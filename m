From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 30 Jul 2020 16:49:18 +0800
Subject: [LTP] [PATCH v3 2/2] syscalls/ioctl_loop05: Using
 LOOP_CONFIGURE to set direct io
In-Reply-To: <20200729113946.GB7152@yuki.lan>
References: <20200722125946.GA22573@yuki.lan>
 <1595556357-29932-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595556357-29932-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200729113946.GB7152@yuki.lan>
Message-ID: <924c3fc1-c56c-a752-0720-bb12d6cf8ec0@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

HI Cyril

> Hi!
> I started look at this patch however the first thing I've found out is that
> our mountinfo parser is wrong. If you look at man 5 proc it says:
> 
> 36 35 98:0 /mnt1 /mnt2 rw,noatime master:1 - ext3 /dev/root rw,errors=continue
> (1)(2)(3)   (4)   (5)      (6)      (7)   (8) (9)   (10)         (11)
> 
> 
> (7)  optional fields: zero or more fields of the form
>       "tag[:value]"; see below.
> 
> So we cannot really parse the information with a static scanf() string,
> since the number of elements in the line is not constant.
> 
> And it does fail on some of the machines I do have here since there is
> no optional fields present.
> 
> So I guess that we will have to write a parser that reads that
> information line by line after all.
I doubt how machies will have more or zero fields in (7). But I think 
you are right,
How about using the (3) field and second to last field. Then we can 
avoid zero or more filed in (7). the code as below?

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 8d8bc5b40..36d6666fe 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -497,16 +497,31 @@ unsigned long tst_dev_bytes_written(const char *dev)

  void tst_find_backing_dev(const char *path, char *dev)
  {
-       char fmt[1024];
+       char fmt[20];
         struct stat buf;
+       FILE *file;
+       char line[PATH_MAX];
+       char *pre = NULL;
+       char *next = NULL;

         if (stat(path, &buf) < 0)
                  tst_brkm(TWARN | TERRNO, NULL, "stat() failed");

-       snprintf(fmt, sizeof(fmt), "%%*i %%*i %u:%u %%*s %%*s %%*s %%*s 
%%*s %%*s %%s %%*s",
-                       major(buf.st_dev), minor(buf.st_dev));
+       snprintf(fmt, sizeof(fmt), "%u:%u", major(buf.st_dev), 
minor(buf.st_dev));
+       file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");

-       SAFE_FILE_LINES_SCANF(NULL, "/proc/self/mountinfo", fmt, dev);
+       while (fgets(line, sizeof(line), file)) {
+               if (strstr(line, fmt) != NULL) {
+                       pre = strtok_r(line, " ", &next);
+                       while(pre != NULL) {
+                               strcpy(dev, pre);
+                               pre = strtok_r(NULL, " ", &next);
+                               if (strlen(next) == 0)
+                                       break;
+                       }
+                       break;
+               }
+       }

         if (stat(dev, &buf) < 0)
                  tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);

> 


