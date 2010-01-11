Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NURr6-0006cq-62
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 21:31:20 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NURr5-00035Z-15
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 21:31:20 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0BLIdg1010769
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 16:18:39 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0BLV0KX141790
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 16:31:00 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0BLV089018473
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 19:31:00 -0200
Date: Mon, 11 Jan 2010 15:31:00 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100111213100.GA28138@us.ibm.com>
References: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081408sf9d740ew55dad7b542463416@mail.gmail.com>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com>
	<20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100111210006.GA26554@us.ibm.com>
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
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ltp-list@lists.sourceforge.net, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Serge E. Hallyn (serue@us.ibm.com):
> > Quoting Serge E. Hallyn (serue@us.ibm.com):
> > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > > On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
> > > > > > Fails with:
> > > > > > cp: cannot stat
> > > > > > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/policy_files/generic/test_policy.*': No such file or directory
> > > > > 
> > > > > You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
> > > > > 
> > > > > I think we are supposed to actually be running
> > > > > /opt/ltp/testscripts/test_selinux.sh.  So then the first question for
> > > > > Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR from a
> > > > > testscript?  Or should the policy sources be copied into /opt?
> > > > 
> > > > Ok, but regardless:  the refpolicy Makefile is still broken.
> > > 
> > > Yup.
> > 
> > All right, baby-steps.
> > 
> > The attached test_selinux.diff is not to be applied, but something
> > like it is needed.  Should we have the ltp 'make install' fill in
> > TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh?  BTW, Garrett,
> > that is the issue I was saying is shared between test_selinux.sh
> > and some others including test_robind.sh.  That's why I'm not just
> > sending a patch to make it work, bc i think we need more general
> > guidance.
> > 
> > The second match makes the 'make load' part of test_selinux.sh
> > succeed on rhel5.4.  Stephen, how does it do on fedora?
> > 
> > After loading policy it fails to execute ltp-pan, but I figure let's
> > get policy loading working first.

All right well just doing

--- /root/ltp_cvs_orig/ltp/testscripts/test_selinux.sh	2009-05-19 05:39:11.000000000 -0400
+++ /opt/ltp/testscripts/test_selinux.sh	2010-01-11 16:26:12.000000000 -0500
@@ -115,7 +117,7 @@
 SAVEBINTYPE=`ls -Zd $LTPROOT/testcases/bin | awk '{ print $4 }' | awk -F: '{ print $3 }'`
 /usr/bin/chcon -t test_file_t $LTPROOT/testcases/bin
 
-$LTPROOT/pan/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l $LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f $LTPROOT/runtest/selinux  
+$LTPROOT/bin/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l $LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f $LTPROOT/runtest/selinux  
 
 # cleanup before exiting    
 
================================================================
in test_selinux.sh makes the testsuite mostly pass (test 39 fails, all
up to then pass)

Again this is on RHEL5.4.

-serge

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
