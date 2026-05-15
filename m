Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD54BCD4F25
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 13:36:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAA8E3E5C6D
	for <ltp@archiver.kernel.org>; Fri, 15 May 2026 15:36:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF4913E5C57
 for <ltp@lists.linux.it>; Fri, 15 May 2026 15:36:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2672A6008F6
 for <ltp@lists.linux.it>; Fri, 15 May 2026 15:36:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5361D760DF;
 Fri, 15 May 2026 13:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778852183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=36jFju0xjLJd1TkuP8AuIhP222xCj3TCt545G3E4TPc=;
 b=hy8w40BH85aUTHam0KZgSSB4WqCAOgRWY6UxTmYxB/13MjY3Mlki305GCTbiPOBpRTPBgE
 0ScBd31nbCt8wncJhzOg/hKbASjOkJYeDsfpe9G6kVLg/Kv4x3TwheDhVaEXexZr/NsJoo
 LiDUG2jM1ntnn8Zc/J3IugG2tkFZy4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778852183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=36jFju0xjLJd1TkuP8AuIhP222xCj3TCt545G3E4TPc=;
 b=9uSt2FuUN07RiGbhNIZNkNjOdRTot/EB2BWckN3Y0FODJG2xhvonyhUgx5AFfOgGTB2oeJ
 qllOgrHTSkJGcHAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hy8w40BH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9uSt2FuU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778852183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=36jFju0xjLJd1TkuP8AuIhP222xCj3TCt545G3E4TPc=;
 b=hy8w40BH85aUTHam0KZgSSB4WqCAOgRWY6UxTmYxB/13MjY3Mlki305GCTbiPOBpRTPBgE
 0ScBd31nbCt8wncJhzOg/hKbASjOkJYeDsfpe9G6kVLg/Kv4x3TwheDhVaEXexZr/NsJoo
 LiDUG2jM1ntnn8Zc/J3IugG2tkFZy4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778852183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=36jFju0xjLJd1TkuP8AuIhP222xCj3TCt545G3E4TPc=;
 b=9uSt2FuUN07RiGbhNIZNkNjOdRTot/EB2BWckN3Y0FODJG2xhvonyhUgx5AFfOgGTB2oeJ
 qllOgrHTSkJGcHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E62CA593A9;
 Fri, 15 May 2026 13:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mSKxNlYhB2p4cQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 May 2026 13:36:22 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 May 2026 15:36:13 +0200
Message-ID: <20260515133613.31249-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid,suse.com:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5361D760DF
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_net.sh: tst_rhost_run(): Go to LTP temporary
 directory first
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

LTP API changes the current working directory when TST_NEEDS_TMPDIR=1
(or .needs_tmpdir = 1S in C API) is set (even legacy shell API test.sh
does that). But this was not true for tst_rhost_run() function in
tst_net.sh, it executed command in the default directory (user home
directory in case of 2 host ssh based setup and / (root) in case of
single host netns based setup).

That is problem on it's own, but it causes problems on read-only root
filesystem.  Wireguard tests in wireguard_lib.sh write file as part of
tst_rhost_run() call:

    tst_rhost_run -s -c "echo '$(cat wg1.key)' > wg1.key"

Which obviously fails on RO /:

    2>&1: line 1: wg1.key: Read-only file system
    wireguard01 1 TBROK: 'echo 'MCqLzPqBbgU/4YOJCH1rrdbOiVFPCWgDpgYZ/hj622A=' > wg1.key' failed on NETNS: ''

While Wireguard tests looks to be the only one which redirect output to
a file in tst_rhost_run() command, it's better to fix the API behavior
instead passing full path ($TST_TMPDIR/wg1.key) to tst_rhost_run().

Reported-by: Petr Cervinka <pcervinka@suse.com>
Fixes: b3906f73cf ("lib: setup rhost TST_TMPDIR if net test sets TST_NEEDS_TMPDIR")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 38435dea74..4e5c1e854a 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -265,6 +265,9 @@ tst_rhost_run()
 		return 1
 	fi
 
+	# go to $TST_TMPDIR before executing the command (once directory created)
+	[ "$TST_TMPDIR_RHOST" = 1 ] && cmd="cd $TST_TMPDIR; $cmd"
+
 	sh_cmd="$pre_cmd $cmd $post_cmd"
 
 	if [ -n "${TST_USE_NETNS:-}" ]; then
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
