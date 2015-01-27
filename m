Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YG7Pz-0000ms-FX
	for ltp-list@lists.sourceforge.net; Tue, 27 Jan 2015 14:47:03 +0000
Date: Tue, 27 Jan 2015 15:46:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150127144652.GC16759@rei.suse.de>
References: <1422323457-184525-1-git-send-email-shengyong1@huawei.com>
	<1422323457-184525-5-git-send-email-shengyong1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422323457-184525-5-git-send-email-shengyong1@huawei.com>
Subject: Re: [LTP] [RESEND PATCH v3 4/4] syscall/{rename11,
 renameat01}: do not test EMLINK if subdir limit not availiable
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
Cc: ltp-list@lists.sourceforge.net

Hi!
>  static void test_emlink(void)
>  {
> -	if (max_subdirs == 0) {
> +	if (max_subdirs == 0 || max_subdirs == -1) {

Hmm, can't we just return 0 as well when the code that tries to figure
out max_subdirs was skipped?

Or is there really reason why we need to differentiate between these two
conditions?

>  		tst_resm(TCONF, "EMLINK test is not appropriate");
>  		return;
>  	}
> diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
> index bb5e6df..11b82f1 100644
> --- a/testcases/kernel/syscalls/renameat/renameat01.c
> +++ b/testcases/kernel/syscalls/renameat/renameat01.c
> @@ -211,7 +211,8 @@ static void setup(void)
>  
>  static void renameat_verify(const struct test_case_t *tc)
>  {
> -	if (tc->exp_errno == EMLINK && max_subdirs == 0) {
> +	if (tc->exp_errno == EMLINK &&
> +	    (max_subdirs == 0 || max_subdirs == -1)) {
>  		tst_resm(TCONF, "EMLINK test is not appropriate");
>  		return;
>  	}
> -- 
> 1.8.3.4
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
