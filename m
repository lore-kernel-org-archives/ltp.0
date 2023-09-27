Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21963E82CD2
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 20:21:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C03AD3CE1A1
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 22:21:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C1E03CBA91
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AD74860133C
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0FAC21898;
 Wed, 27 Sep 2023 20:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695846084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DeOBS7kDxV79zW4KYKFn1P0yP+B2UurAAeak5kxNHgk=;
 b=v9UyRJftYqA9tIuYQ4QO5FmMksWgv99bx96AIFoHydDlAIYcJeVC1ZvtUvEGl45yEZZz/1
 aLxGakkIMYydeQlc0p8bnODPYwdqarItfgv+fUV0ZvfFTqVrlc+bii29MKN7faHA3YAmYU
 6c8o2HeYMWjFZD9sRK+a+g3aPVgAOmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695846084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DeOBS7kDxV79zW4KYKFn1P0yP+B2UurAAeak5kxNHgk=;
 b=td620Kb08C5TjIA11HRCaLVm2Cigg4hbpDF1H0oe2FMAxSti/0SnZrtb5OV3IFIfUQxbei
 cbqsLB7HE/yM2NDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 543F313479;
 Wed, 27 Sep 2023 20:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a6PiEsSOFGWGewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 20:21:24 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Sep 2023 22:21:15 +0200
Message-Id: <20230927202121.300325-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/6] Release scripts and docs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TL;DR
* "LTP Release Procedure" wiki page is (temporarily) visible on:
https://github.com/pevik/ltp/wiki/TEST

NOTE due a public holiday in the Czech Republic tomorrow, I don't expect
Cyril will have time to have look into this before release (which should
be on Friday).

Changes v1->v2:
"LTP Release Procedure" wiki page
* Create "1. Release preparations" paragraph, use Cyril's text for it.
* Add section "2. Prepare the release notes" (important part as which takes
  some time, thus deserve it's own section, 5th section with sending
  announcement is of course kept).
* Kept command examples (Li), update them (e.g. not pushing all tags,
  but only one created - this can avoid pushing tags from forks - e.g.
  from AOSP).
* Mention tools/tag-release.sh tools/create-tarballs-metadata.sh scripts.
* s/20230516/YYYYMMDD/ in wiki doc (previous tag kept as 20230127, Cyril).

tools/tag-release.sh
* Remove skeleton generation (Cyril).

Other
* resend "Remove Makefile.release" in this series.
(it's separated, but let's remove it once we agree on this).

Kind regards,
Petr

Petr Vorel (6):
  tools: Add a script for tagging the release
  tools: Add script for creating tarballs and metadata
  doc: Rename files to names from ltp.wiki.git
  doc: Add Release procedure
  doc: Update release procedure
  Remove Makefile.release

 .github/workflows/wiki-mirror.yml             |  16 +-
 Makefile.release                              |  46 -----
 ...ild-system-guide.txt => Build-System.rest} |   0
 doc/{c-test-api.txt => C-Test-API.asciidoc}   |   0
 ...mple.txt => C-Test-Case-Tutorial.asciidoc} |   0
 ...-c-api.txt => C-Test-Network-API.asciidoc} |   0
 ...kvm-test-api.txt => KVM-Test-API.asciidoc} |   0
 ...P-Library-API-Writing-Guidelines.asciidoc} |   0
 doc/LTP-Release-Procedure.asciidoc            | 183 ++++++++++++++++++
 ...aintainer-Patch-Review-Checklist.asciidoc} |   0
 ...l-test-api.txt => Shell-Test-API.asciidoc} |   0
 ...kernel,-libc,-toolchain-versions.asciidoc} |   0
 ...s.txt => Test-Writing-Guidelines.asciidoc} |   0
 ...ser-guide.txt => User-Guidelines.asciidoc} |   0
 tools/create-tarballs-metadata.sh             |  56 ++++++
 tools/lib.sh                                  |  31 +++
 tools/tag-release.sh                          |  45 +++++
 17 files changed, 318 insertions(+), 59 deletions(-)
 delete mode 100644 Makefile.release
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
