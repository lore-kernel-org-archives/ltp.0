Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6308AD66B9A
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765998456; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=t9pZEnJMx3FQSiTtPnVcju8ZzGMvG+wns/4h8CbNK2o=;
 b=YZgm9rHQduAktlb+pQxZZ5jGuP+p4JGAotpvZj8PvGIGVOSOuAMQuysbXAK/8f71pF8Pk
 GyVf/QHZ4Yp6+TK+tyCEejkBwPqlITizVTua0yZ+KNV1DcrvlyZqH4lPTXIi4GIdRYqFaLN
 fgonabf6wlp4fKkEFSlDSbZaaPUOOp0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B679F3D041A
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 20:07:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA0113CFA4E
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 20:07:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB5BF60096A
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 20:07:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765998430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RBlClbqw/KvR+8m8aiNxElVhaFzxOIjN9ReQRMvGcb4=;
 b=X97df9jQEumXn0B4x6zxuegc4Wx73XyA59mzw+DJ3/LPQGT1xmP7deh8FkZKv43E8PWate
 apuN7I2vzoeMmOmBdYVsGAD7Lk1hUBLVyIVzF2taIumJjtymjrrb+WKQZVKjobtaYJ02W2
 8yTKWOAJOq5K1gNCdYxG3B5e5aY8mK8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-4RHtpS6GPtOGAaMw4BzMnw-1; Wed,
 17 Dec 2025 14:07:08 -0500
X-MC-Unique: 4RHtpS6GPtOGAaMw4BzMnw-1
X-Mimecast-MFC-AGG-ID: 4RHtpS6GPtOGAaMw4BzMnw_1765998427
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA3EB1800669
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 19:07:07 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.253])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39CFA1956056; Wed, 17 Dec 2025 19:07:06 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 17 Dec 2025 13:06:37 -0600
Message-ID: <20251217190637.60929-1-bgrech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yp18gTcHP2-iQ3JBs2Mz2R8GDs7vG6uM6nn2x-Y9dXs_1765998427
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] landlock08: Skip IPv6 variant if not supported
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
From: Brian Grech via ltp <ltp@lists.linux.it>
Reply-To: Brian Grech <bgrech@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Check for IPv6 support before forking the server process to avoid
checkpoint timeout issues. If IPv6 is not available (EAFNOSUPPORT),
report TCONF and skip the variant gracefully.

This allows the landlock08 test to be executed on systems without
IPv6 support.

Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 testcases/kernel/syscalls/landlock/landlock08.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/testcases/kernel/syscalls/landlock/landlock08.c b/testcases/kernel/syscalls/landlock/landlock08.c
index 7c498e6d5..7e7d8470b 100644
--- a/testcases/kernel/syscalls/landlock/landlock08.c
+++ b/testcases/kernel/syscalls/landlock/landlock08.c
@@ -102,12 +102,28 @@ static void test_connect(const int addr_family, const in_port_t port,
 	SAFE_CLOSE(socket.fd);
 }
 
+static int check_ipv6_support(void)
+{
+	int fd;
+
+	fd = socket(AF_INET6, SOCK_STREAM, 0);
+	if (fd == -1 && errno == EAFNOSUPPORT) {
+		tst_res(TCONF, "IPv6 not supported in kernel");
+		return 0;
+	}
+	if (fd != -1)
+		close(fd);
+	return 1;
+}
+
 static void run(void)
 {
 	int addr_family = variants[tst_variant];
 
 	tst_res(TINFO, "Using %s protocol",
 		addr_family == AF_INET ? "IPV4" : "IPV6");
+	if (addr_family == AF_INET6 && !check_ipv6_support())
+		return;
 
 	if (!SAFE_FORK()) {
 		create_server(addr_family);
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
