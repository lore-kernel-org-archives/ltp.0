Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6872BEB64D9
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 12:57:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BB163CE181
	for <ltp@archiver.kernel.org>; Tue, 27 Jun 2023 14:57:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C61EB3C99A6
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 14:57:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1929A600052
 for <ltp@lists.linux.it>; Tue, 27 Jun 2023 14:57:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79E0B21871;
 Tue, 27 Jun 2023 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687870626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJtKhNAyuuXo4RTfYwvnb6fkuhaEYzXfO6IggE8xCaE=;
 b=CtzLVlOJkbSQoL4282vWjUlzwbm8JmHP9K5hXa4XkO7UkjXL2PJwJ4ZLSjABxvr+RdlvXx
 sovJKYhysp3upy452UEQ+6jfi7aYopZyQaznwVvD82PagZZ0RnvE274GBgIwn26kZEr96M
 lDsbRURp6OAN+6b46p19fhxIq5ifYVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687870626;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJtKhNAyuuXo4RTfYwvnb6fkuhaEYzXfO6IggE8xCaE=;
 b=Jy+buLHINCsjml4HJFZX3ODiL/cXhbLfq3ROwCgiO+ISlzDaSLuv+zuHeaD6/xGreWk0BT
 eYWIeT2a1tgqTjAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25BA913276;
 Tue, 27 Jun 2023 12:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NpMLB6LcmmQEWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jun 2023 12:57:06 +0000
Date: Tue, 27 Jun 2023 14:57:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Randolph Lin <randolph@andestech.com>
Message-ID: <20230627125704.GA36835@pevik>
References: <20230627105334.2358121-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230627105334.2358121-1-randolph@andestech.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/prctl04: Allow __NR_waitid in the
 syscall filter
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
Cc: minachou@andestech.com, tim609@andestech.com, kester.tw@gmail.com,
 ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Randolph,

> From: Randolph <randolph@andestech.com>

> The __NR_wait4 syscall is not available in y2038 safe 32-bit systems,
> waitid should be used instead. In the 32ABI system, the __NR_waitid
> must be allowed as well in the filter.

Acked-by: Petr Vorel <pvorel@suse.cz>
LGTM, thanks!

Kind regards,
Petr

> refer:
> https://sourceware.org/git/gitweb.cgi?p=glibc.git;h=9b2cf9482a9397c4711c9e7f42f8d718b6306bdc
> linux: Use waitid on wait4 if __NR_wait4 is not defined

> Signed-off-by: Randolph <randolph@andestech.com>
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
>  testcases/kernel/syscalls/prctl/prctl04.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
> index f6e1f0fea..8b135d611 100644
> --- a/testcases/kernel/syscalls/prctl/prctl04.c
> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
> @@ -45,6 +45,7 @@
>  static const struct sock_filter  strict_filter[] = {
>  	BPF_STMT(BPF_LD | BPF_W | BPF_ABS, (offsetof(struct seccomp_data, nr))),

> +	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_waitid, 7, 0),
>  	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_rt_sigprocmask, 6, 0),
>  	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_close, 5, 0),
>  	BPF_JUMP(BPF_JMP | BPF_JEQ, __NR_exit,  4, 0),

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
