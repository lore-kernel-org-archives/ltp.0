From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Jun 2017 13:49:51 +0200
Subject: [LTP] [PATCH v2] syscalls: Add timer measurement library
In-Reply-To: <88192643.36961651.1497621378847.JavaMail.zimbra@redhat.com>
References: <20170614124239.21109-1-chrubis@suse.cz>
 <88192643.36961651.1497621378847.JavaMail.zimbra@redhat.com>
Message-ID: <20170620114951.GC5369@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> - clock_getres/clock_gettime requires -rt for glibc < 2.17
> On RHEL5/6 I had to modify these Makefiles:
> #       modified:   include/mk/testcases.mk
> #       modified:   lib/newlib_tests/Makefile
> #       modified:   lib/tests/Makefile
> #       modified:   testcases/kernel/containers/netns/Makefile
> #       modified:   testcases/kernel/containers/share/Makefile

Hrm, looks like we have the very same problem as we had with the
mq_open() either we link everything with -lrt or figure out how to
separate the timer library and link it only with the timer testcases.
The problem here is that we call a funcition from the timer library from
the main library. And we cannot use weak stubs since we link statically.

Thinking of it using raw clock_* syscalls to avoid the dependency is not
a good option either since these are VDSO. These could still be reached
via syscall() it would be only slower and possibly broken since glibc
defaults to VDSO...

Or do you have a better idea how to avoid linking whole LTP with -lrt?

-- 
Cyril Hrubis
chrubis@suse.cz
