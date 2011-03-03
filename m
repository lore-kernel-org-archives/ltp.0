Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <qcai@redhat.com>) id 1PuxjH-0008Mm-7U
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 01:53:23 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PuxjG-0001Zy-3U
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 01:53:23 +0000
Date: Wed, 2 Mar 2011 20:52:37 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1469445745.266603.1299117157337.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1299068635.4463.1.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 FEBRUARY 2011.
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net, vapier@gentoo.org, linux-kernel@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, akpm@linux-foundation.org, torvalds@linux-foundation.org


> There was discussion like this some few years back. The idea was to get
> some core tests from LTP to the kernel source tree. But then the idea
> was dropped probably to avoid maintenance overhead ;-)
Where are the places in kernel source tree for those?

Those days, there just too many tests and testing projects for kernel like
LTP, autotest, xfstests and so on. Why not have somewhere to collabrate and
then to extract the best?

LTP has so many goals and focus which isn't going to be only to test kernel
any more and it is increasing difficult to support so many distros, kernel
versions, and so on.

There are some CORE tests like memory management tests, ksm, oom etc have
benefit from the developers' bless and review. It also need to be updated
to keep the tests relevant to the current git tree, since the features/specs
are changing consistent inside the kernel.

This could be also useful to improve the kernel quality by providing test
code inside the kernel tree that to be used during the code review process
that for example, a ksm patchset needs to pass that particular sanity tests
in order to catch the regression. It provide benefit that when the changelog
said that it passed the ksm tests inside the kernel, we knew exactly what it is
without needing to sync up with another project like LTP.

In term of maintenance, it needs to be selectively which tests need to be
inside the kernel. There should ideally have a dedicated maintainer from the
testing point of view to review them. The criteria can be something like,

1) purely purpose of the tests are to test kernel written in C with the kernel
   coding style. Userspace and integration tests should be better to put into
   LTP and other projects.
2) tests need to pass sub-system maintainers' review that for example, ksm
   tests need MM sub-system maintainers' review-by and sign-off-by and alike.
3) they need to be working with and sync up to the latest git version.
4) they have to be proved to be the best tests we can have to test those
   particular kernel code. There are many tests in LTP, but there are also
   many duplicated tests as well. Those need to be solved when considering to
   be moved inside the kernel source.
5) they should really be functional testing. Non-functional tests like stress
   or performance tests are usually more complex to setup hence defeat the
   purpose of quick regression checking.

Once we have those tests in-place, the next step to improve the kernel quality
is to have more patches had Tested-by tags before been accepted in the kernel
git tree. Those testers can simply use the non-ambiguious references for tests
provided by those in-kernel tests.

In addition, those could be a follow-up items with the kernel regression reports
that after fixed/analyzed a regression in kernel, the next natural thing to do
is to fix/add missing tests to close this gap in the future by providing efficient
tests to our users if all possible.

CAI Qian

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
