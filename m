Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAF8CAC5B0
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:48:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A80C3CE2F3
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:48:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 975303CE32D
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F2BA10007D8
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B9EE22B7B;
 Tue,  7 Oct 2025 06:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNlG2Qsq/LxVhuxbCCWOAi53UlMlXr0DepvoFzAu4s4=;
 b=Dlcsaexhn93WapKVGMyRvQ8jjg0BypmgYt/FjR7FFqkjOuEI3hiLkQfhf98wM5fvlOLxZv
 lVi1V4qzU/oiz/+6DJiDwzUG8mYtlqvdU/mJJ4RVHLEPR2wQIO7giTQ8H17u6Oo3/9Oq4t
 WLarRJt6Jv/pePA2qXOsPGTaejiaQGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNlG2Qsq/LxVhuxbCCWOAi53UlMlXr0DepvoFzAu4s4=;
 b=/MdH8x4IR6cj9cWB/ZPE6vfN245w38VOWv6lRNLdC14ZpK2pwSF0rdEkvE/J7eZa2tZoze
 bad6+ojTkw7Y2kBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dlcsaexh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/MdH8x4I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNlG2Qsq/LxVhuxbCCWOAi53UlMlXr0DepvoFzAu4s4=;
 b=Dlcsaexhn93WapKVGMyRvQ8jjg0BypmgYt/FjR7FFqkjOuEI3hiLkQfhf98wM5fvlOLxZv
 lVi1V4qzU/oiz/+6DJiDwzUG8mYtlqvdU/mJJ4RVHLEPR2wQIO7giTQ8H17u6Oo3/9Oq4t
 WLarRJt6Jv/pePA2qXOsPGTaejiaQGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819634;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pNlG2Qsq/LxVhuxbCCWOAi53UlMlXr0DepvoFzAu4s4=;
 b=/MdH8x4IR6cj9cWB/ZPE6vfN245w38VOWv6lRNLdC14ZpK2pwSF0rdEkvE/J7eZa2tZoze
 bad6+ojTkw7Y2kBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7400413AAC;
 Tue,  7 Oct 2025 06:47:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uCbgDnG35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:46:58 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-6-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=1058;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=HBxF9EUGlom8M/sDsYYyRtwci8TiAZnB2+lqufC0SnE=;
 b=0JufKcFj+/t1saOiGGn2wu8TroTpyw6OrDIFqm0rgTeaS0ty15VVBDGSdLavLHjvw1F8JNyzA
 N2r+XXXsaajDTYMGqI2tfAhuTyH1lr21CrG+neRvnRgjCwKq2fo9g3Z
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 1B9EE22B7B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 06/10] lapi: add getxattrat() fallback
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac         |  1 +
 include/lapi/xattr.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/configure.ac b/configure.ac
index 827a8e6eb..e43e631ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -125,6 +125,7 @@ AC_CHECK_FUNCS_ONCE([ \
     getcpu \
     getdents \
     getdents64 \
+    getxattrat \
     io_pgetevents \
     io_uring_setup \
     io_uring_register \
diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
index 8ab7e51d5..3b664e4e6 100644
--- a/include/lapi/xattr.h
+++ b/include/lapi/xattr.h
@@ -41,4 +41,14 @@ static inline int setxattrat(int dfd, const char *pathname,
 }
 #endif
 
+#ifndef HAVE_FUNC_GETXATTRAT
+static inline int getxattrat(int dfd, const char *pathname,
+			     unsigned int at_flags, const char *name,
+			     void *value, size_t size)
+{
+	return tst_syscall(__NR_getxattrat, dfd, pathname, at_flags, name,
+		    value, size);
+}
+#endif
+
 #endif /* LAPI_XATTR_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
