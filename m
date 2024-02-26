Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C3CC48BF6
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 16:07:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55C0A3CEFFD
	for <ltp@archiver.kernel.org>; Mon, 26 Feb 2024 17:07:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DD8D3CBEED
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 17:07:13 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B0ADD140164E
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 17:07:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA3061FD29;
 Mon, 26 Feb 2024 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708963631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9i+/6t+ITog0PfhAgD9sRsDJqGHsnDJcYTVcWvquMj8=;
 b=xIMJ5IXTunPNzombPf8c4eJf28rPXkjWnzTXzWXAyVaDlwuh+mmaaVjZGs3AhOrUl9erLU
 kyOdBrVChG5jnNRqOfpjxDhBxuzOGR3rMiuSr4Ld0+XRBq4fuxUReiTzL0W3scuSOEJF+P
 rlyFBK79sg/tkLLZenASoYOEqH8CrQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708963631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9i+/6t+ITog0PfhAgD9sRsDJqGHsnDJcYTVcWvquMj8=;
 b=2zgoApwkuorIBZu9pbapNKsCdPh/XHwI/uc1Bzsq2olx3c9FDqHUcGgvtB48qeit/QQR9C
 YhHyQcdS6LfRTxCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708963629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9i+/6t+ITog0PfhAgD9sRsDJqGHsnDJcYTVcWvquMj8=;
 b=Kh+IM6MLHrJLct0qOcoE27NAf7oTA9zLqfXpX+JClJlbZZ9ds0MmdFiG7gTKn8XbG+gXVc
 qVGyyxkpy5zVgCu6k9jwqgiK0A0jPzMQx1R5ExrWL9R67fCxnaKkapkK1wVPVrIEjw6+4D
 OtLXeYW4Kge77Mgb2dyrdVFWcCmnnP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708963629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9i+/6t+ITog0PfhAgD9sRsDJqGHsnDJcYTVcWvquMj8=;
 b=DvTaMbnO3o4CvO3l62He4/4+dQxH6hjyjfZCMhxd7LcEf7ENLmMilcgL6DFbctMCvpf1Xg
 EBGDxJssu5sfIwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB3F913A3A;
 Mon, 26 Feb 2024 16:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z72wLS233GXpCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Feb 2024 16:07:09 +0000
Date: Mon, 26 Feb 2024 17:06:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zdy26zz-_23brAlB@yuki>
References: <20240226153754.24998-1-andrea.cervesato@suse.de>
 <20240226153754.24998-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240226153754.24998-3-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[42.95%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add shmat04 SysV IPC bug reproducer
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

Hi!
> +static void change_access(void *addr, int size, int prot)
> +{
> +	switch (prot) {
> +	case PROT_NONE:
> +		tst_res(TINFO, "Disable memory access. addr: %p - size: %d",
> +			addr, size);
> +		break;
> +	case PROT_WRITE:
> +		tst_res(TINFO, "Enable write memory access. addr: %p - size: %d",
> +			addr, size);
> +		break;
> +	default:
> +		tst_res(TINFO, "Change memory access. addr: %p - size: %d",
> +			addr, size);
> +		break;
> +	}
> +
> +	SAFE_MPROTECT(addr, size, prot);
> +}

Hmm, it's kind of ugly how we wrap the macro here like that...

What about we instead add debugging messages to all the SAFE_MACROS()?

Given that we added TDEBUG flag recently we can do soemthing as:

	tst_res_(TDEBUG, file, lineno, "mprotect(%p, %d, %s)",
	         addr, size, prot_to_str(prot));

To the SAFE_MPROTECT() and get the verbose output for free with verbose
flag passed to the test.

We can do that with all SAFE_MACROS() then we do not have to print most
of the messages in this test...

> +
> +static void run(void)
> +{
> +	struct shmid_ds shmid_ds;
> +	void *sh_mem;
> +
> +	segment_id = SAFE_SHMGET(
> +		key_id,
> +		segment_size,
> +		IPC_CREAT | IPC_EXCL | 0600);
> +
> +	sh_mem = SAFE_SHMAT(segment_id, NULL, 0);
> +
> +	tst_res(TINFO, "Attached at %p. key: %d - size: %lu",
> +		sh_mem, segment_id, segment_size);
> +
> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
> +
> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
> +
> +	change_access(sh_mem + page_size, page_size, PROT_NONE);
> +	change_access(sh_mem, 2 * page_size, PROT_WRITE);
> +
> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
> +
> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
> +	tst_res(TINFO, "Delete attached memory");
> +
> +	SAFE_SHMDT(sh_mem);
> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
> +
> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
> +
> +	SAFE_SHMCTL(segment_id, IPC_RMID, NULL);
> +	segment_id = -1;
> +
> +	if (shmid_ds.shm_nattch)
> +		tst_res(TFAIL, "The system is affected by the SysV IPC bug");
> +	else
> +		tst_res(TPASS, "Test passed");

These messages are not really that useful, we can as well do:

TST_EXP_EQ_LU(shmid_ds.shm_nattach, 0);

That will provide better message than "PASS: Test passed"

> +}
> +
> +static void setup(void)
> +{
> +	key_id = GETIPCKEY();
> +	page_size = getpagesize();
> +
> +	tst_res(TINFO, "Key id: %d", key_id);
> +	tst_res(TINFO, "Page size: %d", page_size);
> +
> +	segment_size = 3 * page_size;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (segment_id != -1)
> +		SAFE_SHMCTL(segment_id, IPC_RMID, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
