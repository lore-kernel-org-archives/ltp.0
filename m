Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMyI4-0006ra-7n
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 12:59:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMyI3-0002od-5o
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2015 12:59:28 +0000
Date: Wed, 5 Aug 2015 14:59:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150805125903.GD31234@rei.suse.de>
References: <1436420037-18441-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436420037-18441-1-git-send-email-maninder1.s@samsung.com>
Subject: Re: [LTP] [PATCH 2/2] open_posix/shm_unlink: sanity checking after
 calling pathconf
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
To: Maninder Singh <maninder1.s@samsung.com>
Cc: ltp-list@lists.sourceforge.net, pankaj.m@samsung.com

Hi!
> sanity checking after calling pathconf added
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Reviewed-by: Yogesh Narayan Gaur <yn.gaur@samsung.com>
> ---
>  .../conformance/interfaces/shm_unlink/10-1.c       |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
> index 768863c..20e5bef 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/shm_unlink/10-1.c
> @@ -27,6 +27,11 @@ int main(void)
>  	char *shm_name;
>  
>  	name_max = pathconf("/", _PC_NAME_MAX);
> +
> +	if (name_max == -1) {
> +		perror("An error occurs when calling pathconf()");

I've shortened this error message to "pathconf() failed" here and in
10-2.c and pushed both patches, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
