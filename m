From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 22 Oct 2019 14:05:26 +0200
Subject: [LTP] Bug report in read_all.c
In-Reply-To: <0641c15377874db893088e4f65102ec6@aptaiexm02f.ap.qualcomm.com>
References: <0641c15377874db893088e4f65102ec6@aptaiexm02f.ap.qualcomm.com>
Message-ID: <87ftjlnfy1.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Xiang Li <lixian@qti.qualcomm.com> writes:

> Hi,
>
> I would like to report a bug I found lately in LTP testcase source code.
> The bug is located at: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/read_all/read_all.c#L123
> This bug may cause the read_all testcase terminated unexpectedly before the reading thread complete its job.
>
> In the source code, at the end of the function queue_pop(), it stores i + 1 into the q->front to update the front indicator.
> But under some circumstances it will store 16384 which is the default length of the queue size.
> When this happens, the next time queue_pop() is called, it will perform a read action that overstep the array boundary which is q->data[16384].
> If the value stored there is 0, the queue_pop() will immediately return 0 and the whole testcase is broken.
> This happens when there is a whole file path stores exactly at the end of the data array. In this situation, i equals 16383 when while() ends.
>
> Modifying i + 1 to (i + 1) % QUEUE_SIZE at the source code Line#123 can easily fix it.
> This bug is not triggered on every machine because the files are different between target machine.
> Adjust the length of the QUEUE_SIZE will help you reproduce this bug.

Thanks! This looks correct. Also we can replace

if (++i >= QUEUE_SIZE)
   i = 0;

with

i = (i + 1) % QUEUE_SIZE;

for consistency
	

>
>
> Regards,
> Xiang


-- 
Thank you,
Richard.
