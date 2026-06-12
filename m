Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F31DCD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:17:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6FAB3E6A54
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:17:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D58B93E2A9D
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:17:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9ABF6200773
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 12:17:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0DF2775F8D;
 Fri, 12 Jun 2026 10:17:07 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7CAC779A7;
 Fri, 12 Jun 2026 10:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tyGxNqLcK2rwLwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 12 Jun 2026 10:17:06 +0000
Date: Fri, 12 Jun 2026 12:17:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aivcnnkJVwLQIP22@yuki.lan>
References: <20260612-doc_add_missing_headers-v8-0-a4639c49cad8@suse.com>
 <20260612-doc_add_missing_headers-v8-1-a4639c49cad8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260612-doc_add_missing_headers-v8-1-a4639c49cad8@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0DF2775F8D
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/2] doc: Add missing API references to
 api_c_tests.rst
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Hi!
Some of the fuzzy sync struct member descriptions were simplified too
much. Suggestions below.

>  /**
> - * The state of a two way synchronisation or race.
> + * struct tst_fzsync_pair - The state of a two way synchronisation or race.
> + * @avg_alpha: Rate at which old diff samples are forgotten (default 0.25).
> + * @a_start: Internal; Thread A start time.
> + * @b_start: Internal; Thread B start time.
> + * @a_end: Internal; Thread A end time.
> + * @b_end: Internal; Thread B end time.
> + * @diff_ss: Internal; Avg. difference between a_start and b_start.
> + * @diff_sa: Internal; Avg. difference between a_start and a_end.
> + * @diff_sb: Internal; Avg. difference between b_start and b_end.
> + * @diff_ab: Internal; Avg. difference between a_end and b_end.
> + * @spins: Internal; Number of spins while waiting for the slower thread.
> + * @spins_avg: Internal; Average spins stat.
> + * @delay: Internal; Number of spins to use in the delay.

We need to add this here (otherwise the information is lost):

A negative value delays thread A and a positive delays thread B.

> + * @delay_bias: Internal; Bias added to delay.  + * @sampling:
> Internal; Sampling state or remaining count.

			     ^ If possitive stores the number of samples
			     left. If zero or negative stores sampling
			     state.

> + * @min_samples: Minimum samples before random delays are calculated (default 1024).
> + * @max_dev_ratio: Maximum allowed proportional average deviation (default 0.1).
                          ^

Maximum allowed proportional average deviation, in range (0.0, 1.0),
before random delays are applied. It's ratio of average_deviation /
total_time (default 0.1 i.e. avg deviation at most 10%).


> + * @a_cntr: Internal; Atomic counter used by fzsync_pair_wait().
> + * @b_cntr: Internal; Atomic counter used by fzsync_pair_wait().
> + * @exit: Internal; Used by tst_fzsync_pair_exit() and fzsync_pair_wait().
> + * @exec_time_start: Internal; Test time remaining on tst_fzsync_pair_reset().
> + * @exec_loops: Maximum number of iterations to execute.
> + * @exec_loop: Internal; Current loop index.
> + * @thread_b: Internal; The second thread or 0.
> + * @yield_in_wait: Yield CPU while waiting on single-core machines.
                         ^
	              Yield CPU while waiting, set automatically on single-core
		      machines.


With these adjusted:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
