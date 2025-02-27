Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D95C19F2E
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 15:34:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFCA03C9E04
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 16:34:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16E133C201C
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 16:33:55 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 77FB161020B
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 16:33:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C9CB32116C;
 Thu, 27 Feb 2025 15:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740670434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLFv949HQ3C1EAyX3rLh+1zSyrrfmqiTn7TEDBhJ83k=;
 b=NLaGBh0seaSoqedUCQ1zeiQRI1kOfqc/i4lj7mPsz4hLu8o4larzeZtkCsOAFABp5H7eBf
 /JOf+1MNlHnihFvComtPhbc9weWrCMnirTGzCXyhICV1YTXZ75jvroIxNmdLFHKisbP/R3
 g92zFLkOzfeRnOEdYPHtK+0ZbOyGHQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740670434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLFv949HQ3C1EAyX3rLh+1zSyrrfmqiTn7TEDBhJ83k=;
 b=GSsPuZqauGq2klFa7iLdiTqPztVOsFqAyCs4DiEfxz+xnehWwCT4iINH2DpP06dgC3QCyy
 xNRxN3Ui93Ue6TAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KTlSbpRz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="W/Zi/kNa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740670433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLFv949HQ3C1EAyX3rLh+1zSyrrfmqiTn7TEDBhJ83k=;
 b=KTlSbpRzavvqcxNFXqxI3D4IfPZrsha7HkkdysdhLZem6/moRdn0MEy6IPmmRXEAPMJFYm
 WqL2T1BvHogMZG/9VXQjIqED+Q6KmjuWXIqtxzAFY275naPSTgrxmrrjVYMcSr1aeQYkyX
 jSk6oI3KxF0wIYG4B3wvTnf1hkMLyMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740670433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LLFv949HQ3C1EAyX3rLh+1zSyrrfmqiTn7TEDBhJ83k=;
 b=W/Zi/kNa7tnujlXXUqvG5+PMqaTOvDv9OgHt3e6b57HgRcuNsJ59t5zCsEnHfFGzCMqTEO
 Bf0nVMMlyf+UV2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D82713888;
 Thu, 27 Feb 2025 15:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vNkzJOGFwGcEDwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Feb 2025 15:33:53 +0000
Date: Thu, 27 Feb 2025 16:33:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ross Burton <ross.burton@arm.com>
Message-ID: <20250227153351.GA3149389@pevik>
References: <20250227124330.949015-1-ross.burton@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250227124330.949015-1-ross.burton@arm.com>
X-Rspamd-Queue-Id: C9CB32116C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kernel/kvm: don't hardcode objcopy
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

Hi Ross,

> testcases/kernel/kvm uses objcopy to contruct a payload binary, but in
> cross builds the host objcopy may not know how to handle target
> binaries:

>  CC testcases/kernel/kvm/lib_host.o
>  objcopy: Unable to recognise the format of the input file `kvm_svm03-payload.elf'
>  make[3]: *** [ltp/testcases/kernel/kvm/Makefile:67: kvm_svm03-payload.o] Error 1

> This is trivially fixed by searching for an objcopy tool (so
> host-prefixed in cross builds) and using that instead.

Thanks for the fix, merged!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
