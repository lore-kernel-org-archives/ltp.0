Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E83CA0FFE
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 08:30:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E5743CD3A4
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 10:30:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79B6E3CD3AB
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 10:29:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F188C1400771
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 10:29:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E6D231F455;
 Tue,  2 Sep 2025 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756801780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=VSSzq5AgymdUaSncqSUzTfpNX0Mc3duEMwaebSLo6ei10vnBBSmlRP0NPk/F3JO5t14r2H
 2za/9gUlbPtSXnojnbBsFXH3zpjpGgwTwT0knQcsN073FDmyBpTW0zsG+4jikr1zwSckj/
 n3FpKhUSRfWysU5wVkFHY5/Io2qBdhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756801780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=I9g3MhxYtlE9FqWVjbdt9hCVlKyDw5h5iZ7lG3Vx+27YhVjH3PPCk27iqr2iK09kW7U2J4
 65tjxQvWvTIgGwBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756801780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=VSSzq5AgymdUaSncqSUzTfpNX0Mc3duEMwaebSLo6ei10vnBBSmlRP0NPk/F3JO5t14r2H
 2za/9gUlbPtSXnojnbBsFXH3zpjpGgwTwT0knQcsN073FDmyBpTW0zsG+4jikr1zwSckj/
 n3FpKhUSRfWysU5wVkFHY5/Io2qBdhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756801780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXbFffUzDZSALWNb+3dCQGk8dfdZTFnl29hTgIS+Piw=;
 b=I9g3MhxYtlE9FqWVjbdt9hCVlKyDw5h5iZ7lG3Vx+27YhVjH3PPCk27iqr2iK09kW7U2J4
 65tjxQvWvTIgGwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9660413888;
 Tue,  2 Sep 2025 08:29:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AFnJHvSqtmiDdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Sep 2025 08:29:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Sep 2025 10:29:36 +0200
MIME-Version: 1.0
Message-Id: <20250902-open_tree_attr-v2-1-b23d2585986d@suse.com>
References: <20250902-open_tree_attr-v2-0-b23d2585986d@suse.com>
In-Reply-To: <20250902-open_tree_attr-v2-0-b23d2585986d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756801779; l=1463;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Dhq/cBc6PX6ComRKaQAdb8sb1xRmOAb8S3xIte/tJO4=;
 b=isutlaS1Wq9/IPBiEOyY+EOjK3/x93bQS274wvDM/WBOr0+uvTSsZqFjYVphEnUq47UAG3J7N
 pRJrOWuIWBQAr7ske48Wo2k9uEQMUamwZJ7Png/VjarHHvuBdEa0Kjg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] Add open_tree_attr fallback
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

open_tree_attr syscall has been introduced in kernel 6.15 and it's
now defined in lapi/fsmount.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac           | 1 +
 include/lapi/fsmount.h | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/configure.ac b/configure.ac
index 62ae27d494474fe342b1cceeac7f4c21c0b1028c..2d4d527bcaa675dae5d712a96d266d17184b8a0d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -137,6 +137,7 @@ AC_CHECK_FUNCS_ONCE([ \
     move_mount \
     name_to_handle_at \
     open_tree \
+    open_tree_attr \
     openat \
     openat2 \
     pidfd_getfd \
diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 1783272a00a1a049031cacbb417239123450a0e4..451987ae637d040e08970b7ffcf015bae07a6f11 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -105,6 +105,14 @@ static inline int open_tree(int dirfd, const char *pathname, unsigned int flags)
 }
 #endif /* HAVE_OPEN_TREE */
 
+#ifndef HAVE_OPEN_TREE_ATTR
+static inline int open_tree_attr(int dirfd, const char *pathname, unsigned int flags,
+				 struct mount_attr *attr, size_t size)
+{
+	return tst_syscall(__NR_open_tree_attr, dirfd, pathname, flags, attr, size);
+}
+#endif /* HAVE_OPEN_TREE_ATTR */
+
 #ifndef HAVE_MOUNT_SETATTR
 static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned int flags,
 				struct mount_attr *attr, size_t size)

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
