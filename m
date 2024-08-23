Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B603C52D7C
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 12:02:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEAC83CF762
	for <ltp@archiver.kernel.org>; Fri, 23 Aug 2024 14:02:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 278AF3CF762
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 14:02:16 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3AE94200C70
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 14:02:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B248022677;
 Fri, 23 Aug 2024 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724414534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BcgzIPfw22XfyANRF4gzX2Zv9MsN0nRWQMXoT56qQ6A=;
 b=pjgw0gi2P6anUpbt6w42WXHyCwdLkwENNMYfshClmXyGM5DMDJLqHgej3pYXA8HgUnNgc3
 HRnWMOpA7ZLrshg6RTr116Kx7Eh2QTnDqxNKUATWPaM57YVIZ8YTidkkRSvIWD8hpoiuXk
 W9PvBgqo1FKt0+ApnVkyMF19up/Unw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724414534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BcgzIPfw22XfyANRF4gzX2Zv9MsN0nRWQMXoT56qQ6A=;
 b=xqjPTp8j3YC9MYqCOvxHdfhUWH49+2rjLaffqkOGhFVTfG5F0tC+CRwrfXCZNIVzGsWqwZ
 v50Knfdwt4IOOOAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pjgw0gi2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xqjPTp8j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724414534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BcgzIPfw22XfyANRF4gzX2Zv9MsN0nRWQMXoT56qQ6A=;
 b=pjgw0gi2P6anUpbt6w42WXHyCwdLkwENNMYfshClmXyGM5DMDJLqHgej3pYXA8HgUnNgc3
 HRnWMOpA7ZLrshg6RTr116Kx7Eh2QTnDqxNKUATWPaM57YVIZ8YTidkkRSvIWD8hpoiuXk
 W9PvBgqo1FKt0+ApnVkyMF19up/Unw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724414534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BcgzIPfw22XfyANRF4gzX2Zv9MsN0nRWQMXoT56qQ6A=;
 b=xqjPTp8j3YC9MYqCOvxHdfhUWH49+2rjLaffqkOGhFVTfG5F0tC+CRwrfXCZNIVzGsWqwZ
 v50Knfdwt4IOOOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 557C11398B;
 Fri, 23 Aug 2024 12:02:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xfpDC0Z6yGYlSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 23 Aug 2024 12:02:14 +0000
Date: Fri, 23 Aug 2024 14:02:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20240823120208.GC1247674@pevik>
References: <20240821080808.3311245-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240821080808.3311245-1-maxj.fnst@fujitsu.com>
X-Rspamd-Queue-Id: B248022677
X-Spamd-Result: default: False [-3.70 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.939]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kcmp: Convert docs to docparse
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

Hi Ma,

> +++ b/testcases/kernel/syscalls/kcmp/kcmp02.c
...
> - /* Description:
> - *   Verify that:
> - *		1) kcmp fails with bad pid
> - *		2) kcmp fails with invalid flag
> - *		3) kcmp fails with invalid flag
> - *		4) kcmp fails with invalid flag
> - *		5) kcmp fails with invalid flag
> - *		6) kcmp fails with invalid fd
> +/*\
> + * [Description]
> + *
> + * Verify that, kcmp() returns -1 and sets errno to
> + *
> + * 1. ESRCH if pid does not exist
> + * 2. EINVAL if type is invalid
> + * 3. EINVAL if type is invalid
> + * 4. EINVAL if type is invalid
> + * 5. EINVAL if type is invalid
4x EINVAL, it would be better to describe how they differs.
Obviously KCMP_TYPES (the last item in enum kcmp_type in
include/uapi/linux/kcmp.h) should not be used in userspace (it's not in man
page). Other wrong values are -1 (negative), INT_MIN (negative) and INT_MAX too high.

Or, if you don't want to bother with the description, you could wrote:

* 1. ESRCH if pid does not exist
* 2-5. EINVAL if type is invalid
* 5. EINVAL if type is invalid
* 6. EBADF if fd is invalid

Kind regards,
Petr

> + * 6. EBADF if fd is invalid
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
