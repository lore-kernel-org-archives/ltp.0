From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Fri, 5 Mar 2021 13:52:15 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <YBE03REJywKIlM0X@yuki.lan>, 
 <2021012718043566596022@chinatelecom.cn>, 
 <CAEemH2dA0T1F3wsdwtG2hsfDUUJsY8gFeTLTHyGz+pu034gH4g@mail.gmail.com>
Message-ID: <202103051352110688245@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -36,6 +36,13 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
        if (info.freeram - safety < maxsize / info.mem_unit)
                maxsize = (info.freeram - safety) * info.mem_unit;

 ==>Thanks,but the maxsize original code need to be deleted,Right?

+       /*
+        * To respect CommitLimit to prevent test invoking OOM killer,
+        * this may appear on system with a smaller swap-disk (or disabled).
+        */
+       if (SAFE_READ_MEMINFO("CommitLimit:") < SAFE_READ_MEMINFO("MemAvailable:"))
+               maxsize = SAFE_READ_MEMINFO("CommitLimit:") * 1024 - (safety * info.mem_unit);
+
        blocksize = MIN(maxsize, blocksize);
        map_count = maxsize / blocksize;
        map_blocks = SAFE_MALLOC(map_count * sizeof(void *));





Thanks?
 
From: Li Wang
Date: 2021-03-04 15:52
To: liuxp11@chinatelecom.cn
CC: Cyril Hrubis; ltp; Martin Doucha
Subject: Re: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked oom-killer
Hi Xinpeng,

[root@test-env-nm05-compute-14e5e72e38 ~]# cat /proc/meminfo
MemTotal:       526997420 kB
MemFree:        520224908 kB
MemAvailable:   519936744 kB
Buffers:               0 kB
Cached:          2509036 kB
SwapCached:            0 kB
...
SwapTotal:             0 kB
SwapFree:              0 kB
...
CommitLimit:    263498708 kB
Committed_AS:   10263760 kB

[root@test-env-nm05-compute-14e5e72e38 ~]# cat  /proc/sys/vm/min_free_kbytes
90112

After looking back on this problem, I prefer to think the reasons were caused by lower CommitLimit.

    CommitLimit:    263498708 kB < MemAvailable:   519936744 kB

If you try to enable all swap-disk or reset to a high ratio in overcommit_ratio
to make it larger than MemAvailable, probably no OOM occurs anymore.

Btw, I also observed that ioctl_sg01 almost being killed by OOM
every time on an aarch64 with little swap space, but if I add more
swap or set a high value of overcommit_ratio, the problem is gone.
(I manually tried with another x86_64 to confirm this too)
              total        used        free      shared  buff/cache   available
Mem:         259828        5365      247383          68        7079      231296
Swap:          4095          55        4040---
MemTotal:       266063872 kB
MemFree:        253320768 kB
MemAvailable:   236848064 kB
Buffers:            1472 kB
Cached:          6755456 kB
SwapCached:        12160 kB
...
CommitLimit:    137226176 kB
Committed_AS:    1206912 kB
---

The previous method in the patch[1] seems not good enough, but that can
help to verify if OOM disappears when resetting the overcommit_ratio.
[1] http://lists.linux.it/pipermail/ltp/2021-February/020907.html

Hence, another improvement way based on the above is to allocate proper
memory-size according to CommitLimit value when detecting the value of
CommitLimit is less than MemAvailable. That will make the test happy with
a little swap-space size system.

Any thoughts, or comments?

--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -36,6 +36,13 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
        if (info.freeram - safety < maxsize / info.mem_unit)
                maxsize = (info.freeram - safety) * info.mem_unit;
 
+       /*
+        * To respect CommitLimit to prevent test invoking OOM killer,
+        * this may appear on system with a smaller swap-disk (or disabled).
+        */
+       if (SAFE_READ_MEMINFO("CommitLimit:") < SAFE_READ_MEMINFO("MemAvailable:"))
+               maxsize = SAFE_READ_MEMINFO("CommitLimit:") * 1024 - (safety * info.mem_unit);
+
        blocksize = MIN(maxsize, blocksize);
        map_count = maxsize / blocksize;
        map_blocks = SAFE_MALLOC(map_count * sizeof(void *));


========================

About the  MemAvailable < MemFree, I think that is correct behavior on
your system and not the OOM root-cause.

Generally, we assumed the MemAvailable higher than MemFree,
but we sometimes also allow situations to break that. We'd better
count all of the different free watermarks from /proc/zoneinfo, then
add the sum of the low watermarks to MemAvailable, if get a value
larger than MemFree, that should be OK from my perspective.

-----
# echo 675840 > /proc/sys/vm/min_free_kbytes

# cat /proc/meminfo |grep -i mem
MemTotal:        5888584 kB
MemFree:         4518064 kB
MemAvailable:    3692008 kB
Shmem:             21128 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB


# cat /proc/zoneinfo |grep low -B 3 
...
  pages free     3840
        min      440
        low      550
--
Node 0, zone    DMA32
  pages free     355602
        min      79706
        low      99632
--
Node 0, zone   Normal
  pages free     0
        min      0
        low      0
--
Node 0, zone  Movable
  pages free     0
        min      0
        low      0
--
Node 0, zone   Device
  pages free     0
        min      0
        low      0
--
Node 1, zone      DMA
  pages free     0
        min      0
        low      0
--
Node 1, zone    DMA32
  pages free     0
        min      0
        low      0
--
      nr_kernel_misc_reclaimable 0
  pages free     769192
        min      88812
        low      111015

(111015+99632+550)*4 + 3692008(MemAvailable) > 5888584(MemFree)

Btw the formula to count MemAvailable is:

available = MemFree - totalreserve_pages + pages[LRU_ACTIVE_FILE] + pages[LRU_INACTIVE_FILE] - min(pagecache / 2, wmark_low)

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210305/35aaf9fc/attachment-0001.htm>
