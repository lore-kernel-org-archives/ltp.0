Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5513C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:48:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5652B60F93
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5652B60F93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5C293C4B8F
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 17:48:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1249B3C304F
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 17:47:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2FF5D1000DE1
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 17:47:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFA3F1FD6D
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634572039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bz4ihaNZC1YAKllRK7RVCTreknTWOTvkDqafghHcRv8=;
 b=d1YGrh3oV1eMjIzHnVCIasW2c9oSb4z4C+eWWYgPMn74tpML2WFOB0OCQcmq/mPgItquZm
 v+2XZWVcnM3xfQWgUE7tzP4p/jXf77v7vOi0MxkAzEUqMcLAQa5k6gP9Iu3JGVAIAziCAH
 c3t/yFaLI4iQQ1RWCvgD52tIN+iLY4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634572039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bz4ihaNZC1YAKllRK7RVCTreknTWOTvkDqafghHcRv8=;
 b=9AtASFZoflwERVbps/+/ZE0K32eC3aFpDtK0vfKT65+BwippMNcLvNBaAx4jw2G/NXYxwz
 yZ4Nlutw7u5Z3+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3002140B7
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id e9Y2KgeXbWGGJwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:19 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Oct 2021 17:48:00 +0200
Message-Id: <20211018154800.11013-9-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211018154800.11013-1-chrubis@suse.cz>
References: <20211018154800.11013-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/7] docparse improvements
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

Implements support for various missing bits to the docparse tool and
enables it unconditionally so that the metadata.json file is present
on all builds.

This is first part of bigger effort to get the metadata useful for the
testrunners, expecially we need the .test_variants field to be properly
parsed in order to compute the overall test runtime.

Cyril Hrubis (7):
  docparse: Implement #define and #include
  docparse: Add tests
  docparse: data_storage: Add integer type node
  docparse: Implement ARRAY_SIZE()
  docparse: Add type normalization
  docparse: Group data to 'testsuite' and 'defaults'
  docparse/Makefile: Do not abort on missing generators

 Makefile                             |   5 +-
 docparse/Makefile                    |   4 -
 docparse/data_storage.h              |  45 +++
 docparse/docparse.c                  | 469 ++++++++++++++++++++++++++-
 docparse/parse.sh                    |  18 +-
 docparse/testinfo.pl                 |  16 +-
 docparse/tests/array_size01.c        |   5 +
 docparse/tests/array_size01.c.out    |   4 +
 docparse/tests/array_size02.c        |   5 +
 docparse/tests/array_size02.c.out    |   4 +
 docparse/tests/array_size03.c        |  10 +
 docparse/tests/array_size03.c.out    |   4 +
 docparse/tests/array_size04.c        |   5 +
 docparse/tests/array_size04.c.out    |   4 +
 docparse/tests/empty_struct.c        |   2 +
 docparse/tests/empty_struct.c.out    |   3 +
 docparse/tests/expand_flags.c        |   3 +
 docparse/tests/expand_flags.c.out    |   6 +
 docparse/tests/include.c             |   5 +
 docparse/tests/include.c.out         |   4 +
 docparse/tests/include.h             |   7 +
 docparse/tests/macro.c               |   5 +
 docparse/tests/macro.c.out           |   4 +
 docparse/tests/multiline_macro.c     |   6 +
 docparse/tests/multiline_macro.c.out |   4 +
 docparse/tests/tags.c                |   7 +
 docparse/tests/tags.c.out            |  13 +
 docparse/tests/test.sh               |  18 +
 m4/ltp-docparse.m4                   |   3 -
 29 files changed, 647 insertions(+), 41 deletions(-)
 create mode 100644 docparse/tests/array_size01.c
 create mode 100644 docparse/tests/array_size01.c.out
 create mode 100644 docparse/tests/array_size02.c
 create mode 100644 docparse/tests/array_size02.c.out
 create mode 100644 docparse/tests/array_size03.c
 create mode 100644 docparse/tests/array_size03.c.out
 create mode 100644 docparse/tests/array_size04.c
 create mode 100644 docparse/tests/array_size04.c.out
 create mode 100644 docparse/tests/empty_struct.c
 create mode 100644 docparse/tests/empty_struct.c.out
 create mode 100644 docparse/tests/expand_flags.c
 create mode 100644 docparse/tests/expand_flags.c.out
 create mode 100644 docparse/tests/include.c
 create mode 100644 docparse/tests/include.c.out
 create mode 100644 docparse/tests/include.h
 create mode 100644 docparse/tests/macro.c
 create mode 100644 docparse/tests/macro.c.out
 create mode 100644 docparse/tests/multiline_macro.c
 create mode 100644 docparse/tests/multiline_macro.c.out
 create mode 100644 docparse/tests/tags.c
 create mode 100644 docparse/tests/tags.c.out
 create mode 100755 docparse/tests/test.sh

-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
