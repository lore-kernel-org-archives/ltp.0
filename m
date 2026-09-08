Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1EAC79F82
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 15:34:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AC523E94B5
	for <ltp@archiver.kernel.org>; Tue,  8 Sep 2026 17:34:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 578A63C7449
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 17:34:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 05E3F1400C7A
 for <ltp@lists.linux.it>; Tue,  8 Sep 2026 17:34:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C14E1F81C;
 Tue,  8 Sep 2026 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788881639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PmCxqVTDX+BE5d7x4aOq5nGhy5zkURdZepfF5JqxYBw=;
 b=O6EGYOR+G0oIZNGXtqcPfFrQTp4RbupX24irlVA0HlhtDxV7LbnCznAooF1G4iqlmba9SB
 eOn6/l6vnI9XUuHc7qhxh7sMwneGPoV0SqmV7eNY/SiwjJqkw6ydiWMsWGPVC6b2Zwnhh3
 JUNgTq7vIIcIMY7b/+iBe3noMf/oDiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788881639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PmCxqVTDX+BE5d7x4aOq5nGhy5zkURdZepfF5JqxYBw=;
 b=v44/M5WoIHbo18NV1icTAhYmFCB04SfTXeDaDJU+MD7qPFnMZ5OYWKSZILnJ1tG5a8xvtr
 Q3zNED0JdrNaouAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788881638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PmCxqVTDX+BE5d7x4aOq5nGhy5zkURdZepfF5JqxYBw=;
 b=ByGA8aE8/rpBMjaR2MEkfJ13RQsNKvqesRx/OIkT+VFHQOmro2ITTrvKpHF93R6OfQ5Raz
 Sm9BfHMDqcBO5bBvimP83wZKghnTysN+4o+0nCTskOTI5NQadvxzNr2AcwmrAJRMcfRFLw
 tQxPpjGoH0REN44v2bl9FGyPDZ+C3Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788881638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PmCxqVTDX+BE5d7x4aOq5nGhy5zkURdZepfF5JqxYBw=;
 b=Mc21FESR64Mz7wnHjURyVCmTR5F80apLuOUFQVMiJPn/vKz9CNNkz35LLP8GUvg2qXobsb
 TpK1ZqvUYuL6jwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12AF713332;
 Tue,  8 Sep 2026 15:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UQWMBOYqoGodTAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 08 Sep 2026 15:33:58 +0000
Date: Tue, 8 Sep 2026 17:34:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqAq70zXDbhPv6_w@yuki.lan>
References: <20260908-coredump-v8-0-591f96004543@suse.com>
 <20260908-coredump-v8-1-591f96004543@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260908-coredump-v8-1-591f96004543@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/2] coredump01: New core_pattern specifiers
 test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void set_pattern(const char *fmt, ...)
> +{
> +	char pattern[PATTERN_MAX];
> +	char readback[PATTERN_MAX];
> +	va_list va;
> +	int len;
> +
> +	va_start(va, fmt);
> +	len = vsnprintf(pattern, sizeof(pattern), fmt, va);
> +	va_end(va);
> +
> +	if (len >= PATTERN_MAX)
> +		tst_brk(TCONF, "core_pattern does not fit into %i bytes", PATTERN_MAX - 1);
> +
> +	SAFE_FILE_PRINTF(PATH_KERN_CORE_PATTERN, "%s", pattern);

We actually have safe_file_vprintf() it's not just exposed, we can
easily expose the API with:

diff --git a/include/tst_safe_file_ops.h b/include/tst_safe_file_ops.h
index 73ebd2ab8..f3b322072 100644
--- a/include/tst_safe_file_ops.h
+++ b/include/tst_safe_file_ops.h
@@ -65,6 +65,10 @@ void safe_file_read_str(const char *file, const int lineno,
        safe_file_printf(__FILE__, __LINE__, NULL, \
                         (path), (fmt), ## __VA_ARGS__)

+#define SAFE_FILE_VPRINTF(path, fmt, va) \
+       safe_file_vprintf(__FILE__, __LINE__, NULL, \
+                        (path), (fmt), va)
+
 /* Same as SAFE_FILE_PRINTF() but returns quietly if the path doesn't exist */
 #define SAFE_TRY_FILE_PRINTF(path, fmt, ...) \
        safe_try_file_printf(__FILE__, __LINE__, NULL, \
diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index 19da1fd97..1069a017f 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -280,7 +280,7 @@ err:
        return 1;
 }

-static void safe_file_vprintf(const char *file, const int lineno,
+void safe_file_vprintf(const char *file, const int lineno,
        void (*cleanup_fn)(void), const char *path, const char *fmt,
        va_list va)
 {



And then we can do SAFE_FILE_VPRINTF() here directly instead of the
double printf().


The rest looks fine:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
