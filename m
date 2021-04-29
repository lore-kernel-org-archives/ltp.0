From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 29 Apr 2021 16:05:08 +0100
Subject: [LTP] [PATCH v2 3/5] bpf: Add helper to run socket programs
In-Reply-To: <20210429150510.21585-1-rpalethorpe@suse.com>
References: <20210429150510.21585-1-rpalethorpe@suse.com>
Message-ID: <20210429150510.21585-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So far we always trigger the BPF programs the same way.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/bpf/bpf_common.c | 15 +++++++++++++++
 testcases/kernel/syscalls/bpf/bpf_common.h |  2 ++
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 11 +----------
 testcases/kernel/syscalls/bpf/bpf_prog02.c | 11 +----------
 testcases/kernel/syscalls/bpf/bpf_prog03.c |  9 +--------
 testcases/kernel/syscalls/bpf/bpf_prog04.c |  9 +--------
 6 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index 90772815b..b5337c22a 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -127,3 +127,18 @@ int bpf_load_prog(union bpf_attr *attr, const char *log)
 	tst_brk(TBROK | TERRNO, "Failed to load program");
 	return ret;
 }
+
+void bpf_run_prog(const int prog_fd,
+		  const char *const msg, const size_t msg_len)
+{
+	int sk[2];
+
+	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
+	SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF,
+			&prog_fd, sizeof(prog_fd));
+
+	SAFE_WRITE(1, sk[0], msg, msg_len);
+
+	SAFE_CLOSE(sk[0]);
+	SAFE_CLOSE(sk[1]);
+}
diff --git a/testcases/kernel/syscalls/bpf/bpf_common.h b/testcases/kernel/syscalls/bpf/bpf_common.h
index fb5731c3d..9e9935c2c 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.h
+++ b/testcases/kernel/syscalls/bpf/bpf_common.h
@@ -23,5 +23,7 @@ long bpf_map_array_get(const int map_fd,
 void bpf_init_prog_attr(union bpf_attr *attr, const struct bpf_insn *prog,
 			size_t prog_size, char *log_buf, size_t log_size);
 int bpf_load_prog(union bpf_attr *attr, const char *log);
+void bpf_run_prog(const int prog_fd,
+		  const char *const msg, const size_t msg_len);
 
 #endif
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog01.c b/testcases/kernel/syscalls/bpf/bpf_prog01.c
index ac57b24b5..1d5d04556 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog01.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog01.c
@@ -79,22 +79,13 @@ void setup(void)
 void run(void)
 {
 	int map_fd, prog_fd;
-	int sk[2];
 	uint32_t key = 0;
 	uint64_t val;
 
 	map_fd = bpf_map_array_create(1);
 	prog_fd = load_prog(map_fd);
-
-	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
-	SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF,
-			&prog_fd, sizeof(prog_fd));
-
-	SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
-
+	bpf_run_prog(prog_fd, msg, sizeof(MSG));
 	SAFE_CLOSE(prog_fd);
-	SAFE_CLOSE(sk[0]);
-	SAFE_CLOSE(sk[1]);
 
         bpf_map_array_get(map_fd, &key, &val);
 	if (val != 1) {
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog02.c b/testcases/kernel/syscalls/bpf/bpf_prog02.c
index 4558153ea..9f6acca60 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog02.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog02.c
@@ -79,20 +79,11 @@ static void setup(void)
 static void run(void)
 {
 	int map_fd, prog_fd;
-	int sk[2];
 
 	map_fd = bpf_map_array_create(2);
 	prog_fd = load_prog(map_fd);
-
-	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
-	SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF,
-			&prog_fd, sizeof(prog_fd));
-
-	SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
-
+	bpf_run_prog(prog_fd, msg, sizeof(MSG));
 	SAFE_CLOSE(prog_fd);
-	SAFE_CLOSE(sk[0]);
-	SAFE_CLOSE(sk[1]);
 
         *key = 0;
 	bpf_map_array_get(map_fd, key, val);
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog03.c b/testcases/kernel/syscalls/bpf/bpf_prog03.c
index 1195ddc2c..9a7af7f4c 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog03.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog03.c
@@ -117,7 +117,6 @@ static void setup(void)
 static void run(void)
 {
 	int map_fd, prog_fd;
-	int sk[2];
 
 	map_fd = bpf_map_array_create(32);
 
@@ -137,13 +136,7 @@ static void run(void)
 
 	tst_res(TFAIL, "Loaded bad eBPF, now we will run it and maybe crash");
 
-	SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
-	SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF,
-			&prog_fd, sizeof(prog_fd));
-
-	SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
-	SAFE_CLOSE(sk[0]);
-	SAFE_CLOSE(sk[1]);
+	bpf_run_prog(prog_fd, msg, sizeof(MSG));
 	SAFE_CLOSE(prog_fd);
 
 	*key = 0;
diff --git a/testcases/kernel/syscalls/bpf/bpf_prog04.c b/testcases/kernel/syscalls/bpf/bpf_prog04.c
index 1a1ee0f04..09d0cc468 100644
--- a/testcases/kernel/syscalls/bpf/bpf_prog04.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog04.c
@@ -92,7 +92,6 @@ static void setup(void)
 static void run(void)
 {
 	int map_fd, prog_fd;
-	int sk[2];
 
 	map_fd = bpf_map_array_create(1);
 	prog_fd = load_prog(map_fd);
@@ -100,13 +99,7 @@ static void run(void)
 	if (prog_fd >= 0) {
 		tst_res(TFAIL, "Malicious eBPF code passed verification. "
 			"Now let's try crashing the kernel.");
-		SAFE_SOCKETPAIR(AF_UNIX, SOCK_DGRAM, 0, sk);
-		SAFE_SETSOCKOPT(sk[1], SOL_SOCKET, SO_ATTACH_BPF, &prog_fd,
-			sizeof(prog_fd));
-
-		SAFE_WRITE(1, sk[0], msg, sizeof(MSG));
-		SAFE_CLOSE(sk[0]);
-		SAFE_CLOSE(sk[1]);
+		bpf_run_prog(prog_fd, msg, sizeof(MSG));
 	}
 
 	if (prog_fd >= 0)
-- 
2.31.1

