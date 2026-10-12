Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEF6CA9ED1
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 10:32:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C04A3E9B17
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 12:32:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39EDB3E309A
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 12:32:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F6BF100077D
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 12:32:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18B8321E8A;
 Mon, 12 Oct 2026 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791801142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W3+018bWbqgMvYHnuPavxZApfztnFlXvqaHQqs3Zu7o=;
 b=M4mxb0XP5yp3Q6vJhtOO+dQmGGM1jczn2eMtNTruaOioJ/ocIlVkhTlDVO0q1NkRVue87a
 AAQ+9MK3HcPVmhsWNN9zrUekx2kfbj3NYATboGPd2men4Yne5CUlhDmXY1vzbBkizm+k8Z
 v6njaMG5x38j1FWowy16+Oc86db7hjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791801142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W3+018bWbqgMvYHnuPavxZApfztnFlXvqaHQqs3Zu7o=;
 b=p64UbhU5gvve7CpuBK69sDx6JLe0sGB1+5FfWj28yZtTqd9q7+tgigFI0WWfyanlEY9ZcW
 xcgIMRJ+yZr4lGCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791801142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W3+018bWbqgMvYHnuPavxZApfztnFlXvqaHQqs3Zu7o=;
 b=M4mxb0XP5yp3Q6vJhtOO+dQmGGM1jczn2eMtNTruaOioJ/ocIlVkhTlDVO0q1NkRVue87a
 AAQ+9MK3HcPVmhsWNN9zrUekx2kfbj3NYATboGPd2men4Yne5CUlhDmXY1vzbBkizm+k8Z
 v6njaMG5x38j1FWowy16+Oc86db7hjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791801142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W3+018bWbqgMvYHnuPavxZApfztnFlXvqaHQqs3Zu7o=;
 b=p64UbhU5gvve7CpuBK69sDx6JLe0sGB1+5FfWj28yZtTqd9q7+tgigFI0WWfyanlEY9ZcW
 xcgIMRJ+yZr4lGCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCC2613408;
 Mon, 12 Oct 2026 10:32:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4JDVLTW3zGrwLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 12 Oct 2026 10:32:21 +0000
Date: Mon, 12 Oct 2026 12:32:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asy3R7sb8Limzr1V@yuki.lan>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
 <20260831-fchroot-v4-6-57cceb68f927@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-fchroot-v4-6-57cceb68f927@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v4 06/16] fchroot03: test fchroot()
 permission checks
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
> +static void run(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	if (SAFE_FORK())
> +		return;
> +
> +	int dfd = SAFE_OPEN(tc->dir, O_PATH | O_DIRECTORY);
> +
> +	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
> +		ltpuser->pw_uid);
> +
> +	TST_EXP_FAIL(tst_syscall(__NR_fchroot, dfd, 0),
> +		tc->exp_errno, "fchroot() with %s", tc->desc);
> +
> +	exit(0);

The test library does exit(0); for any process that has been forked from
the main test process. There is no need for the exit(0) here.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
