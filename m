From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 3 Oct 2016 14:19:50 +0200
Subject: [LTP] [PATCH] Allow usage of <sys/xattr.h> header.
In-Reply-To: <1475063587-24552-1-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1475063587-24552-1-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161003121950.GC7583@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> <sys/xattr.h> is nowdays much more common than <attr/xattr.h>. Man
> pages also list <sys/xattr.h> as needed header for syscalls getxattr,
> setxattr, lgetxattr, llistxattr and removexattr.

Well it's not about being common, these headers are part of different
libraries. The sys/xattr.h is glibc one while the attr/xattr.h is part
of attr library[1].

[1] https://savannah.nongnu.org/projects/attr

And the only difference between these two headers is that the glibc one
does not define ENOATTR.

> Currently, related ltp tests are disabled if <attr/xattr.h> is not
> found during configuration process. This patch allows compilation
> if <attr/xattr.h> is not present, but <sys/xattr.h> is present. If
> <sys/xattr.h> is not present, configuration and compilation will
> remain unchanged.

Hmm, I wonder why we don't default to the glibc header since it's
available since glibc 2.3.4 (that is more than ten years old).

And since we do not actually use -llibattr we link agains the glibc
anyway. So I guess that the current code is buggy and that we should
use the glibc header instead.

So what about to switing to sys/xattr.h instead of cluttering the code
with more ifdefs?

-- 
Cyril Hrubis
chrubis@suse.cz
