From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 31 Aug 2017 18:21:37 +0200
Subject: [LTP] [PATCH 1/1] lib6/in6_01.c: Remove IPv6 addresses which do not
	comply RFC 2373
Message-ID: <20170831162137.31948-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <petr.vorel@gmail.com>

glibc 2.26 starts rejecting IPv6 addresses which do not comply RFC 2373.

commit 9a0cc8c1bd7645bf3c988890ffb59639c07a5812
Author: Florian Weimer <fweimer@redhat.com>
Date:   Fri Jun 23 22:51:00 2017 +0200

    inet_pton: Reject IPv6 addresses with many leading zeros [BZ #16637]

    2001:db8:00001::f is not a valid IPv6 address according to RFC 2373.

See also:
https://sourceware.org/bugzilla/show_bug.cgi?id=16637

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/network/lib6/in6_01.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
index f7186b480..3a96ed17d 100644
--- a/testcases/network/lib6/in6_01.c
+++ b/testcases/network/lib6/in6_01.c
@@ -40,8 +40,6 @@ static struct {
 	{ "::ffff:10.0.0.1", 1 },
 	{ "::fffe:10.0.0.1", 0 },
 	{ "::7fff:10.0.0.1", 0 },
-	{ "0:0:0:0:0:0:ffff:0a001", 0 },
-	{ "0:0:1:0:0:0:ffff:0a001", 0 },
 };
 
 #define MAPSIZE (sizeof(maptab)/sizeof(maptab[0]))
-- 
2.14.1

