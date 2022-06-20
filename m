Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4220FC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 09:20:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51BE93C920D
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 11:20:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 789643C91E2
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F7FF1000600
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9BBA21FAC6
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655716782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFFef8poaTg/CfIg4EwbqVXRiVPgE2vn0SY3RdBqSlI=;
 b=X8fUcfUV85cqBcGP2pCY9lGKJBHWd0asLeHZkVCQ1jLvi4qZxS15CPjyJIJRMRwFf7o+Mg
 6J7bKzlCJzp8f1WzUlUCz0psSFYFngEo5BwqZY6MJEsjpalGt7gSdofL9vvk6sSsY8Rw5W
 KOKPv09bV5wU7tT+YuaVWdyAXMxz9GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655716782;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFFef8poaTg/CfIg4EwbqVXRiVPgE2vn0SY3RdBqSlI=;
 b=E9Vh9lf9WcEejLSWTRvMLY0bcfJuUpeL8Nk5vYlzTLHY0//thA9V6PZexbeDNv0s2Yv06v
 JGa14m+gchHtuKAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87F42134CA
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lfRlH647sGJoQAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:42 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jun 2022 11:21:44 +0200
Message-Id: <20220620092146.7604-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620092146.7604-1-chrubis@suse.cz>
References: <20220620092146.7604-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/7] openposix: aio_h/2-1: Add return at the end of
 main()
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

This is compile-only test so the return value is not actually used but
that's not a reason not to fix warnings.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../open_posix_testsuite/conformance/definitions/aio_h/2-1.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/definitions/aio_h/2-1.c b/testcases/open_posix_testsuite/conformance/definitions/aio_h/2-1.c
index 39fb41d22..133b3a516 100644
--- a/testcases/open_posix_testsuite/conformance/definitions/aio_h/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/definitions/aio_h/2-1.c
@@ -25,4 +25,6 @@ int main(void)
 	aiocb.aio_nbytes = 0;
 	aiocb.aio_sigevent = sigevent;
 	aiocb.aio_reqprio = -1;
+
+	return 0;
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
