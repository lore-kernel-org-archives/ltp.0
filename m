Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OdwWf-00038Y-Sa
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 02:37:45 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OdwWf-0005ov-7j
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 02:37:45 +0000
Received: by iwn34 with SMTP id 34so5741783iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Jul 2010 19:37:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000a01cb2dfa$1ab62650$502272f0$@co.jp>
References: <000a01cb2dfa$1ab62650$502272f0$@co.jp>
Date: Tue, 27 Jul 2010 19:37:39 -0700
Message-ID: <AANLkTinA23XVdCGPffiRqVsNGHHCCje4PLcuvBg1sYTE@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jul 27, 2010 at 7:10 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
>
> I want to run "conformance" testcases in "open_posix_testsuite".
> But I couldn't run it without manually copying.
>
> I used "ltp-dev-a4e64cb8bb97d09b5695151106946a76984b330a.tar.gz" git.
> Environment is RHEL5.5 and x86_64 architecture.
>
> First, I executed following commands.
> =A0make autotools
> =A0configure
> =A0make
> =A0make install
> And I confirmed that those commands succeeded.
> And I could see "logfile.conformance-all" file in "${LTPROOT}/testcases
> /open_posix_testsuite" directory.
>
> I ran "make conformance-test" command. But it failed as follows:

Can you try running the following please from testcases/open_posix_testsuit=
e?

make distclean
make all
make test

Your make version would help too.

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share =

of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
