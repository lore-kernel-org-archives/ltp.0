Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F86C4332F
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 19:12:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1ADB53CDA88
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 20:12:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 279643C00CD
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 20:11:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5FAFB1400536
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 20:11:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 92C0F223FD;
 Mon,  7 Nov 2022 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667848317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/62V3PSII9/iNCFnoE48lld+IK4eTx+SC7hHh8nq23o=;
 b=WgtVkftIc2Z3wPesdsvxe6ZknBvfsbSDbMkXt41WvmzyR9nDYcMrmlnsRmlCqVj9XOI6jj
 815iC6cDmRIFJsoh7Ul5KdV5PgV3sMJcMh+ql19V4V/TnNTnt3Tqp4uvrWsf30b6EcpSTV
 cDDpOUup+YflXg3JL5rYUlsLg9EqCjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667848317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/62V3PSII9/iNCFnoE48lld+IK4eTx+SC7hHh8nq23o=;
 b=DUL0MFhVynRThScBibdNyfr+9SEf8qDO6U+7QMRcLQuucFCaRLKlr1Omej/8E0MJk0MgGQ
 Lmwhc/EiygcZGCBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 711B013AC7;
 Mon,  7 Nov 2022 19:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PaIuGHxYaWMjJgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Nov 2022 19:11:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  7 Nov 2022 20:11:35 +0100
Message-Id: <20221107191136.18048-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/1] Possible bug in zram on ppc64le on vfat
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
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kselftest@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

following bug is trying to workaround an error on ppc64le, where
zram01.sh LTP test (there is also kernel selftest
tools/testing/selftests/zram/zram01.sh, but LTP test got further
updates) has often mem_used_total 0 although zram is already filled.

Patch tries to repeatedly read /sys/block/zram*/mm_stat for 1 sec,
waiting for mem_used_total > 0. The question if this is expected and
should be workarounded or a bug which should be fixed.

REPRODUCE THE ISSUE
Quickest way to install only zram tests and their dependencies:
make autotools && ./configure && for i in testcases/lib/ testcases/kernel/device-drivers/zram/; do cd $i && make -j$(getconf _NPROCESSORS_ONLN) && make install && cd -; done

Run the test (only on vfat)
PATH="/opt/ltp/testcases/bin:$PATH" LTP_SINGLE_FS_TYPE=vfat zram01.sh

Petr Vorel (1):
  zram01.sh: Workaround division by 0 on vfat on ppc64le

 .../kernel/device-drivers/zram/zram01.sh      | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
