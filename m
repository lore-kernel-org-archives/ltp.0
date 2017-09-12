From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Sep 2017 09:20:29 +0200
Subject: [LTP] [PATCH v3 1/2] lib6/in6_01: Fix IPv6 addresses which do not
	comply RFC 2373
Message-ID: <20170912072030.15667-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hextet 0a001 contains wrong leading zero which makes it invalid.
glibc 2.26 starts rejecting IPv6 addresses which do not comply RFC 2373.
Change was made in this commit:

commit 9a0cc8c1bd7645bf3c988890ffb59639c07a5812
Author: Florian Weimer <fweimer@redhat.com>
Date:   Fri Jun 23 22:51:00 2017 +0200

    inet_pton: Reject IPv6 addresses with many leading zeros [BZ #16637]

    2001:db8:00001::f is not a valid IPv6 address according to RFC 2373.

See also relevant glibc bug:
https://sourceware.org/bugzilla/show_bug.cgi?id=16637

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/lib6/in6_01.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
index f7186b480..70e771357 100644
--- a/testcases/network/lib6/in6_01.c
+++ b/testcases/network/lib6/in6_01.c
@@ -40,8 +40,8 @@ static struct {
 	{ "::ffff:10.0.0.1", 1 },
 	{ "::fffe:10.0.0.1", 0 },
 	{ "::7fff:10.0.0.1", 0 },
-	{ "0:0:0:0:0:0:ffff:0a001", 0 },
-	{ "0:0:1:0:0:0:ffff:0a001", 0 },
+	{ "0:0:0:0:0:0:ffff:a001", 0 },
+	{ "0:0:1:0:0:0:ffff:a001", 0 },
 };
 
 #define MAPSIZE (sizeof(maptab)/sizeof(maptab[0]))
-- 
2.14.1

