Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAA2D78321
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:36:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB7943DD4F6
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 15:36:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9D413DD4E1
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 15:36:33 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 30D761000CF9
 for <ltp@lists.linux.it>; Mon,  2 Dec 2024 15:36:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 193B61F442;
 Mon,  2 Dec 2024 14:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733150192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WAkvx2I63ZxCJa6lZHRK6WQWp5WraSOi6FCeFQFUKA=;
 b=yaGFovLWQIXsUFDdpbQN/vFy2oSqXIWNDtPvTFaVraJFyyMnhIcNlj+oD+kx7g1UHE/O0g
 oNCjLNk8UKJfhwhtokwBoDcmOPRNr+HvrNFucllEfXgjvnjTv5Sepa13DGQ+jVUTrJb6jV
 RbHJEo//c5wF1cZbMnQlcIDBYAFfbCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733150192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WAkvx2I63ZxCJa6lZHRK6WQWp5WraSOi6FCeFQFUKA=;
 b=VTHuayHxu8xy8fA2K/Vkuu4S4DQkqIMouh2bCZF11LYF/RfjQWBw0N+r7wylsOvfl0zY9/
 Ns3kyYbeUzGRxOAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yaGFovLW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VTHuayHx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733150192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WAkvx2I63ZxCJa6lZHRK6WQWp5WraSOi6FCeFQFUKA=;
 b=yaGFovLWQIXsUFDdpbQN/vFy2oSqXIWNDtPvTFaVraJFyyMnhIcNlj+oD+kx7g1UHE/O0g
 oNCjLNk8UKJfhwhtokwBoDcmOPRNr+HvrNFucllEfXgjvnjTv5Sepa13DGQ+jVUTrJb6jV
 RbHJEo//c5wF1cZbMnQlcIDBYAFfbCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733150192;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WAkvx2I63ZxCJa6lZHRK6WQWp5WraSOi6FCeFQFUKA=;
 b=VTHuayHxu8xy8fA2K/Vkuu4S4DQkqIMouh2bCZF11LYF/RfjQWBw0N+r7wylsOvfl0zY9/
 Ns3kyYbeUzGRxOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D63DB13A43;
 Mon,  2 Dec 2024 14:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b1O6Me/FTWeFIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 02 Dec 2024 14:36:31 +0000
Date: Mon, 2 Dec 2024 15:36:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241202143622.GA321427@pevik>
References: <20241129133421.24349-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241129133421.24349-1-mdoucha@suse.cz>
X-Rspamd-Queue-Id: 193B61F442
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test for data integrity over NFS
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

Hi Martin,

...
> +TST_CNT=4
> +TST_TESTFUNC="do_test"
> +TST_DEVICE_SIZE=1024
> +TST_TIMEOUT=2400

It looks like block size (f_bsize member of struct statvfs) differs depending on
RAM. Testing on s390x VM:

* 1 GB => block size: 131072
* 2 GB => block size: 262144
* 4 GB => block size: 524288

This can cause timeouts depending on the machine setup.
How about changing TST_TIMEOUT=-1 ? I don't like unlimited setup, but in this
case I would keep it. Timeout is handled by fsplough.c anyway.
If you agree, I can change during merge.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +do_test1()
> +{
> +	tst_res TINFO "Testing buffered write, buffered read"
> +	EXPECT_PASS fsplough -c 512 -d "$PWD"
> +}
> +
> +do_test2()
> +{
> +	tst_res TINFO "Testing buffered write, direct read"
> +	EXPECT_PASS fsplough -c 512 -R -d "$PWD"
> +}
> +
> +do_test3()
> +{
> +	tst_res TINFO "Testing direct write, buffered read"
> +	EXPECT_PASS fsplough -c 512 -W -d "$PWD"
> +}
> +
> +do_test4()
> +{
> +	tst_res TINFO "Testing direct write, direct read"
> +	EXPECT_PASS fsplough -c 512 -RW -d "$PWD"
> +}
> +
> +. nfs_lib.sh
> +tst_run

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
