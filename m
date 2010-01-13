Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVC1o-0004xd-Ml
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 22:49:28 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVC1n-0004zl-Me
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 22:49:28 +0000
Received: by pwj11 with SMTP id 11so3844266pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Jan 2010 14:49:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263420212.901.64.camel@moss-pluto.epoch.ncsc.mil>
References: <364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<1263323555.16277.11.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001122251v49ec2743j6c57ada7bd6eaf3f@mail.gmail.com>
	<1263390194.31509.4.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131052s27019ebl53f4e3f76bb4598e@mail.gmail.com>
	<1263410323.901.5.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131137j36d1c665r45cb8b6163263428@mail.gmail.com>
	<1263412198.901.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100113220021.GA838@us.ibm.com>
	<1263420212.901.64.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 13 Jan 2010 14:49:21 -0800
Message-ID: <364299f41001131449w751889b8r98aca16ea1e8957a@mail.gmail.com>
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
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Wed, Jan 13, 2010 at 2:03 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2010-01-13 at 16:00 -0600, Serge E. Hallyn wrote:
>> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> > On Wed, 2010-01-13 at 11:37 -0800, Garrett Cooper wrote:
>> > > Yeah, you're right. I was trying to beat around this bush by not
>> > > copying these over, but it's better to have the test running and be
>> > > improperly designed than it is for regressions to leak by today, unt=
il
>> > > the day comes where these items are fixed.
>> > >
>> > > 1. So, Makefile is now copied over by default.
>> > > 2. load is no longer done as part of all / install (test_selinux.sh
>> > > was performing that function).
>> > >
>> > > So once the tests have been written to make and install independent =
of
>> > > selinux-devel, etc... we'll be in good shape and I will switch these
>> > > back to all / install dependent targets. I was trying to do it that
>> > > way to avoid requiring make on the target under test, but I need to
>> > > better understand the subject matter under test before we get to that
>> > > point.
>> >
>> > Unfortunately, as the Makefile now includes other .mk files and those
>> > are not copied over, it still doesn't work.
>> >
>> > Makefile:25: ../../../../../include/mk/env_pre.mk: No such file or dir=
ectory
>> > make: ../../../../../scripts/detect_distro.sh: Command not found
>> > Makefile:90: ../../../../../include/mk/generic_leaf_target.mk: No such=
 file or directory
>> > make: *** No rule to make target `../../../../../include/mk/generic_le=
af_target.mk'. =A0Stop.
>> > Failed to build and load test_policy module, aborting test run.
>> > /etc/selinux /opt/ltp/testcases/kernel/security/selinux-testsuite/refp=
olicy
>> > /opt/ltp/testcases/kernel/security/selinux-testsuite/refpolicy
>> >
>> > I suppose you could perform the make load as part of all/install
>> > (preferably install as we really shouldn't need to be root to run make
>> > all - although that no longer seems to be the case for the main ltp
>> > either), and drop it from test_selinux.sh. =A0But then they will need =
to
>> > know/remember to remove the test policy when finished testing.
>>
>> But really the compile stage should just create test_policy.pp,
>> which the testsuite can load and unload, right?
>
> Yes, that should work.

Which is what it's doing now, but the original author of the test
wrote the load logic and unload logic so that it used make instead of
using a bourne shell script, etc.

The other thing that's kind of amusing is that its setup / teardown
isn't very robust -- I could send a signal, or the process could get
terminated leaving the test policy files hanging around the system
under test. That's a side issue but it's also another good reason to
migrate away from this make paradigm for setup / teardown -_-...

Thanks,
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
