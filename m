Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575CB106B529
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 12:50:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0535D3E5531
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 13:50:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AA9F3E2FFE
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:49:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A2FD3100077B
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 13:49:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1D2FD4D235;
 Wed, 25 Mar 2026 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774442980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDfaC7W61Y9blZJJCyDeQODH1Z07cHrVO71LJsqJ9Nw=;
 b=lDmPzBgJLV5CMDmK/x66L9MSvUTacWXDhPOYS5MsKgd44hGsYLeA0hcsFFrdR6jij5H/zU
 DsNAC6Eavn/hAJtCFFelN/Ur3+X3GbGhEY5WDYYo0A1Jr6Ihq8ZHSoN6NovY3Qozy0Db2N
 rLxOVplpottzZmoGHLSEo9HKk044BS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774442980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDfaC7W61Y9blZJJCyDeQODH1Z07cHrVO71LJsqJ9Nw=;
 b=8EAFIZteFybbBUNGe28NW3+wqoxWdKNmZjMHQXJ6r5SDw8bd3aSAtrjFW5H6IZHd4RRwnT
 H2MhtYPpxounvyDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lDmPzBgJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8EAFIZte
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774442980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDfaC7W61Y9blZJJCyDeQODH1Z07cHrVO71LJsqJ9Nw=;
 b=lDmPzBgJLV5CMDmK/x66L9MSvUTacWXDhPOYS5MsKgd44hGsYLeA0hcsFFrdR6jij5H/zU
 DsNAC6Eavn/hAJtCFFelN/Ur3+X3GbGhEY5WDYYo0A1Jr6Ihq8ZHSoN6NovY3Qozy0Db2N
 rLxOVplpottzZmoGHLSEo9HKk044BS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774442980;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JDfaC7W61Y9blZJJCyDeQODH1Z07cHrVO71LJsqJ9Nw=;
 b=8EAFIZteFybbBUNGe28NW3+wqoxWdKNmZjMHQXJ6r5SDw8bd3aSAtrjFW5H6IZHd4RRwnT
 H2MhtYPpxounvyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE673443E4;
 Wed, 25 Mar 2026 12:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YZVhMePZw2mNXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 25 Mar 2026 12:49:39 +0000
Date: Wed, 25 Mar 2026 13:49:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260325124930.GA114080@pevik>
References: <20260325105533.259287-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325105533.259287-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1D2FD4D235
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v14] thermal: add new test group
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, ltp@lists.linux.it, daniel.niestepski@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

Minor notes:

