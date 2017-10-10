From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 17:05:12 +0200
Subject: [LTP] [PATCH 4/6] lib: extend PATH as part of test setup
In-Reply-To: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
Message-ID: <fe40d9a0263afff913c646a6bc1fad88e0ce9747.1507647255.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch adds "." and "startdir" to $PATH during setup, so that exec*p()
correctly finds child processes. And it also makes it convenient to run some
tests directly from git tree.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 25cb234425ab..78cce19b6e4a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -841,12 +841,41 @@ static unsigned long long get_time_ms(void)
 	return tv.tv_sec * 1000 + tv.tv_usec / 1000;
 }
 
+static void add_paths(void)
+{
+	char *old_path = getenv("PATH");
+	const char *start_dir;
+	char *new_path;
+	int new_path_size;
+
+	start_dir = tst_get_startwd();
+
+	/* ".:" + "$start_dir" + '\0' */
+	new_path_size = 2 + strlen(start_dir) + 1;
+	if (old_path)
+		/* ":" + "$old_path" */
+		new_path_size += 1 + strlen(old_path);
+
+	new_path = SAFE_MALLOC(new_path_size);
+	strcpy(new_path, ".:");
+	strcat(new_path, start_dir);
+
+	if (old_path) {
+		strcat(new_path, ":");
+		strcat(new_path, old_path);
+	}
+
+	SAFE_SETENV("PATH", new_path, 1);
+	free(new_path);
+}
+
 static void testrun(void)
 {
 	unsigned int i = 0;
 	unsigned long long stop_time = 0;
 	int cont = 1;
 
+	add_paths();
 	do_test_setup();
 
 	if (duration > 0)
-- 
1.8.3.1

