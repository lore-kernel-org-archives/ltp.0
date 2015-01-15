Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YBlcz-0000MF-1y
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 14:42:29 +0000
Date: Thu, 15 Jan 2015 15:41:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150115144135.GB9499@rei>
References: <1421331671-231350-1-git-send-email-shengyong1@huawei.com>
	<1421331671-231350-3-git-send-email-shengyong1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1421331671-231350-3-git-send-email-shengyong1@huawei.com>
Subject: Re: [LTP] [PATCH V2 2/3] syscall/renameat01: do not test EMLINK if
 subdir limit not availiable
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
To: Sheng Yong <shengyong1@huawei.com>
Cc: yanegomi@gmail.com, ltp-list@lists.sourceforge.net

Hi!
> Do not test EMLINK, if the filesystem has no subdir limit.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  testcases/kernel/syscalls/renameat/renameat01.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
> index bb5e6df..b92f96d 100644
> --- a/testcases/kernel/syscalls/renameat/renameat01.c
> +++ b/testcases/kernel/syscalls/renameat/renameat01.c
> @@ -211,6 +211,11 @@ static void setup(void)
>  
>  static void renameat_verify(const struct test_case_t *tc)
>  {
> +	if (tc->exp_errno == EMLINK && max_subdirs == -1) {
> +		tst_resm(TPASS, "EMLINK test is not tested");

This is TCONF not PASS.


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
