Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495CBC25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 11:09:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BE6E3CEC44
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 13:08:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 266BF3CB558
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:08:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC934100077A
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 13:08:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F3431FF54;
 Wed, 25 Oct 2023 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698232117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Z1yLPwqgduV95TSoZ2J22pVcxT4jIP2a58eZ6/K6xo=;
 b=vILbB/DKNokR/9vkEmPH3KUJSRdeepKW1+8nReANULCmhsrTNzQDWtqL5KRsO1710wJG18
 aqQg8HvrA9pHorWhm0lfuqMFfC2O7w2GXIwE6xF5ZxZCzo9ymayIGENL3HllWarv9oPfEa
 v5CkBG6B4ohzfO7tkI/celeSqObw1y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698232117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/Z1yLPwqgduV95TSoZ2J22pVcxT4jIP2a58eZ6/K6xo=;
 b=OjWIFQWDh+Lx9MPblKu0rMOhjYq8gH7Ywdrhq+tfwJpA5w1EGapXYboeQg8+eZ5WykxLQB
 ewSMAKVAT2pmW3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06E0813524;
 Wed, 25 Oct 2023 11:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +JK8ADX3OGUVUgAAMHmgww
 (envelope-from <mkittler@suse.de>); Wed, 25 Oct 2023 11:08:37 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 13:08:31 +0200
Message-ID: <20231025110835.28832-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.16 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.06)[61.02%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/4] Improve ioctl02.c
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I implemented again the changes requested for the first and last
patch.

That means I removed quite a few comments; I totally agree that
this code was over-commented. I kept a few comments (mainly in the
prepare function for the struct) because some struct members are
over-abbreviated (e.g. `c_cc`) so the comments actually do help
understanding the code. Some comments were also stating the
intention of the code which also seemed not completely useless.

I dropped the intermediate patch to use just termios.

In the last patch I decided to use the double-assignment
suggestion after all because the fields in termios are consistently
wider than the fields in termio so when just swapping the
assignment order this should be fine (there can never be a lossy
conversion). I also decided to make the loop a macro as well
because at this point we might as well go all-in with the macros.

Btw, you're sure you don't want to give C++ a try at some point :-)
(Just mentioning this because I really would have liked using C++
templates in this case and with C++ you can really pick what you
like and keep everything else in the usual C-style.)

Marius Kittler (4):
  Refactor ioctl02.c to use the new test API
  Make checks for termio flags more strict
  Remove disabled code in ioctl02.c
  Extend ioctl02 to test termio and termios

 testcases/kernel/syscalls/ioctl/ioctl02.c | 551 +++++++---------------
 1 file changed, 171 insertions(+), 380 deletions(-)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
