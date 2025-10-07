Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10768CCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 14:36:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84B8C3CE45C
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 16:36:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE45D3C2B90
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 16:36:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 58E9E1A008BC
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 16:36:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2279E22110;
 Tue,  7 Oct 2025 14:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759847768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7lXds6e/XW3dAI+dnA2+TqpbPCM59EHIsqtoQKrCF8=;
 b=GTzNfpZZCXVi9MT50Y1dRRg+H1VnD5Z0mRRj/Sfc+HL0uOS0Hec4zpd55TgL3z8OBSYD1Q
 59M3UcUUAIyUkiYS7T+dTw0O5tR914+ZzlyPTYxAkCotgT9/lszUMI5WG3+gLZdJ2i57Ha
 Wta7S22lngBvBy9jXmj16Qvv/nejz7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759847768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7lXds6e/XW3dAI+dnA2+TqpbPCM59EHIsqtoQKrCF8=;
 b=RIUFgiyXl7I6BeOVTqTGLoTCDEtPRP4agZwXHVJ0pcwM/nbWi8w6J5zT3f83aLYwPR+zcn
 07o+kLXlaFfU6XCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759847768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7lXds6e/XW3dAI+dnA2+TqpbPCM59EHIsqtoQKrCF8=;
 b=GTzNfpZZCXVi9MT50Y1dRRg+H1VnD5Z0mRRj/Sfc+HL0uOS0Hec4zpd55TgL3z8OBSYD1Q
 59M3UcUUAIyUkiYS7T+dTw0O5tR914+ZzlyPTYxAkCotgT9/lszUMI5WG3+gLZdJ2i57Ha
 Wta7S22lngBvBy9jXmj16Qvv/nejz7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759847768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7lXds6e/XW3dAI+dnA2+TqpbPCM59EHIsqtoQKrCF8=;
 b=RIUFgiyXl7I6BeOVTqTGLoTCDEtPRP4agZwXHVJ0pcwM/nbWi8w6J5zT3f83aLYwPR+zcn
 07o+kLXlaFfU6XCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12CD113AAC;
 Tue,  7 Oct 2025 14:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mq8ZBFgl5WiRPgAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 07 Oct 2025 14:36:08 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 07 Oct 2025 16:36:07 +0200
Message-ID: <6213145.lOV4Wx5bFT@thinkpad>
In-Reply-To: <20251007143207.27848-1-akumar@suse.de>
References: <aOODn-CZ7F1A777o@yuki.lan> <20251007143207.27848-1-akumar@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] openposix: update invalid clock id to
 accomodate new auxiliary clock ids
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
Cc: pvore@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tuesday, October 7, 2025 4:32:06 PM CEST Avinesh Kumar wrote:
> Starting kernel v6.17, there are 8 more auxiliary clock ids reserved on
> systems with CONFIG_POSIX_AUX_CLOCK=y [1] and moreover posix systems can
> define and support any number of clocks beyond the mandatory ones.
> 
> [1] https://lore.kernel.org/lkml/20250519083025.905800695@linutronix.de/
> 
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  .../conformance/interfaces/clock_getres/6-2.c                | 5 ++---
>  .../conformance/interfaces/clock_gettime/8-2.c               | 4 ++--
>  .../conformance/interfaces/clock_settime/17-2.c              | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
> index c44809012..af45e27c9 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
> @@ -17,8 +17,7 @@
>   *   unassigned value = -1073743192 (ex. of what gcc will set to)
>   *   unassigned value = 1073743192 (ex. of what gcc will set to)
>   *   -1
> - *   17 (currently not = to any clock)
> - *
> + *   50 (hopefully big enough value not to be a valid clock id)
>   */
>  #include <stdio.h>
>  #include <time.h>
> @@ -33,7 +32,7 @@ int main(void)
>  	struct timespec res;
>  	int invalid_tests[NUMINVALIDTESTS] = {
>  		INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192,
> -		1073743192, -1, 17
> +		1073743192, -1, 50
>  	};
>  	int i;
>  	int failure = 0;
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
> index ed4cd4078..92263ce87 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
> @@ -15,7 +15,7 @@
>   *   unassigned value = -1073743192 (ex. of what gcc will set to)
>   *   unassigned value = 1073743192 (ex. of what gcc will set to)
>   *   -1
> - *   17 (currently not = to any clock)
> +  *   50 (hopefully big enough value not to be a valid clock id)
I see I added extra space in this one, please fix while merging if patch is fine.

Thanks,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
