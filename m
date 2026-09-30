Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745B6CA5FB1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 09:57:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A58043E5660
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 11:57:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B1F23E55D4
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 11:57:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FE1C1A00CBA
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 11:57:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 073D11F847;
 Wed, 30 Sep 2026 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790762256;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvCniNh24ua5K4bRuH9O+1RERlFv1EO/IGZO16vfN8o=;
 b=tSn12utoUyDM84cQmziMRL1E/pwED7r7E7v35Mr1bi61ocqXKtI6F40hkrZt4YtJZLSY9o
 xY7k/zzkQwyXbjkOnAlUJS2ds3GtLQHN2C1dSptcZaR0gicNu9JhvX4K4ELPzeI1UlD9vr
 fW7zX7diapQTl9xzGTXZAaArasXCOTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790762256;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvCniNh24ua5K4bRuH9O+1RERlFv1EO/IGZO16vfN8o=;
 b=4FRVLP7TITCukXP3Giwm83JUmZQuP2A+XzQfTCQ3a2pJdWK5upOwOs61kkKwfLqvlSYoq6
 wjGmBsdRaunqEyAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790762252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvCniNh24ua5K4bRuH9O+1RERlFv1EO/IGZO16vfN8o=;
 b=DRJmQM7fqei0T+w6q2bVAVNB+pwT58I70x2OZfiEkjSXFUF9+qI58H0L4FROGhCRpCYt0x
 L2UY/tpvovfxMabTxppf+dVm2fMBgOlQLjgJnJmGpOxLimJ65ySGEvbrizdQGhz3bKFCQx
 ASCXTJGGXQ+AYOtIs33OU/oRVcBkwR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790762252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MvCniNh24ua5K4bRuH9O+1RERlFv1EO/IGZO16vfN8o=;
 b=tTgAyKdVSMLCtiBktD76ADnii1uJFCc9JMZYD9EotaQi2UbeZkyaCcyNo2rIJwI/7xJ6at
 aajTHgazaXfXgAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C190413A90;
 Wed, 30 Sep 2026 09:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fy5hJgvdvGqCWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Sep 2026 09:57:31 +0000
Date: Wed, 30 Sep 2026 11:57:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260930095726.GA2631686@pevik>
References: <20260930-fix_epoll_bpf-v2-1-c1ac22e73b8c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930-fix_epoll_bpf-v2-1-c1ac22e73b8c@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] epoll_ctl06: Fix BPF map on old kernels
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> BPF map file descriptors gained a poll callback in upstream kernel
> 5.8. Without that callback, EPOLL_CTL_ADD fails with EPERM, while the
> test expected it to succeed.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
