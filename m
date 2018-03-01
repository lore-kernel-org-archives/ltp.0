From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  1 Mar 2018 11:59:42 +0100
Subject: [LTP] [RFC PATCH v2 1/2] lib: TCONF on "not supported" errnos in
	SAFE_SOCKET()
Message-ID: <20180301105943.5487-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

*NOSUPPORT errnos likely mean there is configuration issue rather than
test failure.

e.g. missing dccp module in netstress.c which was sofar set as TBROK:
safe_net.c:117: BROK: netstress.c:654: socket(10, 6, 33) failed: ESOCKTNOSUPPORT

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add more errnos.

Maybe it'd make sense to pick suitable errnos and test it against each
safe_*() in lib/safe_net.c or even against all safe_*().
---
 lib/safe_net.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/lib/safe_net.c b/lib/safe_net.c
index 9ea9d2b42..1f1cd0358 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -107,14 +107,25 @@ int tst_getsockport(const char *file, const int lineno, int sockfd)
 int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 		int domain, int type, int protocol)
 {
-	int rval;
+	int rval, ttype;
 
 	rval = socket(domain, type, protocol);
 
 	if (rval < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: socket(%d, %d, %d) failed", file, lineno,
-			 domain, type, protocol);
+		switch (errno) {
+		case EPROTONOSUPPORT:
+		case ESOCKTNOSUPPORT:
+		case EOPNOTSUPP:
+		case EPFNOSUPPORT:
+		case EAFNOSUPPORT:
+			ttype = TCONF;
+			break;
+		default:
+			ttype = TBROK;
+		}
+
+		tst_brkm(ttype | TERRNO, cleanup_fn, "%s:%d: socket(%d, %d, %d) failed",
+				 file, lineno, domain, type, protocol);
 	}
 
 	return rval;
-- 
2.16.2

