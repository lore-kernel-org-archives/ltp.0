Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YzQhB-0003zQ-IT
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 14:28:05 +0000
Date: Mon, 1 Jun 2015 16:27:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150601142710.GC10758@rei.suse.de>
References: <1767962182.190171432787952596.JavaMail.weblogic@epmlwas05c>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1767962182.190171432787952596.JavaMail.weblogic@epmlwas05c>
Subject: Re: [LTP] [PATCH]: Fix Invalid number of character
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
To: Manjeet Pawar <manjeet.p@samsung.com>
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Yogesh Narayan Gaur <yn.gaur@samsung.com>

Hi!
> This patch adds curly brace in if condition to check buffer
> 
> Signed-off-by: Manjeet Pawar <manjeet.p@samsung.com>
> Signed-off-by: Yogesh Gaur <yn.gaur@samsung.com>
> ---
>  lib/dataascii.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/dataascii.c b/lib/dataascii.c
> index 1214ba6..2a196bf 100644
> --- a/lib/dataascii.c
> +++ b/lib/dataascii.c
> @@ -119,7 +119,7 @@ int main(int ac, char **ag)
>  	char *errmsg;
>  
>  	buffer = malloc(size);
> -	if (buffer == NULL)
> +	if (buffer == NULL){
>  		perror("malloc");
>  		exit(2);
>  	}

This is obvious fix, but there should be space before the opening curly
brace. Please resend.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
