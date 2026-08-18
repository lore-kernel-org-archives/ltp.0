Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31EDC5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:17:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C7133CC86F
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:17:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ECEF3CD537
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA4AA2003AA
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 084C0845AA
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsV//2d2bLX/Y7WREXWBjALaR8hoaZEErp9ohXyl9F4=;
 b=LPd1+pV76LkwohZcmweWhptTfcKqvA5ahMgsGd9g4SVgr6FgHgOHjEdfcpK5ulmfyRbMBI
 HJ4GMqZi2BHMmuLLxXQZN/vS3eOLuPfns6zg7aXIGrNZuXBPuSXBrYmPXpNiVHzJIMGLEN
 9vZmedvtR8pnnGg6e/52ec0krCprSXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsV//2d2bLX/Y7WREXWBjALaR8hoaZEErp9ohXyl9F4=;
 b=v/sFktXVd07RpNPk3hYY9XCxQ5vcKosEC+R3F0O0AO/FOegd2QM2qbXKupO0rQbXGqQvoZ
 rchw5/a0x5xVnPBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsV//2d2bLX/Y7WREXWBjALaR8hoaZEErp9ohXyl9F4=;
 b=iMO/wC3tB9zMP60gmvIbhQzJCDvw4xuzxv/qyMHux1hX7ULYy5FahyWb9BhHFNlMqkciUo
 agTgP4QGB8Lu89LyQVZuxs1Bk3bjBrsWY7gTyb9KnO0IeGAb6D8c7ROZSxYREe0GrM2H9d
 W/QRZaF8ZmC+jAvw+TK9fcvuLwtV4BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NsV//2d2bLX/Y7WREXWBjALaR8hoaZEErp9ohXyl9F4=;
 b=SadJV0x8bs5qyhc5bLdiRIE9ozNdC6kqleZHDxW2JXIfwx0kchQKbZ8VNQI/4NRY1NmNnT
 9JQq3w3wG7uKpMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEA53367B
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BlXyOIdohGoMcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:12:59 +0200
Message-ID: <20260818141311.1265557-20-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 19/31] tst_netdevice: Add two more helper macros
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

- NETDEV_SET_HWADDR() helper to change MAC address
- NETDEV_SET_MASTER() helper to connect two devices as master-slave

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_netdevice.h | 20 +++++++++
 lib/tst_netdevice.c     | 90 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index 2617bb149..934ee5fb4 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -61,6 +61,26 @@ int tst_netdev_remove_address_inet(const char *file, const int lineno,
 #define NETDEV_REMOVE_ADDRESS_INET(ifname, address) \
 	tst_netdev_remove_address_inet(__FILE__, __LINE__, 1, (ifname), \
 		(address))
+/*
+ * Change the link-layer (MAC) address of an existing network device. Most
+ * drivers require the device to be administratively down for this to
+ * succeed.
+ */
+int tst_netdev_set_hwaddr(const char *file, const int lineno, int strict,
+	const char *ifname, const void *addr, size_t addrlen);
+#define NETDEV_SET_HWADDR(ifname, addr, addrlen) \
+	tst_netdev_set_hwaddr(__FILE__, __LINE__, 1, (ifname), (addr), \
+		(addrlen))
+
+/*
+ * Enslave ifname to the master_ifname device, e.g. add it as a bridge or bond
+ * port. Pass NULL as master_ifname to release the device from its current
+ * master.
+ */
+int tst_netdev_set_master(const char *file, const int lineno, int strict,
+	const char *ifname, const char *master_ifname);
+#define NETDEV_SET_MASTER(ifname, master_ifname) \
+	tst_netdev_set_master(__FILE__, __LINE__, 1, (ifname), (master_ifname))
 
 int tst_netdev_change_ns_fd(const char *file, const int lineno, int strict,
 	const char *ifname, int nsfd);
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index 1042466bf..0861d39fc 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -287,6 +287,96 @@ static int modify_address(const char *file, const int lineno, int strict,
 	return ret;
 }
 
+int tst_netdev_set_hwaddr(const char *file, const int lineno, int strict,
+	const char *ifname, const void *addr, size_t addrlen)
+{
+	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
+	struct tst_netlink_context *ctx;
+	int ret;
+
+	if (strlen(ifname) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname);
+		return 0;
+	}
+
+	ctx = create_request(file, lineno, RTM_NEWLINK, 0, &info, sizeof(info));
+
+	if (!ctx)
+		return 0;
+
+	if (!tst_rtnl_add_attr_string(file, lineno, ctx, IFLA_IFNAME, ifname)) {
+		tst_netlink_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	if (!tst_rtnl_add_attr(file, lineno, ctx, IFLA_ADDRESS, addr, addrlen)) {
+		tst_netlink_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	ret = tst_netlink_send_validate(file, lineno, ctx);
+	tst_netlink_destroy_context(file, lineno, ctx);
+
+	if (strict && !ret) {
+		tst_brk_(file, lineno, TBROK,
+			"Failed to set hwaddr for %s: %s", ifname,
+			tst_strerrno(tst_netlink_errno));
+	}
+
+	return ret;
+}
+
+int tst_netdev_set_master(const char *file, const int lineno, int strict,
+	const char *ifname, const char *master_ifname)
+{
+	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
+	struct tst_netlink_context *ctx;
+	int32_t master_index = 0;
+	int ret;
+
+	if (strlen(ifname) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname);
+		return 0;
+	}
+
+	if (master_ifname) {
+		master_index = tst_netdev_index_by_name(file, lineno,
+			master_ifname);
+
+		if (master_index < 0)
+			return 0;
+	}
+
+	ctx = create_request(file, lineno, RTM_NEWLINK, 0, &info, sizeof(info));
+
+	if (!ctx)
+		return 0;
+
+	if (!tst_rtnl_add_attr_string(file, lineno, ctx, IFLA_IFNAME, ifname)) {
+		tst_netlink_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	if (!tst_rtnl_add_attr(file, lineno, ctx, IFLA_MASTER, &master_index,
+		sizeof(master_index))) {
+		tst_netlink_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	ret = tst_netlink_send_validate(file, lineno, ctx);
+	tst_netlink_destroy_context(file, lineno, ctx);
+
+	if (strict && !ret) {
+		tst_brk_(file, lineno, TBROK,
+			"Failed to set master for %s: %s", ifname,
+			tst_strerrno(tst_netlink_errno));
+	}
+
+	return ret;
+}
+
 int tst_netdev_add_address(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *address,
 	unsigned int prefix, size_t addrlen, unsigned int flags)
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
