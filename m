From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 15 Jan 2018 03:06:02 -0500 (EST)
Subject: [LTP] [PATCH v2] syscalls/madvise09.c: Use custom mount point
 instead of /sys/fs/cgroup/memory
In-Reply-To: <5A5C3E27.1050702@cn.fujitsu.com>
References: <5A4D94E0.4030508@cn.fujitsu.com>
 <1515033797-18823-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <5A5C3E27.1050702@cn.fujitsu.com>
Message-ID: <1801982516.6465238.1516003561998.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> Could you help me review this patch.

Hi,

I think it would be better to use existing mount, if it's already mounted.
umount may fail with -EBUSY if the subsystem is already part of existing
hierarchy.

Regards,
Jan

> 
> Thanks,
> Xiao Yang
> On 2018/01/04 10:43, xiao yang wrote:
> > 1) on some distros(e.g. RHEL6), memory cgroup was supported and
> >    mounted on /cgroup/memory by default, but the test was skipped
> >    if /sys/fs/cgroup/memory did not exist.
> >
> > 2) We got the following error if memory cgroup wasn't mounted
> >    on /sys/fs/cgroup/memory:
> >    ------------------------------------------------------------
> >    safe_macros.c:169: BROK: madvise09.c:175:
> >    mkdir(/sys/fs/cgroup/memory/ltp_madvise09_16386/,0777) failed: EROFS
> >    ------------------------------------------------------------
> >
> > We use custom mount point and mount memory cgroup on it manually
> > to fix these issues.
> >
> > Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
> > ---
> >  testcases/kernel/syscalls/madvise/madvise09.c | 26
> >  ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/madvise/madvise09.c
> > b/testcases/kernel/syscalls/madvise/madvise09.c
> > index f744405..25cf81f 100644
> > --- a/testcases/kernel/syscalls/madvise/madvise09.c
> > +++ b/testcases/kernel/syscalls/madvise/madvise09.c
> > @@ -53,12 +53,14 @@
> >  #include <errno.h>
> >  #include <stdio.h>
> >  #include <ctype.h>
> > +#include <sys/mount.h>
> >  
> >  #include "tst_test.h"
> >  #include "lapi/mmap.h"
> >  
> > -#define MEMCG_PATH "/sys/fs/cgroup/memory/"
> > +#define MEMCG_PATH "/dev/memcg_madvise09/"
> >  
> > +static int memcg_mounted;
> >  static char cgroup_path[PATH_MAX];
> >  static char tasks_path[PATH_MAX];
> >  static char limit_in_bytes_path[PATH_MAX];
> > @@ -277,6 +279,15 @@ static void cleanup(void)
> >  {
> >  	if (cgroup_path[0] && !access(cgroup_path, F_OK))
> >  		rmdir(cgroup_path);
> > +
> > +	if (memcg_mounted) {
> > +		tst_res(TINFO, "Umount memory cgroup after testing");
> > +		SAFE_UMOUNT(MEMCG_PATH);
> > +		memcg_mounted = 0;
> > +	}
> > +
> > +	if (!access(MEMCG_PATH, F_OK) && rmdir(MEMCG_PATH))
> > +		tst_res(TWARN | TERRNO, "Rmdir %s failed", MEMCG_PATH);
> >  }
> >  
> >  static void run(void)
> > @@ -316,10 +327,17 @@ static void setup(void)
> >  {
> >  	long int swap_total;
> >  
> > -	if (access(MEMCG_PATH, F_OK)) {
> > -		tst_brk(TCONF, "'" MEMCG_PATH
> > -			"' not present, CONFIG_MEMCG missing?");
> > +	SAFE_MKDIR(MEMCG_PATH, 0777);
> > +
> > +	tst_res(TINFO, "Mount memory cgroup on %s", MEMCG_PATH);
> > +	if (mount("memcg", MEMCG_PATH, "cgroup", 0, "memory") == -1) {
> > +		if (errno == ENODEV) {
> > +			tst_brk(TCONF,
> > +				 "Memory cgroup was not configured in kernel");
> > +		}
> > +		tst_brk(TBROK | TERRNO, "Failed to mount memory cgroup");
> >  	}
> > +	memcg_mounted = 1;
> >  
> >  	if (!access(MEMCG_PATH "memory.memsw.limit_in_bytes", F_OK))
> >  		swap_accounting_enabled = 1;
> 
> 
> 
> 
