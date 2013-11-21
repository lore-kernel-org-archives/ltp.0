Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VjRek-0002eQ-Cc
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 10:38:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VjRej-0002z8-3C
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 10:38:42 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rALAcXqf014558
	for <ltp-list@lists.sourceforge.net>; Thu, 21 Nov 2013 18:38:34 +0800
Message-ID: <1385030308.1552.4.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2013 18:38:28 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH] confstr/confstr01.c: add new names
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Add new case for confstr(2) :
_CS_GNU_LIBC_VERSION, _CS_GNU_LIBPTHREAD_VERSION.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/confstr/confstr01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/confstr/confstr01.c b/testcases/kernel/syscalls/confstr/confstr01.c
index b6aebf1..6b4b432 100644
--- a/testcases/kernel/syscalls/confstr/confstr01.c
+++ b/testcases/kernel/syscalls/confstr/confstr01.c
@@ -63,6 +63,8 @@ static struct test_case_t {
 	{_CS_XBS5_LPBIG_OFFBIG_LDFLAGS, "XBS5_LPBIG_OFFBIG_LDFLAGS"},
 	{_CS_XBS5_LPBIG_OFFBIG_LIBS, "XBS5_LPBIG_OFFBIG_LIBS"},
 	{_CS_XBS5_LPBIG_OFFBIG_LINTFLAGS, "XBS5_LPBIG_OFFBIG_LINTFLAGS"},
+	{_CS_GNU_LIBC_VERSION, "GNU_LIBC_VERSION"},
+	{_CS_GNU_LIBPTHREAD_VERSION, "GNU_LIBPTHREAD_VERSION"},
 };
 
 char *TCID = "confstr01";
-- 
1.8.2.1




------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
