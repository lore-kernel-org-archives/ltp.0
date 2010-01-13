Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NVBGh-000559-Uh
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 22:00:47 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NVBGh-0007eC-3M
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 22:00:47 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o0DLofbh014876
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 16:50:41 -0500
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0DM0ZZu116756
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 17:00:35 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o0DM2QIh029787
	for <ltp-list@lists.sourceforge.net>; Wed, 13 Jan 2010 15:02:26 -0700
Date: Wed, 13 Jan 2010 16:00:21 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100113220021.GA838@us.ibm.com>
References: <364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
	<364299f41001120919w3b56bfefoc5b7a1e6a4e96f1@mail.gmail.com>
	<364299f41001120926s45ab6b24i485a0fd0ba499f41@mail.gmail.com>
	<1263323555.16277.11.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001122251v49ec2743j6c57ada7bd6eaf3f@mail.gmail.com>
	<1263390194.31509.4.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131052s27019ebl53f4e3f76bb4598e@mail.gmail.com>
	<1263410323.901.5.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001131137j36d1c665r45cb8b6163263428@mail.gmail.com>
	<1263412198.901.11.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1263412198.901.11.camel@moss-pluto.epoch.ncsc.mil>
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

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Wed, 2010-01-13 at 11:37 -0800, Garrett Cooper wrote:
> > Yeah, you're right. I was trying to beat around this bush by not
> > copying these over, but it's better to have the test running and be
> > improperly designed than it is for regressions to leak by today, until
> > the day comes where these items are fixed.
> > 
> > 1. So, Makefile is now copied over by default.
> > 2. load is no longer done as part of all / install (test_selinux.sh
> > was performing that function).
> > 
> > So once the tests have been written to make and install independent of
> > selinux-devel, etc... we'll be in good shape and I will switch these
> > back to all / install dependent targets. I was trying to do it that
> > way to avoid requiring make on the target under test, but I need to
> > better understand the subject matter under test before we get to that
> > point.
> 
> Unfortunately, as the Makefile now includes other .mk files and those
> are not copied over, it still doesn't work.
> 
> Makefile:25: ../../../../../include/mk/env_pre.mk: No such file or directory
> make: ../../../../../scripts/detect_distro.sh: Command not found
> Makefile:90: ../../../../../include/mk/generic_leaf_target.mk: No such file or directory
> make: *** No rule to make target `../../../../../include/mk/generic_leaf_target.mk'.  Stop.
> Failed to build and load test_policy module, aborting test run.
> /etc/selinux /opt/ltp/testcases/kernel/security/selinux-testsuite/refpolicy
> /opt/ltp/testcases/kernel/security/selinux-testsuite/refpolicy
> 
> I suppose you could perform the make load as part of all/install
> (preferably install as we really shouldn't need to be root to run make
> all - although that no longer seems to be the case for the main ltp
> either), and drop it from test_selinux.sh.  But then they will need to
> know/remember to remove the test policy when finished testing.

But really the compile stage should just create test_policy.pp,
which the testsuite can load and unload, right?

-serge

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
