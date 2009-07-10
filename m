Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MPKqr-0004EP-6Q
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 18:29:41 +0000
Received: from fg-out-1718.google.com ([72.14.220.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPKqk-0003ga-UU
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 18:29:41 +0000
Received: by fg-out-1718.google.com with SMTP id e12so63407fga.9
	for <ltp-list@lists.sourceforge.net>;
	Fri, 10 Jul 2009 11:29:32 -0700 (PDT)
Message-ID: <4A5782A5.2050301@petalogix.com>
Date: Fri, 10 Jul 2009 20:04:21 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A5436D4.6070201@petalogix.com>	
	<364299f40907080719q4ab01842v7e47a352b8214b8a@mail.gmail.com>	
	<4A54AEFA.3030100@petalogix.com>	
	<364299f40907082230m27683f17yd042bd569d0a5165@mail.gmail.com>	
	<4A55C646.5060805@petalogix.com>
	<364299f40907091011y2f988746n562e183b5d4276be@mail.gmail.com>
In-Reply-To: <364299f40907091011y2f988746n562e183b5d4276be@mail.gmail.com>
Subject: Re: [LTP] IDcheck.sh - awk problem
Reply-To: michal.simek@petalogix.com
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
Cc: LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier.adi@gmail.com>

Garrett Cooper wrote:
> On Thu, Jul 9, 2009 at 3:28 AM, Michal Simek<michal.simek@petalogix.com> wrote:
>   
>> Garrett Cooper wrote:
>>     
>>> On Wed, Jul 8, 2009 at 7:36 AM, Michal Simek<michal.simek@petalogix.com> wrote:
>>>
>>>       
>>>> Of course not because I cross compile ltp for Microblaze - correct
>>>> /etc/passwd - group is on
>>>> target system. Maybe worth to remove calling IDcheck.sh from make
>>>> install and call it only before
>>>> running the test.
>>>>
>>>>
>>>>         
>>> Michal,
>>>     Please give this patch a try, and instead when you run make
>>> install, do SKIP_IDCHECK=1.
>>> HTH,
>>> -Garrett
>>>       
>
> Wow. I must have been tired at the time; no idea why I used filter
> instead of strip. Please try this instead.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>   
Sorry for delay.

Tested-by: Michal Simek <monstr@monstr.eu>

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


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
