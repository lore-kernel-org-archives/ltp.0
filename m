Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AACCE79AB
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 09:54:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBA2B3CDEC9
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 11:54:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2ED73CE3D4
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:53:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1FC801401136
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 11:53:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DDA1D1FE94;
 Wed, 20 Sep 2023 09:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695203601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xAfN0p3znBk7YCkHFPHv5DZz3o1om8lz0RWtUrg1ohk=;
 b=234+boBaoONVvdyZMApUIoXGXMqQ2GxPv3osSG5Ld18iLUXHoi34YhjcMglWAXZhcuKVjH
 q4Sp/V277NyDx8LSaNmPIo4EhR3yTwVYbVD0uMv2uU+v9yZnoXZCTbQafxYPFycRNz1qBK
 oHJfm8+LK5ht3FBjOaw2gvDtfU0hT64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695203601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xAfN0p3znBk7YCkHFPHv5DZz3o1om8lz0RWtUrg1ohk=;
 b=p0hqraq69Uu+l5TniwfrjfcsT7N6bIrAtc2RLeb6ShiHxnsTmDd00CWI8T8G0pD96HBvHr
 T3rZbElW8AGKlBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94D631333E;
 Wed, 20 Sep 2023 09:53:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ll4cIhHBCmVpBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Sep 2023 09:53:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Sep 2023 11:53:13 +0200
Message-Id: <20230920095318.340582-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/5] Release scripts and docs
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

Hi,

copy pasting release is error prone, thus I wrote release scripts.
Any change you would have look on it before release?

2 commits were already posted before, Li had some notes about the
procedure, thus I updated it.

Kind regards,
Petr

Petr Vorel (5):
  tools: Add a script for tagging the release
  tools: Add script for creating tarballs and metadata
  doc: Rename files to names from ltp.wiki.git
  doc: Add Release procedure
  doc: Update release procedure

 .github/workflows/wiki-mirror.yml             |  16 +--
 ...ild-system-guide.txt => Build-System.rest} |   0
 doc/{c-test-api.txt => C-Test-API.asciidoc}   |   0
 ...mple.txt => C-Test-Case-Tutorial.asciidoc} |   0
 ...-c-api.txt => C-Test-Network-API.asciidoc} |   0
 ...kvm-test-api.txt => KVM-Test-API.asciidoc} |   0
 ...P-Library-API-Writing-Guidelines.asciidoc} |   0
 doc/LTP-Release-Procedure.asciidoc            | 116 ++++++++++++++++++
 ...aintainer-Patch-Review-Checklist.asciidoc} |   0
 ...l-test-api.txt => Shell-Test-API.asciidoc} |   0
 ...kernel,-libc,-toolchain-versions.asciidoc} |   0
 ...s.txt => Test-Writing-Guidelines.asciidoc} |   0
 ...ser-guide.txt => User-Guidelines.asciidoc} |   0
 tools/create-tarballs-metadata.sh             |  52 ++++++++
 tools/lib.sh                                  |  31 +++++
 tools/tag-release.sh                          |  80 ++++++++++++
 16 files changed, 282 insertions(+), 13 deletions(-)
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
 create mode 100755 tools/create-tarballs-metadata.sh
 create mode 100755 tools/lib.sh
 create mode 100755 tools/tag-release.sh

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
