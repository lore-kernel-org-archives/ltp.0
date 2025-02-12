Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD53C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 15:37:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4EF63C9A26
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 16:37:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F061B3C6A7A
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 16:37:40 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BA5AC1BBC39E
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 16:37:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FA68337C6;
 Wed, 12 Feb 2025 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739374657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2MHO3NuLzxmT/NpGhD1MtvIV9R0B1TWBHVC2RNYBu8s=;
 b=CfeVu00V2ezMZinttKUHjqWqSnTSZuEz4+UFsLOvj/1yvSmjXzmsXLz6xMfxr7YykuRavv
 G3dlEpBZFWMPTwQie21Hme+0ux5jL7ddoLkkySpRW6wfhxXJnaWWHdHo4JWxDchl+eTUsP
 q9VNy7mFSxcQNGT9sOFM7R2cwRbvYJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739374657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2MHO3NuLzxmT/NpGhD1MtvIV9R0B1TWBHVC2RNYBu8s=;
 b=usJekAV32U73JkLgQaHhhY5vMjYGlsIb3sWawwdC88OTEM78lTPc6cBUHsx5Tob7XioX8Z
 3twww0nbMlEJndDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739374657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2MHO3NuLzxmT/NpGhD1MtvIV9R0B1TWBHVC2RNYBu8s=;
 b=CfeVu00V2ezMZinttKUHjqWqSnTSZuEz4+UFsLOvj/1yvSmjXzmsXLz6xMfxr7YykuRavv
 G3dlEpBZFWMPTwQie21Hme+0ux5jL7ddoLkkySpRW6wfhxXJnaWWHdHo4JWxDchl+eTUsP
 q9VNy7mFSxcQNGT9sOFM7R2cwRbvYJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739374657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2MHO3NuLzxmT/NpGhD1MtvIV9R0B1TWBHVC2RNYBu8s=;
 b=usJekAV32U73JkLgQaHhhY5vMjYGlsIb3sWawwdC88OTEM78lTPc6cBUHsx5Tob7XioX8Z
 3twww0nbMlEJndDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45CFE13AEF;
 Wed, 12 Feb 2025 15:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t+O9DkHArGcRSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 15:37:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Feb 2025 16:37:30 +0100
Message-ID: <20250212153730.2127667-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] metaparse: Add "api" to JSON
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

metaparse.c prints api: "c"
metaparse-sh.c prints api: "shell"

This is important for the sphinx (readthedoc) test catalog, which will
generate links to C API and shell API (links will be different).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

a follow up to Cyrils shell test parser (metadata-sh.c)
https://patchwork.ozlabs.org/project/ltp/patch/20250212131618.6810-2-chrubis@suse.cz/

Kind regards,
Petr

 metadata/metaparse-sh.c | 1 +
 metadata/metaparse.c    | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/metadata/metaparse-sh.c b/metadata/metaparse-sh.c
index 9eb38f5834..5d1cf0765a 100644
--- a/metadata/metaparse-sh.c
+++ b/metadata/metaparse-sh.c
@@ -26,6 +26,7 @@ static void json_finish(const char *path)
 	if (!started)
 		return;
 
+	printf("   \"api\": \"shell\",\n");
 	printf("   \"fname\": \"%s\"\n", path);
 	printf("  }");
 }
diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 2b96149dcb..0cfe51cc1d 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -1036,9 +1036,12 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	data_node_hash_add(res, "api", data_node_string("c"));
+
 	data_node_hash_add(res, "fname", data_node_string(argv[optind]));
 	printf("  \"%s\": ", strip_name(argv[optind]));
 	data_to_json(res, stdout, 2);
+
 	data_node_free(res);
 
 	return 0;
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
