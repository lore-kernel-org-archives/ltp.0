Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A07BE77188
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 12:43:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D3E33EFDBA
	for <ltp@archiver.kernel.org>; Thu,  2 Jan 2025 13:43:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92A593E56FA
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 13:43:29 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CDF291BD6750
 for <ltp@lists.linux.it>; Thu,  2 Jan 2025 13:43:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DEF52115E;
 Thu,  2 Jan 2025 12:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735821806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qmtv1oYQMP+9lvosjdba2hqE4gFqRH8wpC32/RpOhmk=;
 b=Szr1Y2DgHgNEQa7Rqb0/Gb4LMKLKvDialfgzmwj9uQvZpU2twp5fPSV7Pz0Lu6dnMc76wt
 42XfcFtwOA6DdvdSmCkjMQybRS40JSzoZ/n/Af4Z4ZBzAMHp/WAy0ERRonW9uLbBZ4CYOT
 tCrMuE8j74RMVaNCxwK5m0ScNOuC6+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735821806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qmtv1oYQMP+9lvosjdba2hqE4gFqRH8wpC32/RpOhmk=;
 b=ZhMFTL5lIHtFSds/kCd21XVAOuKK9ki+3p2uMfkQandJY0BLz3KzM8P5UflIvEPdtAjJFk
 t/V9Mklp3QGTQEAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735821806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qmtv1oYQMP+9lvosjdba2hqE4gFqRH8wpC32/RpOhmk=;
 b=Szr1Y2DgHgNEQa7Rqb0/Gb4LMKLKvDialfgzmwj9uQvZpU2twp5fPSV7Pz0Lu6dnMc76wt
 42XfcFtwOA6DdvdSmCkjMQybRS40JSzoZ/n/Af4Z4ZBzAMHp/WAy0ERRonW9uLbBZ4CYOT
 tCrMuE8j74RMVaNCxwK5m0ScNOuC6+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735821806;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qmtv1oYQMP+9lvosjdba2hqE4gFqRH8wpC32/RpOhmk=;
 b=ZhMFTL5lIHtFSds/kCd21XVAOuKK9ki+3p2uMfkQandJY0BLz3KzM8P5UflIvEPdtAjJFk
 t/V9Mklp3QGTQEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A16C813418;
 Thu,  2 Jan 2025 12:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UKLtI+2JdmdregAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 02 Jan 2025 12:43:25 +0000
Date: Thu, 2 Jan 2025 13:43:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250102124319.GA81987@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241222072251.13150-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigs
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, all,

[ Cc others to get broather feedback ]

> This refines the handling of timeouts for tests running on
> systems with slow kernel configurations (kconfigs).

> Previously, the max_runtime was multiplied globally when
> slow kconfigs were detected, which inadvertently prolonged
> the runtime of all tests using max_runtime for control.

> This patch corrects that behavior by applying the multiplication
> specifically to timeouts, ensuring it only affects the intended
> operations without impacting other tests.

> Fixes: 2da30df24 ("lib: multiply the max_runtime if detect slow kconfigs")

Thanks for handling this, I overlooked it on 27th, thus review it now.

Multiplying whole timeout instead of max_runtime helps to hide longer timeout
from the test which uses detection via tst_remaining_runtime(). I.e. previously
it behaved on slow config as LTP_RUNTIME_MUL=4, now as LTP_TIMEOUT_MUL=4.
Good idea. IMHO good enough (Martin previously suggested [1] to add a new
tst_test flag to identify tests which exit when runtime expires).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Some measurements on my Tumbleweed VM, which is detected as slow due CONFIG_LATENCYTOP:

TEST                                              | 2da30df24~ | 2da30df24  | this patch
--------------------------------------------------|-------------------------------------
swapping01.c (calls tst_remaining_runtime())      | 0h 10m 30s | 0h 40m 30s | 0h 12m 00s
tst_fuzzy_sync01.c (calls tst_remaining_runtime())| 0h 03m 00s | 0h 10m 30s | 0h 04m 30s
tst_cgroup02.c (default timeout 0h 00m 30s)       | 0h 00m 30s | 0h 00m 30s | 0h 02m 00s
test_runtime01.c (.max_runtime = 4, calls         | 0h 00m 34s | 0h 00m 46s | 0h 02m 04s
tst_remaining_runtime())
starvation.c (calls tst_remaining_runtime() only  | 0h 01m 05s | 0h 02m 50s | 0h 02m 34s
to detect failure)                                |

=> Tests which call tst_remaining_runtime() runs slightly longer, but IMHO
that's OK. Other tests (regardless if with the default runtime or these which
set .max_runtime) run 4* longer as expected.

Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/b6da77f3-45d6-4eed-b2d3-90ad20c63e50@suse.cz/

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  lib/tst_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 205fc8326..feffc9f86 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -555,9 +555,6 @@ static int multiply_runtime(int max_runtime)

>  	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);

> -	if (tst_has_slow_kconfig())
> -		max_runtime *= 4;
> -
>  	return max_runtime * runtime_mul;
>  }

> @@ -1706,6 +1703,9 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
>  	if (timeout < 1)
>  		tst_brk(TBROK, "timeout must to be >= 1! (%d)", timeout);

> +	if (tst_has_slow_kconfig())
> +		timeout *= 4;
> +
>  	return timeout * timeout_mul;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
