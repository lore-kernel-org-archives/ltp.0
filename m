Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YzQcy-0001C7-Bo
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 14:23:44 +0000
Date: Mon, 1 Jun 2015 16:22:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150601142249.GA10758@rei.suse.de>
References: <947582411.189461432787431522.JavaMail.weblogic@epmlwas05c>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <947582411.189461432787431522.JavaMail.weblogic@epmlwas05c>
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
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Yogesh Narayan Gaur <yn.gaur@samsung.com>

Hi!
> @@ -110,9 +111,13 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
>  		cur_tok = strtok(NULL, separator);
>  		if (num_toks == max_toks) {
>  			max_toks += 20;
> -			arg_array =
> -			    (char **)realloc((void *)arg_array,
> -					     sizeof(char *) * max_toks);
> +			if((arg_array = realloc((void *)arg_array,sizeof(char *) * max_toks)) == NULL){
> +				fprintf(stderr, "realloc: New memory allocation failed \n");
> +				free(arg_array);
> +				free(arg_string);
> +				exit(1);
> +			}
> +

These lines does not conform to LKML coding style.

There should be space before the opening curly brace '{', spaces after
coma, etc.

You can use checkpatch.pl shipped with linux kernel source to check your
patches before sending them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
