Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WTBG3-0006sp-MQ
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 14:26:15 +0000
Date: Thu, 27 Mar 2014 15:25:48 +0100
From: chrubis@suse.cz
Message-ID: <20140327142548.GA5448@rei>
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<532C1813.9060609@oracle.com> <532C4201.3030605@oracle.com>
	<2329840.m4xvHeQu3f@vapier>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2329840.m4xvHeQu3f@vapier>
Subject: Re: [LTP] [PATCH 2/3] isofs.sh: be more quiet
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> that might work.  certainly the current code, if it's trying to make the 
> script "sleep" in hopes the device is no longer in use by udev/whatever, is 
> also broken.

Last time I've seen this problem the offender was GNOME gvfsd-trash
process. There are even several bugreports for that.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
