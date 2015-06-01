Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YzQfU-0007sU-ER
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 14:26:20 +0000
Date: Mon, 1 Jun 2015 16:25:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150601142525.GB10758@rei.suse.de>
References: <1814027454.189791432787612391.JavaMail.weblogic@epmlwas05c>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1814027454.189791432787612391.JavaMail.weblogic@epmlwas05c>
Subject: Re: [LTP] [PATCH]: Add check for realloc() failure case
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
>  		case 'i':
> -			ilist = realloc(ilist, ++ilistlen * sizeof(*ilist));
> -			ilist[ilistlen - 1] = strtol(optarg, &p, 16);
> +			if(realloc(ilist, ++ilistlen * sizeof(*ilist)) != NULL)
> +				ilist[ilistlen - 1] = strtol(optarg, &p, 16);

This code is wrong. The realloc() may return _different_ address (and
will copy the data if it does so).

> +			else{
> +				fprintf(stderr, "realloc: New memory allocation failed \n");
> +				exit(1);
> +			}
>  			break;
>  		case 'l':
>  			loops = atoi(optarg);

Also the coding style does not follow LKML.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
