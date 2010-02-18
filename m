Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NiEUi-0000Pw-Rf
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 22:05:12 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NiEUh-0004LF-PE
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 22:05:12 +0000
Received: by pxi40 with SMTP id 40so1290410pxi.22
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Feb 2010 14:05:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9debc4411002180950r16a98d89n64b8eba7ed16113d@mail.gmail.com>
References: <4B7BA709.8080306@linux.vnet.ibm.com>
	<70aae6bd1002170035j6b8ad2a3la26a90d13b7b800e@mail.gmail.com>
	<20100217120746.GA5966@rishikesh.in.ibm.com>
	<70aae6bd1002171928r7b86a5c2g568117a65dc462fe@mail.gmail.com>
	<20100218040850.GB13013@rishikesh.in.ibm.com>
	<9debc4411002180950r16a98d89n64b8eba7ed16113d@mail.gmail.com>
Date: Thu, 18 Feb 2010 14:05:06 -0800
Message-ID: <364299f41002181405o18dd2be6yd8f77ea30d3fe8f4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] CAN LTP BE CROSS COMPILED FOR ANDROID PLATFORM
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Maxin John <maxin.john@gmail.com>
Cc: Rishikesh <risrajak@in.ibm.com>, ltp-list@lists.sourceforge.net, md zafar ziya <md.zafar.ziya@gmail.com>

On Thu, Feb 18, 2010 at 9:50 AM, Maxin John <maxin.john@gmail.com> wrote:
> Hi Rishikesh,
>
>>> 1.All LTP application has to compiled against Android bionic library.
>>> 2.Use Android Target Cross compiler for building Testcases executables(=
That
>>> use compiler builtin API also).
>>> 3.Android libraray dont have -lrt and -lpthread library,Real time
>>> library(rt) and Thread library(pthread) are not defined inside Bionic,so
>>> just remove these entries from Makefile because these library function =
are
>>> being moved to bionic C library and for thread API include proper header
>>> file only.

Ok. I'll identify the problem items here and eliminate them
[hopefully] by next month's snapshot by adding more autoconf tests.

More importantly, can the SDK build be driven by anything other than
eclipse (UCK..)? I'd rather not install that mess and have to drive
builds if at all possible.

>>> 4.Header files are placed to different location in bionic ,So update the
>>> source as per requirement.

See comment below.

>>> 5.to run LTP on android based target,use busybox(Cross compiled for
>>> android:Path-http://benno.id.au/blog/2007/11/14/android-busybox).Push to
>>> target and use.
>>> 6.Modify script as per requirement because android based target has
>>> different interpretation.

/bin/sh comment?

>>> 7.Push only scripts and binary of the executables(because of memory
>>> constraints) inside target.

Instead of what...?

>>> 8.Run runltp
>
> Adding some more comments:
>
> =A01. I have observed that the 'ash' shell present in the busybox will
> not be supporting all the functionalities required for running LTP on
> Android. To resolve this, we need to cross compile the bash-4.1 for
> Android. =A0This change is working fine for me.

Yes, we're trying to nuke all bashisms whenever possible. Please send
a full list of problem scripts so that they can be fixed instead of
having to cross-compile bash (><).

> 2 . Remount the '/' in read write mode in Android. Create /bin and
> /tmp directories (most of the LTP test cases depends on the existence
> of these directories ie: #!/bin/sh ). Push the cross compiled bash to
> /bin directory and create the symbolic link 'sh' from 'bash'. We can
> also place the above mentioned busybox in the /bin directory and
> create the required links.

1. #!/bin/sh not existing is a nasty portability issue that really
should be fixed with android unless google plans to roll all of their
rc scripts and stuff as a lot of people assume that /bin/sh exists
(and it's a fairly valid assumption to trust as it's standard across
multiple Unices, not just Linux..).
2. /tmp shouldn't be a big problem if tests do the right thing (for
the most part) and apart from modifying /etc/ files, put all generated
files in tmpfs mounted /tmp // /var . Some tests may fail though
unless the host platform has 2GB `free space' allocated for the tmpfs
filesystem.

> 3. Bionic header files are placed in different directories eg: in LTP
> <wait.h> should be modified as <sys/wait.h> , <sys/fcntl.h> should be
> modified as <fcntl.h> ... etc :)

If Bionic isn't being standard according to standard Linux libcall //
syscall manpages, Bionic needs to be fixed -- not LTP, as LTP (or any
Linux project) shouldn't support non-standard distro packaging quirks.

> 4. Some syscalls should be modified using
> "syscall(__N_syscallname,parameters...)" which is present in
> <sys/syscall.h>

Example?

> 5. Better to have cross compiled 'perl' binary since we need to run
> some perl scripts also.

We [Mike F and I] are advocating that we get rid of the perl
dependency where it's not required because it's just another
`annoying' tool that needs to be maintained in-house and the majority
of the time perl can be replaced by awk // sed. I honestly don't know
of any mainstream tools though that require perl other than the
top-level and post-processing scripts.

> Finally push all the above mentioned binaries along with cross
> compiled LTP binaries to Android for the 'real test'.

Thanks for the feedback!
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
