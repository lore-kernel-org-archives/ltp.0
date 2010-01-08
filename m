Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sds@tycho.nsa.gov>) id 1NTMvh-0002Jz-1z
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 22:03:37 +0000
Received: from msux-gh1-uea01.nsa.gov ([63.239.67.1])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NTMvg-00087h-0Q
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 22:03:37 +0000
From: Stephen Smalley <sds@tycho.nsa.gov>
In-Reply-To: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
References: <1262791548.15424.31.camel@moss-pluto.epoch.ncsc.mil>
	<20100106185019.GA19647@us.ibm.com>
	<1262893258.2821.50.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081020r7ee941f4w1b91bcb79849b406@mail.gmail.com>
	<1262976343.20881.4.camel@moss-pluto.epoch.ncsc.mil>
	<1262976627.20881.6.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
Date: Fri, 08 Jan 2010 17:00:51 -0500
Message-Id: <1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
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

On Fri, 2010-01-08 at 13:38 -0800, Garrett Cooper wrote:
> On Fri, Jan 8, 2010 at 10:50 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Fri, 2010-01-08 at 13:47 -0500, Stephen Smalley wrote:
> >> On Fri, 2010-01-08 at 10:20 -0800, Garrett Cooper wrote:
> >> >     Thanks for the feedback and details Stephen.
> >> >     Would you be kind enough to try out the version from CVS to see
> >> > whether or not it resolves your issue? You'll also need to update
> >> > $LTPROOT/scripts in order to use the new version as I added a distro
> >> > detection script which opens up /etc/redhat-release (for redhat) as
> >> > opposed to using rpm to query the release.
> >> > Thanks,
> >> > -Garrett
> >>
> >> The attempt to make the test policy immediately dies with:
> >> detect_distro.sh: ERROR: Bad release file: /etc/redhat-release
> >
> > I should note that I'm running it on Fedora, so I wouldn't expect that
> > file to exist.  But the script needs to handle it gracefully; we just
> > use the generic test policy files in that situation.
> 
>     What does /etc/redhat-release look like (feel free to reply to me off-list)?

On RHEL5, it can look like one of the following:
Red Hat Enterprise Linux Server release 5 (Tikanga)
Red Hat Enterprise Linux Server release 5.x (Tikanga)
Red Hat Enterprise Linux Client release 5 (Tikanga)
Red Hat Enterprise Linux Client release 5.x (Tikanga)

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
