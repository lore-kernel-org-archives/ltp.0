Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40392C98302
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 13:50:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72F413E6D40
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 15:50:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA3133E1B18
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 15:50:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4DD2D1A0116D
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 15:50:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F6391F747;
 Tue, 22 Sep 2026 13:50:33 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37C0B13A23;
 Tue, 22 Sep 2026 13:50:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2WgWBamHsmo1DwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 13:50:33 +0000
Date: Tue, 22 Sep 2026 15:50:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260922135031.GA2205904@pevik>
References: <20260922105840.2193537-1-pvorel@suse.cz>
 <arJiBgKNC80acBfY@yuki.lan> <20260922112916.GB2191017@pevik>
 <arJ5l2SxNgKMMX-j@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arJ5l2SxNgKMMX-j@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 8F6391F747
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
> > > >  	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
> > > >  	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
> > > >  	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> > > > +	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},

> > > I think that this is still cleaner, this way we skip the test even
> > > before we start running it.

> > Yeah, exit early + having it in the metadata is better - feel free to post the
> > above as a patch and we refuse this patch.

> > After release thinking:
> > Thinking it twice having a separate metadata for "direct" module loading was
> > good (the functionality we replaced by kconfig). Why? Now we need to
> > 1) load module manually in the test
> > 2) manual module loading is hidden in metadata behind kernel config (tester see
> > that in the test output, but it's not obvious in the metadata).

> It's more subtle than this, in most cases kernel actually loads the
> module automatically when the functionality is used (e.g. you create a
> socket and kernel loads the module with the particular socket support).
> The cases where the module needs to be loaded are quite rare. It's never
> unloaded though, so maybe we should attempt that too (if it wasn't
> loaded and was loaded because of the test).

kconfig is more than modules (e.g. module or even kernel core functionality
enabled or disabled). I wonder if it's useful for users to know some module
needs to be presented to be loaded (if not built-in) => bool vs. tristate
kernel config. Maybe not.

Other thing is these few modules which don't support autoloading. (Mostly not
bugs, at least the latest vmw_vsock_virtio_transport not supporting it was meant
to be for testing/debugging [1].). Also the old .needs_drivers documented via
metadata both cases - the modules needed to be loaded manually (e.g. "sctp" in
testcases/cve/sctphantom.c) and autoloaded modules (e.g. "dummy" in
testcases/cve/tcindex01.c or "tun" in testcases/kernel/uevents/uevent02.c or
"quota_v2" in testcases/kernel/syscalls/quotactl/quotactl0*.c).

[1] https://lore.kernel.org/virtualization/acqLo6-IQVBzY3UW@sgarzare-redhat/

> > Sure, we don't want to revert that whole big patchset. But maybe we could
> > consider to
> > 1) call tst_module_load() based on config_module_map() instead doing it
> > in the test

> We can do that, but I would only do so if it's actually needed, so that
> the module autoload is tested as well. For that we would probably need
> to add a needs_load to the config to module mapping table.

I'd also load only these which need it (without autoloading support). And yes,
we would have to mark them because it's not obvious from "struct config_module_map"
which ones needs to be loaded manually.

> > 2) print this mapping in the metadata (that would require struct config_module_map
> > being accessible also by metadata/metaparse.c.

> > > Maybe we should attempt to auto-generate the
> > > table for all CONFIG_* variables used in LTP.

> > Sure, that's a good idea. Useful would be some script similar to updating
> > sycalls numbers. With the only exception: don't delete old modules (modules can
> > be deleted, but still used by supported kernels).

> As long as we have complete list of CONFIG_* variables from the tests,
> which can be easily extracted from the test, we know which modules we
> need mapping for. No need to keep anything that isn't in that set.

Again, not all kconfigs means tristate (module), some bool configs are required
to make sure certain functionality is enabled. Unfortunately we need to check
them one by one with kernel sources to see if they are modules (tristate) or bools.

> > > Also keyctl23.c and keyctl29.c have tst_modprobe("x509_key_parser",
> > > NULL); So we need fix/mappping for x509_key_parser too.

> > Yeah, I also noted that + cve-2026-46331.c (all Andrea's agent based code,
> > we should teach agent about the differences).

> There are also tests that do tst_cmd("modprobe", ...) these should be
> fixed as well (git grep '"modprobe"').

$ git grep  '"modprobe"' testcases/
testcases/kernel/device-drivers/zram/zram03.c:  const char *const cmd_modprobe[] = {"modprobe", "zram", NULL};
testcases/kernel/device-drivers/zram/zram03.c:          {.cmd = "modprobe"},
testcases/kernel/syscalls/keyctl/keyctl05.c:    tst_cmd((const char*[]){"modprobe", MODULE, NULL}, NULL, NULL, 0);
testcases/kernel/syscalls/madvise/madvise11.c:  const char *const cmd_modprobe[] = {"modprobe", HW_MODULE, NULL};
testcases/kernel/syscalls/madvise/madvise11.c:          {.cmd = "modprobe"},
testcases/network/can/cve/can_bcm01.c:  tst_cmd((const char*[]){"modprobe", "vcan", NULL}, NULL, NULL, 0);
testcases/network/can/filter-tests/can_common.h:        CAN_CMD("modprobe", "-r", "vcan");
testcases/network/can/filter-tests/can_common.h:        CAN_CMD("modprobe", "vcan", "echo=1");
testcases/network/can/filter-tests/can_common.h:        CAN_CMD("modprobe", "-r", "vcan");
testcases/network/netstress/netstress.c:                const char * const argv[] = {"modprobe", "dccp_ipv6", NULL};

I remember these. I wanted in the past to add support to tst_modprobe() to pass
module parameters, but it turn out only few tests used them. From this grep it
looks like can_common.h uses module parameters (and kvm tests not listed here,
which use tst_module_reload(), but that's different). But I did not noticed that
other uses could use tst_modprobe() directly.  I can send a patch but it should
be probably merged after the release.

=> back to fixes needed for a release.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
