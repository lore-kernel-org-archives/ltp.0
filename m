Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1OM2Tp-0004yV-Dk
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 17:20:49 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OM2Tn-00076m-HW
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 17:20:48 +0000
Received: by fxm9 with SMTP id 9so3493945fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Jun 2010 10:20:41 -0700 (PDT)
Message-ID: <4C0E75B7.5000103@monstr.eu>
Date: Tue, 08 Jun 2010 18:54:15 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
References: <1276001198-17532-1-git-send-email-monstr@monstr.eu>
	<AANLkTilzjOK_lLfz_o4KOZgdj9Px2qebOnIIEe_Um1TJ@mail.gmail.com>
In-Reply-To: <AANLkTilzjOK_lLfz_o4KOZgdj9Px2qebOnIIEe_Um1TJ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: getdtablesize01 fix for missing
	/etc/hosts
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, michal.simek@petalinux.com.monstr.eu

Garrett Cooper wrote:
> On Tue, Jun 8, 2010 at 5:46 AM,  <monstr@monstr.eu> wrote:
>> From: Michal Simek <monstr@monstr.eu>
>>
>> Embedded systems doesn't need to contain /etc/hosts that's why
>> will be good to create it if doesn't exist. If file doesn't exist
>> then syscall test failed.
>>
>> Error:
>> getdtablesize01    0  TINFO  :  Maximum number of files a process can have opened is 1024
>> getdtablesize01    0  TINFO  :  Checking with the value returned by getrlimit...RLIMIT_NOFILE
>> getdtablesize01    1  TPASS  :  got correct dtablesize, value is 1024
>> getdtablesize01    0  TINFO  :  Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1
>> Opened file num -1
>> getdtablesize01    2  TFAIL  :  0 != 1023
>>
>> Signed-off-by: Michal Simek <monstr@monstr.eu>
>> ---
>>  .../syscalls/getdtablesize/getdtablesize01.c       |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
>> index a495501..568e1ad 100644
>> --- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
>> +++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
>> @@ -83,7 +83,7 @@ int main()
>>        tst_resm(TINFO,
>>                 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
>>        for (loop = 1; loop <= max_val_opfiles; loop++) {
>> -               fd = open("/etc/hosts", O_RDONLY);
>> +               fd = open("/etc/hosts", O_RDONLY | O_CREAT);
>>  #ifdef DEBUG
>>                printf("Opened file num %d\n", fd);
>>  #endif
> 
> No. You need to fix your embedded system to have all of the files on
> it before you try and run LTP. This would regress all sane Linux
> systems running LTP because the file already exists.

If the file doesn't exist then is created. If exists then there is no 
change. And I have no problem to fix my system! My point was do not use 
any assumption.

> 
> I agree that this assumption is broken though; it might be better to
> use a different file, like via mkstemp(3).

I like this solution.

Thanks,
Michal

> 
> Also, leaking file descriptors is silly if getdtablesize(2) is busted,
> or the OS fails to clean up all of the open file descriptors... it
> should cache the opened filehandles if != -1, then close each of them
> one by one.
> 
> Thanks,
> -Garrett


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
