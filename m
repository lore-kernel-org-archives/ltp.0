Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F6EC4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 12:32:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99FCF3CE4F0
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 13:32:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 343343CC318
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 13:31:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D30A51400E65
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 13:31:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC7A4218EA;
 Tue, 14 Nov 2023 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699965101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvoJnJUkWN0fXa6n+1Td/Y7+/i9UnuFYT0kEqbdhgNA=;
 b=EC8Uzsjsq2Nrba5YUQKKwQu0wXi13hFMRs5wyF6FzmrmqlVld2oONwrtCwvIlCf+89/rn2
 7FD6Il2zDStzG+dgqFi+B7PS5IXioBiT7JTyJCJnid9r8wtDwGuZ3KIVCxYIUkOMzQLHaX
 19f1d/tqAsHP0josbnJRtMmGRSGcN7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699965101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvoJnJUkWN0fXa6n+1Td/Y7+/i9UnuFYT0kEqbdhgNA=;
 b=usABbJTuTDqs/4TkZsMMZvdlgZpA8eDrE/llzgFEe5DvCW2+ydmEcN+7w5CtLu90qf4k2e
 drG+ptlau4NBybCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0A2613A73;
 Tue, 14 Nov 2023 12:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mNYxMq1oU2UibAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 14 Nov 2023 12:31:41 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Petr Vorel <pvorel@suse.cz>,
	ltp@lists.linux.it
Date: Tue, 14 Nov 2023 13:31:24 +0100
Message-ID: <20231114123140.1144-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114123140.1144-1-mdoucha@suse.cz>
References: <20231114123140.1144-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] crypto: Replace old netlink helper functions
 with netlink contexts
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Finish refactoring of netlink helper functions for generic use
and replace the very limited netlink send/receive functions
used by the crypto tests with the new context-based helpers.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Rebased
- Removed doc references to tst_crypto_session

The tst_netlink_context structure is initialized by NETLINK_CREATE_CONTEXT(),
no macro is needed or even desirable since it's an opaque structure. It has
no documentation so I've just removed the @relates references
to tst_crypto_session.

 doc/C-Test-Network-API.asciidoc         |   4 +-
 include/tst_crypto.h                    |  69 +---------
 include/tst_netdevice.h                 |   2 +-
 include/tst_netlink.h                   | 171 ++++++++++++++----------
 include/tst_rtnetlink.h                 | 109 ---------------
 lib/tst_crypto.c                        |  90 +++----------
 lib/tst_netdevice.c                     |   2 +-
 lib/{tst_rtnetlink.c => tst_netlink.c}  |   2 +-
 testcases/cve/tcindex01.c               |   2 +-
 testcases/kernel/crypto/crypto_user01.c |  58 +++-----
 testcases/kernel/crypto/crypto_user02.c |  17 +--
 testcases/kernel/crypto/pcrypt_aead01.c |  10 +-
 12 files changed, 159 insertions(+), 377 deletions(-)
 delete mode 100644 include/tst_rtnetlink.h
 rename lib/{tst_rtnetlink.c => tst_netlink.c} (99%)

diff --git a/doc/C-Test-Network-API.asciidoc b/doc/C-Test-Network-API.asciidoc
index 25e4bbd18..d04dd6aa3 100644
--- a/doc/C-Test-Network-API.asciidoc
+++ b/doc/C-Test-Network-API.asciidoc
@@ -277,7 +277,7 @@ static void setup(void)
 3 Netlink API
 ---------------
 
-+#include "tst_rtnetlink.h"+
++#include "tst_netlink.h"+
 
 The netlink library provides helper functions for constructing and sending
 arbitrary messages and parsing kernel responses.
@@ -443,7 +443,7 @@ Example Usage
 #include <arpa/inet.h>
 
 #include "tst_test.h"
-#include "tst_rtnetlink.h"
+#include "tst_netlink.h"
 #include "tst_netdevice.h"
 
 ...
diff --git a/include/tst_crypto.h b/include/tst_crypto.h
index ae406bd04..421e6b947 100644
--- a/include/tst_crypto.h
+++ b/include/tst_crypto.h
@@ -13,67 +13,12 @@
 #define TST_CRYPTO_H
 
 #include "lapi/cryptouser.h"
