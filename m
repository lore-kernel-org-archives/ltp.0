Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OsrlD-0006Jj-IO
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 06:34:27 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OsrlC-0004rh-Kf
	for ltp-list@lists.sourceforge.net; Tue, 07 Sep 2010 06:34:27 +0000
Received: by bwz12 with SMTP id 12so5013708bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Sep 2010 23:34:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimtsukr=vdq9TRL62LUdfdcy2k79cTvEJQ1xmi+@mail.gmail.com>
References: <AANLkTi=ShuJOPjaywptWgDaFFG9zhb_uk=_42bpwSavA@mail.gmail.com>
	<AANLkTi=9PFi3k0eEyYO_SvwBsOK77CBECXkrWLy7rkhY@mail.gmail.com>
	<AANLkTinAQARYsEWv6jbezg=-J=xBZM3UXnWfOSz++Lto@mail.gmail.com>
	<AANLkTinDeS1ODKGwEtwRed0H57e3vyzjqQB8nnv_Cn4G@mail.gmail.com>
	<AANLkTimtsukr=vdq9TRL62LUdfdcy2k79cTvEJQ1xmi+@mail.gmail.com>
Date: Mon, 6 Sep 2010 23:34:20 -0700
Message-ID: <AANLkTi=hm5FFVuBpXBtFTGn-bah4ypf1CQeW02C9pV9b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ld01
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
To: Deepti Thite <dthite@in.mvista.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Mon, Sep 6, 2010 at 9:05 PM, Deepti Thite <dthite@in.mvista.com> wrote:
> Hi Garrett,
>
> We execute ltp tests on different architectures like arm, mips, etc., hen=
ce
> hardcoding the absolute path=A0 will not work on all=A0 architectures. So=
 I came
> up with the patch as a generic solution to it.

But this isn't a generic solution. If it was a generic solution it
would cover not only gcc, but icc, clang, bcc, etc.

Fixing the Montavista infrastructure to report reasonable values for
CC, LD, etc isn't hard. I've done similar stuff many times before. It
shouldn't take you more than 2 lines, and it will fix a number of
other potential issues in LTP.

FWIW I think that the commands/ade testcases add little value, and
honestly they should be removed from ltp and moved into binutils, as
they're incredibly binutils centric, and they control their messages
better than we do.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
