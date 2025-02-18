Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8D0C02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E60023C9C92
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:58:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3BBC3C093B
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:57:50 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 29E38231809
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:57:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42C2C1F396;
 Tue, 18 Feb 2025 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739883469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b85Aixuryvg216dGQZUo2otba+e/UFbPzPil1RVLtxE=;
 b=OADaaFr5HWlMNlgOazpWT61VrMs4xsFxjSRNPyzdLRLgpY0q8XI+nKHvRt3QKYz0G1gX3y
 AFVh6THC/TbnYHsjXcl78+QJW4ogmMSxaUXMbVCVP288ijhRG76yV6/D9AB2ztq3MSs+uk
 UOstQrg92CECs3nZXg3FzhvEBjmUlx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739883469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b85Aixuryvg216dGQZUo2otba+e/UFbPzPil1RVLtxE=;
 b=KxDRMXm8sTSivB+U58lUlhm0NrM6VwiH56aVOJA2MsA9mtogkC0sfqcB0z4M09Df+jTwnd
 d3IrszZPrIWgfUDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739883468;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b85Aixuryvg216dGQZUo2otba+e/UFbPzPil1RVLtxE=;
 b=MyanvtbDxHd9Onjd01yqablM+mUNGomBMiGhacqM4HWit+YDOBEfgHneX59HaALk2vx6Qj
 MWUbxzUxhpBAUJWehXVuSxKrsV7AHUx4trRGO2wC5E6S9UXnRW8rN3brbe1P2V2hAusy8R
 4MvYNjWgbYJJuFtI4mWJgzZvplMG/Mk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739883468;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b85Aixuryvg216dGQZUo2otba+e/UFbPzPil1RVLtxE=;
 b=Yyij5lYKARpTKO+ZiUTDtPXm95h8Rwc0YJGDjnQE8UspgJRvmR58V5lOqEh6q/NzTADyWb
 +rzOAtiWFcQqlOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2492C13A1D;
 Tue, 18 Feb 2025 12:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ms5RB8yDtGe6QAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Feb 2025 12:57:48 +0000
Date: Tue, 18 Feb 2025 13:57:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250218125746.GC2469726@pevik>
References: <20250217215038.177250-1-jmoyer@redhat.com>
 <20250217215038.177250-4-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250217215038.177250-4-jmoyer@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,checkpatch.pl:url,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] tst_find_backing_dev(): add support for
 overlayfs
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


> Add checks for overlayfs in tst_find_backing_dev.  As with btrfs, only
> a single device is checked (the upper one) and returned from
> tst_find_backing_dev().

> The implementation uses both /proc/self/mountinfo and /proc/self/mounts.
> The former is used to map a device to a mountpoint, and the latter is
> used to get the file system options for the mountpoint.  All of the
> information is present in mountinfo, but the file format is more complex,
> and there are no glibc helpers for parsing it.

> The '#define _GNU_SOURCE' was added for the use of the strchrnul(3)
> function.

> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

> ---
> v3: Address review comments from Petr:
>     - Don't split long strings across lines
>     - use TST_OVERLAYFS_MAGIC instead of the kernel's definition
>     Note that I did not use SAFE_SSCANF, as tst_device.c uses the old
>     style safe macros, and that function is not covered.
> v2: Don't use libmount.  Instead, map from device number to mount-point
>     using /proc/self/mountinfo, and then use the mntent.h helpers to get
>     the mount options for the mountpoint from /proc/self/mounts.

LGTM, thanks for a very nice work!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I'd prefer others have look into it before merging.

Again, I'll apply minor formatting changes before merge (using SAFE_STAT(),
moving else branch after break to it's own and checkpatch.pl fixes).

Kind regards,
Petr

+++ lib/tst_device.c
@@ -575,7 +573,7 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
 
 static char *overlay_mount_from_dev(dev_t dev)
 {
-	unsigned dev_major, dev_minor, mnt_major, mnt_minor;
+	unsigned int dev_major, dev_minor, mnt_major, mnt_minor;
 	FILE *fp;
 	char line[PATH_MAX];
 	char *mountpoint;
@@ -627,6 +625,7 @@ static char *overlay_get_upperdir(char *mountpoint)
 				 mountpoint, mnt->mnt_type);
 
 		optstr = hasmntopt(mnt, "upperdir");
+
 		if (optstr) {
 			optstart = strchr(optstr, '=');
 			optstart++;
@@ -634,11 +633,11 @@ static char *overlay_get_upperdir(char *mountpoint)
 			upperdir = calloc(optend - optstart + 1, 1);
 			memcpy(upperdir, optstart, optend - optstart);
 			break;
-		} else {
-			tst_brkm(TBROK, NULL,
-				 "mount point %s does not contain an upperdir",
-				 mountpoint);
 		}
+
+		tst_brkm(TBROK, NULL,
+			 "mount point %s does not contain an upperdir",
+			 mountpoint);
 	}
 	endmntent(mntf);
 
@@ -679,26 +678,21 @@ static char *overlay_get_upperdir(char *mountpoint)
  */
 static void overlay_get_uevent_path(char *tmp_path, char *uevent_path)
 {
-	int ret;
 	struct stat st;
 	char *mountpoint, *upperdir;
 
 	tst_resm(TINFO, "Use OVERLAYFS specific strategy");
 
-	ret = stat(tmp_path, &st);
-	if (ret)
-		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
+	SAFE_STAT(NULL, tmp_path, &st);
 
 	mountpoint = overlay_mount_from_dev(st.st_dev);
 	upperdir = overlay_get_upperdir(mountpoint);
 	free(mountpoint);
 
-	ret = stat(upperdir, &st);
+	SAFE_STAT(NULL, upperdir, &st);
 	free(upperdir);
-	if (ret)
-		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
 
-	tst_resm(TINFO, "Warning: used first of multiple backing devices.");
+	tst_resm(TINFO, "WARNING: used first of multiple backing devices");
 	sprintf(uevent_path, "/sys/dev/block/%d:%d/uevent",
 		major(st.st_dev), minor(st.st_dev));
 }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
