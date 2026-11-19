Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D30606A32F
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=g6MWoOol;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VcNQBWs2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795095673; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=iIP21Vqa39EmlpxWFb1+ZT6PaXj7Zb+wSy69nDQS9M0=;
 b=g6MWoOoltYocuBVxGNHojGnMtWXFmLK+P+lQa+t0oG39fVZ/2waHJ5xCzLaM9EUdkwUw9
 wah/7/6aRBtXLwRf+hWdta6mqiW2qsC1ZU3HTg9VYyElfCUVNIig8g69gtAmWzAM/mr7pz/
 s9qxm5h0MnT8faCe0VQHUmBfSkzA1ZA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 935393E935E
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F22353C9E88
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 14:40:51 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4154610009E9
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 14:40:51 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so20888315e9.2
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795095651; x=1795700451; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gcbedqIyrp3A6pBnKtv8dA/K/gdizI0CfZGG2pub19Y=;
 b=VcNQBWs2yz/hwr+Xc3xhWW8voee1Tgrh7ki6ty8itiOtZ8ZF9iMNzvbdShCs4wpsnH
 yB/mjHS1mOcYBzI+67Nn1S/EMVBuy+iJrv2u3U6pZyn1OwgDx1fWHNSASB9dffmDMcxl
 zJVgbLhfyAMZr+19KmTBY4YgjWevY3VuOSrq2VNYwxmnwcGcDJMjec42J4OZVwy9tZaX
 dx3GCfvAQeJdbedPhp4dgDxlORIJ47UUEfekOrvCHr6sAGJwsd2GfQRTW5b7zOscb7Wo
 b9MQ9JzzyJrl97pQ5KDrzbAQnX1lFVaIFSIYPagfqEk0X/kunAUCLpY/EkrZHkTI6O3V
 4Ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095651; x=1795700451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gcbedqIyrp3A6pBnKtv8dA/K/gdizI0CfZGG2pub19Y=;
 b=N1hXm+3YjiVmJdN3r4yIgT9K9ekKWwRHL9HReFnIJtrryXxsX7Zw9M+/6U+MY2GpmB
 vnUWkdS8RZAhPuwRRj5GA2RyRrJ3rlwFB+sb3S1RoAMiLCfvGL0cJzKq4DcNJpMc9kOj
 6piK/U2Iggz5teIyDB/D43m7cYppXHJ4LK3tB4FDeKKy5UKeh1LHLix/cJ4i9xAyJeZ6
 x6oXRnSZfnL1UpVGEEOdzaGXUQYgPFKpMVot6Z6WBy0oponyLzDG6Ek63yGRp9jTc7rE
 RvDaRUWbM8fNIDY37e/1H90YLy5Zsa4xIdt9Ykc+C831Renju64iwgpeunXrzU4K4K/v
 NjSw==
X-Gm-Message-State: APuU4Z8E/sg7Tn6ZNfvz87iEsipUyiE7LzhA8l27q6zf/a8QtDGzomxc
 vTMXJE4/z42Cjb3RGkL71H3jFRZz8lyELjimorQ6XJDmK18iwVRdrvYbd8S9r1a/rUHunJdiFqU
 vvJdHpxU=
X-Gm-Gg: AYBFou2PGcshhF3y8oob6FBxwkKePoyeYBtxhQBf6QBXlxBshznCcD+ojpxEFkUuSFu
 CTBAZ4b7S35vniSVzNFxZZuJ7d1JhglluxPkDj07XRF0nFU8wdoUCOQw1nVapuKhhtk1qgWwrv5
 EGxw3VQxtWgJS4cafDWLCYylcr0Oblg/0HLAGiJQSNZ0+72ZayO3gpOvF9/N96eTsVUe/9Sqm49
 yJW2ZewTy/BuQtzDgInKF5WqCY3zs95dxMP59OZiaHLSAlbChLShdrGKrplRmUKUqze0qD1JlD8
 3cIbGB8nVw+6Bj9w9YVLoMxJIyUyAL16Fl4jDPrqokEs58/bSrk+Ngdo0SawUMs0k5D0nFLYzLa
 D9pCqqXvUxfYeWwNCbF7zZLdxDzcgrSUl0geKsqvKncXOi4/nr/X650TqJOYfniBZr3Ss2x2B/E
 YozFUGvTzhs7ioVqKqjn48pdbjBN4VLQWy88ocaCISYRiPPHOmLyjAID+IlStblKi7h364hoNxu
 5SFzEvU19dgoOeEcMmiJWyRc7RQCD0vZMArMvSCWb1RaaGvEcqt4wWyP2V0ce7ApS1omqaBthIq
 /cqtsY2NyGLwvpjxRlLwfjfES/Rz
