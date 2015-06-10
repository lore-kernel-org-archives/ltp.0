Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Z2g0i-0004w9-P2
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 13:25:40 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2g0g-0007ex-QO
	for ltp-list@lists.sourceforge.net; Wed, 10 Jun 2015 13:25:40 +0000
Message-ID: <55783AC9.1000601@oracle.com>
Date: Wed, 10 Jun 2015 16:25:29 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1464675384.830491433940044508.JavaMail.weblogic@epmlwas05b>
In-Reply-To: <1464675384.830491433940044508.JavaMail.weblogic@epmlwas05b>
Subject: Re: [LTP] [PATCH v2] kernel:flock: Change tst_resm() followed by
 tst_exit() to tst_brkm()
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



On 06/10/2015 03:40 PM, Maninder Singh wrote:
> As in commit 9fa8ad0 Change tst_resm() followed by tst_exit() to tst_brkm()
>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Akhilesh Kumar <akhilesh.k@samsung.com>
> ---
>   testcases/kernel/syscalls/flock/flock01.c |   12 ++----------
>   testcases/kernel/syscalls/flock/flock06.c |   10 ++--------
>   2 files changed, 4 insertions(+), 18 deletions(-)

+ I slightly modified the subject and changed TFAIL to TBROK and pushed.

Thanks.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
