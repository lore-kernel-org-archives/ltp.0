Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A61E6B240
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 10:58:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69A643CD317
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 11:58:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E09E43C015C
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:58:29 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0FB8A648F4D
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 11:58:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AEC0F21E19;
 Fri,  1 Nov 2024 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730458706;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UjqaQZI+u2R5/MDAkAc+9B80G2P8334Ajju0hb4XvfQ=;
 b=zn9daL8cghOe+gklMO8TNUw4XTemJqNdTvGMyJI/k6PnQBLtYiMrNSqCZ/rFIyxwYC/zai
 ZOU54okgNNMLoeGQW2k2B2muuJNT+GILqg6rC2VnSNi+IjNknsUXiPKdTg7KglJ8oWINiL
 RjHQnBaP4mP+xAFbF9tWCv6LuUr55XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730458706;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UjqaQZI+u2R5/MDAkAc+9B80G2P8334Ajju0hb4XvfQ=;
 b=zQvgd5z4X+mStZvllvks5xXYzcwAQaQRM2imvqT4gWBgG4e7oVR16j9VcxlhDmCujNYAum
 ajOe3yF1S4W7RJAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="pG5Z/Ord";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7NqoGEZp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730458704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UjqaQZI+u2R5/MDAkAc+9B80G2P8334Ajju0hb4XvfQ=;
 b=pG5Z/Ordewvdvbl3ejsnFA0fg8YXiGuKbvMLUXisge2NJSzZQsKPHLh2sYGEfy6oteW8rM
 2ueuU9zBaGiOIkulaXgT8438l0fmHAG5BnTugFCcQ2n/cU/jCgqR+1gEK4Ol6xDg39XzlS
 3g6qAojxrtP5lcNxMIarD/cPsVwnsCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730458704;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UjqaQZI+u2R5/MDAkAc+9B80G2P8334Ajju0hb4XvfQ=;
 b=7NqoGEZpiWnBlkDhkPt51NZO3uUz8OFwnz7KeEBa8juE3eJ4NZZejHPuxz7B69gVy02FK5
 fx3SWrLUrOct4ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F019136D9;
 Fri,  1 Nov 2024 10:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 02ZhIVC0JGd3UwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 10:58:24 +0000
Date: Fri, 1 Nov 2024 11:58:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20241101105808.GD1145995@pevik>
References: <20240926061936.21499-1-wegao@suse.com>
 <20240930135809.9300-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240930135809.9300-1-wegao@suse.com>
X-Rspamd-Queue-Id: AEC0F21E19
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,cpuset_memory_testset.sh:url,suse.cz:dkim,suse.cz:replyto,fujitsu.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] cpuset02: Reimplementing the test6 of
 cpuset_memory_testset.sh as a separate C testcase
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

Hi Wei, Cyril,

> "Reimplementing the test6 of cpuset_memory_testset.sh as a separate C testcase"
This could be followed by removing test6 from cpuset_memory_testset.sh?

The conversion itself from shell test test6 LGTM.

I suppose the reason is that moving code to C improves stability of the test.
But this would be nice to mention in the commit message. (Remember "what" versus
"why" - often the reason for the change is more important that describing the
change.)

> index 8e41c0223..366d67ce9 100644
> --- a/testcases/kernel/mem/cpuset/Makefile
> +++ b/testcases/kernel/mem/cpuset/Makefile
> @@ -19,6 +19,13 @@

>  top_srcdir		?= ../../../..

> +LTPLIBS = numa
> +
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
> +
> +LDLIBS  += $(NUMA_LIBS)
> +LDLIBS  += $(top_srcdir)/testcases/kernel/controllers/cpuset/cpuset_lib/libcpu_set.a
This is not enough, because there is no build dependency on libcpu_set.a.

Other tests which depends on libcpu_set.a are in the subdirectories (e.g.
testcases/kernel/controllers/cpuset/cpuset_hotplug_test/) and they use
testcases/kernel/controllers/cpuset/Makefile.inc. Can you somehow use it?

Maybe we should move cpuset_lib code to libs/ directory, when used elsewhere.

That would also help to avoid ugly includes like:
> +#include "../../controllers/cpuset/cpuset_lib/cpuset.h"

(This could be also improved with CFLAGS += -I../../controllers/cpuset/cpuset_lib/.)


> +LTPLDLIBS = -lltpnuma
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/mem/cpuset/cpuset02.c b/testcases/kernel/mem/cpuset/cpuset02.c
> new file mode 100644
> index 000000000..a62c98b3f
> --- /dev/null
> +++ b/testcases/kernel/mem/cpuset/cpuset02.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (c) 2009 FUJITSU LIMITED  Miao Xie <miaox@cn.fujitsu.com>
> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test check cpuset's mems work with hugepage file.
Maybe: Test checks cpuset.mems works with hugepage file.

> + *
Please remove the blank line above ^.
> + */
...

> +static void count_cpus_mems(void)
> +{
> +	node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024);
> +	if (node->cnt <= 1)
> +		tst_brk(TCONF, "test requires NUMA system");
> +}
nit: Function used only once, I would move the code into setup().

Later (separate effort), this function (with size parameter) could be in
libs/numa/tst_numa.c, because it's used in many tests, or even added into struct
tst_test.

> +static void run_test(void)
> +{
...
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		child();
> +	} else {
> +		SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);
> +
> +		TST_CHECKPOINT_WAKE(0);
> +		TST_CHECKPOINT_WAIT(1);
> +
> +		SAFE_WAITPID(pid, NULL, 0);
> +
> +		cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);
> +	}

Very nit: IMHO saving indent would be more readable:

	if (!pid) {
		child();
		return; // or call exit() in child() and no return here.
	}

	SAFE_CG_PRINTF(cg_cpuset_0, "cgroup.procs", "%d", pid);

	TST_CHECKPOINT_WAKE(0);
	TST_CHECKPOINT_WAIT(1);

	SAFE_WAITPID(pid, NULL, 0);

	cg_cpuset_0 = tst_cg_group_rm(cg_cpuset_0);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
