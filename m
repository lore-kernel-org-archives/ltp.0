Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VoANi-0002dc-04
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 11:12:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VoANg-0004UQ-M9
	for ltp-list@lists.sourceforge.net; Wed, 04 Dec 2013 11:12:37 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id rB4BCTCo007497
	for <ltp-list@lists.sourceforge.net>; Wed, 4 Dec 2013 19:12:29 +0800
Message-ID: <1386155547.1544.9.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Wed, 04 Dec 2013 19:12:27 +0800
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/2] fpathconf/fpathconf01.c: add new test
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

add new test in fpathconf01.c:
_PC_CHOWN_RESTRICTED
_PC_NO_TRUNC

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fpathconf/fpathconf01.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/fpathconf/fpathconf01.c b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
index b551d5a..8980c14 100644
--- a/testcases/kernel/syscalls/fpathconf/fpathconf01.c
+++ b/testcases/kernel/syscalls/fpathconf/fpathconf01.c
@@ -60,6 +60,8 @@ static struct pathconf_args {
 	{"_PC_NAME_MAX", _PC_NAME_MAX},
 	{"_PC_PATH_MAX", _PC_PATH_MAX},
 	{"_PC_PIPE_BUF", _PC_PIPE_BUF},
+	{"_PC_CHOWN_RESTRICTED", _PC_CHOWN_RESTRICTED},
+	{"_PC_NO_TRUNC", _PC_NO_TRUNC},
 };
 
 char *TCID = "fpathconf01";
-- 
1.8.2.1




------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
