Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF97C98306
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 06:50:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79B103E5C57
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 08:50:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A88013E5BC6
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 08:49:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 247E7601D06
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 08:49:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8AF1E1FAC1;
 Fri, 25 Sep 2026 06:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790318981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZknpSQOaq+c87QDZabiGOCHIAGptQOqvDDGGcKQurro=;
 b=ElAN4uUAtTem7s5yPQblwODV2/2ODtbnNDXJjG70DvkFGMNXWnQDLEkp/oqU+aks5Z+i8A
 RghMFK9bO7eH/o6Jcsu8L+KnjRfR4lvhml755u71OYXxgzEetduOTCTs3DeMRjYr3aOUCa
 fY4a094MVnwNILNhJb3OkwRjaLsrm2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790318981;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZknpSQOaq+c87QDZabiGOCHIAGptQOqvDDGGcKQurro=;
 b=/5RzKaCbw+nB0QaS++ZzLL71UcBwWM6PP0gL0WiqIKPioDavjXYWOwxz86J6tRhKER+bYu
 4a8p5nV8sI2W/FAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790318977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZknpSQOaq+c87QDZabiGOCHIAGptQOqvDDGGcKQurro=;
 b=YziX+uJRreFh7Eu6bvyOZTcyPepBcdiCPl5uZFQaNttwGXzxxk75KTt5VcbtM13wbMonYE
 HAbuFK2O0HbAHDIM1ZFB0C3zzLkFlFeTOOSY/pO48WImoR6dvx+JBOze1RvjtS9ZynNUCk
 YUVuqDJiHbfHWMrlOEi1HbQCVgnWD+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790318977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZknpSQOaq+c87QDZabiGOCHIAGptQOqvDDGGcKQurro=;
 b=yIgJteQhtiSzzCjbhMJsKWGKUQ8eAs+Vl7psH3kgRJUY9J/0hT63FLO8OvhyMWfMKXKrNT
 MBWz/e5EgSUeoGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19F0D13432;
 Fri, 25 Sep 2026 06:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GUy4M4AZtmrwZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Sep 2026 06:49:37 +0000
Date: Fri, 25 Sep 2026 08:49:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260925064935.GA2387785@pevik>
References: <20260924112514.2375626-1-pvorel@suse.cz>
 <20260924112514.2375626-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260924112514.2375626-4-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] shmctl03: Use safe_shmctl(),
 TST_EXP_LE_LU()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

...

> -	if (info.shmmin != 1)
> -		tst_res(TFAIL, "shmmin = %li, expected 1", info.shmmin);
> -	else
> -		tst_res(TPASS, "shmmin = 1");
> +	safe_shmctl(__FILE__, __LINE__, 0, IPC_INFO, ((struct shmid_ds *)&info));
> +	TST_EXP_LE_LU(info.shmmin, 1);

Ah, TST_EXP_EQ_LU() should have been used.
Also 1st patch should probably be improved => v3.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
