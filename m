From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 15 Jul 2016 06:38:53 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/read02: Don't pass invalid buffer to
 read	when testing for bad fds
In-Reply-To: <1468578250-26463-1-git-send-email-peter.maydell@linaro.org>
References: <1468578250-26463-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <854542372.5188570.1468579133841.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: ltp@lists.linux.it
> Cc: patches@linaro.org
> Sent: Friday, 15 July, 2016 12:24:10 PM
> Subject: [LTP] [PATCH] syscalls/read02: Don't pass invalid buffer to read	when testing for bad fds
> 
> The read02 testcases 1 and 2 are intended to check the handling
> of the read syscall with an invalid fd (should fail EBADF) and
> an fd which is a directory (should fail EISDIR). However a bug
> in the test code meant that it also passed a NULL pointer as
> the buffer argument, and so the test only succeeded because of
> the implementation detail that the kernel happens to check for
> the EBADF and EISDIR errors before it checks the buffer pointer
> validity for an EFAULT error.
> 
> The 'buf' field in the test_case_t structure is supposed to be
> a pointer to the address of the buffer, but it was being
> initialised with the address of the buffer itself; fix this by
> adding the extra indirection via a new 'bufaddr' variable, so
> that the test is checking the condition it intends to and nothing
> more.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I shortened subject a bit and pushed.

Thanks,
Jan
