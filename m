Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z0Y0o-0006Rh-8S
	for ltp-list@lists.sourceforge.net; Thu, 04 Jun 2015 16:28:58 +0000
Date: Thu, 4 Jun 2015 18:27:57 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150604162757.GA8495@rei.suse.de>
References: <149090115.398111433218346536.JavaMail.weblogic@epmlwas08b>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <149090115.398111433218346536.JavaMail.weblogic@epmlwas08b>
Subject: Re: [LTP] [PATCH]: Add check for realloc failure case
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
Cc: AJEET YADAV <ajeet.y@samsung.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Yogesh Narayan Gaur <yn.gaur@samsung.com>

Hi!
> @@ -113,6 +114,12 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
>  			arg_array =
>  			    (char **)realloc((void *)arg_array,
>  					     sizeof(char *) * max_toks);
> +			if (arg_array == NULL) {
> +				fprintf(stderr, "realloc: New memory allocation failed \n");
> +				free(arg_array);

I've removed the free(arg_array) here, because it's noop (doing free(NULL)) and pushed both patches.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
