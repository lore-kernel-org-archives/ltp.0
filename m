Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63021CA9EBE
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 01:43:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 222A23EAC1A
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 03:43:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF86D3E9C59
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 03:43:17 +0200 (CEST)
Received: from mta0.migadu.com (out-89.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::59])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 61879601944
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 03:43:10 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=nOY2+ofmq4up6z+VDoUwEQ+5mjBTwRL1o/nRfm6WzBA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791596589; v=1; x=1792201389;
 b=Rz7tr6LqIt+c0tor/Xo7RC2jpc1XoCXs+6sLzh3ngsXQYN/1xAEvQGSfYqg2URVb8InFyvX6
 hCO6QScLJoNgT/6Q91tzmM1TIE5e89ujznGVNjTnz36NJcUsFDFqwE+pByu/kZlYjqf6ij5ceTt
 ZtXnESWbggafxm+Ns/r/07Rg=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 5f982f91d3ba878f;
 Sat, 10 Oct 2026 01:43:09 +0000
X-Mizu-Trace-ID: 5f982f91d3ba878f
X-Migadu-Flow: FLOW_OUT
Date: Sat, 10 Oct 2026 09:43:06 +0800
From: Li Wang <li.wang@linux.dev>
To: linuxtestproject.agent@gmail.com
Message-ID: <asmYKk2G9HJ_X0Sg@linux.dev>
Mail-Followup-To: linuxtestproject.agent@gmail.com, ltp@lists.linux.it
References: <20261008052141.129763-2-li.wang@linux.dev>
 <20261008101402.9651-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261008101402.9651-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: add module is loaded check
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

linuxtestproject.agent@gmail.com wrote:

> --- [PATCH 1/4] ---
> 
> > diff --git a/include/tst_module.h b/include/tst_module.h
> > +bool tst_module_is_loaded(const char *mod_name);
> 
> Low: Add kernel-doc for this new public API, including mod_name and the
> return value. Document normalization, built-in modules, and the current
> false return when /proc/modules cannot be read.

No need, funtion name is clear enough.

> --- [PATCH 2/4] ---
> 
> > diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> > + * Called from do_test_cleanup() so that the modules are released when
> > + * the test finishes, regardless of the test result.
> 
> Low: The actual caller is do_cleanup(), in the library parent process,
> not do_test_cleanup(), which invokes the test's cleanup callback.
> Correct the lifecycle description.

No. We would do the unload in the lib-cleanup but not test_cleanup.

> > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> > +#define MAX_LOADED_MODULES 16
> > +	if (loaded_module_count < MAX_LOADED_MODULES)
> > +		loaded_modules[loaded_module_count++] = mod;
> 
> Medium: This commit already has 19 mappings, so a valid requirement list
> with all 19 available as modules passes the config check but queues only
> 16, silently omitting three required loads. Size the storage from the
> mapping table or allocate enough space instead of discarding entries.

True in theory, but rarely happens in practice. In LTP tests, I haven't
seen any test load more than 16 modules.

But to be on safe side, let's use 32.

> >  				kconfig_module_check(&vars[i]);
> > +				kconfig_module_record(vars[i].id);
> 
> Medium: kconfig_module_check() can change choice to 'n' for an uninstalled
> module, but this still queues it. For CONFIG_MMU | CONFIG_CAN_RAW with
> MMU=y and an uninstalled CAN_RAW=m, the expression succeeds, then loading
> can-raw aborts the otherwise runnable test. Queue only configs that
> remain enabled after checking, without making optional branches mandatory.

Good point, let's adding back v1 check:

	kconfig_runtime_check(&vars[i]);
 	kconfig_module_check(&vars[i]);
+	if (vars[i].choice == 'm')
+		kconfig_module_record(vars[i].id);

 
> > +	for (i = 0; i < loaded_module_count; i++) {
> > +		tst_res(TDEBUG, "Loading module '%s'", loaded_modules[i]);
> > +		tst_modprobe(loaded_modules[i], NULL);
> > +	}
> > +
> > +	modules_loaded = true;
> 
> High: If one modprobe succeeds and a later one aborts, modules_loaded is
> still false, so the cleanup helper returns without unloading the earlier
> module. Track each successful load immediately and let abort cleanup
> unload that successful prefix, not unattempted entries.

No. tst_modprobe() never calls tst_brk() internally, so a failed load
doesn't trigger the abort path at all, execution just continues.

> > +		const char *const argv[] = { "rmmod", loaded_modules[i - 1], NULL };
> > +		tst_cmd(argv, "/dev/null", "/dev/null", TST_CMD_PASS_RETVAL);
> 
> Medium: modprobe also inserts dependencies, but this removes only the
> explicitly recorded names. With CONFIG_CAN=m and CONFIG_CAN_RAW=m,
> loading can-raw also loads can; removing can-raw leaves the newly loaded,
> unused can module behind. Track newly loaded dependencies and remove
> only test-owned modules in dependency order.

Ok, maybe we can consider `modprobe -r`.

 
> --- [PATCH 3/4] ---
> 
> > The test also needs root to load the modules and to run as the
> > vsock_loopback transport is not available from an unprivileged user
> > namespace.
> > diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> > +	.needs_root = 1,
> 
> Low: Root is needed for module insertion, but loopback VSOCK on
> nonprivileged ports in the initial namespaces does not require root;
> an ordinary nonroot process is not an unprivileged user namespace.
> Correct the commit message and document the loading-only requirement in
> the test description. Drop privileges for the reproducer after the
> framework has loaded the modules.

Ok.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
