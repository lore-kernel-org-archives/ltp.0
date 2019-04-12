From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Fri, 12 Apr 2019 10:12:08 +0800
Subject: [LTP] [RFC PATCH 2/3] Add more missing <string.h> and
 <strings.h> includes
In-Reply-To: <20190411233115.32744-3-pvorel@suse.cz>
References: <20190411233115.32744-1-pvorel@suse.cz>
 <20190411233115.32744-3-pvorel@suse.cz>
Message-ID: <b9e58aac-eb0f-965a-c411-ef44c6a3ef27@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,


-------- Original Message --------
From: Petr Vorel
Sent: Fri, 12 Apr 2019 01:31:14 +0200
To: Ltp
Cc: Petr Vorel, Sandeep Patil, Steve Muckle, Zhengwang Ruan, Cyril 
Hrubis, Petr Vorel
Subject: [RFC PATCH 2/3] Add more missing <string.h> and <strings.h> 
includes
> From: Petr Vorel <petr.vorel@gmail.com>
>
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Instead of this one [1] can be chosen or this can be rebased on [1]
> (commit after [1]). I created it few weeks ago, but didn't consider it
> reasonable to be added. But with next commit, which adds
> -Werror-implicit-function-declaration for all IMHO it makes sense.
>
> Other users of strcmp() and friends aren't causing a failure, probably
> due other header including <string.h>.
>
> Kind regards,
> Petr
>
> [1] http://lists.linux.it/pipermail/ltp/2019-April/011643.html
> ---
>   include/tst_net.h                                             | 1 +
>   include/tst_numa.h                                            | 2 ++
>   lib/tst_af_alg.c                                              | 1 +
>   testcases/kernel/syscalls/acct/acct01.c                       | 1 +
>   testcases/kernel/syscalls/add_key/add_key02.c                 | 1 +
>   testcases/kernel/syscalls/chmod/chmod06.c                     | 1 +
>   testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c     | 1 +
>   testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c     | 1 +
>   testcases/kernel/syscalls/copy_file_range/copy_file_range01.c | 1 +
>   testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c             | 1 +
>   testcases/kernel/syscalls/epoll_wait/epoll_wait01.c           | 1 +
>   testcases/kernel/syscalls/execl/execl01_child.c               | 2 ++
>   testcases/kernel/syscalls/execle/execle01_child.c             | 4 +++-
>   testcases/kernel/syscalls/execlp/execlp01_child.c             | 2 ++
>   testcases/kernel/syscalls/execv/execv01_child.c               | 2 ++
>   testcases/kernel/syscalls/execve/execve01_child.c             | 4 +++-
>   testcases/kernel/syscalls/execve/execve_child.c               | 4 +++-
>   testcases/kernel/syscalls/execvp/execvp01_child.c             | 2 ++
>   testcases/kernel/syscalls/exit/exit02.c                       | 1 +
>   testcases/kernel/syscalls/getcwd/getcwd04.c                   | 1 +
>   testcases/kernel/syscalls/getrandom/getrandom02.c             | 2 ++
>   testcases/kernel/syscalls/ioctl/ioctl08.c                     | 1 +
>   testcases/kernel/syscalls/keyctl/keyctl05.c                   | 1 +
>   testcases/kernel/syscalls/keyctl/keyctl06.c                   | 1 +
>   testcases/kernel/syscalls/link/link08.c                       | 1 +
>   testcases/kernel/syscalls/listxattr/listxattr02.c             | 1 +
>   testcases/kernel/syscalls/llistxattr/llistxattr02.c           | 1 +
>   testcases/kernel/syscalls/lremovexattr/lremovexattr01.c       | 1 +
>   testcases/kernel/syscalls/madvise/madvise10.c                 | 1 +
>   testcases/kernel/syscalls/mkdir/mkdir03.c                     | 1 +
>   testcases/kernel/syscalls/read/read01.c                       | 1 +
>   testcases/kernel/syscalls/request_key/request_key03.c         | 1 +
>   testcases/kernel/syscalls/rmdir/rmdir02.c                     | 1 +
>   testcases/kernel/syscalls/setsockopt/setsockopt03.c           | 1 +
>   testcases/kernel/syscalls/write/write03.c                     | 1 +
>   testcases/kernel/syscalls/writev/writev07.c                   | 1 +
>   testcases/lib/tst_checkpoint.c                                | 1 +
>   testcases/lib/tst_device.c                                    | 1 +
>   testcases/lib/tst_kvcmp.c                                     | 1 +
>   testcases/network/sctp/sctp_big_chunk.c                       | 1 +
>   40 files changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/include/tst_net.h b/include/tst_net.h
> index cb97b7b61..971d5ec2c 100644
> --- a/include/tst_net.h
> +++ b/include/tst_net.h
> @@ -17,6 +17,7 @@
>   
>   #include <arpa/inet.h>
>   #include <errno.h>
> +#include <string.h>
>   
>   #define MAX_IPV4_PREFIX 32
>   #define MAX_IPV6_PREFIX 128
> diff --git a/include/tst_numa.h b/include/tst_numa.h
> index a4cd1be37..4f9806602 100644
> --- a/include/tst_numa.h
> +++ b/include/tst_numa.h
> @@ -7,6 +7,8 @@
>   #ifndef TST_NUMA_H__
>   #define TST_NUMA_H__
>   
> +#include <string.h>
> +
>   /**
>    * Numa nodemap.
>    */
> diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
> index 97be548b4..edf8c0140 100644
> --- a/lib/tst_af_alg.c
> +++ b/lib/tst_af_alg.c
> @@ -5,6 +5,7 @@
>   
>   #include <errno.h>
>   #include <stdlib.h>
> +#include <string.h>

