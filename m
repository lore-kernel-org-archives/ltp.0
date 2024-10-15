Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF980CFC27C
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 15:45:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D67713C6789
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 17:45:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52C353C287C
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 17:45:39 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8789D1A00CAF
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 17:45:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 94EB31F7F0;
 Tue, 15 Oct 2024 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729007137;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrUkRrYFyMdbmw8fidrMXfO1KOaGfDS6ThKmG1fuEps=;
 b=21475pqoJz+Px80dEh14MY2PcULcltfjUPKkNPwzpMJ5PSSFI5ldpiIMeePsRO8/vHQn+R
 jiIM7wgWd3PHJaDNeLm0zBam4d1oR1zo00eFiU55HZARFFRy8rTi8Zh83L3wiPETNhT0Ql
 rl73TMntHNPAYcNvRxa3g6XOp+NfwhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729007137;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrUkRrYFyMdbmw8fidrMXfO1KOaGfDS6ThKmG1fuEps=;
 b=53SgMdGGsAM7tgyCB6j64B2MHExIGbJEPMtMzq/Lx+FAbOcmB8INTh+HBcUEWODrodOFvh
 PfG8XRrwHRnUUaAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729007137;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrUkRrYFyMdbmw8fidrMXfO1KOaGfDS6ThKmG1fuEps=;
 b=21475pqoJz+Px80dEh14MY2PcULcltfjUPKkNPwzpMJ5PSSFI5ldpiIMeePsRO8/vHQn+R
 jiIM7wgWd3PHJaDNeLm0zBam4d1oR1zo00eFiU55HZARFFRy8rTi8Zh83L3wiPETNhT0Ql
 rl73TMntHNPAYcNvRxa3g6XOp+NfwhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729007137;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrUkRrYFyMdbmw8fidrMXfO1KOaGfDS6ThKmG1fuEps=;
 b=53SgMdGGsAM7tgyCB6j64B2MHExIGbJEPMtMzq/Lx+FAbOcmB8INTh+HBcUEWODrodOFvh
 PfG8XRrwHRnUUaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B33213A42;
 Tue, 15 Oct 2024 15:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UsiUAyGODmclHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Oct 2024 15:45:37 +0000
Date: Tue, 15 Oct 2024 17:45:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241015154535.GA31165@pevik>
References: <20240916113308.16749-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240916113308.16749-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Remove now unsupported power management tests
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

[ Cc automated-testing@lists.yoctoproject.org ]

> The sched_mc_power_savings and sched_smt_power_savings sysfs knobs
> were removed from kernel in:

> commit 8e7fbcbc22c12414bcc9dfdd683637f58fb32759
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Mon Jan 9 11:28:35 2012 +0100

>     sched: Remove stale power aware scheduling remnants and dysfunctional knobs

> That went into kernel 3.5 and the minimal kernel version LTP currently
> supports is 3.10.

Good catch.

I wanted to be happy that whole power management testsuite is being removed
(legacy unmaintained code written in python which is not preferred language for
LTP).  But it's really just the unsupported subset. Otherwise
power_management_tests would need to be removed from scenario_groups/default.

> This has been discussed in:

> https://github.com/linux-test-project/ltp/pull/1016

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/power_management_tests                |   3 -
>  runtest/power_management_tests_exclusive      |   6 -
>  testcases/kernel/power_management/.gitignore  |   1 -
>  testcases/kernel/power_management/README      |  29 ----
>  .../power_management/pm_cpu_consolidation.py  | 143 ------------------
>  .../power_management/pm_get_sched_values.c    |  36 -----
>  .../kernel/power_management/runpwtests01.sh   |  71 ---------
>  .../kernel/power_management/runpwtests02.sh   |  68 ---------
>  .../kernel/power_management/runpwtests05.sh   |  76 ----------

Deleted runpwtests05.sh was the only file which used pm_sched_domain.py
and pm_ilb_test.py.

And when these python scripts are deleted, there is still some dead
code in testcases/kernel/power_management/lib/pm_sched_mc.py which works with
sched_mc_power_savings: reset_schedmc() and set_sched_mc_power()
and with set_sched_smt_power: set_sched_smt_power() and reset_schedsmt().

Could you please delete these. With this:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
