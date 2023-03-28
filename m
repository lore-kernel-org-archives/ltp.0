Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97064C76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 11:14:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDE0D3CCB11
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 13:14:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 626283CA2FA
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:13:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E85ED1000A3E
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 13:13:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 151B01F854;
 Tue, 28 Mar 2023 11:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680002035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xfIE7gpJhKVlnE2KMQMuO6GIUGvb4erV1H3HQk1FVpc=;
 b=UpUtU4EqVlWi64YeGz7XdeDVxeVwqyiBvyd8uc9PD+u3nLD41gf/9PxlPyL5Acs9e9C51d
 7oqqEa6AYhqjNKfo5VPsVdPBCi0hXsjGDKM71eqr5PLLcG6c/e7WZLGnQfml/LvAFFiW7F
 +9zFZszVaNdeM2NWJfjx2H1wywPo9uA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680002035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xfIE7gpJhKVlnE2KMQMuO6GIUGvb4erV1H3HQk1FVpc=;
 b=ilyFl7r5pqM+vQo5iDyl0ce4ccgLNDs8lWAyTskqcdWaRG61bfit2klVPo0NFA0jxMFWA1
 vR2gK1FkpetUHKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6C021390B;
 Tue, 28 Mar 2023 11:13:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id opDVKvLLImR9CAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 11:13:54 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 28 Mar 2023 13:13:36 +0200
Message-Id: <20230328111338.766712-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 0/2] Wiki: files rename,add 'Release procedure'
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel (2):
  doc: Rename files to names from ltp.wiki.git
  doc: Add Release procedure

 .github/workflows/wiki-mirror.yml             | 16 +----
 ...ild-system-guide.txt => Build-System.rest} |  0
 doc/{c-test-api.txt => C-Test-API.asciidoc}   |  0
 ...mple.txt => C-Test-Case-Tutorial.asciidoc} |  0
 ...-c-api.txt => C-Test-Network-API.asciidoc} |  0
 ...kvm-test-api.txt => KVM-Test-API.asciidoc} |  0
 ...P-Library-API-Writing-Guidelines.asciidoc} |  0
 doc/LTP-Release-Procedure.asciidoc            | 67 +++++++++++++++++++
 ...aintainer-Patch-Review-Checklist.asciidoc} |  0
 ...l-test-api.txt => Shell-Test-API.asciidoc} |  0
 ...kernel,-libc,-toolchain-versions.asciidoc} |  0
 ...s.txt => Test-Writing-Guidelines.asciidoc} |  0
 ...ser-guide.txt => User-Guidelines.asciidoc} |  0
 13 files changed, 70 insertions(+), 13 deletions(-)
 rename doc/{build-system-guide.txt => Build-System.rest} (100%)
 rename doc/{c-test-api.txt => C-Test-API.asciidoc} (100%)
 rename doc/{c-test-tutorial-simple.txt => C-Test-Case-Tutorial.asciidoc} (100%)
 rename doc/{network-c-api.txt => C-Test-Network-API.asciidoc} (100%)
 rename doc/{kvm-test-api.txt => KVM-Test-API.asciidoc} (100%)
 rename doc/{library-api-writing-guidelines.txt => LTP-Library-API-Writing-Guidelines.asciidoc} (100%)
 create mode 100644 doc/LTP-Release-Procedure.asciidoc
 rename doc/{maintainer-patch-review-checklist.txt => Maintainer-Patch-Review-Checklist.asciidoc} (100%)
 rename doc/{shell-test-api.txt => Shell-Test-API.asciidoc} (100%)
 rename doc/{supported-kernel-libc-versions.txt => Supported-kernel,-libc,-toolchain-versions.asciidoc} (100%)
 rename doc/{test-writing-guidelines.txt => Test-Writing-Guidelines.asciidoc} (100%)
 rename doc/{user-guide.txt => User-Guidelines.asciidoc} (100%)

-- 
2.40.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
