Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B1CCD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:40:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C2A793E4E38
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:40:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 297B53E2238
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:40:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A8EAE200B60
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 09:40:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEFBD6CA48;
 Tue, 16 Jun 2026 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781595635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5s/GWpaXe+XlE+LQNLP69Y6/tsi7GvPZ+/nM7XpRMT4=;
 b=hOLHC8h3QfrJA+pQ54ivcWSPNofqfCCnL3rSaYV8KywnBT4rhBUTz5BM0T999N48A38b+T
 FNy1BzaPWlWJUj1d5DScbhI5tceZrAoq1le4YEePpbJHhrq7RMJLybuAXLNgbLxfsqe9my
 S7U1Zb369WDFBSuXuQVf4T5p0mzT7gM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781595635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5s/GWpaXe+XlE+LQNLP69Y6/tsi7GvPZ+/nM7XpRMT4=;
 b=Qm00UE0JV2uoNl97oDLIcfSfUaosiB6WnGlIcnVqCgbiXlo3F/kacCFVZK7tBS8cZpojav
 VmBQGVuPt2HpBZBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781595633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5s/GWpaXe+XlE+LQNLP69Y6/tsi7GvPZ+/nM7XpRMT4=;
 b=Pa5s+hbBmUbmvO+lF6FogiXhLVHVaxvrRSz/TIE54ueHUZ0zvneaX1oUp/WS/LCMPyXbr5
 coQh8HYZCayBCLEFkT8dIWSi2QGCP0UQO9INq9K95Mnsj3ZMat8FlxasZTWzVhYqlq3MUu
 p0T9V49msqneoWjO33MU9v+O0nt3sJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781595633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5s/GWpaXe+XlE+LQNLP69Y6/tsi7GvPZ+/nM7XpRMT4=;
 b=VPI1z5cbYV+DnlGw0OsxaQ1YQnPDdIWJfKGThOGz3EaByd2k9JYEcNio3/4HjZC4O+nV2X
 t1qQCLshpogs+hAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C65E3779A8;
 Tue, 16 Jun 2026 07:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ivVnMPH9MGq4SAAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 16 Jun 2026 07:40:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 5AE95A12D3; Tue, 16 Jun 2026 09:40:29 +0200 (CEST)
Date: Tue, 16 Jun 2026 09:40:29 +0200
From: Jan Kara <jack@suse.cz>
To: AnonymeMeow <anonymemeow@gmail.com>
Message-ID: <ate4q7znqlhitd4y5wsrxx2rtq7u6btfeheep6svgvw5zhtbbn@y7cau7ke55ij>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
 <20260615180629.7148-2-anonymemeow@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615180629.7148-2-anonymemeow@gmail.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,lists.linux.it];
 RCVD_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fanotify20: Allow FAN_REPORT_PIDFD with
 FAN_REPORT_TID on v7.2+
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
Cc: amir73il@gmail.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 16-06-26 02:06:25, AnonymeMeow wrote:
> fanotify_init() used to reject FAN_REPORT_PIDFD combined with
> FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
> reporting pidfds for thread IDs, so this combination is expected to
> succeed.
> 
> Keep expecting EINVAL on older kernels and adjust the test expectation
> based on the running kernel version.
> 
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Thanks for the fixes! Some comment below. And take your time with final
exams, that's more important than some failing LTP tests :)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index b32ecf6aa..9a78f6ff0 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -8,13 +8,14 @@
>  
>  /*\
>   * This source file contains a test case which ensures that the
> - * :manpage:`fanotify(7)` API returns an expected error code when provided an
> - * invalid initialization flag alongside FAN_REPORT_PIDFD. Additionally, it
> - * checks that the operability with existing FAN_REPORT_* flags is maintained
> - * and functioning as intended.
> + * :manpage:`fanotify(7)` API returns an expected error code when provided
> + * unsupported initialization flags, e.g. FAN_REPORT_PIDFD combined with
> + * FAN_REPORT_TID. Additionally, it checks that the operability with
> + * supported FAN_REPORT_* flags is maintained and functioning as intended.
>   *
>   * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
>   * af579beb666a ("fanotify: add pidfd support to the fanotify API").
> + * FAN_REPORT_PIDFD combined with FAN_REPORT_TID is supported since v7.2-rc1.
>   */
>  
>  #define _GNU_SOURCE
> @@ -26,8 +27,10 @@
>  
>  #define MOUNT_PATH	"fs_mnt"
>  #define FLAGS_DESC(x) .flags = x, .desc = #x
> +#define PIDFD_TID_FLAGS (FAN_REPORT_PIDFD | FAN_REPORT_TID)
>  
>  static int fd;
> +static int thread_pidfd_supported;
>  
>  static struct test_case_t {
>  	unsigned int flags;
> @@ -51,17 +54,21 @@ static void do_setup(void)
>  	 */
>  	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
>  						    MOUNT_PATH);
> +
> +	thread_pidfd_supported = tst_kvercmp(7, 2, 0) >= 0;
>  }
>  
>  static void do_test(unsigned int i)
>  {
>  	struct test_case_t *tc = &test_cases[i];
> +	int exp_errno = (tc->flags & PIDFD_TID_FLAGS) == PIDFD_TID_FLAGS &&
> +			thread_pidfd_supported ? 0 : tc->exp_errno;
>  
> -	tst_res(TINFO, "Test %s on %s", tc->exp_errno ? "fail" : "pass",
> +	tst_res(TINFO, "Test %s on %s", exp_errno ? "fail" : "pass",
>  		tc->desc);
>  
>  	TST_EXP_FD_OR_FAIL(fd = fanotify_init(tc->flags, O_RDONLY),
> -			   tc->exp_errno);
> +			   exp_errno);

Hum, this looks somewhat ugly. Ideally we'd initialize test case .exp_errno
accordingly to the expected return of the syscall (but that's not really
possible because the initializer has to be constant). Checking how other
tests handle it, I think we can clone the tests to two. One that expects
failure and is skipped for kernels >= 7.2 and one that expects success and
is skipped for kernels < 7.2. And we can have in the test description
.min_kver and .max_kver fields that would store for which kernel versions
the test should be performed.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
