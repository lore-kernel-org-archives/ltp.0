Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAFDD597B6
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 23:07:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C0173D6327
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 00:07:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12AE63D6318
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 00:06:56 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 646CE1414C39
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 00:06:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB7921F788;
 Tue, 12 Nov 2024 23:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731452814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LRvlti8OuzAEsrHXSFrZAdzVE87zUdI+bWX9Gf9qPxo=;
 b=S337cIcowPQLevi2QDcr/lrp0rXrrLQoHGNV39ynEDgM5B2w0jASM8BkrVPJeyAkJi9oqo
 JgUS3chh2d0HJseCZsZzCa3NP9H92xBsXhnGb5ODtbZdmPA7K/fbGDAjMZKSe8caSS4ory
 8w2ESpIK2IlTL4a6f4Fl6Sf4uPds0ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731452814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LRvlti8OuzAEsrHXSFrZAdzVE87zUdI+bWX9Gf9qPxo=;
 b=uwfr2krI2GBDVwsxlg876kwESaXm2hHhXGmqLBvmCafIy+sCPwgblyYsonLDURgwi1fabO
 WV5JkGA+bw70sACQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=S337cIco;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uwfr2krI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731452814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LRvlti8OuzAEsrHXSFrZAdzVE87zUdI+bWX9Gf9qPxo=;
 b=S337cIcowPQLevi2QDcr/lrp0rXrrLQoHGNV39ynEDgM5B2w0jASM8BkrVPJeyAkJi9oqo
 JgUS3chh2d0HJseCZsZzCa3NP9H92xBsXhnGb5ODtbZdmPA7K/fbGDAjMZKSe8caSS4ory
 8w2ESpIK2IlTL4a6f4Fl6Sf4uPds0ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731452814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LRvlti8OuzAEsrHXSFrZAdzVE87zUdI+bWX9Gf9qPxo=;
 b=uwfr2krI2GBDVwsxlg876kwESaXm2hHhXGmqLBvmCafIy+sCPwgblyYsonLDURgwi1fabO
 WV5JkGA+bw70sACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93F0C13301;
 Tue, 12 Nov 2024 23:06:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HG7qIo7fM2ckEAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Nov 2024 23:06:54 +0000
Date: Wed, 13 Nov 2024 00:06:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20241112230649.GA264085@pevik>
References: <20240827061106.350609-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240827061106.350609-1-maxj.fnst@fujitsu.com>
X-Rspamd-Queue-Id: AB7921F788
X-Spamd-Result: default: False [-3.70 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.945]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; REPLYTO_EQ_FROM(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kcmp: Convert docs to docparse
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

Hi Ma Xinjian,

...
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp02.c b/testcases/kernel/syscalls/kcmp/kcmp02.c
> +/*\
> + * [Description]
> + *
> + * Verify that, kcmp() returns -1 and sets errno to
> + *
> + * 1. ESRCH if pid does not exist
> + * 2. EINVAL if type is invalid (it's not in man page)
> + * 3. EINVAL if type is invalid (it's a negative number, -1)
> + * 4. EINVAL if type is invalid (it's a negative number, the smallest integer)
> + * 5. EINVAL if type is invalid (it's too high, the largest integer)
> + * 6. EBADF if fd is invalid
I slightly changed this and merged.

IMHO it's better to use "file descriptor" then just fd (although it's obvious,
let's be more formal). OTOH we can use commonly used constants (INT_MAX, ...)
instead of "the largest integer").

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
