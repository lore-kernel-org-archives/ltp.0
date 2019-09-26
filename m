From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 26 Sep 2019 17:13:31 +0200
Subject: [LTP] [PATCH v2 4/4] Add connection tests for bind()
In-Reply-To: <20190926151331.25070-1-mdoucha@suse.cz>
References: <20190926151331.25070-1-mdoucha@suse.cz>
Message-ID: <20190926151331.25070-5-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add two new test programs to verify that bind() will open sockets for incoming
connections. Both programs follow the same test scenario:
- Create and bind() a socket
- Wait for connection from peer thread
- Send request to peer thread
- Receive and verify response from peer thread

bind04 tests stream-oriented sockets (SOCK_STREAM and SOCK_SEQPACKET).
bind05 tests datagram-oriented sockets (SOCK_DGRAM).

Both programs test the following socket types:
- AF_UNIX (pathname and abstract addresses)
- AF_INET (loopback)
- AF_INET6 (loopback)

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/syscalls                          |   2 +
 testcases/kernel/syscalls/bind/.gitignore |   2 +
 testcases/kernel/syscalls/bind/Makefile   |   2 +
 testcases/kernel/syscalls/bind/bind04.c   | 180 ++++++++++++++++++++
 testcases/kernel/syscalls/bind/bind05.c   | 192 ++++++++++++++++++++++
 testcases/kernel/syscalls/bind/libbind.h  |  29 ++++
 6 files changed, 407 insertions(+)
 create mode 100644 testcases/kernel/syscalls/bind/bind04.c
 create mode 100644 testcases/kernel/syscalls/bind/bind05.c
 create mode 100644 testcases/kernel/syscalls/bind/libbind.h

diff --git a/runtest/syscalls b/runtest/syscalls
index 874ae4d4f..2738193a8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -31,6 +31,8 @@ alarm07 alarm07
 bind01 bind01
 bind02 bind02
 bind03 bind03
+bind04 bind04
+bind05 bind05
 
 bpf_map01 bpf_map01
 bpf_prog01 bpf_prog01
diff --git a/testcases/kernel/syscalls/bind/.gitignore b/testcases/kernel/syscalls/bind/.gitignore
index 4ebea9ee7..e18ceea56 100644
--- a/testcases/kernel/syscalls/bind/.gitignore
+++ b/testcases/kernel/syscalls/bind/.gitignore
@@ -1,3 +1,5 @@
 /bind01
 /bind02
 /bind03
