Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB09C52D7F
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 09:33:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F202A3D212F
	for <ltp@archiver.kernel.org>; Wed, 14 Aug 2024 11:33:54 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AFA93D2026
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:33:38 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 58DD31A01147
 for <ltp@lists.linux.it>; Wed, 14 Aug 2024 11:33:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE1FF1FE84;
 Wed, 14 Aug 2024 09:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723628016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8KeldISweYlyBn2Rc9jXHmgstsM042C0JEwQi1qpA5g=;
 b=EcBNECJkunPEwB6NgrF64fglWkog6OrjXafUtcT+5xVbmmFEBbzt6KiORVgSsIU7TSykqf
 0ukuJrim9W4uh6F3RvkhZova/76S4tHmKO/jhAQv20JsmpYdBb9Zr00a0NEJepGbo7v+ka
 juMt1+Z4iI5S3mcBZ+KbvtiQ5Argjbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723628016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8KeldISweYlyBn2Rc9jXHmgstsM042C0JEwQi1qpA5g=;
 b=qV/9a5/T8nX/rhE8qAQfz7v+ExUmetnwb5TvAT+cx+Ot3wfnN0RmkgyUUVFbkkGXzD6T9X
 tngrNSfBl4wHf7BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1723628016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8KeldISweYlyBn2Rc9jXHmgstsM042C0JEwQi1qpA5g=;
 b=EcBNECJkunPEwB6NgrF64fglWkog6OrjXafUtcT+5xVbmmFEBbzt6KiORVgSsIU7TSykqf
 0ukuJrim9W4uh6F3RvkhZova/76S4tHmKO/jhAQv20JsmpYdBb9Zr00a0NEJepGbo7v+ka
 juMt1+Z4iI5S3mcBZ+KbvtiQ5Argjbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1723628016;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8KeldISweYlyBn2Rc9jXHmgstsM042C0JEwQi1qpA5g=;
 b=qV/9a5/T8nX/rhE8qAQfz7v+ExUmetnwb5TvAT+cx+Ot3wfnN0RmkgyUUVFbkkGXzD6T9X
 tngrNSfBl4wHf7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11E5013B1A;
 Wed, 14 Aug 2024 08:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9+FTAnlxvGYqagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 14 Aug 2024 08:57:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 14 Aug 2024 10:57:21 +0200
Message-ID: <20240814085721.518800-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for kernel
 6.9
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

6.9 moved client RPC calls to namespace in "Make nfs stats visible in
network NS" patchet.

https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Point out whole patchset, not just single commit
* Add a comment about the patchset

Hi all,

could you please ack this so that we have fixed mainline?

FYI Some parts has been backported, e.g.:
d47151b79e322 ("nfs: expose /proc/net/sunrpc/nfs in net namespaces")
to all stable/LTS: 5.4.276, 5.10.217, 5.15.159, 6.1.91, 6.6.31.

But most of that is not yet (but planned to be backported), e.g.
93483ac5fec62 ("nfsd: expose /proc/net/sunrpc/nfsd in net namespaces")
see Chuck's patchset for 6.6
https://lore.kernel.org/linux-nfs/20240812223604.32592-1-cel@kernel.org/

Once all kernels up to 5.4 fixed we should update the version.

Kind regards,
Petr

 testcases/network/nfs/nfsstat01/nfsstat01.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index c2856eff1f..1beecbec43 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -15,7 +15,14 @@ get_calls()
 	local calls opt
 
 	[ "$name" = "rpc" ] && opt="r" || opt="n"
-	! tst_net_use_netns && [ "$nfs_f" != "nfs" ] && type="rhost"
+
+	if tst_net_use_netns; then
+		# "Make nfs stats visible in network NS" patchet
+		# https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/
+		tst_kvcmp -ge "6.9" && [ "$nfs_f" = "nfs" ] && type="rhost"
+	else
+		[ "$nfs_f" != "nfs" ] && type="rhost"
+	fi
 
 	if [ "$type" = "lhost" ]; then
 		calls="$(grep $name /proc/net/rpc/$nfs_f | cut -d' ' -f$field)"
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
