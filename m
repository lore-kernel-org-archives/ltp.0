From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri,  6 Aug 2021 12:19:38 +0100
Subject: [LTP] [PATCH] setsockopt08: Handle ENOPROTOOPT even with compatible
 config
Message-ID: <20210806111938.12007-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

One or more necessary modules can be missing even if they are present
in the config.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .../kernel/syscalls/setsockopt/setsockopt08.c | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 33892f9b1..d3cd5b5b2 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -110,6 +110,7 @@ void run(void)
 	struct xt_entry_target *xt_entry_tgt =
 		((struct xt_entry_target *) (&ipt_entry->elems[0] + match_size));
 	int fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+	int result;
 
 	xt_entry_match->u.user.match_size = (u_int16_t)match_size;
 	strcpy(xt_entry_match->u.user.name, "state");
@@ -126,10 +127,25 @@ void run(void)
 	ipt_replace->num_counters = 1;
 	ipt_replace->size = ipt_entry->next_offset;
 
-	TST_EXP_FAIL(setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1),
-		     EINVAL,
-		     "setsockopt(%d, IPPROTO_IP, IPT_SO_SET_REPLACE, %p, 1)",
-		     fd, buffer);
+	errno = 0;
+	if (setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1) == -1) {
+		switch (errno) {
+		case EINVAL:
+			result = TPASS;
+			break;
+		case ENOPROTOOPT:
+			result = TCONF;
+			break;
+		default:
+			result = TFAIL;
+		}
+	} else {
+		result = TFAIL;
+	}
+
+	tst_res(result | TERRNO,
+		"setsockopt(%d, IPPROTO_IP, IPT_SO_SET_REPLACE, %p, 1)",
+		fd, buffer);
 
 	SAFE_CLOSE(fd);
 }
-- 
2.31.1

