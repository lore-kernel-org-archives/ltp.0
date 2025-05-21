Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76087C54E65
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 09:53:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFEF23CC7AC
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 11:53:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CE2F3CC7A7
 for <ltp@lists.linux.it>; Wed, 21 May 2025 11:53:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 21FBA14060D9
 for <ltp@lists.linux.it>; Wed, 21 May 2025 11:53:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90C03208F2;
 Wed, 21 May 2025 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747821201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2zqB3lp9A2KSRpgxG5+NlAgmcVUV9VND0eLqOYhOkE4=;
 b=p/RYG4VxqVM0bcUE4NS9rkRUUg3+s2F+ZZlJ03CMjqfvnAWdARMUv75Qo39O/0d0HJEqPU
 mjeNFdnqy+r3m2LPB0PE47S+GRc2RaoOfF2Eyvtpa12l5zZBFbk3iQqbWe/9amUevS7V1U
 tu/KxObRxy1PiUqRC9zw9YH9n1aOiFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747821201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2zqB3lp9A2KSRpgxG5+NlAgmcVUV9VND0eLqOYhOkE4=;
 b=Jp3zfE8mF8b8xJ7V+lCADzK80bW0OIhrvRGAJ7kIHXE5kmmkWa5WzmMRAIpvV4hW+k9/kb
 WUcjNvfTKVYVVCBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747821201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2zqB3lp9A2KSRpgxG5+NlAgmcVUV9VND0eLqOYhOkE4=;
 b=p/RYG4VxqVM0bcUE4NS9rkRUUg3+s2F+ZZlJ03CMjqfvnAWdARMUv75Qo39O/0d0HJEqPU
 mjeNFdnqy+r3m2LPB0PE47S+GRc2RaoOfF2Eyvtpa12l5zZBFbk3iQqbWe/9amUevS7V1U
 tu/KxObRxy1PiUqRC9zw9YH9n1aOiFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747821201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2zqB3lp9A2KSRpgxG5+NlAgmcVUV9VND0eLqOYhOkE4=;
 b=Jp3zfE8mF8b8xJ7V+lCADzK80bW0OIhrvRGAJ7kIHXE5kmmkWa5WzmMRAIpvV4hW+k9/kb
 WUcjNvfTKVYVVCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81B5413888;
 Wed, 21 May 2025 09:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t/j5HpGiLWiLRgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 May 2025 09:53:21 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 21 May 2025 11:53:02 +0200
Message-ID: <20250521095302.13845-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [0.20 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: LTP_SINGLE_FS_TYPE fix fuse blacklist
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

The case of LTP_SINGLE_FS_TYPE did not proplerly used the fuse
filesystem blacklist and we enabled fuse filesystem even for tests that
explicitly stated in the tst_test structure that they do not work with
fuse.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Jan Polensky <japo@linux.ibm.com>
---
 lib/tst_supported_fs_types.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index bbbb8df19..3a394283c 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -158,8 +158,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
 	only_fs = getenv("LTP_SINGLE_FS_TYPE");
 
 	if (only_fs) {
+		enum tst_fs_impl ret;
 		tst_res(TINFO, "WARNING: testing only %s", only_fs);
-		if (tst_fs_is_supported(only_fs))
+		ret = tst_fs_is_supported(only_fs);
+		if (ret == TST_FS_KERNEL || (ret == TST_FS_FUSE && !skip_fuse))
 			fs_types[0] = only_fs;
 		return fs_types;
 	}
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
