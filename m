Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVW1b-0005JX-HT
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 20:10:35 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVW1a-00078b-L3
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 20:10:35 +0000
Received: by pxi38 with SMTP id 38so659214pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 12:10:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263478021.8548.3.camel@moss-pluto.epoch.ncsc.mil>
References: <364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<1263390194.31509.4.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131052s27019ebl53f4e3f76bb4598e@mail.gmail.com>
	<1263410323.901.5.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131137j36d1c665r45cb8b6163263428@mail.gmail.com>
	<1263412198.901.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100113220021.GA838@us.ibm.com>
	<1263420212.901.64.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131449w751889b8r98aca16ea1e8957a@mail.gmail.com>
	<1263478021.8548.3.camel@moss-pluto.epoch.ncsc.mil>
Date: Thu, 14 Jan 2010 12:10:28 -0800
Message-ID: <364299f41001141210o49c97980yc703601e7340362f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] regression: selinux testsuite broken since October
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>, ltp-list@lists.sourceforge.net

On Thu, Jan 14, 2010 at 6:07 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2010-01-13 at 14:49 -0800, Garrett Cooper wrote:
>> Which is what it's doing now, but the original author of the test
>> wrote the load logic and unload logic so that it used make instead of
>> using a bourne shell script, etc.
>
> To clarify, there are two things happening under that load target
> presently, one of which is properly handled at build time and one of
> which is properly handled at test execution time. =A0The first part is
> building test_policy.pp. =A0The latter is running semodule -i
> test_policy.pp. =A0So we could split up the Makefile so that the first
> part is done by the make all/install, and test_selinux.sh merely runs
> semodule -i test_policy.pp before the test and semodule -r test_policy
> after the test. =A0One other item I notice is that the current logic
> copies test_policy* to $POLICY_DEVEL_DIR and runs make there, which
> isn't necessary - you could just leave them in the refpolicy directory
> and run make -f $POLICY_DEVEL_DIR/Makefile test_policy.pp.

Ok, this is interesting. So -- is there any particular reason why
clean (which in this case just called cleanup) should be called before
load?

So at the end of the day, all of the junk done as part of `load' could
in fact be done in test_selinux.sh // runtests.sh (I assume the only
step that couldn't be done is semodule -i? I don't have any hard
feelings for not putting that logic in those scripts...

>> The other thing that's kind of amusing is that its setup / teardown
>> isn't very robust -- I could send a signal, or the process could get
>> terminated leaving the test policy files hanging around the system
>> under test. That's a side issue but it's also another good reason to
>> migrate away from this make paradigm for setup / teardown -_-...

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
