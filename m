Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA27CCA464
	for <ltp@archiver.kernel.org>; Fri, 16 Oct 2026 09:06:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 438323EA717
	for <ltp@archiver.kernel.org>; Fri, 16 Oct 2026 11:06:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 267AD3E29D4
 for <ltp@lists.linux.it>; Fri, 16 Oct 2026 11:06:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4AC1F1000A52
 for <ltp@lists.linux.it>; Fri, 16 Oct 2026 11:06:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F90D1F452;
 Fri, 16 Oct 2026 09:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792141589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yDOV0ECqGxUCJDIEnAhSxoUblgSgZ34G3oUWQTymYpM=;
 b=iOeb9bXq7+oQUYXDnQt1WWaSElQ9oL47e0Dg+h9g1cGbiRd0zk85oHItQRTAVTQZpj4lyn
 uoC82WGBK/9HEKU0O5lq7v9+wjL8D4O1k/6M5wR6DlwPUPBo2+9O+II7dh5xT1IPuQtd4H
 fO+6hSNjbboATzh/cnQrIV4w2GJN15o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792141589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yDOV0ECqGxUCJDIEnAhSxoUblgSgZ34G3oUWQTymYpM=;
 b=dY2NP2YgrgKOsB2ENo69uwn2pdc+Qm7dRkpWtFmZZkAO8AiDf4MkleYA7w0MCm3k0P5FL6
 Wnc8g6cOWHtXDRAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iOeb9bXq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dY2NP2Yg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792141589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yDOV0ECqGxUCJDIEnAhSxoUblgSgZ34G3oUWQTymYpM=;
 b=iOeb9bXq7+oQUYXDnQt1WWaSElQ9oL47e0Dg+h9g1cGbiRd0zk85oHItQRTAVTQZpj4lyn
 uoC82WGBK/9HEKU0O5lq7v9+wjL8D4O1k/6M5wR6DlwPUPBo2+9O+II7dh5xT1IPuQtd4H
 fO+6hSNjbboATzh/cnQrIV4w2GJN15o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792141589;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yDOV0ECqGxUCJDIEnAhSxoUblgSgZ34G3oUWQTymYpM=;
 b=dY2NP2YgrgKOsB2ENo69uwn2pdc+Qm7dRkpWtFmZZkAO8AiDf4MkleYA7w0MCm3k0P5FL6
 Wnc8g6cOWHtXDRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 397291339F;
 Fri, 16 Oct 2026 09:06:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hu2BOhTp0WpxAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 16 Oct 2026 09:06:29 +0000
Date: Fri, 16 Oct 2026 11:06:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <20261016090623.GB311652@pevik>
References: <as9x2R-9IQb7vjn7@toolbx>
 <27AE9564-6115-491B-AE80-D9016EA7CDB5@suse.com>
 <20261015083851.GA290292@pevik> <atCVc5kQoGx5spgk@toolbx>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <atCVc5kQoGx5spgk@toolbx>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 7F90D1F452
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] Suggested fix for the mremap03
 syscall testcase
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi Petr,

> with patched testcase, valgrind doesn't crash any more, at least
> my fresh upstream version of valgrind doesn't:

> $ git log -1 --oneline testcases/kernel/syscalls/mremap/mremap03.c
> 3ddcfa8c3 (HEAD -> master) Fix the mremap03 syscall testcase
> $ valgrind --version
> valgrind-3.28.0.GIT
> $ valgrind testcases/kernel/syscalls/mremap/mremap03
> ==1419973== Memcheck, a memory error detector
> ==1419973== Copyright (C) 2002-2026, and GNU GPL'd, by Julian Seward et al.
> ==1419973== Using Valgrind-3.28.0.GIT and LibVEX; rerun with -h for copyright info
> ==1419973== Command: testcases/kernel/syscalls/mremap/mremap03
> ==1419973== 
> tst_test.c:2061: TINFO: LTP version: 20260930-20-g3ddcfa8c3
> tst_test.c:2064: TINFO: Tested kernel: 7.2.7-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 21 18:25:57 UTC 2026 x86_64
> tst_kconfig.c:73: TINFO: Couldn't locate kernel config!
> tst_test.c:1895: TINFO: Overall timeout per run is 0h 00m 30s
> mremap03.c:42: TFAIL: mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE) expected EFAULT: EINVAL (22)
> ==1419992== 
> ==1419992== HEAP SUMMARY:
> ==1419992==     in use at exit: 0 bytes in 0 blocks
> ==1419992==   total heap usage: 13 allocs, 13 frees, 7,647 bytes allocated
> ==1419992== 
> ==1419992== All heap blocks were freed -- no leaks are possible
> ==1419992== 
> ==1419992== For lists of detected and suppressed errors, rerun with: -s
> ==1419992== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)

> Summary:
> passed   0
> failed   1
> broken   0
> skipped  0
> warnings 0
> ==1419973== 
> ==1419973== HEAP SUMMARY:
> ==1419973==     in use at exit: 0 bytes in 0 blocks
> ==1419973==   total heap usage: 6 allocs, 6 frees, 4,488 bytes allocated
> ==1419973== 
> ==1419973== All heap blocks were freed -- no leaks are possible
> ==1419973== 
> ==1419973== For lists of detected and suppressed errors, rerun with: -s
> ==1419973== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
> $

> But that doesn't mean things are perfect.  The main problem is
> that under valgrind the testcase behaves differently compared to
> a run without valgrind. Looking into it.  Thanks for the merge.

I see, there is more work needed :). Anyway, false positive is much better than
test crash and we are happy to have test regression fixed.

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
