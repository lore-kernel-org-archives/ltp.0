Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YQbBq-0000hS-VC
	for ltp-list@lists.sourceforge.net; Wed, 25 Feb 2015 12:35:46 +0000
Date: Wed, 25 Feb 2015 13:35:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150225123508.GA20275@rei.suse.de>
References: <1688764619.7589818.1423581433749.JavaMail.zimbra@redhat.com>
	<54E4C3C3.6080407@redhat.com> <20150219150413.GA23831@rei>
	<54EC5053.4060005@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54EC5053.4060005@redhat.com>
Subject: Re: [LTP] network namespaces tests cleanup
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
> >> The proposed code uses /proc/<pid>/ns/* as file descriptors, so it needs
> >> at least 2.6.39 kernel and related iproute version or /usr/include
> >> recent enough to have IFLA_NET_NS_FD (so you can write your own netlink
> >> setup utility).
> > 
> > Does not seem to be the case for SLES11 SP3 nor SP4. The kernel should
> > be new enough since SP2 though.
> 
> Well, this would be a "nice to have", we could still use
> IFLA_NET_NS_PID, which you should have (also used by current test code).

This one is present.

> Your iproute could also have support for it,
>   $ ip link help 2>&1 | grep netns

                          [ netns PID ]
                          [ netns NAME ]

Seems to be the case as well.

> >> Some (most?) enterprise distributions may have the functionality
> >> backported, for example RHEL-6.6 fully supports mounting
> >> /proc/<pid>/ns/* and even has util-linux support (like nsenter(1)) for
> >> the mounted file descriptors. It is, however, missing any 'ip netns'
> >> support as well as 'ip link .. netns <file>' (supports only pid).
> >>
> >> What about others?
> >>
> >> # kernel fd (setns(2)) + util-linux support
> >> touch netnstest
> >> unshare --net mount --bind /proc/self/ns/net netnstest
> >> nsenter --net=netnstest ip link show
> > 
> > SLES11 unshare does not support --bind and does not have nsenter likely
> > util-linux is too old (2.19.1).
> 
> The --bind is not for unshare, but for mount(8). If you don't have
> unshare(1) from util-linux or have some old one (without netns support),
> try this as a quick replacement for creating the namespace, feel free
> to use mount(2) with MS_BIND (linux 2.4+) if your mount(8) doesn't
> support --bind:

Ah, right, mount supports bind without problem.

> #define _GNU_SOURCE
> #include <sched.h>
> #include <unistd.h>
> int main(int argc, char **argv)
> {
>     char *ma[] = {"mount","--bind","/proc/self/ns/net","netnstest",NULL};
>     unshare(CLONE_NEWNET);
>     execvp("mount", ma);
>     return 1;
> }

What I got:

mount("/proc/15413/ns/net", "netnstest", 0x410848, MS_MGC_VAL|MS_BIND, NULL) = -1 ENOTDIR (Not a directory)

ls -l /proc/self/ns/net
-r-------- 1 root root 0 Feb 25 13:23 /proc/self/ns/net

> and this as a replacement for nsenter:
> 
> #include <sched.h>
> #include <fcntl.h>
> #include <unistd.h>
> int main(int argc, char **argv)
> {
>     int i, fd;
> 
>     fd = open(argv[1], O_RDONLY);
>     /* provide NULL-terminated array for execve */
>     for (i = 1; i < argc-1; i++)
>         argv[i] = argv[i+1];
>     argv[i] = NULL;
> 
>     setns(fd, 0);
>     execvp(argv[1], argv+1);
>     return 1;
> }
> 
> (use as ./a.out netnstest <cmd> [args])
> 
> If it doesn't work, please try strace, doing proper error detection
> for everything above would double the necessary code.

This works after replacing setns(fd, 0) with the syscall(__NR_setns, fd, 0).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
