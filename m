Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NUQLR-0005Sm-7K
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 19:54:33 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.67.1])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUQLN-0007eS-5P
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 19:54:33 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <20100111195043.GA23360@us.ibm.com>
References: <20100106185019.GA19647@us.ibm.com>
	<1262893258.2821.50.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081020r7ee941f4w1b91bcb79849b406@mail.gmail.com>
	<1262976343.20881.4.camel@moss-pluto.epoch.ncsc.mil>
	<1262976627.20881.6.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081408sf9d740ew55dad7b542463416@mail.gmail.com>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
Date: Mon, 11 Jan 2010 14:55:06 -0500
Message-Id: <1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
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

On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
> Quoting Stephen Smalley (sds@tycho.nsa.gov):
> > On Fri, 2010-01-08 at 23:27 -0800, Garrett Cooper wrote:
> > > On Fri, Jan 8, 2010 at 2:08 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> > > > On Fri, Jan 8, 2010 at 2:00 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >> On Fri, 2010-01-08 at 13:38 -0800, Garrett Cooper wrote:
> > > >>> On Fri, Jan 8, 2010 at 10:50 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > >>> > On Fri, 2010-01-08 at 13:47 -0500, Stephen Smalley wrote:
> > > >>> >> On Fri, 2010-01-08 at 10:20 -0800, Garrett Cooper wrote:
> > > >>> >> >     Thanks for the feedback and details Stephen.
> > > >>> >> >     Would you be kind enough to try out the version from CVS to see
> > > >>> >> > whether or not it resolves your issue? You'll also need to update
> > > >>> >> > $LTPROOT/scripts in order to use the new version as I added a distro
> > > >>> >> > detection script which opens up /etc/redhat-release (for redhat) as
> > > >>> >> > opposed to using rpm to query the release.
> > > >>> >> > Thanks,
> > > >>> >> > -Garrett
> > > >>> >>
> > > >>> >> The attempt to make the test policy immediately dies with:
> > > >>> >> detect_distro.sh: ERROR: Bad release file: /etc/redhat-release
> > > >>> >
> > > >>> > I should note that I'm running it on Fedora, so I wouldn't expect that
> > > >>> > file to exist.  But the script needs to handle it gracefully; we just
> > > >>> > use the generic test policy files in that situation.
> > > >>>
> > > >>>     What does /etc/redhat-release look like (feel free to reply to me off-list)?
> > > >>
> > > >> On RHEL5, it can look like one of the following:
> > > >> Red Hat Enterprise Linux Server release 5 (Tikanga)
> > > >> Red Hat Enterprise Linux Server release 5.x (Tikanga)
> > > >> Red Hat Enterprise Linux Client release 5 (Tikanga)
> > > >> Red Hat Enterprise Linux Client release 5.x (Tikanga)
> > > >
> > > > Interesting. They switched over to more of the Fedora-style branding, maybe?.
> > > >
> > > > [garrcoop@halflife ~]$ cat /etc/redhat-release
> > > > Red Hat Enterprise Linux AS release 4 (Nahant Update 6)
> > > 
> > > Could you try again please :)?
> > 
> > Fails with:
> > cp: cannot stat
> > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/policy_files/generic/test_policy.*': No such file or directory
> 
> You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
> 
> I think we are supposed to actually be running
> /opt/ltp/testscripts/test_selinux.sh.  So then the first question for
> Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR from a
> testscript?  Or should the policy sources be copied into /opt?

Ok, but regardless:  the refpolicy Makefile is still broken.

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
