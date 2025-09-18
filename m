Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA39CAC5A0
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 12:35:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7D943CDD36
	for <ltp@archiver.kernel.org>; Thu, 18 Sep 2025 14:35:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A1F33CDB12
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 14:34:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 07B89200774
 for <ltp@lists.linux.it>; Thu, 18 Sep 2025 14:34:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0510C337C0;
 Thu, 18 Sep 2025 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758198893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBsW2oViNmvEkbxsO7a0EVdJE1AZS7IEnKvLEwK74FM=;
 b=Ai7QhEQWYarjW+78nbTmfG2yqdrwOP9vxks6qeGy5SYVBjwTGwAOKYWlde80hX6uyKPnzL
 C9LIqMtewK8ZNmqb4tzDnQAmvNPrO7a5W1JuvrXClgZP6Lm1n1hJD4aV8vo8+ff7a2p21r
 2fSc0ibe+YrvDyMJH/A7sH4qx5PTZv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758198893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBsW2oViNmvEkbxsO7a0EVdJE1AZS7IEnKvLEwK74FM=;
 b=Bkttdj0OXyLIzFdNC6BcbzY4ieogR6RJBD91S/xofpCAK76X0Pqw5oW3oOo2gHB2DsTCQX
 K6efqfl9yrDq85AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Ai7QhEQW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Bkttdj0O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758198893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBsW2oViNmvEkbxsO7a0EVdJE1AZS7IEnKvLEwK74FM=;
 b=Ai7QhEQWYarjW+78nbTmfG2yqdrwOP9vxks6qeGy5SYVBjwTGwAOKYWlde80hX6uyKPnzL
 C9LIqMtewK8ZNmqb4tzDnQAmvNPrO7a5W1JuvrXClgZP6Lm1n1hJD4aV8vo8+ff7a2p21r
 2fSc0ibe+YrvDyMJH/A7sH4qx5PTZv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758198893;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBsW2oViNmvEkbxsO7a0EVdJE1AZS7IEnKvLEwK74FM=;
 b=Bkttdj0OXyLIzFdNC6BcbzY4ieogR6RJBD91S/xofpCAK76X0Pqw5oW3oOo2gHB2DsTCQX
 K6efqfl9yrDq85AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA0A413A39;
 Thu, 18 Sep 2025 12:34:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G5Y4NGz8y2jNGwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Sep 2025 12:34:52 +0000
Date: Thu, 18 Sep 2025 14:34:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: jiaying.song.cn@windriver.com
Message-ID: <20250918123451.GA415571@pevik>
References: <20250523074107.3655219-1-jiaying.song.cn@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250523074107.3655219-1-jiaying.song.cn@windriver.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,sourceware.org:url,ozlabs.org:url,suse.cz:replyto,suse.cz:dkim,windriver.com:email,configure.ac:url];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 0510C337C0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/semctl08: Skip semctl08 when
 __USE_TIME64_REDIRECTS is defined
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

Hi Jiaying,

[ NOTE: Ricardo was wrongly set the sender by patchwork ]

> From: Jiaying Song <jiaying.song.cn@windriver.com>

> When __USE_TIME64_REDIRECTS is defined, glibc redirects struct semid_ds to a
> 64-bit time-safe version that omits the sem_otime_high and sem_ctime_high
> fields. As a result, the case becomes invalid and leads to incorrect behavior.

> This patch adds a check to skip the test when __USE_TIME64_REDIRECTS is
> defined, ensuring the test only runs when semid_ds structurally matches
> semid64_ds and the *_high fields are accessible.

Looking into this old patch. Depending on glibc specific internal definition is
not a preferred approach (definition can be renamed). I wonder if this could be
detected with m4 macro or otherwise (some kind of sizeof check).

IMHO glibc has not switched to 64bit time-safe version by default yet, right?
And it depends on glibc being compiled with -D_TIME_BITS=64 and
-D_FILE_OFFSET_BITS=64, right? But these aren't detectable, right?

Looking at glibc sources [1], _TIME_BITS and _FILE_OFFSET_BITS really determine
__USE_TIME64_REDIRECTS:

#if defined _TIME_BITS
# if _TIME_BITS == 64
#  if ! defined (_FILE_OFFSET_BITS) || _FILE_OFFSET_BITS != 64
#   error "_TIME_BITS=64 is allowed only with _FILE_OFFSET_BITS=64"
#  endif
#  define __USE_TIME_BITS64     1
# elif _TIME_BITS == 32
#  if __TIMESIZE > 32
#   error "_TIME_BITS=32 is not compatible with __TIMESIZE > 32"
#  endif
# else
#  error Invalid _TIME_BITS value (can only be 32 or 64-bit)
# endif
#elif __TIMESIZE == 64
# define __USE_TIME_BITS64      1
#endif

#if defined __USE_TIME_BITS64 && __TIMESIZE == 32
# define __USE_TIME64_REDIRECTS 1
#endif

_TIME_BITS toolchain support is detected by configure.ac [2]

and nowadays is probably 64 bit by default, see  timezone/private.h [3]:

#if !defined _TIME_BITS && _FILE_OFFSET_BITS == 64
# define _TIME_BITS 64
#endif

And the same question applies to your other msgctl05 related patch [4].

Kind regards,
Petr

[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/features-time64.h;h=8d573cd23e48c0f771c72350168b04c6a38c7864;hb=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9
[2] https://sourceware.org/git/?p=glibc.git;a=blob;f=configure.ac;h=af57b0cbae8c1b22bfdc7a4e47d46c4e5064873a;hb=HEAD#l1826
[3] https://sourceware.org/git/?p=glibc.git;a=blob;f=timezone/private.h;h=c33041049f4c8f40b874c23b6fe0556967069b2c;hb=HEAD#l167
[4] https://patchwork.ozlabs.org/project/ltp/patch/20250522093003.1958528-1-jiaying.song.cn@windriver.com/

> Signed-off-by: Jiaying Song <jiaying.song.cn@windriver.com>
> ---
>  testcases/kernel/syscalls/ipc/semctl/semctl08.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> index 1878bd4..3b799fa 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> @@ -10,7 +10,11 @@
>  #include "tst_test.h"
>  #include "libnewipc.h"

> -#ifdef HAVE_SEMID64_DS_TIME_HIGH
> +#if !defined(HAVE_SEMID64_DS_TIME_HIGH)
> +TST_TEST_TCONF("test requires struct semid64_ds to have the time_high fields");
> +#elif defined(__USE_TIME64_REDIRECTS)
> +TST_TEST_TCONF("test requires __USE_TIME64_REDIRECTS to be undefined");
> +#else

>  static void run(void)
>  {
> @@ -47,6 +51,4 @@ static struct tst_test test = {
>  	.test_all = run,
>  	.needs_tmpdir = 1,
>  };
> -#else
> -TST_TEST_TCONF("test requires struct semid64_ds to have the time_high fields");
>  #endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
