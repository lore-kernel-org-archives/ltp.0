Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77310C5B559
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 10:34:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDF0B3C9BD0
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 12:34:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACDBF3C9AF0
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 12:34:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2EAF51A007EB
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 12:34:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE4551F38E;
 Fri,  6 Jun 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD18F1369F;
 Fri,  6 Jun 2025 10:34:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oUj9KCnEQmh3MgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 10:34:17 +0000
Date: Fri, 6 Jun 2025 12:34:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250606103412.GA1289709@pevik>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-3-0b5cff90c21c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605-conversions-mknod-v5-3-0b5cff90c21c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: DE4551F38E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/8] syscalls/mknod03: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo, all,

...
> -	/*
> -	 * Set the effective group id and user id of the test process
> -	 * to that of guest user (nobody)
> -	 */
> -	SAFE_SETGID(cleanup, group1_gid);
> -	if (setreuid(-1, user1_uid) < 0) {
> -		tst_brkm(TBROK, cleanup,
> -			 "Unable to set process uid to that of ltp user");
> -	}
> -
> -	/* Save the real group ID of the current process */
> -	mygid = getgid();
> -
> -	/* Change directory to DIR_TEMP */
> -	SAFE_CHDIR(cleanup, DIR_TEMP);
> +	SAFE_SETGID(nobody_gid);
> +	SAFE_SETREUID(-1, nobody_uid);
>  }

> -/*
> - * cleanup() - Performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *	Print test timing stats and errno log if test executed with options.
> - *	Restore the real/effective user id of the process changed during
> - *	setup().
> - *	Remove temporary directory and sub-directories/files under it
> - *	created during setup().
> - *	Exit the test program with normal exit code.
> - */
> -void cleanup(void)
> -{
> -
> -	/*
> -	 * Restore the effective uid of the process changed in the
> -	 * setup().
> -	 */
> -	if (setreuid(-1, save_myuid) < 0) {
> -		tst_brkm(TBROK, NULL,
> -			 "resetting process real/effective uid failed");
> -	}

+1 for avoiding restoring UID in cleanup (I also think that while setreuid(-1,
nobody_uid) in setup is a subject of testing thus needed, restoring UID is
indeed *not* needed. IMHO this is often done i real programs which gain root
in setuid, but that's not the case).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
