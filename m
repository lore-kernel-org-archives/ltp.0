Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NURNL-0002p8-LQ
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 21:00:35 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NURNK-0002j2-Sm
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 21:00:35 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0BKqH36003986
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 13:52:17 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0BL0A6O165214
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 14:00:10 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0BL076n025174
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 14:00:07 -0700
Date: Mon, 11 Jan 2010 15:00:06 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100111210006.GA26554@us.ibm.com>
References: <1262976627.20881.6.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081408sf9d740ew55dad7b542463416@mail.gmail.com>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com>
	<20100111205858.GA26412@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20100111205858.GA26412@us.ibm.com>
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list@lists.sourceforge.net, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Serge E. Hallyn (serue@us.ibm.com):
> > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
> > > > > Fails with:
> > > > > cp: cannot stat
> > > > > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/policy_files/generic/test_policy.*': No such file or directory
> > > > 
> > > > You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
> > > > 
> > > > I think we are supposed to actually be running
> > > > /opt/ltp/testscripts/test_selinux.sh.  So then the first question for
> > > > Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR from a
> > > > testscript?  Or should the policy sources be copied into /opt?
> > > 
> > > Ok, but regardless:  the refpolicy Makefile is still broken.
> > 
> > Yup.
> 
> All right, baby-steps.
> 
> The attached test_selinux.diff is not to be applied, but something
> like it is needed.  Should we have the ltp 'make install' fill in
> TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh?  BTW, Garrett,
> that is the issue I was saying is shared between test_selinux.sh
> and some others including test_robind.sh.  That's why I'm not just
> sending a patch to make it work, bc i think we need more general
> guidance.
> 
> The second match makes the 'make load' part of test_selinux.sh
> succeed on rhel5.4.  Stephen, how does it do on fedora?
> 
> After loading policy it fails to execute ltp-pan, but I figure let's
> get policy loading working first.
> 
> -serge

gah, attaching the actual patches this time.

-serge

--T4sUOijqQbZv57TR
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="Makefile.diff"

--- /root/ltp_cvs_orig/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	2010-01-08 04:39:20.000000000 -0500
+++ testcases/kernel/security/selinux-testsuite/refpolicy/Makefile	2010-01-11 15:52:13.000000000 -0500
@@ -34,6 +34,8 @@
 
 ifeq ($(strip $(DISTRO_VER)),)
 DISTRO_VER		:= generic
+else
+DISTRO_VER		:= $(shell echo $(DISTRO_VER) | cut -d . -f 1 - )
 endif
 
 CHECKPOLICY		?= $(DESTDIR)/usr/bin/checkpolicy

--T4sUOijqQbZv57TR
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="test_selinux.diff"

--- /root/ltp_cvs_orig/ltp/testscripts/test_selinux.sh	2009-05-19 05:39:11.000000000 -0400
+++ /opt/ltp/testscripts/test_selinux.sh	2010-01-11 15:11:34.000000000 -0500
@@ -77,10 +77,12 @@
 
 SEMODULE="/usr/sbin/semodule"
 
+TOP_SRCDIR=/root/ltp
+
 if [ -f $SEMODULE ]; then
-    POLICYDIR="$LTPROOT/testcases/kernel/security/selinux-testsuite/refpolicy"
+    POLICYDIR="$TOP_SRCDIR/testcases/kernel/security/selinux-testsuite/refpolicy"
 else
-    POLICYDIR="$LTPROOT/testcases/kernel/security/selinux-testsuite/policy"
+    POLICYDIR="$TOP_SRCDIR/testcases/kernel/security/selinux-testsuite/policy"
 fi
 
 config_set_expandcheck

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--T4sUOijqQbZv57TR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--T4sUOijqQbZv57TR--

