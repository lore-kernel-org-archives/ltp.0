Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD051C3DA4D
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 13:22:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45DAF3D199E
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 15:22:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E732D3CBA12
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 15:22:12 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0DF11601417
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 15:22:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D1351FCF9;
 Fri, 12 Jul 2024 13:22:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D80AF13686;
 Fri, 12 Jul 2024 13:22:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RQIiMwIukWZrZAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Jul 2024 13:22:10 +0000
Date: Fri, 12 Jul 2024 15:22:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240712132205.GA145191@pevik>
References: <20240711104400.63355-1-pvorel@suse.cz>
 <20240711104400.63355-2-pvorel@suse.cz> <ZpERtIxWiodTJiYS@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZpERtIxWiodTJiYS@rei>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 1D1351FCF9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/2] sched_football: Rewrite into new API
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
Cc: John Stultz <jstultz@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

First, thanks for having a look.

> Hi!
> > Combining LTP librealtime (librttest.c) and LTP library is somehow
> > experimental. -lltp was needed to be added to CFLAGS but yet on musl
> > it fails to find the function on runtime:
> > tst_test.c:985: TBROK: No test function specified

> That should not happen, you get this message something went horribly
> wrong and the test_all function pointer ended up NULL in the test
> library. Which gcc version was it, I would expect that this would be
> more compiler specific than libc specific.

$ gcc -v
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-alpine-linux-musl/13.2.1/lto-wrapper
Target: x86_64-alpine-linux-musl
Configured with: /home/buildozer/aports/main/gcc/src/gcc-13-20231014/configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --build=x86_64-alpine-linux-musl --host=x86_64-alpine-linux-musl --target=x86_64-alpine-linux-musl --enable-checking=release --disable-cet --disable-fixed-point --disable-libstdcxx-pch --disable-multilib --disable-nls --disable-werror --disable-symvers --enable-__cxa_atexit --enable-default-pie --enable-default-ssp --enable-languages=c,c++,d,objc,go,fortran,ada --enable-link-serialization=2 --enable-linker-build-id --disable-libssp --disable-libsanitizer --enable-shared --enable-threads --enable-tls --with-bugurl=https://gitlab.alpinelinux.org/alpine/aports/-/issues --with-system-zlib --with-linker-hash-style=gnu --with-pkgversion='Alpine 13.2.1_git20231014'
Thread model: posix
Supported LTO compression algorithms: zlib
gcc version 13.2.1 20231014 (Alpine 13.2.1_git20231014)

Hm, after doing make clean of the library everything magically worked. I'm sorry
for the noise.

$ make V=1
gcc -I/home/foo/ltp/testcases/realtime/include -I/home/foo/ltp/testcases/realtime/include -I../../../../include -I../../../../include -I../../../../include/old/ -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -std=gnu99 -D_GNU_SOURCE -L/home/foo/ltp/testcases/realtime/lib -L../../../../lib sched_football.c  -lrealtime -lpthread -lrt -lm -lltp -o sched_football

# ./sched_football
tst_test.c:1806: TINFO: LTP version: 20240524-81-g562d1b39b
tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
sched_football.c:159: TINFO: players_per_team: 2 game_length: 5
sched_football.c:171: TINFO: Starting 2 offense threads at priority 15
sched_football.c:182: TINFO: Starting 2 defense threads at priority 30
sched_football.c:193: TINFO: Starting 2 fan threads at priority 50
sched_football.c:120: TINFO: Starting referee thread
sched_football.c:123: TINFO: Starting the game (5 sec)
sched_football.c:143: TINFO: Final ball position: 0
sched_football.c:145: TPASS: Expect: final_ball == 0

=> main problem solved, but there are 2 others.

1) realtime suite does not trigger libltp dependency (build system fix required):

/usr/lib/gcc/x86_64-alpine-linux-musl/13.2.1/../../../../x86_64-alpine-linux-musl/bin/ld: cannot find -lltp: No such file or directory

I wonder if we should get rid of LTP realtime library for this file. Fixing it
would be obviously better.

2) Running with -i is broken (everywhere, also on glibc)

./sched_football -i2
tst_test.c:1806: TINFO: LTP version: 20240524-93-g17c91c528
tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
sched_football.c:159: TINFO: players_per_team: 2 game_length: 5
sched_football.c:171: TINFO: Starting 2 offense threads at priority 15
sched_football.c:182: TINFO: Starting 2 defense threads at priority 30
sched_football.c:193: TINFO: Starting 2 fan threads at priority 50
sched_football.c:120: TINFO: Starting referee thread
sched_football.c:123: TINFO: Starting the game (5 sec)
sched_football.c:143: TINFO: Final ball position: 0
sched_football.c:145: TPASS: Expect: final_ball == 0
sched_football.c:159: TINFO: players_per_team: 2 game_length: 5
sched_football.c:171: TINFO: Starting 2 offense threads at priority 15
Test timeouted, sending SIGKILL!

Something needs to be reset for each run and it's not?
ball is reset: tst_atomic_store(0, &ball);

Kind regards,
Petr

> Otherwise the conversion looks pretty straightforward, mostly about
> option parsing and printf vs tst_res().

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
