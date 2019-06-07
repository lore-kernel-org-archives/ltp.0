From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Jun 2019 09:17:51 +0200
Subject: [LTP] [PATCH 1/1] lib: Document the endianity in
	tst_get_unused_port()
Message-ID: <20190607071751.9225-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To prevent confusing [1]:

    if you want to print the port you actually have to use
    ntohs() function to convert it to the host endianity. And if you are
    passing that value in the sockaddr_in structure you must not use the
    htons() since the value is already in the correct byte order.

[1] http://lists.linux.it/pipermail/ltp/2019-June/012289.html

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/safe_net.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/safe_net.c b/lib/safe_net.c
index 970a2aba3..abebd1899 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -373,6 +373,9 @@ int safe_gethostname(const char *file, const int lineno,
 	return rval;
 }
 
+/*
+ * @return port in network byte order.
+ */
 unsigned short tst_get_unused_port(const char *file, const int lineno,
 	      void (cleanup_fn)(void), unsigned short family, int type)
 {
-- 
2.21.0

