Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maxin.john@gmail.com>) id 1NiTpY-0006PA-9f
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 14:27:44 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NiTpX-0002IW-0z
	for ltp-list@lists.sourceforge.net; Fri, 19 Feb 2010 14:27:43 +0000
Received: by pxi40 with SMTP id 40so53726pxi.22
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Feb 2010 06:27:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002181405o18dd2be6yd8f77ea30d3fe8f4@mail.gmail.com>
References: <4B7BA709.8080306@linux.vnet.ibm.com>
	<70aae6bd1002170035j6b8ad2a3la26a90d13b7b800e@mail.gmail.com>
	<20100217120746.GA5966@rishikesh.in.ibm.com>
	<70aae6bd1002171928r7b86a5c2g568117a65dc462fe@mail.gmail.com>
	<20100218040850.GB13013@rishikesh.in.ibm.com>
	<9debc4411002180950r16a98d89n64b8eba7ed16113d@mail.gmail.com>
	<364299f41002181405o18dd2be6yd8f77ea30d3fe8f4@mail.gmail.com>
Date: Fri, 19 Feb 2010 19:57:36 +0530
Message-ID: <9debc4411002190627t76c3bbcnb16485b406931dac@mail.gmail.com>
From: Maxin John <maxin.john@gmail.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Rishikesh <risrajak@in.ibm.com>, ltp-list@lists.sourceforge.net, md zafar ziya <md.zafar.ziya@gmail.com>

Hi Garret,

> More importantly, can the SDK build be driven by anything other than
> eclipse (UCK..)? I'd rather not install that mess and have to drive
> builds if at all possible.

Hmm.. Please correct me if I am wrong.  For Android Application
development (Java Apps) and dealing with the emulator/hardware, we
need  SDK. To compile SDK, we don't need Eclipse IDE.If you don't want
to mess up with SDK source, precompiled SDK is available at:
http://developer.android.com/sdk/index.html

However, for cross compiling LTP to Android, we need Android NDK
(Native Development Kit/Tools) which is basically the arm cross
toolchain tailored for Android. It's latest version is available at :
http://developer.android.com/sdk/ndk/1.6_r1/index.html

>> Android. To resolve this, we need to cross compile the bash-4.1 for
>> Android. =A0This change is working fine for me.
>
> Yes, we're trying to nuke all bashisms whenever possible. Please send
> a full list of problem scripts so that they can be fixed instead of
> having to cross-compile bash (><).

I am afraid that it's not 100% possible. I have observed that the ash
shell present in busybox
will not be able to handle arrays properly
(http://osdir.com/ml/busybox/2004-07/msg00152.html).

> 1. #!/bin/sh not existing is a nasty portability issue that really
> should be fixed with android unless google plans to roll all of their
> rc scripts and stuff as a lot of people assume that /bin/sh exists
> (and it's a fairly valid assumption to trust as it's standard across
> multiple Unices, not just Linux..).

Here, we are helpless. Can't do anything unless Google decides so, I guess.

> 2. /tmp shouldn't be a big problem if tests do the right thing (for
> the most part) and apart from modifying /etc/ files, put all generated
> files in tmpfs mounted /tmp // /var . Some tests may fail though
> unless the host platform has 2GB `free space' allocated for the tmpfs
> filesystem.

I really don't think 1GB/2GB free space will be available in commonly
available embedded devices. We should modify the memory requirements
based on the capabilities of the actual device in hand.

>
> If Bionic isn't being standard according to standard Linux libcall //
> syscall manpages, Bionic needs to be fixed -- not LTP, as LTP (or any
> Linux project) shouldn't support non-standard distro packaging quirks.

I do agree with this. However, just to make things work, can we
follow the same way as UCLIBC support in LTP. like:
#if defined(__linux__) && !defined(__UCLIBC__)

>> 4. Some syscalls should be modified using
>> "syscall(__NR_syscallname,parameters...)" which is present in
>> <sys/syscall.h>
>
> Example?

fdatasync(fd) -> syscall(__NR_fdatasync,fd)
truncate64( name->path, length) -> syscall(__NR_truncate64,
name->path, length) .. etc

>> 5. Better to have cross compiled 'perl' binary since we need to run
>> some perl scripts also.
>
> We [Mike F and I] are advocating that we get rid of the perl
> dependency where it's not required because it's just another
> `annoying' tool that needs to be maintained in-house and the majority
> of the time perl can be replaced by awk // sed. I honestly don't know
> of any mainstream tools though that require perl other than the
> top-level and post-processing scripts.

This is a nice idea specially useful for the embedded devices where
there are limitations on the available memory.

> Thanks for the feedback!
Thanks for the comments, Garrett.

Best Regards,
Maxin B. John
www.maxinbjohn.info

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
