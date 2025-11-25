Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A18D0E6C4
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 12:21:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A393C3CE01D
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 13:21:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4ED73CC401
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 13:21:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C41061400187
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 13:21:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A6705BD82
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764073285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hIiDFB4lXLCSNaXgSvu9a4tiQUccvW4Fa4L/NPFI88k=;
 b=nlL8k2yDzYOwejq08015355jmSav/Wd0csC/MsVZnH9xoZVp+gWXOiRHyA3XK4UJg7wuuB
 4jiHFGHXjhwmsmyshm0zGE7RWaBIkqK5oWTV7GivfjkYKc0zc7et8TnnWi58w5XBM7lJtA
 4TPkR21AxxcQFo94M+5FvffSvcGOsnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764073285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hIiDFB4lXLCSNaXgSvu9a4tiQUccvW4Fa4L/NPFI88k=;
 b=RAFZ+j9BhwRkGBRFFpySmDsMohRAZ5cXIHcGqyERxNDRZLJecYq4wp2UdZOzbDtTgOP/I7
 wrx09Pp+9P6pUqCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nlL8k2yD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RAFZ+j9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764073285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hIiDFB4lXLCSNaXgSvu9a4tiQUccvW4Fa4L/NPFI88k=;
 b=nlL8k2yDzYOwejq08015355jmSav/Wd0csC/MsVZnH9xoZVp+gWXOiRHyA3XK4UJg7wuuB
 4jiHFGHXjhwmsmyshm0zGE7RWaBIkqK5oWTV7GivfjkYKc0zc7et8TnnWi58w5XBM7lJtA
 4TPkR21AxxcQFo94M+5FvffSvcGOsnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764073285;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hIiDFB4lXLCSNaXgSvu9a4tiQUccvW4Fa4L/NPFI88k=;
 b=RAFZ+j9BhwRkGBRFFpySmDsMohRAZ5cXIHcGqyERxNDRZLJecYq4wp2UdZOzbDtTgOP/I7
 wrx09Pp+9P6pUqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 058FE3EA63
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 12:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NwZ7O0SfJWlIZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 12:21:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Nov 2025 13:22:10 +0100
Message-ID: <20251125122210.11316-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1A6705BD82
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] CI: do not checkout submodules
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

This was originally added so that kirk installation is tested. The
problem is that this brings random failures when git.kernel.org timeouts
when we are checking out submodules that are not needed for the build
and neither for the installation.

Unfortunatelly there is no support for selective submodule installation
in github checkout action. There is an issue and pull request hanging:

https://github.com/actions/checkout/pull/1866
https://github.com/actions/checkout/issues/1969

It looks like if we wanted to checkout only kirk submodule we would have
to install git and run all the commands ourselves in the CI, which I
would like to avoid. Hence this commit removes the submodules checkout
from the CI, with that we sacrifice kirk installation testing but avoid
random failures.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .github/workflows/ci-docker-build.yml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index f7c779f63..09eb8bb6d 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -125,8 +125,6 @@ jobs:
 
     - name: Git checkout
       uses: actions/checkout@v1
-      with:
-        submodules: 'true'
 
     - name: Install additional packages
       run: |
-- 
2.51.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
