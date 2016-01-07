From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Jan 2016 03:42:54 -0500 (EST)
Subject: [LTP] [PATCH] remove inclusion of deprecated sys/kdaemon.h
 header
In-Reply-To: <1452152281-128165-1-git-send-email-raj.khem@gmail.com>
References: <1452152281-128165-1-git-send-email-raj.khem@gmail.com>
Message-ID: <65521883.5037794.1452156174714.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Khem Raj" <raj.khem@gmail.com>
> To: ltp@lists.linux.it
> Sent: Thursday, 7 January, 2016 8:38:01 AM
> Subject: [LTP] [PATCH] remove inclusion of deprecated sys/kdaemon.h header
> 
> glibc 2.23+ has dropped this header and moreover its not used in
> testcase
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>

Applied.

Regards,
Jan

> ---
> Upstream-Status: Pending
> 
>  testcases/kernel/syscalls/bdflush/bdflush01.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/bdflush/bdflush01.c
> b/testcases/kernel/syscalls/bdflush/bdflush01.c
> index df739f1..a529ba9 100644
> --- a/testcases/kernel/syscalls/bdflush/bdflush01.c
> +++ b/testcases/kernel/syscalls/bdflush/bdflush01.c
> @@ -81,7 +81,6 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <sys/stat.h>
> -#include <sys/kdaemon.h>
>  
>  #include "test.h"
>  #include "linux_syscall_numbers.h"
> --
> 2.6.4
> 
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