Why not simply include <string.h>  in tst_test.h. I did it in my another 
review thread. This should be OK for most of cases.


Regards,

Zhengwang

>   
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index f58e02584..40316db2e 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -14,6 +14,7 @@
>   #include <pwd.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <string.h>
>   #include <unistd.h>
>   #include <sys/mount.h>
>   
> diff --git a/testcases/kernel/syscalls/add_key/add_key02.c b/testcases/kernel/syscalls/add_key/add_key02.c
> index 6d19ff2d8..85bd7b150 100644
> --- a/testcases/kernel/syscalls/add_key/add_key02.c
> +++ b/testcases/kernel/syscalls/add_key/add_key02.c
> @@ -35,6 +35,7 @@
>    */
>   
>   #include <errno.h>
> +#include <string.h>
>   
>   #include "tst_test.h"
>   #include "lapi/keyctl.h"
> diff --git a/testcases/kernel/syscalls/chmod/chmod06.c b/testcases/kernel/syscalls/chmod/chmod06.c
> index e5bb58fc5..468c7b33d 100644
> --- a/testcases/kernel/syscalls/chmod/chmod06.c
> +++ b/testcases/kernel/syscalls/chmod/chmod06.c
> @@ -39,6 +39,7 @@
>    */
>   #include <pwd.h>
>   #include <errno.h>
> +#include <string.h>
>   #include "tst_test.h"
>   
>   #define MODE_RWX	(S_IRWXU|S_IRWXG|S_IRWXO)
> diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
> index 6eac1f25c..b48703101 100644
> --- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
> +++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
> @@ -54,6 +54,7 @@
>    *      ro  STA_CLK - clock source. unused.
>    */
>   
> +#include <string.h>
>   #include "clock_adjtime.h"
>   
>   static long hz;
> diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
> index 1ce936f96..e73bc8943 100644
> --- a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
> +++ b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime02.c
> @@ -55,6 +55,7 @@
>    *      ro  STA_CLK - clock source. unused.
>    */
>   
> +#include <string.h>
>   #include "clock_adjtime.h"
>   
>   static long hz;
> diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> index 2bca8a403..61a6042d9 100644
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range01.c
> @@ -15,6 +15,7 @@
>   #define _GNU_SOURCE
>   #include <stdio.h>
>   #include <errno.h>
> +#include <stdlib.h>
>   #include "tst_test.h"
>   #include "tst_safe_stdio.h"
>   #include "lapi/syscalls.h"
> diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
> index e837913fb..4be106bc6 100644
> --- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
> +++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl01.c
> @@ -32,6 +32,7 @@
>   #include <sys/epoll.h>
>   #include <poll.h>
>   #include <string.h>
> +#include <strings.h>
>   #include <errno.h>
>   #include "tst_test.h"
>   
> diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> index 0ded12765..6099b84aa 100644
> --- a/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> +++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait01.c
> @@ -26,6 +26,7 @@
>   #include <sys/epoll.h>
>   #include <poll.h>
>   #include <string.h>
> +#include <strings.h>
>   #include <errno.h>
>   
>   #include "tst_test.h"
> diff --git a/testcases/kernel/syscalls/execl/execl01_child.c b/testcases/kernel/syscalls/execl/execl01_child.c
> index 8a6e5123f..84f34428d 100644
> --- a/testcases/kernel/syscalls/execl/execl01_child.c
> +++ b/testcases/kernel/syscalls/execl/execl01_child.c
> @@ -16,6 +16,8 @@
>    * along with this program. If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include <string.h>
> +
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   
> diff --git a/testcases/kernel/syscalls/execle/execle01_child.c b/testcases/kernel/syscalls/execle/execle01_child.c
> index 0ebfaa876..315c8afbf 100644
> --- a/testcases/kernel/syscalls/execle/execle01_child.c
> +++ b/testcases/kernel/syscalls/execle/execle01_child.c
> @@ -16,8 +16,10 @@
>    * along with this program. If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -#define TST_NO_DEFAULT_MAIN
>   #include <stdlib.h>
> +#include <string.h>
> +
> +#define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   
>   int main(int argc, char *argv[])
> diff --git a/testcases/kernel/syscalls/execlp/execlp01_child.c b/testcases/kernel/syscalls/execlp/execlp01_child.c
> index 8a6e5123f..84f34428d 100644
> --- a/testcases/kernel/syscalls/execlp/execlp01_child.c
> +++ b/testcases/kernel/syscalls/execlp/execlp01_child.c
> @@ -16,6 +16,8 @@
>    * along with this program. If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include <string.h>
> +
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   
> diff --git a/testcases/kernel/syscalls/execv/execv01_child.c b/testcases/kernel/syscalls/execv/execv01_child.c
> index 307810c63..8272df67b 100644
> --- a/testcases/kernel/syscalls/execv/execv01_child.c
> +++ b/testcases/kernel/syscalls/execv/execv01_child.c
> @@ -20,6 +20,8 @@
>    * along with this program. If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include <string.h>
> +
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   
> diff --git a/testcases/kernel/syscalls/execve/execve01_child.c b/testcases/kernel/syscalls/execve/execve01_child.c
> index 0ebfaa876..315c8afbf 100644
> --- a/testcases/kernel/syscalls/execve/execve01_child.c
> +++ b/testcases/kernel/syscalls/execve/execve01_child.c
> @@ -16,8 +16,10 @@
>    * along with this program. If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> -#define TST_NO_DEFAULT_MAIN
>   #include <stdlib.h>
> +#include <string.h>
> +
> +#define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   
>   int main(int argc, char *argv[])
> diff --git a/testcases/kernel/syscalls/execve/execve_child.c b/testcases/kernel/syscalls/execve/execve_child.c
> index bcf8ccc69..0402ee325 100644
> --- a/testcases/kernel/syscalls/execve/execve_child.c
> +++ b/testcases/kernel/syscalls/execve/execve_child.c
> @@ -21,8 +21,10 @@
>    *	dummy program which is used by execve02/4/5.c testcase
>    */
>   
> -#define TST_NO_DEFAULT_MAIN
>   #include <stdlib.h>
> +#include <string.h>
> +
> +#define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   
>   int main(int argc, char *argv[])
> diff --git a/testcases/kernel/syscalls/execvp/execvp01_child.c b/testcases/kernel/syscalls/execvp/execvp01_child.c
> index 8a6e5123f..84f34428d 100644
> --- a/testcases/kernel/syscalls/execvp/execvp01_child.c
> +++ b/testcases/kernel/syscalls/execvp/execvp01_child.c
> @@ -16,6 +16,8 @@
>    * along with this program. If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include <string.h>
> +
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   
> diff --git a/testcases/kernel/syscalls/exit/exit02.c b/testcases/kernel/syscalls/exit/exit02.c
> index fa9639704..69132e973 100644
> --- a/testcases/kernel/syscalls/exit/exit02.c
> +++ b/testcases/kernel/syscalls/exit/exit02.c
> @@ -25,6 +25,7 @@
>    */
>   
>   #include <stdlib.h>
> +#include <string.h>
>   #include "tst_test.h"
>   
>   #define FNAME "test_file"
> diff --git a/testcases/kernel/syscalls/getcwd/getcwd04.c b/testcases/kernel/syscalls/getcwd/getcwd04.c
> index ba8c358f6..fd8524bb4 100644
> --- a/testcases/kernel/syscalls/getcwd/getcwd04.c
> +++ b/testcases/kernel/syscalls/getcwd/getcwd04.c
> @@ -37,6 +37,7 @@
>   #include <fcntl.h>
>   #include <sys/types.h>
>   #include <unistd.h>
> +#include <string.h>
>   #include "tst_test.h"
>   
>   #define TIMEOUT	5
> diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
> index e7d03e799..bb4908c92 100644
> --- a/testcases/kernel/syscalls/getrandom/getrandom02.c
> +++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
> @@ -27,6 +27,8 @@
>    *
>    */
>   
> +#include <string.h>
> +
>   #include "lapi/getrandom.h"
>   #include "lapi/syscalls.h"
>   #include "tst_test.h"
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
> index 8de80048c..2c01749ae 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl08.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
> @@ -20,6 +20,7 @@
>   #include <stdlib.h>
>   #include <sys/ioctl.h>
>   #include <errno.h>
> +#include <string.h>
>   #include "tst_test.h"
>   
>   #ifdef HAVE_STRUCT_FILE_DEDUPE_RANGE
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl05.c b/testcases/kernel/syscalls/keyctl/keyctl05.c
> index e2ed8ad48..1bf9066db 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl05.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl05.c
> @@ -39,6 +39,7 @@
>   
>   #include <errno.h>
>   #include <stdlib.h>
> +#include <string.h>
>   
>   #include "tst_test.h"
>   #include "lapi/keyctl.h"
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl06.c b/testcases/kernel/syscalls/keyctl/keyctl06.c
> index bab26ee5c..cf95e2b80 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl06.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl06.c
> @@ -29,6 +29,7 @@
>    */
>   
>   #include <errno.h>
> +#include <string.h>
>   
>   #include "tst_test.h"
>   #include "lapi/keyctl.h"
> diff --git a/testcases/kernel/syscalls/link/link08.c b/testcases/kernel/syscalls/link/link08.c
> index 775c0c27b..be3872d64 100644
> --- a/testcases/kernel/syscalls/link/link08.c
> +++ b/testcases/kernel/syscalls/link/link08.c
> @@ -32,6 +32,7 @@
>    *      if too many symbolic links were encountered in resolving path.
>    */
>   #include <errno.h>
> +#include <string.h>
>   #include "tst_test.h"
>   
>   #define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> diff --git a/testcases/kernel/syscalls/listxattr/listxattr02.c b/testcases/kernel/syscalls/listxattr/listxattr02.c
> index 33f57d567..b512e10b7 100644
> --- a/testcases/kernel/syscalls/listxattr/listxattr02.c
> +++ b/testcases/kernel/syscalls/listxattr/listxattr02.c
> @@ -35,6 +35,7 @@
>   
>   #include "config.h"
>   #include <errno.h>
> +#include <string.h>
>   #include <sys/types.h>
>   
>   #ifdef HAVE_SYS_XATTR_H
> diff --git a/testcases/kernel/syscalls/llistxattr/llistxattr02.c b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
> index d239e97bf..c444bae0b 100644
> --- a/testcases/kernel/syscalls/llistxattr/llistxattr02.c
> +++ b/testcases/kernel/syscalls/llistxattr/llistxattr02.c
> @@ -33,6 +33,7 @@
>   
>   #include "config.h"
>   #include <errno.h>
> +#include <string.h>
>   #include <sys/types.h>
>   
>   #ifdef HAVE_SYS_XATTR_H
> diff --git a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
> index 26194f114..38cb6d6be 100644
> --- a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
> +++ b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
> @@ -26,6 +26,7 @@
>   #include <errno.h>
>   #include <stdlib.h>
>   #include <stdio.h>
> +#include <string.h>
>   #include <unistd.h>
>   #include <fcntl.h>
>   
> diff --git a/testcases/kernel/syscalls/madvise/madvise10.c b/testcases/kernel/syscalls/madvise/madvise10.c
> index ca0b9f39b..e0099fc73 100644
> --- a/testcases/kernel/syscalls/madvise/madvise10.c
> +++ b/testcases/kernel/syscalls/madvise/madvise10.c
> @@ -54,6 +54,7 @@
>   #include <errno.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> +#include <string.h>
>   
>   #include "lapi/mmap.h"
>   #include "tst_test.h"
> diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
> index 8cadf9c21..74d39c466 100644
> --- a/testcases/kernel/syscalls/mkdir/mkdir03.c
> +++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
> @@ -28,6 +28,7 @@
>   #include <sys/mman.h>
>   #include <fcntl.h>
>   #include <sys/mount.h>
> +#include <string.h>
>   
>   #include "tst_test.h"
>   
> diff --git a/testcases/kernel/syscalls/read/read01.c b/testcases/kernel/syscalls/read/read01.c
> index 68aea0917..798e67b95 100644
> --- a/testcases/kernel/syscalls/read/read01.c
> +++ b/testcases/kernel/syscalls/read/read01.c
> @@ -32,6 +32,7 @@
>    */
>   
>   #include <errno.h>
> +#include <string.h>
>   #include "tst_test.h"
>   
>   #define SIZE 512
> diff --git a/testcases/kernel/syscalls/request_key/request_key03.c b/testcases/kernel/syscalls/request_key/request_key03.c
> index 9996a6f87..50d024e2e 100644
> --- a/testcases/kernel/syscalls/request_key/request_key03.c
> +++ b/testcases/kernel/syscalls/request_key/request_key03.c
> @@ -44,6 +44,7 @@
>   #include <errno.h>
>   #include <stdbool.h>
>   #include <stdlib.h>
> +#include <string.h>
>   #include <sys/wait.h>
>   
>   #include "tst_test.h"
> diff --git a/testcases/kernel/syscalls/rmdir/rmdir02.c b/testcases/kernel/syscalls/rmdir/rmdir02.c
> index 3f3669213..6f4fa405a 100644
> --- a/testcases/kernel/syscalls/rmdir/rmdir02.c
> +++ b/testcases/kernel/syscalls/rmdir/rmdir02.c
> @@ -28,6 +28,7 @@
>    */
>   
>   #include <errno.h>
> +#include <string.h>
>   
>   #include "tst_test.h"
>   
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt03.c b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> index 2d99865b7..42952e98d 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt03.c
> @@ -28,6 +28,7 @@
>    */
>   
>   #include <stdint.h>
> +#include <string.h>
>   #include <sys/types.h>
>   #include <sys/socket.h>
>   #include <netinet/in.h>
> diff --git a/testcases/kernel/syscalls/write/write03.c b/testcases/kernel/syscalls/write/write03.c
> index 7e3ec98df..61480c306 100644
> --- a/testcases/kernel/syscalls/write/write03.c
> +++ b/testcases/kernel/syscalls/write/write03.c
> @@ -31,6 +31,7 @@
>    */
>   
>   #include <stdio.h>
> +#include <string.h>
>   #include <errno.h>
>   #include "tst_test.h"
>   
> diff --git a/testcases/kernel/syscalls/writev/writev07.c b/testcases/kernel/syscalls/writev/writev07.c
> index ec883ed15..c7d03dae0 100644
> --- a/testcases/kernel/syscalls/writev/writev07.c
> +++ b/testcases/kernel/syscalls/writev/writev07.c
> @@ -32,6 +32,7 @@
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <stdio.h>
> +#include <string.h>
>   #include <sys/mman.h>
>   #include <sys/stat.h>
>   #include <sys/types.h>
> diff --git a/testcases/lib/tst_checkpoint.c b/testcases/lib/tst_checkpoint.c
> index 57c7bc1bb..fd18c146d 100644
> --- a/testcases/lib/tst_checkpoint.c
> +++ b/testcases/lib/tst_checkpoint.c
> @@ -20,6 +20,7 @@
>   #include <limits.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <string.h>
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   
> diff --git a/testcases/lib/tst_device.c b/testcases/lib/tst_device.c
> index 1cfdc962c..73d2e7dcb 100644
> --- a/testcases/lib/tst_device.c
> +++ b/testcases/lib/tst_device.c
> @@ -20,6 +20,7 @@
>   #include <limits.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <string.h>
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   #include "old/old_device.h"
> diff --git a/testcases/lib/tst_kvcmp.c b/testcases/lib/tst_kvcmp.c
> index 06632a278..0405d9d9e 100644
> --- a/testcases/lib/tst_kvcmp.c
> +++ b/testcases/lib/tst_kvcmp.c
> @@ -19,6 +19,7 @@
>   #define TST_NO_DEFAULT_MAIN
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <string.h>
>   #include <sys/utsname.h>
>   #include <tst_test.h>
>   
> diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
> index 4ebdcb20f..32c350af2 100644
> --- a/testcases/network/sctp/sctp_big_chunk.c
> +++ b/testcases/network/sctp/sctp_big_chunk.c
> @@ -14,6 +14,7 @@
>   #include <netinet/ip.h>
>   #include <netinet/ip6.h>
>   #include <netdb.h>
> +#include <string.h>
>   #include <sys/syscall.h>
>   
>   #include "tst_test.h"
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190412/511c8ca0/attachment-0001.html>
