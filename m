Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OvP77-00049u-Sh
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:35:33 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvP75-00030f-Mv
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:35:33 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <FABBC0A4-D041-407C-BFBB-2E6F626B5B56@gmail.com>
References: <1283625550.5303.5.camel@subratamodak.linux.ibm.com>
	<1284418964.3415.10.camel@plars-t500>
	<FABBC0A4-D041-407C-BFBB-2E6F626B5B56@gmail.com>
Date: Tue, 14 Sep 2010 12:05:22 +0530
Message-Id: <1284446122.5001.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [ANNOUNCE] Linux Test Project for AUGUST 2010 has
	been	released
Reply-To: subrata@linux.vnet.ibm.com
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
Cc: ltp-list <ltp-list@lists.sf.net>

On Mon, 2010-09-13 at 18:45 -0700, Garrett Cooper wrote:
> On Sep 13, 2010, at 4:02 PM, Paul Larson wrote:
> 
> > On Sun, 2010-09-05 at 00:09 +0530, Subrata Modak wrote:
> >> Hi,
> >> 
> >> LTP for August 2010 has been released. Please pick your copy from:
> >> http://ltp.sourceforge.net/,
> > Do we have a well-defined release process that is happening for each
> > release?  There were a few problems and differences with the August
> > release.  None of these are really huge, but they do tend to break
> > things for people that rely on the release tarballs for automated tests.
> > The fact that LTP has gone to releasing once every two months also makes
> > it more of a problem, since those affected will either need to make
> > changes that they'll likely need to roll back in two months, or roll
> > their own tarball.
> > 
> > The fact that make autotools had not been run has already been pointed
> > out.  The release was also done only as a .tgz rather than bzip2 like
> > the previous release.  I don't really care so much on that, but
> > consistency would be good.  Also the .git directory was left behind,
> > making the download size much larger than it should have been.

Hmm. My mistake. I will following the bzip2 pattern and remove the .git
and make sure than make autotools is done for this release.

> > 
> > Any chance there might be an interim release to correct these?

I will try for this in another day or 2.

Regards--
Subrata

> 
> 	I'll create the necessary Makefile targets for this. Subrata needs to handle the rest.
> Thanks,
> -Garrett


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
