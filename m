Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maninder1.s@samsung.com>) id 1Z2d7h-0006de-GU
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:20:41 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1Z2d7f-0007RC-GY
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 10:20:41 +0000
Received: from epcpsbgr5.samsung.com
	(u145.gpu120.samsung.co.kr [203.254.230.145])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NPQ00UB94Q8GO70@mailout3.samsung.com> for
	ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 19:20:32 +0900 (KST)
Date: Wed, 10 Jun 2015 10:20:20 +0000 (GMT)
From: Maninder Singh <maninder1.s@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <196909982.825721433931619951.JavaMail.weblogic@epmlwas05b>
Subject: Re: [LTP] [PATCH 1/1] kernel:flock/flock01.c: Change tst_resm()
 followed by tst_exit() to tst_brkm()
Reply-To: maninder1.s@samsung.com
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hello,

Sure i will send in one patch, I created one patch per file, so that it would be easy for maintainer 
and reviewer to review the changes, and Maintainer can check in same commit both patches.

Thanks and Regards,
Maninder Singh

------- Original Message -------
Sender : Stanislav Kholmanskikh<stanislav.kholmanskikh@oracle.com>
Date : Jun 10, 2015 19:15 (GMT+09:00)
Title : Re: [LTP] [PATCH 1/1] kernel:flock/flock01.c: Change tst_resm() followed by tst_exit() to tst_brkm()

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
