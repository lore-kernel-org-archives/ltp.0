Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBF7D1267E
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 10:40:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05AC73D1FEE
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 11:40:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F3303D1F7E
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 11:40:08 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AC4231A0BEBC
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 11:40:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58A411FBB2;
 Tue,  5 Nov 2024 10:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730803205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9yuW48o0IT7abmmo1VxGXxYuhD+XL67ontMn5ktHnA=;
 b=ylirwAOyCcF4IOBj/v7WKJGhkOTZJvcnJ8TRsFHMJcUQXK+iSs+qN6JXHnKL6LF6jHAj12
 ZysfNmJqKwYA5SdSja/fkZ0yOcVut9hUkBS7gWPhg74hsT9J9sc6ZgUaviVZMuJ6769Yhi
 jQZSTC7MjTWmDwXivZ4i1uaObrPFAMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730803205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9yuW48o0IT7abmmo1VxGXxYuhD+XL67ontMn5ktHnA=;
 b=ZAj7aV2KO4Y5OlY7wVbY4XB77SeDf5xpU2S6jBbQyp3NPgRfr95DwfhCo2L5QXAfyX+pAV
 6d8zy77fsQVpAfDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730803205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9yuW48o0IT7abmmo1VxGXxYuhD+XL67ontMn5ktHnA=;
 b=ylirwAOyCcF4IOBj/v7WKJGhkOTZJvcnJ8TRsFHMJcUQXK+iSs+qN6JXHnKL6LF6jHAj12
 ZysfNmJqKwYA5SdSja/fkZ0yOcVut9hUkBS7gWPhg74hsT9J9sc6ZgUaviVZMuJ6769Yhi
 jQZSTC7MjTWmDwXivZ4i1uaObrPFAMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730803205;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C9yuW48o0IT7abmmo1VxGXxYuhD+XL67ontMn5ktHnA=;
 b=ZAj7aV2KO4Y5OlY7wVbY4XB77SeDf5xpU2S6jBbQyp3NPgRfr95DwfhCo2L5QXAfyX+pAV
 6d8zy77fsQVpAfDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31BA513964;
 Tue,  5 Nov 2024 10:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aMMTCwX2KWe6VAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 05 Nov 2024 10:40:05 +0000
Date: Tue, 5 Nov 2024 11:40:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20241105104003.GA1573194@pevik>
References: <20241104153404.21273-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241104153404.21273-1-akumar@suse.de>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] crypto/af_alg0[13]: update tests for additional
 possible errno case
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
Cc: David Hildenbrand <david@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, Jan, David,

> kernel behaviour wrt checking invalid algorithms has changed [1] [2]
> updating the tests to address the additional errno case.
> Related discussion on the mailing list [3]

Looking at 57ab2160c0 ("move_pages04: remove special-casing for kernels < 4.3") [4]
recently reverting errnos for 4.3 d539a004dd ("move_pages04: fix zero page
status code for kernels >= 4.3") [5] please double check this already merged
change. I still believe it's a different case thus merging this is correct.
Also Eric is suggesting this (I should have added Suggested-by: tag for him).

Maybe we need some rules to clarify when we are ok with different errno and when not.

I also thought there would be some rule "don't hide kernel bugs", but I can't
find it in the docs.

Kind regards,
Petr

[4] https://github.com/linux-test-project/ltp/commit/d539a004dde3b760f610ef7cae90a96de8489ec8
[5] https://github.com/linux-test-project/ltp/commit/57ab2160c0b002cbeeb1cba477cf8875ca9d660d
[6] https://lore.kernel.org/lkml/20240924222839.GC1585@sol.localdomain/

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e7a4142b35ce489fc8908d75596c51549711ade0
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=795f85fca229a88543a0a706039f901106bf11c1
> [3] https://lore.kernel.org/lkml/20240924222839.GC1585@sol.localdomain/

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  lib/tst_af_alg.c                   | 1 +
>  testcases/kernel/crypto/af_alg01.c | 5 ++++-
>  testcases/kernel/crypto/af_alg03.c | 5 ++++-
>  3 files changed, 9 insertions(+), 2 deletions(-)

> diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
> index f5437c5c5..a14f9865c 100644
> --- a/lib/tst_af_alg.c
> +++ b/lib/tst_af_alg.c
> @@ -103,6 +103,7 @@ bool tst_have_alg(const char *algtype, const char *algname)
>  	case 0:
>  		return true;
>  	case ENOENT:
> +	case EINVAL:
>  		tst_res(TCONF, "kernel doesn't have %s algorithm '%s'",
>  			algtype, algname);
>  		return false;
> diff --git a/testcases/kernel/crypto/af_alg01.c b/testcases/kernel/crypto/af_alg01.c
> index 7cefe5946..2100b3698 100644
> --- a/testcases/kernel/crypto/af_alg01.c
> +++ b/testcases/kernel/crypto/af_alg01.c
> @@ -21,6 +21,7 @@ static void test_with_hash_alg(const char *hash_algname)
>  {
>  	char hmac_algname[64];
>  	char key[4096] = { 0 };
> +	int ret;

>  	if (!tst_have_alg("hash", hash_algname))
>  		return;
> @@ -30,7 +31,9 @@ static void test_with_hash_alg(const char *hash_algname)
>  		return;

>  	sprintf(hmac_algname, "hmac(hmac(%s))", hash_algname);
> -	if (tst_try_alg("hash", hmac_algname) != ENOENT) {
> +
> +	ret = tst_try_alg("hash", hmac_algname);
> +	if (ret != ENOENT && ret != EINVAL) {
>  		int algfd;

>  		tst_res(TFAIL, "instantiated nested hmac algorithm ('%s')!",
> diff --git a/testcases/kernel/crypto/af_alg03.c b/testcases/kernel/crypto/af_alg03.c
> index bb8d480e2..d7d385883 100644
> --- a/testcases/kernel/crypto/af_alg03.c
> +++ b/testcases/kernel/crypto/af_alg03.c
> @@ -15,10 +15,13 @@

>  static void run(void)
>  {
> +	int ret;
> +
>  	tst_require_alg("aead", "rfc7539(chacha20,poly1305)");
>  	tst_require_alg("hash", "sha256");

> -	if (tst_try_alg("aead", "rfc7539(chacha20,sha256)") != ENOENT) {
> +	ret = tst_try_alg("aead", "rfc7539(chacha20,sha256)");
> +	if ( ret != ENOENT && ret != EINVAL) {
>  		tst_res(TFAIL,
>  			"instantiated rfc7539 template with wrong digest size");
>  	} else {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
