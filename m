Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254A6C433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 09:44:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D5DE3CA27A
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 10:44:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 324AD3C229A
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 10:44:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 63599600945
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 10:44:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E2811F3AA
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646041480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3wZRbRZNdhpa/70x900h0CJxwiz5qqZNDdXNdoWwweI=;
 b=GQV7fW8tG4oI0FxsJQePDsfwgtE9AQiboQsXMq62HPUzqWfH5OHe0uZcaDHxLzWYot2jKo
 +9bzHdS1Qg5e0Bswe5JSBElkK4ja14/Dic+hu9K+MrokMj0htj3pW7sXZcfT8sma17gqA3
 rRmUj9SjiG+HIPcuWk49VJRdVqFfErk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646041480;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3wZRbRZNdhpa/70x900h0CJxwiz5qqZNDdXNdoWwweI=;
 b=tmpLMbqafcAUslSQoul8Ot9A+FzAG+CSYrkcx4WkAdH+k8LQYSiHHkOysssBUq8kPuHUMb
 Uj3G7oZmfLnklzDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6796913AA8
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vjyXGIiZHGIQXQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:40 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 28 Feb 2022 10:46:57 +0100
Message-Id: <20220228094659.21959-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] ksm06 fixes
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

Two minor fixes for the ksm06 test.

Also it looks like the test_ksm_merge_across_nodes() is only called from
the ksm06 test so it does not make that much sense for the code to be in
the mem.c library. I guess that we should move it to the test source so
that it's not hidden in the library as well.

Cyril Hrubis (2):
  ksm06: Free memory at the end of the test
  ksm06: lock memory about to be merged

 testcases/kernel/mem/lib/mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
