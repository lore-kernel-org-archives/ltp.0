Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA3ACA0FF9
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 14:15:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47CE13D283F
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 16:15:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 971B43D25FE
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 16:14:58 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5842560675C
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 16:14:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F5071F7D5;
 Fri, 30 Aug 2024 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725027296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BywUC4NDXiVaReyyQdE8Xzl7eES/4nkJYFf/Qr9NKh8=;
 b=iOSU+Uggs9PWXrWjkgwzq9ysDP4lMp9vyQiWiJIU5vuSB4vXbFs4a11DNoVWnMRJIrwJHl
 lz3hvPm1iFYMFCkd1Swm6x4Z52aFrkA6KlayiNx7hbTcDsqd7ePE3fcos6zrbNO3W703pR
 075WY2BZvu+r61WJCLMw152uSnNf6UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725027296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BywUC4NDXiVaReyyQdE8Xzl7eES/4nkJYFf/Qr9NKh8=;
 b=92wxgSlghgcFF1LUR29wPnnZHmLA88yGRHFA1VewRSXRljdfNFFj4iiIhaK6S2IbwlVwKY
 MqFmshcPXQ/bwdCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725027296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BywUC4NDXiVaReyyQdE8Xzl7eES/4nkJYFf/Qr9NKh8=;
 b=iOSU+Uggs9PWXrWjkgwzq9ysDP4lMp9vyQiWiJIU5vuSB4vXbFs4a11DNoVWnMRJIrwJHl
 lz3hvPm1iFYMFCkd1Swm6x4Z52aFrkA6KlayiNx7hbTcDsqd7ePE3fcos6zrbNO3W703pR
 075WY2BZvu+r61WJCLMw152uSnNf6UE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725027296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BywUC4NDXiVaReyyQdE8Xzl7eES/4nkJYFf/Qr9NKh8=;
 b=92wxgSlghgcFF1LUR29wPnnZHmLA88yGRHFA1VewRSXRljdfNFFj4iiIhaK6S2IbwlVwKY
 MqFmshcPXQ/bwdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57D2513A66;
 Fri, 30 Aug 2024 14:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MIQ7FeDT0WaXZQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 30 Aug 2024 14:14:56 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: NeilBrown <neilb@suse.de>, Chuck Lever III <chuck.lever@oracle.com>,
 Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Fri, 30 Aug 2024 16:13:40 +0200
Message-ID: <20240830141453.28379-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830141453.28379-1-mdoucha@suse.cz>
References: <20240830141453.28379-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] nfsstat01: Check that RPC stats don't leak
 between net namespaces
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

When the NFS server and client run on the same host in different net
namespaces, check that RPC calls from the client namespace don't
change RPC statistics in the root namespace.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

I've initially tried to test both NFS and RPC client stats but it appears
that NFS client stats are still shared across all namespaces. Only RPC
client stats are separate for each net namespace. The kernel patchset[1]
which introduced per-NS stats confirms that only RPC stats have been changed.

If NFS client stats should be separate for each namespace as well, let
me know and I'll return the second set of NS checks in patch v2.

Tested on kernel v5.14 with Neil's backports.

[1] https://lore.kernel.org/linux-nfs/cover.1708026931.git.josef@toxicpanda.com/

 testcases/network/nfs/nfsstat01/nfsstat01.sh | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfsstat01/nfsstat01.sh b/testcases/network/nfs/nfsstat01/nfsstat01.sh
index 8d7202cf3..3379c4d46 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01.sh
+++ b/testcases/network/nfs/nfsstat01/nfsstat01.sh
@@ -22,6 +22,7 @@ get_calls()
 	local name=$1
 	local field=$2
 	local nfs_f=$3
+	local netns=${4:-rhost}
 	local type="lhost"
 	local calls opt
 
@@ -30,7 +31,8 @@ get_calls()
 
 	if tst_net_use_netns; then
 		# In netns setup, rhost is the client
-		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && type="rhost"
+		[ "$nfs_f" = "nfs" ] && [ $NS_STAT_RHOST -ne 0 ] && \
+			type="$netns"
 	else
 		[ "$nfs_f" != "nfs" ] && type="rhost"
 	fi
@@ -64,13 +66,14 @@ get_calls()
 do_test()
 {
 	local client_calls server_calls new_server_calls new_client_calls
-	local client_field server_field
+	local client_field server_field root_calls new_root_calls
 	local client_v=$VERSION server_v=$VERSION
 
 	tst_res TINFO "checking RPC calls for server/client"
 
 	server_calls="$(get_calls rpc 2 nfsd)"
 	client_calls="$(get_calls rpc 2 nfs)"
+	root_calls="$(get_calls rpc 2 nfs lhost)"
 
 	tst_res TINFO "calls $server_calls/$client_calls"
 
@@ -79,6 +82,7 @@ do_test()
 
 	new_server_calls="$(get_calls rpc 2 nfsd)"
 	new_client_calls="$(get_calls rpc 2 nfs)"
+	new_root_calls="$(get_calls rpc 2 nfs lhost)"
 	tst_res TINFO "new calls $new_server_calls/$new_client_calls"
 
 	if [ "$new_server_calls" -le "$server_calls" ]; then
@@ -93,6 +97,16 @@ do_test()
 		tst_res TPASS "client RPC calls increased"
 	fi
 
+	if [ $NS_STAT_RHOST -ne 0 ]; then
+		tst_res TINFO "Root NS client RPC calls: $root_calls => $new_root_calls"
+
+		if [ $root_calls -ne $new_root_calls ]; then
+			tst_res TFAIL "RPC stats leaked between net namespaces"
+		else
+			tst_res TPASS "RPC stats stay within net namespaces"
+		fi
+	fi
+
 	tst_res TINFO "checking NFS calls for server/client"
 	case $VERSION in
 	2) client_field=13 server_field=13
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
