Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CBDC433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 09:45:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF7973C6FE4
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 10:45:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F5373C229A
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 10:44:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C0624100095E
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 10:44:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2436C218E9
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646041481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWCBE6TqnU6dmsk7uuQNabz/xz65YugNi6hWtXJ3caA=;
 b=sciChkT8khyzoJep1QC26bOqvq7fYZmLy5cENU30apKSn2dbQjJK6q2eWeTBneryeboO4T
 5IbPM5H42XaUGq+tTvvAsMb+vOnNYydefhU2jMl6xaYxf5au2HHMlengvFTnIZbuEqn5pZ
 Uynh77K0yJZ6HhWqn8kFVQxasdG4L5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646041481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gWCBE6TqnU6dmsk7uuQNabz/xz65YugNi6hWtXJ3caA=;
 b=goyBdhrv8XY8O+NISFzF08C8qE+ZsMa+Ls2/e3TBjVVMhLXMbqn1BWUTelYtqOuFeT+tr/
 BUlHN2jl8Y5W7xCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D59F13AA8
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CIV1AomZHGIYXQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:41 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 28 Feb 2022 10:46:58 +0100
Message-Id: <20220228094659.21959-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228094659.21959-1-chrubis@suse.cz>
References: <20220228094659.21959-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ksm06: Free memory at the end of the test
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

Fixes the kms06 run with -i 2.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/lib/mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 99d5f7f53..39e3f1791 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -594,6 +594,11 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 		    0, 0, 0, nr_pages * num_nodes);
 
 	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+
+	for (i = 0; i < num_nodes; i++)
+		SAFE_MUNMAP(memory[i], length);
+
+	free(memory);
 }
 
 /* THP */
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
