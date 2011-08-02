Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <serge.hallyn@canonical.com>) id 1QoF4R-0006df-8R
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 13:31:43 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QoF4O-0003Nr-D9
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 13:31:41 +0000
Date: Tue, 2 Aug 2011 08:15:43 -0500
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20110802131543.GA17783@sergelap>
References: <1609707634.578233.1312258810042.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<474812428.578270.1312259338813.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<CAGH67wRZx=iRqR0fMEuGV83Gz686Bq1nLjC8rtJpFCYCT5QWVA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGH67wRZx=iRqR0fMEuGV83Gz686Bq1nLjC8rtJpFCYCT5QWVA@mail.gmail.com>
Subject: Re: [LTP] Running only kernel syscall tests
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

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Mon, Aug 1, 2011 at 9:28 PM, Shakthi Kannan <skannan@redhat.com> wrote:
> > Hi,
> >
> > Are there any options to runltp or any other means to just run the kernel syscall tests?
> 
> runltp -f syscalls
> 
> > How long does it take to run the runalltests.sh on an i386/x86_64 machine?
> 
> Varies depending on the speed of the machine and other factors.

I'm curious - what exactly do people find they can run reliably with no
hangs on a known good system?  On ec2 instances I find even runltp -f
syscalls to hang.  I know, I know :)  I do intend to look into it.  But
is there anything people find they can use as a gross "this works on good
kernel, let's see if it breaks on test kernel" metric?

-serge

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
The must-attend event for mobile developers. Connect with experts. 
Get tools for creating Super Apps. See the latest technologies.
Sessions, hands-on labs, demos & much more. Register early & save!
http://p.sf.net/sfu/rim-blackberry-1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
