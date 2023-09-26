Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7510CE7E62F
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:47:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3129C3CDC8F
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 14:47:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 243573C9981
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:46:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E02F1400214
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:46:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B389421858;
 Tue, 26 Sep 2023 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695732413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/MbQ38oUtmlfqZOoNm5IROz2kbYQlTPiABdZFSNqdNg=;
 b=pgZqazHSM8rhcZfJG7YEbOINGenIz2/d+ASikOp3D2gfDagO4ebXwpwTK08TetAak1ugaX
 63KPT8f7ijw0Ez4Oy3Z3e0TOYZa++WjRBAkVu/leIhnhzm4B3yIWplF9TnR3YF8tFhMpR5
 LsTZx7+ELqquCRIAtzHffqPpNnOHIgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695732413;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/MbQ38oUtmlfqZOoNm5IROz2kbYQlTPiABdZFSNqdNg=;
 b=pfqcYP4HhXcMhewQkQrbGmP5hb58plmoFTQj9bJJCd63x6ZnJR6qOxOx44hv/tTtO9ECGJ
 vRvhOFg7Lr5U9gCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C24413434;
 Tue, 26 Sep 2023 12:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LroqHb3SEmXxHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Sep 2023 12:46:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 Sep 2023 14:46:45 +0200
Message-Id: <20230926124647.152972-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Fix vma05.sh on $DEBUGINFOD_URLS
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

first patch is a candidate for pre-release fix.
Second commit is not strictly needed.

Kind regards,
Petr

Petr Vorel (2):
  vma05.sh: Add workaround for gdb debuginfod question
  vma05.sh: Add check for core file presence

 testcases/kernel/mem/vma/vma05.sh | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
