Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1ZAFyX-0000bl-Vy
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 11:14:45 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZAFyX-0004Xx-2n
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2015 11:14:45 +0000
Message-ID: <5593CC6A.2050501@oracle.com>
Date: Wed, 01 Jul 2015 14:18:02 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1434987065-23739-1-git-send-email-alexey.kodanev@oracle.com>
	<CAPwn2JTduVBP9hgynOwyaNHN427aKAWPq4eyePUSSNzL0beCow@mail.gmail.com>
In-Reply-To: <CAPwn2JTduVBP9hgynOwyaNHN427aKAWPq4eyePUSSNzL0beCow@mail.gmail.com>
Subject: Re: [LTP] [PATCH] sctp: sctputils.c: fix test_peer_addr()
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
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: vasily.isaenko@oracle.com, LTP list <ltp-list@lists.sourceforge.net>

Hi,
On 07/01/2015 05:55 AM, Hangbin Liu wrote:
> I also got this issue while running sctp test and confirm this patch fixed the
> problem. Please push this patch to the repo.

Applied.

Best regards,
Alexey


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
