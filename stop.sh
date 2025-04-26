#!/bin/bash

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                            APP STOPPER PRO MAX v1.2                         ┃
# ┃                        Created by █▀█ █░░ █▀▀ █▀▄▀█                         ┃
# ┃                               Liar Alok™                                    ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

[ ! "$(whoami)" = "root" ] && {
    echo -e "\033[38;5;196m✘ Root access required! Use 'su' first.\033[0m"
    exit 1
}

# Config
COLORS=(
    "\033[0m"       # Reset
    "\033[38;5;196m" # Red
    "\033[38;5;40m"  # Green
    "\033[38;5;226m" # Yellow
    "\033[38;5;129m" # Purple
)

declare -a EXCLUDED=(
    "com.termux"
    "com.android.inputmethod.*"
    "com.google.android.inputmethod.*"
    "*.launcher*"
    "com.android.theme.*"
    "com.custom.overlay.*"
    "android.auto_generated_rro__*"
)

# Dynamic exclusion builder
build_exclusions() {
    local exclusions=""
    for pkg in "${EXCLUDED[@]}"; do
        exclusions+="$pkg|"
    done
    echo "${exclusions%|}"
}

# Main execution
clear
echo -e "${COLORS[3]}"
echo "  █████╗ ██████╗ ██████╗    ███████╗████████╗ ██████╗ ██████╗ ██████╗ ███████╗██████╗ "
echo " ██╔══██╗██╔══██╗██╔══██╗   ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗"
echo " ███████║██████╔╝██████╔╝   ███████╗   ██║   ██║   ██║██████╔╝██████╔╝█████╗  ██████╔╝"
echo " ██╔══██║██╔═══╝ ██╔═══╝    ╚════██║   ██║   ██║   ██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██╗"
echo " ██║  ██║██║     ██║        ███████║   ██║   ╚██████╔╝██║     ██║     ███████╗██║  ██║"
echo " ╚═╝  ╚═╝╚═╝     ╚═╝        ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝"
echo -e "${COLORS[0]}"

echo -e "${COLORS[4]}╔════════════════════════════════════════════════════════════════════════════╗"
echo -e "║                     REAL-TIME APP STOPPER WITH INSTANT FEEDBACK                     ║"
echo -e "╚════════════════════════════════════════════════════════════════════════════╝${COLORS[0]}"

# Get packages
mapfile -t ALL_PKGS < <(pm list packages -e | cut -d: -f2)
FILTER=$(build_exclusions)
TOTAL=0 STOPPED=0 FAILED=0

echo -e "\n${COLORS[4]}▶ Processing applications...${COLORS[0]}\n"

for pkg in "${ALL_PKGS[@]}"; do
    [[ $pkg =~ $FILTER ]] && continue
    ((TOTAL++))
    
    if am force-stop "$pkg" 2>/dev/null; then
        echo -e "  ${COLORS[2]}✅ Done =${pkg}${COLORS[0]}"
        ((STOPPED++))
    else
        echo -e "  ${COLORS[1]}✘ Error ${pkg}${COLORS[0]}"
        ((FAILED++))
    fi
done

# Results
echo -e "\n${COLORS[4]}╔════════════════════════════════════════════════════════════════════════════╗"
echo -e "║                            OPERATION SUMMARY                                ║"
echo -e "╠════════════════════════════════════════════════════════════════════════════╣"
echo -e "║ ${COLORS[3]}Total Scanned: $TOTAL${COLORS[0]}${COLORS[4]}                                                   ║"
echo -e "║ ${COLORS[2]}Stopped: $STOPPED${COLORS[0]}${COLORS[4]}                                                         ║"
echo -e "║ ${COLORS[1]}Failed: $FAILED${COLORS[0]}${COLORS[4]}                                                          ║"
echo -e "╚════════════════════════════════════════════════════════════════════════════╝${COLORS[0]}"

