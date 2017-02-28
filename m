From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:28 +0100
Subject: [LTP] [COMMITTED] [PATCH 06/23] syscalls/bind02: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Get rid of hacked up option to specify user for the test, the rest of
the LTP testcases use nobody just fine.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/bind/bind02.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/bind/bind02.c b/testcases/kernel/syscalls/bind/bind02.c
index 3dc5652..90b0e9d 100644
--- a/testcases/kernel/syscalls/bind/bind02.c
+++ b/testcases/kernel/syscalls/bind/bind02.c
@@ -69,7 +69,6 @@ struct group *gr;
 
 uid_t uid;
 gid_t gid;
-char nobody_uid[] = "nobody";
 
 int rc;
 
@@ -122,21 +121,12 @@ void try_bind(void)
 
 int main(int argc, char *argv[])
 {
+	char *username = "nobody";
 
-	/* FreeBSD has set limits for user login name -- MAXLOGNAME, but
-	 * Linux doesn't have that limitation apparently. */
-	char *username = NULL;
+	tst_parse_opts(argc, argv, NULL, NULL);
 
 	tst_require_root();
 
-	if (argc != 2) {
-		tst_resm(TINFO, "Defaulting to user nobody");
-		username = strdup(nobody_uid);
-	} else {
-		/* Get test user uid/gid. */
-		username = argv[1];
-	}
-
 	if ((pw = getpwnam(username)) == NULL) {
 		tst_brkm(TBROK, 0, "Username - %s - not found", username);
 	}
-- 
2.10.2

