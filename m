From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 29 May 2017 15:45:42 +0200
Subject: [LTP] [PATCH v2] move_pages12: Make sure hugepages are available
In-Reply-To: <877971945.23275711.1496063572967.JavaMail.zimbra@redhat.com>
References: <20170516100759.10355-1-chrubis@suse.cz>
 <1420231349.12458178.1494937684196.JavaMail.zimbra@redhat.com>
 <20170516133233.GB2897@rei.lan>
 <1571565362.12569976.1494943541160.JavaMail.zimbra@redhat.com>
 <364825081.12577806.1494944124022.JavaMail.zimbra@redhat.com>
 <20170516142924.GE2897@rei.lan>
 <877971945.23275711.1496063572967.JavaMail.zimbra@redhat.com>
Message-ID: <0afd1733-3e19-507c-ed85-9f9d03721262@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/29/2017 03:12 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> Hi!
>>> Correction: "hpsz / 1024", we multiply it in setup() by 1024.
>>
>> I've moved the multiplication down in the setup so that we end up with
>> correct value without the divison. And I've also added you Signed-off-by
>> to the patch, since you did non-trivial amount of work on it and finally
>> pushed it. Thanks for you help.
> 
> Hi,
> 
> I'm sporadically running into SIGBUS in this testcase, not sure if it's 
> because of low memory or something else. Do you see it too?
> 
> I wonder if we should replace memset with MAP_POPULATE.

What would you think about something like this?

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index e1d956dba67e..d22b3c917370 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -143,7 +143,8 @@ static void alloc_free_huge_on_node(unsigned int node, size_t size)
 		size / hpsz, node);

 	mem = mmap(NULL, size, PROT_READ | PROT_WRITE,
-		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE,
+		   -1, 0);
 	if (mem == MAP_FAILED) {
 		if (errno == ENOMEM)
 			tst_brk(TCONF, "Cannot allocate huge pages");
@@ -157,7 +158,7 @@ static void alloc_free_huge_on_node(unsigned int node, size_t size)

 	numa_bitmask_setbit(bm, node);

-	ret = mbind(mem, size, MPOL_BIND, bm->maskp, bm->size + 1, 0);
+	ret = mbind(mem, size, MPOL_MF_MOVE, bm->maskp, bm->size + 1, 0);
 	if (ret) {
 		if (errno == ENOMEM)
 			tst_brk(TCONF, "Cannot mbind huge pages");
@@ -167,8 +168,6 @@ static void alloc_free_huge_on_node(unsigned int node, size_t size)

 	numa_bitmask_free(bm);

-	memset(mem, 0, size);
-
 	SAFE_MUNMAP(mem, size);
 }
