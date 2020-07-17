From: Vikas Kumar <vikas.kumar2@arm.com>
Date: Fri, 17 Jul 2020 10:09:16 +0530
Subject: [LTP] [PATCH V8] syscall: Add io_uring related tests
In-Reply-To: <20200716143352.GA11713@yuki.lan>
References: <20200714032408.9201-1-vikas.kumar2@arm.com>
 <20200716143352.GA11713@yuki.lan>
Message-ID: <4144f20f-6097-9e62-0328-c74c09bb68fe@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> I've finished the test code and pushed, thanks.
>
> I've changed it so that it actually reads data and checks the result,
> and also properly unmaps the buffers (fixes failures with -i 10 passed
> to the test), the diff is attached below.
>
> Also I will have to check if we need the read/write barriers, I guess
> that the way we use the interface it's safe, since the syscalls provide
> natural boundary between kernel and userspace. But they would be needed
> for a different tests anyways.
>
> Also I had to remove the IORING_SETUP_IOPOLL flag since that made all
> SQEs fail with EOPNOTSUPP for me.

Thank you very much for help and change in test code.


Regards,

Vikas

