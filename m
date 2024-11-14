Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B924DD68B2B
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 14:41:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5F413D6F46
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 15:41:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127783D6F3E
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:37 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2CE661000DA0
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24BF81F38F;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ALN8WrDnFIigWnlq4rno3V99vMKupc7PA9SqVDOU4xU=;
 b=lRTJhXOV0lCSOyl7o1M6eVihaXsIeZuSKxBvRqQobO3pEslfzBm5R4VBq74li+A0NR/1Wu
 8wT3fWVCKYmu4RYCgm0EefnrPa7MOc/uDSoFCz6NLWBZJegUQESwuy9RsMvwuuJyfQNB2+
 JPTVTHx9ffTCdKAr9dW/+iDZW+dIBJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ALN8WrDnFIigWnlq4rno3V99vMKupc7PA9SqVDOU4xU=;
 b=kHlOEvnptme0x49umIbqYarOT3UZ6ke/QyXqSVL4pbbbcjXVXwSsQfRPualS/mpNdiYWWU
 jijovgfXcFuCsRBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lRTJhXOV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kHlOEvnp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ALN8WrDnFIigWnlq4rno3V99vMKupc7PA9SqVDOU4xU=;
 b=lRTJhXOV0lCSOyl7o1M6eVihaXsIeZuSKxBvRqQobO3pEslfzBm5R4VBq74li+A0NR/1Wu
 8wT3fWVCKYmu4RYCgm0EefnrPa7MOc/uDSoFCz6NLWBZJegUQESwuy9RsMvwuuJyfQNB2+
 JPTVTHx9ffTCdKAr9dW/+iDZW+dIBJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ALN8WrDnFIigWnlq4rno3V99vMKupc7PA9SqVDOU4xU=;
 b=kHlOEvnptme0x49umIbqYarOT3UZ6ke/QyXqSVL4pbbbcjXVXwSsQfRPualS/mpNdiYWWU
 jijovgfXcFuCsRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFF7513721;
 Thu, 14 Nov 2024 14:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MynhOOILNmeSdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 14:40:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Nov 2024 15:40:24 +0100
Message-ID: <20241114144029.349559-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 24BF81F38F
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, ozlabs.org:url, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] mq_timedsend01: sigtimedwait01: Workaround
 segfault on libc variant on 32 bit
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

Hi,

similar patchset to
https://patchwork.ozlabs.org/project/ltp/patch/20241112171831.156440-2-pvorel@suse.cz/

Kind regards,
Petr

Petr Vorel (5):
  mq_timedsend01: Fix different signedness error on 32bit
  mq_timedsend01: Remove unneeded designated initializers
  mq_timedsend01: Workaround segfault on libc variant on 32 bit
  libs/sigwait: Workaround segfault on libc variant on 32 bit
  libs/sigwait: Use safe/test macros

 libs/sigwait/sigwait.c                        |  47 ++++----
 .../syscalls/mq_timedsend/mq_timedsend01.c    | 104 +++++++++++-------
 2 files changed, 86 insertions(+), 65 deletions(-)

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
