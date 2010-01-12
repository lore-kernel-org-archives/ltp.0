Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NUgTv-0004yj-G0
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 13:08:23 +0000
Received: from msux-gh1-uea02.nsa.gov ([63.239.67.2])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUgTt-0007aZ-Gs
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 13:08:22 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <364299f41001120043p41ead970ieed6188e31e3fc04@mail.gmail.com>
References: <20100106185019.GA19647@us.ibm.com>
	<1262976343.20881.4.camel@moss-pluto.epoch.ncsc.mil>
	<1262976627.20881.6.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081408sf9d740ew55dad7b542463416@mail.gmail.com>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001120043p41ead970ieed6188e31e3fc04@mail.gmail.com>
Date: Tue, 12 Jan 2010 08:08:17 -0500
Message-Id: <1263301697.14187.11.camel@moss-pluto.epoch.ncsc.mil>
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

On Tue, 2010-01-12 at 00:43 -0800, Garrett Cooper wrote:
> On Mon, Jan 11, 2010 at 11:55 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
> >> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> >> > On Fri, 2010-01-08 at 23:27 -0800, Garrett Cooper wrote:
> >> > > On Fri, Jan 8, 2010 at 2:08 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> >> > > > On Fri, Jan 8, 2010 at 2:00 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> > > >> On Fri, 2010-01-08 at 13:38 -0800, Garrett Cooper wrote:
> >> > > >>> On Fri, Jan 8, 2010 at 10:50 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> >> > > >>> > On Fri, 2010-01-08 at 13:47 -0500, Stephen Smalley wrote:
> >> > > >>> >> On Fri, 2010-01-08 at 10:20 -0800, Garrett Cooper wrote:
> >> > > >>> >> >     Thanks for the feedback and details Stephen.
> >> > > >>> >> >     Would you be kind enough to try out the version from CVS to see
> >> > > >>> >> > whether or not it resolves your issue? You'll also need to update
> >> > > >>> >> > $LTPROOT/scripts in order to use the new version as I added a distro
> >> > > >>> >> > detection script which opens up /etc/redhat-release (for redhat) as
> >> > > >>> >> > opposed to using rpm to query the release.
> >> > > >>> >> > Thanks,
> >> > > >>> >> > -Garrett
> >> > > >>> >>
> >> > > >>> >> The attempt to make the test policy immediately dies with:
> >> > > >>> >> detect_distro.sh: ERROR: Bad release file: /etc/redhat-release
> >> > > >>> >
> >> > > >>> > I should note that I'm running it on Fedora, so I wouldn't expect that
> >> > > >>> > file to exist.  But the script needs to handle it gracefully; we just
> >> > > >>> > use the generic test policy files in that situation.
> >> > > >>>
> >> > > >>>     What does /etc/redhat-release look like (feel free to reply to me off-list)?
> >> > > >>
> >> > > >> On RHEL5, it can look like one of the following:
> >> > > >> Red Hat Enterprise Linux Server release 5 (Tikanga)
> >> > > >> Red Hat Enterprise Linux Server release 5.x (Tikanga)
> >> > > >> Red Hat Enterprise Linux Client release 5 (Tikanga)
> >> > > >> Red Hat Enterprise Linux Client release 5.x (Tikanga)
> >> > > >
> >> > > > Interesting. They switched over to more of the Fedora-style branding, maybe?.
> >> > > >
> >> > > > [garrcoop@halflife ~]$ cat /etc/redhat-release
> >> > > > Red Hat Enterprise Linux AS release 4 (Nahant Update 6)
> >> > >
> >> > > Could you try again please :)?
> >> >
> >> > Fails with:
> >> > cp: cannot stat
> >> > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/policy_files/generic/test_policy.*': No such file or directory
> >>
> >> You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
> >>
> >> I think we are supposed to actually be running
> >> /opt/ltp/testscripts/test_selinux.sh.  So then the first question for
> >> Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR from a
> >> testscript?  Or should the policy sources be copied into /opt?
> >
> > Ok, but regardless:  the refpolicy Makefile is still broken.
> 
>     Yes, it is (I don't have access to that package I think on my
> version of Fedora...). Please try the attached patch and let me know
> how it goes [the comments aren't as important as the `set -e' and
> `$(TEST_POLICY_DIR)/' removal on the cp(1) call].
> Thanks,
> -Garrett

The patch was whitespace-damaged, so I had to fix it up by hand.
Now a 'make' in the refpolicy directory yields:
(cd
"/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/policy_files/generic" && cat test_global.te test_bounds.te test_capable_file.te test_capable_net.te test_capable_sys.te test_dyntrace.te test_dyntrans.te test_entrypoint.te test_execshare.te test_exectrace.te test_execute_no_trans.te test_fdreceive.te test_file.te test_inherit.te test_ioctl.te test_ipc.te test_link.te test_mkdir.te test_open.te test_ptrace.te test_readlink.te test_relabel.te test_rename.te test_rxdir.te test_setattr.te test_setnice.te test_sigkill.te test_stat.te test_sysctl.te test_task_create.te test_task_getpgid.te test_task_getsched.te test_task_getsid.te test_task_setpgid.te test_task_setsched.te test_transition.te test_wait.te) > test_policy.te

And a 'make load' successfully loads that.

On recent Fedora you don't need any additional
packages; /usr/share/selinux/devel is shipped as part of selinux-policy
these days rather than as a separate selinux-policy-devel package.

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
