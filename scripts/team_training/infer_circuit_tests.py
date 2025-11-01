#!/usr/bin/env python3
"""
🔮 Infer Circuit Tests - Analyze code patterns to infer test coverage circuits
"""

import os
import sys
import json
from pathlib import Path
from datetime import datetime, timezone


def find_source_files(base_path="."):
    """Find all source files in the repository"""
    extensions = [".java", ".cpp", ".py", ".sh", ".yml"]
    source_files = []
    
    for root, dirs, files in os.walk(base_path):
        # Skip common directories
        dirs[:] = [d for d in dirs if d not in ['.git', 'node_modules', '.vscode', '__pycache__']]
        
        for file in files:
            if any(file.endswith(ext) for ext in extensions):
                source_files.append(os.path.join(root, file))
    
    return source_files


def find_test_files(base_path="."):
    """Find all test files in the repository"""
    test_files = []
    
    for root, dirs, files in os.walk(base_path):
        dirs[:] = [d for d in dirs if d not in ['.git', 'node_modules', '.vscode', '__pycache__']]
        
        for file in files:
            if 'test' in file.lower() and (file.endswith('.py') or file.endswith('.java') or file.endswith('.sh')):
                test_files.append(os.path.join(root, file))
    
    return test_files


def infer_test_circuits():
    """Infer test coverage circuits from the repository"""
    print("🔍 Inferring test circuits...")
    
    source_files = find_source_files()
    test_files = find_test_files()
    
    print(f"📊 Found {len(source_files)} source files")
    print(f"🧪 Found {len(test_files)} test files")
    
    # Calculate coverage ratio
    coverage_ratio = len(test_files) / len(source_files) if source_files else 0
    
    circuits = {
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "source_files_count": len(source_files),
        "test_files_count": len(test_files),
        "coverage_ratio": round(coverage_ratio, 3),
        "circuits_inferred": [],
        "recommendations": []
    }
    
    # Infer circuits based on file patterns
    if any('android' in f.lower() for f in source_files):
        circuits["circuits_inferred"].append({
            "name": "Android UI Circuit",
            "status": "detected",
            "files": [f for f in source_files if 'android' in f.lower()][:5]
        })
    
    if any('.yml' in f or 'pipeline' in f.lower() for f in source_files):
        circuits["circuits_inferred"].append({
            "name": "CI/CD Pipeline Circuit",
            "status": "detected",
            "files": [f for f in source_files if '.yml' in f or 'pipeline' in f.lower()][:5]
        })
    
    if any('training' in f.lower() or 'export' in f.lower() for f in source_files):
        circuits["circuits_inferred"].append({
            "name": "Training Data Circuit",
            "status": "detected",
            "files": [f for f in source_files if 'training' in f.lower() or 'export' in f.lower()][:5]
        })
    
    # Generate recommendations
    if coverage_ratio < 0.1:
        circuits["recommendations"].append("⚠️  Low test coverage detected. Consider adding more test files.")
    elif coverage_ratio >= 0.1:
        circuits["recommendations"].append("✅ Reasonable test coverage maintained.")
    
    if not test_files:
        circuits["recommendations"].append("🔴 No test files found. Implement test circuits immediately.")
    
    # Print summary
    print(f"\n🎯 Coverage Ratio: {coverage_ratio:.1%}")
    print(f"🔌 Circuits Inferred: {len(circuits['circuits_inferred'])}")
    
    for circuit in circuits["circuits_inferred"]:
        print(f"  ✓ {circuit['name']}: {circuit['status']}")
    
    print("\n📋 Recommendations:")
    for rec in circuits["recommendations"]:
        print(f"  {rec}")
    
    # Save results
    output_file = "circuit_inference_results.json"
    with open(output_file, 'w') as f:
        json.dump(circuits, f, indent=2)
    
    print(f"\n💾 Results saved to {output_file}")
    
    return circuits


if __name__ == "__main__":
    try:
        circuits = infer_test_circuits()
        sys.exit(0)
    except Exception as e:
        print(f"❌ Error: {e}", file=sys.stderr)
        sys.exit(1)
