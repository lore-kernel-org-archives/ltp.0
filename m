Return-Path: <SRS0=R2VO=OM=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450A8C433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:53:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FECC60F41
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 11:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FECC60F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8903F3CA20D
	for <ltp@archiver.kernel.org>; Wed, 22 Sep 2021 13:53:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C5DF3C05AE
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 13:53:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D562660020A
 for <ltp@lists.linux.it>; Wed, 22 Sep 2021 13:53:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F17CA1FE19;
 Wed, 22 Sep 2021 11:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632311594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TGtrqKiRUpXJHrlx24ZmORPtDKfX+2fas7t8ipwXb3w=;
 b=ZoZ8CbsAT1/kC4Alj1Vn6dOeHFKQarSP0ZvzCabdmyM4YCso2AvLzTTw7sJzxY08nZQghE
 5Zq4l+Iy1PCVY1SbpmaupXif130ENCso2ERMEWbmZhm5SlmTx0ML6serlIJVu6oYcW2BTU
 i676heN27ZxUhhCpzgOxI5Z7pF9X8m4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632311594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TGtrqKiRUpXJHrlx24ZmORPtDKfX+2fas7t8ipwXb3w=;
 b=EA2k0AZLV4Ml7NdNeruVorN748CxBDO+3IDK/pskilk62/kINxrFiDk1usZldEQRj3C/VF
 ySX8HRnraS1viYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A68FB13D76;
 Wed, 22 Sep 2021 11:53:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9tp4JioZS2F9CgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Sep 2021 11:53:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Sep 2021 13:53:07 +0200
Message-Id: <20210922115310.5927-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/3] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I've fixed Alex's v5.

changes v5->v6:
* add test_file parameter to ima_check() (using global for function is ugly)
* keep $TEST_FILE in ima_measurements.sh ]
* add verify_measurement() (DRY)

Alex Henrie (3):
  IMA: Move check_policy_writable() to ima_setup.sh and rename it
  IMA: Move ima_check to ima_setup.sh
  IMA: Add tests for uid, gid, fowner, and fgroup options

 runtest/ima                                   |  1 +
 .../integrity/ima/tests/ima_conditionals.sh   | 62 +++++++++++++++++++
 .../integrity/ima/tests/ima_measurements.sh   | 31 +---------
 .../integrity/ima/tests/ima_policy.sh         | 16 +----
 .../security/integrity/ima/tests/ima_setup.sh | 38 ++++++++++++
 5 files changed, 106 insertions(+), 42 deletions(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_conditionals.sh

-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