-
-/**
- * A reference to a crypto session and associated state.
- *
- * Holds state relevant to a netlink crypto connection. The seq_num is used
- * to tag each message sent to the netlink layer and is automatically
- * incremented by the tst_crypto_ functions. When the netlink layer sends a
- * response (ack) it will use the sequences number from the request.
- *
- * Some functions, such as delete ALG, may return EBUSY in which case it is
- * safe to retry them. The retries field allows you to set the number of
- * times this should be done. If set to zero the operation will only be tried
- * once. For operations which do not return EBUSY, the field is ignored.
- *
- * Use TST_CRYPTO_SESSION_INIT to statically initialize this struct with sane
- * defaults.
- */
-struct tst_crypto_session {
-	/** File descriptor for the netlink socket */
-	int fd;
-	/** A sequence number used to identify responses from the kernel. */
-	uint32_t seq_num;
-	/** Number of times some operations will be retried. */
-	uint32_t retries;
-};
-
-/**
- * Default static definition of tst_crypto_session.
- *
- * @relates tst_crypto_session
- */
-#define TST_CRYPTO_SESSION_INIT {\
-	.fd = 0,                 \
-	.seq_num = 0,            \
-	.retries = 1000          \
-}
-
-/**
- * Creates a crypto session.
- *
- * @relates tst_crypto_session
- * @param ses Session structure to use, it can be uninitialized.
- *
- * If some necessary feature is missing then it will call tst_brk() with
- * TCONF, for any other error it will use TBROK.
- */
-void tst_crypto_open(struct tst_crypto_session *ses);
-
-/**
- * Close a crypto session.
- *
- * @relates tst_crypto_session
- * @param ses The session to close.
- */
-void tst_crypto_close(struct tst_crypto_session *ses);
+#include "tst_netlink.h"
 
 /**
  * Add a crypto algorithm to a session.
  *
- * @relates tst_crypto_session
- * @param ses An open session.
+ * @param ctx Initialized netlink context
  * @param alg The crypto algorithm or module to add.
  *
  * This requests a new crypto algorithm/engine/module to be initialized by the
@@ -84,15 +29,15 @@ void tst_crypto_close(struct tst_crypto_session *ses);
  * @return On success it will return 0 otherwise it will return an inverted
  *         error code from the crypto layer.
  */
