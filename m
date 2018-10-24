From: Hongzhi, Song <hongzhi.song@windriver.com>
Date: Wed, 24 Oct 2018 10:29:56 +0800
Subject: [LTP] [PATCH] open_posix_testsuite/mmap24-2: Relax condition a
 bit
In-Reply-To: <20181017083945.GA4192@rei.lan>
References: <1539226733-18212-1-git-send-email-hongzhi.song@windriver.com>
 <20181016130209.GB6980@rei>
 <21d93aaa-3047-42b4-cb8e-747ef1036a53@windriver.com>
 <20181017083945.GA4192@rei.lan>
Message-ID: <2de81dcd-301e-07bc-23c5-5e3d00a9c136@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 10/17/2018 04:39 PM, Cyril Hrubis wrote:
> Hi!
>>> Hmm, it's always complicated with these POSIX tests, since we have to
>>> follow the POSIX specification there.
>>>
>>> And the POSIX clearly says that mmap() shall fail with ENOMEM if
>>> MAP_FIXED was specified, and the range [addr,addr+len) exceeds that
>>> allowed for the address space of a process. So I guess that the best
>>> solution here would be limiting the address space with rlimit, so that
>>> we actually happen to hit the ENOMEM instead of EINVAL.
>> I just referred to follow commit which has similar issue.
>>
>>   ?????? [commit id: e7bab61882847]
>>   ?????? syscalls/mmap15: relax condition a bit
>>
>>   ?????? High address is arch specific, and it also occasionally changes
>>   ?????? as can be se?????????????????????????????????en in history of this test.
>>
>>   ?????? Relax the co?????????????????????????????????ndition and accept both ENOMEM and
>> EINVAL
>>   ?????? as expected outcome.
>>   ?????? ?????????????????????????????????
>>   ?????? Fixes: #390
> The difference is that the mmap15 is a Linux specific test, we can
> accept any behavior we think is reasonable.
>
>> Mips returns EINVAL and never returns ENOMEM if [addr+len]
>>   ??exceeds task size. I think it's has no relation with rlimit.
> While the POSIX tests are written to test the conformity of the
> implementation, we have to stick to POSIX there and actually it seems to
> require that ENOMEM has to be returned if [addr,addr+len) exceeds that
> allowed for the address space of a process, so I guess that mips is not
> strictly conforming to POSIX here,

Hi Cyril,

The POSIX specification says:
"If MAP_FIXED is set, mmap() may return MAP_FAILED and set errno to 
[EINVAL]."
[http://pubs.opengroup.org/onlinepubs/9699919799/functions/mmap.html]

So I think the mips kernel remains POSIX compliant.

I hope to send V2 with commit log explaining this clearly.
With the patch, the testcase will support more Arches.


--Hongzhi


> however that is not a reason to
> change the test. And in this case it's not a big deal and we can
> possilby just ignore the failure in the same way we do for a few rwlock
> tests where Linux behavior differs from the one mandated by POSIX.
>

