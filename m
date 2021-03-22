From: zhaogongyi <zhaogongyi@huawei.com>
Date: Mon, 22 Mar 2021 03:32:38 +0000
Subject: [LTP] [PATCH] cleanup: Replace libc functions with safe_macros
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB403899593@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

I am sorry for the compile error, thanks for your review!

I have resubmit the patch according you review, and i will make sure compile PASS at least  locally in the future.

Best Regards,
Gongyi


???: Li Wang [mailto:liwang@redhat.com]
????: 2021?3?19? 13:41
???: zhaogongyi <zhaogongyi@huawei.com>
??: LTP List <ltp@lists.linux.it>
??: Re: [LTP] [PATCH] cleanup: Replace libc functions with safe_macros

Hi Gongyi,

Zhao Gongyi <zhaogongyi@huawei.com<mailto:zhaogongyi@huawei.com>> wrote:

--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -128,17 +128,13 @@ static void generate_events(void)
        /*
         * Generate sequence of events
         */
-       if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-               exit(1);
-       if (write(fd, fname, 1) == -1)
-               exit(2);
+       fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);

-       lseek(fd, 0, SEEK_SET);
-       if (read(fd, buf, BUF_SIZE) != -1)
-               exit(3);
+       SAFE_WRITE(fd, fname, 1);

SAFE_READ/SAFE_WRITE requires 4 arguments, but only 3 given,
it even builds fails after applying this patch. So it'd be better to compile
PASS at least locally before sending it to ML.


--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -53,14 +53,12 @@ static void generate_events(void)
        /*
         * generate sequence of events
         */
-       if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1)
-               exit(1);
+       fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0700);

FNAME --> fname


--
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210322/a552f75c/attachment.htm>
