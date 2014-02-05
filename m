Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WAzxo-0001h1-0G
	for ltp-list@lists.sourceforge.net; Wed, 05 Feb 2014 10:44:16 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WAzxn-0002TL-62
	for ltp-list@lists.sourceforge.net; Wed, 05 Feb 2014 10:44:15 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s15Ai8Wp014732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Feb 2014 10:44:09 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s15Ai7Rw021626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Feb 2014 10:44:08 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s15Ai7DE020409
	for <ltp-list@lists.sourceforge.net>; Wed, 5 Feb 2014 10:44:07 GMT
Message-ID: <52F215F4.4000301@oracle.com>
Date: Wed, 05 Feb 2014 14:44:04 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1387875605-801-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1387875605-801-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] runtest/stress.part1: fix cmdline for nfsstress
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


On 12/24/2013 01:00 PM, Stanislav Kholmanskikh wrote:
> TCbin is exported with an incorrect path therefore nfsstress
> test cases fail.
>
> Fixed with the correct path.
>
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---

Hello!

Could anybody help to review this?

Thanks.

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
