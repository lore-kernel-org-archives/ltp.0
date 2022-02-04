Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46DEC433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 19:47:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D77023C9AEC
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 20:47:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35D453C9ABE
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 20:47:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0BD75100053D
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 20:47:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB428210EE;
 Fri,  4 Feb 2022 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644004025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E4tQClR/3ZQ+t03C0EJEY60l+tLtUmNffFkOyVb1fCw=;
 b=FPB+/LeVcOq34XABhaa3dZCQpLK8brX24XIcwb7jB3QXk/m7BOhq80tv7pMpPkbOEGCdYP
 g/r9ZgjUNx9u6tK+f9TtnAl8QWUMiteAZTsog2ToRf5v6DORzZv+hTsnj2bF3q8vUi1785
 hHOv1rbtQ0XspGCOn7nYp12+ZJoS/tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644004025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E4tQClR/3ZQ+t03C0EJEY60l+tLtUmNffFkOyVb1fCw=;
 b=aMiYZdcFaJO2PK2RyZLUsQHW1j9/xSjxX7o3e6klChAEl0oUg3zK1kP/NZo5p4mGpwKIz7
 lkoa0LIS8GpbujAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 695A013A91;
 Fri,  4 Feb 2022 19:47:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9YvpFrmC/WHtEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 04 Feb 2022 19:47:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  4 Feb 2022 20:46:45 +0100
Message-Id: <20220204194648.32165-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] shell: Fixes for disabled IPv6
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

Hi all,

changes v2->v3:
* Partly rewritten containers netns to use tst_net.sh. Further cleanup
  will be done, but changes are already big and for sake of
  working IPv6 is this enough.
  TODO: Test should be further cleanup to use tst_rhost_run over different
  LTP_NETNS and tst_ping instead of $tping.

* Use only $TST_NET_IPV6_ENABLED for both lhost and rhost. ATM when
  use TST_NET_SKIP_VARIABLE_INIT=1 it detects only lhost. This is useful
  for containers netns tests (and will be needed even after 

NOTE: no other shell tests which use only tst_test.sh need this
(if any needs in the future, can be migrated the same way as
netns_helper.sh currently).

C tests are ok, because they can check EAFNOSUPPORT (as done for SCTP
tests: https://patchwork.ozlabs.org/project/ltp/list/?series=284336)

NOTE: this is really v3, because I forget to add v2 in previous version
https://patchwork.ozlabs.org/project/ltp/list/?series=282638

Kind regards,
Petr

Petr Vorel (3):
  tst_net.sh: Fix for disabled IPv6
  broken_ip-nexthdr.sh: Check IPv6 support before forcing it
  netns: Rewrite to use tst_net.sh

 runtest/containers                            |  32 +--
 .../kernel/containers/netns/netns_breakns.sh  |  29 +--
 .../kernel/containers/netns/netns_comm.sh     |  53 +----
 .../kernel/containers/netns/netns_helper.sh   | 225 +++++++-----------
 testcases/lib/tst_net.sh                      |  71 +++++-
 .../stress/broken_ip/broken_ip-nexthdr.sh     |   1 +
 6 files changed, 169 insertions(+), 242 deletions(-)

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
