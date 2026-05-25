Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9CCCD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 15:15:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6219D3E62D8
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 17:15:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23A753E62E4
 for <ltp@lists.linux.it>; Mon, 25 May 2026 17:15:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E0B791A0065D
 for <ltp@lists.linux.it>; Mon, 25 May 2026 17:15:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE6B96AA0C
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779722105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Vh9x6J6I2Szop5zRHGzELvTfi2ZIB6/OO8as51wqzY=;
 b=lFX/U6WMQJfTsZk8uMFfL884IZjgkLnu38hRuGEuPNFO5jTsQfhlo6fjK+DyOOE5RNMGfr
 p4PqZ1CGhiCafXNqYgJNG+5eDvIBQJP5M61RoVVBli0DT1SxZEkE5f05RwkYwb2y4OppVt
 U3gsXO3KzAX5IC+6K6V2nQAHvbtwq2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779722105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Vh9x6J6I2Szop5zRHGzELvTfi2ZIB6/OO8as51wqzY=;
 b=0wGC/oI+nGWZlx42bJ6LJ4VO4dIxSn/ELOXai7cQZgMmI6crk87FESVe9DEsovGJ6VoIIG
 y3AxEI8+7TLczcAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779722105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Vh9x6J6I2Szop5zRHGzELvTfi2ZIB6/OO8as51wqzY=;
 b=lFX/U6WMQJfTsZk8uMFfL884IZjgkLnu38hRuGEuPNFO5jTsQfhlo6fjK+DyOOE5RNMGfr
 p4PqZ1CGhiCafXNqYgJNG+5eDvIBQJP5M61RoVVBli0DT1SxZEkE5f05RwkYwb2y4OppVt
 U3gsXO3KzAX5IC+6K6V2nQAHvbtwq2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779722105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Vh9x6J6I2Szop5zRHGzELvTfi2ZIB6/OO8as51wqzY=;
 b=0wGC/oI+nGWZlx42bJ6LJ4VO4dIxSn/ELOXai7cQZgMmI6crk87FESVe9DEsovGJ6VoIIG
 y3AxEI8+7TLczcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC54259CE6
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fvisMHlnFGpaYAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 25 May 2026 15:15:05 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 17:14:49 +0200
Message-ID: <20260525151449.203586-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525151449.203586-1-chrubis@suse.cz>
References: <20260525151449.203586-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 internal_greylist_whitelist(0.00)[10.150.64.97];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls/inotify{07,
 08}: Fix TBROK on older kernels
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

When kernel fails to generate events the read returns EAGAIN and since
we switches to SAFE_READ() the tests now TBROK when kernel does not
generate events. Fix this by passing the newly introduced
SAFE_READ_ANY_EAGAIN flag to the SAFE_READ().

Fixes: deda021818a4 ('inotify: modernize with SAFE_ wrappers')
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify07.c | 2 +-
 testcases/kernel/syscalls/inotify/inotify08.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index b4000f353..9cadbf656 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -88,7 +88,7 @@ void verify_inotify(void)
 	strcpy(event_set[test_cnt].name, FILE_NAME);
 	test_cnt++;
 
-	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	int len = SAFE_READ(SAFE_READ_ANY_EAGAIN, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	int i = 0, test_num = 0;
 	while (i < len) {
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index e0837cac3..23d3c5a65 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -86,7 +86,7 @@ void verify_inotify(void)
 	SAFE_TOUCH(OVL_LOWER"/"FILE_NAME, 0644, NULL);
 	SAFE_TOUCH(OVL_UPPER"/"FILE_NAME, 0644, NULL);
 
-	int len = SAFE_READ(0, fd_notify, event_buf, EVENT_BUF_LEN);
+	int len = SAFE_READ(SAFE_READ_ANY_EAGAIN, fd_notify, event_buf, EVENT_BUF_LEN);
 
 	int i = 0, test_num = 0;
 	while (i < len) {
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
