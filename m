From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
Date: Fri, 8 Jun 2018 16:35:47 +0800
Subject: [LTP] [PATCH] ebizzy-0.3: change type of variable to fix compile
	warning
Message-ID: <20180608083547.8548-1-sunlw.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change the type of variable from int to unsigned int
to fix complie warning: "comparison between signed and unsigned integer
expressions [-Wsign-compare]"

Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 utils/benchmark/ebizzy-0.3/ebizzy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 5bb8eff56..8a433e8e1 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -228,7 +228,7 @@ static void read_options(int argc, char *argv[])
 
 static void touch_mem(char *dest, size_t size)
 {
-	int i;
+	unsigned int i;
 	if (touch_pages) {
 		for (i = 0; i < size; i += page_size)
 			*(dest + i) = 0xff;
@@ -279,7 +279,7 @@ static void my_memcpy(void *dest, void *src, size_t len)
 {
 	char *d = (char *)dest;
 	char *s = (char *)src;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < len; i++)
 		d[i] = s[i];
@@ -288,7 +288,7 @@ static void my_memcpy(void *dest, void *src, size_t len)
 
 static void allocate(void)
 {
-	int i;
+	unsigned int i;
 
 	mem = alloc_mem(chunks * sizeof(record_t *));
 
@@ -313,7 +313,7 @@ static void allocate(void)
 
 static void write_pattern(void)
 {
-	int i, j;
+	unsigned int i, j;
 
 	for (i = 0; i < chunks; i++) {
 		for (j = 0; j < chunk_size / record_size; j++)
-- 
2.17.0



