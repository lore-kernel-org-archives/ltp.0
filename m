Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XBK2j-0003gG-E6
	for ltp-list@lists.sourceforge.net; Sun, 27 Jul 2014 08:42:57 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XBK2i-00025m-73
	for ltp-list@lists.sourceforge.net; Sun, 27 Jul 2014 08:42:57 +0000
Message-ID: <53D4BB5B.5030701@cn.fujitsu.com>
Date: Sun, 27 Jul 2014 16:42:03 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1405419229-4222-1-git-send-email-wangxg.fnst@cn.fujitsu.com>	<1405419229-4222-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<38788431.12648558.1405933467675.JavaMail.zimbra@redhat.com>
	<53CCD8DB.7030703@cn.fujitsu.com> <53CCDBFA.4060209@cn.fujitsu.com>
In-Reply-To: <53CCDBFA.4060209@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] syscalls/getcwd04.c: regression test for
	getcwd(2)
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net, Savkov <asavkov@redhat.com>, Artem@edo.cn.fujitsu.com

Hi,

On 07/21/2014 05:23 PM, Xiaoguang Wang wrote:
> Hi Jan, Wanlong,
> 
> On 07/21/2014 05:09 PM, Wanlong Gao wrote:
>> On 07/21/2014 05:04 PM, Jan Stancek wrote:
>>>
>>> looks good to me.
>>>
>>>>> I have run this test case in RHEL7.0GA, Fedora19, v3.11-7758-g232d2d6 and 3.16.0-rc4+.
>>>>> RHEL7.0GA has this kernel bug, so this test case fails.
>>> I can confirm this, with note that I've seen it happen only on systems with 2+ CPUs.
>>
>> If this note is truth, we should judge the nr_cpus in this case to make sure it always
>> gives the right result.
> 
> Thanks Jan for pointing this.
> I'll have a look at these three related kernel patches again. If needed, I'll sent a 
> v2 version including the judgment about number of cpus, thanks!

I'm not that familiar with kernel VFS layer code and spent time to look into the code, sorry for the delay.

Now I think it is impossible to reproduce this bug in only one cpu machine, below is the possible reason,
please check it(The kernel source code I used is RHEL7.0GA).
First let me explain why this bug is triggered. Look at the getcwd(2)'s implementation,

SYSCALL_DEFINE2(getcwd, ...)
----prepend_path(...)

In prepend_path(), it will use a kernel sequence lock named rename_lock to check whether the corresponding
operation in prepend_path() is valid. If it's valid, everything is OK. But if it's not(for example, some
other kernel code flow call a write_seqlock() on the rename_lock), then prepend_path() need to restart the entire 
operation, but kernel commit 232d2d6 patch forgot to reinitialize dentry/vfsmount/mnt, in this time, the dentry
is already the root dentry, so gewcwd(2) will return a "/", bug is triggered.

But when we only have one cpu, when we are in  prepend_path(),  If I understand
right, I think there is no operation in prepend_path() that will cause the current kernel code flow to sleep or give up
the cpu voluntarily and kernel is preempt disabled, only when the getcwd(2) operation completes, can a
process switch happen when returning to user space, that says we can ensure there is no other kernel code flow
have a chance to  operate rename_lock in kernel when a getcwd(2) is in progress.

So I'll send a V2 patch including the judgment about number of cpus. If system only has one cpu, it will
print a TCONF, thanks!


Regards,
Xiaoguang Wang
> 
> Regards,
> Xiaoguang Wang
>>
>> Thanks,
>> Wanlong Gao
>>  
>>
>> .
>>
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
