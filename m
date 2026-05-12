Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B44CD4F38
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 09:57:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A6503D0434
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 11:57:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D89A3CCDD4
 for <ltp@lists.linux.it>; Tue, 12 May 2026 11:56:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DBFBB140035E
 for <ltp@lists.linux.it>; Tue, 12 May 2026 11:56:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03F856C0D7;
 Tue, 12 May 2026 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778579811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ctL/08FdfN4d5X+gURXTbyU6guQdcT9vXHAqWtESKw=;
 b=nrvG45ugKOyGdbWYDKTWqnRRiWM33iSAwT+qGvBqcYIxp1GCn3dJD2TRwpjA9ZITAs5sIw
 uRXjMYDEUMoWBuirlmZgwHoB5oOGoDbxOZv/XH14uaR/x6STq/d3eLCHN7Z0wKZYEUPZ4r
 Llse8d4+u+36jX9pvGkcNNPrV3vVJ0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778579811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ctL/08FdfN4d5X+gURXTbyU6guQdcT9vXHAqWtESKw=;
 b=KS6XXBcOuHqhwQ/sJqxGbOXQM1BSF6m/cqZG4eVUBkD2sBsbjZuuHx3WCUonk+hLtbFuis
 Y6gEhWVDUmaY6aDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3K5kbl8h;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ec7MDN46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778579807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ctL/08FdfN4d5X+gURXTbyU6guQdcT9vXHAqWtESKw=;
 b=3K5kbl8hQe8I9xjF1LhrhT3stmz/FtVDL5jb9LiHXEPmWNTEpcrQu3OA/OYuwkwSMYiQpn
 gugr9PmhKf/5ZxPbB4rNtr/p7Z4r+t+U4HzN8ky0t97fIciimyJ4GCV/baayGoqeVzqK8T
 pbdWrfKreXTR1KQ1eU6DLTy9bNGgWc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778579807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ctL/08FdfN4d5X+gURXTbyU6guQdcT9vXHAqWtESKw=;
 b=Ec7MDN46isQ/ACad1vi9RI3qpFEQkLTSRJQUjOxm6MCzbSK8KMWXnIc12bjFLHTGhQxbEK
 5Tqg7RLfTz0tk8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0917593A9;
 Tue, 12 May 2026 09:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uvGeNV75AmqwUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 12 May 2026 09:56:46 +0000
Date: Tue, 12 May 2026 11:56:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <agL5X898iY6MXK75@yuki.lan>
References: <20260506112420.67516-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260506112420.67516-2-piotr.kubaj@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 03F856C0D7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v19] thermal: add new test group
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void setup(void)
> +{
> +	char line[8192];
> +
> +	nproc = tst_ncpus();
> +	tst_set_runtime(nproc * TEST_RUNTIME);

The last thing that I do not think is correct is this part. We are
setting the runtime here based on the number of CPUs and not based on
the number of actuall test iterations.

I guess that we need to:

  Turn the x86_pkg_temp_tz_found into a counter and collect the number
  of thermal zones found and set the runtime at the end of the setup
  with the counter instead.

And at the same time the TEST_RUNTIME appears to be significantly
smaller than the actual runtime.

  The upper bound for the runtime is a sum of all possible iterations,
  if we simplify it a bit it would be roughly ((RUNTIME+SLEEPTIME) *
  (SLEEPTIME/2))

  As we are doing SLEEPTIME iterations with SLEEPTIME and RUNTIME
  getting smaller in each of them so it will average out to SLEEPTIME/2
  iterations with full (RUNTIME+SLEEPTIME)

  So I guess that we need:

  #define TEST_RUNTIME ((RUNTIME+SLEEPTIME) * (SLEEPTIME/2))


The rest looks good to me.

With the runtime calculation fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
