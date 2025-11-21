# Android Pipeline

An Android development pipeline repository with CI/CD automation, team training rituals, and intellectual property tracking.

## Overview

This repository contains:
- **Azure DevOps CI/CD pipelines** for Android builds
- **Team training scripts** for development best practices
- **IP and patent tracking** system
- **Android native projections** with CMake build support

## Repository Structure

```
android-pipeline/
├── app/                    # Android application source code
│   └── src/               # Source files
├── scripts/               
│   └── team_training/     # Development ritual and training scripts
├── ip/                    # IP tracking artifacts
├── patent/                # Patent documentation
├── tests/                 # Test files
├── azure-pipelines.yml    # Azure DevOps pipeline configuration
├── android-pipeline.yml   # Android build pipeline
├── CMakeList.txt          # CMake build configuration
└── protection.json        # Branch protection settings
```

## CI/CD Pipelines

### Azure DevOps Pipeline
- **Trigger**: Commits to `main` branch
- **Pool**: Custom agent pool `AseEj`
- **Java Version**: 17
- **Android SDK**: Platform 30, Build Tools 30.0.3
- **Build Command**: `./gradlew assembleRelease`

See `azure-pipelines.yml` and `android-pipeline.yml` for full configuration.

## Team Training Scripts

Located in `scripts/team_training/`, these scripts help maintain development quality:

- **`detect_rdx_beat.sh`**: Detects rhythmic development excellence patterns
- **`infer_circuit_tests.py`**: Analyzes test coverage and circuit inference
- **`validate_invention_ritual.sh`**: Validates development practices
- **`auto_rdx_report.sh`**: Generates autonomous development reports

### Running Training Scripts

```bash
# Validate development ritual
bash scripts/team_training/validate_invention_ritual.sh

# Generate RDX report
bash scripts/team_training/auto_rdx_report.sh

# Detect RDX beat
bash scripts/team_training/detect_rdx_beat.sh

# Infer circuit tests
python3 scripts/team_training/infer_circuit_tests.py
```

## Android Native Projections

The repository includes CMake configuration for building Android native libraries with external display features:

```cmake
cmake_minimum_required(VERSION 3.22.1)
option(ENABLE_EXTERNAL_DISPLAY "Enable external display features" ON)
```

## IP and Patent Tracking

### Patent Documentation
The `patent/` directory contains documentation for:
- Android Display Adapter
- Auto Screen Fullscreen
- Dual Device Jetpack Extension

### IP Conflict Monitoring
- **Report**: `ip_conflict_report.txt`
- **Protection Policy**: `protection.json`
- Regular scanning recommended to ensure compliance

## Training Data Export

Use the export script to prepare code for AI training while protecting secrets:

```bash
bash export_training_data.sh
```

This script:
1. Scans for secrets using gitleaks
2. Creates sanitized training data
3. Outputs to `training_data/combined_data.jsonl`

## Testing

Run the ritual tests:

```bash
python3 tests/ritual_tests.py
```

## Branch Protection

Branch protection rules are defined in `protection.json`:
- Required status checks: SonarCloud, Android_AI, Projection_Build
- Required pull request reviews (1 approval minimum)
- Code owner reviews required
- Linear history enforced
- Force pushes and deletions blocked

## Development Workflow

1. Create a feature branch from `main`
2. Make your changes
3. Run validation scripts from `scripts/team_training/`
4. Run tests: `python3 tests/ritual_tests.py`
5. Create pull request
6. Wait for CI/CD checks and required approvals
7. Merge to `main` after approval

## Reports

The repository automatically generates:
- **Autonomous RDX Report**: `autonomous_rdx_report.md`
- **IP Conflict Report**: `ip_conflict_report.txt`
- **RDX Beat Detection**: `ip/rdx_beat_found.txt`

## Requirements

- Java 17
- Android SDK (Platform 30, Build Tools 30.0.3)
- Python 3
- CMake 3.22.1+
- Gitleaks (for secure training data export)
- Bash shell

## License

[To be determined - please add license information]

## Contributing

Please follow the development rituals and validation scripts before submitting pull requests. Ensure all tests pass and the validation score is above 70%.

---

*This repository follows the Rhythmic Development Excellence (RDX) methodology for maintaining code quality and team alignment.*
