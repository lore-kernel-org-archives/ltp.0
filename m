Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hanpt@linux.vnet.ibm.com>) id 1YFuzs-0005Kt-Kw
	for ltp-list@lists.sourceforge.net; Tue, 27 Jan 2015 01:31:16 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YFuzq-0001sf-Ou
	for ltp-list@lists.sourceforge.net; Tue, 27 Jan 2015 01:31:16 +0000
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <hanpt@linux.vnet.ibm.com>;
	Mon, 26 Jan 2015 20:31:10 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
	[9.57.198.25])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 53C3638C8026
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Jan 2015 20:31:07 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t0R1V7Mm26673238
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jan 2015 01:31:07 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t0R1V7a4003277
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 20:31:07 -0500
Received: from localhost.localdomain ([9.115.120.14])
	by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t0R1V6H9003232
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Jan 2015 20:31:06 -0500
Date: Tue, 27 Jan 2015 09:31:04 +0800
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Message-ID: <20150127013104.GA3260@localhost.localdomain>
References: <20150126094613.GA2055@localhost.localdomain>
	<20150126134555.GC25601@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150126134555.GC25601@rei.suse.de>
Subject: Re: [LTP] [PATCH] increasing buffer size for correct alignment
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

On Mon, Jan 26, 2015 at 02:45:56PM +0100, Cyril Hrubis wrote:
> You are adding the page_size_mask to all uses of total_ram, wouldn't it
> be easier to add it to the total_ram at the start of the function (and
> remove the page_size_mask from the malloc() call that has it allready)?
> 
Yes, you're right. This is the new patch. Please review. Thanks.


From 8d0521c7fbee1b46f27d8268fee28e9721c79cc2 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Mon, 26 Jan 2015 17:29:41 +0800
Subject: [PATCH] increasing buffer size for correct alignment

For align buffer address to the number specified by -a option in
aio-stress, it needs to add page_size_mask extra length to total_ram
before call allocation functions. Or it wouldn't be correct in this line
after the allocation:

         p = (char *)((intptr_t) (p + page_size_mask) & ~page_size_mask);

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 0b7148c..06a4953 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1019,8 +1019,11 @@ int setup_shared_mem(int num_threads, int num_files, int depth,
 	if (verify)
 		total_ram += padded_reclen;
 
+	/* for aligning buffer after the allocation */
+	total_ram += page_size_mask;
+
 	if (use_shm == USE_MALLOC) {
-		p = malloc(total_ram + page_size_mask);
+		p = malloc(total_ram);
 	} else if (use_shm == USE_SHM) {
 		shm_id = shmget(IPC_PRIVATE, total_ram, IPC_CREAT | 0700);
 		if (shm_id < 0) {
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
