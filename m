Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1XRu6U-00052G-6F
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 02:27:22 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XRu6T-00027j-8i
	for ltp-list@lists.sourceforge.net; Thu, 11 Sep 2014 02:27:22 +0000
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Wed, 10 Sep 2014 22:27:15 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
	[9.57.198.23])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 146A9C90046
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Sep 2014 22:27:05 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	s8B2RDCV60489792
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Sep 2014 02:27:13 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	s8B2RD1i009397
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Sep 2014 22:27:13 -0400
Received: from localhost.localdomain ([9.115.120.242])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	s8B2RCeu009337
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Sep 2014 22:27:12 -0400
Date: Thu, 11 Sep 2014 10:27:09 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20140911022709.GA16027@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP]  [PATCH] ldd01: using 'ppc' to check powerpc arch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hello,
The ldd01 always failed on some powerpc systems of ours. I have figured
out a patch. Please take a look. Thanks in advance.


On some powerpc system, the 'uname -a' doesn't show 'powerpc' but will
show 'ppc'. So we need using it to check the powerpc arch.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/commands/ade/ldd/ldd01 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/ade/ldd/ldd01
index c60d3ac..569902e 100755
--- a/testcases/commands/ade/ldd/ldd01
+++ b/testcases/commands/ade/ldd/ldd01
@@ -47,7 +47,7 @@ do_setup()
 	mkdir $TCtmp
 
 	# Check for ppc64 architecture or x86_64 architecture
-	if uname -a | grep -iq powerpc; then
+	if uname -a | grep -iq 'ppc\|powerpc'; then
 		file lddfile1.obj | grep 64-bit >/dev/null 2>&1
 		if [ $? -eq 0 ]; then
 			CFLAGS="-m64"
-- 
1.9.3


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
