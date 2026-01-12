Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A7BD2502E
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 01:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768181250; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=xZ+SpplfQbFI9BUlRkS8DSDWxzJ3MwsdK+VFVzHx89A=;
 b=d/rX7xncnEWN7hNg0T6eE+sO0RoKwIKRHM36tgYonWsDJ6XEXnmOgxUHKK5iJ0Epxja06
 BQBVTay9EobpH69NO2IUgH223U8ykOgtFqe6IKuUkSmIOUa+NZa+tGDZnx9+lTJGYn+bmfE
 eOA7OpjoQzOVH6dYMQqOt3D8N9qJ6tU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFFD33C2EA5
	for <ltp@archiver.kernel.org>; Mon, 12 Jan 2026 02:27:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67F733C2775
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 02:27:04 +0100 (CET)
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com
 [113.46.200.222])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E49C560062A
 for <ltp@lists.linux.it>; Mon, 12 Jan 2026 02:27:02 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=5wnRDfonOpjSKK1hgmlTpmXxcrud6WxxV7myzsMexR0=;
 b=ZgePxtLPiMF183Emjg9H8WkYjfLbY53872igY6u1nCh01ITl51hlrS0pnXmwUZAvSzwHswGg4
 ws8SomrHjdtFQ931JlV7toYiaPe3eBHchzPM22HP47z7g5y9nMuqJNYDiAoVaV1MRgbnBYyslNW
 d9gEc652XUNiy7RHJ5TJyK8=
Received: from mail.maildlp.com (unknown [172.19.162.92])
 by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dqF565LNrzLlxJ;
 Mon, 12 Jan 2026 09:23:38 +0800 (CST)
Received: from dggpemf500015.china.huawei.com (unknown [7.185.36.143])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B02D40565;
 Mon, 12 Jan 2026 09:26:56 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500015.china.huawei.com
 (7.185.36.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 Jan
 2026 09:26:55 +0800
To: <ltp@lists.linux.it>, <andrea.cervesato@suse.com>
Date: Mon, 12 Jan 2026 09:50:47 +0800
Message-ID: <20260112015047.2184003-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Originating-IP: [10.50.85.128]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500015.china.huawei.com (7.185.36.143)
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc validation
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Liu Jian via ltp <ltp@lists.linux.it>
Reply-To: Liu Jian <liujian56@huawei.com>
Cc: liujian56@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Liu Jian via ltp <ltp@lists.linux.it>

The testcase(rpc_svc_destroy, rpc_svcfd_create, rpc_xprt_register,
rpc_xprt_unregister) was failing due to an invalid fd, which
caused libtirpc's internal validation to reject the operation.
This change ensures a valid socket fd is created and can pass the
validation checks in libtirpc.

Signed-off-by: Liu Jian <liujian56@huawei.com>
---
v2: Fix a compilation error on Alpine.
 .../rpc_svc_destroy.c                         | 27 +++++++++++++++++++
 .../rpc_svcfd_create.c                        | 26 ++++++++++++++++++
 .../rpc_xprt_register.c                       | 25 +++++++++++++++++
 .../rpc_xprt_unregister.c                     | 25 +++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
index 22e560843..b9240ccba 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
@@ -30,6 +30,12 @@
 #include <time.h>
 #include <rpc/rpc.h>
 
+#include <unistd.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <string.h>
+
 //Standard define
 #define PROCNUM 1
 #define VERSNUM 1
@@ -43,6 +49,27 @@ int main(void)
 	int test_status = 1;	//Default test result set to FAILED
 	int fd = 0;
 	SVCXPRT *svcr = NULL;
+	struct sockaddr_in server_addr;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		printf("socket creation failed");
+		return test_status;
+	}
+
+	memset(&server_addr, 0, sizeof(server_addr));
+	server_addr.sin_family = AF_INET;
+	server_addr.sin_port = htons(9001);
+	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
+		printf("inet_pton failed");
+		close(fd);
+		return test_status;
+	}
+	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
+		printf("connect failed");
+		close(fd);
+		return test_status;
+	}
 
 	//First of all, create a server
 	svcr = svcfd_create(fd, 0, 0);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
index f0d89ba48..ea4418961 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
@@ -29,6 +29,11 @@
 #include <stdlib.h>
 #include <time.h>
 #include <rpc/rpc.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <string.h>
 
 //Standard define
 #define PROCNUM 1
@@ -43,6 +48,27 @@ int main(void)
 	int test_status = 1;	//Default test result set to FAILED
 	int fd = 0;
 	SVCXPRT *svcr = NULL;
+	struct sockaddr_in server_addr;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		printf("socket creation failed");
+		return test_status;
+	}
+
+	memset(&server_addr, 0, sizeof(server_addr));
+	server_addr.sin_family = AF_INET;
+	server_addr.sin_port = htons(9001);
+	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
+		printf("inet_pton failed");
+		close(fd);
+		return test_status;
+	}
+	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
+		printf("connect failed");
+		close(fd);
+		return test_status;
+	}
 
 	//create a server
 	svcr = svcfd_create(fd, 0, 0);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
index b10a1ce5e..a40dad7fe 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
@@ -31,6 +31,10 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <string.h>
 
 //Standard define
 #define PROCNUM 1
@@ -45,6 +49,27 @@ int main(void)
 	int test_status = 1;	//Default test result set to FAILED
 	SVCXPRT *svcr = NULL;
 	int fd = 0;
+	struct sockaddr_in server_addr;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		printf("socket creation failed");
+		return test_status;
+	}
+
+	memset(&server_addr, 0, sizeof(server_addr));
+	server_addr.sin_family = AF_INET;
+	server_addr.sin_port = htons(9001);
+	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
+		printf("inet_pton failed");
+		close(fd);
+		return test_status;
+	}
+	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
+		printf("connect failed");
+		close(fd);
+		return test_status;
+	}
 
 	//create a server
 	svcr = svcfd_create(fd, 1024, 1024);
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
index 3b6130eaa..5ac51de41 100644
--- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
@@ -31,6 +31,10 @@
 #include <rpc/rpc.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <unistd.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <string.h>
 
 //Standard define
 #define PROCNUM 1
@@ -49,6 +53,27 @@ int main(int argn, char *argc[])
 	int test_status = 1;	//Default test result set to FAILED
 	SVCXPRT *svcr = NULL;
 	int fd = 0;
+	struct sockaddr_in server_addr;
+
+	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	if (fd < 0) {
+		printf("socket creation failed");
+		return test_status;
+	}
+
+	memset(&server_addr, 0, sizeof(server_addr));
+	server_addr.sin_family = AF_INET;
+	server_addr.sin_port = htons(9001);
+	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
+		printf("inet_pton failed");
+		close(fd);
+		return test_status;
+	}
+	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
+		printf("connect failed");
+		close(fd);
+		return test_status;
+	}
 
 	//create a server
 	svcr = svcfd_create(fd, 1024, 1024);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