+/bind04
+/bind05
diff --git a/testcases/kernel/syscalls/bind/Makefile b/testcases/kernel/syscalls/bind/Makefile
index bd617d806..1fe390997 100644
--- a/testcases/kernel/syscalls/bind/Makefile
+++ b/testcases/kernel/syscalls/bind/Makefile
@@ -20,4 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+bind04 bind05:	LDLIBS		+= -lpthread
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/bind/bind04.c b/testcases/kernel/syscalls/bind/bind04.c
new file mode 100644
index 000000000..bd71ca82e
--- /dev/null
+++ b/testcases/kernel/syscalls/bind/bind04.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (c) 2019 Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*
+ * Create and bind socket for various standard stream protocols.
+ * Then connect to it and send some test data.
+ */
+
+#include <string.h>
+#include <stdlib.h>
+#include <time.h>
+#include <pthread.h>
+
+#include "tst_test.h"
+#include "tst_net.h"
+#include "tst_safe_pthread.h"
+#include "libbind.h"
+
+static struct sockaddr_un unix_addr = {
+	.sun_family = AF_UNIX,
+	.sun_path = MAIN_SOCKET_FILE
+};
+static struct sockaddr_un abstract_addr = {
+	.sun_family = AF_UNIX,
+	.sun_path = ABSTRACT_SOCKET_PATH
+};
+static struct sockaddr_in ipv4_addr;
+static struct sockaddr_in ipv4_any_addr;
+static struct sockaddr_in6 ipv6_addr;
+static struct sockaddr_in6 ipv6_any_addr;
+
+static struct test_case testcase_list[] = {
+	// UNIX sockets
+	{SOCK_STREAM, 0, (struct sockaddr*)&unix_addr, sizeof(unix_addr),
+		"AF_UNIX pathname stream"},
+	{SOCK_SEQPACKET, 0, (struct sockaddr*)&unix_addr, sizeof(unix_addr),
+		"AF_UNIX pathname seqpacket"},
+	{SOCK_STREAM, 0, (struct sockaddr*)&abstract_addr,
+		sizeof(abstract_addr), "AF_UNIX abstract stream"},
+	{SOCK_SEQPACKET, 0, (struct sockaddr*)&abstract_addr,
+		sizeof(abstract_addr), "AF_UNIX abstract seqpacket"},
+
+	// IPv4 sockets
+	{SOCK_STREAM, 0, (struct sockaddr*)&ipv4_addr, sizeof(ipv4_addr),
+		"IPv4 loop TCP variant 1"},
+	{SOCK_STREAM, IPPROTO_TCP, (struct sockaddr*)&ipv4_addr,
+		sizeof(ipv4_addr), "IPv4 loop TCP variant 2"},
+	{SOCK_STREAM, IPPROTO_SCTP, (struct sockaddr*)&ipv4_addr,
+		sizeof(ipv4_addr), "IPv4 loop SCTP"},
+	{SOCK_STREAM, 0, (struct sockaddr*)&ipv4_any_addr,
+		sizeof(ipv4_any_addr), "IPv4 any TCP variant 1"},
+	{SOCK_STREAM, IPPROTO_TCP, (struct sockaddr*)&ipv4_any_addr,
+		sizeof(ipv4_any_addr), "IPv4 any TCP variant 2"},
+	{SOCK_STREAM, IPPROTO_SCTP, (struct sockaddr*)&ipv4_any_addr,
+		sizeof(ipv4_any_addr), "IPv4 any SCTP"},
+
+	// IPv6 sockets
+	{SOCK_STREAM, 0, (struct sockaddr*)&ipv6_addr, sizeof(ipv6_addr),
+		"IPv6 loop TCP variant 1"},
+	{SOCK_STREAM, IPPROTO_TCP, (struct sockaddr*)&ipv6_addr,
+		sizeof(ipv6_addr), "IPv6 loop TCP variant 2"},
+	{SOCK_STREAM, IPPROTO_SCTP, (struct sockaddr*)&ipv6_addr,
+		sizeof(ipv6_addr), "IPv6 loop SCTP"},
+	{SOCK_STREAM, 0, (struct sockaddr*)&ipv6_any_addr,
+		sizeof(ipv6_any_addr), "IPv6 any TCP variant 1"},
+	{SOCK_STREAM, IPPROTO_TCP, (struct sockaddr*)&ipv6_any_addr,
+		sizeof(ipv6_any_addr), "IPv6 any TCP variant 2"},
+	{SOCK_STREAM, IPPROTO_SCTP, (struct sockaddr*)&ipv6_any_addr,
+		sizeof(ipv6_any_addr), "IPv6 any SCTP"}
+};
+
+static void setup(void)
+{
+	srand(time(0));
+
+	// Init addresses for IPv4/IPv6 test cases
+	init_sockaddr_inet(&ipv4_addr, IPV4_ADDRESS, 0);
+	init_sockaddr_inet_bin(&ipv4_any_addr, INADDR_ANY, 0);
+	init_sockaddr_inet6_bin(&ipv6_addr, &in6addr_loopback, 0);
+	init_sockaddr_inet6_bin(&ipv6_any_addr, &in6addr_any, 0);
+}
+
+static void *peer_thread(void *tc_ptr)
+{
+	const struct test_case *tc = (struct test_case*)tc_ptr;
+	int sock;
+	unsigned request;
+	const char *response;
+
+	sock = SAFE_SOCKET(tc->address->sa_family, tc->type, tc->protocol);
+	SAFE_CONNECT(sock, tc->address, tc->addrlen);
+	SAFE_READ(1, sock, &request, sizeof(request));
+
+	if (request < ARRAY_SIZE(testcase_list)) {
+		response = testcase_list[request].description;
+	} else {
+		response = "Invalid request value";
+	}
+
+	SAFE_WRITE(1, sock, response, strlen(response) + 1);
+	SAFE_CLOSE(sock);
+	return NULL;
+}
+
+static void test_bind(unsigned int n)
+{
+	struct test_case tc_copy, *tc = testcase_list + n;
+	struct sockaddr_storage listen_addr, remote_addr;
+	struct sockaddr_un *tmp_addr;
+	socklen_t remote_len = sizeof(struct sockaddr_storage);
+	int listen_sock, sock, size;
+	unsigned rand_index;
+	pthread_t thread_id;
+	char buffer[BUFFER_SIZE];
+	const char *exp_data;
+
+	// Create listen socket
+	tst_res(TINFO, "Testing %s", tc->description);
+	listen_sock = SAFE_SOCKET(tc->address->sa_family, tc->type,
+		tc->protocol);
+
+	TEST(bind(listen_sock, tc->address, tc->addrlen));
+
+	if (TST_RET) {
+		tst_res(TFAIL | TERRNO, "bind() failed");
+		close(listen_sock);
+		return;
+	}
+
+	// IPv4/IPv6 tests use wildcard addresses, resolve a valid connection
+	// address for peer thread
+	memcpy(&tc_copy, tc, sizeof(struct test_case));
+	tc_copy.addrlen = get_connect_address(listen_sock, &listen_addr);
+	tc_copy.address = (struct sockaddr*)&listen_addr;
+
+	// Start peer thread and wait for connection
+	SAFE_LISTEN(listen_sock, 1);
+	SAFE_PTHREAD_CREATE(&thread_id, NULL, peer_thread, &tc_copy);
+	sock = accept(listen_sock, (struct sockaddr*)&remote_addr,
+		&remote_len);
+
+	if (sock < 0) {
+		tst_brk(TBROK | TERRNO, "accept() failed");
+	}
+
+	// Send request
+	rand_index = rand() % ARRAY_SIZE(testcase_list);
+	SAFE_WRITE(1, sock, &rand_index, sizeof(rand_index));
+
+	// Read response
+	size = SAFE_READ(0, sock, buffer, BUFFER_SIZE - 1);
+	buffer[size] = '\0';
+	exp_data = testcase_list[rand_index].description;
+
+	if (!strcmp(buffer, exp_data)) {
+		tst_res(TPASS, "Communication successful");
+	} else {
+		tst_res(TFAIL, "Received invalid data. Expected: \"%s\". "
+			"Received: \"%s\"", exp_data, buffer);
+	}
+
+	// Cleanup
+	SAFE_CLOSE(sock);
+	SAFE_CLOSE(listen_sock);
+	pthread_join(thread_id, NULL);
+	tmp_addr = (struct sockaddr_un*)tc->address;
+
+	if (tc->address->sa_family == AF_UNIX && tmp_addr->sun_path[0]) {
+		SAFE_UNLINK(tmp_addr->sun_path);
+	}
+}
+
+static struct tst_test test = {
+	.test = test_bind,
+	.tcnt = ARRAY_SIZE(testcase_list),
+	.needs_tmpdir = 1,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/bind/bind05.c b/testcases/kernel/syscalls/bind/bind05.c
new file mode 100644
index 000000000..5532843e6
--- /dev/null
+++ b/testcases/kernel/syscalls/bind/bind05.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (c) 2019 Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*
+ * Create and bind socket for various standard datagram protocols.
+ * Then connect to it and send some test data.
+ */
+
+#include <string.h>
+#include <stdlib.h>
+#include <time.h>
+#include <pthread.h>
+
+#include "tst_test.h"
+#include "tst_net.h"
+#include "tst_safe_pthread.h"
+#include "libbind.h"
+
+static struct sockaddr_un unix_addr = {
+	.sun_family = AF_UNIX,
+	.sun_path = MAIN_SOCKET_FILE
+};
+static struct sockaddr_un abstract_addr = {
+	.sun_family = AF_UNIX,
+	.sun_path = ABSTRACT_SOCKET_PATH
+};
+static struct sockaddr_un peer_addr = {
+	.sun_family = AF_UNIX,
+	.sun_path = PEER_SOCKET_FILE
+};
+static struct sockaddr_in ipv4_addr;
+static struct sockaddr_in ipv4_any_addr;
+static struct sockaddr_in6 ipv6_addr;
+static struct sockaddr_in6 ipv6_any_addr;
+
+static struct test_case testcase_list[] = {
+	// UNIX sockets
+	{SOCK_DGRAM, 0, (struct sockaddr*)&unix_addr, sizeof(unix_addr),
+		"AF_UNIX pathname datagram"},
+	{SOCK_DGRAM, 0, (struct sockaddr*)&abstract_addr,
+		sizeof(abstract_addr), "AF_UNIX abstract datagram"},
+
+	// IPv4 sockets
+	{SOCK_DGRAM, 0, (struct sockaddr*)&ipv4_addr, sizeof(ipv4_addr),
+		"IPv4 loop UDP variant 1"},
+	{SOCK_DGRAM, IPPROTO_UDP, (struct sockaddr*)&ipv4_addr,
+		sizeof(ipv4_addr), "IPv4 loop UDP variant 2"},
+	{SOCK_DGRAM, IPPROTO_UDPLITE, (struct sockaddr*)&ipv4_addr,
+		sizeof(ipv4_addr), "IPv4 loop UDP-Lite"},
+	{SOCK_DGRAM, 0, (struct sockaddr*)&ipv4_any_addr,
+		sizeof(ipv4_any_addr), "IPv4 any UDP variant 1"},
+	{SOCK_DGRAM, IPPROTO_UDP, (struct sockaddr*)&ipv4_any_addr,
+		sizeof(ipv4_any_addr), "IPv4 any UDP variant 2"},
+	{SOCK_DGRAM, IPPROTO_UDPLITE, (struct sockaddr*)&ipv4_any_addr,
+		sizeof(ipv4_any_addr), "IPv4 any UDP-Lite"},
+
+	// IPv6 sockets
+	{SOCK_DGRAM, 0, (struct sockaddr*)&ipv6_addr, sizeof(ipv6_addr),
+		"IPv6 loop UDP variant 1"},
+	{SOCK_DGRAM, IPPROTO_UDP, (struct sockaddr*)&ipv6_addr,
+		sizeof(ipv6_addr), "IPv6 loop UDP variant 2"},
+	{SOCK_DGRAM, IPPROTO_UDPLITE, (struct sockaddr*)&ipv6_addr,
+		sizeof(ipv6_addr), "IPv6 loop UDP-Lite"},
+	{SOCK_DGRAM, 0, (struct sockaddr*)&ipv6_any_addr,
+		sizeof(ipv6_any_addr), "IPv6 any UDP variant 1"},
+	{SOCK_DGRAM, IPPROTO_UDP, (struct sockaddr*)&ipv6_any_addr,
+		sizeof(ipv6_any_addr), "IPv6 any UDP variant 2"},
+	{SOCK_DGRAM, IPPROTO_UDPLITE, (struct sockaddr*)&ipv6_any_addr,
+		sizeof(ipv6_any_addr), "IPv6 any UDP-Lite"}
+};
+
+static void setup(void)
+{
+	srand(time(0));
+
+	// Init addresses for IPv4/IPv6 test cases
+	init_sockaddr_inet(&ipv4_addr, IPV4_ADDRESS, 0);
+	init_sockaddr_inet_bin(&ipv4_any_addr, INADDR_ANY, 0);
+	init_sockaddr_inet6_bin(&ipv6_addr, &in6addr_loopback, 0);
+	init_sockaddr_inet6_bin(&ipv6_any_addr, &in6addr_any, 0);
+}
+
+static void *peer_thread(void *tc_ptr)
+{
+	const struct test_case *tc = (struct test_case*)tc_ptr;
+	int sock;
+	unsigned request = 0;
+	const char *response;
+
+	sock = SAFE_SOCKET(tc->address->sa_family, tc->type, tc->protocol);
+
+	// Both sides of AF_UNIX/SOCK_DGRAM socket must be bound for
+	// bidirectional communication
+	if (tc->address->sa_family == AF_UNIX) {
+		SAFE_BIND(sock, (struct sockaddr*)&peer_addr,
+			sizeof(struct sockaddr_un));
+	}
+
+	SAFE_CONNECT(sock, tc->address, tc->addrlen);
+	SAFE_WRITE(1, sock, &request, sizeof(request));
+	SAFE_READ(1, sock, &request, sizeof(request));
+
+	if (request < ARRAY_SIZE(testcase_list)) {
+		response = testcase_list[request].description;
+	} else {
+		response = "Invalid request value";
+	}
+
+	SAFE_WRITE(1, sock, response, strlen(response) + 1);
+	SAFE_CLOSE(sock);
+
+	if (tc->address->sa_family == AF_UNIX) {
+		SAFE_UNLINK(PEER_SOCKET_FILE);
+	}
+
+	return NULL;
+}
+
+static void test_bind(unsigned int n)
+{
+	struct test_case tc_copy, *tc = testcase_list + n;
+	struct sockaddr_storage listen_addr, remote_addr;
+	struct sockaddr_un *tmp_addr;
+	socklen_t remote_len = sizeof(struct sockaddr_storage);
+	int sock, size;
+	unsigned rand_index;
+	pthread_t thread_id;
+	char buffer[BUFFER_SIZE];
+	const char *exp_data;
+
+	// Create listen socket
+	tst_res(TINFO, "Testing %s", tc->description);
+	sock = SAFE_SOCKET(tc->address->sa_family, tc->type, tc->protocol);
+
+	TEST(bind(sock, tc->address, tc->addrlen));
+
+	if (TST_RET) {
+		tst_res(TFAIL | TERRNO, "bind() failed");
+		close(sock);
+		return;
+	}
+
+	// IPv4/IPv6 tests use wildcard addresses, resolve a valid connection
+	// address for peer thread
+	memcpy(&tc_copy, tc, sizeof(struct test_case));
+	tc_copy.addrlen = get_connect_address(sock, &listen_addr);
+	tc_copy.address = (struct sockaddr*)&listen_addr;
+
+	// Start peer thread and wait for connection
+	SAFE_PTHREAD_CREATE(&thread_id, NULL, peer_thread, &tc_copy);
+	size = recvfrom(sock, &rand_index, sizeof(rand_index), 0,
+		(struct sockaddr*)&remote_addr, &remote_len);
+
+	if (size != sizeof(rand_index)) {
+		tst_brk(TBROK | TERRNO, "Error while waiting for connection");
+	}
+
+	// Send request
+	rand_index = rand() % ARRAY_SIZE(testcase_list);
+	SAFE_SENDTO(1, sock, &rand_index, sizeof(rand_index), 0,
+		(struct sockaddr*)&remote_addr, remote_len);
+
+	// Read test data
+	size = SAFE_READ(0, sock, buffer, BUFFER_SIZE - 1);
+	buffer[size] = '\0';
+	exp_data = testcase_list[rand_index].description;
+
+	if (!strcmp(buffer, exp_data)) {
+		tst_res(TPASS, "Communication successful");
+	} else {
+		tst_res(TFAIL, "Received invalid data. Expected: \"%s\". "
+			"Received: \"%s\"", exp_data, buffer);
+	}
+
+	// Cleanup
+	SAFE_CLOSE(sock);
+	pthread_join(thread_id, NULL);
+	tmp_addr = (struct sockaddr_un*)tc->address;
+
+	if (tc->address->sa_family == AF_UNIX && tmp_addr->sun_path[0]) {
+		SAFE_UNLINK(tmp_addr->sun_path);
+	}
+}
+
+static struct tst_test test = {
+	.test = test_bind,
+	.tcnt = ARRAY_SIZE(testcase_list),
+	.needs_tmpdir = 1,
+	.setup = setup,
+};
diff --git a/testcases/kernel/syscalls/bind/libbind.h b/testcases/kernel/syscalls/bind/libbind.h
new file mode 100644
index 000000000..e19758f1b
--- /dev/null
+++ b/testcases/kernel/syscalls/bind/libbind.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (c) 2019 Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*
+ * Common settings and data types for bind() connection tests
+ */
+
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
+#include <netinet/ip.h>
+
+#define MAIN_SOCKET_FILE "test.sock"
+#define ABSTRACT_SOCKET_PATH "\0test.sock"
+#define PEER_SOCKET_FILE "peer.sock"
+#define IPV4_ADDRESS "127.0.0.1"
+#define IPV6_ADDRESS "::1"
+#define BUFFER_SIZE 128
+
+struct test_case {
+	int type, protocol;
+	struct sockaddr *address;
+	socklen_t addrlen;
+	const char *description;
+};
-- 
2.23.0

