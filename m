From: liuxp11@chinatelecom.cn <liuxp11@chinatelecom.cn>
Date: Wed, 27 Jan 2021 19:50:02 +0800
Subject: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01
 invoked oom-killer
References: <1611570288-23040-1-git-send-email-liuxp11@chinatelecom.cn>, 
 <YBE03REJywKIlM0X@yuki.lan>, 
 <2021012718043566596022@chinatelecom.cn>, 
 <29f6bd4d-bb20-6558-8e23-a29cadc19860@suse.cz>, 
 <2021012719413722937529@chinatelecom.cn>, 
 <3b9e2152-95ed-ee2a-6b30-180255330188@suse.cz>
Message-ID: <2021012719500196319832@chinatelecom.cn>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

available memory can avoid to oom-killer.

#man free
available
              Estimation of how much memory is available for starting new applications, without swapping. Unlike the data provided by  the  cache  or
              free  fields,  this  field  takes into account page cache and also that not all reclaimable memory slabs will be reclaimed due to items
              being in use (MemAvailable in /proc/meminfo, available on kernels 3.14, emulated on kernels 2.6.27+, otherwise the same as free)


[root@bogon ltp]# cat my.diff
commit eb28176a3351c6854620aaa8248bf17edea210ae
Author: Xinpeng Liu <liuxp11@chinatelecom.cn>
Date:   Mon Jan 25 20:58:20 2021 +0800

    syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked oom-killer

    Kernel version is 5.4.81+,the available RAM is less than free,as follow:
    [root@liuxp mywork]# head /proc/meminfo
    MemTotal:       198101744 kB
    MemFree:        189303148 kB
    MemAvailable:   188566732 kB

    So use available RAM to avoid OOM killer.

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 91dad07..3fd70b2 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -6,6 +6,8 @@
 #ifndef TST_MEMUTILS_H__
 #define TST_MEMUTILS_H__

+unsigned long tst_get_mem_available(void);
+
 /*
  * Fill up to maxsize physical memory with fillchar, then free it for reuse.
  * If maxsize is zero, fill as much memory as possible. This function is
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index dd09db4..9408b37 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -13,11 +13,21 @@

 #define BLOCKSIZE (16 * 1024 * 1024)

+unsigned long tst_get_mem_available(void)
+{
+       unsigned long available_kb = 0;
+
+       FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %lu", &available_kb);
+
+       return available_kb;
+}
+
 void tst_pollute_memory(size_t maxsize, int fillchar)
 {
        size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
        void **map_blocks;
        struct sysinfo info;
+       unsigned long available_ram;

        SAFE_SYSINFO(&info);
        safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
@@ -26,15 +36,22 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
        if (info.freeswap > safety)
                safety = 0;

+       available_ram = 1024 * tst_get_mem_available();
+       available_ram /= info.mem_unit;
+
+       /*"MemAvailable" field maybe not exist, or freeram less than available_ram*/
+       if(available_ram == 0 || info.freeram < available_ram)
+               available_ram = info.freeram;
+
        /* Not enough free memory to avoid invoking OOM killer */
-       if (info.freeram <= safety)
+       if (available_ram <= safety)
                return;

        if (!maxsize)
                maxsize = SIZE_MAX;

-       if (info.freeram - safety < maxsize / info.mem_unit)
-               maxsize = (info.freeram - safety) * info.mem_unit;
+       if (available_ram - safety < maxsize / info.mem_unit)
+               maxsize = (available_ram - safety) * info.mem_unit;

        blocksize = MIN(maxsize, blocksize);
        map_count = maxsize / blocksize;



From: Martin Doucha
Date: 2021-01-27 19:46
To: liuxp11@chinatelecom.cn; Cyril Hrubis
CC: ltp
Subject: Re: [LTP] [PATCH 1/2] syscalls/ioctl: ioctl_sg01.c: ioctl_sg01 invoked oom-killer
On 27. 01. 21 12:41, liuxp11@chinatelecom.cn wrote:
>     safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
>     now safety margin is 128MB,not 64MB. Right?
 
Yes, right, sorry.
 
-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210127/182cafa3/attachment.htm>
