From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Jul 2016 09:02:39 -0400 (EDT)
Subject: [LTP] [PATCH] kernel/include/aarch64.in: Fix incorrect numbers
 for	kcmp and getrandom
In-Reply-To: <1469110469-19351-1-git-send-email-peter.maydell@linaro.org>
References: <1469110469-19351-1-git-send-email-peter.maydell@linaro.org>
Message-ID: <88526423.7367039.1469192559025.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Peter Maydell" <peter.maydell@linaro.org>
> To: ltp@lists.linux.it
> Cc: patches@linaro.org
> Sent: Thursday, 21 July, 2016 4:14:29 PM
> Subject: [LTP] [PATCH] kernel/include/aarch64.in: Fix incorrect numbers for	kcmp and getrandom
> 
> The syscall numbers listed for kcmp and getrandom for aarch64 seem
> to have been incorrectly copied from 32-bit ARM. 64-bit ARM uses
> the generic syscall numbers, which are 272 and 278.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Pushed.

Thanks,
Jan
