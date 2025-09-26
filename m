Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70F0CAC5AC
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 08:17:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 699243CE08B
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 10:17:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B8C23CDDE3
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:17:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1EFC1400420
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:17:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2071D24998;
 Fri, 26 Sep 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758874625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zm8HTlRRwdWhwAFRiWG2XYSfrYxWqS/yEtsD1hiURI=;
 b=OmFyeXLD+9JlaibphfC3YCZxRtNWfUpJ5h6s/MthpHSfep4RZVKvmk6yL9IPYq7jswu2ui
 YsRgO5WJEtkA4CylYMwr8NUgZ6tbFji24T6aSdHa5ly0g67b6HJ74KSP6EkIFDzaBoLfq0
 ypUf60C6icqr3UxGAMttgjZWm8n+iO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758874625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zm8HTlRRwdWhwAFRiWG2XYSfrYxWqS/yEtsD1hiURI=;
 b=trLc7wvNJWVm898swS+Yee2a/hMjR6BLEMZtLxTJKbLtlMDT8R/KUuLku6bLnqWAJAtRCc
 RJYar/ngfivgoGBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iUfgwz5X;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xXHv1bw0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758874624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zm8HTlRRwdWhwAFRiWG2XYSfrYxWqS/yEtsD1hiURI=;
 b=iUfgwz5XCcZKcHzkalXz0tORV9vl3qmgcxz83C4+DlJp0QpZJDPtPkk6kcp5uENmnXAjOi
 E3uvNWJso6qz2zAiDhUYFKkPwGgkMHQJ/MUa9vkUolYirRsxrU7ShcrSLGLFGdoxHYMTO9
 QdRFr51w/t/YEryOISQn6sPsw+QEyZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758874624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zm8HTlRRwdWhwAFRiWG2XYSfrYxWqS/yEtsD1hiURI=;
 b=xXHv1bw0/TNjIiDIiebLUuIoPbJ3ymNHjxdafyDxmOS4fKWJp1Tz1kyeaFvTMV/q4iBHEO
 7xnHeheJoGLVi6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01C0F1373E;
 Fri, 26 Sep 2025 08:17:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p/weAABM1mhbcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Sep 2025 08:17:03 +0000
Date: Fri, 26 Sep 2025 10:17:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aNZMLUDAxLp2DAy-@yuki.lan>
References: <20250926040707.671282-1-jmorgan@naotchy.com>
 <20250926040707.671282-2-jmorgan@naotchy.com>
 <4d514eb9-cf7e-430e-a0ad-dfffdf947fcc@suse.com>
 <ab2c81a0-2ae8-48c5-ac28-cdb6d4ed347f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab2c81a0-2ae8-48c5-ac28-cdb6d4ed347f@suse.com>
X-Rspamd-Queue-Id: 2071D24998
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statmount09.c: Enable mnt_ns_id for
 STATMOUNT_MNT_NS_ID
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> FYI this patch might be needed for the release, since it's breaking the 
> build on old kernels before 09b31295f833031c88419550172703d45c5401e3 
> commit. What do you think?

Yes, this is one of the fixes that should go in.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
