Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D860C61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 15:31:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFB623CC005
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 16:31:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F27C13CADA6
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:31:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5F2411400202
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 16:30:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7651022AB3;
 Mon, 13 Mar 2023 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678721459;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fhtpZmnJDZzuKcvAnLcLSTTTjCcWsFHnfGvnvqkUwFU=;
 b=fcFnNJ4TplA7WqVCE8hnNUjqcYkCxwUifL95U10xpbHTxb+ooDfuWFha0bnH9Z5oO2ZKgd
 bJNedY3i8RVNNWg9SI/xVnGcXYO75BDBQSUFmYjRkKNjHYoqya60BvZXP7OVO12AFlXxkK
 e1g3dKcIuJ4ZysNzbl9RcIPv/O/BAJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678721459;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fhtpZmnJDZzuKcvAnLcLSTTTjCcWsFHnfGvnvqkUwFU=;
 b=lXnT63g/ZNkSY8lovY2bdWzEy9UqUsmy3cy67UaIrxynswcQLwp7rwrSjhAcPvtdoVUGUQ
 U2QlVdeyNJVBbcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47A0813517;
 Mon, 13 Mar 2023 15:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id byPTJLJBD2S4bgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Mar 2023 15:30:58 +0000
Date: Mon, 13 Mar 2023 16:30:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230313153056.GB10305@pevik>
References: <20230310124125.14279-1-pvorel@suse.cz>
 <ZA87677RI2ddqkJm@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZA87677RI2ddqkJm@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] Move container utils to testcases/lib/
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
> > Preparation for https://github.com/linux-test-project/ltp/issues/991.

> > NOTE: this patch conflicts with my other patch [1]
> > (touching testcases/lib/{Makefile,.gitignore}).

> > Kind regards,
> > Petr

> > [1] https://patchwork.ozlabs.org/project/ltp/patch/20230307145517.1359-2-pvorel@suse.cz/


> > Petr Vorel (3):
> >   ns_exec.c: Rename to testcases/lib/tst_ns_exec.c
> >   ns_create.c: Rename to testcases/lib/tst_ns_create.c
> >   ns_ifmove.c: Rename to testcases/lib/tst_ns_ifmove.c

> >  doc/namespaces-helper-tools.txt               | 14 ++++++------
> >  .../ns_common.h => include/tst_ns_common.h    |  6 ++---

> I'm not sure about moving this header into top level include, it would
> probably make more sense to add it next to the C files that include it.

Sure, I'll put it there before merge (if it's the only thing to change).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
