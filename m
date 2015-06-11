Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z33uA-0002GD-9v
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2015 14:56:30 +0000
Date: Thu, 11 Jun 2015 16:55:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150611145524.GA22344@rei.suse.de>
References: <1433919301-24797-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1433919301-24797-4-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433919301-24797-4-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 4/4] pan/splitstr.c: free memory allocated by
 strdup()
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
>  pan/splitstr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/pan/splitstr.c b/pan/splitstr.c
> index fbcd697..decfbf5 100644
> --- a/pan/splitstr.c
> +++ b/pan/splitstr.c
> @@ -122,6 +122,7 @@ const char **splitstr(const char *str, const char *separator, int *argcount)
>  		}
>  	}
>  	arg_array[num_toks] = NULL;
> +	free(arg_string);

As far as I can see the arg_string is destructively parsed with strtok()
and parts of the string are saved into the array that gets returned
at the end of the function. So freeing it will cause crash.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
