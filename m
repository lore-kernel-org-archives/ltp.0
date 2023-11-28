Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C43C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:23:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43E7E3CDAB7
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 12:23:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 086793CB148
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:23:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 324C914044CE
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 12:23:08 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A34881F74B;
 Tue, 28 Nov 2023 11:22:59 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DAE7139FC;
 Tue, 28 Nov 2023 11:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id lWxXIJPNZWUmdgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 11:22:59 +0000
Date: Tue, 28 Nov 2023 12:22:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Shirisha G <shirisha@linux.ibm.com>
Message-ID: <20231128112254.GA367506@pevik>
References: <20230929091401.205277-1-shirisha@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230929091401.205277-1-shirisha@linux.ibm.com>
X-Spamd-Bar: ++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: A34881F74B
X-Spamd-Result: default: False [12.36 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(0.19)[0.062];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 DMARC_NA(1.20)[suse.cz];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; NEURAL_SPAM_LONG(3.50)[1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.02)[51.59%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Migrating the
 libhugetlbfs/testcases/truncate.c test
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

Hi,

...
> +static void sigbus_handler(int signum)
> +{
> +	test_pass = 1;
> +	siglongjmp(sig_escape, 17);
What 17 stands for? Is there any constant which could be used? Or can you define
something (the name of the constant would be self-describing).
> +}
> +
> +static void run_test(void)
> +{
> +	void *p;
> +	volatile unsigned int *q;
> +
> +	sigbus_count = 0;
> +	test_pass = 0;
> +	int err;
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +	q = p;
> +	*q = 0;
> +	err = ftruncate(fd, 0);
> +	if (err)
> +		tst_res(TFAIL, "ftruncate failed");
We have SAFE_FTRUNCATE(), error check is not needed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
