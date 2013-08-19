Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VBELR-0007Db-EK
	for ltp-list@lists.sourceforge.net; Mon, 19 Aug 2013 01:33:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VBELP-0003HW-Bh
	for ltp-list@lists.sourceforge.net; Mon, 19 Aug 2013 01:33:21 +0000
Message-ID: <521175B9.4000108@cn.fujitsu.com>
Date: Mon, 19 Aug 2013 09:32:41 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1375192031-10636-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130805154118.GA16172@rei> <52009D26.4030609@oracle.com>
	<520A34B4.3020502@oracle.com> <520AFFFB.6040708@redhat.com>
	<520B1666.6010808@oracle.com> <520B3FC4.5020809@redhat.com>
In-Reply-To: <520B3FC4.5020809@redhat.com>
Subject: Re: [LTP] [PATCH] max_map_count: corrected max_map_count condition
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: ltp-list@lists.sourceforge.net, bob.picco@oracle.com

On 08/14/2013 04:28 PM, Zhouping Liu wrote:
> On 08/14/2013 01:32 PM, Stanislav Kholmanskikh wrote:
>>
>> On 08/14/2013 07:56 AM, Zhouping Liu wrote:
>>> On 08/13/2013 09:29 PM, Stanislav Kholmanskikh wrote:
>>>>
>>>> On 08/06/2013 10:52 AM, Stanislav Kholmanskikh wrote:
>>>>> On 08/05/2013 07:41 PM, chrubis@suse.cz wrote:
>>>>>> Hi!
>>>>> Hi, Cyril.
>>>>>>> * kernel test for max_map_count_sysctl is:
>>>>>>>      /* Too many mappings? */
>>>>>>>      if (mm->map_count > sysctl_max_map_count)
>>>>>>>        return -ENOMEM;
>>>>>> Hmm, that looks like we allow the map_count to became one greater 
>>>>>> than
>>>>>> max_map_count, is this known bug?
>>>>> I'm not sure whether this is a bug or feature but in fact mm/mmap.c 
>>>>> contains
>>>>> this strict condition.
>>>>>
>>>>>>>     so in LTP test map_count should be greater than max_map_count 
>>>>>>> by 1
>>>>>>>
>>>>>>> * only [vsyscall] is allocated without incrementing mm->map_count
>>>>>> That also looks strange, do you know why one is allocated without
>>>>>> incrementing it and another with?
>>>>>>
>>>>> [vdso] is allocated this way:
>>>>> 1) load_elf_binary (fs/binfmt_elf.c)
>>>>> 2) arch_setup_additional_pages (arch/x86/vdso/vdso32-setup.c)
>>>>> 3) install_special_mapping (mm/mmap.c)
>>>>> 4) insert_vm_struct (mm/mmap.c)
>>>>> 5) vma_link (mm/mmap.c) increases mm->map_count++
>>>
>>> Sorry for lately replying, as I'm a little busy these days...
>>>
>>> we all know (you have explained) VDSO vma is inserted by 
>>> install_special_mapping(), and the sysctl_max_map_count
>>> don't check the special vma, that's the reason why map_count is to 
>>> became one greater than max_map_count,
>>
>> The function install_special_mapping() __does__ increase mm->map_count.
>> [vdso] is mapped one of the first vmas when a binary is executed so 
>> it's not a problem or bug that sysctl_max_map_count is not checked in
>> install_special_mapping().
> 
> yeah, it sounds reasonable.
> 
>>
>> So we should not filter out [vdso] string from /proc/[pid]/maps (as we 
>> have in git test version).
>>
>> I mean that the reason why map_count could be one greater than 
>> max_map_count is not related to [vdso] or [vsyscall]. It's caused by 
>> the kernel
>> test I posted above.
> 
> I think so after I recheck the code again and again... sorry for the 
> misunderstanding.
> 
> so your patch looks good for me.
> 
> Reviewed-by: Zhouping Liu <zliu@redhat.com>

Applied, thank you all involved.

Wanlong Gao

> 
> Thanks,
> Zhouping
> 
> ------------------------------------------------------------------------------
> Get 100% visibility into Java/.NET code with AppDynamics Lite!
> It's a free troubleshooting tool designed for production.
> Get down to code-level detail for bottlenecks, with <2% overhead. 
> Download for free and get started troubleshooting in minutes. 
> http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
