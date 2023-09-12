Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA67CA0EEB
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 14:44:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A10923CE7EA
	for <ltp@archiver.kernel.org>; Tue, 12 Sep 2023 16:44:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E91323CB33E
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 16:43:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4D0771401332
 for <ltp@lists.linux.it>; Tue, 12 Sep 2023 16:43:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D54E51F74A;
 Tue, 12 Sep 2023 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694529834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOUd3TIIPkRbnBhsu5My2OMsdiQu55nXnkVNBSNyjbg=;
 b=C/73QHrc5pyvI7p7r02Nw+3JcD7bltwJ7mxvsPNEXaTt67CXxxEfr4hZN5yuiacXIcRYe6
 9N1vRJ22eWf7oj2V8Nj+ob6I64j9Lues1ioeWjtSTjIEzWdIH1czd6hBvjKM5cSzPu43aI
 Ipe3vw6GLbOPsV+Simez5LOXVw+n+rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694529834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOUd3TIIPkRbnBhsu5My2OMsdiQu55nXnkVNBSNyjbg=;
 b=NUBD6uCb8Envoh+sbVp0QJrDbb6KDp9rlCAdUWRJs6ZraWvJA7xGd0ciOS3W1tItH4txvb
 kNWNOyK9dlGfaeAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ABB1713A3B;
 Tue, 12 Sep 2023 14:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eNXyKCp5AGUXYAAAMHmgww
 (envelope-from <mkittler@suse.de>); Tue, 12 Sep 2023 14:43:54 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Sep 2023 16:43:51 +0200
Message-ID: <20230912144351.13494-3-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912144351.13494-1-mkittler@suse.de>
References: <20230912144351.13494-1-mkittler@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 2/2] Prevent segmentation fault when negative task
 count specified
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

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/realtime/func/rt-migrate/rt-migrate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/realtime/func/rt-migrate/rt-migrate.c b/testcases/realtime/func/rt-migrate/rt-migrate.c
index 2554f63e2..252e77e6a 100644
--- a/testcases/realtime/func/rt-migrate/rt-migrate.c
+++ b/testcases/realtime/func/rt-migrate/rt-migrate.c
@@ -419,6 +419,10 @@ int main(int argc, char **argv)
 		numcpus = sysconf(_SC_NPROCESSORS_ONLN);
 		nr_tasks = numcpus + 1;
 	}
+	if (nr_tasks < 0) {
+		printf("The number of tasks must not be negative.\n");
+		exit(EXIT_FAILURE);
+	}
 
 	intervals = malloc(sizeof(stats_container_t) * nr_tasks);
 	if (!intervals)
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
