Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34C4C3DA4A
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 09:48:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADBE83D1D3E
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 11:48:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 980733D1D36
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 11:47:46 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F5EA1A01230
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 11:47:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA811219DA;
 Mon, 29 Jul 2024 09:47:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D94EB1368A;
 Mon, 29 Jul 2024 09:47:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kvQ2Mz9lp2YDEgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Jul 2024 09:47:43 +0000
Date: Mon, 29 Jul 2024 11:47:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZqdlJJ1-AYAJsDcL@yuki>
References: <20240717171713.687339-1-pvorel@suse.cz>
 <20240717171713.687339-6-pvorel@suse.cz>
 <20240729073226.GA1223191@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240729073226.GA1223191@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EA811219DA
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] runtest/sched: Add sched_football
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > diff --git a/runtest/sched b/runtest/sched
> > index 5dab7a4c27..ecedd1a92b 100644
> > --- a/runtest/sched
> > +++ b/runtest/sched
> > @@ -18,3 +18,5 @@ sched_cli_serv run_sched_cliserv.sh
> >  sched_stress sched_stress.sh
> 
> >  autogroup01 autogroup01
> > +
> > +sched_football sched_football
> 
> I'm sorry, I haven't noticed, that realtime installs into a different directory:

Uff, missed that as well. The INSTALL_DIR is set in the config.mk for
the realtime tests to $(srcdir) so it copies the layout of the realtime
directories.

> cd ltp/testcases/realtime/func/sched_football
> # make install
> mkdir -p "/opt/ltp/testcases/realtime/func/sched_football"
> install -m 00775   "ltp/testcases/realtime/func/sched_football/run_auto.sh" /opt/ltp/testcases/realtime/func/sched_football/run_auto.sh
> install -m 00775   "ltp/testcases/realtime/func/sched_football/sched_football" /opt/ltp/testcases/realtime/func/sched_football/sched_football

The minimal fix would be to overwrite the INSTALL_DIR for the
sched_football testcase, that would be:

diff --git a/testcases/realtime/func/sched_football/Makefile b/testcases/realtime/func/sched_football/Makefile
index 9bc779efa..aac98eab6 100644
--- a/testcases/realtime/func/sched_football/Makefile
+++ b/testcases/realtime/func/sched_football/Makefile
@@ -6,10 +6,11 @@

 top_srcdir             ?= ../../../..

-INSTALL_TARGETS                := run_auto.sh
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(abs_srcdir)/../../config.mk

+INSTALL_DIR=testcases/bin
+
 # TODO: integrate properly with LTP library
 LDLIBS                 += -lltp
 include $(top_srcdir)/include/mk/generic_leaf_target.mk


We can move the source code around once we get to the realtime directory
cleanup later on.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
