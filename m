Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA419C4167B
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 18:31:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 028903CF47A
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 19:31:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE4E03CB385
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:31:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2B6731A0C25F
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:31:24 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB9C3220BC;
 Fri, 15 Dec 2023 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702665084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EmqPqhwuGzBRYpyIU27Kar1clfFnTxVZKUFUvI7tDlk=;
 b=wtmfwbLmzrvRmXmV6kZDOFFh06xMXWOxBXP8eb9MHW7oGsqNKXzEfh3cy4Pq0VFVju5DM0
 BHUtYpxKSnYPXIS974B4OlEoa9BTnh1Kcwewb+0Fblfi5FnIOWSinRaCE/VxRRXtqzOjW8
 TFNtj4EC9LW+HqBQJTxH46alpmFbKuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702665084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EmqPqhwuGzBRYpyIU27Kar1clfFnTxVZKUFUvI7tDlk=;
 b=NCSlPRjzfjGDaso31+NXq9ei0UqMZNW2mnAZZd4JK3NWIBR8xOBqOYZcnwOO3fPkHkh3Qe
 cm7ZBw2QoRulxWAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702665083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EmqPqhwuGzBRYpyIU27Kar1clfFnTxVZKUFUvI7tDlk=;
 b=XN8c4lgBwmh8UWL+LVQHPovDfwy51SwOSAbWYkf/MmSG2LVmAfY/ooYl4AguKG/Ntfxprb
 +JtmfQ0veArXVfOsi0HcD0vKYmJXt/9yeqfACt6fQcXAZLjenfdJOjqlf+ATJ/tXtFIlBO
 tI6FdBxJktRzVB5yw5tQJdFTUIOsC4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702665083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EmqPqhwuGzBRYpyIU27Kar1clfFnTxVZKUFUvI7tDlk=;
 b=cOgSbz1Rl8J5gz+i6a20oaUAmgJFzkndWv05mcMVELdQnv5SoDRCLMxPomLBeV2+544zK4
 WzoajQ9pFe9j/zBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B51D013A08;
 Fri, 15 Dec 2023 18:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id nzkxK3ubfGW2LwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 15 Dec 2023 18:31:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Dec 2023 19:31:18 +0100
Message-ID: <20231215183121.57632-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.67 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.03)[95.20%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] More fsx-linux fixes
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

besides my patchset, which reduces logging via TDEBUG [1] there is
another fix for timeout and runtest cleanup.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=386694&state=*

Petr Vorel (3):
  fsx-linux: Add .max_runtime = 60
  runtest/ltp-aiodio.part3: Keep only unique records
  runtest/ltp-aiodio.part3: Renumber tests

 runtest/ltp-aiodio.part3                  | 69 +++++++----------------
 testcases/kernel/fs/fsx-linux/fsx-linux.c |  1 +
 2 files changed, 22 insertions(+), 48 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
