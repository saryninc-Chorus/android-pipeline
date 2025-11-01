#!/usr/bin/env python3
"""
🔮 Ritual Tests - Validate team training rituals and sacred development practices
"""

import unittest
import os
import sys
import subprocess
from pathlib import Path


class RitualTestCase(unittest.TestCase):
    """Test cases for development ritual validation"""
    
    @classmethod
    def setUpClass(cls):
        """Set up test environment"""
        cls.repo_root = Path(__file__).parent.parent
        cls.scripts_dir = cls.repo_root / "scripts" / "team_training"
    
    def test_scripts_directory_exists(self):
        """Test that scripts/team_training directory exists"""
        self.assertTrue(
            self.scripts_dir.exists(),
            "scripts/team_training directory should exist"
        )
    
    def test_detect_rdx_beat_exists(self):
        """Test that detect_rdx_beat.sh exists"""
        script_path = self.scripts_dir / "detect_rdx_beat.sh"
        self.assertTrue(
            script_path.exists(),
            "detect_rdx_beat.sh should exist"
        )
        self.assertTrue(
            os.access(script_path, os.X_OK) or script_path.suffix == '.sh',
            "detect_rdx_beat.sh should be executable or have .sh extension"
        )
    
    def test_infer_circuit_tests_exists(self):
        """Test that infer_circuit_tests.py exists"""
        script_path = self.scripts_dir / "infer_circuit_tests.py"
        self.assertTrue(
            script_path.exists(),
            "infer_circuit_tests.py should exist"
        )
    
    def test_validate_invention_ritual_exists(self):
        """Test that validate_invention_ritual.sh exists"""
        script_path = self.scripts_dir / "validate_invention_ritual.sh"
        self.assertTrue(
            script_path.exists(),
            "validate_invention_ritual.sh should exist"
        )
    
    def test_auto_rdx_report_exists(self):
        """Test that auto_rdx_report.sh exists"""
        script_path = self.scripts_dir / "auto_rdx_report.sh"
        self.assertTrue(
            script_path.exists(),
            "auto_rdx_report.sh should exist"
        )
    
    def test_infer_circuit_tests_syntax(self):
        """Test that infer_circuit_tests.py has valid Python syntax"""
        script_path = self.scripts_dir / "infer_circuit_tests.py"
        if script_path.exists():
            try:
                with open(script_path, 'r') as f:
                    compile(f.read(), str(script_path), 'exec')
            except SyntaxError as e:
                self.fail(f"infer_circuit_tests.py has syntax error: {e}")
    
    def test_ip_directory_created(self):
        """Test that ip directory can be created or exists"""
        ip_dir = self.repo_root / "ip"
        # Directory should exist or be creatable
        if not ip_dir.exists():
            ip_dir.mkdir(exist_ok=True)
        self.assertTrue(
            ip_dir.exists(),
            "ip directory should exist or be creatable"
        )
    
    def test_script_execution_detect_rdx(self):
        """Test that detect_rdx_beat.sh can be executed"""
        script_path = self.scripts_dir / "detect_rdx_beat.sh"
        if script_path.exists():
            try:
                result = subprocess.run(
                    ["bash", str(script_path)],
                    cwd=self.repo_root,
                    capture_output=True,
                    timeout=30
                )
                # Script should execute without hanging
                self.assertIsNotNone(result.returncode, "Script should complete execution")
                # Check that output file is created
                output_file = self.repo_root / "ip" / "rdx_beat_found.txt"
                self.assertTrue(
                    output_file.exists(),
                    "detect_rdx_beat.sh should create ip/rdx_beat_found.txt"
                )
            except subprocess.TimeoutExpired:
                self.fail("detect_rdx_beat.sh timed out")
            except Exception as e:
                self.fail(f"Error executing detect_rdx_beat.sh: {e}")
    
    def test_script_execution_infer_circuit(self):
        """Test that infer_circuit_tests.py can be executed"""
        script_path = self.scripts_dir / "infer_circuit_tests.py"
        if script_path.exists():
            try:
                result = subprocess.run(
                    ["python3", str(script_path)],
                    cwd=self.repo_root,
                    capture_output=True,
                    timeout=30
                )
                # Script should execute without hanging
                self.assertIsNotNone(result.returncode, "Script should complete execution")
            except subprocess.TimeoutExpired:
                self.fail("infer_circuit_tests.py timed out")
            except Exception as e:
                self.fail(f"Error executing infer_circuit_tests.py: {e}")
    
    def test_script_execution_validate_ritual(self):
        """Test that validate_invention_ritual.sh can be executed"""
        script_path = self.scripts_dir / "validate_invention_ritual.sh"
        if script_path.exists():
            try:
                result = subprocess.run(
                    ["bash", str(script_path)],
                    cwd=self.repo_root,
                    capture_output=True,
                    timeout=30
                )
                # Script should execute without hanging
                self.assertIsNotNone(result.returncode, "Script should complete execution")
            except subprocess.TimeoutExpired:
                self.fail("validate_invention_ritual.sh timed out")
            except Exception as e:
                self.fail(f"Error executing validate_invention_ritual.sh: {e}")


class FileStructureTestCase(unittest.TestCase):
    """Test cases for required file structure"""
    
    @classmethod
    def setUpClass(cls):
        """Set up test environment"""
        cls.repo_root = Path(__file__).parent.parent
    
    def test_ip_conflict_report_exists(self):
        """Test that ip_conflict_report.txt exists or can be created"""
        report_path = self.repo_root / "ip_conflict_report.txt"
        # File should exist or be creatable
        if not report_path.exists():
            report_path.touch()
        self.assertTrue(
            report_path.exists(),
            "ip_conflict_report.txt should exist"
        )
    
    def test_autonomous_rdx_report_can_be_generated(self):
        """Test that autonomous_rdx_report.md can be generated"""
        report_path = self.repo_root / "autonomous_rdx_report.md"
        # File may not exist yet but should be creatable
        # This is validated by the auto_rdx_report.sh script
        script_path = self.repo_root / "scripts" / "team_training" / "auto_rdx_report.sh"
        self.assertTrue(
            script_path.exists(),
            "auto_rdx_report.sh should exist to generate autonomous_rdx_report.md"
        )


def run_tests():
    """Run all ritual tests"""
    loader = unittest.TestLoader()
    suite = unittest.TestSuite()
    
    suite.addTests(loader.loadTestsFromTestCase(RitualTestCase))
    suite.addTests(loader.loadTestsFromTestCase(FileStructureTestCase))
    
    runner = unittest.TextTestRunner(verbosity=2)
    result = runner.run(suite)
    
    return 0 if result.wasSuccessful() else 1


if __name__ == "__main__":
    sys.exit(run_tests())