X-Received: by 2002:a05:600c:620c:b0:4bb:665c:a078 with SMTP id
 5b1f17b1804b1-4bb7da4917bmr115720105e9.28.1795095650544; 
 Thu, 19 Nov 2026 05:40:50 -0800 (PST)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e50512sm21445235e9.3.2026.11.19.05.40.50
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 05:40:50 -0800 (PST)
To: ltp@lists.linux.it
Date: Thu, 19 Nov 2026 14:40:45 +0100
Message-ID: <20261119134049.272956-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pwnescape: Send untagged frames on kernels without
 nested VLAN 0 support
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

The test wraps every frame in two VID 0 VLAN tags so that csum_start can
point at the IPv4 header on kernels with the csum_start check in the TAP
driver (added in v6.12), which reject checksum metadata starting less
than sizeof(struct iphdr) bytes into the frame.

Kernels without the nested VID 0 tag handling (added in v5.2) drop such
frames in __netif_receive_skb_core(), so the control datagram is never
forwarded and the test ends with TBROK before it exercises the bug.

pwnescape.c:219: TBROK: control datagram was not forwarded back

Such kernels typically lack the csum_start check in the TAP driver as
well, so the same frames can be sent without the tags.

Probe the framing in setup(): send the control datagram with the tags
and, if it is not forwarded back, retry without them and use that framing
for all following frames. The vulnerable path is unchanged, only the L2
framing and the matching csum_start differ.

Fixes: 02173646c ("cve: add pwnescape reproducer")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/cve/pwnescape.c | 84 ++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 19 deletions(-)

diff --git a/testcases/cve/pwnescape.c b/testcases/cve/pwnescape.c
index 12963382f718..5a3a382548d7 100644
--- a/testcases/cve/pwnescape.c
+++ b/testcases/cve/pwnescape.c
@@ -21,11 +21,16 @@
  * The test loads the tun module when run as root and runs inside a
  * private network namespace so that it needs no other privileges.
  *
- * The frames carry two VID 0 VLAN tags because the TAP driver rejects
- * checksum metadata starting less than ``sizeof(struct iphdr)`` bytes into
- * the frame. Without the tags the IPv4 header would start at frame offset
- * 14, so ``csum_start`` could not point at it. With the tags it starts at
- * offset 22.
+ * The frames carry two VID 0 VLAN tags because TAP drivers with the
+ * csum_start check (added in v6.12) reject checksum metadata starting less
+ * than ``sizeof(struct iphdr)`` bytes into the frame. Without the tags the
+ * IPv4 header would start at frame offset 14, so ``csum_start`` could not
+ * point at it. With the tags it starts at offset 22.
+ *
+ * Kernels without the nested VID 0 tag handling (added in v5.2) drop such
+ * frames before they reach the IPv4 layer. They typically lack the
+ * csum_start check in the TAP driver as well, so the test sends the frames
+ * without the VLAN tags there, with the IPv4 header at frame offset 14.
  *
  * [Algorithm]
  *
@@ -37,12 +42,16 @@
  *   device
  * - send a 320 byte control IPv4 datagram behind two VID 0 VLAN tags
  *   with checksum metadata at the transport header (frame offset 42)
- *   and verify its fragments are forwarded with an intact header
+ *   and verify its fragments are forwarded; if they are not, retry
+ *   without the VLAN tags (frame offset 34) and send all following frames
+ *   without them
+ * - send the control datagram again and verify its fragments carry an
+ *   intact header
  * - send the test datagram with csum_start on the IPv4 header (frame
- *   offset 22) and a payload word chosen so that completing the bogus
- *   checksum writes 0x4f (version 4, IHL 15) at the start of the IPv4
- *   header, then check whether the emitted fragments carry the
- *   corrupted header
+ *   offset 22, or 14 without VLAN tags) and a payload word chosen so
+ *   that completing the bogus checksum writes 0x4f (version 4, IHL 15)
+ *   at the start of the IPv4 header, then check whether the emitted
+ *   fragments carry the corrupted header
  */
 
 #include <stddef.h>
