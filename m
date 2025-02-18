Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408BBC02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:51:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66AF83C9CA9
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:50:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 918C63C0254
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:50:41 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E549C62FB84
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:50:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BED31F396;
 Tue, 18 Feb 2025 12:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739883040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksVExQV1yZ2gffjX6Lfdc7Xp9Y7QfOuUlDbwQa/L/nA=;
 b=VexB89HEMByI1MI9MRNgNUQrbRyAI0nMshczfgeMjywoKyJhXTpKlcQ2D5UIxii8Icz/xT
 pFTeM8xbCeRTE5rYfsEOtVftQGNeBmvYY9wxi7r0p8mZtG90XkFRseUZ604INruWKNlfYt
 XX2vvNXL2n0JgPA1o/80BEMHEb8myg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739883040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksVExQV1yZ2gffjX6Lfdc7Xp9Y7QfOuUlDbwQa/L/nA=;
 b=Dwm56VgBzspg8my5A+IJ+HOGYT9Z67betoEx+nrj66eb938RCmj5ZmvLTEBKHwHbywPl3P
 dZ0g6DBhq0hIsiAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739883040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksVExQV1yZ2gffjX6Lfdc7Xp9Y7QfOuUlDbwQa/L/nA=;
 b=VexB89HEMByI1MI9MRNgNUQrbRyAI0nMshczfgeMjywoKyJhXTpKlcQ2D5UIxii8Icz/xT
 pFTeM8xbCeRTE5rYfsEOtVftQGNeBmvYY9wxi7r0p8mZtG90XkFRseUZ604INruWKNlfYt
 XX2vvNXL2n0JgPA1o/80BEMHEb8myg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739883040;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksVExQV1yZ2gffjX6Lfdc7Xp9Y7QfOuUlDbwQa/L/nA=;
 b=Dwm56VgBzspg8my5A+IJ+HOGYT9Z67betoEx+nrj66eb938RCmj5ZmvLTEBKHwHbywPl3P
 dZ0g6DBhq0hIsiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AD1D132C7;
 Tue, 18 Feb 2025 12:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +8aBFB+CtGdUPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Feb 2025 12:50:39 +0000
Date: Tue, 18 Feb 2025 13:50:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250218125029.GB2469726@pevik>
References: <20250217215038.177250-1-jmoyer@redhat.com>
 <20250217215038.177250-3-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250217215038.177250-3-jmoyer@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] lib/tst_device.c: check for
 BTRFS_SUPER_MAGIC instead of device major of 0
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jeff,

> stat() may return a major number of 0 in st_dev for any number of
> pseudo file systems.  Check for the exact file system instead.  There
> should be no change in behavior with this patch.

LGTM, thank you!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

FYI I'll apply very minor formatting fix before merge.

Kind regards,
Petr

+++ lib/tst_device.c
@@ -559,12 +559,10 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
 
 	uevent_path[0] = '\0';
 
-	if (d) {
-		sprintf(uevent_path, "%s/%s/uevent",
-			bdev_path, d->d_name);
-	} else {
-		tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s.", bdev_path);
-	}
+	if (d)
+		sprintf(uevent_path, "%s/%s/uevent", bdev_path, d->d_name);
+	else
+		tst_brkm(TBROK | TERRNO, NULL, "No backing device found while looking in %s", bdev_path);
 
 	if (SAFE_READDIR(NULL, dir))
 		tst_resm(TINFO, "Warning: used first of multiple backing device.");
@@ -600,7 +598,7 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
 	if (fsbuf.f_type == TST_BTRFS_MAGIC) {
 		btrfs_get_uevent_path(tmp_path, uevent_path);
 	} else if (dev_major == 0) {
-		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system.", path);
+		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system", path);
 	} else {
 		tst_resm(TINFO, "Use uevent strategy");
 		sprintf(uevent_path,


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
