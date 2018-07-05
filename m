From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  5 Jul 2018 16:56:33 +0200
Subject: [LTP] [PATCH v3 1/3] lib: Add tst_crypto and tst_netlink libs
Message-ID: <20180705145635.27244-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a helper library for dealing with the crypto subsystem.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

Changes from V2 (which was a long time ago, sorry):
* Merged netlink lib into the header files.
* Move linux/cryptouser.h definitions to lapi/cryptouser.h and use the system
  definitions where possible.
* Move the retries parameter into the session struct and give it a default value
  so that most users can ignore it.
* Use usleep instead of nanosleep for simplicity.
* Use unsigned int for netlink data length.
* Convert the documentation comments into Doxygen format because it looks like
  the preferred format.

I have also included a Doxygen config file which may be ignored as it should
probably be handled in a seperate patch series. However it can be used to
check that the comments produce working documentation.

Discussion about documentation format is here:
https://github.com/linux-test-project/ltp/issues/262

 configure.ac              |   1 +
 include/lapi/cryptouser.h | 121 ++++++++++++++++++++++++++++++++++++++++++++
 include/tst_crypto.h      | 124 ++++++++++++++++++++++++++++++++++++++++++++++
 include/tst_netlink.h     |  99 ++++++++++++++++++++++++++++++++++++
 lib/tst_crypto.c          | 121 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 466 insertions(+)
 create mode 100644 include/lapi/cryptouser.h
 create mode 100644 include/tst_crypto.h
 create mode 100644 include/tst_netlink.h
 create mode 100644 lib/tst_crypto.c

