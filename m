Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4447EC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:56:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0E2B3C9385
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 11:56:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 260983C2F48
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:05 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 02B211401230
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0990E1F38D;
 Fri,  7 Feb 2025 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738925763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zkNZpObedLVQWhRsmh5GwuzF7JoGQxlKSW2fLATpeGU=;
 b=pGytjk8pQL9rkQZrreSaGrLQtZ1EfjqdTYjQXeuWV6JPgbAtOdYPWfgOgK94ueEplRebhD
 kWA5HtBo6DqzvEXZPhX5Nsp1tbMzJBDjafZrVQ8zeFHwB6mMiUTMf2y+tS1wzZx0V6T6yO
 3lBAXYZknsRQM5IMumiDiznnPPDRQF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738925763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zkNZpObedLVQWhRsmh5GwuzF7JoGQxlKSW2fLATpeGU=;
 b=ZCKH+jPfYZ19LlgbQUHUyetemJm6qpYbJn7AySFB064mnv49biOln6RW4O4sWorMBJzc/U
 K9A5GedK8enXzvBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738925763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zkNZpObedLVQWhRsmh5GwuzF7JoGQxlKSW2fLATpeGU=;
 b=pGytjk8pQL9rkQZrreSaGrLQtZ1EfjqdTYjQXeuWV6JPgbAtOdYPWfgOgK94ueEplRebhD
 kWA5HtBo6DqzvEXZPhX5Nsp1tbMzJBDjafZrVQ8zeFHwB6mMiUTMf2y+tS1wzZx0V6T6yO
 3lBAXYZknsRQM5IMumiDiznnPPDRQF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738925763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zkNZpObedLVQWhRsmh5GwuzF7JoGQxlKSW2fLATpeGU=;
 b=ZCKH+jPfYZ19LlgbQUHUyetemJm6qpYbJn7AySFB064mnv49biOln6RW4O4sWorMBJzc/U
 K9A5GedK8enXzvBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D929013694;
 Fri,  7 Feb 2025 10:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OYTiM8LmpWddeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 10:56:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Feb 2025 11:55:45 +0100
Message-ID: <20250207105551.1736356-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] Remove asciidoc{,tor} doc
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

Hi,

This is a follow up for Andrea's 1bf344a3db ("doc: add tests catalog page").

Besides these changes I plan:

1) Configure readthedocs to generate html/pdf doc for user to be able to
download it.

2) Generate html/pdf documentation as a part of the release process
(build it locally with sphinx), to be able to add it to the release
as we did with the doc generated by asciidoc{,tor}.

3) Andrea refused to do have virtualenv support in Makefile.
https://lore.kernel.org/ltp/3032b376-8f7a-4b1c-8422-f5a61e59b680@suse.com/
I would still prefer to have it, as optional, when some variable is
passed to make. It's better than copy paste the commands all the time,
also it would help 2).

WDYT?

Tested:
https://github.com/pevik/ltp/actions/runs/13198229443
https://github.com/pevik/ltp/actions/runs/13198229440

Kind regards,
Petr

Petr Vorel (6):
  create-tarballs-metadata.sh: Remove metadata generation
  github: Stop building asciidoc{,tor} documentation
  ci: Don't install asciidoc{,tor}
  doc: Replace docparse info with sphinx
  Move docparse/README.md to metadata/
  docparse: Remove

 .github/workflows/ci-docker-build.yml     |  14 +-
 ci/alpine.sh                              |   2 -
 ci/debian.sh                              |   8 -
 ci/fedora.sh                              |   2 -
 ci/tumbleweed.sh                          |   3 -
 configure.ac                              |  32 --
 doc/developers/writing_tests.rst          |  13 +-
 doc/maintainers/ltp_release_procedure.rst |   6 -
 doc/maintainers/patch_review.rst          |   4 +-
 docparse/.gitignore                       |   5 -
 docparse/Makefile                         |  69 ---
 docparse/testinfo.pl                      | 526 ----------------------
 lib/tst_test.c                            |   4 +-
 m4/ax_prog_perl_modules.m4                |  77 ----
 m4/ltp-docparse.m4                        | 118 -----
 metadata/Makefile                         |   9 -
 {docparse => metadata}/README.md          |   0
 tools/create-tarballs-metadata.sh         |   9 +-
 18 files changed, 13 insertions(+), 888 deletions(-)
 delete mode 100644 docparse/.gitignore
 delete mode 100644 docparse/Makefile
 delete mode 100755 docparse/testinfo.pl
 delete mode 100644 m4/ax_prog_perl_modules.m4
 delete mode 100644 m4/ltp-docparse.m4
 rename {docparse => metadata}/README.md (100%)

-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
