From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 13 Jul 2018 08:53:54 +0200
Subject: [LTP] [PATCH v1] Test madvise with advise value'MADV_WIPEONFORK'
In-Reply-To: <04128a41ce9c82069cbadfd812c2a0a0.squirrel@pike.zilogic.com>
References: <1531324792-16559-1-git-send-email-kewal@zilogic.com>
 <2eef9639-8704-a736-5193-e7ef3074516e@redhat.com>
 <04128a41ce9c82069cbadfd812c2a0a0.squirrel@pike.zilogic.com>
Message-ID: <20180713065353.GA24308@dustball.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 13, 2018 at 06:27:25AM -0000, kewal wrote:
> 
> Hi Jan,
> 
> As per your below comment,
> > -drop madvise11, errno tests can be added to existing madvise02
> 
> we found that in madvise02, the below structure uses mapped address which
> is mapped with the flag value as "MAP_SHARED" but as per my test cases we
> have to vary the flag value with "MAP_SHARED | MAP_ANONYMOUS" &
> "MAP_PRIVATE".
> 
> I didn't found a way to add our testcases in madvise02.

See attached patch - wouldn't that work?

Regards,
Jan
-------------- next part --------------
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 710e46e54f..5bb2c44965 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -59,9 +59,11 @@ static struct stat st;
 static long pagesize;
 static char *file1;
 static char *file2;
+static char *file3;
 static char *ptr_addr;
 static char *tmp_addr;
 static char *nonalign;
+static char *shared_anon;
 
 static struct tcase {
 	int advice;
@@ -81,6 +83,8 @@ static struct tcase {
 	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF, 0},
 	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL, 0},
 	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL, 0},
+	{MADV_WIPEONFORK,  "MADV_WIPEONFORK shared anon",  &shared_anon,    EINVAL, 0},
+	{MADV_WIPEONFORK,  "MADV_WIPEONFORK private file backed",  &file3,    EINVAL, 0},
 };
 
 static void tcases_filter(void)
@@ -151,6 +155,8 @@ static void setup(void)
 	file1 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 	file2 = SAFE_MMAP(0, st.st_size, PROT_READ, MAP_SHARED, fd, 0);
 	SAFE_MUNMAP(file2 + st.st_size - pagesize, pagesize);
+	file3 = SAFE_MMAP(0, st.st_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	shared_anon = SAFE_MMAP(0, st.st_size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
 
 	nonalign = file1 + 100;
 
