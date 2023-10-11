Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F86CD98EA
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 16:08:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56F573CFFF4
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 18:08:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFE973CD4E1
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:08:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A0EBD2099E2
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:08:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C266021885;
 Wed, 11 Oct 2023 16:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697040505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iS2FENIdDgV4fO1DLVQhaDA6y1RnC0P0DDzBPxI2q/A=;
 b=m1TNdNySvIFCEZyRzVvzdsnoqzvGOZPnCitxkhKa6BT+H72jiNSy5HzEqGvse23OMqQ3Jm
 wKL2meut4iEXQOvXL5MxDD9gty2ns+qZcTeLwMwr1OPJcw20W8I9yMjG5+MfeLo+l/B+fk
 I9Hpjc82+KUIgrVWTxfSNvljSPmJSZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697040505;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iS2FENIdDgV4fO1DLVQhaDA6y1RnC0P0DDzBPxI2q/A=;
 b=jjsksC0ae18PkwgbUH7Asezy/Wsoz8zL/Lf2rjh242qFr8M13CtAkahZoGLV40h9V4mS5r
 XGLRnZgUYmNsPVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AEE4134F5;
 Wed, 11 Oct 2023 16:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HyJaG3nIJmVVIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Oct 2023 16:08:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 18:08:19 +0200
Message-ID: <20231011160822.578637-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[26.26%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Cleanup tst_ioctl.c, libswap.c
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

this is somehow related to #1091 [1], but independent on it.

I also wonder if we should move tst_fibmap() out of lib/tst_ioctl.c
(it's the only function there) somewhere. include/tst_fs.h is used
several files, I wonder if there should be lib/tst_fs.c.

Maybe not all C files which use include/tst_fs.h should be merged in it,
but some of them contain only single function (e.g. lib/tst_fs_has_free.c).
Is there any benefit to have that separate? Size? In the end we link libltp.a
to every test binary (unfortunately). I also don't think that for
readability purposes of the sources we need 5 C files in lib/ which use
tst_test.h.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/1091

Petr Vorel (3):
  tst_ioctl: Cleanup the code
  tst_fs.h: Improve tst_fibmap() doc
  libltpswap: TCONF on EPERM

 include/tst_fs.h          |  5 ++++-
 lib/tst_ioctl.c           | 18 ++++--------------
 libs/libltpswap/libswap.c | 10 +++++++---
 3 files changed, 15 insertions(+), 18 deletions(-)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
