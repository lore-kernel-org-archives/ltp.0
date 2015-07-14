Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZEujj-0002mO-Ih
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 07:34:43 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEujh-0008Ls-NF
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2015 07:34:43 +0000
Date: Tue, 14 Jul 2015 03:34:30 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <893248042.16992409.1436859270663.JavaMail.zimbra@redhat.com>
In-Reply-To: <1436856423-5444-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <1436856423-5444-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] lib/safe_macros.c: fix safe_write() and
 safe_pwrite()
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
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Guangwen Feng" <fenggw-fnst@cn.fujitsu.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Tuesday, 14 July, 2015 8:47:03 AM
> Subject: [LTP] [PATCH] lib/safe_macros.c: fix safe_write() and safe_pwrite()
> 
> The len_strict is ineffective in byte length verification
> because of the improper if-condition.
> 
> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

Good catch, pushed.

Regards,
Jan

> ---
>  lib/safe_macros.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index a3d997c..173d72f 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -414,7 +414,7 @@ ssize_t safe_write(const char *file, const int lineno,
> void (cleanup_fn) (void),
>  	ssize_t rval;
>  
>  	rval = write(fildes, buf, nbyte);
> -	if ((len_strict == 0 && rval == -1) || (size_t)rval != nbyte) {
> +	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  			 "%s:%d: write(%d,%p,%zu) failed",
>  		         file, lineno, fildes, buf, rval);
> @@ -430,7 +430,7 @@ ssize_t safe_pwrite(const char *file, const int lineno,
>  	ssize_t rval;
>  
>  	rval = pwrite(fildes, buf, nbyte, offset);
> -	if ((len_strict == 0 && rval == -1) || (size_t)rval != nbyte) {
> +	if (rval == -1 || (len_strict && (size_t)rval != nbyte)) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  			 "%s:%d: pwrite(%d,%p,%zu,%ld) failed",
>  			 file, lineno, fildes, buf, rval, offset);
> --
> 1.8.4.2
> 
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

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
