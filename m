From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Date: Mon, 25 Dec 2017 15:03:06 +0900
Subject: [LTP] [PATCH 2/2] execltp: add rstrip to runtest_file
In-Reply-To: <1514181786-6677-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
References: <1514181786-6677-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
Message-ID: <1514181786-6677-3-git-send-email-daniel.sangorrin@toshiba.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Without an rstrip I was getting errors saying that the
runtest file syscalls didn't exist.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 execltp.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/execltp.in b/execltp.in
index 6d13ad1..2dcdf10 100755
--- a/execltp.in
+++ b/execltp.in
@@ -361,7 +361,7 @@ def main():
 
             failed_subset = {}
 
-            runtest_file = os.path.join(opts.ltp_dir, 'runtest', testsuite)
+            runtest_file = os.path.join(opts.ltp_dir, 'runtest', testsuite).rstrip()
 
             if not opts.postprocess_only:
 
-- 
2.1.4


