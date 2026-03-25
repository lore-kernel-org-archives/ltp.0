Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BE61093168
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 14:19:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5332A3E2FF9
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:19:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 432443C62D0
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 15:19:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 26788600F85
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 15:19:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3CE9C4D24A;
 Wed, 25 Mar 2026 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774448353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxGlm1TjV3jd2WmVVYdJ+pz/C0CdNFedovEx3mHiaKY=;
 b=EZVvasHuhkJw5tIYn9+Zd1b0KQ+DEBw2ChH9VkhuUekeQ7XUOqBjXeY+o/tLgxOGKQuYkj
 VlQukYthSc9yK4kxkUTkvoK0VF+LY7NdXeiyaV7nEVtXKKioCLz1XFZ4Zc8eGHiFgfU8n8
 r0v5gVnHH5x6wsdykexm4ZS7lSNIL6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774448353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxGlm1TjV3jd2WmVVYdJ+pz/C0CdNFedovEx3mHiaKY=;
 b=hwpSp8sr4qBAozyGcFtq+LUV9XERoNfnfGo4Eco2kiOfusK9LHTjsNPgqeLreezbLcH+7Q
 FdpWUjzcMl1PwtDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UCzrfR8T;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=F3CSBySZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774448352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxGlm1TjV3jd2WmVVYdJ+pz/C0CdNFedovEx3mHiaKY=;
 b=UCzrfR8TDc9ZcalkZNbBmzMMU/99sdmPe9dnfoU7jCo//9xbFauuDknHj8JfVZb6yCtzPk
 8JbL2HpAW/z9/bJQwLPvivTFG4AUapWCDBPLsWs8m1JFgVapCfJZkOADbpIA7dmLOwHmzG
 tfVDgcrsv3BWBQkICt463Fsdhys+Vlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774448352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxGlm1TjV3jd2WmVVYdJ+pz/C0CdNFedovEx3mHiaKY=;
 b=F3CSBySZ8ErgfZN76FV5BsncVFev5kwaZKyF8lTwcybD6mm26CxYaRzyek9KTLMu90EBn0
 QRDFsJOsNCsd7ZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EDE744440;
 Wed, 25 Mar 2026 14:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EPO6BeDuw2nQPQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Mar 2026 14:19:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 25 Mar 2026 15:19:10 +0100
MIME-Version: 1.0
Message-Id: <20260325-ioctl_getlbmd01-v1-1-00dc526e326f@suse.com>
References: <20260325-ioctl_getlbmd01-v1-0-00dc526e326f@suse.com>
In-Reply-To: <20260325-ioctl_getlbmd01-v1-0-00dc526e326f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774448351; l=1850;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=cLJ3HRmDhTIopkCe3fkGq+C+/13nv1XJEjb3/+UlEpk=;
 b=aARXBBJqVXfvMAnzhwfZu2M1aT1DraQ0lG/+rT4T5KggMyOQzQ0jFqSUl2vZjgxjK4A2VWcx1
 S5usjcW60MhBirI73ebXtBWCsp90z/MVwquNfBPJ9dWYnloJ1Yx77Ob
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,configure.ac:url,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3CE9C4D24A
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Add logical_block_metadata_cap struct fallback
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add UAPI fallback definitions for struct logical_block_metadata_cap,
FS_IOC_GETLBMD_CAP ioctl and related LBMD_* constants in lapi/fs.h
for systems whose kernel headers predate v6.17.

Also add the corresponding AC_CHECK_TYPES entry in configure.ac.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac      |  2 ++
 include/lapi/fs.h | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9d6ec7f13ad421aa35840ebc65745c962b11e1db..685771096f5329177237f2c2a6e5dda00853c469 100644
--- a/configure.ac
+++ b/configure.ac
@@ -274,6 +274,8 @@ AC_CHECK_TYPES([struct file_attr],,,[#include <linux/fs.h>])
 
 AC_CHECK_TYPES([struct fsxattr],,,[#include <linux/fs.h>])
 
+AC_CHECK_TYPES([struct logical_block_metadata_cap],,,[#include <linux/fs.h>])
+
 AC_CHECK_TYPES([struct sockaddr_vm],,,[
 #include <sys/socket.h>
 #include <linux/vm_sockets.h>
diff --git a/include/lapi/fs.h b/include/lapi/fs.h
index 6b5056bd25c5504637f01f10be8b091f79d5632d..471ad0a25b805b9d4254b13611445a1cc294e0f1 100644
--- a/include/lapi/fs.h
+++ b/include/lapi/fs.h
@@ -136,4 +136,25 @@ static inline int file_setattr(int dfd, const char *filename,
 }
 #endif
 
+#ifndef HAVE_STRUCT_LOGICAL_BLOCK_METADATA_CAP
+struct logical_block_metadata_cap {
+	uint32_t	lbmd_flags;
+	uint16_t	lbmd_interval;
+	uint8_t		lbmd_size;
+	uint8_t		lbmd_opaque_size;
+	uint8_t		lbmd_opaque_offset;
+	uint8_t		lbmd_pi_size;
+	uint8_t		lbmd_pi_offset;
+	uint8_t		lbmd_guard_tag_type;
+	uint8_t		lbmd_app_tag_size;
+	uint8_t		lbmd_ref_tag_size;
+	uint8_t		lbmd_storage_tag_size;
+	uint8_t		pad;
+};
+#endif
+
+#ifndef FS_IOC_GETLBMD_CAP
+# define FS_IOC_GETLBMD_CAP	_IOWR(0x15, 2, struct logical_block_metadata_cap)
+#endif
+
 #endif /* LAPI_FS_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
