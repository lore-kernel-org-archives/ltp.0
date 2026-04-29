Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062AFFF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 11:08:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 831543E49CB
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 13:08:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 540453C60F2
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 13:07:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 004FF600A7E
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 13:07:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E1595BD50;
 Wed, 29 Apr 2026 11:07:54 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BC71593B0;
 Wed, 29 Apr 2026 11:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ipb7CYrm8WnWGgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 29 Apr 2026 11:07:54 +0000
Date: Wed, 29 Apr 2026 13:07:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <afHkQ3kFW1PBSHU0@yuki.lan>
References: <20260429064011.3200745-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260429064011.3200745-1-wakel@google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3E1595BD50
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/userfaultfd: Handle ENOSYS in
 SAFE_USERFAULTFD
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
Cc: camann@suse.com, rbranco@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  include/lapi/userfaultfd.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
> index 0c9e34c84..09126d856 100644
> --- a/include/lapi/userfaultfd.h
> +++ b/include/lapi/userfaultfd.h
> @@ -244,6 +244,10 @@ static inline int safe_userfaultfd(const char *file, const int lineno, int
>  retry:
>  	ret = tst_syscall(__NR_userfaultfd, flags);
>  	if (ret == -1) {
> +		if (errno == ENOSYS) {
> +			tst_brk_(file, lineno, TCONF | TERRNO,
> +				"userfaultfd() is not supported by this kernel");
> +		}

The tst_syscall() code has already branch that checks for ENOSYS and
calls tst_brk(TCONF, ...) which looks like:

#define TST_SYSCALL_BRK__(NR, SNR) ({ \
tst_brk(TCONF, \
        "syscall(%d) " SNR " not supported on your arch", NR); \
})

#define tst_syscall(NR, ...) ({ \
intptr_t tst_ret; \
if (NR == __LTP__NR_INVALID_SYSCALL) { \
        errno = ENOSYS; \
        tst_ret = -1; \
} else { \
        tst_ret = syscall(NR, ##__VA_ARGS__); \
} \
if (tst_ret == -1 && errno == ENOSYS) { \
        TST_SYSCALL_BRK__(NR, #NR); \
} \
tst_ret; \
})

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
