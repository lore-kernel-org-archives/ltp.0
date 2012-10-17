Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris@mips.com>) id 1TOXZf-00051H-Hl
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 17:38:31 +0000
Received: from dns1.mips.com ([12.201.5.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TOXZb-0007QC-Ib
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 17:38:31 +0000
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q9HHcLfd032471
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Oct 2012 10:38:21 -0700
Received: from exchdb01.mips.com (unknown [192.168.36.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mailgate1.mips.com (Postfix) with ESMTP id 22DE2364656
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Oct 2012 10:38:20 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MIMEBOUNDARY"
From: Chris Dearman <chris@mips.com>
Date: Wed, 17 Oct 2012 10:38:19 -0700
Message-ID: <20121017173819.11624.74780.stgit@localhost6.localdomain6>
In-Reply-To: <507D6CAD.1040209@mips.com>
References: <507D6CAD.1040209@mips.com>
Subject: [LTP] [PATCH] pipe01 should only check the data actually received
	from the	pipe
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--MIMEBOUNDARY
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The pipe write does not include the string terminator. The way the
test is written it's valid for the writer to send less than the
requested data and for the reader to read less than the number of
written bytes, so just compare the actual bytes received.

Signed-off-by: Chris Dearman <chris@mips.com>
---
 testcases/kernel/syscalls/pipe/pipe01.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--MIMEBOUNDARY
Content-Disposition: attachment; filename="improve-correctness-of-pipe01.patch"
MIME-Version: 1.0
Content-Type: text/plain; name="improve-correctness-of-pipe01.patch";
	charset="utf-8"
Content-Transfer-Encoding: 7bit

diff --git a/testcases/kernel/syscalls/pipe/pipe01.c b/testcases/kernel/syscalls/pipe/pipe01.c
index 08cf612..f49d7f4 100644
--- a/testcases/kernel/syscalls/pipe/pipe01.c
+++ b/testcases/kernel/syscalls/pipe/pipe01.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 			}
 
 			/* are the strings written and read equal */
-			if ((greater = strcmp(rebuf, wrbuf)) != 0) {
+			if ((greater = strncmp(rebuf, wrbuf, red)) != 0) {
 				tst_resm(TFAIL, "Condition #3 test failed");
 				continue;
 			}

--MIMEBOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
--MIMEBOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--MIMEBOUNDARY--

