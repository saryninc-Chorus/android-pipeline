#!/bin/bash
set -e

# 🔮 Auto RDX Report - Generate automated Rhythmic Development Excellence reports

echo "📊 Generating Autonomous RDX Report..."

# Initialize report
REPORT_FILE="autonomous_rdx_report.md"
TIMESTAMP=$(date -u +"%Y-%m-%d %H:%M:%S UTC")

# Start report
cat > "$REPORT_FILE" << 'EOF'
# 🎯 Autonomous RDX Report

> **Rhythmic Development Excellence** - Automated Analysis

---

EOF

echo "Timestamp: $TIMESTAMP" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Run RDX Beat Detection
echo "## 🎵 RDX Beat Analysis" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

if [ -f "scripts/team_training/detect_rdx_beat.sh" ]; then
    echo "Running RDX Beat detection..."
    bash scripts/team_training/detect_rdx_beat.sh > /tmp/rdx_beat_output.txt 2>&1 || true
    
    if [ -f "ip/rdx_beat_found.txt" ]; then
        echo "### Beat Detection Results" >> "$REPORT_FILE"
        echo "\`\`\`" >> "$REPORT_FILE"
        cat ip/rdx_beat_found.txt >> "$REPORT_FILE"
        echo "\`\`\`" >> "$REPORT_FILE"
    fi
else
    echo "⚠️  RDX Beat detection script not found" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# Run Circuit Tests Inference
echo "## 🔌 Test Circuit Analysis" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

if [ -f "scripts/team_training/infer_circuit_tests.py" ]; then
    echo "Analyzing test circuits..."
    python3 scripts/team_training/infer_circuit_tests.py > /tmp/circuit_output.txt 2>&1 || true
    
    if [ -f "circuit_inference_results.json" ]; then
        echo "### Circuit Inference Results" >> "$REPORT_FILE"
        
        # Extract key metrics
        SOURCE_COUNT=$(grep -o '"source_files_count": [0-9]*' circuit_inference_results.json | grep -o '[0-9]*' || echo "0")
        TEST_COUNT=$(grep -o '"test_files_count": [0-9]*' circuit_inference_results.json | grep -o '[0-9]*' || echo "0")
        COVERAGE=$(grep -o '"coverage_ratio": [0-9.]*' circuit_inference_results.json | grep -o '[0-9.]*' || echo "0")
        
        echo "- **Source Files:** $SOURCE_COUNT" >> "$REPORT_FILE"
        echo "- **Test Files:** $TEST_COUNT" >> "$REPORT_FILE"
        echo "- **Coverage Ratio:** $COVERAGE" >> "$REPORT_FILE"
        echo "" >> "$REPORT_FILE"
    fi
else
    echo "⚠️  Circuit inference script not found" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# Run Invention Ritual Validation
echo "## ✨ Invention Ritual Validation" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

if [ -f "scripts/team_training/validate_invention_ritual.sh" ]; then
    echo "Validating invention ritual..."
    bash scripts/team_training/validate_invention_ritual.sh > /tmp/ritual_output.txt 2>&1 || true
    
    # Extract validation score
    VALIDATION_RESULT=$(grep "Validation Score:" /tmp/ritual_output.txt || echo "Validation Score: N/A")
    
    echo "### Validation Results" >> "$REPORT_FILE"
    echo "\`\`\`" >> "$REPORT_FILE"
    echo "$VALIDATION_RESULT" >> "$REPORT_FILE"
    echo "\`\`\`" >> "$REPORT_FILE"
    
    # Add status
    if grep -q "VALIDATED!" /tmp/ritual_output.txt; then
        echo "" >> "$REPORT_FILE"
        echo "✅ **Status:** Ritual practices validated successfully" >> "$REPORT_FILE"
    elif grep -q "PARTIALLY VALIDATED" /tmp/ritual_output.txt; then
        echo "" >> "$REPORT_FILE"
        echo "⚡ **Status:** Partial validation - improvements recommended" >> "$REPORT_FILE"
    else
        echo "" >> "$REPORT_FILE"
        echo "🔥 **Status:** Validation failed - action required" >> "$REPORT_FILE"
    fi
else
    echo "⚠️  Validation ritual script not found" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# Repository Statistics
echo "## 📈 Repository Statistics" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

if [ -d ".git" ]; then
    TOTAL_COMMITS=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    CONTRIBUTORS=$(git log --format='%an' | sort -u | wc -l || echo "0")
    BRANCHES=$(git branch -a | wc -l || echo "0")
    
    echo "- **Total Commits:** $TOTAL_COMMITS" >> "$REPORT_FILE"
    echo "- **Contributors:** $CONTRIBUTORS" >> "$REPORT_FILE"
    echo "- **Branches:** $BRANCHES" >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# Recommendations
echo "## 💡 Recommendations" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check if IP conflict report exists
if [ -f "ip_conflict_report.txt" ]; then
    CONFLICTS=$(wc -l < ip_conflict_report.txt)
    if [ "$CONFLICTS" -gt 1 ]; then
        echo "- ⚠️  Review IP conflict report ($CONFLICTS entries)" >> "$REPORT_FILE"
    fi
fi

# Check test coverage
if [ -f "circuit_inference_results.json" ]; then
    COVERAGE=$(grep -o '"coverage_ratio": [0-9.]*' circuit_inference_results.json | grep -o '[0-9.]*' | head -1 || echo "0")
    # Use awk for better portability instead of bc
    COVERAGE_NUM=$(awk "BEGIN {printf \"%.0f\", $COVERAGE * 100}" 2>/dev/null || echo "0")
    
    if [ "$COVERAGE_NUM" -lt 10 ]; then
        echo "- 🔴 Increase test coverage (current: ${COVERAGE_NUM}%)" >> "$REPORT_FILE"
    fi
fi

echo "- ✅ Continue maintaining development rhythm" >> "$REPORT_FILE"
echo "- 📚 Keep documentation updated" >> "$REPORT_FILE"
echo "- 🔒 Ensure security practices are followed" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"
echo "---" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "*Generated automatically by auto_rdx_report.sh*" >> "$REPORT_FILE"

echo ""
echo "✅ Report generated successfully: $REPORT_FILE"
echo ""

# Display report location
echo "📄 Report saved to: $(pwd)/$REPORT_FILE"

exit 0
