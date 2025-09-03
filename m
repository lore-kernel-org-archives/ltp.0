Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81537CA1009
	for <ltp@archiver.kernel.org>; Wed,  3 Sep 2025 13:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2F793CD3E9
	for <ltp@archiver.kernel.org>; Wed,  3 Sep 2025 15:20:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B0EA3CCE5E
 for <ltp@lists.linux.it>; Wed,  3 Sep 2025 15:19:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 96589140097F
 for <ltp@lists.linux.it>; Wed,  3 Sep 2025 15:19:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BFFB1F38A;
 Wed,  3 Sep 2025 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756905578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCCKchFqSF1K11fJ7OWm2pZT2JgSb8cQZLmdcq5FGDg=;
 b=2n2Hky2CaNcvMIqXV4zuKLbCBk4UfcnS9rL+LhXSMbqQQfGaK8sxIWTNC50WZGqkKaRZD5
 nEEdDsLRZ+blscQTGVwQNqqXH4iDsk6qwAtZb82GWEVyva5nYkJ7NBg9CgyqBqjSmOyfNM
 4SXFdB8SLzM/pFnQ52QJ4jdUSgQ4FwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756905578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCCKchFqSF1K11fJ7OWm2pZT2JgSb8cQZLmdcq5FGDg=;
 b=uAxkR8yZ5z+DRoo+R/3PjUOJCTkS1JCktKT6z+VVDTXIeZlqYnALS7RjSFSV7XlqJ+9LKc
 3SfluJJOYP15J1Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756905578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCCKchFqSF1K11fJ7OWm2pZT2JgSb8cQZLmdcq5FGDg=;
 b=2n2Hky2CaNcvMIqXV4zuKLbCBk4UfcnS9rL+LhXSMbqQQfGaK8sxIWTNC50WZGqkKaRZD5
 nEEdDsLRZ+blscQTGVwQNqqXH4iDsk6qwAtZb82GWEVyva5nYkJ7NBg9CgyqBqjSmOyfNM
 4SXFdB8SLzM/pFnQ52QJ4jdUSgQ4FwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756905578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nCCKchFqSF1K11fJ7OWm2pZT2JgSb8cQZLmdcq5FGDg=;
 b=uAxkR8yZ5z+DRoo+R/3PjUOJCTkS1JCktKT6z+VVDTXIeZlqYnALS7RjSFSV7XlqJ+9LKc
 3SfluJJOYP15J1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29A1C13888;
 Wed,  3 Sep 2025 13:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ECOoCGpAuGhGPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Sep 2025 13:19:38 +0000
Date: Wed, 3 Sep 2025 15:20:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aLhAj_-gzjmzvOoX@yuki.lan>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <f014f48a-294c-4205-b147-e20074a8da48@suse.com>
 <aLgxmUJ7e05X1seP@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aLgxmUJ7e05X1seP@yuki.lan>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
> > After an analysis we are now sure that it's not a product bug but a test 
> > issue. There might be a need to fallback the patch if we can't fix the 
> > test before release. @Li WDYT?
> 
> Try this:
> 
> diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
> index 0617bdb87..0d64210b0 100644
> --- a/testcases/realtime/func/sched_football/sched_football.c
> +++ b/testcases/realtime/func/sched_football/sched_football.c
> @@ -115,8 +115,8 @@ void referee(int game_length)
>         now = start;
>  
>         /* Start the game! */
> -       tst_atomic_store(0, &the_ball);
>         pthread_barrier_wait(&start_barrier);
> +       tst_atomic_store(0, &the_ball);
>         atrace_marker_write("sched_football", "Game_started!");
> 
> 
> We have to be sure that the defense has started before we clear the
> ball. Previously we had the loop that waited for the players to be ready
> before we called referee() function so all the players were ready when
> we cleared it.

Uff and we have to get the final ball position before we stop the
threads as well, otherwise there is always chance, that we may end up
moving the ball right after the high priority defence threads has been
stopped:

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 0617bdb87..54317bed9 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -115,8 +115,8 @@ void referee(int game_length)
        now = start;

        /* Start the game! */
-       tst_atomic_store(0, &the_ball);
        pthread_barrier_wait(&start_barrier);
+       tst_atomic_store(0, &the_ball);
        atrace_marker_write("sched_football", "Game_started!");

        /* Watch the game */
@@ -125,14 +125,14 @@ void referee(int game_length)
                gettimeofday(&now, NULL);
        }

-       /* Stop the game! */
-       tst_atomic_store(1, &game_over);
-       atrace_marker_write("sched_football", "Game_Over!");
-
        /* Blow the whistle */
        final_ball = tst_atomic_load(&the_ball);
        tst_res(TINFO, "Final ball position: %d", final_ball);

+       /* Stop the game! */
+       tst_atomic_store(1, &game_over);
+       atrace_marker_write("sched_football", "Game_Over!");
+
        TST_EXP_EXPR(final_ball == 0);
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
