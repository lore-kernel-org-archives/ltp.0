Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZUxwU-0003Em-2W
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2015 14:14:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUxwS-0002c0-4c
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2015 14:14:14 +0000
Date: Thu, 27 Aug 2015 16:13:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150827141335.GB28831@rei.suse.cz>
References: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
	<1439899089-7601-1-git-send-email-mmarhefk@redhat.com>
	<20150826150521.GA19278@rei.suse.de>
	<20150827115542.GA27851@rei.suse.cz> <55DF1280.5080300@redhat.com>
	<20150827134749.GA28831@rei.suse.cz> <55DF19FC.3030501@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55DF19FC.3030501@redhat.com>
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> In addition, there are probably going to be some problems with
> >> capability bits when calling execve(2) after doing setns on user ns
> >> (see capabilities(7), "Thread capability sets").
> >>
> >> Yes, user namespaces are even bigger PITA than pid namespaces. :)
> > 
> > Looks like that.
> > 
> 
> Maybe the best solution would be explicit getopt-like switches, telling
> exec_ns which namespaces and in which order to setns.

I came to this conclusion as well. It does not need to be getopt-like,
maybe just list of namespaces to join, the important part is that the
order would be preserved.

I would just accept the parameters the same way as the ns_create does,
i.e. list of argv parameters. And handle them in two passes, first one
would check that the parameters are correct and the second pass would
actually call the setns() one by one in the order they were specified.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
