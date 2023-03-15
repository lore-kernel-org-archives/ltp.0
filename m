Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A167BC6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 12:24:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C63703CD49C
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 13:24:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20F023C95FB
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:23:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9725F600A4A
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 13:23:53 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DACB91FD73;
 Wed, 15 Mar 2023 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678883032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AfdDTpIuRhaDBZRWBil5qJKuYlEWlDDh8ht6yNuJlOU=;
 b=p5BsUP++6ZnUOFOyTQmFuovvndLKeUmEHO/6UeVk9/4zyIMoGXYgc+RP+h0LjS/tcn4Rrj
 T5exPMw0p0mGy1kS4gY36g4oEWX0Nta1BiPG+ae44ikEieYK6hs+ZMiKFRsptGip2sanZl
 0LoeIKsVg2equiD5S13ffdZbtk7xQx8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DBED13A2F;
 Wed, 15 Mar 2023 12:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jye8E9e4EWR2BwAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 15 Mar 2023 12:23:51 +0000
Date: Wed, 15 Mar 2023 08:23:47 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230315122347.GA10248@localhost>
References: <20230306235715.29868-1-wegao@suse.com>
 <20230307085139.3574-1-wegao@suse.com>
 <20230309214046.GC451752@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230309214046.GC451752@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] kill01: New case cgroup kill
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 09, 2023 at 10:40:46PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> Closes: https://github.com/linux-test-project/ltp/issues/846
> 
> Test LGTM.
> 
> ...
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
> Is it based on some Christian's reproducer?
> I haven't noticed any in https://lwn.net/Articles/855049/ (linked in #846)
> nor in the patch
> https://lwn.net/ml/cgroups/20210503143922.3093755-1-brauner@kernel.org/.
> But maybe I just overlooked it.
This case base kernel self test, will add more description here.
> 
> > + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Basic cgroup kill test.
> > + *
> > + */
> > +
> > +#include <errno.h>
> > +#include <linux/limits.h>
> > +#include <stdbool.h>
> nit: stdbool.h is not needed (can be removed before merge).
ack
> 
> ...
> > +static void run(void)
> > +{
> > +	pid_t pids[MAX_PID_NUM];
> > +	int i;
> > +
> > +	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
> > +
> > +	memset(buf, 0, buf_len);
> > +
> > +	for (i = 0; i < pid_num; i++)
> > +		pids[i] = cg_run_nowait(cg_child_test_simple, child_fn);
> > +
> > +	TST_EXP_PASS(cg_wait_for_proc_count(cg_child_test_simple, pid_num));
> > +	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
> > +
> > +	for (i = 0; i < pid_num; i++) {
> > +		/* wait_for_pid(pids[i]); */
> I guess this comment should be removed before merge.
ack
> > +		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]) == SIGKILL);
> > +	}
> > +
> > +	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
> > +}
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
