From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 May 2021 14:57:51 +0200
Subject: [LTP] [PATCH 2/2] shell: Extend timeout tests,
 to run on multiple shells
In-Reply-To: <2f8e652b-aaa8-5f98-4f9d-5b7c138c17fa@jv-coder.de>
References: <20210519063109.224352-1-lkml@jv-coder.de>
 <20210519063109.224352-2-lkml@jv-coder.de> <YKToUgBnK6ZQ5I0Q@yuki>
 <2f8e652b-aaa8-5f98-4f9d-5b7c138c17fa@jv-coder.de>
Message-ID: <YKULT1tIBFIR+U70@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> HI Cyril,

> On 5/19/2021 12:28 PM, Cyril Hrubis wrote:
> > Hi!
> > > There are some differences especially in signal handling
> > > between the shells, so execute the tests on as many
> > > shells as possible.
> > I'm not sure that we want to support anything but bash, dash and
> > busybox and even these three are enough trouble.

> > One of my friends once told me that it's easier to write a portable
> > shell than portable shell code and it looks like he was right...

> In general I would say: YES
> But if at some point in the future there are features used, that really only
> work for one shell,
> we can still reduce the tested shells for this script.

> Btw: ksh is not really support, it complains about all local variables,
> because it only allows them in "function <name>"-style functions.
> But the timeout code still works even there.

Although I generally agree that scrips should be portable to some extent
(it's already hard trying to keep it POSIX), it should be for shells which are
used on Linux distros as a default shell (/bin/sh). That's why besides the
default bash on most of distros we also care about dash (Debian/Ubuntu by
default) and busybox sh implementation (embedded distros and Alpine).
I'm not aware of any distro using ksh, csh or zsh as a default.

Trying to remember when I met ksh as a default, I guess it was on some old
Solaris, more than decade ago :).

We state this in shell shoding style chapter [1]. Maybe I should have added it
into Supported kernel ... page [2], but not many people run shell tests anyway.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style
[2] https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions

> J?rg
