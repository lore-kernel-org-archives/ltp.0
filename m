From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:47 +0100
Subject: [LTP] [PATCH 10/19] Unify error handling in lib/tst_net.c
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-11-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/tst_net.c b/lib/tst_net.c
index 8a589b0ad..de343bb39 100644
--- a/lib/tst_net.c
+++ b/lib/tst_net.c
@@ -212,10 +212,11 @@ void safe_getaddrinfo(const char *file, const int lineno, const char *src_addr,
 {
 	int err = getaddrinfo(src_addr, port, hints, addr_info);
 
-	if (err)
-		tst_brk(TBROK, "%s:%d: getaddrinfo failed, %s", file, lineno,
-				gai_strerror(err));
+	if (err) {
+		tst_brk_(file, lineno, TBROK, "getaddrinfo failed, %s",
+			gai_strerror(err));
+	}
 
 	if (!*addr_info)
-		tst_brk(TBROK, "%s:%d: failed to get the address", file, lineno);
+		tst_brk_(file, lineno, TBROK, "failed to get the address");
 }
-- 
2.28.0

