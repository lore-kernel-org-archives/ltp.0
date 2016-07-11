From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Jul 2016 08:19:30 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/mmap16: close open files in cleanup path
In-Reply-To: <1467384925-24792-1-git-send-email-peter.maydell@linaro.org>
References: <1467384925-24792-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <1194994844.3639216.1468239570693.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: ltp@lists.linux.it
> Cc: patches@linaro.org
> Sent: Friday, 1 July, 2016 4:55:25 PM
> Subject: [LTP] [PATCH] syscalls/mmap16: close open files in cleanup path
> 
> If the mmap16 test fails while the do_test() function
> still has its filedescriptor open, the cleanup function's
> attempt to unmount will fail with EBUSY, resulting in a
> lot of noise in the test log, a leaked mounted filesystem
> and unnecessary test failures later in the run.
> 
> Make the do_test() file descriptor global so we can
> close it in the cleanup function if necessary.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi,

pushed with small change, which treats uninitialized fd as -1, not 0.

Regards,
Jan
