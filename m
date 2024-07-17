Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C53C3DA60
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:18:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9ABCC3D1AEA
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:18:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA55A3D0C9E
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:20 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D719C140051E
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37B2D21A11;
 Wed, 17 Jul 2024 17:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdLKvkpllA+LHnDUZUR6JYzA0H7At2MEORRlUczMNlQ=;
 b=RdsTx1eGGo3FVPZBYyYVn4Jms55zKE5MLXVrqYGsV6FKFu1o+v+6PjS3MJhk5yLPs0SfBW
 1BFHZPlQ9W6dLi/Rye5uwkjrZJMulweuH1/cs2bUr66EXG8cEwri013Mr1IlnpbfM6A7tk
 l0D+dowJVnVNYilZFJ9nwtISIXHlomI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdLKvkpllA+LHnDUZUR6JYzA0H7At2MEORRlUczMNlQ=;
 b=/QFRhj47NrshTNKqQKdD1lt1d9/WUS1Bl2mLBBY85GUS/pQ58bg3sSByOcC8+KYS20Rrmp
 WNFb5fy48k0fvsDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RdsTx1eG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/QFRhj47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdLKvkpllA+LHnDUZUR6JYzA0H7At2MEORRlUczMNlQ=;
 b=RdsTx1eGGo3FVPZBYyYVn4Jms55zKE5MLXVrqYGsV6FKFu1o+v+6PjS3MJhk5yLPs0SfBW
 1BFHZPlQ9W6dLi/Rye5uwkjrZJMulweuH1/cs2bUr66EXG8cEwri013Mr1IlnpbfM6A7tk
 l0D+dowJVnVNYilZFJ9nwtISIXHlomI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdLKvkpllA+LHnDUZUR6JYzA0H7At2MEORRlUczMNlQ=;
 b=/QFRhj47NrshTNKqQKdD1lt1d9/WUS1Bl2mLBBY85GUS/pQ58bg3sSByOcC8+KYS20Rrmp
 WNFb5fy48k0fvsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0132B139B3;
 Wed, 17 Jul 2024 17:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UNhWOp38l2ZQOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 17:17:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jul 2024 19:17:09 +0200
Message-ID: <20240717171713.687339-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717171713.687339-1-pvorel@suse.cz>
References: <20240717171713.687339-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 37B2D21A11
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] configure: Don't assume
 testcases/realtime/configure.ac
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

a05298ec44 removed autotools configuration including
testcases/realtime/configure.ac. Running ./configure --with-realtime-testsuite
produces warning:

    === configuring in testcases/realtime (ltp/testcases/realtime)
    configure: WARNING: no configuration information is in testcases/realtime

Hence remove AC_CONFIG_SUBDIRS([testcases/realtime]).

Fixes: a05298ec44 ("testcases: realtime: Get rid of autotools")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 3958e551c0..8f8003f53b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -376,8 +376,6 @@ AC_ARG_WITH([realtime-testsuite],
 
 if test "x$with_realtime_testsuite" = xyes; then
     AC_SUBST([WITH_REALTIME_TESTSUITE],["yes"])
-    # Run configure on testcases/realtime as well.
-    AC_CONFIG_SUBDIRS([testcases/realtime])
 else
     AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
 fi
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
