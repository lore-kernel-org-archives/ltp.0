From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 17 May 2016 16:02:07 +0300
Subject: [LTP] [RFC PATCH 4/4] memcg_stress_test.sh: allocate less than
 CommitLimit bytes
In-Reply-To: <573B140B.8080500@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1461338590-1309-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160512134217.GB32457@rei.lan> <573B140B.8080500@oracle.com>
Message-ID: <573B164F.7040309@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 05/17/2016 03:52 PM, Stanislav Kholmanskikh wrote:
> Hi,
>
> On 05/12/2016 04:42 PM, Cyril Hrubis wrote:
>> Hi!
>>> Given that, (CommitLimit - Committed_AS) with overcommit_memory == 1,
>>> looks to be a suitable formula, since the kernel lets allocate this
>>> amount of memory and there will be some memory for other tasks.
>>
>> I wonder what the original purpose of the test is, it looks to me like
>> the whole point is to attach processes to number of memory cgroups and
>> then stress it by allocating memory while forcing heavy swapping. Hence
>> the $mem_free + $swap_free/2 which is wrong obviously.
>>
>> So for the new formula the CommitLimit seems to be calculated as
>> SWAP + RAM * overcommit_ratio which will default to SWAP + RAM/2 in most
>> of the cases. Wouldn't that cause too much swap trashing in case that you
>> have SWAP == 2 * RAM? Shouldn't be something simple as 0.8 * RAM better
>> for the purpose of the test? Or something as 0.9 * mem_free - 50MB after
>> caches has been dropped?
>
> I'm afraid that const * mem_free couldn't be the best formula, since if
> swap is small we may get an OOM here. At least this is what I get in a
> ldom with 128g memory, and < 1gb swap.
>
> There is an idea. If we set memory.limit_in_bytes of a cgroup to a value
> less than the amount of memory.usage_in_bytes, then activities of
> processes of this cgroup will involve swapping.
>
> So what do you think about this scheme:
>
> mem = RAM * overcommit_ratio - CommitLimit

Sorry, I meant Committed_AS here.
