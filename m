Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DFCF8D755
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 18:40:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64DB73E7534
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 20:40:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A4E43E74F9
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:39:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF20F2000C6
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:39:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D1F36A811;
 Thu, 16 Apr 2026 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776364794;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mApZ5q/lt6uNCvdorCLcdUW7NqlpZZbWUC7NA8ai7Q=;
 b=Ev9lkYIPXaSMVup7Ayz6qFmyVvzUWc8CMUZwtEvRbi+U+H9QwimaZ/a1pWoWzHQ/ULexs4
 ri4NarFwBsYPFMFk7wVp/kkCAPSl87cmLiWLbqMfEDLAPGgmpJhGGfvZnOH8u3cvcX95vK
 zU9I9Krwz7FAlutG1cg0uXCex608vPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776364794;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mApZ5q/lt6uNCvdorCLcdUW7NqlpZZbWUC7NA8ai7Q=;
 b=jWiuuD9F8dufNU7SdBQNul2I0x1A5syuaMQwwO77Mv5ZI7VXs6jbx9B3T78eLyGIyJXsjK
 tZOvgVTpJMbkd4Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ev9lkYIP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jWiuuD9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776364794;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mApZ5q/lt6uNCvdorCLcdUW7NqlpZZbWUC7NA8ai7Q=;
 b=Ev9lkYIPXaSMVup7Ayz6qFmyVvzUWc8CMUZwtEvRbi+U+H9QwimaZ/a1pWoWzHQ/ULexs4
 ri4NarFwBsYPFMFk7wVp/kkCAPSl87cmLiWLbqMfEDLAPGgmpJhGGfvZnOH8u3cvcX95vK
 zU9I9Krwz7FAlutG1cg0uXCex608vPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776364794;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7mApZ5q/lt6uNCvdorCLcdUW7NqlpZZbWUC7NA8ai7Q=;
 b=jWiuuD9F8dufNU7SdBQNul2I0x1A5syuaMQwwO77Mv5ZI7VXs6jbx9B3T78eLyGIyJXsjK
 tZOvgVTpJMbkd4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AEA4593A3;
 Thu, 16 Apr 2026 18:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uyt8CPos4WlqCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 18:39:54 +0000
Date: Thu, 16 Apr 2026 20:39:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260416183947.GC303991@pevik>
References: <20260415044641.97806-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260415044641.97806-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4D1F36A811
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_kexec.sh: Use %s in printf to prevent
 evaluating cmdline backslashes
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

Hi Avinesh,

> On systemd-boot systems, the kernel command line contains EFI paths
> with backslashes (e.g., `initrd=\opensuse...\6.19...`).

> Writing this to a file using `printf "$cmdline"` inadvertently evaluates
> these backslashes as escape sequences, corrupting the expected digest
> and causing a false test failure:

>   + printf 'initrd=\opensuse-tumbleweed\6.19.11-1-default\initrd-...'
>   + cat -v file1
>   initrd=\opensuse-tumbleweed^F.19.11-1-default\initrd-...

>   ima_kexec 1 TINFO: testing kexec -s -l /boot/Image-6.19.11-1-default --reuse-cmdline
>   ima_kexec 1 TFAIL: unable to find a correct measurement

> Fix this by using `printf "%s" "$cmdline"` to ensure the command line
> is treated as literal data.

Thanks a lot, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
