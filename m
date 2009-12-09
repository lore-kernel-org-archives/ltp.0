Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NIEjX-0006PS-Qe
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 05:05:03 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NIEjQ-0002gD-0y
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 05:05:03 +0000
Received: by pwi13 with SMTP id 13so1139555pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Dec 2009 21:04:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b9d696240912081359p57e3bfdck6b76d88cfe7e2852@mail.gmail.com>
References: <1260241019.1107.17.camel@plars-t500>
	<b9d696240912081359p57e3bfdck6b76d88cfe7e2852@mail.gmail.com>
Date: Tue, 8 Dec 2009 21:04:49 -0800
Message-ID: <364299f40912082104i18451b1amd36a95f45754505@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] make install... doesn't
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Tue, Dec 8, 2009 at 1:59 PM, K.D. Lucas <kdlucas@gmail.com> wrote:
> I've noticed the same. It used to be that I could easily build and run LT=
P,
> but now I build fine, but running has become an issue. I've typically ran
> the LTP suite against every kernel that our [my company] various project
> teams create; however, with the last few releases I've tended not to use =
it.
>
> It used to be that when I built LTP, I could run it from the same directo=
ry,
> but that is no longer true. With November's release I can't run it period.
>
> kdl
>
> On Mon, Dec 7, 2009 at 6:56 PM, Paul Larson <paul.larson@canonical.com>
> wrote:
>>
>> Was trying to build ltp today, which sadly, seems to be a bit more
>> complicated than it once was. =A0The make install completed without
>> errors, but noticed at the end that I didn't even have a testcases/bin
>> directory! =A0As I watched the make install output I noticed that
>> everything in testcases was getting built with the 'all' target, but
>> never install.
>>
>> My make-foo is quite rusty, but I'm guessing that this change from
>> changeset b2e46ed73e9601ecad1044d37a85c97ba0ca42ce (if you are following
>> git, It was from around Nov 30 if not) seems to be a likely culprit:
>> -.SECONDEXPANSION:
>> -$(INSTALL_TARGETS) include-install lib-install: %-install:
>> $(abs_top_builddir)/$$*
>> - =A0 =A0 =A0 $(MAKE) -C $* -f "$(abs_top_srcdir)/$*/Makefile" install
>> +$(INSTALL_TARGETS) include-install lib-install:
>> + =A0 =A0 =A0 $(MAKE) -C "$(subst -install,,$@)" \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 -f "$(abs_top_srcdir)/$(subst -install,,$@=
)/Makefile"
>> all

KD,
    Please provide your development usecase requirements that the
current make system doesn't allow so I can either 1) suggest an
alternative method to solve your problem, and/or 2) add needed support
to enable you to do what you need to do in LTP.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
