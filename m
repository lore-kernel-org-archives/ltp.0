Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD401CA6007
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 05:10:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 883793E2C3C
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 07:10:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAADF3C5AD6
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 07:10:14 +0200 (CEST)
Received: from mta0.migadu.com (out-42.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0A62F60057F
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 07:10:13 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=rl4r3ffIw/v3r2AsMirOe/1yARTSGEIpsn2tEf7Pns0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791436212; v=1; x=1792041012;
 b=eaDdvCje4GcOWi4flJe0SMqaWOfBQ607SuLaGDo+49BgNzJ3DsYTidt+8s3CjzHL4vvCG35G
 GAKyGchV2BwHw9TeqA1C18hmefuT/PozASvst+INbTNgbcQgSKvU/tjSvqXk9INYi29a/Ts/c/j
 qkYGFRfLPqwZKJ5qnIvSxY+I=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 7188bd766941ff3a;
 Thu, 08 Oct 2026 05:10:11 +0000
X-Mizu-Trace-ID: 7188bd766941ff3a
X-Migadu-Flow: FLOW_OUT
Date: Thu, 8 Oct 2026 13:09:58 +0800
From: Li Wang <li.wang@linux.dev>
To: linuxtestproject.agent@gmail.com
Message-ID: <asclptsE0nKmz2eq@linux.dev>
Mail-Followup-To: linuxtestproject.agent@gmail.com, ltp@lists.linux.it
References: <20261007105730.94492-2-li.wang@linux.dev>
 <20261007141758.9828-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261007141758.9828-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_kconfig: load and unload kernel modules for CONFIG_*=m
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

On Wed, Oct 07, 2026 at 02:17:58PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Li,
> 
> On Wed, 7 Oct 2026, Li Wang wrote:
> > tst_kconfig: load and unload kernel modules for CONFIG_*=m
> 
> --- [PATCH 1/3] ---
> 
> > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> > +	if (loaded_module_count < MAX_LOADED_MODULES)
> > +		loaded_modules[loaded_module_count++] = mod;
> 
> High: This records config matches, not modules newly loaded by the test,
> so cleanup can remove an unused module that was already loaded beforehand.
> A read-only tst_kconfig_read() during a callback also adds unload targets
> without loading them. Separate config discovery from ownership tracking
> and unload only modules successfully added by this test.

Good point, will fix it in v2.

> 
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > +	tst_kconfig_module_unload_all();
> 
> High: Loading happens once in the library parent, but this cleanup runs
> in each test child. Setup aborts and killed children leak modules, later
> variants can lose modules removed by the first child, and cve-2026-46331
> cannot unload after dropping initial-user-namespace privileges. Move
> unloading to parent do_cleanup(), after all variants and resource teardown.

Agreed.

> 
> > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> > +		tst_modprobe(loaded_modules[i], NULL);
> > +		const char *const argv[] = { "rmmod", loaded_modules[i - 1], NULL };
> 
> Medium: modprobe also inserts dependencies that this list never records;
> with both initially absent, loading can-raw inserts can, but cleanup only
> removes can-raw and leaves can loaded. Track newly inserted dependencies
> relative to the initial module state and remove owned modules in
> dependency order.
> 
> > diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> > +/*
> > + * tst_kconfig_module_load() - Load kernel modules for CONFIG_*=m entries.
> 
> Low: Both new public API comments use /* rather than /** and are omitted
> from the generated kernel-doc reference. Use kernel-doc comment openers
> for both declarations.

+1

> 
> --- [PATCH 2/3] ---
> 
> > Map CONFIG_VSOCKETS and CONFIG_VSOCKETS_LOOPBACK to their kernel
> > modules (vsock, vsock_loopback).
> 
> Low: The body only restates the mappings and does not explain the new
> config and privilege gates in cve-2025-21756. Explain the missing-loopback
> bind failure and why the test now requires root.

Will add the note in v2.

> 
> > diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> > +	.needs_root = 1,
> 
> Low: Document this new root requirement in the test's high-level
> description, identifying module loading as the privileged operation.

Sure.

> 
> --- [PATCH 3/3] ---
> 
> > diff --git a/testcases/kernel/syscalls/keyctl/keyctl29.c b/testcases/kernel/syscalls/keyctl/keyctl29.c
> > -	tst_modprobe("x509_key_parser", NULL);
> > diff --git a/testcases/kernel/syscalls/keyctl/keyctl30.c b/testcases/kernel/syscalls/keyctl/keyctl30.c
> > -	tst_modprobe("pkcs8_key_parser", NULL);
> 
> Medium: With KCONFIG_SKIP_CHECK=1, tst_kconfig_check() returns before
> recording modules, leaving these removed loads without a replacement.
> When parser modules are installed but unloaded, keyctl29/keyctl30 now
> skip with EBADMSG instead of executing their checks. Preserve module
> setup independently of config validation, or retain the explicit loads.

With KCONFIG_SKIP_CHECK=1 the config check returns early and the
automatic module loading is skipped as well. However, I consider
that the intended behaviour rather than a regression.

KCONFIG_SKIP_CHECK=1 is an explicit opt-out from the kernel config
check. Loading the modules depends on the result of that check: the
list of modules is built by kconfig_parse_line() while parsing the
config, and with the check skipped that parsing never happens. To
load the modules anyway we would have to either re-parse the config,
which contradicts the whole point of skipping it, or hardcode the
module list, which would duplicate config_module_maps[].

So skipping the automatic load together with the config check keeps
the semantics consistent: KCONFIG_SKIP_CHECK=1 skips everything that
depends on the config check, and users who set it are expected to
make sure the modules their tests need are already loaded.

The affected tests are still executed normally when the config check
runs, which is the default. I've added a note to the commit message
to make the KCONFIG_SKIP_CHECK=1 behaviour explicit.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
