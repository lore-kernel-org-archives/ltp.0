Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C8FC10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 16:54:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DCDD3CDDD5
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 18:54:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEC843CDC8C
 for <ltp@lists.linux.it>; Tue,  7 May 2024 18:53:49 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 86D34215F0B
 for <ltp@lists.linux.it>; Tue,  7 May 2024 18:53:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ADB1334242;
 Tue,  7 May 2024 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715100828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzvTiTmvXS/83k4TexTUHwWo8AQOVnctwryMzFAbjfg=;
 b=t5LGAiBqRaZem8dYKF5orEhmWYT/z3Uyah39Tsos3ifJLctDZplNR/zs7AaGpx9PKgp2Pd
 xrLZpFUMXmlQbvhUbtW9sPAxhMLLmClJ4DLmp3oju1LAuaM2P3KyPyP5gqm5YwLGpwS7Fo
 n7zfrbT1Vkm+EQzRdoHJd+LJMoKaNTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715100828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzvTiTmvXS/83k4TexTUHwWo8AQOVnctwryMzFAbjfg=;
 b=tQFdQtoCyywwoBKnjMOZ8V1/rtX+LqApm/fPVP1DX8PpA+JiptNPoAkwHNlSFOT3CUJTEv
 II6jPl/n4rNCVIAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=t5LGAiBq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tQFdQtoC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715100828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzvTiTmvXS/83k4TexTUHwWo8AQOVnctwryMzFAbjfg=;
 b=t5LGAiBqRaZem8dYKF5orEhmWYT/z3Uyah39Tsos3ifJLctDZplNR/zs7AaGpx9PKgp2Pd
 xrLZpFUMXmlQbvhUbtW9sPAxhMLLmClJ4DLmp3oju1LAuaM2P3KyPyP5gqm5YwLGpwS7Fo
 n7zfrbT1Vkm+EQzRdoHJd+LJMoKaNTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715100828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gzvTiTmvXS/83k4TexTUHwWo8AQOVnctwryMzFAbjfg=;
 b=tQFdQtoCyywwoBKnjMOZ8V1/rtX+LqApm/fPVP1DX8PpA+JiptNPoAkwHNlSFOT3CUJTEv
 II6jPl/n4rNCVIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 905BC139CB;
 Tue,  7 May 2024 16:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cSQLIpxcOmbVcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 16:53:48 +0000
Date: Tue, 7 May 2024 18:53:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240507165347.GB157588@pevik>
References: <20240429194021.5523-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240429194021.5523-1-akumar@suse.de>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ADB1334242
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap06: use macro TST_EXP_FAIL_PTR_VOID()
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

Hi Avinesh,

...
> -	TESTPTR(mmap(NULL, tc->length, tc->prot, tc->flags, fd, 0));
> -
> -	if (TST_RET_PTR != MAP_FAILED) {
> -		tst_res(TFAIL, "mmap() was successful unexpectedly");
> -		SAFE_MUNMAP(TST_RET_PTR, MMAPSIZE);
> -	} else if (TST_ERR == tc->exp_errno) {
> -		tst_res(TPASS | TERRNO, "mmap() failed with");
> -	} else {
> -		tst_res(TFAIL | TERRNO, "mmap() failed unexpectedly");
> -	}
> +	TST_EXP_FAIL_PTR_VOID(mmap(NULL, tc->length, tc->prot, tc->flags, fd, 0), tc->exp_errno);

Also here should IMHO be:

	if (TST_RET_PTR != MAP_FAILED) {
		SAFE_MUNMAP(TST_RET_PTR, page_sz);

Kind regards,
Petr

>  }

>  static void cleanup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
