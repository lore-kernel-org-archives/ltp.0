Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OUhlh-0006xu-6j
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 15:03:05 +0000
Received: from mail-pw0-f46.google.com ([209.85.160.46])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OUhlg-0003uG-BG
	for ltp-list@lists.sourceforge.net; Fri, 02 Jul 2010 15:03:05 +0000
MIME-Version: 1.0
In-Reply-To: <1278082240.6654.51.camel@moss-pluto.epoch.ncsc.mil>
References: <20100629195210.GA14549@hallyn.com>
	<1277900005.5710.8.camel@subratamodak.linux.ibm.com>
	<1277909544.21903.142.camel@moss-pluto.epoch.ncsc.mil>
	<1278003976.21642.4.camel@subratamodak.linux.ibm.com>
	<1278008699.15753.195.camel@moss-pluto.epoch.ncsc.mil>
	<20100701195352.GA26918@hallyn.com>
	<1278082240.6654.51.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 2 Jul 2010 08:02:57 -0700
Message-ID: <AANLkTimM3p26aPBbX8Gub-FUomhqKr49qEp-GJQbAhNH@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] selinux testsuite
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
Cc: James Morris <jmorris@redhat.com>, ltp-list <ltp-list@lists.sf.net>, kaigai@ak.jp.nec.com, SELinux <selinux@tycho.nsa.gov>, Jeff Burke <jburke@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>

On Fri, Jul 2, 2010 at 7:50 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2010-07-01 at 14:53 -0500, Serge E. Hallyn wrote:
>> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> > On Thu, 2010-07-01 at 22:36 +0530, Subrata Modak wrote:
>> > > On Wed, 2010-06-30 at 10:52 -0400, Stephen Smalley wrote:
>> > > > On Wed, 2010-06-30 at 17:43 +0530, Subrata Modak wrote:
>> > > > > Hi Serge,
>> > > > >
>> > > > > On Tue, 2010-06-29 at 14:52 -0500, Serge E. Hallyn wrote:
>> > > > > > Just a little note to announce that the selinux testsuite is n=
ow up as a
>> > > > > > git tree at kernel.org. =A0You can fetch it using
>> > > > > >
>> > > > > > =A0 =A0 git clone git://git.kernel.org/pub/scm/tests/selinux-t=
estsuite
>> > > > >
>> > > > > Great. So, how far does it differ from that we have in LTP ?
>> > > > > http://ltp.git.sourceforge.net/git/gitweb.cgi?p=3Dltp/ltp-dev.gi=
t;a=3Dtree;f=3Dtestcases/kernel/security/selinux-testsuite;h=3D066df4cdf2f8=
a80a0045e338b4bb2bf0f5d37091;hb=3DHEAD
>> > > > >
>> > > > > As you, Stephen and others in SELinux <selinux@tycho.nsa.gov> we=
re the
>> > > > > main contributors to the SELinux test(s) in LTP, i guess the nex=
t/future
>> > > > > development for SELinux tests will be happening in the new tree.
>> > > > >
>> > > > > So, i would rather keep pulling to LTP from your tree. Now, coul=
d you
>> > > > > please let me know:
>> > > > >
>> > > > > =A0 =A0 =A01. Whether the new tree contains all scenarios which =
is present in
>> > > > > =A0 =A0 =A0 =A0 LTP. In such a case a complete pruning of LTP SE=
Linux tests can
>> > > > > =A0 =A0 =A0 =A0 be done and replaced with your tree contents,
>> > > > > =A0 =A0 =A02. If some of the LTP tests are not there, then i wou=
ld like to
>> > > > > =A0 =A0 =A0 =A0 retain them in LTP side-by-side your tree conten=
ts,
>> > > >
>> > > > The new tree contains all of the selinux tests present in the LTP.=
 =A0You
>> > > > cannot however simply replace the ltp version of the tests with th=
is
>> > > > tree, as this tree is a standalone testsuite and will not run with=
in the
>> > > > ltp test harness. This testsuite is based on the original standalo=
ne
>> > > > selinux testsuite that was contributed by us to IBM to port to the=
 LTP.
>> > > > We have internally maintained this testsuite in parallel to the ltp
>> > > > version as we have found it easier to set up, use, debug, and main=
tain.
>> > >
>> > > Thanks Stephen. Since you have maintained the Original-One Internally
>> > > and have simultaneously contributed changes to the LTP-version of
>> > > SELinux, i am depending on you/Serge/SELinux-Mailing-List-members to
>> > > keep sending patches to LTP to update the LTP-version at regular
>> > > intervals (off-course at your convenience ;-))
>> >
>> > I think that will depend on whether there is some benefit to maintaini=
ng
>> > the ltp version. =A0We might derive some benefit if the ltp selinux
>> > testsuite were better integrated (e.g. tests run by default if SELinux
>> > is enabled on the host) and if the tests got some regular attention fr=
om
>> > the ltp maintainers. =A0Otherwise, it may be better to just remove the
>> > tests from the ltp and point people to the standalone version.
>>
>> I don't object to the tests being maintained in LTP. =A0But so far, AFAI=
CS,
>> the cost of maintaining in LTP far outweighs the benefits.
>>
>> So I'd like to know, does anyone (IBM?) *use* the version in LTP for
>> automated testing?
>>
>> If not, heck we could replace ltp/testcases/kernel/security/selinux/*
>> with a script that git clones the testsuite and runs it.
>>
>> Mind you it's not the selinux tests per se - it's the random bulk LTP
>> updates which then break selinux tests, or worse, the autoconf cruft
>> to try to detect whether the user wants selinux tests - which constitute
>> the real maintenance cost.
>>
>> If someone who uses the LTP selinux tests could step up and offer
>> to periodically run the tests and work with (me and) the community
>> to push fixes, I'll be happy to help out.
>
> (cc'd Jeff Burke as I know he has run the ltp selinux tests in the past
> on RHEL and has contributed patches in the past)
>
> Jeff - see above for context. =A0Do you still run the ltp selinux tests on
> a regular basis? =A0Are you interested in helping to maintain them and
> ideally to better integrate them into the LTP so that they will be run
> by default (if SELinux is enabled) and exercised by the regular ltp
> maintainers? =A0Or are you just as happy to clone the separate standalone
> selinux testsuite and run that as part of QA, separate from ltp testing?

    I'll do my best to assist as a resource too for you guys in the
integration effort.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
