From: Song Jian <songjian15@huawei.com>
Date: Mon, 28 Oct 2019 17:31:32 +0800
Subject: [LTP] [PATCH]kernel/mem/mtest01:Fix mtest01's options
Message-ID: <1572255092-105929-1-git-send-email-songjian15@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Song Jian <songjian15@huawei.com>
---
 testcases/kernel/mem/mtest01/mtest01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index eaf1026..960a2ce 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -58,7 +58,7 @@ static char *opt_chunksize, *opt_maxbytes, *opt_maxpercent;
 static struct tst_option mtest_options[] = {
 	{"c:", &opt_chunksize,	"-c  size of chunk in bytes to malloc on each pass"},
 	{"b:", &opt_maxbytes,	"-b  maximum number of bytes to allocate before stopping"},
-	{"p:", &opt_maxpercent, "-u  percent of total memory used at which the program stops"},
+	{"p:", &opt_maxpercent, "-p  percent of total memory used at which the program stops"},
 	{"w",  &dowrite,   	"-w  write to the memory after allocating"},
 	{"v",  &verbose,     	"-v  verbose"},
 	{NULL, NULL, 		NULL}
--
2.6.2

