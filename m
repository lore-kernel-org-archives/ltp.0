From: Vikas Kumar <vikas.kumar2@arm.com>
Date: Tue, 9 Jun 2020 10:09:06 +0530
Subject: [LTP] [PATCH V6] syscall: Add io_uring related tests
In-Reply-To: <20200601053550.3848-1-vikas.kumar2@arm.com>
References: <20200601053550.3848-1-vikas.kumar2@arm.com>
Message-ID: <14e7e598-b0aa-5c62-3cb3-726d29e315da@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/06/20 11:05 am, Vikas Kumar wrote:
> Added asynchronous I/O API tests for io_uring_setup(), io_uring_register()
> and io_uring_enter(). These tests intend to validate io_uring operations.
>
> 1. io_uring_setup() creates submission queue and completion queue to
>     perform subsequent operations on the io_uring instance.
> 2. io_uring_register() registers user buffers in kernel for long term
>     usese.
> 3. io_uring_enter() initiates I/O operations using the shared SQ and CQ
>     queue.
>
> Signed-off-by: Vikas Kumar<vikas.kumar2@arm.com>

Gentle reminder. Any updates on this patch ?

- Vikas



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200609/fa88d6f8/attachment-0001.htm>
