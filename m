From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed,  5 May 2021 10:16:22 +0100
Subject: [LTP] [PATCH v3 3/4] bpf: Add helper to run socket programs
In-Reply-To: <20210505091623.29121-1-rpalethorpe@suse.com>
References: <20210505091623.29121-1-rpalethorpe@suse.com>
Message-ID: <20210505091623.29121-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So far we always trigger the BPF programs the same way.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/bpf/bpf_common.c | 15 +++++++++++++++
 testcases/kernel/syscalls/bpf/bpf_prog01.c | 11 +----------
 testcases/kernel/syscalls/bpf/bpf_prog02.c | 11 +----------
 testcases/kernel/syscalls/bpf/bpf_prog03.c |  9 +--------
 testcases/kernel/syscalls/bpf/bpf_prog04.c |  9 +--------
 5 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/bpf/bpf_common.c b/testcases/kernel/syscalls/bpf/bpf_common.c
index 42c72b975..8a324a8fa 100644
--- a/testcases/kernel/syscalls/bpf/bpf_common.c
+++ b/testcases/kernel/syscalls/bpf/bpf_common.c
@@ -124,3 +124,18 @@ int bpf_load_prog(union bpf_attr *const attr, const char *const log)
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

