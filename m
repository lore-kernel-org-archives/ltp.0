Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PX5cX-0004BA-B5
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 05:27:45 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PX5cW-0002i2-2N
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 05:27:45 +0000
Date: Mon, 27 Dec 2010 00:27:33 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1885427080.85283.1293427653101.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <3733F585-4591-4813-A34B-6B47C9D665B6@gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH]Fix building error.
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
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> On Dec 22, 2010, at 11:02 PM, CAI Qian <caiqian@redhat.com> wrote:
> 
> >
> >> However, many people use the LTP to test their own linux system, if
> >> those kernel
> >> is not support KSM, at least we should make sure they can build
> >> successfully.
> > In that case, why not use an older version?
> 
> Implementing the fix is trivial. Please write some autoconf tests for
> KSM, et all.
Garrett, yes, it is trivial. If we are going to fix here, there are many
other similar places need the fix too. It adds much headaches and code to
support old distros like RHEL5 and RHEL4. There are also so many distros
and custom kernels out there and there is no way to move anything forwards
to support those including embedded. For examples,

1) AC_PREREQ(2.61) in ltp/configure.ac: this won't support old distros anyway.
2) Even if the test has MADV_MERGEABLE defined, the kernel can still use
   the old interfaces other than the new implementation, so the test will
   definitely broke.
3) if the kernels are buggy, the test will fail as well. It is not scalable
   to fix the test in this case.
4) there are many arches/kernel configuration out there which the new tests
   are not going to compile on them all.

I think it is not a problem for me to fix the compilation here for RHEL5, but
we are still lack of supporting matrix for LTP which has been brought up many
times before without a consensus.

Here is something a proposal going forwards when submitting new tests:
1) compiling tests passed for the current 2.6.x oldest stable release (2.6.27.57)
2) compiling tests passed for tool-chains (autoconf, make etc) at least released
   as old as the current 2.6.x stable kernel base release (2.6.27 was released in
   Oct 2008; Autoconf 2.63 was released in Sep. 2008 so it should be supported).
3) the tests should give clearly indication of TPASS/TFAIL/TCONF for the current
   2.6.x oldest stable kernel release.

CAI Qian

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
