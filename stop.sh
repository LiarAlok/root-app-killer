#!/bin/bash

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                            APP STOPPER PRO MAX                              ┃
# ┃                        Created by █▀█ █░░ █▀▀ █▀▄▀█                         ┃
# ┃                               Liar Alok™                                    ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# ┌─────────────────────────────────────────────────────────────────────────────┐
# │  CONFIGURATION                                                             │
# └─────────────────────────────────────────────────────────────────────────────┘
COLOR_RESET="\033[0m"
COLOR_RED="\033[38;5;196m"
COLOR_GREEN="\033[38;5;40m"
COLOR_BLUE="\033[38;5;27m"
COLOR_YELLOW="\033[38;5;226m"
COLOR_PURPLE="\033[38;5;129m"
COLOR_CYAN="\033[38;5;51m"
COLOR_PINK="\033[38;5;205m"

EXCLUDED=(
    com.termux
    com.android.inputmethod.latin
    com.google.android.inputmethod.latin
    
)

# ┌─────────────────────────────────────────────────────────────────────────────┐
# │  ART & VISUALS                                                             │
# └─────────────────────────────────────────────────────────────────────────────┘
function print_logo() {
    echo -e "${COLOR_PURPLE}"
    echo "   █████╗ ██████╗ ██████╗    ███████╗████████╗ ██████╗ ██████╗ ██████╗ ███████╗██████╗ "
    echo "  ██╔══██╗██╔══██╗██╔══██╗   ██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗"
    echo "  ███████║██████╔╝██████╔╝   ███████╗   ██║   ██║   ██║██████╔╝██████╔╝█████╗  ██████╔╝"
    echo "  ██╔══██║██╔═══╝ ██╔═══╝    ╚════██║   ██║   ██║   ██║██╔═══╝ ██╔═══╝ ██╔══╝  ██╔══██╗"
    echo "  ██║  ██║██║     ██║        ███████║   ██║   ╚██████╔╝██║     ██║     ███████╗██║  ██║"
    echo "  ╚═╝  ╚═╝╚═╝     ╚═╝        ╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝"
    echo -e "${COLOR_RESET}"
}

function print_header() {
    clear
    print_logo
    echo -e "${COLOR_CYAN}╔════════════════════════════════════════════════════════════════════════════╗"
    echo -e "║                     REAL-TIME APP STOPPER WITH INSTANT FEEDBACK                     ║"
    echo -e "╚════════════════════════════════════════════════════════════════════════════╝${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}                           Created by Liar Alok™${COLOR_RESET}\n"
}

# ┌─────────────────────────────────────────────────────────────────────────────┐
# │  CORE FUNCTIONS                                                            │
# └─────────────────────────────────────────────────────────────────────────────┘
function show_status() { echo -e "  ${COLOR_BLUE}⌛ ${1}${COLOR_RESET}"; }
function show_success() { echo -e "  ${COLOR_GREEN}✔ ${1}${COLOR_RESET}"; }
function show_error() { echo -e "  ${COLOR_RED}✘ ${1}${COLOR_RESET}"; }

# ┌─────────────────────────────────────────────────────────────────────────────┐
# │  MAIN EXECUTION                                                           │
# └─────────────────────────────────────────────────────────────────────────────┘
print_header

# Check root
if ! su -c true; then
    show_error "Root access required!"
    exit 1
fi

# Prepare packages
EXCLUDED_PATTERN=$(IFS="|"; echo "${EXCLUDED[*]}")
PACKAGES=$(su -c "pm list packages -e" | cut -d':' -f2 | grep -vE "^(${EXCLUDED_PATTERN})$")
TOTAL=$(echo "$PACKAGES" | wc -l)
COUNT=0 STOPPED=0 FAILED=0

echo -e "${COLOR_PURPLE}╔════════════════════════════════════════════════════════════════════════════╗"
echo -e "║                        LIVE APPLICATION STOPPING FEEDBACK                        ║"
echo -e "╚════════════════════════════════════════════════════════════════════════════╝${COLOR_RESET}"

