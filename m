Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE160A2602
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=BMXcE4FM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TCHcpE7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795012412; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gLkRwHmdQ9FGgmj9uktxDRilWVjjPX3tDDpR69TqUOk=;
 b=BMXcE4FMhT8EQZitxfeKD2Jiz6E9qQR531XyCwp+zpRR4RmE2J9sUi0LIlCsW+hmx8K27
 90BbgO1c1xN6WRn2RXrJN5NfCW+wUJ7ed+OUxFPyR6X12vvrahT99P3zdcxC6lY/eb7Ootg
 d70aF6PlJnj0uixEm7ybRbkMKFWpF6c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F7893EA9A9
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 15:33:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F25F3E9511
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 15:33:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B157140096C
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 15:33:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795012390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Elz6vcBGiktB2nlCruDmOIE6wXMRRqA43uiJbiUMTcM=;
 b=TCHcpE7BW2Q1PNTTN81GDwTG3Xep848D/9HIHDPb0kUDEmrrPw6Zd4BkarHHTEOdpeEcRb
 zPWBPKZk8VEnoLF66cl0AgPh0T5dntGR3hT0Adq+MRTbDgOzYgbOyACH/EXzcsD4LzpJK8
 RHP3iTsx1OxWrIOmZgHcFw1HRFn+te4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-4eegqiBpOIm7dhHGeCbYtA-1; Wed, 18 Nov 2026 09:33:09 -0500
X-MC-Unique: 4eegqiBpOIm7dhHGeCbYtA-1
X-Mimecast-MFC-AGG-ID: 4eegqiBpOIm7dhHGeCbYtA_1795012389
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-55c5cbc838aso23189421cf.3
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 06:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012389; x=1795617189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Elz6vcBGiktB2nlCruDmOIE6wXMRRqA43uiJbiUMTcM=;
 b=XM9iFdTzZQ5tkTMegD9vMPvv1J5VQn23OHnaGbuYuEhH5xg3M1v8fUVHE/R061m2qi
 +JDd9/OuYjji0gH5Cl0H03+h4kvzb6tYTl4TAiDqY1W3WypMIL+uG+EkNaQHBTvGbBP5
 HciLAv6HJnBipg8lLGlPerHU2N0QLV/5wbekmH0IfkmJfmTUO6hEv+6mFenE5Bgc7kO9
 URVwYAXtmLhcuPKvP80RMV3y70PZ6yQo2DTqia/9rn11xTQaGkDJSzuUNHr9GMx3oHNd
 CcmHwech+hFyCyKpEJpTLNfNRTCTLLEKAa0zErleYXMuy27HKMfnzDpNhTDk/84tYsbK
 n7Sg==
X-Gm-Message-State: APuU4Z/etgeC/0II/4ZZYQxIPzx3YBMWO4vpXqX+9k7Pp3bnDHBakG4G
 +wHAQ5RlKwxrwNyIQY3UBJwi9cCIMj7KsHEtARiaoKXcPUQrWB/hr6/SRJl7o4yi4AXlmIdXXaE
 9uc+JKfB1iVUH/8P7kXUg4UtOWjEACAcJHb/ZXbO6npD8/KFdL0zy3p+d2rDJsyaxcRX/NeT013
 eiiMYhMJ0YIA4i+5lFnOCoCFABxeM83aC6zd5A
X-Gm-Gg: AYBFou1YPBRktSlhyeKONKi4sCyI2O7XN5Rcu2DS9pDMyPxLNwMNs/ZiMllLISWTyKD
 kgHC8r8bL1FxsAdj0kAhbVVdvlV3R7z0w2F6dQmHoG+mDzt//oZQUTR5hemHqSHP+T0zRvmup4a
 wvkufdumvKEnwV84ff4bVBcFPDpTFCuXxNy8SfsIgGWB4vKnjloZW1/rRU1/uj58b8uvI8qxe/d
 DCMoHURAiCPt02taI3MmTKPe4mt4nVQU0FTQ8I7Re6sb2B2ELtwv1RHvdfVIo1U60hF+B+W074g
 2G5joyMvGdO1LjSZXGhmkBdyTI8PO2L9Wos33QEvzX4LsT/ACoTieVw7czEGmkCtSqQfXJZt+jM
 2kEwFThy0md6kUTXS0a4mOIe1DgqG0iF79ztxUobX4era7d8jWyR6gsYdRESKIvtETBy5kqqqc1
 tovP4B
X-Received: by 2002:ac8:59cf:0:b0:55c:8dc9:401c with SMTP id
 d75a77b69052e-55d5a705ac1mr42716901cf.70.1795012388500; 
 Wed, 18 Nov 2026 06:33:08 -0800 (PST)
X-Received: by 2002:ac8:59cf:0:b0:55c:8dc9:401c with SMTP id
 d75a77b69052e-55d5a705ac1mr42716101cf.70.1795012387727; 
 Wed, 18 Nov 2026 06:33:07 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.redhat.corp ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d669bb8d4sm1012191cf.3.2026.11.18.06.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:33:07 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 18 Nov 2026 09:32:54 -0500
