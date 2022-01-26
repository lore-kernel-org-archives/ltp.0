Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4DAC28CF5
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 14:51:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 021673C9664
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 15:51:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48FEF3C9536
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 15:51:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BE4A11A00148
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 15:51:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0544D1F3B7;
 Wed, 26 Jan 2022 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643208706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aIsUB1Aef15S4WdMjXwMfdmOs83nUCzt6AOj0l9YIKw=;
 b=W9l3NelKylVT5i5wHUQ44GDvZ/FNai1qc7DGcrPricr1EToeGYE1gw1eqs5FiwTXD8ekR7
 ia6eWki+CmN8VVvtk6koRAyKizrKTVLJHSjZFEYOWL8r9axS1UaKZiW2tb54SqNvX2u6mK
 laK6O661ot1U4UK4sF454puVyi2qBWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643208706;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aIsUB1Aef15S4WdMjXwMfdmOs83nUCzt6AOj0l9YIKw=;
 b=iSlE7X6QdHjSB3laPEoXZH5QElkg+h4pVmOPlg/CNMxZvccHcPrMIxjbeH7y/gTqL91S0h
 Oyj3RDpPbEe79zDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE32A13A67;
 Wed, 26 Jan 2022 14:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eVJ/MAFg8WHLCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 14:51:45 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 15:51:39 +0100
Message-Id: <20220126145141.13825-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] shell API: print environment variables in .h
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

Petr Vorel (2):
  tst_test.sh: Print environment variables in help
  doc: Mention places for environment variables

 doc/library-api-writing-guidelines.txt |  4 ++++
 testcases/lib/tst_test.sh              | 22 ++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
