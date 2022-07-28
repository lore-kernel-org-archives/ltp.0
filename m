Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13E3C3F6B0
	for <ltp@archiver.kernel.org>; Thu, 28 Jul 2022 11:43:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA2C03C8095
	for <ltp@archiver.kernel.org>; Thu, 28 Jul 2022 13:43:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33A723C2A24
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 13:43:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBEA4200D26
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 13:42:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 466E933E21
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 11:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659008579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GD9m/7UGmoN2yp6bLvRX59mjXHHF1S9KLQcp4+GPdRk=;
 b=piOPLZ6trpbI2NCXthfqQIXuN6ffHIjQ2FZyHwgeBjo+TTzKciUS2qXtNHHMxbVxk1Zpog
 HPUWTJNyTbICptEtE2mzzdjKxNEAVaeSa8APstJR62WwsDQUeX4jB4xRakXJxfoFuREChS
 s8Jc5tZEq4gFKExy+8aXJyGcKs8AgfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659008579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GD9m/7UGmoN2yp6bLvRX59mjXHHF1S9KLQcp4+GPdRk=;
 b=oFVs5YD6tUB/8xvE2iHzws0BrAcXKGznyamqUm9rPhq1BY2Xn8IucOMkTrU1W5pNBJwATw
 znD76M4Ph4sq5wCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3561E13B05
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 11:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uE4VDEN24mLTEgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 28 Jul 2022 11:42:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 28 Jul 2022 13:42:58 +0200
Message-Id: <20220728114258.30832-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220728114258.30832-1-mdoucha@suse.cz>
References: <20220728114258.30832-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_rod: Fail on directory change commands
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

Using tst_rod to check directory change success doesn't work. The command
gets executed in a subprocess and will have no effect on the parent
shell where the directory change is desired.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/lib/tst_rod.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/lib/tst_rod.c b/testcases/lib/tst_rod.c
index 24c1fb668..362471fa9 100644
--- a/testcases/lib/tst_rod.c
+++ b/testcases/lib/tst_rod.c
@@ -77,6 +77,13 @@ int main(int argc, char *argv[])
 
 	args[pos] = NULL;
 
+	if (!strcmp(args[0], "cd") || !strcmp(args[0], "pushd") ||
+		!strcmp(args[0], "popd")) {
+		fprintf(stderr, "\"%s %s\" has no effect on parent shell\n",
+			argv[0], args[0]);
+		return 1;
+	}
+
 	if (stdin_path) {
 		if (close(0)) {
 			fprintf(stderr, "%s: Failed to close stdin: %s\n",
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
