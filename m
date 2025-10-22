Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03045CCD1AB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 12:12:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D9E83CF0C7
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 14:12:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD9643CEDEE
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 14:12:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A9851200257
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 14:12:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F30221168;
 Wed, 22 Oct 2025 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761135129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOATducwgjJYNf5xRUUlUigG5jvG/objCWoK3h1UNoM=;
 b=nMFPJTmKqSCxr11/LtGHNRjCGNpQ+MLZOE+3j4M9FHGpbwDHJF0kADldkBgTCKvJmkIhzz
 BQl+5svEUU2l1TCEhTYjTVZJTtFvzqrKNxiCkpm+8gkNtwzmi1yJkaCZncu5mi1QNuHEKR
 C8NtJ98JlOZaT4mKdJDHDRy3CryDcs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761135129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOATducwgjJYNf5xRUUlUigG5jvG/objCWoK3h1UNoM=;
 b=96GHO7kE//mCSmmANRBvMOvx8HaS41atmVmupWfpqbD7dZ2SgkrfgNa345n2svaY1McU7X
 jhC14mw1l3K+vRBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0itR3CsJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=07dwfYMr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761135125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOATducwgjJYNf5xRUUlUigG5jvG/objCWoK3h1UNoM=;
 b=0itR3CsJ5T5nlGrp1T/WtXxreTrPSocGRF4zQ4f3XhI9YY3XPh0vWuBt8QoLXHivGvm04Y
 PSY3NXtfF1+3fvANCWLhIVrwRw3ZnB4SYobonn3gczgNpSQFAYLoBuguoDF1jnoykizsPt
 Co0apKLApNKYdVL75VtBLV3KZV63L9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761135125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOATducwgjJYNf5xRUUlUigG5jvG/objCWoK3h1UNoM=;
 b=07dwfYMrkhqVWXy+i2oBY4odwxdKrwib4Px9QAmfzvsuMFsfn+fxotX1tVMR4ecTVLlKRU
 U267ichU8LdJ9PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91A9413AAC;
 Wed, 22 Oct 2025 12:12:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ikGNIhTK+GjVHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Oct 2025 12:12:04 +0000
Date: Wed, 22 Oct 2025 14:12:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <20251022121203.GA481852@pevik>
References: <20251022115704.46936-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251022115704.46936-1-naresh.kamboju@linaro.org>
X-Rspamd-Queue-Id: 1F30221168
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux-test-project.readthedocs.io:url,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_pidfd05: accept both EINVAL and ENOTTY as
 valid errors
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
Cc: arnd@kernel.org, brauner@kernel.org, jack@suse.cz,
 regressions@lists.linux.dev, arnd@arndb.de, linux-kernel@vger.kernel.org,
 lkft-triage@lists.linaro.org, lkft-triage@linaro.org, ltp@lists.linux.it,
 benjamin.copeland@linaro.org, linux-fsdevel@vger.kernel.org,
 aalbersh@kernel.org, lkft@linaro.org, dan.carpenter@linaro.org,
 viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Naresh,

> Latest kernels return ENOTTY instead of EINVAL when invoking
> ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid).  Update the test to
> accept both EINVAL and ENOTTY as valid errors to ensure compatibility
> across different kernel versions.

Thanks a lot for contributing to LTP, we really appreciate it.

> Link: https://lore.kernel.org/all/CA+G9fYtUp3Bk-5biynickO5U98CKKN1nkE7ooxJHp7dT1g3rxw@mail.gmail.com
very nit: +1 for this. I prefer to reference it differently (e.g. [1]) as I add
Link: for referencing your actual patch the same way how it's used in kernel.
(e.g. Link: https://lore.kernel.org/ltp/20251022115704.46936-1-naresh.kamboju@linaro.org/)

> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> @@ -4,7 +4,7 @@
>   */

>  /*\
> - * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
> + * Verify that ioctl() raises an EINVAL or ENOTTY error when PIDFD_GET_INFO is used. This
nit: maybe note for ENOTTY: (from v6.18)?
>   * happens when:
>   *
>   * - info parameter is NULL
> @@ -14,6 +14,7 @@
>  #include "tst_test.h"
>  #include "lapi/pidfd.h"
>  #include "lapi/sched.h"
> +#include <errno.h>
>  #include "ioctl_pidfd.h"

>  struct pidfd_info_invalid {
> @@ -43,7 +44,22 @@ static void run(void)
>  		exit(0);

>  	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
> -	TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
> +	/* Expect ioctl to fail; accept either EINVAL or ENOTTY */
> +	TEST(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid));

I'm sorry, we prefer these macros in include/tst_test_macros.h which shorten the
code. Could you please use TST_EXP_FAIL_ARR() [1]?

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#macro-tst-exp-fail-arr

> +	if (TEST_RETURN == -1) {
> +		if (TEST_ERRNO == EINVAL || TEST_ERRNO == ENOTTY) {
> +			tst_res(TPASS,
> +				"ioctl(PIDFD_GET_INFO_SHORT) failed as expected with %s",
> +				tst_strerrno(TEST_ERRNO));
> +		} else {
> +			tst_res(TFAIL,
> +				"Unexpected errno: %s (expected EINVAL or ENOTTY)",
> +				tst_strerrno(TEST_ERRNO));
> +		}
> +	} else {
> +		tst_res(TFAIL, "ioctl(PIDFD_GET_INFO_SHORT) unexpectedly succeeded");
> +	}
> +

>  	SAFE_CLOSE(pidfd);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