> +static void setup(void)
> +{
> +	char line[8192];
> +
> +	nproc = tst_ncpus();
> +	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
> +	interrupt_init = calloc(nproc, sizeof(uint64_t));
> +	interrupt_later = calloc(nproc, sizeof(uint64_t));
You correctly had SAFE_CALLOC() in v13, here you accident start using calloc()
again.

> +
> +	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
> +	struct dirent *entry;
> +
> +	while ((entry = SAFE_READDIR(dir))) {
> +		if ((!strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone") - 1)))
> +			tz_counter++;
> +	}
> +	SAFE_CLOSEDIR(dir);
> +	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
> +
> +	x86_pkg_temp_tz = calloc(tz_counter, sizeof(bool));
And here as well.

...
> +	memset(interrupts, 0, nproc * sizeof(*interrupts));
> +	FILE *fp = SAFE_FOPEN("/proc/interrupts", "r");
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (strstr(line, "Thermal event interrupts")) {
> +			interrupts_found = true;
> +			char *ptr = strchr(line, ':');
> +
> +			for (int i = 0; i < nproc; i++) {
> +				char *endptr;
> +
> +				while (*ptr && !isdigit(*ptr))
> +					ptr++;
> +
> +				errno = 0;
> +
> +				interrupts[i] = strtoull(ptr, &endptr, 10);
> +
> +				if (ptr == endptr)
> +					tst_brk(TBROK, "interrupt not found");
Printing CPU would help to debug on error, right?
					tst_brk(TBROK, "CPU %d: interrupt not found", nproc);

> +
> +				if (errno == ERANGE)
> +					tst_brk(TCONF, "interrupt out of range");
I would expect this is quite serious error (test bug), therefore TBROK should be
used, right?  TCONF is really for skipping the test due SUT not suitable for
running the test. But if the only error, it can be changed before merge.

					tst_brk(TBROK, "CPU %d: interrupt out of range", nproc);
...
> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.needs_drivers = (const char *const []) {
> +		"x86_pkg_temp_thermal",
> +		NULL
> +	},
> +	.min_runtime = 180,
You had .min_runtime = 5 sec in the v13, now again back 3 min.
As I wrote earlier, using tst_set_runtime() would be much better than expect 3
min run (on my laptop the test needs few sec, but it will waste time in case of
the test get stuck for whatever reason or might not enough for really big machine).

+#define	TEST_RUNTIME	3
 #define	RUNTIME		30
 #define	SLEEP		10
 #define	TEMP_INCREMENT	10
...
@@ -73,9 +74,10 @@ static void setup(void)
 	char line[8192];
 
 	nproc = tst_ncpus();
+	tst_set_runtime(nproc * TEST_RUNTIME);

This will lead to run in my machine:
tst_test.c:1887: TINFO: Overall timeout per run is 0h 00m 30s
tst_test.c:1908: TINFO: Updating runtime to 0h 00m 12s
tst_test.c:1887: TINFO: Overall timeout per run is 0h 00m 42s

I'd be ok to apply the following changes before merge. But I'd really prefer
Cyril to give ack to this before merge.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	.needs_root = 1,
> +	.setup = setup,
> +	.supported_archs = (const char *const []) {
> +		"x86",
> +		"x86_64",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "9635c586a559ba0e45b2bfbff79c937ddbaf1a62"},
> +		{}
> +	},
> +	.test_all = run
> +};

+++ testcases/kernel/thermal/thermal_interrupt_events.c
@@ -19,6 +19,7 @@
 #include "tst_test.h"
 #include "tst_timer_test.h"
 
+#define	TEST_RUNTIME	3
 #define	RUNTIME		30
 #define	SLEEP		10
 #define	TEMP_INCREMENT	10
@@ -52,10 +53,10 @@ static void read_interrupts(uint64_t *interrupts, const int nproc)
 				interrupts[i] = strtoull(ptr, &endptr, 10);
 
 				if (ptr == endptr)
-					tst_brk(TBROK, "interrupt not found");
+					tst_brk(TBROK, "CPU %d: interrupt not found", nproc);
 
 				if (errno == ERANGE)
-					tst_brk(TCONF, "interrupt out of range");
+					tst_brk(TBROK, "CPU %d: interrupt out of range", nproc);
 
 				ptr = endptr;
 				tst_res(TDEBUG, "interrupts[%d]: %ld", i, interrupts[i]);
@@ -73,9 +74,10 @@ static void setup(void)
 	char line[8192];
 
 	nproc = tst_ncpus();
+	tst_set_runtime(nproc * TEST_RUNTIME);
 	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
-	interrupt_init = calloc(nproc, sizeof(uint64_t));
-	interrupt_later = calloc(nproc, sizeof(uint64_t));
+	interrupt_init = SAFE_CALLOC(nproc, sizeof(uint64_t));
+	interrupt_later = SAFE_CALLOC(nproc, sizeof(uint64_t));
 
 	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
 	struct dirent *entry;
@@ -87,7 +89,7 @@ static void setup(void)
 	SAFE_CLOSEDIR(dir);
 	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
 
-	x86_pkg_temp_tz = calloc(tz_counter, sizeof(bool));
+	x86_pkg_temp_tz = SAFE_CALLOC(tz_counter, sizeof(bool));
 
 	for (int i = 0; i < tz_counter; i++) {
 		char path[PATH_MAX];
@@ -214,7 +216,6 @@ static struct tst_test test = {
 		"x86_pkg_temp_thermal",
 		NULL
 	},
-	.min_runtime = 180,
 	.needs_root = 1,
 	.setup = setup,
 	.supported_archs = (const char *const []) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
