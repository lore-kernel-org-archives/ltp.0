Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZHt6X-0003EK-Hi
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 12:26:33 +0000
Date: Wed, 22 Jul 2015 14:26:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150722122623.GA16661@rei.suse.de>
References: <1437043403-11184-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1437043403-11184-2-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1437043403-11184-2-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] pan/splitstr.c: free arg_string before return
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> diff --git a/pan/splitstr.c b/pan/splitstr.c
> index 39b4698..608c682 100644
> --- a/pan/splitstr.c
> +++ b/pan/splitstr.c
> @@ -136,6 +136,7 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
>  	if (argcount != NULL)
>  		*argcount = num_toks;
>  
> +	free(arg_string);

I've explained why this is wrong before, didn't I?

-- 
Cyril Hrubis
chrubis@suse.cz

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
