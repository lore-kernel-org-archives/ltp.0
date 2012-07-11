Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Sotwk-0004Sn-5h
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 10:15:02 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sotwg-0003wV-Az
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 10:15:02 +0000
Received: by pbbrq2 with SMTP id rq2so1756180pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Jul 2012 03:14:52 -0700 (PDT)
Message-ID: <4FFD5210.1070305@casparzhang.com>
Date: Wed, 11 Jul 2012 18:14:40 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4FAA6A83.8010100@casparzhang.com>
	<4f473639-dcf2-43c7-ba27-be826fbb81d2@zmail17.collab.prod.int.phx2.redhat.com>
	<20120518180534.088a07b2@Gantu>
In-Reply-To: <20120518180534.088a07b2@Gantu>
Subject: Re: [LTP] [PATCH] Simple tests for cross memory attach
 (process_vm_[readv|writev] syscalls)
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
To: Christopher Yeoh <cyeoh@au1.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On 05/18/2012 04:35 PM, Christopher Yeoh wrote:
> On Tue, 15 May 2012 10:56:17 -0400 (EDT)
> Jan Stancek <jstancek@redhat.com> wrote:
>>
>> Hi,
>>
>> I looked at testcases sent by Chris. Good news is, they
>> do not overlap (in terms of functionality) with mine :-).
>>
>> The patch need some polishing to match the style guide:
>> - indentation
>> - I think output should be TINFO, rather than plain printf
>> - single statement if without { }
>> - I would split some code to more functions, for example
>> process_vm_writev01.c main function seems complex
>
> Thanks for the feedback. I'll have a go at reworking them.
>
>> As for test organization, I think we need to decide 2 issues:
>> 1. directory structure
>> a)
>>    testcases/kernel/syscalls/cma/
>>    testcases/kernel/syscalls/cma/process_vm_readv
>>    testcases/kernel/syscalls/cma/process_vm_writev
>> b)
>>    testcases/kernel/syscalls/process_vm_readv
>>    testcases/kernel/syscalls/process_vm_writev
>>
>> I'm preferring a) as these 2 syscalls are closely related,
>> and we already have need to share code.
>
> that would be fine with me.
>
>> 2. how to invoke new syscalls
>> a)
>> Patch from Chris is defining new syscall numbers in test and
>> using syscall(2).
>>
>> b)
>> My patch adds configure check for glibc wrappers
>> process_vm_readv/writev and if those does not exists it checks for
>> __NR_process_vm_readv.
>>
>> I think we should not define syscall numbers in tests directly,
>> but I'm relying on LTP maintainers to provide guidance here.
>
> I agree - the configure check is much better. I was just trying to get
> something working :-)
>
> Regards,
>
> Chris
>

Hi Chris, not sure if you're working on a v2 to these CMA simple tests, 
if not, mind /me doing some update based on your version?

Thanks,
Caspar


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
