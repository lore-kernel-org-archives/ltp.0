Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4026F606A31C
	for <ltp@archiver.kernel.org>; Tue, 17 Nov 2026 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=HKX2QY+u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fh0YOGwV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794957667; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=Dy1m0qJ2eriXDsuP9nHifE8gDFjzVDZ6K+dVRBljLMM=;
 b=HKX2QY+uh1dLlUsVK9aXrAwkr34dBBM39edayoXtTI4hqb3vimBT71MFPtr1agkpWqsjt
 I3EgfWdgA62Mw8r9vokp3z2y3HhiL1opaBGJfHqIDEcxvWwxBolpeZOWKegmoBTKPs+22jq
 NvcIMeJ83/nI1vOYQLByWcvTpy5yqS0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 893673EC317
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 00:21:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 982F73E210E
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 00:20:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC9E0140020B
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 00:20:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794957644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6u2ST0OK722fIWgQSIbyMLL+PsPTLlN415dsorYqz1s=;
 b=fh0YOGwVVvxm7e0RDUx2qa87/iFvp8Zh+WPOajs2kU1O8XqP9mr4jzQU+82FbUAjwA78To
 xh57x7j95mDU5RqKV7Mp3XRq0zwszVPPPEcV1RcZJokJUU4efsnqqaNEfGk3vh+H4C1JPZ
 mCRZJTRV3M8PQrisjEfD6Gp5TMmV124=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-znRI_5xANGmfxdbIW74xGw-1; Tue, 17 Nov 2026 18:20:41 -0500
X-MC-Unique: znRI_5xANGmfxdbIW74xGw-1
X-Mimecast-MFC-AGG-ID: znRI_5xANGmfxdbIW74xGw_1794957641
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-945b0154705so59290685a.3
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 15:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794957641; x=1795562441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6u2ST0OK722fIWgQSIbyMLL+PsPTLlN415dsorYqz1s=;
 b=UqvxUMtkVsCIRjqYkuHhhmIGO/Q7k6Q11gJKIlffm9uSFR/F7diwWOt/Tn2uZFmTkM
 QuP0+54axuWF/c12i7jkTY5Jke6VgtGYTb6uWkBQuV+NCg7qq/S63PrFQ9Jyxp8JYCv4
 VHMVTElIHxwJ0Bp3MxAgr+xBI3AWxGySQt9qmEwtShXQG3cN7nrAxQUrsJt7gavH/n+L
 rYO4iZZtW9mq+3H42b7wsCrfvnOcdMknToJnDU3D+6tbaUASbIiAiXUHBMTg1+s6LURE
 8Z4LFPYBRjGJMFbkWO2W+GqEoYd4ilMWealXy5PH4YjDjDKmI2nYVW9shoq7My0F+XpQ
 GriQ==
X-Gm-Message-State: APuU4Z94Hkjfyz/cWYW5xsB3RHGJ4PGFBuKXG7a5CeTZGUoJZieQD4LU
 8YNAC9GJdn+OHqa/f89T0VTPVuAIi7lFnGKa0Kd3pN2fIqIKJtKoi4/YpnCi7RhKzFxqJTnI6dN
 r0ewgvM3fdI7bauDqjKd21JJ0X/1n0GLt/nnCnzhqXzjRXnwAyjSXSmDtjfDtx10ahuPquS3RbK
 UTSJgAUa6znguT6auI/yhiDE+fVaRFWu7Hpdsu
X-Gm-Gg: AYBFou1zFzfx7V6fjLnLDrnKI4+Z5pJ77FE+EoFAzEjymR/b3lUwLFM5uC4kmaJrSQr
 kSSYT9MWAteU3cB6rC7lupFlsomSukR19IDNy4k1hUPDUhsSRx6OQrAucWdYEXrLn5nzkekgIyv
 u9ceYzUGSfxDIyn8SSwPU/fY61nCDnq4A3kGdZU2pvgUAdgehFEE1mH1PupZedRcTaVY4xnTuNX
 moO9ZEGYVc2JPxbnVy+MA91H6uH9mSOzbDRSRNPlzFzYc3hCE2p7PsBKT3bpOv0XRfaY30VmuLD
 icbsyu+sJNLpqHIsccXckVTZ7BjNH8z/y+kPjn9yG7V0aztBTwSTLX6Vn1zjUHP2jmcVcOo7KbY
 +9tF7mExT1MRlPSohc9EJGlo/9/f9fDe3Gkj3NHz9ugVDuIbNanquiK+3Kgi+dkbOCcvN1OfJt2
 F7AmU=
X-Received: by 2002:a05:620a:2685:b0:949:8106:3ee3 with SMTP id
 af79cd13be357-94999623e12mr218033985a.69.1794957640916; 
 Tue, 17 Nov 2026 15:20:40 -0800 (PST)
X-Received: by 2002:a05:620a:2685:b0:949:8106:3ee3 with SMTP id
 af79cd13be357-94999623e12mr218029185a.69.1794957640041; 
 Tue, 17 Nov 2026 15:20:40 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.redhat.corp ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b7ad72csm40428185a.29.2026.11.17.15.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:20:39 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 17 Nov 2026 18:20:34 -0500
Message-ID: <20261117232036.1228445-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GJBHoRFY4uaYrol7Jvk1mXPK3vp0QvMbdi4biUqd0HU_1794957641
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] network/sockets: Add handshake01
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
 testcases/network/sockets/handshake01.c | 243 ++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
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
index 000000000..68384edec
--- /dev/null
+++ b/testcases/network/sockets/handshake01.c
@@ -0,0 +1,243 @@
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
+static void setup(void)
+{
+	struct passwd *pw = SAFE_GETPWNAM("nobody");
+
+	nobody_uid = pw->pw_uid;
+	nobody_gid = pw->pw_gid;
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
+static int unprivileged_done(void)
+{
+	int fds[2], err = 0;
+	pid_t pid;
+
+	SAFE_PIPE(fds);
+	pid = SAFE_FORK();
+
+	if (!pid) {
+		int ret;
+
+		SAFE_CLOSE(fds[0]);
+
+		SAFE_SETGROUPS(0, NULL);
+		SAFE_SETGID(nobody_gid);
+		SAFE_SETUID(nobody_uid);
+
+		ret = send_done();
+
+		SAFE_WRITE(SAFE_WRITE_ALL, fds[1], &ret, sizeof(ret));
+		_exit(0);
+	}
+
+	SAFE_CLOSE(fds[1]);
+	SAFE_READ(SAFE_READ_ALL, fds[0], &err, sizeof(err));
+	SAFE_CLOSE(fds[0]);
+	SAFE_WAITPID(pid, NULL, 0);
+
+	return err;
+}
+
+static void run(void)
+{
+	int root_err, child_err;
+
+	nl_family_id = resolve_family(HANDSHAKE_FAMILY_NAME);
+
+	root_err = send_done();
+	if (root_err == -EPERM)
+		tst_brk(TBROK, "root was denied HANDSHAKE_CMD_DONE");
+	if (root_err != -EINVAL)
+		tst_brk(TBROK,
+			"root HANDSHAKE_CMD_DONE returned %d (%s), expected EINVAL",
+			root_err, strerror(-root_err));
+
+	child_err = unprivileged_done();
+
+	if (child_err == -EPERM)
+		tst_res(TPASS, "unprivileged HANDSHAKE_CMD_DONE rejected with EPERM");
+	else
+		tst_res(TFAIL,
+			"unprivileged HANDSHAKE_CMD_DONE returned %d (%s), expected EPERM",
+			child_err, strerror(-child_err));
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
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
