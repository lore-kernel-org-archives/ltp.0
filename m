Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WeioJ-0003wc-T6
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 10:29:19 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WeioI-0004Yv-VC
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 10:29:19 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3SATA8j011070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 10:29:11 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3SATAlP027019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 10:29:10 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3SAT9er027010
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 10:29:09 GMT
Message-ID: <535E2D73.3000103@oracle.com>
Date: Mon, 28 Apr 2014 14:29:07 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1398674834-1643-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1398674834-1643-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] kernel/mem/lib/mem.c: fix compilation warnings
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

Hi!

On 04/28/2014 12:47 PM, Xiaoguang Wang wrote:
> Functions declared in testcases/kernel/mem/include/_private.h is not
> implemented and used, so delete it.
>
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>

Acked-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

> ---
>   testcases/kernel/mem/include/_private.h | 22 ----------------------
>   testcases/kernel/mem/include/mem.h      |  2 +-
>   testcases/kernel/mem/lib/mem.c          | 25 +++++++++++++++----------
>   3 files changed, 16 insertions(+), 33 deletions(-)
>   delete mode 100644 testcases/kernel/mem/include/_private.h
>

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
