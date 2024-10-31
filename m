Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEDFE68974
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 10:28:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98D7C3CBE7E
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 11:28:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 866333CBCF4
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 11:28:25 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 169CD206BF6
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 11:28:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 349541F7DB;
 Thu, 31 Oct 2024 10:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730370504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2vA9M9Z/xd7AYK+YV0wi1fGnTS5gkKW3eSCFh0/Bm04=;
 b=s40PS01ZuTaGh1zy4V0rWpKUX0ZsOQBiLFAIfb3qSHHPjV6Xev1msTgDKp5P1GxUfLY0X9
 MgVMbbtb8Gg/7rZJUkq6qiwLUTIgvN5dByRshJl93oZ3O2yWyihpXkB7P/Nx4x7Wot8hff
 949+cJ/TI6g+wBMXNOvpAIVeUcKCUf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730370504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2vA9M9Z/xd7AYK+YV0wi1fGnTS5gkKW3eSCFh0/Bm04=;
 b=h/ZrobfZimm1sRzVucHgWRYbWBoxhHZfMy2TIT77DFtKRgnnq1Sw+uUfbaKSpkUiR4vx7Y
 FJuyqssYeurI+FAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730370504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2vA9M9Z/xd7AYK+YV0wi1fGnTS5gkKW3eSCFh0/Bm04=;
 b=s40PS01ZuTaGh1zy4V0rWpKUX0ZsOQBiLFAIfb3qSHHPjV6Xev1msTgDKp5P1GxUfLY0X9
 MgVMbbtb8Gg/7rZJUkq6qiwLUTIgvN5dByRshJl93oZ3O2yWyihpXkB7P/Nx4x7Wot8hff
 949+cJ/TI6g+wBMXNOvpAIVeUcKCUf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730370504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2vA9M9Z/xd7AYK+YV0wi1fGnTS5gkKW3eSCFh0/Bm04=;
 b=h/ZrobfZimm1sRzVucHgWRYbWBoxhHZfMy2TIT77DFtKRgnnq1Sw+uUfbaKSpkUiR4vx7Y
 FJuyqssYeurI+FAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2062613A53;
 Thu, 31 Oct 2024 10:28:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TmzwBshbI2eBPQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 31 Oct 2024 10:28:24 +0000
Date: Thu, 31 Oct 2024 11:28:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZyNbzFs39LOOLgV7@yuki.lan>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
 <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
 <20241031094927.GB995052@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031094927.GB995052@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] Refactor regen.sh script to generate
 syscalls
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
> I was comparing the old include/lapi/syscalls.h (21579 lines) and the new one
> (20054). Having new file shorter is a bit surprising to me. I haven't found what
> is missing, probably I'm missing something myself :).

That is strange, I got exactly same content minus some whitespaces and
slightly different macros that check for arch support:

--- syscalls.h.old      2024-10-31 11:17:04.840217056 +0100
+++ syscalls.h  2024-10-31 11:23:38.326891830 +0100
@@ -1,3 +1,5 @@
+
+// SPDX-License-Identifier: GPL-2.0-or-later
 /************************************************
  * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
  *  change your arch specific .in file instead  *
@@ -6,8 +8,6 @@
 /*
  * Here we stick all the ugly *fallback* logic for linux
  * system call numbers (those __NR_ thingies).
- *
- * Licensed under the GPLv2 or later, see the COPYING file.
  */

 #ifndef LAPI_SYSCALLS_H__
@@ -19,30 +19,30 @@

 #ifdef TST_TEST_H__
 #define TST_SYSCALL_BRK__(NR, SNR) ({ \
-       tst_brk(TCONF, \
-               "syscall(%d) " SNR " not supported on your arch", NR); \
+tst_brk(TCONF, \
+       "syscall(%d) " SNR " not supported on your arch", NR); \
 })
 #else
 inline static void dummy_cleanup(void) {}

 #define TST_SYSCALL_BRK__(NR, SNR) ({ \
-       tst_brkm(TCONF, dummy_cleanup, \
-               "syscall(%d) " SNR " not supported on your arch", NR); \
+tst_brkm(TCONF, dummy_cleanup, \
+       "syscall(%d) " SNR " not supported on your arch", NR); \
 })
 #endif

 #define tst_syscall(NR, ...) ({ \
-       intptr_t tst_ret; \
-       if (NR == __LTP__NR_INVALID_SYSCALL) { \
-               errno = ENOSYS; \
-               tst_ret = -1; \
-       } else { \
-               tst_ret = syscall(NR, ##__VA_ARGS__); \
-       } \
-       if (tst_ret == -1 && errno == ENOSYS) { \
-               TST_SYSCALL_BRK__(NR, #NR); \
-       } \
-       tst_ret; \
+intptr_t tst_ret; \
+if (NR == __LTP__NR_INVALID_SYSCALL) { \
+       errno = ENOSYS; \
+       tst_ret = -1; \
+} else { \
+       tst_ret = syscall(NR, ##__VA_ARGS__); \
+} \
+if (tst_ret == -1 && errno == ENOSYS) { \
+       TST_SYSCALL_BRK__(NR, #NR); \
+} \
+tst_ret; \
 })

 #define __LTP__NR_INVALID_SYSCALL -1
@@ -6681,7 +6681,7 @@
 #endif


-#if defined(__mips__) && defined(_ABIN32)
+#ifdef __mips_n32__
 # ifndef __NR_read
 #  define __NR_read 6000
 # endif
@@ -7828,7 +7828,7 @@
 #endif


-#if defined(__mips__) && defined(_ABI64)
+#ifdef __mips_n64__
 # ifndef __NR_read
 #  define __NR_read 5000
 # endif
@@ -8903,7 +8903,7 @@
 #endif


-#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32
+#ifdef __mips_o32__
 # ifndef __NR_syscall
 #  define __NR_syscall 4000
 # endif

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
