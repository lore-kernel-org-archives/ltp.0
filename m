Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7D606A339
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EyU/tG3S;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=R9LofqZ+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sLShUisv;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=/CTIr+4l
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CF2D3EAF7D
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 18:22:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21F093EA62A
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:22:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F18EF6008C3
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 18:22:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18F9B21CF9;
 Tue, 20 Oct 2026 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792513328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4/uElPy1n+dvgdIVLPlihWgluTPH3+dPX9bmOfG9PnU=;
 b=EyU/tG3SGCeXsxvluUFtISA4WPYNgOESgJqLqB+m3y8szjpJg4Gy2tee3rPxNAPqsiisNA
 TTmWhdxe14I3lUAd222MzlxP0x/Svn+bMgafkm4sbwoH8cXBejbOT/3bBqQqfYn2FOapTr
 sevXOZ8SUHZ7LLY3vV9M4UxOMumqkdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792513328;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4/uElPy1n+dvgdIVLPlihWgluTPH3+dPX9bmOfG9PnU=;
 b=R9LofqZ+x3b/6yBHJALDGQ2Bv5rCwYeY7JNkrsBXNXkIkeshr9GxELutrPHlGFgA8mWVEs
 2FsshhRP5GFB3sBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sLShUisv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/CTIr+4l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792513327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4/uElPy1n+dvgdIVLPlihWgluTPH3+dPX9bmOfG9PnU=;
 b=sLShUisvanyFAonEtaomDFDkaQvoiMp5wF4kdUjLp+bAuen5D/+NDQZZqRAadc78juBaQa
 nCvQy7XW02fCUtmOkYHlorWhaK3zLRlos3ieJLpbSOPB2bqLS5FlPhsp3jBAIgwyqJGibZ
 lqzylRiCIrXKYCtdlEU40A30OXZGNrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792513327;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4/uElPy1n+dvgdIVLPlihWgluTPH3+dPX9bmOfG9PnU=;
 b=/CTIr+4l2Mda8quzEwYphyuNHT9FOYC8eI8uOLx+RQsAwku65uyq0C1SmP7ykr4SZGCC8p
 BIPJtyHUNcL9fGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3F73136CC;
 Tue, 20 Oct 2026 16:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QyfjKS6V12rqOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Oct 2026 16:22:06 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Oct 2026 18:22:06 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261020-pwnescape-v2-1-f0669e990410@suse.com>
X-B4-Tracking: v=1; b=H4sIAC2V12oC/22NQQ7CIBAAv9LsWQwLCVpP/sP0gLhYTGwbtkVNw
 9+FevU4yWRmBaYYiOHUrBApBQ7jUEDtGnC9He4kwq0wKKkMSiXF9BqInZ1IkLYHa1Aheg3FnyL
 58N5al+7HvFwf5OYaqEYfeB7jZ5slrN6/bkKBom3pqEhKb7U588K0d+MTupzzF6HWpWazAAAA
X-Change-ID: 20261020-pwnescape-e3a7a61211f3
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792513326; l=12582;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=125qjJ58G50DqJpJlrfekgSc8JlcsXEFGPOjKQIYEZ0=;
 b=TuqOieqhTssafaPOosQ1H/uzLBV0O6A9Hz/VnIM52vNNLc9slfkvugR9cVKMbfTFZuSl5Ms3W
 PLmQCsROYsgAeOh//8PFnnjQx6UIznNjbPln1x/54QIDq1+N1oMwFuR
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 18F9B21CF9
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:email, linux.it:email, suse.de:dkim,
 ip.id:url]
X-Spam-Score: -4.51
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cve: add pwnescape reproducer
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Verify that IPv4 fragmentation validates csum_start before completing
partial checksums so bogus virtio_net_hdr checksum offsets cannot
overwrite the IPv4 header.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Before 6785011f8b16

	tst_test.c:2061: TINFO: LTP version: 20260930-29-g34e338bbb
	tst_test.c:2064: TINFO: Tested kernel: 7.3.0-rc5-virtme #18 SMP PREEMPT_DYNAMIC Tue Oct 20 15:48:53 CEST 2026 x86_64
	tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.3.0-rc5-virtme/build/.config'
	tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.3.0-rc5-virtme/build/.config'
	tst_test.c:1895: TINFO: Overall timeout per run is 0h 00m 30s
	[    1.323287] tun: Universal TUN/TAP device driver, 1.6
	pwnescape.c:217: TFAIL: IPv4 header IHL corrupted by checksum completion (15)

	HINT: You _MAY_ be missing kernel fixes:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6785011f8b16

