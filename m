Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2cjp-0005Ni-Kg
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 04:33:21 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2cjo-0004vs-S0
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 04:33:21 +0000
MIME-Version: 1.0
In-Reply-To: <AANLkTi=woCpWexWHWTcojN7U_UQZEszEvVXEaPDiDpLQ@mail.gmail.com>
References: <20100924100303.5709.80714.sendpatchset@sravan-laptop>
	<20100927142304.GA23119@hallyn.com>
	<4CA0AEB7.7080701@linux.vnet.ibm.com>
	<20100927180239.GA15486@hallyn.com>
	<4CA1ADB0.7070908@linux.vnet.ibm.com>
	<20100928213611.GA1046@hallyn.com>
	<4CA31140.4000805@linux.vnet.ibm.com>
	<20100929141051.GB4620@hallyn.com>
	<OFA3C42AE5.7F12F4DF-ON652577AD.004DA114-652577AD.004DCA76@in.ibm.com>
	<AANLkTi=woCpWexWHWTcojN7U_UQZEszEvVXEaPDiDpLQ@mail.gmail.com>
Date: Sun, 3 Oct 2010 21:33:15 -0700
Message-ID: <AANLkTinjEdCxD5E0BfniymiHHLmF4S_ocsawTdHpfr_2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Compilation Error Fixed in filecaps.
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
To: Subrata Modak1 <subrata.modak@in.ibm.com>
Cc: sravan <sravan@linux.vnet.ibm.com>, ltp-list@lists.sf.net

On Sun, Oct 3, 2010 at 8:50 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, Sep 29, 2010 at 7:09 AM, Subrata Modak1
> <subrata.modak@in.ibm.com> wrote:
>> Serge Hallyn <serge.hallyn@canonical.com> wrote on 09/29/2010 07:40:51 P=
M:
>>>
>>> Quoting sravan (sravan@linux.vnet.ibm.com):
>>> > =A0Sorry for the confusion Serge.
>>> > I have taken the "c.c" file from the latest ltp release and found
>>> > that it is not compiling.
>>> >
>>> > The same file is not compiling in the earlier release of ltp also.
>>> > To resolve the compilation issue I have added the following
>>> > flag(HAVE_SYS_CAPABILITY_H).
>>> > The same flag is also used in
>> ltp-full-20100831/testcases/kernel/security/
>>> filecaps/verify_caps_exec.c
>>> > file.
>>> >
>>> > #if HAVE_SYS_CAPABILITY_H =A0 =A0 =A0 =A0 =A0 =A0//Added by Sravan
>>> > #include <sys/capability.h>
>>> > #endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0// Added by Sravan
>>> >
>>> > Please let me know if this is the correct approach.
>>>
>>> Well, the better approach would be to install the libcap-dev
>>> package (or whatever it is called on your distro) =A0:) =A0But so
>>> long as you're just getting your own compile working, whatever
>>> gets you a working build is fine.
>>>
>>> What worries me, though, is the thought that the official
>>> 20100831 release has the wrong files in it! =A0Can you follow
>>> up on that with Subrata? =A0In particular, the c.c file is
>>> different from the one in ltp.git. =A0Something is going very
>>> wrong!
>>
>> Garret,
>>
>> Did we miss/drop something during our migration from ltp-dev.git to
>> ltp.git ?
>
> =A0 =A0No... I pushed all of the content from ltp-dev.git up to ltp.git.

    BTW...

$ git status c.c
# On branch master
nothing to commit (working directory clean)
$ diff ~/Downloads/ltp-full-20100831/testcases/kernel/security/filecaps/c.c
  c.c
$ echo $?
0

    So I'm not sure what Serge was looking at...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security =

easier or more difficult to achieve? Read this whitepaper to separate the =

two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
