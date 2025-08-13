Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCED7CA0EE0
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 16:59:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED8843CB96F
	for <ltp@archiver.kernel.org>; Wed, 13 Aug 2025 18:59:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B32BA3CB7C1
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 18:59:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D4176002B5
 for <ltp@lists.linux.it>; Wed, 13 Aug 2025 18:59:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 681521F7BE;
 Wed, 13 Aug 2025 16:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755104371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/0Oq5C8GUEGkymoPk2YM92RLxtXLV+e/H0T0v8a830=;
 b=rylycwuxcvr9X06raZMVi/V5A5abdOGaAgePYwXwFfY7gCAKOBsdARoE0EviksazZzjcls
 eIO0HXaQV04L37b6uFmfqFFpA8UzRmNeOqfL/maxNmAkONFGdCmH5ex1Zli28GbmNnojBa
 jwgTvSWqp0wvocKxxv8bWG1XASWNQGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755104371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/0Oq5C8GUEGkymoPk2YM92RLxtXLV+e/H0T0v8a830=;
 b=EQEO0Y+5iLRtC6q5KXdDkiiVYj1bjyXctUvcNNZi5UgkIlHSj4TH/9oPGZOBvJAyKaord9
 ns+GPvgTKHwCyEBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755104371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/0Oq5C8GUEGkymoPk2YM92RLxtXLV+e/H0T0v8a830=;
 b=rylycwuxcvr9X06raZMVi/V5A5abdOGaAgePYwXwFfY7gCAKOBsdARoE0EviksazZzjcls
 eIO0HXaQV04L37b6uFmfqFFpA8UzRmNeOqfL/maxNmAkONFGdCmH5ex1Zli28GbmNnojBa
 jwgTvSWqp0wvocKxxv8bWG1XASWNQGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755104371;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/0Oq5C8GUEGkymoPk2YM92RLxtXLV+e/H0T0v8a830=;
 b=EQEO0Y+5iLRtC6q5KXdDkiiVYj1bjyXctUvcNNZi5UgkIlHSj4TH/9oPGZOBvJAyKaord9
 ns+GPvgTKHwCyEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5554513479;
 Wed, 13 Aug 2025 16:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dwbKE3PEnGi1GwAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 13 Aug 2025 16:59:31 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 Aug 2025 18:59:30 +0200
Message-ID: <5912512.DvuYhMxLoT@thinkpad>
In-Reply-To: <39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com>
References: <39ee7abdee12e22074b40d46775d69d37725b932.1754386027.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 CTE_CASE(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/epoll_ctl04: add ELOOP to expected errnos
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

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>
Tested-by: Avinesh Kumar <akumar@suse.de>

tst_test.c:2007: TINFO: Tested kernel: 6.17.0-rc1-1-default+ #11 SMP PREEMPT_DYNAMIC Wed Aug 13 16:42:23 CEST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1825: TINFO: Overall timeout per run is 0h 02m 00s
epoll_ctl04.c:61: TPASS: epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5 : ELOOP (40)


Thank you,
Avinesh


On Tuesday, August 5, 2025 11:27:23 AM CEST Jan Stancek via ltp wrote:
> Kernel commit f2e467a48287 ("eventpoll: Fix semi-unbounded recursion")
> added an extra checks for determining the maximum depth of an upwards walk,
> which startign with 6.17-rc kernels now hits ELOOP before EINVAL.
> 
> Add ELOOP to list of expected errnos.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
> index 955959b6b266..feb49623b15e 100644
> --- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
> +++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl04.c
> @@ -51,13 +51,16 @@ static void cleanup(void)
>  
>  static void verify_epoll_ctl(void)
>  {
> +	const int exp_errnos[] = {EINVAL, ELOOP};
> +
>  	new_epfd = epoll_create(1);
>  	if (new_epfd == -1)
>  		tst_brk(TBROK | TERRNO, "fail to create epoll instance");
>  
>  	events.data.fd = epfd;
> -	TST_EXP_FAIL(epoll_ctl(new_epfd, EPOLL_CTL_ADD, epfd, &events), EINVAL,
> -		     "epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5");
> +	TST_EXP_FAIL2_ARR(epoll_ctl(new_epfd, EPOLL_CTL_ADD, epfd, &events),
> +		exp_errnos, ARRAY_SIZE(exp_errnos),
> +		"epoll_ctl(..., EPOLL_CTL_ADD, ...) with number of nesting is 5");
>  	SAFE_CLOSE(new_epfd);
>  }
>  
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
