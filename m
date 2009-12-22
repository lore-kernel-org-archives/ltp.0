Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NMuqI-0006RT-OU
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 02:51:22 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NMuqB-00007z-Pu
	for ltp-list@lists.sourceforge.net; Tue, 22 Dec 2009 02:51:22 +0000
Received: by pzk31 with SMTP id 31so3886215pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 Dec 2009 18:51:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1261152185.8993.23.camel@subratamodak.linux.ibm.com>
References: <4B1F52FD.4010305@cn.fujitsu.com>
	<1261152185.8993.23.camel@subratamodak.linux.ibm.com>
Date: Mon, 21 Dec 2009 18:51:09 -0800
Message-ID: <364299f40912211851w3aaf2ab4t9ea3342dcf6b12f7@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
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
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 18, 2009 at 8:03 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Garret,
>
> Not sure if you applied this :-(
>
> Regards--
> Subrata
>
> On Wed, 2009-12-09 at 15:34 +0800, liubo wrote:
>> Here is the patch, which contains lots of adjustments
>> on style, so it might be a bit huge.
>>
>> Testcase 1. rt_sigaction01
>> On arch x86_64, if we directly get to call syscall
>> rt_sigaction, there will be "segment fault".
>> 1) One reason is that we must supply the flag of
>> "SA_RESTORER" and the correct pointer to the fuction
>> "restorer", according to the kernel code.
>> 2) The other reason is that default syscall rt_sigaction
>> use kernel "sigaction" structure, which is different
>> with normal "sigaction" structure.
>>
>> So,
>> 1) We manage to find the address of the function
>> "restorer" by using glibc function "sigaction",
>> which might be something tricky. Then we add these
>> arguments to make test run correctly.
>> 2) We also use kernel "sigaction" structure to fit
>> realtime syscall __NR_rt_sigaction.
>>
>> Testcase 2. rt_sigprocmask01
>> First, there exsits the same problem as rt_sigaction01.
>> Second, this testcase uses a unchanged signal number 33,
>> which may diff among different archs and lead to error
>> "unknown signal".
>>
>> So, we use a macro TEST_SIG which refers to SIGRTMIN
>> to replace 33.
>>
>> Testcase 3. rt_sigsuspend01
>> There exists the same problem as rt_sigaction01.
>>
>> This patch fixed these failure.

    No, I didn't commit this because it's long, and I'm not sure if
it's doing the right thing as per my research over the past couple of
weeks. These tests are tricky because it requires a particular formula
of preset variables and structures in order to properly use
rt_sigaction, and that's where we're running into issues with them on
x86_64 -- because the syscall implementers decided to remain sort of
backwards compatible with x86, and that's why it's such a mess to deal
with.
    I will look at the diff and pick out which parts are of value, but
a lot of this diff's contents are basically reverting the changes that
I made this month.
Thanks,
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
