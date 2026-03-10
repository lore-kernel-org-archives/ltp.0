Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FB2FD2D79
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 13:25:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43F483E57F5
	for <ltp@archiver.kernel.org>; Tue, 10 Mar 2026 14:25:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2008E3CA670
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 14:25:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 774752000CE
 for <ltp@lists.linux.it>; Tue, 10 Mar 2026 14:25:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C851C5BCD5;
 Tue, 10 Mar 2026 13:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773149124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXnnkc5/+l2YfMJpv9lKwNBJMeRbM4dqy2leecld5hw=;
 b=oXAsp9K5aQdopURq5PHymkqJPSs5lN/ZCkVZYLFcWhUd0Gu7EzhUB1aOpXbiFpFMsYA3rQ
 5G+A8K4qAQbmH3k68/ffkQxTF7YyPI7GPepdCfNjvmpokrs84VbVKLQIf/3vE61FgKLGdh
 Eg7tBOT9H7J6C9WNszjvh77jqV0uMms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773149124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXnnkc5/+l2YfMJpv9lKwNBJMeRbM4dqy2leecld5hw=;
 b=4KPnaylmEfaEvy74tmgkKw3hYbAlJOXXqxGX+j2EgbCE6pxjg6jXbqa4s+wA+ZpM2z+flc
 PhjCBwmGpmCdGsDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m+EKvm+I;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hKdHJCyG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773149123;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXnnkc5/+l2YfMJpv9lKwNBJMeRbM4dqy2leecld5hw=;
 b=m+EKvm+IrYfLCRSqnzNougreWMraTNCAokLQGtAVo+reKSHg6/7J/hMbf34sNubOp+VWbY
 lh+sr103CdjtGPIHRlWCYDY1tBJoTsGqE28rR1ULKnlEiskG0kuIQL2LWyBEPmIZngOGc/
 44nbnXavkJloPW2fxCdDjXSCjrJy3TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773149123;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXnnkc5/+l2YfMJpv9lKwNBJMeRbM4dqy2leecld5hw=;
 b=hKdHJCyGtXeS97Z4BIb94mfQBswh0YTZIwcuHIVRwEIbUekZrvkwf6jmxqsoe1l4jXw6pK
 cLyF6prXD6Rb4EAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA3B43F495;
 Tue, 10 Mar 2026 13:25:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RxoJKMMbsGkyUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Mar 2026 13:25:23 +0000
Date: Tue, 10 Mar 2026 14:25:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260310132522.GD39882@pevik>
References: <20260309172057.272946-1-japo@linux.ibm.com>
 <20260309172057.272946-2-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260309172057.272946-2-japo@linux.ibm.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C851C5BCD5
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/3] fsetxattr02: Adapt test for kernel 7.0+
 socket xattr support
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

Hi Jan,

> Starting with kernel 7.0.0, sockets support extended attributes in the
> user.* namespace. This behavior was enabled by dc0876b9846d ("xattr: support
> extended attributes on sockets"), which permits user.* xattrs on S_IFSOCK
> inodes (previously rejected with -EPERM).

Good catch, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Adapts the test to expect success (exp_err = 0) instead of EPERM when
> testing fsetxattr(2) on sockets with kernel 7.0+.

> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
> index 18490a865871..ede86b218ee6 100644
> --- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
> +++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
> @@ -158,6 +158,10 @@ static void verify_fsetxattr(unsigned int i)
>  	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
>  		tst_brk(TCONF, "fsetxattr(2) not supported");

> +	/* consider newer kernels */
very nit: The commit is obvious. If anything to add, I would add the git hash itself.

Kind regards,
Petr

> +	if ((tst_kvercmp(7, 0, 0) >= 0) && (strncmp(tc[i].fname, SOCK, strlen(SOCK)) == 0))
> +		tc[i].exp_err = 0;
> +
>  	/* success */

>  	if (!tc[i].exp_err) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
