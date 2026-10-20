Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC38606A31B
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UW53GdoH;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=z3sRe5ck;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=UW53GdoH;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=z3sRe5ck
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CF373E9E10
	for <ltp@archiver.kernel.org>; Tue, 20 Oct 2026 11:50:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 178183E9E10
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 11:50:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6D52C140098B
 for <ltp@lists.linux.it>; Tue, 20 Oct 2026 11:49:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DB8721CD7;
 Tue, 20 Oct 2026 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792489797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0mYOwcwUd2BBxtOLxENVeAz3++cFscwh973y/i6clg=;
 b=UW53GdoHh2bRr6tmtLv9p9s7YwGm7dD3N31u72Ito2v/iWntndukR5WsesoyWOyqSXnkIO
 ga8waldRpH2/wZidqyTVa8SB9AKEgOSXmZk0XMFs1+iJrMvN7/i8Sg6S2Wl2+wO1px1Dqv
 JZ+SeYqj1BqSUOPgQ1xsVKKTcTA7IE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792489797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0mYOwcwUd2BBxtOLxENVeAz3++cFscwh973y/i6clg=;
 b=z3sRe5ckCcJDaATPKn+522hP8dZOd9QjxpeSWiGZHvXc1alL8jYJhU9X63uKkLVR6ebhA1
 j4phGpIeU9h8xKAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792489797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0mYOwcwUd2BBxtOLxENVeAz3++cFscwh973y/i6clg=;
 b=UW53GdoHh2bRr6tmtLv9p9s7YwGm7dD3N31u72Ito2v/iWntndukR5WsesoyWOyqSXnkIO
 ga8waldRpH2/wZidqyTVa8SB9AKEgOSXmZk0XMFs1+iJrMvN7/i8Sg6S2Wl2+wO1px1Dqv
 JZ+SeYqj1BqSUOPgQ1xsVKKTcTA7IE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792489797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q0mYOwcwUd2BBxtOLxENVeAz3++cFscwh973y/i6clg=;
 b=z3sRe5ckCcJDaATPKn+522hP8dZOd9QjxpeSWiGZHvXc1alL8jYJhU9X63uKkLVR6ebhA1
 j4phGpIeU9h8xKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ED92136C6;
 Tue, 20 Oct 2026 09:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QdMeO0Q512pBFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 20 Oct 2026 09:49:57 +0000
Date: Tue, 20 Oct 2026 11:50:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Li Wang (Hieco)" <li.wang@linux.dev>
Message-ID: <atc5USFImqRKPt82@yuki.lan>
References: <20261020080033.123660-1-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261020080033.123660-1-li.wang@linux.dev>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -8.30
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sys_hwmon01: always report a result
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  #include "tst_test.h"
>  #include "tst_sysfs_assert.h"
> @@ -56,39 +58,67 @@
>  
>  #define MAX_CHANNELS 32
>  
> +static unsigned int checked;
> +
> +static int sysfs_attr_exists(const char *fmt, ...)
> +{
> +	char path[PATH_MAX];
> +	va_list va;
> +
> +	va_start(va, fmt);
> +	vsnprintf(path, sizeof(path), fmt, va);
> +	va_end(va);
> +
> +	return tst_sysfs_exists(path);
> +}

Uff, the tst_sysfs_attr_exists() does work with printf-like parameters.

What do we need the this wrapper for?

> +#define CHECK_RANGELL(lo, hi, ...) do { \
> +	if (sysfs_attr_exists(__VA_ARGS__)) { \
> +		checked++; \
> +		TST_SYSFS_ASSERT_RANGELL_SILENT(lo, hi, __VA_ARGS__); \
> +	} \
> +} while (0)
> +
> +#define CHECK_BOOL(...) do { \
> +	if (sysfs_attr_exists(__VA_ARGS__)) { \
> +		checked++; \
> +		TST_SYSFS_ASSERT_BOOL_SILENT(__VA_ARGS__); \
> +	} \
> +} while (0)

What about we add the counter into the sysfs library instead?

If we add:

void tst_sysfs_cnt_reset(void);

unsigned int tst_sysfs_cnt_get(void);

We can call the tst_sysfs_cnt_rest() at the start of the test function,
and get the counter at the end.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
