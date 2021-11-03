Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355AAC433EF
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:02:59 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D22E360F5A
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D22E360F5A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7399C3C71F1
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:02:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E95D33C72B2
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:01:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC5EF140112F
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:01:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D168421916
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 12:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635940897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8Oon2p5PhbSgrxgtLfDg/FdMeHNnBhqIvpeQauxgmtU=;
 b=SIMtPdukNQX/4Cm17gWUPWeOKxF5+kRc2w8bu2UBZcGTnDBKGh6we8Efu5/bvSlt+pX5kk
 ZqOhps+YDwJNQYa1ODZixvNoRK2ZyWtHts64alX88nHtoZRkaonKwkEwnr8fgvjad6tC6J
 zChwQIVZIIq+9g6lc1PD17gmuzAaxfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635940897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8Oon2p5PhbSgrxgtLfDg/FdMeHNnBhqIvpeQauxgmtU=;
 b=ZTEb/uQsBNyZCOn0DdPqvKO6jrnrSQLjiZV4wo35sdERYIN/KHxXlz/FXCEZ+R5mrs+ZHx
 IopwjFEebvE3weAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B376213CE7
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 12:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FasrKyF6gmFKRwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 03 Nov 2021 12:01:37 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Nov 2021 13:02:26 +0100
Message-Id: <20211103120233.20728-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/7] docparse improvements
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

Implement support for various missing bits to the docparse tool and
enables it unconditionally so that the metadata file is present on
all builds.

This is first part of bigger effort to get the metadata useful for the
testrunners, expecially we need the .test_variants field to be properly
parsed in order to compute the overall test runtime correctly.

v3:
  - A few fixes in the parser as reported by rpalethorpe
  - Fixed out-of-tree build for the last patch that moves
    the parser to a metadata directory

v2:
     - Cleaned up the patchset a bit

    pvorel:
     - Added Makefile to metadata tests
     - Rename the expected output files to foo.c.json

    rpalethorpe:
     - Fixed parsing of the '# include' and '# define' directives
       now the hash character produces a separate token and any
       whitespaces between it and the keyword are removed by the
       parser


Cyril Hrubis (7):
  docparse: Implement #define and #include
  docparse: Add tests
  docparse: data_storage: Add integer type node
  docparse: Implement ARRAY_SIZE()
  docparse: Add type normalization
  docparse: Group data to 'testsuite' and 'defaults'
  docparse: Split into metadata and docparse

 Makefile                              |   5 +-
 docparse/.gitignore                   |   2 -
 docparse/Makefile                     |  12 +-
 docparse/docparse.c                   | 434 -------------
 docparse/testinfo.pl                  |  16 +-
 metadata/.gitignore                   |   2 +
 metadata/Makefile                     |  27 +
 {docparse => metadata}/data_storage.h |  45 ++
 metadata/metaparse.c                  | 900 ++++++++++++++++++++++++++
 {docparse => metadata}/parse.sh       |  18 +-
 metadata/tests/Makefile               |   4 +
 metadata/tests/array_size01.c         |   5 +
 metadata/tests/array_size01.c.json    |   4 +
 metadata/tests/array_size02.c         |   9 +
 metadata/tests/array_size02.c.json    |   4 +
 metadata/tests/array_size03.c         |  10 +
 metadata/tests/array_size03.c.json    |   4 +
 metadata/tests/array_size04.c         |   5 +
 metadata/tests/array_size04.c.json    |   4 +
 metadata/tests/empty_struct.c         |   2 +
 metadata/tests/empty_struct.c.json    |   3 +
 metadata/tests/expand_flags.c         |   3 +
 metadata/tests/expand_flags.c.json    |   6 +
 metadata/tests/include.c              |   5 +
 metadata/tests/include.c.json         |   4 +
 metadata/tests/include.h              |   7 +
 metadata/tests/macro.c                |   5 +
 metadata/tests/macro.c.json           |   4 +
 metadata/tests/macro_str.c            |   5 +
 metadata/tests/macro_str.c.json       |   4 +
 metadata/tests/multiline_macro.c      |   6 +
 metadata/tests/multiline_macro.c.json |   4 +
 metadata/tests/tags.c                 |   7 +
 metadata/tests/tags.c.json            |  13 +
 metadata/tests/test.sh                |  18 +
 35 files changed, 1141 insertions(+), 465 deletions(-)
 delete mode 100644 docparse/docparse.c
 create mode 100644 metadata/.gitignore
 create mode 100644 metadata/Makefile
 rename {docparse => metadata}/data_storage.h (89%)
 create mode 100644 metadata/metaparse.c
 rename {docparse => metadata}/parse.sh (58%)
 create mode 100644 metadata/tests/Makefile
 create mode 100644 metadata/tests/array_size01.c
 create mode 100644 metadata/tests/array_size01.c.json
 create mode 100644 metadata/tests/array_size02.c
 create mode 100644 metadata/tests/array_size02.c.json
 create mode 100644 metadata/tests/array_size03.c
 create mode 100644 metadata/tests/array_size03.c.json
 create mode 100644 metadata/tests/array_size04.c
 create mode 100644 metadata/tests/array_size04.c.json
 create mode 100644 metadata/tests/empty_struct.c
 create mode 100644 metadata/tests/empty_struct.c.json
 create mode 100644 metadata/tests/expand_flags.c
 create mode 100644 metadata/tests/expand_flags.c.json
 create mode 100644 metadata/tests/include.c
 create mode 100644 metadata/tests/include.c.json
 create mode 100644 metadata/tests/include.h
 create mode 100644 metadata/tests/macro.c
 create mode 100644 metadata/tests/macro.c.json
 create mode 100644 metadata/tests/macro_str.c
 create mode 100644 metadata/tests/macro_str.c.json
 create mode 100644 metadata/tests/multiline_macro.c
 create mode 100644 metadata/tests/multiline_macro.c.json
 create mode 100644 metadata/tests/tags.c
 create mode 100644 metadata/tests/tags.c.json
 create mode 100755 metadata/tests/test.sh

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
