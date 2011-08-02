Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Qo72T-0005Em-R0
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 04:57:09 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Qo72T-00026L-7w
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 04:57:09 +0000
Received: by vxh2 with SMTP id 2so7007896vxh.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Aug 2011 21:57:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <474812428.578270.1312259338813.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
References: <1609707634.578233.1312258810042.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
	<474812428.578270.1312259338813.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>
Date: Mon, 1 Aug 2011 21:57:03 -0700
Message-ID: <CAGH67wRZx=iRqR0fMEuGV83Gz686Bq1nLjC8rtJpFCYCT5QWVA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Shakthi Kannan <skannan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Aug 1, 2011 at 9:28 PM, Shakthi Kannan <skannan@redhat.com> wrote:
> Hi,
>
> Are there any options to runltp or any other means to just run the kernel syscall tests?

runltp -f syscalls

> How long does it take to run the runalltests.sh on an i386/x86_64 machine?

Varies depending on the speed of the machine and other factors.

HTH,
-Garrett

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
