From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Sep 2020 12:58:24 +0200
Subject: [LTP] [PATCH 2/2] doc/user-guide: Document block device variables
In-Reply-To: <20200929105824.28793-1-pvorel@suse.cz>
References: <20200929105824.28793-1-pvorel@suse.cz>
Message-ID: <20200929105824.28793-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NOTE: LTP_BIG_DEV{,FS_TYPE} omitted, because used only
in dma_thread_diotest.c which is using legacy API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/user-guide.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 5cb8322cf..8df29e688 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -13,6 +13,9 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'LTPROOT'             | Prefix for installed LTP, the default is '/opt/ltp'.
 | 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
                           'n' or '0': never colorize.
+| 'LTP_DEV'             | Path to the block device to be used
+                          (C: '.needs_device = 1', shell: 'TST_NEEDS_DEVICE=1').
+| 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
 | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
                           slow machines to avoid unexpected timeout).
                           Variable is also used in shell tests, but ceiled to int.
-- 
2.28.0

