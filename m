From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Jan 2021 15:01:30 +0530
Subject: [LTP] Holidays and LTP release
In-Reply-To: <db866679-a5e8-35d6-f57a-18a202c7937b@suse.cz>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
 <20210113095724.214c904a@kmaincent-XPS-13-7390>
 <CA+G9fYv1UFr+7ePC7tLjCY4JPsoQdBdf-6Jpr40zmsoYRWVrdQ@mail.gmail.com>
 <db866679-a5e8-35d6-f57a-18a202c7937b@suse.cz>
Message-ID: <CA+G9fYvRqOH7D04NHwPQNXKyMzak5bDo=GN3k13tcwV3bwN5Yw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 14 Jan 2021 at 19:44, Martin Doucha <mdoucha@suse.cz> wrote:
>
> On 14. 01. 21 12:12, Naresh Kamboju wrote:
> > on x86_64:
> > The ioctl_sg01 test killed and reported failed.
> >
> > tst_test.c:1263: TINFO: Timeout per run is 0h 15m 00s
> > ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
> > [  332.383394] ioctl_sg01 invoked oom-killer:
>
> Looks like the safety margin in tst_pollute_memory() is too small. Edit
> lib/tst_memutils.c and try setting the "safety" variable on line 23 to a
> higher value. I'd recommend something like MAX(4096 pages, 64MB).

do you mean something like this ?
But this change did not solve the problem (ioctl_sg01) i have reported.

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index f134d90c9..00bf45e9c 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -20,7 +20,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
        struct sysinfo info;

        SAFE_SYSINFO(&info);
-       safety = 4096 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;
+       safety = 8192 * SAFE_SYSCONF(_SC_PAGESIZE) / info.mem_unit;

        if (info.freeswap > safety)
                safety = 0;


After the above change the test case ioctl_sg01 fails intermittently
when running
multiple times.
https://lkft.validation.linaro.org/scheduler/job/2170593#L1357


- Naresh