diff --git a/configure.ac b/configure.ac
index 9208f1c6c..844d454dd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,6 +37,7 @@ AC_CHECK_HEADERS([ \
     keyutils.h \
     linux/can.h \
     linux/dccp.h \
+    linux/cryptouser.h \
     linux/genetlink.h \
     linux/keyctl.h \
     linux/if_packet.h \
diff --git a/include/lapi/cryptouser.h b/include/lapi/cryptouser.h
new file mode 100644
index 000000000..61ff21ad3
--- /dev/null
+++ b/include/lapi/cryptouser.h
@@ -0,0 +1,121 @@
+/*
+ * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef CRYPTOUSER_H__
+#define CRYPTOUSER_H__
+
+#ifdef HAVE_LINUX_CRYPTOUSER_H
+#  include <linux/cryptouser.h>
+#else
+#  include <stdint.h>
+#  define CRYPTO_MAX_NAME 64
+
+enum {
+	CRYPTO_MSG_BASE = 0x10,
+	CRYPTO_MSG_NEWALG = 0x10,
+	CRYPTO_MSG_DELALG,
+	CRYPTO_MSG_UPDATEALG,
+	CRYPTO_MSG_GETALG,
+	CRYPTO_MSG_DELRNG,
+	__CRYPTO_MSG_MAX
+};
+
+struct crypto_user_alg {
+	char cru_name[CRYPTO_MAX_NAME];
+	char cru_driver_name[CRYPTO_MAX_NAME];
+	char cru_module_name[CRYPTO_MAX_NAME];
+	uint32_t cru_type;
+	uint32_t cru_mask;
+	uint32_t cru_refcnt;
+	uint32_t cru_flags;
+};
+
+#endif	/* HAVE_LINUX_CRYPTOUSER_H */
+
+/* These are taken from include/crypto.h in the kernel tree. They are not
+ * currently included in the user API.
+ */
+#ifndef CRYPTO_MAX_ALG_NAME
+#  define CRYPTO_MAX_ALG_NAME		128
+#endif
+
+#ifndef CRYPTO_ALG_TYPE_MASK
+#  define CRYPTO_ALG_TYPE_MASK		0x0000000f
+#endif
+#ifndef CRYPTO_ALG_TYPE_CIPHER
+#  define CRYPTO_ALG_TYPE_CIPHER	0x00000001
+#endif
+#ifndef CRYPTO_ALG_TYPE_COMPRESS
+#  define CRYPTO_ALG_TYPE_COMPRESS	0x00000002
+#endif
+#ifndef CRYPTO_ALG_TYPE_AEAD
+#  define CRYPTO_ALG_TYPE_AEAD		0x00000003
+#endif
+#ifndef CRYPTO_ALG_TYPE_BLKCIPHER
+#  define CRYPTO_ALG_TYPE_BLKCIPHER	0x00000004
+#endif
+#ifndef CRYPTO_ALG_TYPE_ABLKCIPHER
+#  define CRYPTO_ALG_TYPE_ABLKCIPHER	0x00000005
+#endif
+#ifndef CRYPTO_ALG_TYPE_SKCIPHER
+#  define CRYPTO_ALG_TYPE_SKCIPHER	0x00000005
+#endif
+#ifndef CRYPTO_ALG_TYPE_GIVCIPHER
+#  define CRYPTO_ALG_TYPE_GIVCIPHER	0x00000006
+#endif
+#ifndef CRYPTO_ALG_TYPE_KPP
+#  define CRYPTO_ALG_TYPE_KPP		0x00000008
+#endif
+#ifndef CRYPTO_ALG_TYPE_ACOMPRESS
+#  define CRYPTO_ALG_TYPE_ACOMPRESS	0x0000000a
+#endif
+#ifndef CRYPTO_ALG_TYPE_SCOMPRESS
+#  define CRYPTO_ALG_TYPE_SCOMPRESS	0x0000000b
+#endif
+#ifndef CRYPTO_ALG_TYPE_RNG
+#  define CRYPTO_ALG_TYPE_RNG		0x0000000c
+#endif
+#ifndef CRYPTO_ALG_TYPE_AKCIPHER
+#  define CRYPTO_ALG_TYPE_AKCIPHER	0x0000000d
+#endif
+#ifndef CRYPTO_ALG_TYPE_DIGEST
+#  define CRYPTO_ALG_TYPE_DIGEST	0x0000000e
+#endif
+#ifndef CRYPTO_ALG_TYPE_HASH
+#  define CRYPTO_ALG_TYPE_HASH		0x0000000e
+#endif
+#ifndef CRYPTO_ALG_TYPE_SHASH
+#  define CRYPTO_ALG_TYPE_SHASH		0x0000000e
+#endif
+#ifndef CRYPTO_ALG_TYPE_AHASH
+#  define CRYPTO_ALG_TYPE_AHASH		0x0000000f
+#endif
+
+#ifndef CRYPTO_ALG_TYPE_HASH_MASK
+#  define CRYPTO_ALG_TYPE_HASH_MASK	0x0000000e
+#endif
+#ifndef CRYPTO_ALG_TYPE_AHASH_MASK
+#  define CRYPTO_ALG_TYPE_AHASH_MASK	0x0000000e
+#endif
+#ifndef CRYPTO_ALG_TYPE_BLKCIPHER_MASK
+#  define CRYPTO_ALG_TYPE_BLKCIPHER_MASK	0x0000000c
+#endif
+#ifndef CRYPTO_ALG_TYPE_ACOMPRESS_MASK
+#  define CRYPTO_ALG_TYPE_ACOMPRESS_MASK	0x0000000e
+#endif
+
+#endif	/* CRYPTOUSER_H__ */
diff --git a/include/tst_crypto.h b/include/tst_crypto.h
new file mode 100644
index 000000000..d5871ab79
--- /dev/null
+++ b/include/tst_crypto.h
@@ -0,0 +1,124 @@
+/*
+ * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/**
+ * @file tst_crypto.h
+ *
+ * Library for interacting with kernel's crypto layer using the netlink
+ * interface.
+ */
+
+#ifndef TST_CRYPTO_H
+#define TST_CRYPTO_H
+
+#include "lapi/cryptouser.h"
+
+/**
+ * A reference to a crypto session and associated state.
+ *
+ * Holds state relevant to a netlink crypto connection. The seq_num is used
+ * to tag each message sent to the netlink layer and is automatically
+ * incremented by the tst_crypto_ functions. When the netlink layer sends a
+ * response (ack) it will use the sequences number from the request.
+ *
+ * Some functions, such as delete ALG, may return EBUSY in which case it is
+ * safe to retry them. The retries field allows you to set the number of
+ * times this should be done. If set to zero the operation will only be tried
+ * once. For operations which do not return EBUSY, the field is ignored.
+ *
+ * Use TST_CRYPTO_SESSION_INIT to statically initialize this struct with sane
+ * defaults.
+ */
+struct tst_crypto_session {
+	/** File descriptor for the netlink socket */
+	int fd;
+	/** A sequence number used to identify responses from the kernel. */
+	uint32_t seq_num;
+	/** Number of times some operations will be retried. */
+	uint32_t retries;
+};
+
+/**
+ * Default static definition of tst_crypto_session.
+ *
+ * @relates tst_crypto_session
+ */
+#define TST_CRYPTO_SESSION_INIT {\
+	.fd = 0,                 \
+	.seq_num = 0,            \
+	.retries = 1000          \
+}
+
+/**
+ * Creates a crypto session.
+ *
+ * @relates tst_crypto_session
+ * @param ses Session structure to use, it can be uninitialized.
+ *
+ * If some necessary feature is missing then it will call tst_brk() with
+ * TCONF, for any other error it will use TBROK.
+ */
+void tst_crypto_open(struct tst_crypto_session *ses);
+
+/**
+ * Close a crypto session.
+ *
+ * @relates tst_crypto_session
+ * @param ses The session to close.
+ */
+void tst_crypto_close(struct tst_crypto_session *ses);
+
+/**
+ * Add a crypto algorithm to a session.
+ *
+ * @relates tst_crypto_session
+ * @param ses An open session.
+ * @param alg The crypto algorithm or module to add.
+ *
+ * This requests a new crypto algorithm/engine/module to be initialized by the
+ * kernel. It sends the request contained in alg and then waits for a
+ * response. If sending the message or receiving the ack fails at the netlink
+ * level then tst_brk() with TBROK will be called.
+ *
+ * @return On success it will return 0 otherwise it will return an inverted
+ *         error code from the crypto layer.
+ */
+int tst_crypto_add_alg(struct tst_crypto_session *ses,
+		       const struct crypto_user_alg *alg);
+
+/**
+ * Delete a crypto algorithm from a session.
+ *
+ * @relates tst_crypto_session
+ * @param ses An open session.
+ * @param alg The crypto algorithm to delete.
+ *
+ * Request that the kernel remove an existing crypto algorithm. This behaves
+ * in a similar way to tst_crypto_add_alg() except that it is the inverse
+ * operation and that it is not unusual for the crypto layer to return
+ * EBUSY. If EBUSY is returned then the function will internally retry the
+ * operation tst_crypto_session::retries times before giving up and returning
+ * EBUSY.
+ *
+ * Return: Either 0 or an inverted error code from the crypto layer. If called
+ *         during cleanup it may return a positive ENODATA value from the LTP
+ *         library, you don't need to log this error as it will already have
+ *         been printed by tst_brk().
+ */
+int tst_crypto_del_alg(struct tst_crypto_session *ses,
+		       const struct crypto_user_alg *alg);
+
+#endif	/* TST_CRYPTO_H */
diff --git a/include/tst_netlink.h b/include/tst_netlink.h
new file mode 100644
index 000000000..42232a169
--- /dev/null
+++ b/include/tst_netlink.h
@@ -0,0 +1,99 @@
+/*
+ * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/**
+ * @file tst_netlink.h
+ *
+ * Library for communicating with the kernel over the netlink interface.
+ */
+
+#ifndef TST_NETLINK_H
+#define TST_NETLINK_H
+
+#include <linux/netlink.h>
+
+#ifndef NETLINK_CRYPTO
+/**
+ * The netlink-crypto socket protocol.
+ */
+#define NETLINK_CRYPTO 21
+#endif
+
+/** @private */
+ssize_t safe_netlink_send(const char *file, const int lineno,
+			  int fd, const struct nlmsghdr *nh,
+			  const void *payload)
+{
+	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
+	struct iovec iov[2] = {
+		{(struct nlmsghdr *)nh, sizeof(*nh)},
+		{(void *)payload, nh->nlmsg_len - sizeof(*nh)}
+	};
+	struct msghdr msg = {
+		.msg_name = &sa,
+		.msg_namelen = sizeof(sa),
+		.msg_iov = iov,
+		.msg_iovlen = 2
+	};
+
+	return safe_sendmsg(file, lineno, nh->nlmsg_len, fd, &msg, 0);
+}
+
+/**
+ * Sends a netlink message using safe_sendmsg().
+ *
+ * @param fd netlink socket file descriptor.
+ * @param nl_header netlink header structure describing the message.
+ * @param payload an opaque object containing the message data.
+ *
+ * You should set the message length, type and flags to appropriate values
+ * within the nl_header object. See lib/tst_crypto.c for an example.
+ *
+ * @return The number of bytes sent.
+ */
+#define SAFE_NETLINK_SEND(fd, nl_header, payload)		\
+	safe_netlink_send(__FILE__, __LINE__, fd, nl_header, payload)
+
+/** @private */
+ssize_t safe_netlink_recv(const char *file, const int lineno,
+			  int fd, char *nl_headers_buf, size_t buf_len)
+{
+	struct iovec iov = { nl_headers_buf, buf_len };
+	struct sockaddr_nl sa;
+	struct msghdr msg = {
+		.msg_name = &sa,
+		.msg_namelen = sizeof(sa),
+		.msg_iov = &iov,
+		.msg_iovlen = 1
+	};
+
+	return safe_recvmsg(file, lineno, 0, fd, &msg, 0);
+}
+
+/**
+ * Receives a netlink message using safe_recvmsg().
+ *
+ * @param fd netlink socket file descriptor.
+ * @param nl_header_buf buffer to contain the received netlink header structure.
+ * @param buf_len The length of the header buffer. Must be greater than the page
+ *                size.
+ *
+ * @return The number of bytes received.
+ */
+#define SAFE_NETLINK_RECV(fd, nl_header_buf, buf_len)			\
+	safe_netlink_recv(__FILE__, __LINE__, fd, nl_header_buf, buf_len)
+
+#endif /* TST_NETLINK_H */
diff --git a/lib/tst_crypto.c b/lib/tst_crypto.c
new file mode 100644
index 000000000..55219dab4
--- /dev/null
+++ b/lib/tst_crypto.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (c) 2018 Richard Palethorpe <rpalethorpe@suse.com>
+ *                    Nicolai Stange <nstange@suse.de>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_crypto.h"
+#include "tst_netlink.h"
+
+void tst_crypto_open(struct tst_crypto_session *ses)
+{
+	TEST(socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO));
+	if (TEST_RETURN < 0 && TEST_ERRNO == EPROTONOSUPPORT) {
+		tst_brk(TCONF | TTERRNO, "NETLINK_CRYPTO is probably disabled");
+	} else if (TEST_RETURN < 0) {
+		tst_brk(TBROK | TTERRNO,
+			"socket(AF_NETLINK, SOCK_DGRAM, NETLINK_CRYPTO)");
+	}
+
+	ses->fd = TEST_RETURN;
+	ses->seq_num = 0;
+}
+
+void tst_crypto_close(struct tst_crypto_session *ses)
+{
+	SAFE_CLOSE(ses->fd);
+}
+
+static int tst_crypto_recv_ack(struct tst_crypto_session *ses)
+{
+	uint32_t len;
+	char buf[BUFSIZ];
+	struct nlmsghdr *nh;
+
+	len = SAFE_NETLINK_RECV(ses->fd, buf, sizeof(buf));
+
+	for (nh = (struct nlmsghdr *) buf;
+	     NLMSG_OK(nh, len);
+	     nh = NLMSG_NEXT(nh, len)) {
+		if (nh->nlmsg_seq != ses->seq_num) {
+			tst_brk(TBROK,
+				"Message out of sequence; type=0%hx, seq_num=%u (not %u)",
+				nh->nlmsg_type, nh->nlmsg_seq, ses->seq_num);
+		}
+
+		/* Acks use the error message type with error number set to
+		 * zero. Ofcourse we could also receive an actual error.
+		 */
+		if (nh->nlmsg_type == NLMSG_ERROR)
+			return ((struct nlmsgerr *)NLMSG_DATA(nh))->error;
+
+		tst_brk(TBROK, "Unexpected message type; type=0x%hx, seq_num=%u",
+			nh->nlmsg_type, nh->nlmsg_seq);
+	}
+
+	tst_brk(TBROK, "Empty message from netlink socket?");
+
+	return ENODATA;
+}
+
+int tst_crypto_add_alg(struct tst_crypto_session *ses,
+		       const struct crypto_user_alg *alg)
+{
+	struct nlmsghdr nh = {
+		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*alg),
+		.nlmsg_type = CRYPTO_MSG_NEWALG,
+		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		.nlmsg_seq = ++(ses->seq_num),
+		.nlmsg_pid = 0,
+	};
+
+	SAFE_NETLINK_SEND(ses->fd, &nh, alg);
+
+	return tst_crypto_recv_ack(ses);
+}
+
+int tst_crypto_del_alg(struct tst_crypto_session *ses,
+		       const struct crypto_user_alg *alg)
+{
+	unsigned int i = 0;
+	struct nlmsghdr nh = {
+		.nlmsg_len = sizeof(struct nlmsghdr) + sizeof(*alg),
+		.nlmsg_type = CRYPTO_MSG_DELALG,
+		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK,
+		.nlmsg_pid = 0,
+	};
+
+	while (1) {
+		nh.nlmsg_seq = ++(ses->seq_num),
+
+		SAFE_NETLINK_SEND(ses->fd, &nh, alg);
+
+		TEST(tst_crypto_recv_ack(ses));
+		if (TEST_RETURN != -EBUSY || i >= ses->retries)
+			break;
+
+		if (usleep(1) && errno != EINTR)
+			tst_brk(TBROK | TERRNO, "usleep(1)");
+
+		++i;
+	}
+
+	return TEST_RETURN;
+}
-- 
2.16.3

