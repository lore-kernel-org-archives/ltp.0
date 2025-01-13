Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5A6C02180
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 16:02:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 188883C7964
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 17:02:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B125A3C06C1
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 17:02:35 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4C2911B601CA
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 17:02:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 834781F37E;
 Mon, 13 Jan 2025 16:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736784154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KoFhpe/lgFMzzl7KtNtqFftZoKSilIXN8Y1KRbAYdc=;
 b=VnqGgSjMbc0/c+ZVHoSM1Y6ruJlNKTE3m2W7ZoaIoMFAAvnVnviV1SWirV4Uss2mxu6C2S
 ZlTlF/4MQ9+sNyWSMh7Q76d0HRhxJQHl3qNSlbuCvZIZgsftvGYDH0tHwy0oRKVwAs+n1U
 k4jNMr4fsDEVYuPzvnavyc4kkuzubt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736784154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KoFhpe/lgFMzzl7KtNtqFftZoKSilIXN8Y1KRbAYdc=;
 b=9TM8RubfMdmanW+tOZTfm3nRbIxvAagVou5cxmFnhv9dvCofIqqpaLDTSLpmtfgAVVjlix
 w5+aV2H3JSgfxZAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736784154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KoFhpe/lgFMzzl7KtNtqFftZoKSilIXN8Y1KRbAYdc=;
 b=VnqGgSjMbc0/c+ZVHoSM1Y6ruJlNKTE3m2W7ZoaIoMFAAvnVnviV1SWirV4Uss2mxu6C2S
 ZlTlF/4MQ9+sNyWSMh7Q76d0HRhxJQHl3qNSlbuCvZIZgsftvGYDH0tHwy0oRKVwAs+n1U
 k4jNMr4fsDEVYuPzvnavyc4kkuzubt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736784154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/KoFhpe/lgFMzzl7KtNtqFftZoKSilIXN8Y1KRbAYdc=;
 b=9TM8RubfMdmanW+tOZTfm3nRbIxvAagVou5cxmFnhv9dvCofIqqpaLDTSLpmtfgAVVjlix
 w5+aV2H3JSgfxZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EEA013310;
 Mon, 13 Jan 2025 16:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Iy/rGRo5hWdmWQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 13 Jan 2025 16:02:34 +0000
Date: Mon, 13 Jan 2025 17:02:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Z4U5C3tHhDQ_pQTv@yuki.lan>
References: <20241217061636.16366-1-wegao@suse.com>
 <20250113081622.28942-1-wegao@suse.com>
 <20250113081622.28942-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250113081622.28942-2-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] ptrace05: Refactor the test using new LTP
 API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void print_dbg_sig(int signum)
>  {
> -	fprintf(stderr, "usage: %s [start-signum] [end-signum]\n", argv0);
> -	return 1;
> +	char const *strsig = tst_strsig(signum);
> +
> +	if (strstr(strsig, "???"))
> +		tst_res(TDEBUG, "[child] Sending kill(.., %d)", signum);
> +	else
> +		tst_res(TDEBUG, "[child] Sending kill(.., %s)", strsig);
>  }

This works around the library defficiencies. I would rather see patch
that changes the tst_strsig() return the number if we do not have a
match.

This should work:

diff --git a/lib/tests/tst_strsig.c b/lib/tests/tst_strsig.c
index 9a5ca80aa..ed5be3f00 100644
--- a/lib/tests/tst_strsig.c
+++ b/lib/tests/tst_strsig.c
@@ -29,6 +29,7 @@ int TST_TOTAL = 1;

 int main(void)
 {
+       fprintf(stderr, "0 = %s\n", tst_strsig(0));
        fprintf(stderr, "SIGKILL = %s\n", tst_strsig(SIGKILL));
        fprintf(stderr, "SIGALRM = %s\n", tst_strsig(SIGALRM));
        return 0;
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 7c66d2f6c..90403bc67 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -141,11 +141,14 @@ struct pair {
 #define PAIR(def) [def] = {.name = #def, .val = def},
 #define STRPAIR(key, value) [key] = {.name = value, .val = key},

-#define PAIR_LOOKUP(pair_arr, idx) do {                       \
-       if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) || \
-           pair_arr[idx].name == NULL)                       \
-               return "???";                                 \
-       return pair_arr[idx].name;                            \
+#define PAIR_LOOKUP(pair_arr, idx) do {                                    \
+       static char par_str_buf__[16];                                     \
+       if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) ||              \
+           pair_arr[idx].name == NULL) {                                  \
+               snprintf(par_str_buf__, sizeof(par_str_buf__), "%i", idx); \
+               return par_str_buf__;                                      \
+       }                                                                  \
+       return pair_arr[idx].name;                                         \
 } while (0)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
