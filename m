Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4627C636D4
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 07:48:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABA313CBE53
	for <ltp@archiver.kernel.org>; Fri, 17 Feb 2023 08:48:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE36B3CB05F
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 08:48:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E998E60083F
 for <ltp@lists.linux.it>; Fri, 17 Feb 2023 08:48:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FF721F749;
 Fri, 17 Feb 2023 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676620096;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDVuUdCVz/mCjqco1rRIoNV7ST47Pnnm1whdEU0yYkU=;
 b=i+tHxa3OeLe9iJwcFGDoNTPm5gOExOz0ibVdp1Izr37RmivHgGl3M41Sh0N/a7wA25bvNJ
 VUDLIu3GKN0QQABEiwqYPDcJ8t0+HA0DDISl/9Ho2LJSN1j9Pi3t7y/6Nx2nmoApMiiHMF
 O9zHXdTk1XhYnm/3RoO3RytgmSjNWbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676620096;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDVuUdCVz/mCjqco1rRIoNV7ST47Pnnm1whdEU0yYkU=;
 b=WbSuq8DDAM9BB+lKFMIF3pf1hFxRMSHF06DCmNyLtqG0pHjvQHt3hBgEDRbTzMDNdP3uVt
 LCyaQlgMRpyaqfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88B9F13274;
 Fri, 17 Feb 2023 07:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VTD3Hj8x72NRbwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Feb 2023 07:48:15 +0000
Date: Fri, 17 Feb 2023 08:48:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y+8xM+n6OTP5oCuj@pevik>
References: <20230213010924.12352-1-wegao@suse.com>
 <20230216235218.25757-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230216235218.25757-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] fsconfig03: New test CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> +/*\
> + * [Description]
> + *
> + * Test for CVE-2022-0185.
> + *
> + * References links:
Here needs to be empty blank line (can be fixed before merge).

> + * - https://www.openwall.com/lists/oss-security/2022/01/25/14
> + * - https://github.com/Crusaders-of-Rust/CVE-2022-0185
> + */

Otherwise the final formatting will be without list:
References links: - https://www.openwall.com/lists/oss-security/2022/01/25/14 - https://github.com/Crusaders-of-Rust/CVE-2022-0185

We need some checker which reports that, because nobody knows it.
I also forget on it when putting example for v2.

> +
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +
> +#define MNTPOINT	"mntpoint"
> +
> +static int fd = -1;
> +
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +}
> +
> +static void run(void)
> +{
> +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> +	long pagesize;
> +
> +	TEST(fd = fsopen(tst_device->fs_type, 0));
> +	if (fd == -1)
> +		tst_brk(TBROK | TTERRNO, "fsopen() failed");

Yes, this is needed to be in test function (it's not enough to be in the
setup()).
> +
> +	pagesize = sysconf(_SC_PAGESIZE);
> +	if (pagesize == -1)
> +		tst_brk(TBROK, "sysconf(_SC_PAGESIZE) failed");
> +
> +	for (size_t i = 0; i < 5000; i++) {
> +		/* use same logic in kernel legacy_parse_param function */
> +		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
> +
> +		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize) {
> +			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> +			if (TST_ERR)
> +				return;
> +		} else {
> +			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> +					    EINVAL);
> +			if (!TST_PASS)
> +				return;
> +		}
> +	}
> +
> +	if (fd != -1)
> +		SAFE_CLOSE(fd);
Very good to catch open file descriptor leak (which would leak if this was in
cleanup()).

> +
> +	tst_res(TPASS, "fsconfig() overflow on %s haven't triggerred crash",
> +			tst_device->fs_type);
> +}

It looks to be ready from my site, I'll test it on various kernels to double
check any problem.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
