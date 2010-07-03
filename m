Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OV70Y-0003ZU-8h
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:00:06 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OV70W-0002gN-0P
	for ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 18:00:06 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1278082240.6654.51.camel@moss-pluto.epoch.ncsc.mil>
References: <20100629195210.GA14549@hallyn.com>
	<1277900005.5710.8.camel@subratamodak.linux.ibm.com>
	<1277909544.21903.142.camel@moss-pluto.epoch.ncsc.mil>
	<1278003976.21642.4.camel@subratamodak.linux.ibm.com>
	<1278008699.15753.195.camel@moss-pluto.epoch.ncsc.mil>
	<20100701195352.GA26918@hallyn.com>
	<1278082240.6654.51.camel@moss-pluto.epoch.ncsc.mil>
Date: Sat, 03 Jul 2010 23:29:51 +0530
Message-Id: <1278179992.7665.14.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] selinux testsuite
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>, James Morris <jmorris@redhat.com>, kaigai@ak.jp.nec.com, SELinux <selinux@tycho.nsa.gov>, Jeff Burke <jburke@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>

On Fri, 2010-07-02 at 10:50 -0400, Stephen Smalley wrote:
> On Thu, 2010-07-01 at 14:53 -0500, Serge E. Hallyn wrote:
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > On Thu, 2010-07-01 at 22:36 +0530, Subrata Modak wrote:
> > > > On Wed, 2010-06-30 at 10:52 -0400, Stephen Smalley wrote: 
> > > > > On Wed, 2010-06-30 at 17:43 +0530, Subrata Modak wrote:
> > > > > > Hi Serge,
> > > > > > 
> > > > > > On Tue, 2010-06-29 at 14:52 -0500, Serge E. Hallyn wrote:
> > > > > > > Just a little note to announce that the selinux testsuite is now up as a
> > > > > > > git tree at kernel.org.  You can fetch it using
> > > > > > > 
> > > > > > > 	git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
> > > > > > 
> > > > > > Great. So, how far does it differ from that we have in LTP ?
> > > > > > http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=tree;f=testcases/kernel/security/selinux-testsuite;h=066df4cdf2f8a80a0045e338b4bb2bf0f5d37091;hb=HEAD
> > > > > > 
> > > > > > As you, Stephen and others in SELinux <selinux@tycho.nsa.gov> were the
> > > > > > main contributors to the SELinux test(s) in LTP, i guess the next/future
> > > > > > development for SELinux tests will be happening in the new tree.
> > > > > > 
> > > > > > So, i would rather keep pulling to LTP from your tree. Now, could you
> > > > > > please let me know:
> > > > > > 
> > > > > >      1. Whether the new tree contains all scenarios which is present in
> > > > > >         LTP. In such a case a complete pruning of LTP SELinux tests can
> > > > > >         be done and replaced with your tree contents,
> > > > > >      2. If some of the LTP tests are not there, then i would like to
> > > > > >         retain them in LTP side-by-side your tree contents,
> > > > > 
> > > > > The new tree contains all of the selinux tests present in the LTP.  You
> > > > > cannot however simply replace the ltp version of the tests with this
> > > > > tree, as this tree is a standalone testsuite and will not run within the
> > > > > ltp test harness. This testsuite is based on the original standalone
> > > > > selinux testsuite that was contributed by us to IBM to port to the LTP.
> > > > > We have internally maintained this testsuite in parallel to the ltp
> > > > > version as we have found it easier to set up, use, debug, and maintain.
> > > > 
> > > > Thanks Stephen. Since you have maintained the Original-One Internally
> > > > and have simultaneously contributed changes to the LTP-version of
> > > > SELinux, i am depending on you/Serge/SELinux-Mailing-List-members to
> > > > keep sending patches to LTP to update the LTP-version at regular
> > > > intervals (off-course at your convenience ;-))
> > > 
> > > I think that will depend on whether there is some benefit to maintaining
> > > the ltp version.  We might derive some benefit if the ltp selinux
> > > testsuite were better integrated (e.g. tests run by default if SELinux
> > > is enabled on the host) and if the tests got some regular attention from
> > > the ltp maintainers.  Otherwise, it may be better to just remove the
> > > tests from the ltp and point people to the standalone version.
> > 
> > I don't object to the tests being maintained in LTP.  But so far, AFAICS,
> > the cost of maintaining in LTP far outweighs the benefits.
> > 
> > So I'd like to know, does anyone (IBM?) *use* the version in LTP for
> > automated testing?
> > 
> > If not, heck we could replace ltp/testcases/kernel/security/selinux/*
> > with a script that git clones the testsuite and runs it.
> > 
> > Mind you it's not the selinux tests per se - it's the random bulk LTP
> > updates which then break selinux tests, or worse, the autoconf cruft
> > to try to detect whether the user wants selinux tests - which constitute
> > the real maintenance cost.
> > 
> > If someone who uses the LTP selinux tests could step up and offer
> > to periodically run the tests and work with (me and) the community
> > to push fixes, I'll be happy to help out.
> 
> (cc'd Jeff Burke as I know he has run the ltp selinux tests in the past
> on RHEL and has contributed patches in the past)
> 
> Jeff - see above for context.  Do you still run the ltp selinux tests on
> a regular basis?  Are you interested in helping to maintain them and
> ideally to better integrate them into the LTP so that they will be run
> by default (if SELinux is enabled) and exercised by the regular ltp

I would prefer integrating it in the default LTP run. And then run it if
SELinux is enabled. That way everybody would probably execute SELinux in
their regular test cycle and report issues, helping us in addressing and
keeping these tests alive.

Regards--
Subrata

> maintainers?  Or are you just as happy to clone the separate standalone
> selinux testsuite and run that as part of QA, separate from ltp testing?
> 


------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
