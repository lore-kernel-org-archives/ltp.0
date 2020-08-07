From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 7 Aug 2020 19:16:08 +0800
Subject: [LTP] [PATCH] lib/tst_cgroup: Reset cgroup.clone_children value
In-Reply-To: <CAEemH2d7+05ZT7UwePjtOuDKws-kK-5kt5LbyzV_zicFp51z2A@mail.gmail.com>
References: <1596793326-21639-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2d7+05ZT7UwePjtOuDKws-kK-5kt5LbyzV_zicFp51z2A@mail.gmail.com>
Message-ID: <1ca03e90-6885-4345-9be8-c1f37a6227ab@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li


> 
> 
> On Fri, Aug 7, 2020 at 5:42 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com 
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> 
>     When running cgroup test cases(like cpuset01 or oom05) about cpuset
>     subsystem
>     firstly, then cpuset_inherit case will fail because the value of
>     cgroup.clone_children has been changed into 1 on cgroup-v1. Reset
>     this value
>     when calling tst_cgroupN_umount.
> 
>     Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com
>     <mailto:xuyang2018.jy@cn.fujitsu.com>>
>     ---
>      ?lib/tst_cgroup.c | 8 ++++++++
>      ?1 file changed, 8 insertions(+)
> 
>     diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>     index 9459f7ea0..764951afa 100644
>     --- a/lib/tst_cgroup.c
>     +++ b/lib/tst_cgroup.c
>     @@ -9,6 +9,8 @@
>      ?#include <stdio.h>
>      ?#include <stdlib.h>
>      ?#include <sys/mount.h>
>     +#include <fcntl.h>
>     +#include <unistd.h>
> 
>      ?#include "tst_test.h"
>      ?#include "tst_safe_macros.h"
>     @@ -123,6 +125,7 @@ static void tst_cgroupN_umount(const char
>     *mnt_path, const char *new_path)
>      ? ? ? ? FILE *fp;
>      ? ? ? ? int fd;
>      ? ? ? ? char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
>     +? ? ? ?char knob_path[PATH_MAX];
> 
>      ? ? ? ? if (!tst_is_mounted(mnt_path))
>      ? ? ? ? ? ? ? ? return;
>     @@ -151,6 +154,11 @@ static void tst_cgroupN_umount(const char
>     *mnt_path, const char *new_path)
>      ? ? ? ? ? ? ? ? ? ? ? ? ? ? != (ssize_t)strlen(value) - 1)
>      ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? tst_res(TWARN | TERRNO, "write %s", s);
>      ? ? ? ? }
>     +? ? ? ?if (tst_cg_ver & TST_CGROUP_V1) {
> 
> 
> To recognize cgroup_v1 is not enough here, because it will 
> be?failed?"with?no such cgroup.clone_children file" on MEMCG umount?if 
> the system no CPUSET mounting.
I has umounted cpuset, but I still see this file in memory as below:

#mount |grep cpuset
nothing
# ls -l /sys/fs/cgroup/memory/cgroup.clone_children
-rw-r--r--. 1 root root 0 Aug  7 08:16 
/sys/fs/cgroup/memory/cgroup.clone_children

> 
> Maybe a smart way is to save the cgroup.clone_children?value, restore it 
> if it has been changed in the setup phase. What do u think?
We can just use print and scanf api to do this.
But I don't know this whether takes bad effects on complexd nesting 
situation(has sub cgroup).

> 
>     +? ? ? ? ? ? ? ?sprintf(knob_path, "%s/cgroup.clone_children",
>     mnt_path);
>     +? ? ? ? ? ? ? ?if (!access(knob_path, F_OK))
Here has a check for cgroup.clone_children so it should not trigger un 
such file error.

ps: I will add clone_children swith into cpu_inherit case.

Best Regards
Yang Xu
>     +? ? ? ? ? ? ? ? ? ? ? ?SAFE_FILE_PRINTF(knob_path, "%d", 0);
>     +? ? ? ?}
>      ? ? ? ? if (fd != -1)
>      ? ? ? ? ? ? ? ? close(fd);
>      ? ? ? ? if (fp != NULL)
>     -- 
>     2.23.0
> 
> 
> 
> 
> 
> -- 
> Regards,
> Li Wang


