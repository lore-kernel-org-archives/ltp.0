Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AC3C982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:42:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7316C3E6D42
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 18:42:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFC263E5D6F
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:41:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 590401000DB3
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 18:41:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D66C6219C7;
 Tue, 22 Sep 2026 16:41:50 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CD8B1365D;
 Tue, 22 Sep 2026 16:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mGQYGc6vsmrWSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 16:41:50 +0000
Date: Tue, 22 Sep 2026 18:41:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260922164145.GA2272799@pevik>
References: <20260922105840.2193537-1-pvorel@suse.cz>
 <arJiBgKNC80acBfY@yuki.lan> <20260922112916.GB2191017@pevik>
 <arJ5l2SxNgKMMX-j@yuki.lan> <20260922135031.GA2205904@pevik>
 <arKOByoqSFBfhTtn@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arKOByoqSFBfhTtn@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D66C6219C7
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl30: Check module is presented before
 loading
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > It's more subtle than this, in most cases kernel actually loads the
> > > module automatically when the functionality is used (e.g. you create a
> > > socket and kernel loads the module with the particular socket support).
> > > The cases where the module needs to be loaded are quite rare. It's never
> > > unloaded though, so maybe we should attempt that too (if it wasn't
> > > loaded and was loaded because of the test).

> > kconfig is more than modules (e.g. module or even kernel core functionality
> > enabled or disabled). I wonder if it's useful for users to know some module
> > needs to be presented to be loaded (if not built-in) => bool vs. tristate
> > kernel config. Maybe not.

> We actually check and only do the module presence if the CONFIG_FOO=m,
> if the code is build in the branch that checks for the module existence
> never runs.

Thanks for info, makes sense.

> > Other thing is these few modules which don't support autoloading. (Mostly not
> > bugs, at least the latest vmw_vsock_virtio_transport not supporting it was meant
> > to be for testing/debugging [1].). Also the old .needs_drivers documented via
> > metadata both cases - the modules needed to be loaded manually (e.g. "sctp" in
> > testcases/cve/sctphantom.c) and autoloaded modules (e.g. "dummy" in
> > testcases/cve/tcindex01.c or "tun" in testcases/kernel/uevents/uevent02.c or
> > "quota_v2" in testcases/kernel/syscalls/quotactl/quotactl0*.c).

> I do not see the problem here, autoloading is as simple as:

> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index 46eeb8ec0..5d4e4d248 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -147,6 +147,7 @@ static void kconfig_runtime_check(struct tst_kconfig_var *var)
>  static struct config_module_map {
>         const char *config;
>         const char *module_name;
> +       int autoload;
>  } config_module_maps[] = {
>         {"CONFIG_KVM", "kvm"},
>         {"CONFIG_ZRAM", "zram"},
> @@ -165,8 +166,8 @@ static struct config_module_map {
>         {"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
>         {"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
>         {"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> -       {"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},
> -       {"CONFIG_X509_CERTIFICATE_PARSER", "x509_key_parser"},
> +       {"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser", 1},
> +       {"CONFIG_X509_CERTIFICATE_PARSER", "x509_key_parser", 1},
>         {}
>  };

> @@ -186,6 +187,11 @@ static void kconfig_module_check(struct tst_kconfig_var *var)
>                         var->choice = 'n';
>                         return;
>                 }
> +
> +               if (config_module_maps[i].autoload) {
> +                       tst_res(TINFO, "Autoloading '%s'", config_module_maps[i].module_name);
> +                       tst_modprobe(config_module_maps[i].module_name);
> +               }
>         }
>  }

+1 (unless autoload is really module specific, not test specific).


will you send a patch after the release? Feel free to ask me to finish it
(find which ones are needed).

> If we want that information to be present in metadata and documentation,
> we can render that table from a (generated) json that could be parsed by
> the documentation code as well.

+1

> I think it's better to have that information the the test library once,
> rather than to keep a copy in each test.

+1, I really hope that this is not test specific (2 tests somehow using a single
module, one with a way that autoload works on other use case not). It would be
very rare case, let's ignore it now (again that vmw_vsock_virtio_transport which
is loaded by vsock only [1] shows that autoloading can fail).

[1] https://github.com/bluca/systemd/commit/7b435741ba7667cc14aa25d22309da703e0cbf33

> > > As long as we have complete list of CONFIG_* variables from the tests,
> > > which can be easily extracted from the test, we know which modules we
> > > need mapping for. No need to keep anything that isn't in that set.

> > Again, not all kconfigs means tristate (module), some bool configs are required
> > to make sure certain functionality is enabled. Unfortunately we need to check
> > them one by one with kernel sources to see if they are modules (tristate) or bools.

> There should be include/config/tristate.conf in the kernel sources once
> make defconfig is done in linux kernel sources.

New thing to me, but already removed 6 years ago in v5.6-rc1. I indeed had
include/config/tristate.conf with old kernel (leftover of debugging 4.4 based
kernel). And Masahiro Yamada mentioned about false positives in it :).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8b41fc4454e36fbfdbb23f940d023d4dece2de29

> The harder part is the
> CONFIG_ to module name mapping, for that we would have to grep kernel
> Makefiles.

Exactly.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
