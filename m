Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WfRkC-0005CT-Au
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 10:28:04 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WfRk8-0001GO-Tq
	for ltp-list@lists.sourceforge.net; Wed, 30 Apr 2014 10:28:04 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3UARsh1010683
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 10:27:54 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s3UARrbi001939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 10:27:53 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s3UARr0V001910
	for <ltp-list@lists.sourceforge.net>; Wed, 30 Apr 2014 10:27:53 GMT
Message-ID: <5360D024.4000408@oracle.com>
Date: Wed, 30 Apr 2014 14:27:48 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1398850017-10751-1-git-send-email-shuang.qiu@oracle.com>
In-Reply-To: <1398850017-10751-1-git-send-email-shuang.qiu@oracle.com>
Subject: Re: [LTP] [PATCH 1/2] syscalls/fstatfs: Cleanup
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
To: shuang.qiu@oracle.com, ltp-list@lists.sourceforge.net

Hi!

On 04/30/2014 01:26 PM, shuang.qiu@oracle.com wrote:
> From: Shuang Qiu <shuang.qiu@oracle.com>
>
> * Delete some useless comments
>
> * Make variables and functions static
>
> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>

Reviewed-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

And I would personally add these small changes (can be done at pushing 
time):

diff --git a/testcases/kernel/syscalls/fstatfs/fstatfs02.c 
b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
index b243af3..99dc51b 100644
--- a/testcases/kernel/syscalls/fstatfs/fstatfs02.c
+++ b/testcases/kernel/syscalls/fstatfs/fstatfs02.c
@@ -67,14 +67,12 @@ int main(int ac, char **av)

         setup();

-       /* set up the expected errnos */
         TEST_EXP_ENOS(exp_enos);

         for (lc = 0; TEST_LOOPING(lc); lc++) {

                 tst_count = 0;

-               /* loop through the test cases */
                 for (i = 0; i < TST_TOTAL; i++) {

                         TEST(fstatfs(TC[i].fd, TC[i].sbuf));

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
