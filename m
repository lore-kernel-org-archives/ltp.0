Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2d2s-0006Rm-LB
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:15:42 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2d2r-0007IM-QD
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:15:42 +0000
Message-ID: <55780E44.3090203@oracle.com>
Date: Wed, 10 Jun 2015 13:15:32 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <2146467181.815321433923090470.JavaMail.weblogic@epmlwas05b>
In-Reply-To: <2146467181.815321433923090470.JavaMail.weblogic@epmlwas05b>
Subject: Re: [LTP] [PATCH 1/1] kernel:flock/flock01.c: Change tst_resm()
 followed by tst_exit() to tst_brkm()
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
To: maninder1.s@samsung.com, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi.

On 06/10/2015 10:58 AM, Maninder Singh wrote:
> As in commit 9fa8ad0 Change tst_resm() followed by tst_exit() to tst_brkm()
>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
> ---
>   testcases/kernel/syscalls/flock/flock01.c |   12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>

You are doing exactly the same thing in two related test cases, so I 
don't see a reason to keep the changes in to separate patches.

Could you, please, merge this patch with the one for flock/flock06.c and 
resend?

Thanks.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
