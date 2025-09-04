Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA88CA1012
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 09:49:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384B03CC058
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 11:49:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E12D53CD42B
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 11:48:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CEEC7600795
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 11:48:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1ED5E3429D;
 Thu,  4 Sep 2025 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756979325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzwkGxmwyG73Emaxo8nlVUnFMV+eAmMebqnDb9YMltI=;
 b=dyYuJzc8Z+//mLoczNoViEeW8hHIWFobx5Y/QU5o+i6adlxHR0B1/ZSXHnMO1lCXgEYz5S
 Cypu0SDWLOCmsvOD8Qpc0yKkCWO35Hw0a4hrbxkVzur9QXg41XNOLdQc9xb7U7CvwOM144
 iHIOUkfvrqRwQJrjsPLYTAJdxqO3GAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756979325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzwkGxmwyG73Emaxo8nlVUnFMV+eAmMebqnDb9YMltI=;
 b=boWzus0o1rxFNe8WEawtOk+DQRy5DqCQSIZrPN59u6YhBKDVjISXLtY63wlEBlUj/tezKI
 2pg4TZgSPWEfB6CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756979325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzwkGxmwyG73Emaxo8nlVUnFMV+eAmMebqnDb9YMltI=;
 b=dyYuJzc8Z+//mLoczNoViEeW8hHIWFobx5Y/QU5o+i6adlxHR0B1/ZSXHnMO1lCXgEYz5S
 Cypu0SDWLOCmsvOD8Qpc0yKkCWO35Hw0a4hrbxkVzur9QXg41XNOLdQc9xb7U7CvwOM144
 iHIOUkfvrqRwQJrjsPLYTAJdxqO3GAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756979325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzwkGxmwyG73Emaxo8nlVUnFMV+eAmMebqnDb9YMltI=;
 b=boWzus0o1rxFNe8WEawtOk+DQRy5DqCQSIZrPN59u6YhBKDVjISXLtY63wlEBlUj/tezKI
 2pg4TZgSPWEfB6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EC9413AA0;
 Thu,  4 Sep 2025 09:48:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f2t8F3xguWgkIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 04 Sep 2025 09:48:44 +0000
Date: Thu, 4 Sep 2025 11:48:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250904094842.GA52619@pevik>
References: <20250904064126.125661-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250904064126.125661-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: synchronize with kickoff flag to
 reduce skew
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

Hi Li,

...
>  static void do_setup(void)
>  {
> +	if (!tst_check_preempt_rt())
> +		tst_brk(TCONF, "Test requires real-time kernel");

I guess this itself fix many false positives :). I'm ok with requesting RT
kernel, but just to remind the claim originated from Cyril [1] "sched_football
is useful not only for testing realtime". So was Cyril wrong?

(I'm ok to keep the test in runtest/sched even requesting RT kernel, because
runtest/sched and other LTP tests are run on both RT and non-RT.

The rest LGTM, thanks for stabilising the test.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/3a8e38fc2c46c886525bbb708dff462c6b633d32

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
