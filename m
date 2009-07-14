Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MQjaH-0005J1-OT
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 15:06:21 +0000
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQjaA-0004vo-SQ
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 15:06:21 +0000
Received: by bwz11 with SMTP id 11so2776772bwz.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jul 2009 08:06:13 -0700 (PDT)
Message-ID: <4A5C9EE4.4040101@monstr.eu>
Date: Tue, 14 Jul 2009 17:06:12 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
References: <4A5C8068.6020203@monstr.eu> <200907141521.47719.arnd@arndb.de>
	<4A5C8BF2.8020505@monstr.eu> <200907141645.48833.arnd@arndb.de>
In-Reply-To: <200907141645.48833.arnd@arndb.de>
Subject: Re: [LTP] access_ok macor
Reply-To: monstr@monstr.eu
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

Arnd Bergmann wrote:
> On Tuesday 14 July 2009, Michal Simek wrote:
>> Arnd Bergmann wrote:
>> Look at
>> http://developer.petalogix.com/git/gitweb.cgi?p=ltp-microblaze.git;a=commitdiff;h=45f4cd783ce8b94f1267bb87c0c46e8536f62eca
>>
>> There are three affected tests and my quick fixes which I am trying to solve now.
>>
> 
> ok, I see.
>  
>> int move_addr_to_user(struct sockaddr *kaddr, int klen, void __user *uaddr,
>> 		      int __user *ulen)
>> {
>> 	int err;
>> 	int len;
>>
>> 	err = get_user(len, ulen);
>> 	if (err)
>> 		return err;
>>
> 
> So the code looks something like
> 
>                         "1:     lw      %1, %2, r0;                     \
>                                 addk    %0, r0, r0;                     \
>                         2:                                              \
>                         .section .fixup,\"ax\";                         \
>                         3:      brid    2b;                             \
>                                 addik   %0, r0, %3;                     \
>                         .previous;                                      \
>                         .section ,\"a\";                      		\
>                         .word   1b,3b;                                  \
>                         .previous;"                                     \

yes,

> 
> Not much that can go wrong there. First of all, I'd check that the
> code actually looks the same in the binary. I assume that the 'addik'
> gets executed when the brid branches, right?

yes, it should bri-d meant branch with delay slot and addik is in delay.

> 
> I would guess that some of the logic in do_page_fault might be
> broken and does not actually call the fixup.

ok.

Michal

> 
> 	Arnd <><


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
