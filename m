Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YYYi5-0005Ta-5f
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 11:33:57 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YYYi3-0004XG-DW
	for ltp-list@lists.sourceforge.net; Thu, 19 Mar 2015 11:33:57 +0000
Date: Thu, 19 Mar 2015 07:33:42 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1627971631.32976127.1426764822909.JavaMail.zimbra@redhat.com>
In-Reply-To: <1426742198-17967-2-git-send-email-bamvor.zhangjian@huawei.com>
References: <1426742198-17967-1-git-send-email-bamvor.zhangjian@huawei.com>
	<1426742198-17967-2-git-send-email-bamvor.zhangjian@huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] [RFC PATCH 1/3] ARM64: ILP32: modify struct
 kernel_sigaction
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
To: "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: dingtianhong@huawei.com, ltp-list@lists.sourceforge.net, bintian wang <bintian.wang@huawei.com>, apinski@cavium.com, yangyingliang@huawei.com





----- Original Message -----
> From: "Zhang Jian(Bamvor)" <bamvor.zhangjian@huawei.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "bintian wang" <bintian.wang@huawei.com>, yangyingliang@huawei.com, apinski@cavium.com, dingtianhong@huawei.com
> Sent: Thursday, 19 March, 2015 6:16:36 AM
> Subject: [LTP] [RFC PATCH 1/3] ARM64: ILP32: modify struct kernel_sigaction
> 
> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> In ILP32, the sigaction struct is the same as AARCH64.
> To allow for this to work, we use a long long fields and
> then add extra casts when converting between the user
> exposed struct and the kernel exposed struct.
> The modify is came from a patch of glibc,
> the commit is 9266f4b060f6("Add kernel_sigaction.h for AARCH64 ILP32").
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  include/lapi/rt_sigaction.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/lapi/rt_sigaction.h b/include/lapi/rt_sigaction.h
> index 46f6a50..2b1365a 100644
> --- a/include/lapi/rt_sigaction.h
> +++ b/include/lapi/rt_sigaction.h
> @@ -34,9 +34,9 @@
>  #define INVAL_SA_PTR ((void *)-1)
>  
>  struct kernel_sigaction {
> -	__sighandler_t k_sa_handler;
> -	unsigned long sa_flags;
> -	void (*sa_restorer) (void);
> +	unsigned long long k_sa_handler;
> +	unsigned long long sa_flags;
> +	unsigned long long sa_restorer;

Isn't this going to break i386? (long is 4, long long is 8).

Regards,
Jan

>  	sigset_t sa_mask;
>  };
>  
> @@ -159,7 +159,7 @@ static int ltp_rt_sigaction(int signum, const struct
> sigaction *act,
>  	if (act == INVAL_SA_PTR) {
>  		kact_p = INVAL_SA_PTR;
>  	} else if (act) {
> -		kact.k_sa_handler = act->sa_handler;
> +		kact.k_sa_handler = (unsigned long long)(uintptr_t)act->sa_handler;
>  		memcpy(&kact.sa_mask, &act->sa_mask, sizeof(sigset_t));
>  		kact.sa_flags = act->sa_flags;
>  		kact.sa_restorer = NULL;
> @@ -203,12 +203,12 @@ static int ltp_rt_sigaction(int signum, const struct
> sigaction *act,
>  
>  	if (ret >= 0) {
>  		if (oact && (oact != INVAL_SA_PTR)) {
> -			oact->sa_handler = koact.k_sa_handler;
> +			oact->sa_handler = (void*)(uintptr_t)koact.k_sa_handler;
>  			memcpy(&oact->sa_mask, &koact.sa_mask,
>  				sizeof(sigset_t));
>  			oact->sa_flags = koact.sa_flags;
>  #ifdef HAVE_SA_RESTORER
> -			oact->sa_restorer = koact.sa_restorer;
> +			oact->sa_restorer = (void*)(uintptr_t)koact.sa_restorer;
>  #endif
>  		}
>  	}
> --
> 1.8.4.5
> 
> 
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website,
> sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for
> all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