Message-ID: <20261118143256.195124-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117232036.1228445-1-sbertram@redhat.com>
References: <20261117232036.1228445-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QvR_MXJnonj3rpfH1dfsJmr3eb4NrNga2nQHiHfYCKY_1795012389
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] network/sockets: Add handshake01
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Stephen Bertram <sbertram@redhat.com>

Add a regression test for CVE-2026-74270 (81246a65303d "handshake:
Require admin permission for DONE command"). Verify that
HANDSHAKE_CMD_DONE returns -EPERM for a sender without CAP_NET_ADMIN,
while root reaches the handler and gets -EINVAL for the missing sockfd.

Register it as cve-2026-74270 in runtest/cve.

Reviewed and tested before submission: builds, passes check-handshake01,
fails on the unfixed kernel and passes on the fixed kernel.

Assisted-by: ClaudeCode:DeepSeek-V4.1-Flash
Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 runtest/cve                             |   1 +
 testcases/network/sockets/.gitignore    |   1 +
 testcases/network/sockets/handshake01.c | 230 ++++++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100644 testcases/network/sockets/handshake01.c

diff --git a/runtest/cve b/runtest/cve
index 0fe25cd83..fb31cd76f 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -105,3 +105,4 @@ cve-2026-46300 xfrm02
 cve-2026-46300-skb-segment xfrm03
 cve-2026-46331 cve-2026-46331
 cve-2026-64564 sctphantom
+cve-2026-74270 handshake01
diff --git a/testcases/network/sockets/.gitignore b/testcases/network/sockets/.gitignore
index 3e8962bbf..c7d784d36 100644
--- a/testcases/network/sockets/.gitignore
+++ b/testcases/network/sockets/.gitignore
@@ -1,3 +1,4 @@
+/handshake01
 /xfrm01
 /xfrm02
 /xfrm03
diff --git a/testcases/network/sockets/handshake01.c b/testcases/network/sockets/handshake01.c
new file mode 100644
index 000000000..a4d04b745
--- /dev/null
+++ b/testcases/network/sockets/handshake01.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Test for CVE-2026-74270 fixed by:
+ * 81246a65303d ("handshake: Require admin permission for DONE command")
+ *
+ * The handshake generic netlink family exposes the ACCEPT and DONE downcalls
+ * for the trusted handshake agent (tlshd). ACCEPT requires GENL_ADMIN_PERM;
+ * DONE had no privilege check. An unprivileged process that knows a socket
+ * with a pending handshake could send a forged DONE and make the kernel
+ * consumer proceed as if the handshake succeeded, or tear down a legitimate
+ * handshake with a non-zero status.
+ *
+ * The test resolves the ``handshake`` family and sends ``HANDSHAKE_CMD_DONE``
+ * without attributes. The generic netlink permission check runs before
+ * attribute parsing, so no pending handshake is needed: the kernel rejects
+ * the request with ``-EPERM`` for a sender without ``CAP_NET_ADMIN``. A root
+ * control must instead reach the handler and fail with ``-EINVAL`` because
+ * ``HANDSHAKE_A_DONE_SOCKFD`` is missing.
+ *
+ * On an unfixed kernel the unprivileged request reaches the handler and
+ * returns ``-EINVAL`` as well, so the test fails.
+ */
+
+#include <linux/genetlink.h>
+#include <pwd.h>
+
+#include "tst_test.h"
+#include "tst_netlink.h"
+
+/*
+ * Values from include/uapi/linux/handshake.h. Define them locally so the
+ * test builds against kernel headers older than 6.7.
+ */
+#ifndef HANDSHAKE_FAMILY_NAME
+# define HANDSHAKE_FAMILY_NAME "handshake"
+#endif
+#ifndef HANDSHAKE_FAMILY_VERSION
+# define HANDSHAKE_FAMILY_VERSION 1
+#endif
+#ifndef HANDSHAKE_CMD_DONE
+# define HANDSHAKE_CMD_DONE 3
+#endif
+
+static int nl_family_id;
+static uid_t nobody_uid;
+static gid_t nobody_gid;
+
+static int resolve_family(const char *name);
+
+static void setup(void)
+{
+	struct passwd *pw = SAFE_GETPWNAM("nobody");
+
+	nobody_uid = pw->pw_uid;
+	nobody_gid = pw->pw_gid;
+
+	nl_family_id = resolve_family(HANDSHAKE_FAMILY_NAME);
+}
+
+static int resolve_family(const char *name)
+{
+	struct tst_netlink_context *ctx;
+	struct tst_netlink_message *msgs, *m;
+	struct nlmsghdr nlh = {
+		.nlmsg_type = GENL_ID_CTRL,
+		.nlmsg_flags = NLM_F_REQUEST,
+	};
+	struct genlmsghdr gh = {
+		.cmd = CTRL_CMD_GETFAMILY,
+		.version = 1,
+	};
+	char *p;
+	int id = -1, rem;
+	uint16_t fid;
+
+	ctx = NETLINK_CREATE_CONTEXT(NETLINK_GENERIC);
+	NETLINK_ADD_MESSAGE(ctx, &nlh, &gh, sizeof(gh));
+	NETLINK_ADD_ATTR_STRING(ctx, CTRL_ATTR_FAMILY_NAME, name);
+
+	if (NETLINK_SEND(ctx) < 0)
+		tst_brk(TBROK | TERRNO, "send(CTRL_CMD_GETFAMILY) failed");
+
+	if (NETLINK_WAIT(ctx) <= 0)
+		tst_brk(TBROK, "no response to CTRL_CMD_GETFAMILY");
+
+	msgs = NETLINK_RECV(ctx);
+	if (!msgs)
+		tst_brk(TBROK, "no response to CTRL_CMD_GETFAMILY");
+
+	for (m = msgs; m->header; m++) {
+		if (m->err) {
+			if (m->err->error == -ENOENT)
+				tst_brk(TCONF, "family '%s' is not available", name);
+			if (m->err->error)
+				tst_brk(TBROK, "CTRL_CMD_GETFAMILY failed: %s",
+					strerror(-m->err->error));
+			continue;
+		}
+
+		if (m->header->nlmsg_type != GENL_ID_CTRL)
+			continue;
+		if (m->payload_size < GENL_HDRLEN)
+			continue;
+
+		p = (char *)m->payload + GENL_HDRLEN;
+		rem = (int)m->payload_size - GENL_HDRLEN;
+
+		while (rem >= (int)sizeof(struct nlattr)) {
+			struct nlattr *a = (struct nlattr *)p;
+			int alen;
+
+			if (a->nla_len < NLA_HDRLEN)
+				break;
+
+			alen = NLA_ALIGN(a->nla_len);
+			if (alen > rem)
+				break;
+
+			if ((a->nla_type & NLA_TYPE_MASK) == CTRL_ATTR_FAMILY_ID) {
+				if (a->nla_len < NLA_HDRLEN + (int)sizeof(fid))
+					break;
+
+				memcpy(&fid, (char *)a + NLA_HDRLEN, sizeof(fid));
+				id = fid;
+				break;
+			}
+
+			p += alen;
+			rem -= alen;
+		}
+
+		if (id >= 0)
+			break;
+	}
+
+	NETLINK_FREE_MESSAGE(msgs);
+	NETLINK_DESTROY_CONTEXT(ctx);
+
+	if (id < 0)
+		tst_brk(TBROK, "CTRL_ATTR_FAMILY_ID not found for '%s'", name);
+
+	return id;
+}
+
+static int send_done(void)
+{
+	struct tst_netlink_context *ctx;
+	struct nlmsghdr nlh = {
+		.nlmsg_type = nl_family_id,
+		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+	};
+	struct genlmsghdr gh = {
+		.cmd = HANDSHAKE_CMD_DONE,
+		.version = HANDSHAKE_FAMILY_VERSION,
+	};
+	int ret;
+
+	ctx = NETLINK_CREATE_CONTEXT(NETLINK_GENERIC);
+	NETLINK_ADD_MESSAGE(ctx, &nlh, &gh, sizeof(gh));
+
+	ret = NETLINK_SEND_VALIDATE(ctx);
+	NETLINK_DESTROY_CONTEXT(ctx);
+
+	if (ret)
+		return 0;
+
+	/* No ACK and no error means the kernel never replied. */
+	if (!tst_netlink_errno)
+		return -ETIMEDOUT;
+
+	return -tst_netlink_errno;
+}
+
+static void unprivileged_done(void)
+{
+	int ret;
+
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETGROUPS(0, NULL);
+	SAFE_SETGID(nobody_gid);
+	SAFE_SETUID(nobody_uid);
+
+	ret = send_done();
+
+	if (ret == -EPERM)
+		tst_res(TPASS, "unprivileged HANDSHAKE_CMD_DONE rejected with EPERM");
+	else
+		tst_res(TFAIL,
+			"unprivileged HANDSHAKE_CMD_DONE returned %d (%s), expected EPERM",
+			ret, strerror(-ret));
+
+	exit(0);
+}
+
+static void run(void)
+{
+	int root_err;
+
+	root_err = send_done();
+	if (root_err == -EPERM)
+		tst_brk(TBROK, "root was denied HANDSHAKE_CMD_DONE");
+	if (root_err != -EINVAL)
+		tst_brk(TBROK,
+			"root HANDSHAKE_CMD_DONE returned %d (%s), expected EINVAL",
+			root_err, strerror(-root_err));
+
+	unprivileged_done();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_NET_HANDSHAKE",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "81246a65303d9635266b1334490142caaf86a11f"},
+		{"CVE", "2026-74270"},
+		{}
+	},
+};
-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
