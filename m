Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB56C282D1
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 18:06:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCAF03C9FDE
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 19:06:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCF823C9FA3
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 19:06:39 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2D6812002BA
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 19:06:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BE60C211AD;
 Thu,  6 Mar 2025 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741284398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6nS2MCg/b+11wdRmHgzkVtSljb8tlDErVLvuVBXpqg=;
 b=0tR1MbvDlXw3MR/eGCGx3Rn3pUiCkvWM71eX+xlCMb2K8AA0tYRi/BC3y3+KPLTkgKeSRS
 CEHtPT5R7eBditKNNizMe44cTArirhFMA8pP+kzlrQPoF2fNv25+bQoVvp8EuJ5A5vftJi
 EYBVXVGeWzZkdxUvOJj1a5QWJcWYy40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741284398;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6nS2MCg/b+11wdRmHgzkVtSljb8tlDErVLvuVBXpqg=;
 b=UgBRQ1hHrpiZbkjdsqnMPbwPB5oZoMelwSTuCXlV0wAW+0IVGshbwT5+S5mxKJaYogi1fZ
 N52B4a8oNv7P4GDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gH2Punnk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vtbQd1yy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741284396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6nS2MCg/b+11wdRmHgzkVtSljb8tlDErVLvuVBXpqg=;
 b=gH2PunnkLJtn1VLZwbNcHFHcoC/MpvrWFg97LxVIvu28JQW7uYrb1Oc2IRtavBTfqOuVl2
 vuJi0PQR4hXVQsbHQW2ScEy/JjRrDwsc3t8DxRBbBe2SmLdySLAL2uOULkua69KdCmupMQ
 33y8psncmMfCXjQRacgO9PFIlC0MFHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741284396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A6nS2MCg/b+11wdRmHgzkVtSljb8tlDErVLvuVBXpqg=;
 b=vtbQd1yyf2EHblXNsb7eEi5/lwWh0/YsP4RJcyA+4dJm2mtvyvtC0e/8TnQPGX6m8Oq26U
 tB6PfZBSZhAtKkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 906EF13676;
 Thu,  6 Mar 2025 18:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C6/OISzkyWexRwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Mar 2025 18:06:36 +0000
Date: Thu, 6 Mar 2025 19:06:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250306180631.GA214761@pevik>
References: <x491pvczdfd.fsf@segfault.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x491pvczdfd.fsf@segfault.usersys.redhat.com>
X-Rspamd-Queue-Id: BE60C211AD
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4]: tst_find_backing_dev(): add support for
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

Hi Jeff, Cyril,

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
> v4: Address review comments from Petr:
>     - s/unsigned/unsigned int/
>     - string formatting
>     - code simplification: remove else block
>     - use SAFE_STAT
>     Address review comments from Cyril:
>     - s/PATH_MAX/4096
>     - string formatting fixes
>     - use strcmp() instead of strncmp() to prevent false matching
>     - don't re-implement strndup

LGTM. I leave where overlay_mount_from_dev() should be called up to Cyril.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
