#!/bin/bash
set -e

# 🔮 Validate Invention Ritual - Ensure sacred development practices are followed

echo "🔍 Validating Invention Ritual..."

VALIDATION_SCORE=0
ISSUES_FOUND=()

# Check git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

echo "📋 Running ritual validation checks..."

# 1. Check for protection configuration
if [ -f "protection.json" ]; then
    echo "✅ Protection configuration present"
    VALIDATION_SCORE=$((VALIDATION_SCORE + 10))
else
    ISSUES_FOUND+=("⚠️  protection.json not found")
fi

# 2. Check for CI/CD pipeline
CI_FILES=0
if [ -f ".github/workflows/android-build.yml" ]; then
    CI_FILES=$((CI_FILES + 1))
fi
if [ -f "azure-pipelines.yml" ]; then
    CI_FILES=$((CI_FILES + 1))
fi
if [ -f "android-pipeline.yml" ]; then
    CI_FILES=$((CI_FILES + 1))
fi

if [ "$CI_FILES" -gt 0 ]; then
    echo "✅ CI/CD pipelines configured ($CI_FILES found)"
    VALIDATION_SCORE=$((VALIDATION_SCORE + 15))
else
    ISSUES_FOUND+=("⚠️  No CI/CD pipeline configuration found")
fi

# 3. Check for .gitignore
if [ -f ".gitignore" ]; then
    echo "✅ .gitignore present"
    VALIDATION_SCORE=$((VALIDATION_SCORE + 5))
    
    # Check for common patterns
    if grep -q "*.log" .gitignore && grep -q "node_modules" .gitignore; then
        echo "✅ Standard ignore patterns configured"
        VALIDATION_SCORE=$((VALIDATION_SCORE + 5))
    fi
else
    ISSUES_FOUND+=("⚠️  .gitignore not found")
fi

# 4. Check for training data export script
if [ -f "export_training_data.sh" ]; then
    echo "✅ Training data export ritual present"
    VALIDATION_SCORE=$((VALIDATION_SCORE + 10))
else
    ISSUES_FOUND+=("⚠️  export_training_data.sh not found")
fi

# 5. Check for team training scripts
TRAINING_SCRIPTS=0
if [ -d "scripts/team_training" ]; then
    TRAINING_SCRIPTS=$(find scripts/team_training -type f \( -name "*.sh" -o -name "*.py" \) 2>/dev/null | wc -l)
    if [ "$TRAINING_SCRIPTS" -gt 0 ]; then
        echo "✅ Team training scripts present ($TRAINING_SCRIPTS found)"
        VALIDATION_SCORE=$((VALIDATION_SCORE + 15))
    fi
else
    ISSUES_FOUND+=("⚠️  scripts/team_training directory not found")
fi

# 6. Check for test files
TEST_COUNT=$(find . -type f \( -name "*test*.py" -o -name "*test*.sh" -o -name "*Test*.java" \) 2>/dev/null | grep -v ".git" | wc -l)
if [ "$TEST_COUNT" -gt 0 ]; then
    echo "✅ Test files present ($TEST_COUNT found)"
    VALIDATION_SCORE=$((VALIDATION_SCORE + 15))
else
    ISSUES_FOUND+=("⚠️  No test files found")
fi

# 7. Check commit history quality
RECENT_COMMITS=$(git log --oneline -10 2>/dev/null | wc -l)
if [ "$RECENT_COMMITS" -gt 0 ]; then
    echo "✅ Active commit history ($RECENT_COMMITS recent commits)"
    VALIDATION_SCORE=$((VALIDATION_SCORE + 10))
fi

# 8. Check for documentation
if [ -f "README.md" ]; then
    echo "✅ README.md present"
    VALIDATION_SCORE=$((VALIDATION_SCORE + 5))
fi

# Calculate percentage
MAX_SCORE=90
PERCENTAGE=$((VALIDATION_SCORE * 100 / MAX_SCORE))

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Validation Score: $VALIDATION_SCORE/$MAX_SCORE ($PERCENTAGE%)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ ${#ISSUES_FOUND[@]} -gt 0 ]; then
    echo ""
    echo "📌 Issues Found:"
    for issue in "${ISSUES_FOUND[@]}"; do
        echo "  $issue"
    done
fi

echo ""
if [ "$PERCENTAGE" -ge 70 ]; then
    echo "✨ Invention Ritual VALIDATED! Sacred practices are being followed."
    exit 0
elif [ "$PERCENTAGE" -ge 50 ]; then
    echo "⚡ Invention Ritual PARTIALLY VALIDATED. Some improvements needed."
    exit 0
else
    echo "🔥 Invention Ritual NEEDS ATTENTION. Please address the issues above."
    exit 1
fi
