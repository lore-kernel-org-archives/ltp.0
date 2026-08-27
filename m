Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACBDC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 14:22:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 199E43D0F3F
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 16:22:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B1313D0F3F
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 16:22:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACA7C1A007FD
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 16:22:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 10EE31F867;
 Thu, 27 Aug 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F113C1352D;
 Thu, 27 Aug 2026 14:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VKJGOQZIkGoKJAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Aug 2026 14:21:58 +0000
Date: Thu, 27 Aug 2026 16:21:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <apBH_mTl9lUxbGdZ@yuki.lan>
References: <ao7sDiRA4JguwRUl@autotest-wegao.qe.prg2.suse.org>
 <6a8ff007.b1f9e4c6.15919c.5636@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a8ff007.b1f9e4c6.15919c.5636@mx.google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 10EE31F867
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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

Hi!
> yes, basically we re-implement some sort of OOM-killer/memory.reclaim
> inside the code, instead of using them directly. That means we need to
> disable OOM killer, loop over the current swap status and eventually
> raise an error if after N iterations pages are not swapped.
> 
> But I feel it's not deterministic because on a really slow device we
> might run out of iterations. I still think memory.reclaim is the best
> choice for v2 in this case, because it will wait until a certain amount
> of memory has been reclaimed and eventually raise an error.
> 
> @Cyril do you have any idea on how to proceed here?	

If the goal is to make sure that kernel swaps when memory.max is reached
we may as well slow down the dirtying loop so that it dirties memory
with speed 20MB/s when it gets close to the limit.

Something as:

diff --git a/testcases/kernel/mem/mmapstress/mmapstress06.c b/testcases/kernel/mem/mmapstress/mmapstress06.c
index 4e6023399..2c0c6fb02 100644
--- a/testcases/kernel/mem/mmapstress/mmapstress06.c
+++ b/testcases/kernel/mem/mmapstress/mmapstress06.c
@@ -59,8 +59,9 @@ static void run_test(void)
 
                for (size_t i = 0; i < map_size; i += page_size) {
                        mmapaddr[i] = 'a';
-                       if ((i % (2 * 1024 * 1024)) == 0)
-                               usleep(1000);
+
+                       if (i >= mem_limit && !(i % (2 * 1024 * 1024)))
+                               usleep(100000);
                }

The testrun increses to 6s from 1s but it makes the OOM very unlikely to
happen.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
