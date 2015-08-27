Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZUxXc-0001lx-PP
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2015 13:48:32 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZUxXX-0001qH-2e
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2015 13:48:32 +0000
Date: Thu, 27 Aug 2015 15:47:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150827134749.GA28831@rei.suse.cz>
References: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
	<1439899089-7601-1-git-send-email-mmarhefk@redhat.com>
	<20150826150521.GA19278@rei.suse.de>
	<20150827115542.GA27851@rei.suse.cz> <55DF1280.5080300@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55DF1280.5080300@redhat.com>
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
> > Since the ns_create only creates a new network namespace the rest of the
> > namespaces are inherited. At least when I change the ns_create that
> > creates the handle to create new user namespace as well it can
> > succesfully join it.
> > 
> > Why do we attempt to join all namespaces in the ns_exec? I guess that we
> > will have to change it to get a list of namespaces to join the same way
> > the ns_create does it.
> 
> The original idea was to simply join all NSs of the target to avoid
> passing the ns type, which is a nice idea and works for any other ns,
> but unfortunately not for user ns.
> The simple fix for that would be readlink() on the file and if the id
> (dentry) matches the one in /proc/self/ns/, don't open it.

Or we may ignore EINVAL for the user namespace. But shouldn't be joining
only the net namespace enough for the testing? That way we are sure that
other namespaces does not cause unexpected side effects.

> However I fear there may be other considerations at hand, ie. user ns
> interactions with other NSs - the functions (from what I can see) can
> create/unshare multiple namespaces on a single process. If one specifies
> ie. CLONE_NEWNS | CLONE_NEWUSER | CLONE_NEWNET, the user ns is always
> created first. This theoretically means (haven't tested it myself) that
> an unprivileged user can create non-user namespaces if it has UID 0 in
> the new user namespace as well as a privileged user being unable to
> create the other namespaces if it doesn't have the capabilities to do so
> in the new user namespace (according to uid/gid maps).

Hmm, kind of makes sense...

> This also implies possible complications of calling setns() multiple
> times for multiple different namespace types - it may be necessary to
> call it first on the user ns fd (or the other way around?).

The setns() with user ns should be last if we want to join more
namespaces, otherwise I get EPERM since the process is no longer
capable, but that happen only in case I've actually created new user
namespace.

> In addition, there are probably going to be some problems with
> capability bits when calling execve(2) after doing setns on user ns
> (see capabilities(7), "Thread capability sets").
> 
> Yes, user namespaces are even bigger PITA than pid namespaces. :)

Looks like that.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