After 6785011f8b16

	tst_test.c:2061: TINFO: LTP version: 20260930-29-g34e338bbb
	tst_test.c:2064: TINFO: Tested kernel: 7.3.0-rc5-virtme #19 SMP PREEMPT_DYNAMIC Tue Oct 20 15:52:44 CEST 2026 x86_64
	tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.3.0-rc5-virtme/build/.config'
	tst_kconfig.c:90: TINFO: Parsing kernel config '/lib/modules/7.3.0-rc5-virtme/build/.config'
	tst_test.c:1895: TINFO: Overall timeout per run is 0h 00m 30s
	[    1.305821] tun: Universal TUN/TAP device driver, 1.6
	[    1.307941] modprobe (198) used greatest stack depth: 11968 bytes left
	pwnescape.c:223: TPASS: kernel dropped the datagram with checksum metadata inside the IPv4 header

This reproducer has been generated by DeepSeep v4 Pro and tuned up by
Gemini 4 Argon.
---
Changes in v2:
- add CONFIG_SYSCTL=y requirement
- import stddef.h for offset
- Link to v1: https://lore.kernel.org/20261020-pwnescape-v1-1-99e82e00fa36@suse.com

To: Linux Test Project <ltp@lists.linux.it>
---
 runtest/cve               |   1 +
 testcases/cve/.gitignore  |   1 +
 testcases/cve/pwnescape.c | 312 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)

diff --git a/runtest/cve b/runtest/cve
index 894863e33..0fe25cd83 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -91,6 +91,7 @@ cve-2023-52879 fanotify25
 cve-2026-43499 ghostlock
 cve-2026-53362 setsockopt11
 cve-2026-64600 refluxfs
+cve-2026-99999 pwnescape
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
 cve-2022-0185 fsconfig03
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 418d67566..58246fd2d 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -17,5 +17,6 @@ cve-2025-38236
 cve-2025-21756
 cve-2026-46331
 ghostlock
+pwnescape
 refluxfs
 sctphantom