@@ -79,7 +88,6 @@ struct vlan_tag {
 
 struct pkt_frame {
 	struct ethhdr eth;
-	struct vlan_tag vlan[2];
 	struct iphdr ip;
 	uint16_t csum_adj;
 	uint8_t payload[PAYLOAD_LEN - sizeof(uint16_t)];
@@ -87,6 +95,7 @@ struct pkt_frame {
 
 static int tap_fd = -1;
 static int cap_fd = -1;
+static int vlan_tagged;
 
 static struct pkt_frame ctrl_frame;
 static struct pkt_frame test_frame;
@@ -115,9 +124,7 @@ static void build_frame(struct pkt_frame *fr, uint16_t id, int corrupt_iph)
 
 	memcpy(fr->eth.h_dest, tap_mac, ETH_ALEN);
 	memcpy(fr->eth.h_source, src_mac, ETH_ALEN);
-	fr->eth.h_proto = htons(ETH_P_8021Q);
-	fr->vlan[0].proto = htons(ETH_P_8021Q);
-	fr->vlan[1].proto = htons(ETH_P_IP);
+	fr->eth.h_proto = htons(ETH_P_IP);
 
 	fr->ip.version = 4;
 	fr->ip.ihl = GOOD_IHL;
@@ -139,20 +146,32 @@ static void build_frame(struct pkt_frame *fr, uint16_t id, int corrupt_iph)
 }
 
 /* write a frame to the TAP device with a virtio_net_hdr that asks
- * for checksum completion at the given frame-relative csum_start
+ * for checksum completion at the given csum_start, which is relative
+ * to the start of the frame without VLAN tags
  */
 static void send_datagram(struct pkt_frame *fr, uint16_t csum_start)
 {
+	struct vlan_tag vlan[] = {
+		{.proto = htons(ETH_P_8021Q)},
+		{.proto = htons(ETH_P_IP)},
+	};
+	size_t vlan_len = vlan_tagged ? sizeof(vlan) : 0;
+	struct ethhdr eth = fr->eth;
 	struct virtio_net_hdr vnet_hdr = {
 		.flags = VIRTIO_NET_HDR_F_NEEDS_CSUM,
-		.csum_start = csum_start,
+		.csum_start = csum_start + vlan_len,
 		.csum_offset = 0,
 	};
 	struct iovec iov[] = {
 		{.iov_base = &vnet_hdr, .iov_len = sizeof(vnet_hdr)},
-		{.iov_base = fr, .iov_len = sizeof(*fr)},
+		{.iov_base = &eth, .iov_len = sizeof(eth)},
+		{.iov_base = vlan, .iov_len = vlan_len},
+		{.iov_base = &fr->ip, .iov_len = sizeof(*fr) - sizeof(eth)},
 	};
 
+	if (vlan_tagged)
+		eth.h_proto = htons(ETH_P_8021Q);
+
 	SAFE_WRITEV(SAFE_WRITE_ALL, tap_fd, iov, ARRAY_SIZE(iov));
 }
 
@@ -208,14 +227,39 @@ static int capture_fragment(uint16_t id, unsigned int *ihl)
 	return 0;
 }
 
+static int send_control(unsigned int *ihl)
+{
+	send_datagram(&ctrl_frame, offsetof(struct pkt_frame, csum_adj));
+
+	return capture_fragment(CTRL_ID, ihl);
+}
+
+/* kernels older than v5.2 drop the frames with nested VID 0 tags, so send
+ * the frames without the tags if the control datagram does not make it
+ * through with them
+ */
+static void select_framing(void)
+{
+	unsigned int ihl;
+
+	vlan_tagged = 1;
+	if (send_control(&ihl))
+		return;
+
+	tst_res(TINFO, "VLAN tagged control datagram was not forwarded back, retrying without VLAN tags");
+
+	vlan_tagged = 0;
+	if (!send_control(&ihl))
+		tst_brk(TBROK, "control datagram was not forwarded back with or without VLAN tags");
+}
+
 static void run(void)
 {
 	unsigned int ihl;
 
 	drain_capture();
 
-	send_datagram(&ctrl_frame, offsetof(struct pkt_frame, csum_adj));
-	if (!capture_fragment(CTRL_ID, &ihl))
+	if (!send_control(&ihl))
 		tst_brk(TBROK, "control datagram was not forwarded back");
 	if (ihl != GOOD_IHL)
 		tst_brk(TBROK, "control datagram IHL corrupted (%u)", ihl);
@@ -293,6 +337,8 @@ static void setup(void)
 
 	build_frame(&ctrl_frame, CTRL_ID, 0);
 	build_frame(&test_frame, TEST_ID, 1);
+
+	select_framing();
 }
 
 static void cleanup(void)
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
