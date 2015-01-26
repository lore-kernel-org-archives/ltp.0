Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1YFhCn-0002m2-EU
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 10:47:41 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YFhCj-0004c3-BW
	for ltp-list@lists.sourceforge.net; Mon, 26 Jan 2015 10:47:39 +0000
Received: from /spool/local
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Mon, 26 Jan 2015 03:47:34 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
	(b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 682FB19D801C
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Jan 2015 03:38:42 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id t0QAlNuv53608534
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 03:47:31 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP
	id t0QAkwcf032202
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 03:46:58 -0700
Received: from localhost.localdomain ([9.125.28.228])
	by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t0QAkw9O031663
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 03:46:58 -0700
Date: Mon, 26 Jan 2015 17:46:13 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20150126094613.GA2055@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] increasing buffer size for correct alignment
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hey there,

I have a patch for aio-stress to align buffer address correctly. Please
have a look. Thanks in advance.

For align buffer address to the number specified by -a option in
aio-stress, it needs to add page_size_mask extra length to total_ram
before call allocation functions. Or it wouldn't be correct in this line
after the allocation:

         p = (char *)((intptr_t) (p + page_size_mask) & ~page_size_mask);

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 0b7148c..24675ec 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1022,7 +1022,7 @@ int setup_shared_mem(int num_threads, int num_files, int depth,
 	if (use_shm == USE_MALLOC) {
 		p = malloc(total_ram + page_size_mask);
 	} else if (use_shm == USE_SHM) {
-		shm_id = shmget(IPC_PRIVATE, total_ram, IPC_CREAT | 0700);
+		shm_id = shmget(IPC_PRIVATE, total_ram + page_size_mask, IPC_CREAT | 0700);
 		if (shm_id < 0) {
 			perror("shmget");
 			drop_shm();
@@ -1046,9 +1046,9 @@ int setup_shared_mem(int num_threads, int num_files, int depth,
 			goto free_buffers;
 		}
 		unlink(mmap_name);
-		ftruncate(fd, total_ram);
+		ftruncate(fd, total_ram + page_size_mask);
 		shm_id = fd;
-		p = mmap((char *)0x50000000, total_ram,
+		p = mmap((char *)0x50000000, total_ram + page_size_mask,
 			 PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 
 		if (p == MAP_FAILED) {
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
