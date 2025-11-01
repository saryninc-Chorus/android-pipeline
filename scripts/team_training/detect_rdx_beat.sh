#!/bin/bash
set -e

# 🔮 Detect RDX Beat - Scan for rhythmic development excellence patterns

echo "🔍 Detecting RDX Beat patterns..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p ip

# Analyze commit patterns for development rhythm
BEAT_SCORE=0
COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null || echo 0)

if [ "$COMMIT_COUNT" -gt 0 ]; then
    echo "📊 Analyzing $COMMIT_COUNT commits for RDX patterns..."
    
    # Check for regular commit patterns (daily rhythm)
    DAYS_WITH_COMMITS=$(git log --date=short --format="%ad" | sort -u | wc -l)
    
    if [ "$DAYS_WITH_COMMITS" -gt 5 ]; then
        BEAT_SCORE=$((BEAT_SCORE + 10))
        echo "✅ Consistent development rhythm detected (+10)"
    fi
    
    # Check for test file patterns
    TEST_FILES=$(find . -type f \( -name "*test*.py" -o -name "*test*.sh" -o -name "*Test*.java" \) 2>/dev/null | wc -l)
    
    if [ "$TEST_FILES" -gt 0 ]; then
        BEAT_SCORE=$((BEAT_SCORE + 15))
        echo "✅ Test files present (+15)"
    fi
    
    # Check for CI/CD configuration
    if [ -f ".github/workflows/android-build.yml" ] || [ -f "azure-pipelines.yml" ]; then
        BEAT_SCORE=$((BEAT_SCORE + 20))
        echo "✅ CI/CD configuration detected (+20)"
    fi
fi

# Generate beat report
echo "🎵 RDX Beat Score: $BEAT_SCORE/100"

if [ "$BEAT_SCORE" -ge 30 ]; then
    echo "🎉 RDX Beat FOUND! Excellent development rhythm detected."
    echo "RDX Beat Score: $BEAT_SCORE" > ip/rdx_beat_found.txt
    echo "Status: FOUND" >> ip/rdx_beat_found.txt
    echo "Timestamp: $(date -u +"%Y-%m-%d %H:%M:%S UTC")" >> ip/rdx_beat_found.txt
    exit 0
else
    echo "⚠️  RDX Beat below threshold. Continue training."
    echo "RDX Beat Score: $BEAT_SCORE" > ip/rdx_beat_found.txt
    echo "Status: TRAINING_NEEDED" >> ip/rdx_beat_found.txt
    echo "Timestamp: $(date -u +"%Y-%m-%d %H:%M:%S UTC")" >> ip/rdx_beat_found.txt
    exit 0
fi
