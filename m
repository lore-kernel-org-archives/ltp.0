From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 May 2019 13:50:45 +0200
Subject: [LTP] [COMMITTED][PATCH] tst_rod: Fix path names in error messages
Message-ID: <20190515115045.27207-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixing obvious copy paste error.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_rod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_rod.c b/testcases/lib/tst_rod.c
index 8d436fc22..db6d17641 100644
--- a/testcases/lib/tst_rod.c
+++ b/testcases/lib/tst_rod.c
@@ -113,7 +113,7 @@ int main(int argc, char *argv[])
 		if (open(stdout_path, O_CREAT|O_WRONLY|O_TRUNC, 0777) < 0) {
 			fprintf(stderr,
 			        "%s: Failed to open '%s' for writing: %s\n",
-				argv[0], stdin_path, strerror(errno));
+				argv[0], stdout_path, strerror(errno));
 			return 1;
 		}
 	}
@@ -131,7 +131,7 @@ int main(int argc, char *argv[])
 		if (fd < 0) {
 			fprintf(stderr,
 			        "%s: Failed to open '%s' for writing: %s\n",
-				argv[0], stdin_path, strerror(errno));
+				argv[0], stderr_path, strerror(errno));
 			return 1;
 		}
 
-- 
2.21.0

