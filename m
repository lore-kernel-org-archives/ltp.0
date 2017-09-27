From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Sep 2017 09:52:13 +0800
Subject: [LTP] LTP release and code freeze
In-Reply-To: <CA+G9fYtv_FT=hZhHWMD92nQpv2S7UUdK=fK7EjGTcP+WWHkYVw@mail.gmail.com>
References: <CA+G9fYs59g3eHyucNRJQ1+vxmwykZ_hHaUbANREpHXJ9C9u=TQ@mail.gmail.com>
 <20170919080444.GA14080@rei>
 <CA+G9fYtTBa4rva8eBZoxoBb31r6hSVXbmOSBn=uFAGSLGqnwyQ@mail.gmail.com>
 <CAEemH2e0t0ETA4+db=cvfzk+9s9sJDyfjf-zqni74KHRZtYYRg@mail.gmail.com>
 <CA+G9fYtv_FT=hZhHWMD92nQpv2S7UUdK=fK7EjGTcP+WWHkYVw@mail.gmail.com>
Message-ID: <CAEemH2fx76meJH1ij4bBh0n6aZJVt72Jz5qO9sb-j06-3WT+Dw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 27, 2017 at 3:18 AM, Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
> On 26 September 2017 at 01:51, Li Wang <liwang@redhat.com> wrote:
>> On Tue, Sep 26, 2017 at 4:00 AM, Naresh Kamboju
>> <naresh.kamboju@linaro.org> wrote:
>>> Hi Cyril,
>>>
>>> On 19 September 2017 at 01:04, Cyril Hrubis <chrubis@suse.cz> wrote:
>>>> Hi!
>>>>> Regarding the LTP September 2017 release,
>>>>> Identifying bugs / issues / limitation / pre-requirements of LTP
>>>>> testing on ARM64 architecture is crucial at our end. We would like to
>>>>> test LTP pre-release candidate on ARM64 architecture.
>>>>> Please announce code freeze and allow time to validate test code.
>>>>
>>>> I guess that you can start with the validation now. We haven't declared
>>>> the freeze formally yet, but there are only a few possible changes that
>>>> may get in the release. The thp01 is broken on new kernels, that one
>>>> should get in for sure. Then possibly something like ten tests may end
>>>> up affected by possible changes in the CVE tests, which should be easy
>>>> enough to retest if needed.
>>>
>>> Tested LTP syscalls on ARM64 architecture and the results looks good
>>> on 4.12 and 4.13 kernel.
>>
>> FYI:
>>
>> I run the latest LTP on x86_64 arch and only get 1
>> failure(madvise08.c) on 4.14-rc1 kernel.
>>
>> # ./madvise08
>> tst_test.c:908: INFO: Timeout per run is 0h 05m 00s
>> madvise08.c:87: INFO: System core pattern is 'core'
>> madvise08.c:91: INFO: Temporary core pattern is '/tmp/H9HNr1/dump-%p'
>> madvise08.c:133: INFO: Dump file should be dump-1368
>> madvise08.c:215: FAIL: Found sequence in dump when MADV_DONTDUMP set
>> madvise08.c:133: INFO: Dump file should be dump-1369
>> madvise08.c:221: PASS: madvise(..., MADV_DODUMP)
>>
>> Summary:
>> passed   1
>> failed   1
>> skipped  0
>> warnings 0
>>
>
> On 4.14.0.rc2 on ARM64 architecture the madvise08 test pass.
>
> Kernel Version: 4.14.0-rc2-00044-ge365806
> Machine Architecture: aarch64
> LTP version: 20170516-277-g247466a63
>
> tst_test.c:908: INFO: Timeout per run is 0h 05m 00s
> madvise08.c:87: INFO: System core pattern is '|/bin/false'
> madvise08.c:91: INFO: Temporary core pattern is
> '/tmp/ltp-InS0HOqMuy/14UUcU/dump-%p'
> madvise08.c:133: INFO: Dump file should be dump-5076
> madvise08.c:217: PASS: madvise(..., MADV_DONTDUMP)
> madvise08.c:133: INFO: Dump file should be dump-5077
> madvise08.c:221: PASS: madvise(..., MADV_DODUMP)
>
> Summary:
> passed   2
> failed   0
> skipped  0
> warnings 0
>
>
>> After do some research, I found that is a kernel regression bug which
>> has been fixed by an unmerge patch in LKML:
>> https://lkml.org/lkml/2017/9/18/541
>
> Is it merged in -rc2 ?

No, It have not be merged.

This BUG is actually a coredump bug, and only  found on x86_64 arch
with kernel configuration 'CONFIG_X86_INTEL_MPX' enabled.


The fallback is like:

elf_core_dump -> vma_dump_size -> always_dump_vma -> arch_vma_name

since the VM_MPX define to wrong number, arch_vma_name() return [mpx]
for all private memory, so vma_dump_size() goto whole dump branch and
our MADV_DONTDUMP was ignore there.



-- 
Li Wang
liwang@redhat.com
