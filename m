Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <lmr@redhat.com>) id 1QESQp-0000Mc-Fk
	for ltp-list@lists.sourceforge.net; Mon, 25 Apr 2011 20:30:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QESQo-0007zg-Hj
	for ltp-list@lists.sourceforge.net; Mon, 25 Apr 2011 20:30:55 +0000
From: Lucas Meneghel Rodrigues <lmr@redhat.com>
Date: Mon, 25 Apr 2011 16:20:21 -0300
In-Reply-To: <1303738356.4244.67.camel@moss-pluto>
References: <1303477727.18220.15.camel@moss-pluto>
	<4DB1E88D.2030808@linux.vnet.ibm.com>
	<1303738356.4244.67.camel@moss-pluto>
Message-ID: <1303759223.2325.11.camel@freedom>
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, 2011-04-25 at 09:32 -0400, Stephen Smalley wrote:

> At present we see no benefit, only cost, to maintaining the selinux
> testsuite in the ltp as it is regularly broken by unrelated changes
> elsewhere in the ltp and as it is not truly integrated into the ltp (you
> have to perform separate steps to build and run it).  In comparison, we
> don't have to worry about unrelated changes breaking the standalone
> selinux testsuite, and it is certainly no harder to do this:
> 
> git clone git://git.kernel.org/pub/scm/tests/selinux-testsuite
> cd selinux-testsuite
> sudo make test
> 
> than to do this:
> 
> git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
> cd ltp
> make autotools
> ./configure
> make all
> make install
> cd testcases/kernel/security/selinux-testsuite
> make all
> make install
> cd /opt/ltp
> ./testscripts/test_selinux.sh
> 
> If the selinux testsuite were fully integrated into the ltp (e.g. built
> and run by default if SELinux is enabled on the system), then that might
> be more worthwhile to keep it as part of the ltp.  But in the 6 years
> since it was added to the ltp, that hasn't happened. 

+1 for this. In the end of the day, what matters for a software project
is maintenance. Since we have a working, maintained git repo with the
selinux testsuite, it's better than having it half integrated with LTP,
so the better choice here IMHO is to just remove it from the LTP tree.

I know LTP aims to be comprehensive, but this comprehensiveness has to
be achieved through tightly integrated code, no point in keeping
disconnected pieces of code in the tree, that will likely break and
bitrot. I wish I could commit in looking at all current testsuites
merged into LTP that need better integration so we can opt by:

1) Remove
2) Do what it takes to get it fully integrated in terms of API, build
system, workflow.

I am not an LTP maintainer so I feel like I'm meddling on other people's
business, however I thought it'd be worth to point this out... take it
with a grain of salt.

Cheers,

Lucas


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
