Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB547C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 09:59:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38C453E658A
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 11:59:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4A123E4A7C
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:58:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A7F4C60082E
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 11:58:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 99F163E0C;
 Wed, 29 Jul 2026 09:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9e//tp+sA8ZPnisahCQmQik4l5CAn4huMZ1D1rmHdk=;
 b=a0Nv23kF+N68FCe9MSNAV+8bBpW4xQ1dm5kBccv02EEYvqde/dPXU3gOm8aOrPVC33lKjr
 URjemieIdT2ddyNegfeLo4pRsXhhHMzqgx+JkoaltlX842C336qYzTwmmq/PGxGM1DIruf
 1bklZjt2zuOv46ILvw5rkE1avdevI7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9e//tp+sA8ZPnisahCQmQik4l5CAn4huMZ1D1rmHdk=;
 b=8Yx7gizj81Hj1FAzgImqcYSnQ89Dz3MJAs3cw7oYf36aO/M7RXt0AS7f5yjIJHHc3FOZn6
 dmJY/RbmLNdEEzDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785319074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9e//tp+sA8ZPnisahCQmQik4l5CAn4huMZ1D1rmHdk=;
 b=aE+GnaOeZiqg+C26dfauXGe1VkN7cbtM0P3IHNi0sTxHcBYL8H9ONNe0dmuQzHmL2pHFSx
 vV7BS21HXwn/eZuWwdMEEUdgPXTvRBCsCmKO6siubRCLIIhwXZNOOsHCvDV0h4DeqFl4si
 ACByYrVY7MI4xly0K93caN+SEdxUDq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785319074;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9e//tp+sA8ZPnisahCQmQik4l5CAn4huMZ1D1rmHdk=;
 b=RfdBwiaWtKgN6fayjyNAe/Suqqd5jcHj2+vBMeb6yYHGWi/9UbJ+zb0doZb0lQzBdbS1W9
 WDd0VrwstLW1mABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37E3C779BC;
 Wed, 29 Jul 2026 09:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sB45DKLOaWrTJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Jul 2026 09:57:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 29 Jul 2026 11:57:30 +0200
Message-ID: <20260729095730.29185-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729095730.29185-1-pvorel@suse.cz>
References: <20260729095730.29185-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,suse.com,gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] fanotify20: Skip on v7.2
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fanotify_init() used to reject FAN_REPORT_PIDFD combined with
FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
reporting pidfds for thread IDs, so this combination is expected to
succeed.

The test that these flag combinations are allowed:
                FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID |
			   FAN_REPORT_DFID_NAME),

Because the above flag combinations are already "tested" by the tests
that use them and we don't have any tests that >= 5.10 has support for
FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.

Reported-by: AnonymeMeow <anonymemeow@gmail.com>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Fixed version 7.2 => 7.1

More changes needed => v2. I'm sorry for the noise.

 testcases/kernel/syscalls/fanotify/fanotify20.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index b32ecf6aa3..db4a5ba63b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -15,6 +15,9 @@
  *
  * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
  * af579beb666a ("fanotify: add pidfd support to the fanotify API").
+ *
+ * NOTE: since v7.2, fanotify supports reporting pidfds for thread IDs => skip
+ * the test.
  */
 
 #define _GNU_SOURCE
@@ -75,6 +78,7 @@ static void do_cleanup(void)
 
 static struct tst_test test = {
 	.setup = do_setup,
+	.max_kver = "7.1",
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
 	.cleanup = do_cleanup,
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
