From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 3 Oct 2016 08:26:18 -0400 (EDT)
Subject: [LTP] [PATCH] Allow usage of <sys/xattr.h> header.
In-Reply-To: <20161003121950.GC7583@rei.suse.cz>
References: <1475063587-24552-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <20161003121950.GC7583@rei.suse.cz>
Message-ID: <1904076579.110796.1475497578827.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Dejan Jovicevic" <dejan.jovicevic@rt-rk.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 3 October, 2016 2:19:50 PM
> Subject: Re: [LTP] [PATCH] Allow usage of <sys/xattr.h> header.
> 
> Hi!
> > <sys/xattr.h> is nowdays much more common than <attr/xattr.h>. Man
> > pages also list <sys/xattr.h> as needed header for syscalls getxattr,
> > setxattr, lgetxattr, llistxattr and removexattr.
> 
> Well it's not about being common, these headers are part of different
> libraries. The sys/xattr.h is glibc one while the attr/xattr.h is part
> of attr library[1].
> 
> [1] https://savannah.nongnu.org/projects/attr
> 
> And the only difference between these two headers is that the glibc one
> does not define ENOATTR.
> 
> > Currently, related ltp tests are disabled if <attr/xattr.h> is not
> > found during configuration process. This patch allows compilation
> > if <attr/xattr.h> is not present, but <sys/xattr.h> is present. If
> > <sys/xattr.h> is not present, configuration and compilation will
> > remain unchanged.
> 
> Hmm, I wonder why we don't default to the glibc header since it's
> available since glibc 2.3.4 (that is more than ten years old).

I was wondering that too.

> 
> And since we do not actually use -llibattr we link agains the glibc
> anyway. So I guess that the current code is buggy and that we should
> use the glibc header instead.
> 
> So what about to switing to sys/xattr.h instead of cluttering the code
> with more ifdefs?

I ran submitted patch across RHEL5.6/6.0/7.3 on x86 and haven't run
into any issues, compile or runtime.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
