From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 30 Aug 2018 09:17:22 +0800
Subject: [LTP] [PATCH 3/4] syscalls/mlock201: Add new testcase
In-Reply-To: <1936332281.43470556.1535546553712.JavaMail.zimbra@redhat.com>
References: <1534844339-8655-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1534844339-8655-3-git-send-email-yangx.jy@cn.fujitsu.com>
 <864746561.43466655.1535545169373.JavaMail.zimbra@redhat.com>
 <1936332281.43470556.1535546553712.JavaMail.zimbra@redhat.com>
Message-ID: <5B8745A2.7010005@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/08/29 20:42, Jan Stancek wrote:
> ----- Original Message -----
>> ----- Original Message -----
>>> Check the basic functionality of mlock2(2) since kernel v2.6.9.
> Missed this one:
>    mlock2() is available since Linux 4.4.
Hi Jan,

Thanks for your review.

It seems that mlock2() has been backported by some distros(e.g. 
RHEL7.6), so i use tst_syscall()
instead of .min_kver to check if mlock2() is supported.

 From mlock2() manpage:
Before Linux 2.6.8, a process must be privileged (CAP_IPC_LOCK) in order 
to lock memory and the
RLIMIT_MEMLOCK soft resource limit defines a limit on how much memory 
the process may lock.
Since Linux 2.6.9, no limits are placed on the amount of memory that a 
privileged process can lock
and the RLIMIT_MEMLOCK soft resource limit instead defines a limit on 
how  much memory an unprivileged\
process may lock.

I just check the behavior of mlock2() since Linux 2.6.9.
>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> + * Description:
>>> + * Check the basic functionality of the mlock2(2) since kernel v2.6.9:
>>> + * 1) Use mlock2(2) without MLOCK_ONFAULT to lock memory in the specified
>>> + *    range that is multiples of page size or not, and the VmLck from
>>> + *    /proc/PID/status shows correct size of memory that is locked by PID.
>>> + * 2) Use mlock2(2) with MLOCK_ONFAULT to lock memory in the specified
>>> + *    range that is multiples of page size or not, and the VmLck from
>>> + *    /proc/PID/status show correct size of memory that is locked by PID.
>> Can we also check if MLOCK_ONFAULT doesn't make non-present pages present,
>> but it still locks present pages? (mincore(2) or /proc/pid/pagemap)
I will try to check this point as you suggested.

Thanks,
Xiao Yang
>> Regards,
>> Jan
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>
>
>



