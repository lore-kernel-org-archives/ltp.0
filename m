Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MNpQA-0005qt-LI
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 14:43:54 +0000
Received: from mail-bw0-f227.google.com ([209.85.218.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MNpQ9-0003HD-QH
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 14:43:54 +0000
Received: by bwz27 with SMTP id 27so1101833bwz.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 07:43:52 -0700 (PDT)
Message-ID: <4A520DA6.2040107@petalogix.com>
Date: Mon, 06 Jul 2009 16:43:50 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A4DFB77.1080700@petalogix.com>
	<20090706121455.GA16908@linux-sh.org>
	<4A51F3F3.6040501@petalogix.com> <200907061616.12220.arnd@arndb.de>
In-Reply-To: <200907061616.12220.arnd@arndb.de>
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
>>> Not necessarily, even on platforms that manage aliases in hardware
>>> mappings that violate the aliasing constraints can still result in
>>> undefined behaviour, this really depends more on your cache controller
>>> and MMU than anything else. I notice that microblaze sets SHMLBA to
>>> PAGE_SIZE, you may want to see if this test still breaks after bumping it
>>> up to something like PAGE_SIZE * 4.
>>>   
>>>       
>> Yes, test still break - behavior is the same. I don't have accurate
>> information about MMU unit
>> but I will ask a question about. We are able to turn off cache
>> controller directly in HW.
>>     
>
> There may still be a problem with data being queued in some write
> buffers that don't get flushed before reading back from another
> address.
>
> What happens in a simple user space program that mmaps the same
> page to two addresses? Something like
>
> #include <sys/mman.h>
> #include <fcntl.h>
> int main(void)
> {
> 	int fd = open("existing-4k-file", O_RDWR);
> 	char *p1 = mmap(0, 4096, PROT_READ | PROT_WRITE,
> 				MAP_SHARED, fd, 0);
> 	char *p2 = mmap(p1 + 4096, 4096, PROT_READ | PROT_WRITE,
> 				MAP_SHARED | MAP_FIXED, fd, 0);
>
> 	*p1 = 0xaa; *p2 = 0x55;
>   
I closed fd too.
    close(fd);
> 	return *p1; /* returns 0xaa if broken, 0x55 if correct */
> }
>   
# ls -la existing-4k-file
-rw-rw-r--    1 monstr   monstr       4096 Jul  6  2009 existing-4k-file

# ./test-arnd
# echo $?
85
# dd if=existing-4k-file of=/dev/console count=1 2>/dev/null
U#

in file is first char U (0x55) which is IMO correct.

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
