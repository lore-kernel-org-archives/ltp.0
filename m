Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3635D73EA8
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 23:39:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C0523CBEC7
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 00:39:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AE663CB260
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 00:39:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 01B281000D86
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 00:38:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 690DE343BB;
 Thu, 29 Jan 2026 23:38:59 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE653EA61;
 Thu, 29 Jan 2026 23:38:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ddbyBJPve2mQRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 29 Jan 2026 23:38:59 +0000
Date: Fri, 30 Jan 2026 00:38:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <20260129233857.GB110393@pevik>
References: <20260129111556.501121-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260129111556.501121-2-piotr.kubaj@intel.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 690DE343BB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr, all,

...
> +static void setup(void)
> +{
> +	char line[8192];
> +
> +	nproc = tst_ncpus();
> +	tst_res(TDEBUG, "Number of logical cores: %d", nproc);
> +	interrupt_init = calloc(nproc, sizeof(uint64_t));
> +	interrupt_later = calloc(nproc, sizeof(uint64_t));
> +
> +	DIR *dir = SAFE_OPENDIR("/sys/class/thermal/");
> +	struct dirent *entry;
> +
> +	tz_counter = 0;
> +
> +	while ((entry = SAFE_READDIR(dir))) {
> +		if ((strncmp(entry->d_name, "thermal_zone", sizeof("thermal_zone"))) > 0)
> +			tz_counter++;
> +	}
> +	SAFE_CLOSEDIR(dir);
> +	tst_res(TDEBUG, "Found %d thermal zone(s)", tz_counter);
> +
> +	interrupts(interrupt_init, nproc);
> +
> +	x86_pkg_temp_tz = calloc(tz_counter, sizeof(bool));
> +
> +	for (int i = 0; i < tz_counter; i++) {
> +		char path[NAME_MAX];
> +
> +		snprintf(path, NAME_MAX, "/sys/class/thermal/thermal_zone%d/type", i);
> +		tst_res(TDEBUG, "Checking whether %s is x86_pkg_temp", path);
> +
> +		SAFE_FILE_SCANF(path, "%s", line);
> +		if (strstr(line, "x86_pkg_temp")) {
> +			tst_res(TDEBUG, "Thermal zone %d uses x86_pkg_temp", i);
> +			x86_pkg_temp_tz[i] = 1;
> +			x86_pkg_temp_tz_found = 1;
> +		}
> +	}
> +
> +	if (!x86_pkg_temp_tz_found)
> +		tst_brk(TCONF, "No thermal zone uses x86_pkg_temp");
NOTE: any tst_brk() causes cleanup() being called before test exit.

> +}
> +
> +static void cleanup(void)
> +{
Therefore this must be guarded:
> +	SAFE_FILE_PRINTF(trip_path, "%d", trip);

if (x86_pkg_temp_tz_found)
	SAFE_FILE_PRINTF(trip_path, "%d", trip);

(Detectable on machine without x86_pkg_temp, e.g. VM).

Kind regards,
Petr

> +	free(interrupt_init);
> +	free(interrupt_later);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
