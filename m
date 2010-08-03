Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Og9AN-0000B8-9B
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 04:31:51 +0000
Received: from out10.sjc.mx.trendmicro.com ([216.99.131.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Og9AL-00035f-SX
	for ltp-list@lists.sourceforge.net; Tue, 03 Aug 2010 04:31:51 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000a01cb2dfa$1ab62650$502272f0$@co.jp>	<AANLkTinA23XVdCGPffiRqVsNGHHCCje4PLcuvBg1sYTE@mail.gmail.com>	<000301cb2e17$cdb444e0$691ccea0$@co.jp>
	<AANLkTin=5dbgG=exOFBOm9Jx5EELLfSQp--ab6T=Vx5V@mail.gmail.com>
In-Reply-To: <AANLkTin=5dbgG=exOFBOm9Jx5EELLfSQp--ab6T=Vx5V@mail.gmail.com>
Date: Tue, 3 Aug 2010 13:31:40 +0900
Message-ID: <000d01cb32c4$c4946730$4dbd3590$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] How to run "conformance" tests?
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Wednesday, July 28, 2010 3:28 PM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] How to run "conformance" tests?
> =

> On Tue, Jul 27, 2010 at 10:43 PM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> >
> > I executed "make distclean" from "testcases/open_posix_testsuite"
> directory,
> >
> > and it secceeded.
> > I executed "make all", but it failed:
> >
> > ------------
> > [...]
> > make[2]: Entering directory
> > `/home/LTP/ltp-dev-20100727/testcases/open_posix_testsuite/str
> > ess'
> > make[2]: Leaving directory
> > `/home/LTP/ltp-dev-20100727/testcases/open_posix_testsuite/stre
> > ss'
> > Generating buildonly Makefiles
> > sed: invalid option -- E
> =

> This is the problem. I leaked a non-POSIX extension into the Makefile
> generator by accident. Let me think up a solution for this...
> =

> > Usage: sed [OPTION]... {script-only-if-no-other-script}
> [input-file]...
> >
> > =A0-n, --quiet, --silent
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suppress automatic printing of pattern =
space
> > =A0-e script, --expression=3Dscript
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add the script to the commands to be ex=
ecuted
> > [...]
> > If no -e, --expression, -f, or --file option is given, then the first
> > non-option argument is taken as the sed script to interpret. =A0All
> > remaining arguments are names of input files; if no input files are
> > specified, then the standard input is read.
> >
> > E-mail bug reports to: bonzini@gnu.org .
> > Be sure to include the word ``sed'' somewhere in the ``Subject:''
> field.
> > sed: invalid option -- E
> > Usage: sed [OPTION]... {script-only-if-no-other-script}
> [input-file]...
> > [...]
> > ------------
> >
> > In this time, I used latest git
> > "ltp-dev-3393cd192002793080aba661054d54a8a06f25c2.tar.gz"
> >
> >
> >> Your make version would help too.
> >
> > My make version is 3.81.
> > Gcc version is 4.1.2.
> >
> >
> > Regards--
> >
> > -Tomonori Mitani
> >
> >
> >> -----Original Message-----
> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> Sent: Wednesday, July 28, 2010 11:38 AM
> >> To: Mitani
> >> Cc: ltp-list@lists.sourceforge.net
> >> Subject: Re: [LTP] How to run "conformance" tests?
> >>
> >> On Tue, Jul 27, 2010 at 7:10 PM, Mitani <mitani@ryobi.co.jp> wrote:
> >> > Hi,
> >> >
> >> >
> >> > I want to run "conformance" testcases in "open_posix_testsuite".
> >> > But I couldn't run it without manually copying.
> >> >
> >> > I used
> "ltp-dev-a4e64cb8bb97d09b5695151106946a76984b330a.tar.gz"
> >> git.
> >> > Environment is RHEL5.5 and x86_64 architecture.
> >> >
> >> > First, I executed following commands.
> >> > =A0make autotools
> >> > =A0configure
> >> > =A0make
> >> > =A0make install
> >> > And I confirmed that those commands succeeded.
> >> > And I could see "logfile.conformance-all" file in
> >> "${LTPROOT}/testcases
> >> > /open_posix_testsuite" directory.
> >> >
> >> > I ran "make conformance-test" command. But it failed as follows:
> >>
> >> Can you try running the following please from
> >> testcases/open_posix_testsuite?
> >>
> >> make distclean
> >> make all
> >> make test
> >>
> >> Your make version would help too.


Garrett,

I succeeded to build by using recent git.

   ltp-dev-33df225de41edcc3213535f249548acc937647a2.tar.gz

Thank you!

Regards--


-Tomonori Mitani



---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
