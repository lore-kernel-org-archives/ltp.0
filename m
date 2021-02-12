From: Pavel Begunkov <asml.silence@gmail.com>
Date: Fri, 12 Feb 2021 13:05:25 +0000
Subject: [LTP] CVE-2020-29373 reproducer fails on v5.11
In-Reply-To: <YCZ5ZS5Sr2tPiUvP@pevik>
References: <YCQvL8/DMNVLLuuf@pevik>
 <b74d54ed-85ba-df4c-c114-fe11d50a3bce@gmail.com>
 <270c474f-476a-65d2-1f5b-57d3330efb04@kernel.dk> <YCZ5ZS5Sr2tPiUvP@pevik>
Message-ID: <8e7ad2f3-eb35-71fe-5989-b5f09476eb24@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/02/2021 12:49, Petr Vorel wrote:
> Hi all,
> 
>> On 2/10/21 12:32 PM, Pavel Begunkov wrote:
>>> On 10/02/2021 19:08, Petr Vorel wrote:
>>>> Hi all,
> 
>>>> I found that the reproducer for CVE-2020-29373 from Nicolai Stange (source attached),
>>>> which was backported to LTP as io_uring02 by Martin Doucha [1] is failing since
>>>> 10cad2c40dcb ("io_uring: don't take fs for recvmsg/sendmsg") from v5.11-rc1.
> 
>>> Thanks for letting us know, we need to revert it
> 
>> I'll queue up a revert. Would also be nice to turn that into
>> a liburing regression test.
> 
> Jens (or others), could you please have look that the other commit 907d1df30a51
> ("io_uring: fix wqe->lock/completion_lock deadlock") from v5.11-rc6 didn't cause
> any regression? Changed behavior causing io_uring02 test [1] and the original
> reproducer [2] to fail is probably a test bug, but better double check that.

Thanks for keeping an eye on it. That's on the test because DRAIN doesn't
punt to worker threads anymore, and DRAIN is used for those prepended
requests.

Can we just use IOSQE_ASYNC instead and fallback to DRAIN for older kernels
as you mentioned? It would be much more reliable. Or replace IOSQE_IO_DRAIN
with IOSQE_IO_LINK, but there are nuances to that... 

> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/syscalls/io_uring/io_uring02.c
> [2] https://lore.kernel.org/io-uring/YCQvL8%2FDMNVLLuuf@pevik/
> 

-- 
Pavel Begunkov
