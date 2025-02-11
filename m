Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9549EC0219E
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 15:48:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7876A3C996A
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 16:48:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBC063C98EF
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 16:48:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 52B8E237BDB
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 16:48:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C5DE3ECEF
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739276638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoL6cLVK7YQFcU3YM+4Jo5ajUZdClz5dXyhat7FxxNQ=;
 b=Nimw/D7DBONBAGbmm0xc255xeDelUWgPm/NXlW8oxKwBXqHDI7hYA57mPflBupUxX1uzvs
 Q4N1Da3Wh5QPTyrYtjphyAWsBKG8crEF3YzAX+36EG/kM2EhW6zl9DXcsfJV62h6Dwro2b
 2WmeqMcS64GxLlUnmpHTodmBKe89ahs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739276638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoL6cLVK7YQFcU3YM+4Jo5ajUZdClz5dXyhat7FxxNQ=;
 b=6Fc9Xr2PV9UqiFPs5TW7N2g+WskVCYZxUhsb/fzCXfzR/6mykT6ux1JQj7qANkbNrPR8HI
 jhMQ9Bx8amV9cwDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739276638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoL6cLVK7YQFcU3YM+4Jo5ajUZdClz5dXyhat7FxxNQ=;
 b=Nimw/D7DBONBAGbmm0xc255xeDelUWgPm/NXlW8oxKwBXqHDI7hYA57mPflBupUxX1uzvs
 Q4N1Da3Wh5QPTyrYtjphyAWsBKG8crEF3YzAX+36EG/kM2EhW6zl9DXcsfJV62h6Dwro2b
 2WmeqMcS64GxLlUnmpHTodmBKe89ahs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739276638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoL6cLVK7YQFcU3YM+4Jo5ajUZdClz5dXyhat7FxxNQ=;
 b=6Fc9Xr2PV9UqiFPs5TW7N2g+WskVCYZxUhsb/fzCXfzR/6mykT6ux1JQj7qANkbNrPR8HI
 jhMQ9Bx8amV9cwDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB9E513AA6
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 12:23:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IBIrOV1Bq2dsIQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 12:23:57 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Feb 2025 13:23:50 +0100
Message-ID: <20250211122354.18324-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211122354.18324-1-mdoucha@suse.cz>
References: <20250211122354.18324-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] nfs10.sh: Remove fixed loop count from fsplough
 command
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

The fsplough test now runs for 30 seconds by default. Remove the fixed
number of loops from the NFS variant and use the safer default behavior.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/nfs/nfs_stress/nfs10.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs10.sh b/testcases/network/nfs/nfs_stress/nfs10.sh
index 17fb4e866..e52db8e29 100755
--- a/testcases/network/nfs/nfs_stress/nfs10.sh
+++ b/testcases/network/nfs/nfs_stress/nfs10.sh
@@ -25,25 +25,25 @@ nfs10_setup()
 do_test1()
 {
 	tst_res TINFO "Testing buffered write, buffered read"
-	EXPECT_PASS fsplough -c 512 -d "$PWD"
+	EXPECT_PASS fsplough -d "$PWD"
 }
 
 do_test2()
 {
 	tst_res TINFO "Testing buffered write, direct read"
-	EXPECT_PASS fsplough -c 512 -R -d "$PWD"
+	EXPECT_PASS fsplough -R -d "$PWD"
 }
 
 do_test3()
 {
 	tst_res TINFO "Testing direct write, buffered read"
-	EXPECT_PASS fsplough -c 512 -W -d "$PWD"
+	EXPECT_PASS fsplough -W -d "$PWD"
 }
 
 do_test4()
 {
 	tst_res TINFO "Testing direct write, direct read"
-	EXPECT_PASS fsplough -c 512 -RW -d "$PWD"
+	EXPECT_PASS fsplough -RW -d "$PWD"
 }
 
 . nfs_lib.sh
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
