Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D26C79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:41:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD2173E926F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 12:41:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02A0E3C198F
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 12:41:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 16309140043D
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 12:41:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49F3B21C38;
 Thu, 10 Sep 2026 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789036855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWeaay6iAlZKKMXkwIRb8cquFg6Pj9RtJ4j9r1X08hk=;
 b=gQrbIoKxjR/QlkaXx0t2uwZNHfdIz5RObGXcbr+4wZwyYT7Z0DoFHSGftqeQaorDSVLKW/
 Ya2AwYrZmY/+1yFeAuusr8cbKjllU3BGuENn6zNGv/WdTOed9Yzt+ff/LSNwd9KpPIffiT
 Nvdz8FmQBuAGqDTZE5vq8f2pzSac0hI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789036855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWeaay6iAlZKKMXkwIRb8cquFg6Pj9RtJ4j9r1X08hk=;
 b=pnIu5uCEcatKN20VBdk982M6EoARKzt3d0ZvBFUEJYKPCQWW/T2N51lu0zoMH8RlLGvcSX
 pA2eV8DDvO/TG/DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789036851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWeaay6iAlZKKMXkwIRb8cquFg6Pj9RtJ4j9r1X08hk=;
 b=Tq22jRhZ+6PVlBFPz5W5Vm6jOn9X8PQ3pSAvduXHP1IsgBJi2VRtYDjRLaHpXjPPlmGxNa
 +hHdw6DebWs74Zc8EzqLoR1kR9VoKvum7bIFc6n2XI01GRoG1o2CpbXn3pviPaWsHPx2BV
 /Qix2nFjdOIMD/CC4oWsNstZECjcmDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789036851;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWeaay6iAlZKKMXkwIRb8cquFg6Pj9RtJ4j9r1X08hk=;
 b=x0KCGO9Dfjoci9EmK4zT5Dd3e1L1OCNjviCVo012v+1D9mmz2JCQE6ZQZ0DGrIhYld5ruW
 YVFg1RSfAc6cyADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1254D13180;
 Thu, 10 Sep 2026 10:40:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m3R2BDOJomo9XAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 10 Sep 2026 10:40:51 +0000
Date: Thu, 10 Sep 2026 12:40:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqKJODHqRsBDsSi4@yuki.lan>
References: <20260904-cve-ghostlock-v8-0-bd999083c7fb@suse.com>
 <20260904-cve-ghostlock-v8-1-bd999083c7fb@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-cve-ghostlock-v8-1-bd999083c7fb@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/5] sched_setattr01: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void verify_sched_setattr(unsigned int n)
>  {
> -	TEST(sched_setattr(*(test->pid), test->a, test->flags));
> -
> -	if (TEST_RETURN != test->exp_return) {
> -		tst_resm(TFAIL | TTERRNO, "sched_setattr(%i,attr,%u) "
> -		         "returned: %ld expected: %d",
> -		         *(test->pid), test->flags,
> -		         TEST_RETURN, test->exp_return);
> +	struct tcase *tc = &tcases[n];
> +	pid_t pid = tc->pid ? *tc->pid : 0;
> +	struct sched_attr *target_attr = tc->bad_attr ? bad_addr : tc->attr;
> +	struct sched_attr read_attr = { .size = sizeof(read_attr) };
> +
> +	/*
> +	 * The kernel writes sizeof(struct sched_attr) back to uattr->size
> +	 * on the -E2BIG error path, clobbering our test input. Refresh
> +	 * before each call so re-runs (e.g. -i N) still exercise the
> +	 * intended size.
> +	 */
> +	attr_small.size = SCHED_ATTR_SIZE_VER0 - 1;
> +
> +	if (tc->exp_errno) {
> +		TST_EXP_FAIL(sched_setattr(pid, target_attr, tc->flags),
> +			     tc->exp_errno, "%s", tc->desc);
>  		return;
>  	}
>  
> -	if (TEST_ERRNO == test->exp_errno) {
> -		tst_resm(TPASS | TTERRNO,
> -			"sched_setattr() works as expected");
> +	TST_EXP_PASS(sched_setattr(pid, target_attr, tc->flags),
> +		     "%s", tc->desc);
> +	if (!TST_PASS)
>  		return;
> -	}
> -
> -	tst_resm(TFAIL | TTERRNO, "sched_setattr(%i,attr,%u): "
> -		"expected: %d - %s",
> -		*(test->pid), test->flags,
> -		test->exp_errno, tst_strerrno(test->exp_errno));
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	pthread_t thread;
> -	int lc;
>  
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		pthread_create(&thread, NULL, do_test, NULL);
> -		pthread_join(thread, NULL);
> +	if (sched_getattr(pid, &read_attr, sizeof(read_attr), 0) == -1) {
> +		tst_res(TFAIL | TERRNO, "sched_getattr() failed");
> +		return;
>  	}
>  
> -	tst_exit();
> +	TST_EXP_EQ_LU(read_attr.sched_policy, SCHED_DEADLINE);
> +	TST_EXP_EQ_LU(read_attr.sched_runtime, RUNTIME_VAL);
> +	TST_EXP_EQ_LU(read_attr.sched_deadline, DEADLINE_VAL);
> +	TST_EXP_EQ_LU(read_attr.sched_period, PERIOD_VAL);
> +
> +	reset_sched();
>  }

Can we please split the passing test into a separate testcase?

Mixing possitive and negative tests into single source makes things
more complex for no good reason...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
