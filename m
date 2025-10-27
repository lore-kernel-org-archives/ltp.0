Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E293CCF9EA
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 09:22:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9418C3CF4F4
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 10:22:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEDF43CBB88
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 10:22:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 400931A00667
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 10:22:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2FAE421A64;
 Mon, 27 Oct 2025 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761556929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6aX5BhAQLtYw6kC/E43QeUwnojFYCESwL09Zqj3yi8=;
 b=Y311SU1HXawTVx1dvWJ4pF3DN3i5V0nhvYC0P704GNhtCteSr4DYFXEbMwG9NCU2V5EVhY
 uadhpHbQBSCCU0HbwviLlJBieQn+aoz/YfELW6FwxzCALQh3K4dKPStYSNwZql/XChMdtB
 cM+nX6yq0odSmD1a7PgeLV/fMK+AfuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761556929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6aX5BhAQLtYw6kC/E43QeUwnojFYCESwL09Zqj3yi8=;
 b=hUOS995cFLTLS5Fk561FlM9zyrI77tYVysCrzT+1OWKnQEYELipcJcMzh4elrfw8cSfCLU
 mR6OPs+CIsmLGvBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761556929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6aX5BhAQLtYw6kC/E43QeUwnojFYCESwL09Zqj3yi8=;
 b=Y311SU1HXawTVx1dvWJ4pF3DN3i5V0nhvYC0P704GNhtCteSr4DYFXEbMwG9NCU2V5EVhY
 uadhpHbQBSCCU0HbwviLlJBieQn+aoz/YfELW6FwxzCALQh3K4dKPStYSNwZql/XChMdtB
 cM+nX6yq0odSmD1a7PgeLV/fMK+AfuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761556929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m6aX5BhAQLtYw6kC/E43QeUwnojFYCESwL09Zqj3yi8=;
 b=hUOS995cFLTLS5Fk561FlM9zyrI77tYVysCrzT+1OWKnQEYELipcJcMzh4elrfw8cSfCLU
 mR6OPs+CIsmLGvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B83F136CF;
 Mon, 27 Oct 2025 09:22:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oWpSBcE5/2jrVQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 27 Oct 2025 09:22:09 +0000
Date: Mon, 27 Oct 2025 10:21:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <aP85jhbSvlYxeOiQ@rei>
References: <20251024125613.2340799-1-anders.roxell@linaro.org>
 <20251024133035.GA590258@pevik> <aPu2lqXN8G7h4e7D@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aPu2lqXN8G7h4e7D@stanley.mountain>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] file_attr02: Add XFS kernel config requirement
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
Cc: ltp@lists.linux.it, benjamin.copeland@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I wonder why tst_get_supported_fs_types() from lib/tst_supported_fs_types.c did
> > not detect it. Could you please post whole output?
> > 
> > Because if code in struct tst_test.filesystems does not work, many tests would
> > be affected with this setup. I'm probably missing something, but I'd prefer to
> > fix the detection in the library than force config (we don't have any CONFIG_.*_FS
> > in testcases/).

I think that we have a but in the test library, it looks like we do not
check for the kernel support if we have only one filesystem defined in
the tst_test.filesystems.

The problem is that we are trying to avoid formatting and mounting the
filesystem for each test iteration (if -i 10 is passed) but that means
that we skip the filesystem kernel support. We only check for mkfs in
the setup and prepare the device.

This should fix it:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index b8894f782..d49f34623 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1530,6 +1530,10 @@ static void do_setup(int argc, char *argv[])
                tdev.fs_type = default_fs_type();

                if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
+
+                       if (!tst_fs_is_supported(tdev.fs_type))
+                               tst_brk(TCONF, "The %s filesystem is not supported", tdev.fs_type);
+
                        if (tst_test->filesystems && tst_test->filesystems->mkfs_ver)
                                tst_check_cmd(tst_test->filesystems->mkfs_ver, 1);


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
