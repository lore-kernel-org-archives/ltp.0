Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MODUs-0003Ew-1a
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 16:26:22 +0000
Received: from mail-yx0-f202.google.com ([209.85.210.202])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MODUn-0004BP-8s
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 16:26:22 +0000
MIME-Version: 1.0
In-Reply-To: <1246980755.5539.50.camel@subratamodak.linux.ibm.com>
References: <200907071035.46915.jpalecek@web.de>
	<1246980755.5539.50.camel@subratamodak.linux.ibm.com>
Date: Tue, 7 Jul 2009 09:26:10 -0700
Message-ID: <364299f40907070926k4a3557c8of6d4b8feb3fb4e54@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix some bashisms
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
To: subrata@linux.vnet.ibm.com
Cc: Jiri Palecek <jpalecek@web.de>, ltp-list <ltp-list@lists.sf.net>

On Tue, Jul 7, 2009 at 8:32 AM, Subrata Modak<subrata@linux.vnet.ibm.com> wrote:
> I can find that they addressed all issues of Mike and Matt. However, i
> would just wait for some more confirmation from them. Thanks.
>
> Regards--
> Subrata

Hi Jiri!
    Your patch looks better than before, but like you mentioned in
your last reply, the:

command || RC=$?
if [ $RC -ne 0 ]; then

    stuff is a bit inconsistent, and like you originally suggested it
should probably be more like:

command
if [ $? -ne 0 ]; then

    It looks like it was inconsistent before anyhow to be honest, so
it shouldn't be a big problem, but if we can fix it, we probably
should. That's the only outstanding concern from my end.
Thanks!
-Garrett

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
