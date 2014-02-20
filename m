Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WGUC5-0005nh-66
	for ltp-list@lists.sourceforge.net; Thu, 20 Feb 2014 14:01:41 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 64205AC86
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Feb 2014 14:01:34 +0000 (UTC)
Date: Thu, 20 Feb 2014 15:01:28 +0100
From: chrubis@suse.cz
Message-ID: <20140220140128.GA25930@rei>
References: <1392642413-11071-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392642413-11071-1-git-send-email-jack@suse.cz>
Subject: Re: [LTP] [PATCH] syscalls/inotify: Extend tests to verify cookie
	value
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +				if (event->mask == IN_MOVED_FROM) {
> +					if (event->cookie == 0)
> +						goto cookie_fail;
> +					stored_cookie = event->cookie;
> +				} else if (event->mask == IN_MOVED_TO) {
> +					if (event->cookie != stored_cookie)
> +						goto cookie_fail;
> +					stored_cookie = UINT_MAX;
> +				} else {
> +					if (event->cookie != 0)
> +						goto cookie_fail;
> +				}
>  				tst_resm(TPASS,
>  					 "get event: wd=%d mask=%x"
>  					 " cookie=%u len=%u name=\"%s\"",
>  					 event->wd, event->mask, event->cookie,
>  					 event->len, event->name);
> -
> +				goto next;
> +cookie_fail:
> +				tst_resm(TFAIL,
> +					 "get event: wd=%d mask=%x cookie=%u "
> +					 "(wrong) len=%u name=\"%s\"",
> +					 event->wd, event->mask,
> +					 event->cookie, event->len,
> +					 event->name);
>  			} else {
>  				tst_resm(TFAIL, "get event: wd=%d mask=%x "
>  					 "(expected %x) cookie=%u len=%u "
> @@ -241,6 +261,7 @@ int main(int ac, char **av)
>  					 strcmp(event_set[test_num].name,
>  						event->name));
>  			}
> +next:

Hmm, shouldn't we rather add a variable named failed, initialize it to
zero, set it to non-zero values ono failure and branch tst_resm() on it?

The goto statements are getting a bit out of hand in this part...

Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
