From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 10 Feb 2021 12:37:34 -0700
Subject: [LTP] CVE-2020-29373 reproducer fails on v5.11
In-Reply-To: <b74d54ed-85ba-df4c-c114-fe11d50a3bce@gmail.com>
References: <YCQvL8/DMNVLLuuf@pevik>
 <b74d54ed-85ba-df4c-c114-fe11d50a3bce@gmail.com>
Message-ID: <270c474f-476a-65d2-1f5b-57d3330efb04@kernel.dk>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/10/21 12:32 PM, Pavel Begunkov wrote:
> On 10/02/2021 19:08, Petr Vorel wrote:
>> Hi all,
>>
>> I found that the reproducer for CVE-2020-29373 from Nicolai Stange (source attached),
>> which was backported to LTP as io_uring02 by Martin Doucha [1] is failing since
>> 10cad2c40dcb ("io_uring: don't take fs for recvmsg/sendmsg") from v5.11-rc1.
> 
> Thanks for letting us know, we need to revert it

I'll queue up a revert. Would also be nice to turn that into
a liburing regression test.

-- 
Jens Axboe

