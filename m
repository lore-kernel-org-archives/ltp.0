Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1S8YOR-0006Mp-QV
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 14:44:35 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S8YOL-0006Q6-W7
	for ltp-list@lists.sourceforge.net; Fri, 16 Mar 2012 14:44:35 +0000
Date: Fri, 16 Mar 2012 10:44:09 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <47a39b80-c735-45af-aee5-075ca9080323@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <20120316141906.GB2897@peqn>
MIME-Version: 1.0
Subject: Re: [LTP] Are you still maintaining Selinux testsuite
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
To: Serge Hallyn <serge.hallyn@canonical.com>
Cc: Poornima Nayak <Poornima.Nayak@in.ibm.com>, ltp-list <ltp-list@lists.sf.net>, Jeffrey Burke <jburke@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>



----- Original Message -----
> From: "Serge Hallyn" <serge.hallyn@canonical.com>
> To: "Poornima Nayak" <Poornima.Nayak@in.ibm.com>
> Cc: "ltp-list" <ltp-list@lists.sf.net>, "Stephen Smalley" <sds@tycho.nsa.gov>, "James Morris" <jmorris@namei.org>
> Sent: Friday, March 16, 2012 3:19:06 PM
> Subject: Re: [LTP] Are you still maintaining Selinux testsuite
> 
> Quoting Poornima Nayak (Poornima.Nayak@in.ibm.com):
> > Hi Serge
> > 
> > I was looking out for selinux test suite after the call was taken
> > to move
> > it out of LTP. Latest discussion is this
> > http://permalink.gmane.org/gmane.linux.ltp/15301. Any progress
> > beyond this
> > ?
> 
> Hi Poornima,
> 
> yes, I'm sorry it's taken this long, but I finally got a copy up at:
> 
> http://git.selinuxproject.org/git/?p=users/serge/selinux-testsuite.git;a=summary
> 
> Thanks James for the account, and Stephen for the copy of the git
> tree.
> 
> Now I should get back to getting this to pass on Ubuntu -
> unfortunately
> the changes I"d been staging for that were the victim of a hard drive
> crash.

Hi,

what is the preffered way of contributing?

I have some patches, which allow testsuite to run on latest RHEL (7 Alpha atm.)
and F16 in automated env (Beaker). These also include some previous fixes made in LTP,
which probably didn't make it back to upstream.

Regards,
Jan

> 
> -serge
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
