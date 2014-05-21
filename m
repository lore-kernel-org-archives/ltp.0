Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Wn3nn-0006M5-18
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 10:31:15 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Wn3nm-00021j-8J
	for ltp-list@lists.sourceforge.net; Wed, 21 May 2014 10:31:14 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4LAV7LH028874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:31:08 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4LAV6vV003529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:31:07 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s4LAV6NT019426
	for <ltp-list@lists.sourceforge.net>; Wed, 21 May 2014 10:31:06 GMT
Message-ID: <537C8067.4070000@oracle.com>
Date: Wed, 21 May 2014 14:31:03 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <20140520144246.GA30023@rei.suse.cz>
	<1400667887-5188-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1400667887-5188-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 3/3] ltp_rt_sigaction: added SPARC support
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
Cc: vasily.isaenko@oracle.com



On 05/21/2014 02:24 PM, Stanislav Kholmanskikh wrote:
> Based on patches by Jose E. Marchesi <jose.marchesi@oracle.com>.
>
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>

Sorry, I forgot to mention why we are doing this in the commit message.

If the patches are ok, I'll add a few strings at the push time.

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
