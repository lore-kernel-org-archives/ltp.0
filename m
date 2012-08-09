Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SzQ62-0005QN-6k
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 10:36:06 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SzQ61-0003CG-8o
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 10:36:06 +0000
Received: by pbcwy7 with SMTP id wy7so623004pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Aug 2012 03:35:59 -0700 (PDT)
Message-ID: <50239281.4080705@casparzhang.com>
Date: Thu, 09 Aug 2012 18:35:45 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1024699575.2373526.1344504153517.JavaMail.root@redhat.com>
In-Reply-To: <1024699575.2373526.1344504153517.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall
	availability
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
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 08/09/2012 05:22 PM, Jan Stancek wrote:
> Caspar,
>
> I think what Garrett meant was something like this:
> /* check if syscall is supported, syscall() here is macro from linux_syscall_numbers.h */
> syscall(__NR_get_mempolicy, NULL, NULL, 0, NULL, 0);
>
> linux_syscall_numbers.h defines a macro "syscall", which checks for ENOSYS.

You're right, hope my "resend v2" is the final correct version...

Oops, the patch didn't append after this mail but followed to the top 
thread... hmmm, please help to review the one tagged as "PATCH resend v2 
3/6".

And thank you very much for your testing on the whole patch series!

Thanks,
Caspar

>
> Regards,
> Jan
>
> ----- Original Message -----
>> From: "Caspar Zhang" <caspar@casparzhang.com>
>> To: "LTP List" <ltp-list@lists.sourceforge.net>
>> Sent: Thursday, 9 August, 2012 8:15:39 AM
>> Subject: [LTP] [PATCH resend 3/6] syscalls/numa: check syscall availability
>>
>>
>> some NUMA related syscalls: mbind, get_mempolicy are not supported on
>> some arches (e.g. i386), this patch checks the syscalls' availability
>> in
>> setup() function, if the syscall is not implemented on the system, a
>> TCONF message will be given like this:
>>
>> get_mempolicy01    1  TCONF  : syscall __NR_get_mempolicy01 not
>> supported on your arch
>>
>> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
>> ---
>>   .../syscalls/get_mempolicy/get_mempolicy01.c       |   10 ++++++++++
>>   testcases/kernel/syscalls/mbind/mbind01.c          |    9 +++++++++
>>   2 files changed, 19 insertions(+), 0 deletions(-)
>>
>>
>> ------------------------------------------------------------------------------
>> Live Security Virtual Conference
>> Exclusive live event will cover all the ways today's security and
>> threat landscape has changed and how IT managers can respond.
>> Discussions
>> will include endpoint security, mobile security and the latest in
>> malware
>> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>



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
