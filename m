Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MNpz2-00080a-9Y
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:19:56 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNpyw-0004cG-At
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 15:19:51 +0000
Received: by fxm4 with SMTP id 4so2952825fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 08:19:49 -0700 (PDT)
Message-ID: <4A521612.3030607@petalogix.com>
Date: Mon, 06 Jul 2009 17:19:46 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A4DFB77.1080700@petalogix.com> <200907061616.12220.arnd@arndb.de>
	<4A520DA6.2040107@petalogix.com> <200907061705.50308.arnd@arndb.de>
In-Reply-To: <200907061705.50308.arnd@arndb.de>
Subject: Re: [LTP] mmap syscall problem
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: LTP <ltp-list@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, John Williams <john.williams@petalogix.com>

Arnd Bergmann wrote:
> On Monday 06 July 2009, Michal Simek wrote:
>   
>>>       *p1 = 0xaa; *p2 = 0x55;
>>>   
>>>       
>> I closed fd too.
>>     close(fd);
>>     
>>>       return *p1; /* returns 0xaa if broken, 0x55 if correct */
>>> }
>>>       
>
> If you close the fd between the assignment and reading
> from the pointer again, the test case becomes invalid because of
> timing. Closing the fd before the '*p1 = 0xaa' should be fine,
> but unnecessary.
>
> I also realized that you might need to mark the pointers
> as 'volatile' so that the compiler has to do the operations
> in order.
>
>   
The result are the same. I tried to run mmap test which are in LTP and
only first one failed.

Do you have any ideas what buffer could caused that problems?
>>>   
>>>       
>> # ls -la existing-4k-file
>> -rw-rw-r--    1 monstr   monstr       4096 Jul  6  2009 existing-4k-file
>>
>> # ./test-arnd
>> # echo $?
>> 85
>>     
>
> Ok, so inside a single task, this does not happen.
>   
I print output in that task and there is 0x55 too.
>   
>> # dd if=existing-4k-file of=/dev/console count=1 2>/dev/null
>> U#
>>
>> in file is first char U (0x55) which is IMO correct.
>>     
>
> Right, though that was not part of the test, I'd expect this in
> the file even if the return value was broken.
>   
Not in case that mmap is completely broken. This test confirm that mmap
map that fd and is possible to write there.

Thanks,
Michal


> 	Arnd <><
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
