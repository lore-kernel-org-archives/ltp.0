Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844C3C636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 13:17:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 155793CC22D
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 14:17:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56A493CB15E
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:17:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5FD76600917
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:17:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E0A413F828;
 Tue,  7 Feb 2023 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675775839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpez92QL9e4WCkkhDlGzDt6kMqaeNQPlZfaeTdVCZs8=;
 b=hveyGJxWXFO4QiO38toRv9GiUW+gWl0i30lsuBWQBJhjUpiqzW0u4meueCgYaGDpEXXye9
 qstR6miE4h3O5eHzN1Iy54xbJmkbS8rk0A+ms0IGc8MOYg5fREM+zQwgz1w4OpASd6N6hn
 kSLZjRZrBOPJ4gzXa68zpzwAzYN3ycw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675775839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpez92QL9e4WCkkhDlGzDt6kMqaeNQPlZfaeTdVCZs8=;
 b=0fJeTRILK6NVz42bVGXgUcgof5oEdv1N1sKzMr9+KKMUOnqqIN1T/A7rUn6yzU+vIIwwrU
 8sfRBNiuQd+3CgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97EF513467;
 Tue,  7 Feb 2023 13:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2DGIIl9P4mOJbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Feb 2023 13:17:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 Feb 2023 14:17:14 +0100
Message-Id: <20230207131714.2500-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207131714.2500-1-pvorel@suse.cz>
References: <20230207131714.2500-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] runtest/syscalls: Enable ioctl01
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

ioctl01 needs tty device. We check that in 2 previous commits,
thus it can be safely enabled by default.

NOTE: the same should be done for ioctl02, but it should be first
converted to the new API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index ae37a1192a..c4287c3e90 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -543,8 +543,8 @@ getxattr05 getxattr05
 init_module01 init_module01
 init_module02 init_module02
 
+ioctl01 ioctl01
 #Needs tty device.
-#ioctl01 ioctl01 -D /dev/tty0
 #ioctl02 ioctl02 -D /dev/tty0
 
 # Introducing ioctl tests for all /dev/tty* devices
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
