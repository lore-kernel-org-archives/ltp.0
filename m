From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jun 2021 18:33:07 +0200
Subject: [LTP] [RFC PATCH 3/3] doc: Update LTPROOT and PATH environment
 variables
In-Reply-To: <20210615163307.10755-1-pvorel@suse.cz>
References: <20210615163307.10755-1-pvorel@suse.cz>
Message-ID: <20210615163307.10755-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to address changes in two previous commits.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 README.md          | 2 +-
 doc/user-guide.txt | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index 703395c6b..b0ad47dfa 100644
--- a/README.md
+++ b/README.md
@@ -162,7 +162,7 @@ $ testcases/bin/ioctl01 -h
 Many require certain environment variables to be set
 
 ```
-$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
+$ LTPROOT=/opt/ltp testcases/bin/wc01.sh
 ```
 
 Most commonly, the path variable needs to be set and also `LTPROOT`, but there
diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 8df29e688..ab2d773a7 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -11,6 +11,7 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
                           the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
 | 'LTPROOT'             | Prefix for installed LTP, the default is '/opt/ltp'.
+                          Used for setting 'PATH' and other environment variables.
 | 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
                           'n' or '0': never colorize.
 | 'LTP_DEV'             | Path to the block device to be used
@@ -19,8 +20,10 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
                           slow machines to avoid unexpected timeout).
                           Variable is also used in shell tests, but ceiled to int.
-| 'PATH'                | It's required to addjust path:
-                          `PATH="$PATH:$LTPROOT/testcases/bin"`
+| 'PATH'                | Testcases are installed into 'LTPROOT/testcases/bin',
+                          'PATH' is set by library API. You need to add it into
+                          'PATH' only if you use custom runner (not runltp neither
+                          [runltp-ng](https://github.com/metan-ucw/runltp-ng).
 | 'TMPDIR'              | Base directory for template directory (C: '.needs_tmpdir = 1'
                           and others, which imply it, shell: 'TST_NEEDS_TMPDIR=1').
 | 'TST_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
-- 
2.32.0