# Process apps with instant feedback
while read -r package; do
    ((COUNT++))
    echo -ne "${COLOR_YELLOW}Processing: ${COUNT}/${TOTAL} apps\r${COLOR_RESET}"
    
    if su -c "am force-stop $package" >/dev/null 2>&1; then
        echo -e "  ${COLOR_GREEN}✔ Stopped: ${package}${COLOR_RESET}"
        ((STOPPED++))
    else
        echo -e "  ${COLOR_RED}✘ Failed: ${package}${COLOR_RESET}"
        ((FAILED++))
    fi
done <<< "$PACKAGES"


# ... (keep all previous code until the final report section)

# ... (keep all previous code until the final report section)

# Final report with enhanced decorations
echo -e "\n${COLOR_PURPLE}╔════════════════════════════════════════════════════════════════════════════╗"
echo -e "║                                                                                ║"
echo -e "║            ${COLOR_CYAN}▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜${COLOR_PURPLE}            ${COLOR_CYAN}▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜${COLOR_PURPLE}           ║"
echo -e "║            ${COLOR_CYAN}▌  FINAL REPORT  ▐${COLOR_PURPLE}            ${COLOR_CYAN}▌   STATS      ▐${COLOR_PURPLE}           ║"
echo -e "║            ${COLOR_CYAN}▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟${COLOR_PURPLE}            ${COLOR_CYAN}▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟${COLOR_PURPLE}           ║"
echo -e "║                                                                                ║"
echo -e "║  ${COLOR_YELLOW}█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█${COLOR_PURPLE}                  ║"
echo -e "║  ${COLOR_YELLOW}█               APPLICATION STATS               █${COLOR_PURPLE}                  ║"
echo -e "║  ${COLOR_YELLOW}█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█${COLOR_PURPLE}                  ║"
echo -e "║  ${COLOR_GREEN}⟫ Success Rate:   $(( STOPPED * 100 / TOTAL ))% ${COLOR_PURPLE}                                 ║"
echo -e "║  ${COLOR_GREEN}⟫ Stopped Apps:   ${STOPPED} ${COLOR_PURPLE}                                                   ║"
echo -e "║  ${COLOR_RED}⟫ Failed Apps:    ${FAILED} ${COLOR_PURPLE}                                                   ║"
echo -e "║  ${COLOR_YELLOW}⟫ Total Processed: ${TOTAL} ${COLOR_PURPLE}                                                   ║"
echo -e "║                                                                                ║"
echo -e "║  ${COLOR_CYAN}▛▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▜${COLOR_PURPLE}  ║"
echo -e "║  ${COLOR_CYAN}▌          SYSTEM STATUS: CRITICAL APPS PRESERVED          ▐${COLOR_PURPLE}  ║"
echo -e "║  ${COLOR_CYAN}▙▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▟${COLOR_PURPLE}  ║"
echo -e "║                                                                                ║"
echo -e "╚════════════════════════════════════════════════════════════════════════════╝"

echo -e "\n${COLOR_PINK}"
echo "  ████████╗██╗  ██╗ █████╗ ███╗   ██╗██╗  ██╗███████╗██╗   ██╗ ██████╗ "
echo "  ╚══██╔══╝██║  ██║██╔══██╗████╗  ██║██║ ██╔╝██╔════╝╚██╗ ██╔╝██╔════╝ "
echo "     ██║   ███████║███████║██╔██╗ ██║█████╔╝ █████╗   ╚████╔╝ ██║  ███╗"
echo "     ██║   ██╔══██║██╔══██║██║╚██╗██║██╔═██╗ ██╔══╝    ╚██╔╝  ██║   ██║"
echo "     ██║   ██║  ██║██║  ██║██║ ╚████║██║  ██╗███████╗   ██║   ╚██████╔╝"
echo "     ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝ "
echo -e "${COLOR_RESET}"

echo -e "${COLOR_CYAN}╔════════════════════════════════════════════════════════════════════════════╗"
echo -e "║ ${COLOR_YELLOW}🚀 Powered by Liar Alok™ • 🛡️  System Protection Suite • 🔥 Instant Execution ${COLOR_CYAN}║"
echo -e "╚════════════════════════════════════════════════════════════════════════════╝${COLOR_RESET}"


