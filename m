Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NUgah-0001nJ-99
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 13:15:23 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.67.1])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUgaf-0003Ld-Qn
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 13:15:22 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <20100111213100.GA28138@us.ibm.com>
References: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081408sf9d740ew55dad7b542463416@mail.gmail.com>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com> <20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com> <20100111213100.GA28138@us.ibm.com>
Date: Tue, 12 Jan 2010 08:16:08 -0500
Message-Id: <1263302168.14187.13.camel@moss-pluto.epoch.ncsc.mil>
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net, James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>

On Mon, 2010-01-11 at 15:31 -0600, Serge E. Hallyn wrote:
> Quoting Serge E. Hallyn (serue@us.ibm.com):
> > Quoting Serge E. Hallyn (serue@us.ibm.com):
> > > Quoting Serge E. Hallyn (serue@us.ibm.com):
> > > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > > > > On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
> > > > > > > Fails with:
> > > > > > > cp: cannot stat
> > > > > > > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/policy_files/generic/test_policy.*': No such file or directory
> > > > > > 
> > > > > > You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
> > > > > > 
> > > > > > I think we are supposed to actually be running
> > > > > > /opt/ltp/testscripts/test_selinux.sh.  So then the first question for
> > > > > > Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR from a
> > > > > > testscript?  Or should the policy sources be copied into /opt?
> > > > > 
> > > > > Ok, but regardless:  the refpolicy Makefile is still broken.
> > > > 
> > > > Yup.
> > > 
> > > All right, baby-steps.
> > > 
> > > The attached test_selinux.diff is not to be applied, but something
> > > like it is needed.  Should we have the ltp 'make install' fill in
> > > TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh?  BTW, Garrett,
> > > that is the issue I was saying is shared between test_selinux.sh
> > > and some others including test_robind.sh.  That's why I'm not just
> > > sending a patch to make it work, bc i think we need more general
> > > guidance.
> > > 
> > > The second match makes the 'make load' part of test_selinux.sh
> > > succeed on rhel5.4.  Stephen, how does it do on fedora?
> > > 
> > > After loading policy it fails to execute ltp-pan, but I figure let's
> > > get policy loading working first.
> 
> All right well just doing
> 
> --- /root/ltp_cvs_orig/ltp/testscripts/test_selinux.sh	2009-05-19 05:39:11.000000000 -0400
> +++ /opt/ltp/testscripts/test_selinux.sh	2010-01-11 16:26:12.000000000 -0500
> @@ -115,7 +117,7 @@
>  SAVEBINTYPE=`ls -Zd $LTPROOT/testcases/bin | awk '{ print $4 }' | awk -F: '{ print $3 }'`
>  /usr/bin/chcon -t test_file_t $LTPROOT/testcases/bin
>  
> -$LTPROOT/pan/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l $LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f $LTPROOT/runtest/selinux  
> +$LTPROOT/bin/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l $LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f $LTPROOT/runtest/selinux  
>  
>  # cleanup before exiting    
>  
> ================================================================
> in test_selinux.sh makes the testsuite mostly pass (test 39 fails, all
> up to then pass)
> 
> Again this is on RHEL5.4.

test39 isn't supposed to be run on RHEL5.4.  
The old tests/Makefile had conditional logic to exclude certain tests on
RHEL4 and on RHEL5, as their kernels wouldn't support newer tests.

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
