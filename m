Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D45CA1002
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 09:52:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91F513CD428
	for <ltp@archiver.kernel.org>; Thu,  4 Sep 2025 11:52:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B8F03C5705
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 11:52:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 322806007B7
 for <ltp@lists.linux.it>; Thu,  4 Sep 2025 11:52:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C3DF342EA;
 Thu,  4 Sep 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB6113AA0;
 Thu,  4 Sep 2025 09:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LbaKBl9huWg+IwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 04 Sep 2025 09:52:31 +0000
Date: Thu, 4 Sep 2025 11:53:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aLlhhJcdbx7mPQX_@yuki.lan>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <f014f48a-294c-4205-b147-e20074a8da48@suse.com>
 <aLgxmUJ7e05X1seP@yuki.lan> <aLhAj_-gzjmzvOoX@yuki.lan>
 <CAEemH2dzju5n1FZ8TyG0=YBJY-A80VD7Sv1PLJZuj_AYNERYvg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dzju5n1FZ8TyG0=YBJY-A80VD7Sv1PLJZuj_AYNERYvg@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2C3DF342EA
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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
> This makes sense! However, from my extensive testing, I still see
> occasional fails on KVM/Debug platforms.
> 
> I suspect the existing barriers ensure all threads are created before
> the game starts, but small scheduler skews can still allow the attacking
> thread to run for a few cycles before the defending thread migrates,
> especially on debug/RT kernels.

I guess that there is no defined order in which the threads are woken up
after the sleep on the barrier. Hence if we wake up the low prio thread
by a chance before all the high prio threads are awake they manage to do
a few cycles.

> So, based on this improve, we might need additional spin for all player
> threads (offense, defense, fans) wait at the barrier and then spin until
> the referee kicks off the ball.
> 
> --- a/testcases/realtime/func/sched_football/sched_football.c
> +++ b/testcases/realtime/func/sched_football/sched_football.c
> @@ -44,6 +44,7 @@
>  static tst_atomic_t the_ball;
>  static int players_per_team = 0;
>  static int game_length = DEF_GAME_LENGTH;
> +static tst_atomic_t kickoff_flag;
>  static tst_atomic_t game_over;
> 
>  static char *str_game_length;
> @@ -55,6 +56,9 @@ void *thread_fan(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
>         prctl(PR_SET_NAME, "crazy_fan", 0, 0, 0);
>         pthread_barrier_wait(&start_barrier);
> +       while (!tst_atomic_load(&kickoff_flag))
> +               ;
> +
>         /*occasionally wake up and run across the field */
>         while (!tst_atomic_load(&game_over)) {
>                 struct timespec start, stop;
> @@ -80,6 +84,9 @@ void *thread_defense(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
>         prctl(PR_SET_NAME, "defense", 0, 0, 0);
>         pthread_barrier_wait(&start_barrier);
> +       while (!tst_atomic_load(&kickoff_flag))
> +               ;
> +
>         /*keep the ball from being moved */
>         while (!tst_atomic_load(&game_over)) {
>         }
> @@ -92,6 +99,9 @@ void *thread_offense(void *arg LTP_ATTRIBUTE_UNUSED)
>  {
>         prctl(PR_SET_NAME, "offense", 0, 0, 0);
>         pthread_barrier_wait(&start_barrier);
> +       while (!tst_atomic_load(&kickoff_flag))
> +               ;
> +
>         while (!tst_atomic_load(&game_over)) {
>                 tst_atomic_add_return(1, &the_ball); /* move the ball ahead
> one yard */
>         }
> @@ -115,9 +125,10 @@ void referee(int game_length)
>         now = start;
> 
>         /* Start the game! */
> -       tst_atomic_store(0, &the_ball);
> -       pthread_barrier_wait(&start_barrier);
>         atrace_marker_write("sched_football", "Game_started!");
> +       pthread_barrier_wait(&start_barrier);
> +       tst_atomic_store(0, &the_ball);
> +       tst_atomic_store(1, &kickoff_flag);

Is this really 100% buletproof? Now the threads are going to wait for
the referee for the kick off but if the referee is the first thread to
be woken up after the barrier the order is stil not guaranteed.

Maybe we can just do a short sleep here in order to make sure that the
scheduller kicks in and redistributes the threads. I would say something
as 20ms (since with CONFIG_HZ=100 we have scheduller ticks every 10ms).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
