Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZfAwx-0003Fq-W8
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2015 18:08:56 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZfAww-0000b8-Qu
	for ltp-list@lists.sourceforge.net; Thu, 24 Sep 2015 18:08:55 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0A598ABC8
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2015 18:08:47 +0000 (UTC)
Date: Thu, 24 Sep 2015 20:07:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150924180751.GA1094@rei.suse.cz>
References: <1441708477-26192-1-git-send-email-chnyda@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1441708477-26192-1-git-send-email-chnyda@suse.com>
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
> +''|*[!0-9]*) 
> +	usage
> +	exit_parameter;;
> +    *) ;;
>  esac

I've removed the trailing whitespace at the end of the ''|*[!0-9]*) and
updated the commit message and pushed, thanks.

BTW: The canonical format for the git commit message is:

short commit description <= 50 characters
[empty line]
longer commit description that may span across multiple lines with lines
up to 72 chars long...
[empty line]
Signed-off-by: ...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
