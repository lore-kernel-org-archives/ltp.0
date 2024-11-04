Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A7FD132BE
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 13:05:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D2F53D0ADA
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 14:05:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5B463C130D
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 14:05:14 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F118661F8F3
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 14:05:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3907021B79;
 Mon,  4 Nov 2024 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730725510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+A4fGt9jgrbs+Y2L4kMhTvQar2frUXEtw+M/nxCPvAA=;
 b=cajqlp4qKxVkXbIkMbbBo81MqLKaYnMu28QxWdXRApsGauOOmNfbAtilm0Jd0jjAuCKNV1
 8S2BvRXTJlugz2EQ0ZpRhfdNdk/SDhRiHUXO8t9+nWnguuAGMvNdU6g5XoOznI2tmzBqAI
 skJkgAGrvpJlJXximJWt5dDVSmd/JLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730725510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+A4fGt9jgrbs+Y2L4kMhTvQar2frUXEtw+M/nxCPvAA=;
 b=6aZc7LduaXAbV4EjkQgiaY5eOMEvkRBfXc8VS8QrRNJU5EBoZ5KmRbIMb0o2fK2XV7nDEo
 9dIs2OOCIbvNJfCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730725510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+A4fGt9jgrbs+Y2L4kMhTvQar2frUXEtw+M/nxCPvAA=;
 b=cajqlp4qKxVkXbIkMbbBo81MqLKaYnMu28QxWdXRApsGauOOmNfbAtilm0Jd0jjAuCKNV1
 8S2BvRXTJlugz2EQ0ZpRhfdNdk/SDhRiHUXO8t9+nWnguuAGMvNdU6g5XoOznI2tmzBqAI
 skJkgAGrvpJlJXximJWt5dDVSmd/JLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730725510;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+A4fGt9jgrbs+Y2L4kMhTvQar2frUXEtw+M/nxCPvAA=;
 b=6aZc7LduaXAbV4EjkQgiaY5eOMEvkRBfXc8VS8QrRNJU5EBoZ5KmRbIMb0o2fK2XV7nDEo
 9dIs2OOCIbvNJfCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2759313736;
 Mon,  4 Nov 2024 13:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7vv4B4bGKGfTYwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 Nov 2024 13:05:10 +0000
Date: Mon, 4 Nov 2024 14:05:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZyjGiQ7-oyBZBG-S@yuki.lan>
References: <20241101141111.104803-1-mdoucha@suse.cz>
 <20241101141111.104803-6-mdoucha@suse.cz>
 <20241101233221.GC1324664@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241101233221.GC1324664@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] Add test for data integrity over NFS
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
> Test timed out, sending SIGTERM!
> If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> Sending SIGKILL to test process...
> Test is still running... 10
> Test is still running... 9
> Test is still running... 8
> Test is still running... 7
> Test is still running... 6
> Test is still running... 5
> Test is still running... 4
> Test is still running... 3
> Test is still running... 2
> Test is still running... 1
> Test is still running, sending SIGKILL
> Killed

Isn't the propblem here that the fsplough.c itself does not have
.max_runtime set?

I think that main problem here is that we have a LTP test that is being
executed from another LTP test which means that we have two layers of
everything including timeouts.

> The quickest way would be to use the same calculation (* $TST_CNT + 5% for spare
> time) in nfs10.sh and increase tst_set_timeout with.
> 
> Or, I wonder if using tst_loader.sh and tst_run_shell.c would help to integrate
> these. But I'm not sure how easily could be nfs_lib.sh integrated, e.g.
> * isn't it too late, when it uses tst_net.sh (maybe this file would need to be
>   integrated)
> * should use keep using TST_ALL_FILESYSTEMS=1 from tst_test.sh or configure
>   via all_filesystems=1 via json?

I guess that the best solution would be to add NFS support into the
tst_test.c as another filesystem. That way we would get much more
coverate than we do now. I guess that it would be doable as long as the
configuration on how to do that is passed to the test library somehow.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
