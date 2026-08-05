Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EB0C55822
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 09:51:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB3CA3E2BC9
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 11:51:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 756CB3E1538
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:50:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EB7ED1400C7F
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 11:50:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9206C7FD51;
 Wed,  5 Aug 2026 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a99T6oalajTk7B/pBji9kZBYFHli6QDochGTJF9Lbw=;
 b=r+v0qV+JZm8k2XRX6LyQS1kI8MunOIft7/1qSWcI7uZ3POBYiS6BAbEFgQwLYdZKZq/TqJ
 mh9ylsVPJ92wUxY9V9wlQ7Tfp2ZlXQqKSN0ME4QC/qbirDzbQTrmNSs5KIiaDpHzh06sRI
 b6O2p8Y6i9jPHTNCBu7avDrnePHu888=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a99T6oalajTk7B/pBji9kZBYFHli6QDochGTJF9Lbw=;
 b=mtGM0eVsB2gQYyBUrG1bciwyS0oFF9+alnf4cjXY0fPpcV0j6J/o0ZRa89hppcEpESiSSJ
 0vh2h5XkR1VTVLDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0iE2lLw2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DBQ8v2eG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785923380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a99T6oalajTk7B/pBji9kZBYFHli6QDochGTJF9Lbw=;
 b=0iE2lLw24SuJr99ZbRd3BbycLpKx9engDF7mTe86jQCZASM+GkVdfUDANRt6Y5eBpVJxHu
 Zuf8cOOs9EIw2J9Zvb6X8UmQ8j6qVpbXDbBHXa1QWDIrD7FIcRJS7czGZfBscg5QQ58014
 bdlbNSOQxGoJb5OWRX5UN+v6DfNy2sQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785923380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a99T6oalajTk7B/pBji9kZBYFHli6QDochGTJF9Lbw=;
 b=DBQ8v2eGdGkXlW+SxZSFkDtsQyjbXacIDvUA0FiDsQbYXDJMlDTNsEyoxlntvjHVX4vA0f
 veTeFUE+DYF0iIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B6E6779EC;
 Wed,  5 Aug 2026 09:49:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MIhkFTQHc2rvSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 09:49:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 11:49:35 +0200
Message-ID: <20260805094935.448896-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805094935.448896-1-pvorel@suse.cz>
References: <20260805094935.448896-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9206C7FD51
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] tst_kvercmp.h: Further links to manpage
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

Add further manpage links (requires Sphinx 7.3):
* struct utsname.release => uname(2)
* uname -r => uname(1)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_kvercmp.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
index 2bc7c53f12..26e8f8e3c1 100644
--- a/include/tst_kvercmp.h
+++ b/include/tst_kvercmp.h
@@ -10,7 +10,7 @@
 /**
  * tst_kvcmp() - Compare given kernel version with kernel in string.
  *
- * @cur_kver: Kernel version string (struct utsname.release).
+ * @cur_kver: Kernel version string (:manpage:`struct utsname.release <uname(2)>`).
  * @r1: Major kernel version.
  * @r2: Minor kernel version.
  * @r3: Kernel patch level.
@@ -28,7 +28,7 @@ int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3);
 /**
  * tst_parse_kver() - Parses a version string into three integers.
  *
- * @str_kver: Kernel version string (struct utsname.release).
+ * @str_kver: Kernel version string (:manpage:`struct utsname.release <uname(2)>`).
  * @v1: Major kernel version.
  * @v2: Minor kernel version.
  * @v3: Kernel patch level.
@@ -43,7 +43,7 @@ int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3);
 /**
  * tst_kvcmp_distname() - Get the distribution name from kernel version string.
  *
- * @cur_kver: Kernel version string (struct utsname.release).
+ * @cur_kver: Kernel version string (:manpage:`struct utsname.release <uname(2)>`).
  *
  * Return: The distribution name parsed from kernel version string or NULL.
  */
@@ -51,8 +51,8 @@ const char *tst_kvcmp_distname(const char *cur_kver);
 
 /**
  * tst_kvexcmp() - Compares versions up to five version numbers long.
- * @tst_exv: The tested kernel version string (struct utsname.release).
- * @cur_kver: The current version in string (struct utsname.release).
+ * @tst_exv: The tested kernel version string (:manpage:`struct utsname.release <uname(2)>`).
+ * @cur_kver: The current version in string (:manpage:`struct utsname.release <uname(2)>`).
  *
  * The return value is similar to the :manpage:`strcmp(3)` function, i.e. zero means
  * equal, negative value means that the kernel is older than the expected value
@@ -70,7 +70,8 @@ int tst_kvexcmp(const char *tst_exv, const char *cur_kver);
  * @r3: Kernel patch level.
  *
  * Parse the output from :manpage:`uname(2)` and compare it to the passed values.
- * This is shortcut for calling tst_kvcmp() with ``uname -r`` as str_kver.
+ * This is shortcut for calling tst_kvcmp() with :manpage:`uname -r <uname(1)>`
+ * as str_kver.
  *
  * Return: Negative if older, 0 if the same and positive if newer.
  */
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
