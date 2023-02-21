Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216B5C636D6
	for <ltp@archiver.kernel.org>; Tue, 21 Feb 2023 01:35:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDBD83CBF00
	for <ltp@archiver.kernel.org>; Tue, 21 Feb 2023 02:35:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFC5F3CAFE7
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 02:35:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4990D1A0071B
 for <ltp@lists.linux.it>; Tue, 21 Feb 2023 02:35:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EA9025BD17;
 Tue, 21 Feb 2023 01:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676943321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/fz+mDFfjPeh9PcA9e7Qe0qGJGmwzfIjpat7pXB/Gk=;
 b=WKjPZuJRjqzO7+snFsW0MH6kNt/BsFJK3h8PyRPaz+sioIMIRYbJX7bzQsueXjSLAQiysT
 v6hHOd+C7XkbrxQAtlqTDNo44xitDwxQhl6zENRi5nZ91ghiy41+w8HYA9mFWjaua7CJXn
 9mWiUELzXX2R+jrpN1aNELQTbvzlaX8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17D5F13A2F;
 Tue, 21 Feb 2023 01:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h0QAONgf9GPNWgAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 21 Feb 2023 01:35:20 +0000
To: ltp@lists.linux.it
Date: Mon, 20 Feb 2023 20:34:44 -0500
Message-Id: <20230221013446.19399-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230215023438.11370-1-wegao@suse.com>
References: <20230215023438.11370-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Move linux rseq test into ltp
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

*** BLURB HERE ***

Wei Gao (2):
  rseq: Copy linux rseq test header files to ltp
  rseq01: basic test rseq

 include/lapi/compiler.h                    |   30 +
 include/lapi/rseq-abi.h                    |  151 +++
 include/lapi/rseq-arm.h                    |  827 ++++++++++++
 include/lapi/rseq-arm64.h                  |  695 ++++++++++
 include/lapi/rseq-generic-thread-pointer.h |   25 +
 include/lapi/rseq-mips.h                   |  777 +++++++++++
 include/lapi/rseq-ppc-thread-pointer.h     |   30 +
 include/lapi/rseq-ppc.h                    |  791 ++++++++++++
 include/lapi/rseq-riscv.h                  |  677 ++++++++++
 include/lapi/rseq-s390.h                   |  610 +++++++++
 include/lapi/rseq-skip.h                   |   65 +
 include/lapi/rseq-thread-pointer.h         |   19 +
 include/lapi/rseq-x86-thread-pointer.h     |   40 +
 include/lapi/rseq-x86.h                    | 1365 ++++++++++++++++++++
 include/lapi/rseq.h                        |  313 +++++
 runtest/syscalls                           |    2 +
 testcases/kernel/syscalls/rseq/.gitignore  |    1 +
 testcases/kernel/syscalls/rseq/Makefile    |   10 +
 testcases/kernel/syscalls/rseq/rseq01.c    |   55 +
 19 files changed, 6483 insertions(+)
 create mode 100644 include/lapi/compiler.h
 create mode 100644 include/lapi/rseq-abi.h
 create mode 100644 include/lapi/rseq-arm.h
 create mode 100644 include/lapi/rseq-arm64.h
 create mode 100644 include/lapi/rseq-generic-thread-pointer.h
 create mode 100644 include/lapi/rseq-mips.h
 create mode 100644 include/lapi/rseq-ppc-thread-pointer.h
 create mode 100644 include/lapi/rseq-ppc.h
 create mode 100644 include/lapi/rseq-riscv.h
 create mode 100644 include/lapi/rseq-s390.h
 create mode 100644 include/lapi/rseq-skip.h
 create mode 100644 include/lapi/rseq-thread-pointer.h
 create mode 100644 include/lapi/rseq-x86-thread-pointer.h
 create mode 100644 include/lapi/rseq-x86.h
 create mode 100644 include/lapi/rseq.h
 create mode 100644 testcases/kernel/syscalls/rseq/.gitignore
 create mode 100644 testcases/kernel/syscalls/rseq/Makefile
 create mode 100644 testcases/kernel/syscalls/rseq/rseq01.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
