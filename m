From: Li Wang <liwang@redhat.com>
Date: Mon,  1 Feb 2021 13:31:06 +0000
Subject: [LTP] [RFC PATCH] lib: enhancement of tst_pollute_memory
Message-ID: <20210201133106.26970-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This method base on set '2' to '/proc/sys/vm/overcommit_memory' which
helps to use the strict policy on memory overcommit. After comparing
the existing value of 'CommitLimit' with 'MemAvailable', to determine
how much overcommit_ratio should be used in those two situations:

1. 'CommitLimit' >= 'MemAvailable'

This means system already set a proper ratio (by default is 50), and it
quite safe for memory allocating with 'overcommit_memory=2'. Don't worry
about OOM-Killer because, MAP_FAILED will be returned instantly if the
whole system allocated-memory reaches the limitation.

2. 'CommitLimit' < 'MemAvailable'

This means system possibly has a little size of swap-space (or disabled),
so that wouldn't provide enough memory on expected allocating, more easily
exceed CommitLimit and trigger OOM. We recalculate the capability and let
system won't go over a commit-ratio larger than '(FreeMem - safety) / TotalMem',
that also make safety-margin take effect to it.

And, I propose to skip this function to be performed on larger RAM (128G)
system, because it takes too long to dirty memory.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    Hi Xinpeng,
    
    Before Cyril coming up with a new idea for solving this, I'd suggest you
    can help to test this patch with cancel the TCONF on 128G temporarily, to
    verify if my thought works for you.

 lib/tst_memutils.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index dd09db490..af2178a9c 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -15,6 +15,7 @@
 
 void tst_pollute_memory(size_t maxsize, int fillchar)
 {
+	unsigned int ori_overcommit_mem, ori_overcommit_rat, new_overcommit_rat;
 	size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
 	void **map_blocks;
 	struct sysinfo info;
@@ -40,6 +41,25 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 	map_count = maxsize / blocksize;
 	map_blocks = SAFE_MALLOC(map_count * sizeof(void *));
 
+	/* Only allow to run on systems with less than or equal to 128GB of memory */
+	if (info.totalram  >= (137438953472 / info.mem_unit)) {
+		tst_brk(TCONF, "Skip test - totalram (%lukB) is larger than 128GB",
+				info.totalram * info.mem_unit / 1024);
+	}
+
+	SAFE_FILE_SCANF("/proc/sys/vm/overcommit_memory", "%u", &ori_overcommit_mem);
+	SAFE_FILE_SCANF("/proc/sys/vm/overcommit_ratio",  "%u", &ori_overcommit_rat);
+
+	/* Disable the memory overcommit to prevent test invoking OOM killer */
+	if (SAFE_READ_MEMINFO("CommitLimit:") >= SAFE_READ_MEMINFO("MemAvailable:")) {
+		SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_memory", "2");
+	} else {
+		new_overcommit_rat = (maxsize / info.mem_unit * 100) / info.totalram;
+		SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_ratio", "%u", new_overcommit_rat);
+
+		SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_memory", "2");
+	}
+
 	/*
 	 * Keep allocating until the first failure. The address space may be
 	 * too fragmented or just smaller than maxsize.
@@ -60,4 +80,7 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
 		SAFE_MUNMAP(map_blocks[i], blocksize);
 
 	free(map_blocks);
+
+	SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_memory", "%u", ori_overcommit_mem);
+	SAFE_FILE_PRINTF("/proc/sys/vm/overcommit_ratio", "%u",  ori_overcommit_rat);
 }
-- 
2.21.3

