Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <sds@tycho.nsa.gov>) id 1QEiCj-00089h-3c
	for ltp-list@lists.sourceforge.net; Tue, 26 Apr 2011 13:21:25 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.65.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QEiCd-0006fz-L0
	for ltp-list@lists.sourceforge.net; Tue, 26 Apr 2011 13:21:25 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <96AA5F80-E871-4368-BEB7-BC9FA24FFABD@gmail.com>
References: <1303477727.18220.15.camel@moss-pluto>
	<4DB1E88D.2030808@linux.vnet.ibm.com>
	<1303738356.4244.67.camel@moss-pluto>
	<96AA5F80-E871-4368-BEB7-BC9FA24FFABD@gmail.com>
Date: Tue, 26 Apr 2011 09:21:10 -0400
Message-ID: <1303824070.4244.102.camel@moss-pluto>
Mime-Version: 1.0
Subject: Re: [LTP] selinux-testsuite has moved
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
Cc: ltp-list <ltp-list@lists.sf.net>, Serge Hallyn <serge@hallyn.com>

On Mon, 2011-04-25 at 12:38 -0700, Garrett Cooper wrote:
> On Apr 25, 2011, at 6:32 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > At present we see no benefit, only cost, to maintaining the selinux
> > testsuite in the ltp as it is regularly broken by unrelated changes
> > elsewhere in the ltp and as it is not truly integrated into the ltp (you
> > have to perform separate steps to build and run it).  In comparison, we
> > don't have to worry about unrelated changes breaking the standalone
> > selinux testsuite, and it is certainly no harder to do this:
> > 
> > git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
> > cd selinux-testsuite
> > sudo make test
> > 
> > than to do this:
> > 
> > git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
> > cd ltp
> > make autotools
> > ./configure
> > make all
> > make install
> > cd testcases/kernel/security/selinux-testsuite
> > make all
> > make install
> > cd /opt/ltp
> > ./testscripts/test_selinux.sh
> > 
> > If the selinux testsuite were fully integrated into the ltp (e.g. built
> > and run by default if SELinux is enabled on the system), then that might
> > be more worthwhile to keep it as part of the ltp.  But in the 6 years
> > since it was added to the ltp, that hasn't happened.
> 
> Do what's easiest for you guys to maintain upstream; what you suggested makes sense: pull from git and run selinux as-is. The twist I'm proposing here is as follows:
> 1. The selinux test suite needs to be made modular and portable. I'll provide you with autoconf/other patches sometime after I get back from vacation on friday.
> 2. I'll add logic to pull from git in ltp, which means the following: releases will come with the selinux test suite; archives and other non-release mechanisms won't. Thus, if you want to run the selinux testcases, you will need git, and will have to specify --with-selinux=yes when running configure, etc.
> 
> Sound ok?

Not sure what modularity or portability problems you see in the
testsuite, but I think autotools would be overkill and just make
maintenance harder.  If by modularity you mean the ability to run tests
individually, that is already possible, and if by portability you mean
the ability to build and run the tests on the various architectures, I
believe that also is already covered.  We certainly don't have to
concern ourselves with portability to other OSes, as the selinux
testsuite is by definition specific to Linux.

-- 
Stephen Smalley
National Security Agency


------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
