Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NSxxe-00057R-HT
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 19:23:58 +0000
Received: from msux-gh1-uea02.nsa.gov ([63.239.67.2])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSxxd-0006SY-Cd
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 19:23:58 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <364299f41001070105p3bf32bbdwff0edf9315c333da@mail.gmail.com>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
	<20100106185837.GA20097@us.ibm.com>
	<364299f41001070105p3bf32bbdwff0edf9315c333da@mail.gmail.com>
Date: Thu, 07 Jan 2010 14:23:29 -0500
Message-Id: <1262892209.2821.28.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Thu, 2010-01-07 at 01:05 -0800, Garrett Cooper wrote:
> On Wed, Jan 6, 2010 at 10:58 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> >> It seems the Makefile rewrite last October broke the selinux testsuite.
> >> Is it unreasonable to expect that someone who rewrote the Makefile would
> >> actually try running the testsuite?
> >>
> >> Please, revert the changes or fix them.
> >>
> >> See testcases/kernel/security/selinux-testsuite/README for the
> >> instructions.
> >
> > Ok, Garrett, two particular scripts that are broken since the move
> > to running out of /opt/ltp are
> >        test_robind.sh
> >        test_selinux.sh
> >
> > Guidance?
> 
>     I need output in order to judge what needs to be fixed. Gentoo
> doesn't have a selinux policy package (at least not in portage), thus
> I cannot run the tests as they're Redhat centric.

To start, we need to get the test policy to build again.

Bad:
$ cd testcases/kernel/security/selinux-testsuite/refpolicy/
$ make
(cd "/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy" && cat *.te) > "test_policy.te";
cat: test_policy.te: input file is output file
make: *** [test_policy.te] Error 1

Good:
$ cvs update -r1.7 Makefile 
P Makefile
# make
make[1]: Entering directory `/usr/share/selinux/devel'
rm -fR tmp
rm -f *.pp
Compiling targeted test_policy module
/usr/bin/checkmodule:  loading policy configuration from tmp/test_policy.tmp
/usr/bin/checkmodule:  policy configuration loaded
/usr/bin/checkmodule:  writing binary representation (version 10) to tmp/test_policy.mod
Creating targeted test_policy.pp policy package
rm tmp/test_policy.mod tmp/test_policy.mod.fc
make[1]: Leaving directory `/usr/share/selinux/devel'

I tried tweaking your Makefile to no avail.  Some obvious errors in the
new Makefile:
- It has mixed use of REDHAT_VERS and REDHAT_VER, POLICY_DEVEL and
POLICYDEVEL.
- test_bounds.te is only to be included if checkpolicy supports version
24, not filtered out in that case.
- Only test_policy.* is to be copied to $POLICYDEVEL, not the
individual .te files that are concatenated into it.
- test_policy.te should be regenerated every time or made conditional on
all of the individual .te files _and_ the directory (in case a .te file
is removed or added).  Less likely to miss if we just always regenerate
it as in the original makefile.

-- 
Stephen Smalley
National Security Agency


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
