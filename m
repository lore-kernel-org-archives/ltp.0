From: Li Wang <liwang@redhat.com>
Date: Fri, 22 Jul 2016 11:46:03 +0800
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <5790DADF.8000506@redhat.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160719055844.GA31704@gmail.com>
 <1822250385.6269456.1468911402613.JavaMail.zimbra@redhat.com>
 <20160719085756.GB31704@gmail.com> <578F8CB6.2020602@redhat.com>
 <597691787.18542977.1469097118207.JavaMail.zimbra@redhat.com>
 <20160721110159.GA13274@gmail.com> <5790DADF.8000506@redhat.com>
Message-ID: <20160722034603.GA15996@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Jul 21, 2016 at 04:23:27PM +0200, Jan Stancek wrote:
> 
> I'm starting to run out of ideas how we can test this somewhat reliably.
> 
> Attached is approach v3, which sets up memory cgroup:
> - memory.limit_in_bytes is 128M
> - we allocate 512M
> - as consequence ~384M should be swapped while system should still have
>   plenty of free memory, which should be available for cache

Drop caches before testing is really good, we think the same!

And setting cgroup shorten the test time, if there could guarantee
cgroup OOM is off and swappiness is a little larger, that would
be more reliable I think.

One question is that you wrote function count_swapped_pages() but
didn't using it, seems forgot to put somewhere?

Anyway, V3 is strong enough expecially it combines the two method
together.


> #include <errno.h>
> #include <stdio.h>
> #include <sys/mount.h>
> #include <sys/sysinfo.h>
> #include "tst_test.h"
> 
> #define CHUNK_SZ (512*1024*1024L)
> #define CHUNK_PAGES (CHUNK_SZ / pg_sz)
> #define PASS_THRESHOLD (CHUNK_SZ / 4)
> 
> static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
> static int pg_sz;
> 
> static void drop_caches(void)
> {
> 	int ret;
> 	FILE *f;
> 
> 	f = fopen(drop_caches_fname, "w");
> 	if (f) {
> 		ret = fprintf(f, "1");
> 		fclose(f);
> 		if (ret < 1)
> 			tst_brk(TBROK, "Failed to drop caches");
> 	} else {
> 		tst_brk(TBROK, "Failed to open drop_caches");
> 	}
> }
> 
> static void setup(void)
> {
> 	struct sysinfo sys_buf_start;
> 
> 	pg_sz = getpagesize();
> 
> 	if (access(drop_caches_fname, R_OK | W_OK))
> 		tst_brk(TCONF, "needed: %s\n", drop_caches_fname);
> 	tst_res(TINFO, "dropping caches");
> 	drop_caches();

save this function by oneline:

 /* drop caches*/
 SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "1");

> 
> 	sysinfo(&sys_buf_start);
> 	if (sys_buf_start.freeram < 2 * CHUNK_SZ)
> 		tst_brk(TCONF, "System RAM is too small, skip test");
> 	if (sys_buf_start.freeswap < 2 * CHUNK_SZ)
> 		tst_brk(TCONF, "System swap is too small");
> 
> 	SAFE_MKDIR("memory", 0700);
> 	SAFE_MOUNT("memory", "memory", "cgroup", 0, "memory");
> 	if (access("memory/memory.limit_in_bytes", R_OK | W_OK))
> 		tst_brk(TCONF, "cgroup memory.limit_in_bytes needed");
> 
> 	SAFE_MKDIR("memory/madvise06", 0700);
> 	SAFE_FILE_PRINTF("memory/madvise06/memory.limit_in_bytes", "%ld\n",
> 		PASS_THRESHOLD);

Turn off oom, enlarge swappiness

 SAFE_FILE_PRINTF("memory/madvise06/memory.oom_control", "0");
 SAFE_FILE_PRINTF("memory/madvise06/memory.swappiness", "60");

> 	SAFE_FILE_PRINTF("memory/madvise06/tasks", "%d\n", getpid());
> }
> 
> static void cleanup(void)
> {
> 	FILE *f = fopen("memory/tasks", "w");
> 
> 	if (f) {
> 		fprintf(f, "%d\n", getpid());
> 		fclose(f);
> 	}
> 	rmdir("memory/madvise06");
> 	umount("memory");
> }
> 
> static long count_swapped_pages(void *ptr, long pg_count)

A compile Warnning:

madvise06.c:94:13: warning: ‘count_swapped_pages’ defined but not used
[-Wunused-function]
static long count_swapped_pages(void *ptr, long pg_count)


Regards,
Li Wang
