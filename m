Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SwgLx-0007dq-Sv
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 21:21:13 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SwgLt-0002wH-7Z
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 21:21:13 +0000
Received: by obcva7 with SMTP id va7so13311338obc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 01 Aug 2012 14:21:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201208011647.55852.vapier@gentoo.org>
References: <CAO8ONPyEzsnxpivfG-Jw=5YyzmPdzW2JyVCJrH0i8PkSqDX7tg@mail.gmail.com>
	<201208011647.55852.vapier@gentoo.org>
Date: Wed, 1 Aug 2012 14:21:03 -0700
Message-ID: <CAGH67wRjM+ifREgSNpLYK6u99Q4MHa1g25c9Z1+RRb17mMgQOA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP on ARMV7
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Vanni Genua <vannigenua@gmail.com>

On Wed, Aug 1, 2012 at 1:47 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday 02 July 2012 11:27:45 Vanni Genua wrote:
>> anybody know if LTP support ARMv7 and not only x86 architecture?
>
> LTP doesn't really care about the architecture.  it works on any CPU.

- You may run into ARM bugs (in which case, patches are welcome after
some investigation).
- You will need to roll your own builds; once upon a time some RPMs
and other binaries for LTP were produced and distributed by the
project, but that kind of died out after some of the contributors got
too busy or left the project.
Thanks!
-Garrett

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
