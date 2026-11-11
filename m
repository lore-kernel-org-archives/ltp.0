Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE7606A324
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=T0JOk6DK;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=w93j5jK1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=T0JOk6DK;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=w93j5jK1
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DD713EA0DA
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 14:24:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4A393E265B
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 14:24:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3360E10000EA
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 14:24:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7ED862249D;
 Wed, 11 Nov 2026 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794403464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW9OjBW/8VeXY9vqqPx5fZ6bLoHXDqcnqvy9QXjSecQ=;
 b=T0JOk6DKDj7TbzwjSRlMyTpjPUeSo9TygvVGd+d1/nDBcIgR22Ec3ls5F2L+w4gsLq9wSB
 AcyA9pFrw4PWNl2tGHk9p36pUReMa4gjGf/eoyNYu3f6K6Q8533R/znJHKifavCF6AHSy7
 13xKTyhxWe0C+rX4R2ty4AzAz8RcqvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794403464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW9OjBW/8VeXY9vqqPx5fZ6bLoHXDqcnqvy9QXjSecQ=;
 b=w93j5jK1PBofk8tH4lxk5STfOwERWt18u/tD3Fmd9YoBOa+9Co8hvg5+l08G0pP+hVspbN
 zNBZM2z8JGazBiAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=T0JOk6DK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w93j5jK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794403464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW9OjBW/8VeXY9vqqPx5fZ6bLoHXDqcnqvy9QXjSecQ=;
 b=T0JOk6DKDj7TbzwjSRlMyTpjPUeSo9TygvVGd+d1/nDBcIgR22Ec3ls5F2L+w4gsLq9wSB
 AcyA9pFrw4PWNl2tGHk9p36pUReMa4gjGf/eoyNYu3f6K6Q8533R/znJHKifavCF6AHSy7
 13xKTyhxWe0C+rX4R2ty4AzAz8RcqvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794403464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW9OjBW/8VeXY9vqqPx5fZ6bLoHXDqcnqvy9QXjSecQ=;
 b=w93j5jK1PBofk8tH4lxk5STfOwERWt18u/tD3Fmd9YoBOa+9Co8hvg5+l08G0pP+hVspbN
 zNBZM2z8JGazBiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A39F1339F;
 Wed, 11 Nov 2026 13:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id thzABIhs9Gr/SwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Nov 2026 13:24:24 +0000
Date: Wed, 11 Nov 2026 14:24:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: berringtoni36@gmail.com
Message-ID: <20261111132418.GA747242@pevik>
References: <20261019-research-select-time64-rk3576-v1-1-a65d6b72e21f@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261019-research-select-time64-rk3576-v1-1-a65d6b72e21f@gmail.com>
X-Rspamd-Queue-Id: 7ED862249D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.71 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TAGGED_RCPT(0.00)[berringtoni36.gmail.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.71
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/select: use kernel timeval for _newselect
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Wenqiang Zhao via B4 Relay <devnull+berringtoni36.gmail.com@kernel.org>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wenqiang Zhao,

> With _TIME_BITS=64, struct timeval has 64-bit fields on 32-bit ARM,
> but _newselect still expects the old kernel timeval layout. Passing
> the libc structure directly makes a subsecond timeout appear as zero.

> Convert valid timeouts to struct __kernel_old_timeval before the syscall
> and copy the remaining time back afterwards. Pass NULL and deliberately
> faulty timeout pointers through unchanged.

> On an RK3576 running a 6.1.118-rt36 aarch64 kernel with CONFIG_COMPAT=y,
> the unmodified ARM32 time64 select02 reports 22 passes and 6 failures.
> With this change it reports 28 passes and no failures. Both runs skip
> the unsupported SYS_select variant.

> Tested select01-select04 on the same board with ARM32 time32, ARM32
> time64 and AArch64 static builds: 250 passes, 55 configuration skips,
> no failures or broken tests. Additional local checks cover timeout
> copy-back, ready fds, NULL, EFAULT, EINVAL and EINTR.

> Closes: https://github.com/linux-test-project/ltp/issues/1314

LGTM, thanks!

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
> ---
> syscalls/select: use kernel timeval for _newselect
> ---
>  testcases/kernel/syscalls/select/select_var.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
> index a945fa6..e23f1fa 100644
> --- a/testcases/kernel/syscalls/select/select_var.h
> +++ b/testcases/kernel/syscalls/select/select_var.h
> @@ -84,14 +84,30 @@ static int do_select_faulty_to(int nfds, fd_set *readfds, fd_set *writefds,
>  #endif
>  		return ret;
>  	}
> -	case 4:
> +	case 4: {
>  #ifdef __NR__newselect
> -		return tst_syscall(__NR__newselect, nfds, readfds, writefds, exceptfds, timeout);
> +		struct __kernel_old_timeval _tv;
> +		void *tv = timeout;
> +		int ret;
> +
> +		if (timeout && !faulty_to) {
> +			_tv.tv_sec = timeout->tv_sec;
> +			_tv.tv_usec = timeout->tv_usec;
> +			tv = &_tv;
> +		}
> +
> +		ret = tst_syscall(__NR__newselect, nfds, readfds, writefds, exceptfds, tv);
> +		if (timeout && !faulty_to) {
> +			timeout->tv_sec = _tv.tv_sec;
> +			timeout->tv_usec = _tv.tv_usec;
> +		}
> +		return ret;
>  #else
>  		tst_brk(TCONF, "__NR__newselect not implemented");
>  #endif
>  	break;
>  	}
> +	}

>  	return -1;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