-int tst_crypto_add_alg(struct tst_crypto_session *ses,
+int tst_crypto_add_alg(struct tst_netlink_context *ctx,
 		       const struct crypto_user_alg *alg);
 
 /**
  * Delete a crypto algorithm from a session.
  *
- * @relates tst_crypto_session
- * @param ses An open session.
+ * @param ctx Initialized netlink context
  * @param alg The crypto algorithm to delete.
+ * @param retries Number of retries before giving up. Recommended value: 1000
  *
  * Request that the kernel remove an existing crypto algorithm. This behaves
  * in a similar way to tst_crypto_add_alg() except that it is the inverse
@@ -106,7 +51,7 @@ int tst_crypto_add_alg(struct tst_crypto_session *ses,
  *         library, you don't need to log this error as it will already have
  *         been printed by tst_brk().
  */
-int tst_crypto_del_alg(struct tst_crypto_session *ses,
-		       const struct crypto_user_alg *alg);
+int tst_crypto_del_alg(struct tst_netlink_context *ctx,
+	const struct crypto_user_alg *alg, unsigned int retries);
 
 #endif	/* TST_CRYPTO_H */
diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index 5e62ba065..4239d0960 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -5,7 +5,7 @@
 #ifndef TST_NETDEVICE_H
 #define TST_NETDEVICE_H
 
-#include "tst_rtnetlink.h"
+#include "tst_netlink.h"
 
 /* Find device index for given network interface name. */
 int tst_netdev_index_by_name(const char *file, const int lineno,
diff --git a/include/tst_netlink.h b/include/tst_netlink.h
index 2030ac30b..f10f1cf5d 100644
--- a/include/tst_netlink.h
+++ b/include/tst_netlink.h
@@ -1,11 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later
- * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
- */
-
-/**
- * @file tst_netlink.h
- *
- * Library for communicating with the kernel over the netlink interface.
+ * Copyright (c) 2021 Linux Test Project
  */
 
 #ifndef TST_NETLINK_H
@@ -13,76 +7,105 @@
 
 #include <linux/netlink.h>
 
-#ifndef NETLINK_CRYPTO
-/**
- * The netlink-crypto socket protocol.
+struct tst_netlink_context;
+
+struct tst_rtnl_attr_list {
+	unsigned short type;
+	const void *data;
+	ssize_t len;
+	const struct tst_rtnl_attr_list *sublist;
+};
+
+struct tst_netlink_message {
+	struct nlmsghdr *header;
+	struct nlmsgerr *err;
+	void *payload;
+	size_t payload_size;
+};
+
+extern int tst_netlink_errno;
+
+/* Open a netlink socket */
+struct tst_netlink_context *tst_netlink_create_context(const char *file,
+	const int lineno, int protocol);
+#define NETLINK_CREATE_CONTEXT(protocol) \
+	tst_netlink_create_context(__FILE__, __LINE__, (protocol))
+
+/* Free a tst_netlink_message array returned by tst_netlink_recv() */
+void tst_netlink_free_message(struct tst_netlink_message *msg);
+#define NETLINK_FREE_MESSAGE tst_netlink_free_message
+
+/* Close netlink socket */
+void tst_netlink_destroy_context(const char *file, const int lineno,
+	struct tst_netlink_context *ctx);
+#define NETLINK_DESTROY_CONTEXT(ctx) \
+	tst_netlink_destroy_context(__FILE__, __LINE__, (ctx))
+
+/* Send all messages in given buffer */
+int tst_netlink_send(const char *file, const int lineno,
+	struct tst_netlink_context *ctx);
+#define NETLINK_SEND(ctx) tst_netlink_send(__FILE__, __LINE__, (ctx))
+
+/* Send all messages in given buffer and validate kernel response */
+int tst_netlink_send_validate(const char *file, const int lineno,
+	struct tst_netlink_context *ctx);
+#define NETLINK_SEND_VALIDATE(ctx) \
+	tst_netlink_send_validate(__FILE__, __LINE__, (ctx))
+
+/* Wait until data is available for reading from the netlink socket */
+int tst_netlink_wait(struct tst_netlink_context *ctx);
+#define NETLINK_WAIT tst_netlink_wait
+
+/*
+ * Read from netlink socket and return an array of partially parsed messages.
+ * header == NULL indicates end of array.
  */
-#define NETLINK_CRYPTO 21
-#endif
-
-/** @private */
-static inline ssize_t safe_netlink_send(const char *file, const int lineno,
-					int fd, const struct nlmsghdr *nh,
-					const void *payload)
-{
-	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
-	struct iovec iov[2] = {
-		{(struct nlmsghdr *)nh, sizeof(*nh)},
-		{(void *)payload, nh->nlmsg_len - sizeof(*nh)}
-	};
-	struct msghdr msg = {
-		.msg_name = &sa,
-		.msg_namelen = sizeof(sa),
-		.msg_iov = iov,
-		.msg_iovlen = 2
-	};
-
-	return safe_sendmsg(file, lineno, nh->nlmsg_len, fd, &msg, 0);
-}
-
-/**
- * Sends a netlink message using safe_sendmsg().
- *
- * @param fd netlink socket file descriptor.
- * @param nl_header netlink header structure describing the message.
- * @param payload an opaque object containing the message data.
- *
- * You should set the message length, type and flags to appropriate values
- * within the nl_header object. See lib/tst_crypto.c for an example.
- *
- * @return The number of bytes sent.
+struct tst_netlink_message *tst_netlink_recv(const char *file, const int lineno,
+	struct tst_netlink_context *ctx);
+#define NETLINK_RECV(ctx) tst_netlink_recv(__FILE__, __LINE__, (ctx))
+
+/* Add new message to buffer */
+int tst_netlink_add_message(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, const struct nlmsghdr *header,
+	const void *payload, size_t payload_size);
+#define NETLINK_ADD_MESSAGE(ctx, header, payload, psize) \
+	tst_netlink_add_message(__FILE__, __LINE__, (ctx), (header), \
+		(payload), (psize))
+
+/* Add arbitrary attribute to last message */
+int tst_rtnl_add_attr(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, unsigned short type, const void *data,
+	unsigned short len);
+#define RTNL_ADD_ATTR(ctx, type, data, len) \
+	tst_rtnl_add_attr(__FILE__, __LINE__, (ctx), (type), (data), (len))
+
+/* Add string attribute to last message */
+int tst_rtnl_add_attr_string(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, unsigned short type, const char *data);
+#define RTNL_ADD_ATTR_STRING(ctx, type, data) \
+	tst_rtnl_add_attr_string(__FILE__, __LINE__, (ctx), (type), (data))
+
+/*
+ * Add list of arbitrary attributes to last message. The list is terminated
+ * by attribute with negative length. Nested sublists are supported.
  */
-#define SAFE_NETLINK_SEND(fd, nl_header, payload)		\
-	safe_netlink_send(__FILE__, __LINE__, fd, nl_header, payload)
-
-/** @private */
-static inline ssize_t safe_netlink_recv(const char *file, const int lineno,
-					int fd, char *nl_headers_buf,
-					size_t buf_len)
-{
-	struct iovec iov = { nl_headers_buf, buf_len };
-	struct sockaddr_nl sa;
-	struct msghdr msg = {
-		.msg_name = &sa,
-		.msg_namelen = sizeof(sa),
-		.msg_iov = &iov,
-		.msg_iovlen = 1
-	};
-
-	return safe_recvmsg(file, lineno, 0, fd, &msg, 0);
-}
-
-/**
- * Receives a netlink message using safe_recvmsg().
- *
- * @param fd netlink socket file descriptor.
- * @param nl_header_buf buffer to contain the received netlink header structure.
- * @param buf_len The length of the header buffer. Must be greater than the page
- *                size.
+int tst_rtnl_add_attr_list(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, const struct tst_rtnl_attr_list *list);
+#define RTNL_ADD_ATTR_LIST(ctx, list) \
+	tst_rtnl_add_attr_list(__FILE__, __LINE__, (ctx), (list))
+
+/* Check that all sent messages with NLM_F_ACK flag have been acked without
+ * error. Usage:
  *
- * @return The number of bytes received.
+ * tst_netlink_send(ctx);
+ * tst_netlink_wait(ctx);
+ * response = tst_netlink_recv(ctx);
+ * if (!tst_netlink_check_acks(ctx, response)) { ... }
+ * tst_netlink_free_message(response);
  */
-#define SAFE_NETLINK_RECV(fd, nl_header_buf, buf_len)			\
-	safe_netlink_recv(__FILE__, __LINE__, fd, nl_header_buf, buf_len)
+int tst_netlink_check_acks(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, struct tst_netlink_message *response);
+#define NETLINK_CHECK_ACKS(ctx, response) \
+	tst_netlink_check_acks(__FILE__, __LINE__, (ctx), (response))
 
 #endif /* TST_NETLINK_H */
diff --git a/include/tst_rtnetlink.h b/include/tst_rtnetlink.h
deleted file mode 100644
index c5f295a38..000000000
--- a/include/tst_rtnetlink.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later
- * Copyright (c) 2021 Linux Test Project
- */
-
-#ifndef TST_RTNETLINK_H
-#define TST_RTNETLINK_H
-
-struct tst_netlink_context;
-
-struct tst_rtnl_attr_list {
-	unsigned short type;
-	const void *data;
-	ssize_t len;
-	const struct tst_rtnl_attr_list *sublist;
-};
-
-struct tst_netlink_message {
-	struct nlmsghdr *header;
-	struct nlmsgerr *err;
-	void *payload;
-	size_t payload_size;
-};
-
-extern int tst_netlink_errno;
-
-/* Open a netlink socket */
-struct tst_netlink_context *tst_netlink_create_context(const char *file,
-	const int lineno, int protocol);
-#define NETLINK_CREATE_CONTEXT(protocol) \
-	tst_netlink_create_context(__FILE__, __LINE__, (protocol))
-
-/* Free a tst_netlink_message array returned by tst_netlink_recv() */
-void tst_netlink_free_message(struct tst_netlink_message *msg);
-#define NETLINK_FREE_MESSAGE tst_netlink_free_message
-
-/* Close netlink socket */
-void tst_netlink_destroy_context(const char *file, const int lineno,
-	struct tst_netlink_context *ctx);
-#define NETLINK_DESTROY_CONTEXT(ctx) \
-	tst_netlink_destroy_context(__FILE__, __LINE__, (ctx))
-
-/* Send all messages in given buffer */
-int tst_netlink_send(const char *file, const int lineno,
-	struct tst_netlink_context *ctx);
-#define NETLINK_SEND(ctx) tst_netlink_send(__FILE__, __LINE__, (ctx))
-
-/* Send all messages in given buffer and validate kernel response */
-int tst_netlink_send_validate(const char *file, const int lineno,
-	struct tst_netlink_context *ctx);
-#define NETLINK_SEND_VALIDATE(ctx) \
-	tst_netlink_send_validate(__FILE__, __LINE__, (ctx))
-
-/* Wait until data is available for reading from the netlink socket */
-int tst_netlink_wait(struct tst_netlink_context *ctx);
-#define NETLINK_WAIT tst_netlink_wait
-
-/*
- * Read from netlink socket and return an array of partially parsed messages.
- * header == NULL indicates end of array.
- */
-struct tst_netlink_message *tst_netlink_recv(const char *file, const int lineno,
-	struct tst_netlink_context *ctx);
-#define NETLINK_RECV(ctx) tst_netlink_recv(__FILE__, __LINE__, (ctx))
-
-/* Add new message to buffer */
-int tst_netlink_add_message(const char *file, const int lineno,
-	struct tst_netlink_context *ctx, const struct nlmsghdr *header,
-	const void *payload, size_t payload_size);
-#define NETLINK_ADD_MESSAGE(ctx, header, payload, psize) \
-	tst_netlink_add_message(__FILE__, __LINE__, (ctx), (header), \
-		(payload), (psize))
-
-/* Add arbitrary attribute to last message */
-int tst_rtnl_add_attr(const char *file, const int lineno,
-	struct tst_netlink_context *ctx, unsigned short type, const void *data,
-	unsigned short len);
-#define RTNL_ADD_ATTR(ctx, type, data, len) \
-	tst_rtnl_add_attr(__FILE__, __LINE__, (ctx), (type), (data), (len))
-
-/* Add string attribute to last message */
-int tst_rtnl_add_attr_string(const char *file, const int lineno,
-	struct tst_netlink_context *ctx, unsigned short type, const char *data);
-#define RTNL_ADD_ATTR_STRING(ctx, type, data) \
-	tst_rtnl_add_attr_string(__FILE__, __LINE__, (ctx), (type), (data))
-
-/*
- * Add list of arbitrary attributes to last message. The list is terminated
- * by attribute with negative length. Nested sublists are supported.
- */
-int tst_rtnl_add_attr_list(const char *file, const int lineno,
-	struct tst_netlink_context *ctx, const struct tst_rtnl_attr_list *list);
-#define RTNL_ADD_ATTR_LIST(ctx, list) \
-	tst_rtnl_add_attr_list(__FILE__, __LINE__, (ctx), (list))
-
-/* Check that all sent messages with NLM_F_ACK flag have been acked without
- * error. Usage:
- *
- * tst_netlink_send(ctx);
- * tst_netlink_wait(ctx);
- * response = tst_netlink_recv(ctx);
- * if (!tst_netlink_check_acks(ctx, response)) { ... }
- * tst_netlink_free_message(response);
- */
-int tst_netlink_check_acks(const char *file, const int lineno,
-	struct tst_netlink_context *ctx, struct tst_netlink_message *response);
-#define NETLINK_CHECK_ACKS(ctx, response) \
-	tst_netlink_check_acks(__FILE__, __LINE__, (ctx), (response))
-
-#endif /* TST_RTNETLINK_H */
diff --git a/lib/tst_crypto.c b/lib/tst_crypto.c
index c01632c2a..4495d0baa 100644
--- a/lib/tst_crypto.c
+++ b/lib/tst_crypto.c
@@ -10,102 +10,42 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_crypto.h"
-#include "tst_netlink.h"
 
-void tst_crypto_open(struct tst_crypto_session *ses)
-{
-	const long ret = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO);
-
-	if (ret < 0 && errno == EPROTONOSUPPORT)
-		tst_brk(TCONF | TERRNO, "NETLINK_CRYPTO is probably disabled");
-
-	if (ret < 0) {
-		tst_brk(TBROK | TERRNO,
-			"socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO)");
-	}
-
-	ses->fd = ret;
-	ses->seq_num = 0;
-}
-
-void tst_crypto_close(struct tst_crypto_session *ses)
-{
-	SAFE_CLOSE(ses->fd);
-}
-
-static int tst_crypto_recv_ack(struct tst_crypto_session *ses)
-{
-	uint32_t len;
-	char buf[BUFSIZ];
-	struct nlmsghdr *nh;
-
-	len = SAFE_NETLINK_RECV(ses->fd, buf, sizeof(buf));
-
-	for (nh = (struct nlmsghdr *) buf;
-	     NLMSG_OK(nh, len);
-	     nh = NLMSG_NEXT(nh, len)) {
-		if (nh->nlmsg_seq != ses->seq_num) {
-			tst_brk(TBROK,
-				"Message out of sequence; type=0%hx, seq_num=%u (not %u)",
-				nh->nlmsg_type, nh->nlmsg_seq, ses->seq_num);
-		}
-
-		/* Acks use the error message type with error number set to
-		 * zero. Ofcourse we could also receive an actual error.
-		 */
-		if (nh->nlmsg_type == NLMSG_ERROR)
-			return ((struct nlmsgerr *)NLMSG_DATA(nh))->error;
-
-		tst_brk(TBROK, "Unexpected message type; type=0x%hx, seq_num=%u",
-			nh->nlmsg_type, nh->nlmsg_seq);
-	}
-
-	tst_brk(TBROK, "Empty message from netlink socket?");
-
-	return ENODATA;
-}
-
-int tst_crypto_add_alg(struct tst_crypto_session *ses,
+int tst_crypto_add_alg(struct tst_netlink_context *ctx,
 		       const struct crypto_user_alg *alg)
 {
 	struct nlmsghdr nh = {
-		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*alg),
 		.nlmsg_type = CRYPTO_MSG_NEWALG,
 		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
-		.nlmsg_seq = ++(ses->seq_num),
-		.nlmsg_pid = 0,
 	};
 
-	SAFE_NETLINK_SEND(ses->fd, &nh, alg);
-
-	return tst_crypto_recv_ack(ses);
+	NETLINK_ADD_MESSAGE(ctx, &nh, alg, sizeof(struct crypto_user_alg));
+	return NETLINK_SEND_VALIDATE(ctx) ? 0 : -tst_netlink_errno;
 }
 
-int tst_crypto_del_alg(struct tst_crypto_session *ses,
-		       const struct crypto_user_alg *alg)
+int tst_crypto_del_alg(struct tst_netlink_context *ctx,
+	const struct crypto_user_alg *alg, unsigned int retries)
 {
-	long ret;
+	int ret;
 	unsigned int i = 0;
 	struct nlmsghdr nh = {
-		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*alg),
 		.nlmsg_type = CRYPTO_MSG_DELALG,
 		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
-		.nlmsg_pid = 0,
 	};
 
-	while (1) {
-		nh.nlmsg_seq = ++(ses->seq_num),
+	for (i = 0; i < retries; i++) {
+		NETLINK_ADD_MESSAGE(ctx, &nh, alg,
+			sizeof(struct crypto_user_alg));
 
-		SAFE_NETLINK_SEND(ses->fd, &nh, alg);
+		if (NETLINK_SEND_VALIDATE(ctx))
+			return 0;
 
-		ret = tst_crypto_recv_ack(ses);
-		if (ret != -EBUSY || i >= ses->retries)
-			break;
+		ret = -tst_netlink_errno;
 
-		if (usleep(1) && errno != EINTR)
-			tst_brk(TBROK | TERRNO, "usleep(1)");
+		if (ret != -EBUSY)
+			break;
 
-		++i;
+		usleep(1);
 	}
 
 	return ret;
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index 5873b3d58..6f86b8089 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -12,7 +12,7 @@
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
-#include "tst_rtnetlink.h"
+#include "tst_netlink.h"
 #include "tst_netdevice.h"
 
 static struct tst_netlink_context *create_request(const char *file,
diff --git a/lib/tst_rtnetlink.c b/lib/tst_netlink.c
similarity index 99%
rename from lib/tst_rtnetlink.c
rename to lib/tst_netlink.c
index bf782ffb5..bd05df81a 100644
--- a/lib/tst_rtnetlink.c
+++ b/lib/tst_netlink.c
@@ -13,7 +13,7 @@
 #include <sys/poll.h>
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
-#include "tst_rtnetlink.h"
+#include "tst_netlink.h"
 
 struct tst_netlink_context {
 	int socket;
diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 0fd254a92..d441a2449 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -24,7 +24,7 @@
 #include <linux/pkt_sched.h>
 #include <linux/pkt_cls.h>
 #include "tst_test.h"
-#include "tst_rtnetlink.h"
+#include "tst_netlink.h"
 #include "tst_netdevice.h"
 #include "lapi/sched.h"
 #include "lapi/if_ether.h"
diff --git a/testcases/kernel/crypto/crypto_user01.c b/testcases/kernel/crypto/crypto_user01.c
index 47bf9f0d2..6f6036aed 100644
--- a/testcases/kernel/crypto/crypto_user01.c
+++ b/testcases/kernel/crypto/crypto_user01.c
@@ -17,7 +17,6 @@
 
 #include "tst_test.h"
 #include "tst_crypto.h"
-#include "tst_netlink.h"
 
 /*
  * include after <sys/socket.h> (via tst_test.h), to work around dependency bug
@@ -25,11 +24,11 @@
  */
 #include <linux/rtnetlink.h>
 
-static struct tst_crypto_session ses = TST_CRYPTO_SESSION_INIT;
+static struct tst_netlink_context *ctx;
 
 static void setup(void)
 {
-	tst_crypto_open(&ses);
+	ctx = NETLINK_CREATE_CONTEXT(NETLINK_CRYPTO);
 }
 
 static void do_check_for_leaks(const char *name, const char *value, size_t vlen)
@@ -131,25 +130,20 @@ static void validate_one_alg(const struct nlmsghdr *nh)
 	}
 }
 
-static void validate_alg_list(const void *buf, size_t remaining)
+static void validate_alg_list(const struct tst_netlink_message *msg)
 {
-	const struct nlmsghdr *nh;
-
-	for (nh = buf; NLMSG_OK(nh, remaining);
-	     nh = NLMSG_NEXT(nh, remaining)) {
-		if (nh->nlmsg_seq != ses.seq_num) {
-			tst_brk(TBROK,
-				"Message out of sequence; type=0%hx, seq_num=%u (not %u)",
-				nh->nlmsg_type, nh->nlmsg_seq, ses.seq_num);
-		}
-		if (nh->nlmsg_type == NLMSG_DONE)
+	for (; msg->header; msg++) {
+		if (msg->header->nlmsg_type == NLMSG_DONE)
 			return;
-		if (nh->nlmsg_type != CRYPTO_MSG_GETALG) {
+
+		if (msg->header->nlmsg_type != CRYPTO_MSG_GETALG) {
 			tst_brk(TBROK,
 				"Unexpected message type; type=0x%hx, seq_num=%u",
-				nh->nlmsg_type, nh->nlmsg_seq);
+				msg->header->nlmsg_type,
+				msg->header->nlmsg_seq);
 		}
-		validate_one_alg(nh);
+
+		validate_one_alg(msg->header);
 	}
 }
 
@@ -157,35 +151,23 @@ static void run(void)
 {
 	struct crypto_user_alg payload = { 0 };
 	struct nlmsghdr nh = {
-		.nlmsg_len = sizeof(payload),
 		.nlmsg_type = CRYPTO_MSG_GETALG,
 		.nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP,
-		.nlmsg_seq = ++(ses.seq_num),
-		.nlmsg_pid = 0,
 	};
-	/*
-	 * Due to an apparent kernel bug, this API cannot be used incrementally,
-	 * so we just use a large recvmsg() buffer.  This is good enough since
-	 * we don't necessarily have to check every algorithm for this test to
-	 * be effective...
-	 */
-	const size_t bufsize = 1048576;
-	void *buf = SAFE_MALLOC(bufsize);
-	size_t res;
-
-	SAFE_NETLINK_SEND(ses.fd, &nh, &payload);
-
-	res = SAFE_NETLINK_RECV(ses.fd, buf, bufsize);
-
-	validate_alg_list(buf, res);
-
-	free(buf);
+	struct tst_netlink_message *msg;
+
+	NETLINK_ADD_MESSAGE(ctx, &nh, &payload, sizeof(payload));
+	NETLINK_SEND(ctx);
+	NETLINK_WAIT(ctx);
+	msg = NETLINK_RECV(ctx);
+	validate_alg_list(msg);
+	NETLINK_FREE_MESSAGE(msg);
 	tst_res(TPASS, "No information leaks found");
 }
 
 static void cleanup(void)
 {
-	tst_crypto_close(&ses);
+	NETLINK_DESTROY_CONTEXT(ctx);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/crypto/crypto_user02.c b/testcases/kernel/crypto/crypto_user02.c
index afaff5d18..89cbb9bc5 100644
--- a/testcases/kernel/crypto/crypto_user02.c
+++ b/testcases/kernel/crypto/crypto_user02.c
@@ -52,7 +52,7 @@ static const char * const ALGORITHM_CANDIDATES[] = {
 };
 
 static const char* algorithm = NULL;
-static struct tst_crypto_session ses = TST_CRYPTO_SESSION_INIT;
+static struct tst_netlink_context *ctx;
 
 
 static void setup(void)
@@ -60,7 +60,8 @@ static void setup(void)
 	int rc;
 	unsigned i;
 	struct crypto_user_alg alg;
-	tst_crypto_open(&ses);
+
+	ctx = NETLINK_CREATE_CONTEXT(NETLINK_CRYPTO);
 
 	/* find an algorithm, that is not in use */
 	for (i = 0; i < ARRAY_SIZE(ALGORITHM_CANDIDATES); ++i) {
@@ -68,12 +69,12 @@ static void setup(void)
 		strcpy(alg.cru_driver_name, ALGORITHM_CANDIDATES[i]);
 
 		/* try to add it, to see if it is valid */
-		rc = tst_crypto_add_alg(&ses, &alg);
+		rc = tst_crypto_add_alg(ctx, &alg);
 		if (rc != 0)
 			continue;
 
 		/* it also has to be deletable */
-		rc = tst_crypto_del_alg(&ses, &alg);
+		rc = tst_crypto_del_alg(ctx, &alg, 1000);
 		if (rc == 0) {
 			algorithm = ALGORITHM_CANDIDATES[i];
 			break;
@@ -103,9 +104,9 @@ static void run(void)
 
 		if (pid == 0) {
 			/* Child process: execute CRYPTO_MSG_NEWALG. */
-			tst_crypto_open(&ses);
+			ctx = NETLINK_CREATE_CONTEXT(NETLINK_CRYPTO);
 			for (;;) {
-				TEST(tst_crypto_add_alg(&ses, &alg));
+				TEST(tst_crypto_add_alg(ctx, &alg));
 				if (TST_RET && TST_RET != -EEXIST)
 					tst_brk(TBROK | TRERRNO,
 						"unexpected error from tst_crypto_add_alg()");
@@ -123,7 +124,7 @@ static void run(void)
 		SAFE_WAIT(&status);
 		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
 			tst_brk(TBROK, "child %s", tst_strstatus(status));
-		TEST(tst_crypto_del_alg(&ses, &alg));
+		TEST(tst_crypto_del_alg(ctx, &alg, 1000));
 		if (TST_RET && TST_RET != -ENOENT)
 			tst_brk(TBROK | TRERRNO,
 				"unexpected error from tst_crypto_del_alg()");
@@ -134,7 +135,7 @@ static void run(void)
 
 static void cleanup(void)
 {
-	tst_crypto_close(&ses);
+	NETLINK_DESTROY_CONTEXT(ctx);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/crypto/pcrypt_aead01.c b/testcases/kernel/crypto/pcrypt_aead01.c
index 3b4f5d8d1..3979f317a 100644
--- a/testcases/kernel/crypto/pcrypt_aead01.c
+++ b/testcases/kernel/crypto/pcrypt_aead01.c
@@ -26,11 +26,11 @@
 
 #define ATTEMPTS 10000
 
-static struct tst_crypto_session ses = TST_CRYPTO_SESSION_INIT;
+static struct tst_netlink_context *ctx;
 
 void setup(void)
 {
-	tst_crypto_open(&ses);
+	ctx = NETLINK_CREATE_CONTEXT(NETLINK_CRYPTO);
 }
 
 void run(void)
@@ -43,7 +43,7 @@ void run(void)
 	};
 
 	for (i = 0; i < ATTEMPTS; ++i) {
-		TEST(tst_crypto_add_alg(&ses, &a));
+		TEST(tst_crypto_add_alg(ctx, &a));
 		if (TST_RET && TST_RET == -ENOENT) {
 			tst_brk(TCONF | TRERRNO,
 				"pcrypt, hmac, sha256, cbc or aes not supported");
@@ -51,7 +51,7 @@ void run(void)
 		if (TST_RET && TST_RET != -EEXIST)
 			tst_brk(TBROK | TRERRNO, "add_alg");
 
-		TEST(tst_crypto_del_alg(&ses, &a));
+		TEST(tst_crypto_del_alg(ctx, &a, 1000));
 		if (TST_RET)
 			tst_brk(TBROK | TRERRNO, "del_alg");
 
@@ -67,7 +67,7 @@ void run(void)
 
 void cleanup(void)
 {
-	tst_crypto_close(&ses);
+	NETLINK_DESTROY_CONTEXT(ctx);
 }
 
 static struct tst_test test = {
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
