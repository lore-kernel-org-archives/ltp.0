Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E83C25B7C
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 15:43:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE2F43D01A6
	for <ltp@archiver.kernel.org>; Thu, 23 May 2024 17:43:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1B943CFF9C
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:43:26 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 501E4200CF6
 for <ltp@lists.linux.it>; Thu, 23 May 2024 17:43:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38E85202FF;
 Thu, 23 May 2024 15:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716479004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhxA1Drz98mcW6B2A9ur26zJGthtVjMvSgkj5afRUsc=;
 b=LjVMK5hBRPScwPo37M0bbruBq19raZl189FvgZHorpCEAKBZQx0eWMuJ0HzA1kX90jSK3o
 xtW9XE/BHmQ9DCYuUbWkK70NygZKdTT2rr1piCJMqpw5AUttgessIAITPLWJaO3A+qlMe+
 PUr9gZMQ+9r6DSESkxqlBPaVq+uxZ6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716479004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhxA1Drz98mcW6B2A9ur26zJGthtVjMvSgkj5afRUsc=;
 b=NaoDfCLQDh07fEvStFcyfyKm8GWxa7zhOfC70n9AsZVvURcmlxy6ATUBfdtZ3najjjUPMV
 fMS88xXdCihpiVCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716479004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhxA1Drz98mcW6B2A9ur26zJGthtVjMvSgkj5afRUsc=;
 b=LjVMK5hBRPScwPo37M0bbruBq19raZl189FvgZHorpCEAKBZQx0eWMuJ0HzA1kX90jSK3o
 xtW9XE/BHmQ9DCYuUbWkK70NygZKdTT2rr1piCJMqpw5AUttgessIAITPLWJaO3A+qlMe+
 PUr9gZMQ+9r6DSESkxqlBPaVq+uxZ6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716479004;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QhxA1Drz98mcW6B2A9ur26zJGthtVjMvSgkj5afRUsc=;
 b=NaoDfCLQDh07fEvStFcyfyKm8GWxa7zhOfC70n9AsZVvURcmlxy6ATUBfdtZ3najjjUPMV
 fMS88xXdCihpiVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 152E913A6C;
 Thu, 23 May 2024 15:43:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E6IPAxxkT2aaNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 May 2024 15:43:24 +0000
Date: Thu, 23 May 2024 17:43:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20240523154322.GC18111@pevik>
References: <20240523133132.13978-1-chrubis@suse.cz>
 <20240523133132.13978-3-chrubis@suse.cz>
 <20240523154113.GB18111@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240523154113.GB18111@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/msgstress01: Fix timeouts
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

> Hi,

> BTW I have found problem on Alpine:

OK, it's not Alpine related, but 32 bit related:

$ ./msgstress01
tst_test.c:1733: TINFO: LTP version: 20240129-290-g37fd02a1c
tst_test.c:1619: TINFO: Timeout per run is 0h 03m 30s
tst_pid.c:94: TINFO: Found limit of processes 40844 (from /sys/fs/cgroup/user.slice/user-1000.slice/pids.max)
msgstress01.c:269: TINFO: Available messages slots: 19045
msgstress01.c:166: TFAIL: Received wrong data at index 99: 6c != 1

Maybe worth of fixing. Regression from 90f80322a.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
