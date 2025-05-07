Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2A1C3ABC3
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 15:25:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E933D3CBFE0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 17:25:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09CF13CBD4C
 for <ltp@lists.linux.it>; Wed,  7 May 2025 17:25:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E90BD600BE8
 for <ltp@lists.linux.it>; Wed,  7 May 2025 17:25:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2695C21216;
 Wed,  7 May 2025 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746631501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nXa+wpzsspJ/2UuuSnrYegeWwkf/0hnELlk96rkYz0=;
 b=MEvmBclPlkeVoaZVsDA4KrIUAfpGs3daw2qMuA00Wc4uRJdO8isMxxgY/r1IfuMG/QHJMB
 b+HHgVHjJHUjeNB56ba/t8T964y4uOoZc+d8vPMSImCT1/BYxPCvvTOwPrEbm8vSfog9El
 aooCBU4wasjneJQTt4yB2YbdbIiehtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746631501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nXa+wpzsspJ/2UuuSnrYegeWwkf/0hnELlk96rkYz0=;
 b=WwJPgh03Cs1YUA96vh3H/5Pt8h1OrX7lifCr4VwSB/ypnVmWN4PXTIIwm8hFbskG3LDGuQ
 Lgm/+Tm/sFEK35BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746631501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nXa+wpzsspJ/2UuuSnrYegeWwkf/0hnELlk96rkYz0=;
 b=MEvmBclPlkeVoaZVsDA4KrIUAfpGs3daw2qMuA00Wc4uRJdO8isMxxgY/r1IfuMG/QHJMB
 b+HHgVHjJHUjeNB56ba/t8T964y4uOoZc+d8vPMSImCT1/BYxPCvvTOwPrEbm8vSfog9El
 aooCBU4wasjneJQTt4yB2YbdbIiehtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746631501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8nXa+wpzsspJ/2UuuSnrYegeWwkf/0hnELlk96rkYz0=;
 b=WwJPgh03Cs1YUA96vh3H/5Pt8h1OrX7lifCr4VwSB/ypnVmWN4PXTIIwm8hFbskG3LDGuQ
 Lgm/+Tm/sFEK35BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 149C713882;
 Wed,  7 May 2025 15:25:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZKnjAk17G2gVaAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 07 May 2025 15:25:01 +0000
Date: Wed, 7 May 2025 17:25:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aBt7ck35Dq8GIKHc@yuki.lan>
References: <20250416191645.355088-1-wegao@suse.com>
 <20250428160421.3457215-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250428160421.3457215-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap22.c: Test for new MAP_DROPPABLE flag for
 mmap
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
Pushed with a minor change, thanks.

We should check if the addr is valid before we attemp to unmap it in the
setup() so I've added:

diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
index bfef559e4..0e589dfab 100644
--- a/testcases/kernel/syscalls/mmap/mmap22.c
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -72,8 +72,13 @@ static void setup(void)
 {
        void *addr = mmap(0, 1, PROT_READ | PROT_WRITE,
                        MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
+
        if (addr == MAP_FAILED && errno == EINVAL)
-               tst_brk(TCONF, "MAP_DROPPABLE not support");
+               tst_brk(TCONF, "MAP_DROPPABLE not supported");
+
+       if (addr == MAP_FAILED)
+               tst_brk(TBROK | TERRNO, "mmap() MAP_DROPPABLE failed");
+
        SAFE_MUNMAP(addr, 1);
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
