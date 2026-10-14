Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BFBCC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 03:37:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23F313EB10D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 05:36:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6C6D3E6AA4
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 05:36:42 +0200 (CEST)
Received: from mta1.migadu.com (out-115.mta1.migadu.com
 [IPv6:2001:41d0:203:375::73])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F29D410009EA
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 05:36:39 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=5ET5eTA1vk6Xg+OPPHhdUwR84Bl5j5YjlQtXkX9ludY=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791948998; v=1; x=1792553798;
 b=Q6Mn78ADiTngxpQ8SZ3yFIniLsWP69+5jJL9l+YI37F9aDuEbZqUA262hRKCRkBzFff3CSVK
 CmjPMhVVUeJVaqKEj1+eGE8z5nTvq/0w3qM07jjlua5JmI7xEePzK3khbX/Ox339Zzcz5fzNeSK
 eslP0Kf4klGJ+3qCUSsKjK1M=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id c3d6655bd306e321;
 Wed, 14 Oct 2026 03:36:38 +0000
X-Mizu-Trace-ID: c3d6655bd306e321
X-Migadu-Flow: FLOW_OUT
Date: Wed, 14 Oct 2026 11:36:31 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <as74VdT9VULCDMWM@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.com>,
 ltp@lists.linux.it
References: <20261010033622.68927-3-li.wang@linux.dev>
 <KAcS5WJbQyPKbiDel0IQZfd4x2rnMBTRIRb9@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <KAcS5WJbQyPKbiDel0IQZfd4x2rnMBTRIRb9@localhost.localdomain>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] tst_kconfig: load and unload kernel
 modules for CONFIG_*=m
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

On Mon, Oct 12, 2026 at 04:09:29PM +0000, Andrea Cervesato wrote:
> Hi Li,
> 
> > +static const char *module_name_for_config(const char *cfg)
> > +{
> > +	size_t i;
> > +
> > +	for (i = 0; config_module_maps[i].config; i++) {
> > +		if (!strcmp(config_module_maps[i].config, cfg))
> > +			return config_module_maps[i].module_name;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> This is used only once, we don't need to define a new function.
> We can leave it inside kconfig_module_record().
+1

> > +
> > +static void kconfig_module_record(const char *cfg)
> > +{
> > +	unsigned int i;
> > +	const char *mod = module_name_for_config(cfg);
> > +
> > +	if (!mod)
> > +		return;
> > +
> > +	if (tst_module_is_loaded(mod))
> > +		return;
> > +
> > +	for (i = 0; i < loaded_module_count; i++) {
> > +		if (!strcmp(loaded_modules[i], mod))
> > +			return;
> > +	}
> > +
> > +	if (loaded_module_count < MAX_LOADED_MODULES)
> > +		loaded_modules[loaded_module_count++] = mod;
> > +}
> > +
> >  static inline int kconfig_parse_line(const char *line,
> >                                       struct tst_kconfig_var *vars,
> >                                       unsigned int vars_len)
> > @@ -268,6 +307,8 @@ out:
> >  				vars[i].choice = 'm';
> >  				kconfig_runtime_check(&vars[i]);
> >  				kconfig_module_check(&vars[i]);
> > +				if (vars[i].choice == 'm')
> 
> This is better to have it inside kconfig_module_record() at the
> very beginning as a gate.

Good point, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
