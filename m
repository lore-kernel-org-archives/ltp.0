From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Mar 2018 16:01:10 +0100
Subject: [LTP] [PATCH v2 2/3] lib: TCONF on "not supported" errnos in
	SAFE_SOCKET()
In-Reply-To: <20180313150111.16501-1-pvorel@suse.cz>
References: <20180313150111.16501-1-pvorel@suse.cz>
Message-ID: <20180313150111.16501-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

*NOSUPPORT errnos likely mean there is configuration issue rather than
test failure.

e.g. missing dccp module in netstress.c which was so far set as TBROK:
safe_net.c:117: BROK: netstress.c:654: socket(10, 6, 33) failed: ESOCKTNOSUPPORT

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 lib/safe_net.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/lib/safe_net.c b/lib/safe_net.c
index 9ea9d2b42..9ed52dcd1 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -107,12 +107,24 @@ int tst_getsockport(const char *file, const int lineno, int sockfd)
 int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 		int domain, int type, int protocol)
 {
-	int rval;
+	int rval, ttype;
 
 	rval = socket(domain, type, protocol);
 
 	if (rval < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
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
+		tst_brkm(ttype | TERRNO, cleanup_fn,
 			 "%s:%d: socket(%d, %d, %d) failed", file, lineno,
 			 domain, type, protocol);
 	}
-- 
2.16.2

