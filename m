Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0561C55179
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:58:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD8623E74F9
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 13:58:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C74A3E62BB
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 13:58:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE0E0200058
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 13:58:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 03CA13ED2;
 Mon,  3 Aug 2026 11:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785758308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=62+ysjpf9Qbw/KqC47upfmo2WJTU7qrlYXCr39k/bqg=;
 b=YS3QhefSHYQXISOSbT2C0MeVXWGth/dYvKnhl+6JV2OfsDXizqGsy9NWgcIQprdGkwP8Rg
 QAy2OWETyXe1HddjoQ7WnXhR7nDvUjFNYjbvKcBrxYZEkMZNelBEvv1rt9ggeJ8RoD8heB
 j61670yTB+jehM75dvxijzw8HyT0NKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785758308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=62+ysjpf9Qbw/KqC47upfmo2WJTU7qrlYXCr39k/bqg=;
 b=fdDtKG78BtejHObk2+a74MQ6OpHShex47ACXEZoNqX/PaHXuynNQlguFAnUekvsbU8ddKZ
 mjwWiv1xLVgOSdBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rbAkN2fj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KmEDpA5h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785758304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=62+ysjpf9Qbw/KqC47upfmo2WJTU7qrlYXCr39k/bqg=;
 b=rbAkN2fj8gSm5FTtqFvgW6hJBuQJSqj8Grzf8BlgzdfbbCuQY0y/idUsbjr0wFHx9U2/Lk
 Evdz05418UoYXqDbkOUdWKA7A+DV2NqxFqC20E1XZHz+XG+amXl8s1plLtaS2s7DAVtmoJ
 s3pa83aZhx6inUoC5SizQRpSOtpynlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785758304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=62+ysjpf9Qbw/KqC47upfmo2WJTU7qrlYXCr39k/bqg=;
 b=KmEDpA5hCq23NtopcPGIFRrPL7JPZrZ2d1Fy6zpTCdH/iWxaMlSJrPzJx0CyBvOF7pMEpx
 KgWNe0Eamnw9sGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F5B4779A1;
 Mon,  3 Aug 2026 11:58:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RpOaDF+CcGrcLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Aug 2026 11:58:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-kernel@vger.kernel.org
Date: Mon,  3 Aug 2026 13:58:21 +0200
Message-ID: <20260803115821.238704-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,linux-test-project.readthedocs.io:url,fujitsu.com:email,linux.it:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[fujitsu.com:email,linux.it:email,suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 03CA13ED2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] MAINTAINERS: Add IRC and patchwork for LTP
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
Cc: Tim Bird <tim.bird@sony.com>, Andrew Morton <akpm@linux-foundation.org>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP project recently switched to patchwork.kernel.org,
document it. Add also IRC channel.

Link: https://github.com/linux-test-project/ltp/commit/3590f66120d1c875bef5d573c66c4c0d340c1612
Link: https://lore.kernel.org/ltp/20260731054548.133241-1-pvorel@suse.cz/
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Add IRC

Link to v1:
https://lore.kernel.org/lkml/20260803111553.229452-1-pvorel@suse.cz/

 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe67f7bfa44c..72c24bb6ea82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15520,7 +15520,9 @@ M:	Yang Xu <xuyang2018.jy@fujitsu.com>
 M:	Xiao Yang <yangx.jy@fujitsu.com>
 L:	ltp@lists.linux.it (subscribers-only)
 S:	Maintained
+C:	irc://irc.libera.chat/ltp
 W:	https://linux-test-project.readthedocs.io/
+Q:	https://patchwork.kernel.org/project/ltp/list/
 T:	git https://github.com/linux-test-project/ltp.git
 
 LTR390 AMBIENT/UV LIGHT SENSOR DRIVER
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
