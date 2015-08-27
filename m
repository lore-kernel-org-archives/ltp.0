Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZUvn2-0000MN-P0
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2015 11:56:20 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUvn1-0000hD-LU
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2015 11:56:20 +0000
Date: Thu, 27 Aug 2015 13:55:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150827115542.GA27851@rei.suse.cz>
References: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
	<1439899089-7601-1-git-send-email-mmarhefk@redhat.com>
	<20150826150521.GA19278@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150826150521.GA19278@rei.suse.de>
Subject: Re: [LTP] [PATCH 1/2 v3] added helper tools for creating and
 working with namespaces
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> On SLES12 (kernel 3.12.28) setns() fails for the fd opened from "user"
> namespace. I'm getting EINVAL here. Everything seems to work fine if I
> comment the rf |= open_ns_fd(argv[1], "user"); line above.
> 
> Unfortunately EINVAL seems to be catch-all error for setns(), any idea
> what is wrong here?

And it seems to be the case of:

EINVAL The caller attempted to join the user namespace in which
       it is already a member.

Since the ns_create only creates a new network namespace the rest of the
namespaces are inherited. At least when I change the ns_create that
creates the handle to create new user namespace as well it can
succesfully join it.

Why do we attempt to join all namespaces in the ns_exec? I guess that we
will have to change it to get a list of namespaces to join the same way
the ns_create does it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
