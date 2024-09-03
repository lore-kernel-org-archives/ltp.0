Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E5CCD13CF
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 08:24:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9A6A3C4E00
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 10:24:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5710A3C090A
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 10:24:30 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0B4EA1A00E24
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 10:24:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DB021F7CD;
 Tue,  3 Sep 2024 08:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725351864;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/3ejsF/MyclvGrQsIko/ptBuOBm/ol+NyVVCAtWcMw=;
 b=tBSVU3ZHu8LVkVKqhHmLxqWE4nblXvlxiDCKLxHkYWOGjXkMb//YbHTTbkbrWsqXdO3d0k
 o6n1rEIvwQ2rBDfNI3zwb5m+P1sfNvBXDWE+wPIlypvBFD7fT3bb8TzYgENoECJLAq6RDM
 ZOs6ZXoXbdow4qhhFjb2x7Plb10mAbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725351864;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/3ejsF/MyclvGrQsIko/ptBuOBm/ol+NyVVCAtWcMw=;
 b=eoWZtCECsKIlsZP5/sEdjVPaOC4smbcDScj/tNIcMhPeLDwUXLVMrCfhbSKvpsV54frz8J
 NhvVR6FwBMHZ4LBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tBSVU3ZH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eoWZtCEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725351864;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/3ejsF/MyclvGrQsIko/ptBuOBm/ol+NyVVCAtWcMw=;
 b=tBSVU3ZHu8LVkVKqhHmLxqWE4nblXvlxiDCKLxHkYWOGjXkMb//YbHTTbkbrWsqXdO3d0k
 o6n1rEIvwQ2rBDfNI3zwb5m+P1sfNvBXDWE+wPIlypvBFD7fT3bb8TzYgENoECJLAq6RDM
 ZOs6ZXoXbdow4qhhFjb2x7Plb10mAbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725351864;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/3ejsF/MyclvGrQsIko/ptBuOBm/ol+NyVVCAtWcMw=;
 b=eoWZtCECsKIlsZP5/sEdjVPaOC4smbcDScj/tNIcMhPeLDwUXLVMrCfhbSKvpsV54frz8J
 NhvVR6FwBMHZ4LBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6677313A80;
 Tue,  3 Sep 2024 08:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DDUYGLjH1mbkYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 08:24:24 +0000
Date: Tue, 3 Sep 2024 10:24:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240903082415.GB728268@pevik>
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240827120237.25805-3-chrubis@suse.cz>
X-Rspamd-Queue-Id: 7DB021F7CD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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

Hi Cyril,

...
> diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
I hoped testcases/lib/run_tests.sh could be run in CI (and manually).

We have in the toplevel Makefile other test targets, could we add
testcases/lib/run_tests.sh to test-shell target?

1) Add test target to testcases/lib/tests/Makefile (similar to
metadata/tests/Makefile).

test:
	@echo == Run C - shell integration tests ===
	@./run_tests.sh

2) Add test target to testcases/lib/Makefile which would call test target in the
test/ directory (similar to metadata/Makefile).

test:
	$(MAKE) -C $(abs_srcdir)/tests/ test

3) Add testing to the toplevel test-shell target + build dependency to testcases/lib/.

test-shell: lib-all
ifneq ($(build),$(host))
	$(error running tests on cross-compile build not supported)
endif
	$(call _test,-s)
	$(MAKE) -C $(abs_top_builddir)/testcases/lib
	$(MAKE) -C $(abs_top_srcdir)/testcases/lib test

> --- /dev/null
> +++ b/testcases/lib/run_tests.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +
> +testdir=$(realpath $(dirname $0))
Not sure if there should be some quotes.

> +export PATH=$PATH:$testdir:$testdir/tests/
Also quotes here.

...
> diff --git a/testcases/lib/tests/Makefile b/testcases/lib/tests/Makefile
> new file mode 100644
> index 000000000..5a5cf5310
> --- /dev/null
> +++ b/testcases/lib/tests/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
nit: Maybe LTP copyright? (copy paste error)
> +# Ngie Cooper, August 2009
nit: and you, or just replace Ngie?
> +
> +top_srcdir		?= ../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +INSTALL_TARGETS=
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

The rest LGTM, but I'll have a deeper look today or tomorrow and try to play
with it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
