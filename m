Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3D3C5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 12:41:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 860BD3D1929
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 13:41:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CD633CC6C8
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 13:41:32 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E17EE14001FA
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 13:41:31 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C92620380;
 Fri,  1 Mar 2024 12:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709296890;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xc5HOze6PbjJbVc+axJnU1LG00c35Ud3YaTEeIKBMrQ=;
 b=PuhH5Q2dNdC/BnJLVzUg5tDtTTtgg8FoYQl5/uh6sSR5cW/e0S8cBUS6Kcxeq9nzXvo3Hi
 p8hP9JzjBLjY1B8Pw0nM+BEegFkzkL58hfw1D5usGjeYrwF3I1GYy/9y+ilGmNoJM53D2L
 0G/FByjXNEHs+10Nz0FoXN/6QYTBeO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709296890;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xc5HOze6PbjJbVc+axJnU1LG00c35Ud3YaTEeIKBMrQ=;
 b=2ZjYdqLK6GsdKwTXImOQA3/sMn+2KNqpBZVDIMIuZVZVE7+2oprbXIhiOjy7mPT5qR5vSB
 XLY6n2bvA1T8D9Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709296890;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xc5HOze6PbjJbVc+axJnU1LG00c35Ud3YaTEeIKBMrQ=;
 b=PuhH5Q2dNdC/BnJLVzUg5tDtTTtgg8FoYQl5/uh6sSR5cW/e0S8cBUS6Kcxeq9nzXvo3Hi
 p8hP9JzjBLjY1B8Pw0nM+BEegFkzkL58hfw1D5usGjeYrwF3I1GYy/9y+ilGmNoJM53D2L
 0G/FByjXNEHs+10Nz0FoXN/6QYTBeO0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709296890;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xc5HOze6PbjJbVc+axJnU1LG00c35Ud3YaTEeIKBMrQ=;
 b=2ZjYdqLK6GsdKwTXImOQA3/sMn+2KNqpBZVDIMIuZVZVE7+2oprbXIhiOjy7mPT5qR5vSB
 XLY6n2bvA1T8D9Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B5ED13A39;
 Fri,  1 Mar 2024 12:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id BBTfG/rM4WV4SAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Mar 2024 12:41:30 +0000
Date: Fri, 1 Mar 2024 13:41:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: xuwenjie04 <xuwenjie04@baidu.com>
Message-ID: <20240301124129.GE1661970@pevik>
References: <EF89BFA1-4088-4497-B0C3-788743AAED3C@baidu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <EF89BFA1-4088-4497-B0C3-788743AAED3C@baidu.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PuhH5Q2d;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2ZjYdqLK
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 BAYES_SPAM(0.00)[19.67%]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9C92620380
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pipe/pipe15.c: Adjust fd check for pipe creation
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

HI Wenjie, Marius,

> A pipe occupies 2 fds, and considering 3 standard fds,
> we should compare rlim_max with such *2+3 calculated value
> to verify whether the maximum file descriptor configuration
> of the current machine is sufficient.

Indeed, 1024*2+3 is the lowest number which passes with non-default ulimit:

ulimit -n $((1024*2+3)) && ./pipe15

Therefore I merged, thank you!

BTW I wonder how did you encounter this?

@Marius FYI I also fixed SIGSEGV when low ulimit, see
https://github.com/linux-test-project/ltp/commit/fc6adb8454df34fa87b462844b740cc3a0b84caa

> Signed-off-by: Wenjie Xu <xuwenjie04@baidu.com>
> ---
> testcases/kernel/syscalls/pipe/pipe15.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/pipe/pipe15.c b/testcases/kernel/syscalls/pipe/pipe15.c
> index c85ad1820..9e02fe2eb 100644
> --- a/testcases/kernel/syscalls/pipe/pipe15.c
> +++ b/testcases/kernel/syscalls/pipe/pipe15.c
> @@ -59,7 +59,7 @@ static void setup(void)
>       tst_res(TINFO, "Creating %i pipes", pipe_count);

>       SAFE_GETRLIMIT(RLIMIT_NOFILE, &nfd);
> -     if (nfd.rlim_max < (unsigned long)pipe_count)
> +    if (nfd.rlim_max < (unsigned long)pipe_count * 2 + 3)
nit: you mixed tabs with spaces or broke indent. And patch was not applicable
(even before my changes), therefore I needed to do the changes myself and thus I
put my fix fc6adb845 ("pipe15: Avoid SIGSEGV in cleanup") before.

Kind regards,
Petr

>              tst_brk(TCONF, "NOFILE limit max too low: %lu < %i", nfd.rlim_max, pipe_count);
>       if (nfd.rlim_cur < nfd.rlim_max) {
>              nfd.rlim_cur = nfd.rlim_max;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
