From: Steve Muckle <smuckle@google.com>
Date: Fri, 15 Feb 2019 16:17:32 -0800
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <20190215132251.GB26339@rei>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
 <CAFA6WYO8qg79rQ-qwU3i6FpfNRQhiTNXzGHtDsJ6FpTty6W77g@mail.gmail.com>
 <20190215121611.GA14270@rei>
 <CAFA6WYOF1Kh1rspdiPgne9q4jUQsMW4p5BN_J4evcsr9O-KD1Q@mail.gmail.com>
 <20190215132251.GB26339@rei>
Message-ID: <4cae2a11-47c2-c319-19cf-9a8fecc7793d@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/15/2019 05:22 AM, Cyril Hrubis wrote:
> Hi!
>> Thanks for the pointers. IIUC, you are referring to following change:
>>
>> -       TEST(syncfs(fd));
>> +       TEST(tst_syscall(__NR_syncfs, fd));
>>
>> If yes, then I will incorporate it.
> 
> The most complete solution is configure check + fallback definition.
> 
> Have a look at:
> 
> include/lapi/execveat.h
> m4/ltp-execveat.m4
> configure.ac

For tests in testcases/kernel/syscalls, should the tests typically 
directly call the syscall? I'd think this is preferable to the use of C 
library wrappers as these tests (by their location in the tree) seem to 
be focused on the syscall functionality in the kernel.

thanks,
steve
