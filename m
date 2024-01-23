Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCACDC47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 12:12:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A6C33CE205
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 13:12:15 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC0613CC7B2
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 13:12:00 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DC7411401224
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 13:11:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 980CD21E66;
 Tue, 23 Jan 2024 12:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706011918;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9D40K1eBPuoHK99lP/OQgnh2Dkfk/Hh3FU0eVG7dB30=;
 b=PnaV5e4FlGQUSUG0dwel5t5pEdABgqQaLoDRIvrFrcVj39+qe/u9evmzEWLmHnHpuwLguy
 ixJ8DQ2iREN9uRsjbE8kXHYYsPvLMy3Hs5ki02xKtZuJCMFRbhCI3LZUZtu9oGy7erBAss
 cDSAG7QObW6k9LjfHnTi/s8JehV7+x8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706011918;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9D40K1eBPuoHK99lP/OQgnh2Dkfk/Hh3FU0eVG7dB30=;
 b=LN8BdqsuHpbp5ADLpKa82TQzxVrWijUDohsKLKONyhhSHPenG9QVbeoyDqbDz/ZJKJYHsN
 EpJ+XEsSDvwPYsCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706011918;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9D40K1eBPuoHK99lP/OQgnh2Dkfk/Hh3FU0eVG7dB30=;
 b=PnaV5e4FlGQUSUG0dwel5t5pEdABgqQaLoDRIvrFrcVj39+qe/u9evmzEWLmHnHpuwLguy
 ixJ8DQ2iREN9uRsjbE8kXHYYsPvLMy3Hs5ki02xKtZuJCMFRbhCI3LZUZtu9oGy7erBAss
 cDSAG7QObW6k9LjfHnTi/s8JehV7+x8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706011918;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9D40K1eBPuoHK99lP/OQgnh2Dkfk/Hh3FU0eVG7dB30=;
 b=LN8BdqsuHpbp5ADLpKa82TQzxVrWijUDohsKLKONyhhSHPenG9QVbeoyDqbDz/ZJKJYHsN
 EpJ+XEsSDvwPYsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A36913786;
 Tue, 23 Jan 2024 12:11:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +1NCFw6tr2UmOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 12:11:58 +0000
Date: Tue, 23 Jan 2024 13:11:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240123121156.GA175806@pevik>
References: <20240123114840.2610533-1-liwang@redhat.com>
 <20240123114840.2610533-5-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240123114840.2610533-5-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.06 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.56)[92.11%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V3 4/5] libswap: add function to prealloc
 contiguous file
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

Hi Li,

swapoff01 fails on TMPDIR on btrfs (regardless kernel version):

# ./swapoff01 
rm -f -f -r swapoff01 swapoff02  *.o *.pyc .cache.mk *.dwo .*.dwo
BUILD libltpswap.a
make[1]: Nothing to be done for 'all'.
CC testcases/kernel/syscalls/swapoff/swapoff01
CC testcases/kernel/syscalls/swapoff/swapoff02
tst_test.c:1709: TINFO: LTP version: 20230929-295-gc20ab499a
tst_test.c:1595: TINFO: Timeout per run is 0h 00m 30s
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:33: TINFO: FS_NOCOW_FL attribute set on ./tstswap
swapoff01.c:24: TFAIL: Failed to turn on the swap file, skipping test iteration: EINVAL (22)

=> I guess we would need to replace tst_fill_file() with
prealloc_contiguous_file() (which is not public), or use make_swapfile()
directly. But here we create file first with 65536 blocks and make_swapfile()
creates 10 block file (with prealloc_contiguous_file() or previously also with
tst_fill_file()).

Kind regards,
Petr

--- testcases/kernel/syscalls/swapoff/swapoff01.c
+++ testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -44,11 +44,8 @@ static void setup(void)
                tst_brk(TBROK,
                        "Insufficient disk space to create swap file");
 
-       if (tst_fill_file("swapfile01", 0x00, 1024, 65536))
+       if (make_swapfile("swapfile01", 1))
                tst_brk(TBROK, "Failed to create file for swap");
-
-       if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
-               tst_brk(TBROK, "Failed to make swapfile");
 }



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
