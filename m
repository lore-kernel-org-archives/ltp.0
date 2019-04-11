From: Enji Cooper <yaneurabeya@gmail.com>
Date: Thu, 11 Apr 2019 08:16:00 -0700
Subject: [LTP] [PATCH v1] Fix build error caused by
	-Werror-implicit-function-declaration for Android
In-Reply-To: <1554992323-14338-1-git-send-email-ruanzw@xiaopeng.com>
References: <1554992323-14338-1-git-send-email-ruanzw@xiaopeng.com>
Message-ID: <F2D8419F-5149-4D85-BBBC-53B268A38065@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On Apr 11, 2019, at 07:18, Zhengwang Ruan <ruanzw@xiaopeng.com> wrote:
> 
> Fix build errors caused by -Werror-implicit-function-declaration by add missing
> <string.h> and <strings.h> for Android.

Comment next time: it would be a good idea a to note what functions were missing.

> Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>

Reviewed-by: Enji Cooper <yaneurabeya@gmail.com>

> ---
> include/tst_numa.h                                            | 2 ++
> include/tst_test.h                                            | 1 +
> testcases/kernel/syscalls/copy_file_range/copy_file_range01.c | 1 +
> testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c             | 2 +-
> testcases/kernel/syscalls/epoll_wait/epoll_wait01.c           | 1 +
> 5 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/tst_numa.h b/include/tst_numa.h
> index a4cd1be..4f98066 100644
> --- a/include/tst_numa.h
> +++ b/include/tst_numa.h
> @@ -7,6 +7,8 @@
> #ifndef TST_NUMA_H__
> #define TST_NUMA_H__
> 
> +#include <string.h>
> +
> /**
>  * Numa nodemap.
>  */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index cf2447f..25b9763 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -24,6 +24,7 @@
> 
> #include <unistd.h>
> #include <limits.h>
> +#include <string.h>
> 
> #include "tst_common.h"
> #include "tst_res_flags.h"
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> index 2bca8a4..61a6042 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> @@ -15,6 +15,7 @@
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <errno.h>
> +#include <stdlib.h>
> #include "tst_test.h"
> #include "tst_safe_stdio.h"
> #include "lapi/syscalls.h"
> diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
> index e837913..4df55b5 100644
> --- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
> +++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
> @@ -31,7 +31,7 @@
> 
> #include <sys/epoll.h>
> #include <poll.h>
> -#include <string.h>
> +#include <strings.h>

Just a general question: did you test the non-Android case?

> #include <errno.h>
> #include "tst_test.h"
> 
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> index 0ded127..6099b84 100644
> --- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> @@ -26,6 +26,7 @@
> #include <sys/epoll.h>
> #include <poll.h>
> #include <string.h>
> +#include <strings.h>
> #include <errno.h>
> 
> #include "tst_test.h"
> -- 
> 2.7.4
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
