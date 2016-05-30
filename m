From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Mon, 30 May 2016 21:56:58 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <CA+icZUXd0TC36TgYjMDg-6+f-M555C0yu3Pz4R410wutPDNi-A@mail.gmail.com>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
 <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
 <20160530151115.GA8207@rei.lan>
 <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
 <20160530153220.GB8207@rei.lan>
 <CA+icZUXd0TC36TgYjMDg-6+f-M555C0yu3Pz4R410wutPDNi-A@mail.gmail.com>
Message-ID: <CA+icZUUm8-L1FDBMZiGdv0CL4Y=4zxj9si-pxtfkne3nG4eqHQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 5/30/16, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> [...]
>>> Is there a testcase around - runnable via "runltp -s $testcase_script".
>>
>> These are executed as a part of syscall tests.
>>
>> You can simply do ./runltp -s xattr to execute all testcases that have
>> xattr in their name.
>>
>
> Running xattr testcase has shown a different issue.
> In [1] Andreas explains why cgroup_xattr tests fails...
>
> "The test seems to try getting/setting an xattr named "trusted." (no
> suffix). That's an invalid name; such invalid names are rejected since
> commit 98e9cb571 "vfs: Distinguish between full xattr names and proper
> prefixes" (v4.5-rc1).
>
> Could you try removing that from the LTP test and rerun it?"
>
> I followed the advice and the attached diff fixes the problem here.
> Xattr testcase runs successfully,
>
> See attached logs for details.
>
> - Sedat -
>
> [1] http://marc.info/?l=linux-fsdevel&m=146463254520809&w=2
>

Andreas send a patch [1] which works fine.

- Sedat -

[1] http://marc.info/?l=linux-fsdevel&m=146463658521851&w=2