diff --git a/testcases/cve/pwnescape.c b/testcases/cve/pwnescape.c
new file mode 100644
index 000000000..c829c2a75
--- /dev/null
+++ b/testcases/cve/pwnescape.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Linux Test Project
+ */
+
+/*\
+ * Regression test for commit 6785011f8b16 ("ipv4: validate
+ * checksum_start before completing checksum").
+ *
+ * A frame written to a TAP device can carry a virtio_net_hdr with
+ * VIRTIO_NET_HDR_F_NEEDS_CSUM, asking the stack to complete a partial
+ * checksum later. If csum_start points into the IPv4 header instead of
+ * at the transport header, skb_checksum_help() completes the checksum
+ * and stores the result at csum_start + csum_offset, overwriting the
+ * first two bytes of the IPv4 header that were already parsed. When
+ * such a packet needs to be fragmented, ip_do_fragment() then reads
+ * the corrupted version/IHL byte and copies an attacker-chosen number
+ * of "header" bytes, which can read past skb_headlen() and disclose
+ * adjacent kernel memory in the IPv4 options of the emitted fragments.
+ *
+ * The test loads the tun module when run as root and runs inside a
+ * private network namespace so that it needs no other privileges.
+ *
+ * [Algorithm]
+ *
+ * - create a TAP device with MAC 02:00:00:00:00:01, address
+ *   10.0.0.1/24 and MTU 200 inside a fresh network namespace
+ * - add a permanent neighbour entry for 10.0.0.3 on the TAP device
+ * - enable IPv4 forwarding in the network namespace
+ * - open an AF_PACKET (:manpage:`packet(7)`) socket bound to the TAP
+ *   device
+ * - send a 320 byte control IPv4 datagram behind two VID 0 VLAN tags
+ *   with checksum metadata at the transport header (frame offset 42)
+ *   and verify its fragments are forwarded with an intact header
+ * - send the test datagram with csum_start on the IPv4 header (frame
+ *   offset 22) and a payload word chosen so that completing the bogus
+ *   checksum writes 0x4f (version 4, IHL 15) at the start of the IPv4
+ *   header, then check whether the emitted fragments carry the
+ *   corrupted header
+ */
+
+#include <stddef.h>
+
+#include <net/if.h>
+#include <net/if_arp.h>
+#include <linux/if_tun.h>
+#include <linux/virtio_net.h>
+
+#include "tst_test.h"
+#include "tst_module.h"
+#include "tst_netdevice.h"
+#include "tst_timer.h"
+#include "lapi/if_ether.h"
+#include "lapi/if_packet.h"
+#include "lapi/ioctl.h"
+
+#define TAP_NAME	"pwnescape"
+#define TAP_MTU		200
+#define PAYLOAD_LEN	300
+
+#define IP_PROTO	253
+#define TTL		64
+
+#define CTRL_ID		0x2000
+#define TEST_ID		0x3000
+#define GOOD_IHL	5
+#define BAD_FIRST_BYTE	0x4f	/* IPv4, IHL 15 */
+
+struct vlan_tag {
+	uint16_t tci;
+	uint16_t proto;
+} __attribute__((packed));
+
+struct pkt_frame {
+	struct ethhdr eth;
+	struct vlan_tag vlan[2];
+	struct iphdr ip;
+	uint16_t csum_adj;
+	uint8_t payload[PAYLOAD_LEN - sizeof(uint16_t)];
+} __attribute__((packed));
+
+static int tap_fd = -1;
+static int cap_fd = -1;
+
+static struct pkt_frame ctrl_frame;
+static struct pkt_frame test_frame;
+
+static const uint8_t tap_mac[ETH_ALEN] = {0x02, 0x00, 0x00, 0x00, 0x00, 0x01};
+static const uint8_t src_mac[ETH_ALEN] = {0x02, 0x00, 0x00, 0x00, 0x00, 0x02};
+static const uint8_t nbr_mac[ETH_ALEN] = {0x02, 0x00, 0x00, 0x00, 0x00, 0x03};
+
+static uint16_t ip_checksum(const void *buf, size_t len)
+{
+	const uint16_t *w = buf;
+	uint32_t s = 0;
+
+	for (size_t i = 0; i < len / 2; i++)
+		s += w[i];
+
+	s = (s & 0xffff) + (s >> 16);
+	s = (s & 0xffff) + (s >> 16);
+
+	return (uint16_t)~s;
+}
+
+static void build_frame(struct pkt_frame *fr, uint16_t id, int corrupt_iph)
+{
+	memset(fr, 0, sizeof(*fr));
+
+	memcpy(fr->eth.h_dest, tap_mac, ETH_ALEN);
+	memcpy(fr->eth.h_source, src_mac, ETH_ALEN);
+	fr->eth.h_proto = htons(ETH_P_8021Q);
+	fr->vlan[0].proto = htons(ETH_P_8021Q);
+	fr->vlan[1].proto = htons(ETH_P_IP);
+
+	fr->ip.version = 4;
+	fr->ip.ihl = GOOD_IHL;
+	fr->ip.tot_len = htons(sizeof(fr->ip) + PAYLOAD_LEN);
+	fr->ip.id = htons(id);
+	fr->ip.ttl = TTL;
+	fr->ip.protocol = IP_PROTO;
+	fr->ip.saddr = inet_addr("10.0.0.2");
+	fr->ip.daddr = inet_addr("10.0.0.3");
+	fr->ip.check = ip_checksum(&fr->ip, sizeof(fr->ip));
+
+	/* a valid IPv4 header always sums to 0xffff (-0 in one's complement)
+	 * both before and after the forwarding TTL decrement, so with a zero
+	 * payload the folded checksum over the whole IPv4 packet is simply
+	 * ~csum_adj
+	 */
+	if (corrupt_iph)
+		fr->csum_adj = htons(~(uint16_t)(BAD_FIRST_BYTE << 8));
+}
+
+/* write a frame to the TAP device with a virtio_net_hdr that asks
+ * for checksum completion at the given frame-relative csum_start
+ */
+static void send_datagram(struct pkt_frame *fr, uint16_t csum_start)
+{
+	struct virtio_net_hdr vnet_hdr = {
+		.flags = VIRTIO_NET_HDR_F_NEEDS_CSUM,
+		.csum_start = csum_start,
+		.csum_offset = 0,
+	};
+	struct iovec iov[] = {
+		{.iov_base = &vnet_hdr, .iov_len = sizeof(vnet_hdr)},
+		{.iov_base = fr, .iov_len = sizeof(*fr)},
+	};
+
+	SAFE_WRITEV(SAFE_WRITE_ALL, tap_fd, iov, ARRAY_SIZE(iov));
+}
+
+static void drain_capture(void)
+{
+	uint8_t buf[256];
+	ssize_t n;
+
+	do {
+		n = recv(cap_fd, buf, sizeof(buf), MSG_DONTWAIT);
+	} while (n > 0);
+
+	if (n < 0 && errno != EAGAIN && errno != EWOULDBLOCK)
+		tst_brk(TBROK | TERRNO, "recv() failed");
+}
+
+/* wait up to two seconds for a fragmented packet with the given IP id;
+ * store its IPv4 IHL in *ihl and return 1
+ */
+static int capture_fragment(uint16_t id, unsigned int *ihl)
+{
+	struct pollfd pfd = {.fd = cap_fd, .events = POLLIN};
+
+	tst_timer_start(CLOCK_MONOTONIC);
+
+	while (!tst_timer_expired_ms(2000)) {
+		struct {
+			struct ethhdr eth;
+			struct iphdr ip;
+		} __attribute__((packed)) hdr;
+		ssize_t n;
+
+		if (SAFE_POLL(&pfd, 1, 100) <= 0)
+			continue;
+
+		n = SAFE_RECV(0, cap_fd, &hdr, sizeof(hdr), 0);
+		if (n < (ssize_t)sizeof(hdr))
+			continue;
+
+		/* a forwarded fragment has MF set or a non-zero fragment
+		 * offset; the injected frame itself never does, which
+		 * distinguishes the forwarded output from its receive-side
+		 * copy on the same device
+		 */
+		if (hdr.eth.h_proto == htons(ETH_P_IP) &&
+		    ntohs(hdr.ip.id) == id &&
+		    ntohs(hdr.ip.frag_off) & (IP_MF | IP_OFFMASK)) {
+			*ihl = hdr.ip.ihl;
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static void run(void)
+{
+	unsigned int ihl;
+
+	drain_capture();
+
+	send_datagram(&ctrl_frame, offsetof(struct pkt_frame, csum_adj));
+	if (!capture_fragment(CTRL_ID, &ihl))
+		tst_brk(TBROK, "control datagram was not forwarded back");
+	if (ihl != GOOD_IHL)
+		tst_brk(TBROK, "control datagram IHL corrupted (%u)", ihl);
+
+	send_datagram(&test_frame, offsetof(struct pkt_frame, ip));
+	if (capture_fragment(TEST_ID, &ihl) && ihl != GOOD_IHL) {
+		tst_res(TFAIL,
+			"IPv4 header IHL corrupted by checksum completion (%u)",
+			ihl);
+		return;
+	}
+
+	tst_res(TPASS,
+		"kernel dropped the datagram with checksum metadata inside the IPv4 header");
+}
+
+static void setup(void)
+{
+	struct ifreq ifr;
+	struct sockaddr_ll sll;
+	struct arpreq req;
+
+	if (!geteuid())
+		tst_modprobe("tun", NULL);
+
+	tst_setup_netns();
+
+	/* the tun socket must be opened in the test's own network
+	 * namespace: TUNSETIFF checks for CAP_NET_ADMIN in the user
+	 * namespace that owns the netns the file was opened in
+	 */
+	tap_fd = open("/dev/net/tun", O_RDWR);
+	if (tap_fd < 0)
+		tst_brk(TCONF | TERRNO, "open /dev/net/tun failed");
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, TAP_NAME, IFNAMSIZ - 1);
+	ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
+	SAFE_IOCTL(tap_fd, TUNSETIFF, &ifr);
+
+	NETDEV_SET_HWADDR(TAP_NAME, tap_mac, sizeof(tap_mac));
+	NETDEV_SET_STATE(TAP_NAME, 1);
+	NETDEV_ADD_ADDRESS_INET(TAP_NAME, inet_addr("10.0.0.1"), 24, 0);
+
+	cap_fd = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, TAP_NAME, IFNAMSIZ - 1);
+	ifr.ifr_mtu = TAP_MTU;
+	SAFE_IOCTL(cap_fd, SIOCSIFMTU, &ifr);
+
+	memset(&req, 0, sizeof(req));
+	tst_init_sockaddr_inet((struct sockaddr_in *)&req.arp_pa, "10.0.0.3", 0);
+	req.arp_ha.sa_family = ARPHRD_ETHER;
+	memcpy(req.arp_ha.sa_data, nbr_mac, sizeof(nbr_mac));
+	req.arp_flags = ATF_COM | ATF_PERM;
+	strncpy(req.arp_dev, TAP_NAME, IFNAMSIZ - 1);
+	SAFE_IOCTL(cap_fd, SIOCSARP, &req);
+
+	SAFE_FILE_PRINTF("/proc/sys/net/ipv4/ip_forward", "1");
+
+	memset(&sll, 0, sizeof(sll));
+	sll.sll_family = AF_PACKET;
+	sll.sll_protocol = htons(ETH_P_ALL);
+	sll.sll_ifindex = NETDEV_INDEX_BY_NAME(TAP_NAME);
+	SAFE_BIND(cap_fd, (struct sockaddr *)&sll, sizeof(sll));
+
+	build_frame(&ctrl_frame, CTRL_ID, 0);
+	build_frame(&test_frame, TEST_ID, 1);
+}
+
+static void cleanup(void)
+{
+	if (cap_fd != -1)
+		SAFE_CLOSE(cap_fd);
+
+	if (tap_fd != -1)
+		SAFE_CLOSE(tap_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_TUN",
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		"CONFIG_SYSCTL=y",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "6785011f8b16"},
+		{}
+	},
+};

---
base-commit: 121876b3da3ff59b0dd17b4798b2e4699ba431d1
change-id: 20261020-pwnescape-e3a7a61211f3

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
