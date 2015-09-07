Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZYxVo-0004ns-Ih
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2015 14:35:12 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZYxVm-0008Rr-H2
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2015 14:35:12 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id E889AAABB
	for <ltp-list@lists.sourceforge.net>;
	Mon,  7 Sep 2015 14:35:03 +0000 (UTC)
Date: Mon, 7 Sep 2015 16:34:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150907143426.GA26079@rei.suse.cz>
References: <1441619902-25433-1-git-send-email-chnyda@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441619902-25433-1-git-send-email-chnyda@suse.com>
Subject: Re: [LTP] [PATCH] cgroup_fj: renamed arguments because the previous
 ones were not clear.
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
To: Cedric Hnyda <chnyda@suse.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  case $mount_times in
> -"1" )
> +"1"|"100")
>  	mount_times=1
>  	;;
> -"2" )
> -	mount_times=100
> -	;;
>  *  )


Hmm, after the change the mount_times is always set to 1 (forget to
remove mount_times=1?).

Also we may only want to check that the parameter is a numeric so that
we can tune the test parameters later (and for other parameters that can
be tuned such as number of subgroup as well).

The portable way to do that seems to be case statement:

case $mount_times in
	''|*[!0-9]*) usage;;
	*) ;;
esac


Otherwise the patch looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
