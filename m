Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ow885-00070z-OA
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 06:39:33 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ow884-0004k0-RU
	for ltp-list@lists.sourceforge.net; Thu, 16 Sep 2010 06:39:33 +0000
Received: by pvg6 with SMTP id 6so332184pvg.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 15 Sep 2010 23:39:27 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4C91A23E.6080506@windriver.com>
Date: Wed, 15 Sep 2010 23:39:26 -0700
Message-Id: <3DD1FEEC-2EE3-4F12-87CC-D1D8D6BDA387@gmail.com>
References: <4C91A23E.6080506@windriver.com>
Subject: Re: [LTP] [patch] change user password usable time
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
To: "lina.zhao" <lina.zhao@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Sep 15, 2010, at 9:51 PM, lina.zhao wrote:

> Hi,
> 
> Some board do not have a RTC, then when it boot up, the time is 1970.1.1.
> 
> if Linux finds 'last password change date' of an account = 1/1/1970 , it forces password change on next login.
> if the systems' date is like that and you change (as required) the password, each time you login on the same day it will require you to change password.
> 
> So in the target whose boot up time is 1/1/1970 and use the 'su' command, there will be 'You are required to change your password immediately (root enforced)' informations and stop the testing.
> 
> chage -d 10 userName will let the userName is usable in the next 10 days.

	Again, this is more of an environment issue with your board than anything else, and can be easily resolved by calling ntpdate on the board, so... I still don't see the usefulness of this functionality if it's just applied in one set of scripts (again, half-measures are very undesirable because they're more painful to maintain).
	It can be solved via an init.d script or an upstart job file in a matter of a few lines.
Thanks,
-Garrett
------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
