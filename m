Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5B7C433EF
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 15:16:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 329CB3C8E72
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 16:16:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AC2F3C25EC
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 16:15:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8415C10001A3
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 16:15:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0D481FD5A
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637680538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siONAoEy/QGvNNwxpcQdBhh1sgLCDSwRWyHbMYlxXLU=;
 b=V33l6mWuqz8u/7ETV/MxON/IXLvuxFLQ8bNzeKrwQchRSG+e0SQouX5UEVdh4si795ZVrf
 4GH9RhzBKF9+ub4NaKj/scpdmyPponw11ufrEaRsNy079pKNvN4qPwjZo7syNou2wTox4T
 UojlEytDUsjP2WnmRPVBeL8TmokcBWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637680538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siONAoEy/QGvNNwxpcQdBhh1sgLCDSwRWyHbMYlxXLU=;
 b=b9HRq0sV1YyhhacxpPLpAp7os5fgx5cZuopn0H+ZxADd4mzxL6r21vyjkFc5jwp2JVPIS7
 ETDs13nv5RBA0RCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DCFC13E20
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OL5cJZoFnWHqQwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 15:15:38 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Nov 2021 16:15:36 +0100
Message-Id: <20211123151537.14913-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211123151537.14913-1-mdoucha@suse.cz>
References: <20211123151537.14913-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] nfs_lib.sh: Add support for test-specific
 parameters
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 790655643..b01215136 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -19,10 +19,12 @@ nfs_parse_args()
 	case "$1" in
 	v) VERSION="$(echo $2 | tr ',' ' ')";;
 	t) SOCKET_TYPE="$(echo $2 | tr ',' ' ')";;
+	*) [ "$NFS_PARSE_ARGS_CALLER" ] && $NFS_PARSE_ARGS_CALLER "$@";;
 	esac
 }
 
-TST_OPTS="v:t:"
+NFS_PARSE_ARGS_CALLER="$TST_PARSE_ARGS"
+TST_OPTS="v:t:$TST_OPTS"
 TST_PARSE_ARGS=nfs_parse_args
 TST_USAGE=nfs_usage
 TST_NEEDS_TMPDIR=1
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
