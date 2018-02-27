From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Feb 2018 19:00:43 +0100
Subject: [LTP] [RFC PATCH 1/2] lib: TCONF on ESOCKTNOSUPPORT and
	EPROTONOSUPPORT in SAFE_SOCKET()
In-Reply-To: <20180227180044.21867-1-pvorel@suse.cz>
References: <20180227180044.21867-1-pvorel@suse.cz>
Message-ID: <20180227180044.21867-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As this is clearly configuration issue.

Example of use if missing dccp module in netstress.c:
safe_net.c:117: BROK: netstress.c:654: socket(10, 6, 33) failed: ESOCKTNOSUPPORT

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/safe_net.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/safe_net.c b/lib/safe_net.c
index 9ea9d2b42..f8f4f44ca 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -111,11 +111,10 @@ int safe_socket(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	rval = socket(domain, type, protocol);
 
-	if (rval < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn,
-			 "%s:%d: socket(%d, %d, %d) failed", file, lineno,
-			 domain, type, protocol);
-	}
+	if (rval < 0)
+		tst_brkm((errno == EPROTONOSUPPORT || errno == ESOCKTNOSUPPORT ? TCONF : TBROK)
+				 | TERRNO, cleanup_fn, "%s:%d: socket(%d, %d, %d) failed",
+				 file, lineno, domain, type, protocol);
 
 	return rval;
 }
-- 
2.16.2

