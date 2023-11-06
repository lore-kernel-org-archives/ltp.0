Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41332C4167D
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 10:55:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EF183CE861
	for <ltp@archiver.kernel.org>; Mon,  6 Nov 2023 11:55:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA56B3CC737
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 11:54:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54F571400F31
 for <ltp@lists.linux.it>; Mon,  6 Nov 2023 11:54:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81C5C2185E;
 Mon,  6 Nov 2023 10:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699268096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IJ/0sbFkE5Ys0oopJld4h4I6eE1ARKvtwAEsxFAAiU=;
 b=ubfT4q58Lfbs6eJAmZU+S0kdQ4eHYVbNy21RLQQonXrwBbjVT92v20kPhoWZ+z8X78lCF3
 M+uZN06yMRjS9w0WktN5Z5X3D2UAvd28UXziEqDDHHThWSZXnhoL41OK3nlWN52aj7ln/S
 ehHdVw3Ylqt72fQjHPT1+UwVf3vlu7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699268096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IJ/0sbFkE5Ys0oopJld4h4I6eE1ARKvtwAEsxFAAiU=;
 b=il8fKyTton1X8NbIxR7DYKjRqs7H2TLJNHfQeKbcr/BebrsSiioayEmvu20ini84+aXS1t
 QCbWLURWWRjMZVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 180D2138E5;
 Mon,  6 Nov 2023 10:54:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2BquBADGSGXCIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Nov 2023 10:54:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Nov 2023 11:54:16 +0100
Message-ID: <20231106105418.1240169-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106105418.1240169-1-pvorel@suse.cz>
References: <20231106105418.1240169-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] CI: Replace CentOS 7 with openSUSE Leap 42.2
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
Cc: Ulrich Hecht <uli@kernel.org>, Richard Palethorpe <rpalethorpe@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CentOS 7 (kernel 3.10, glibc 2.17, gcc 4.8.5) is not yet EOL,
but IMHO nobody test it (or other distro with similarly old)
with the latest LTP (older LTP release is used). It's not worth of
effort to keep LTP compilable with that old kernel/glibc headers.

Therefore replace CentOS 7 with a distro with similar age:
openSUSE Leap 42.2 (kernel 4.4, glibc 2.22, gcc 4.8.5).

Although it has EOL in 2018-01, it's still available in docker Hub (thus
working in GitHub CI).

These will become the oldest distros in LTP CI.

The same kernel release 4.4 is also used in SLE 12-SP2, which is still
being tested with the latest LTP release. Also CIP project uses kernel
4.4, people might test it recent LTP.

NOTE: we considered to add also Ubuntu 16.04 LTS xenial (kernel 4.4,
glibc 2.23, gcc 5.3.1, EOL 2021-04). But we need to keep number jobs in
CI reasonable, thus adding just Leap 42.2 which has slightly older
software.

Acked-by: Jan Stancek <jstancek@redhat.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 24876b564..9a8a66b6d 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -58,14 +58,12 @@ jobs:
               TREE: out
               VARIANT: minimal
 
-          # other builds
-          - container: "fedora:latest"
+          # oldest distros
+          - container: "opensuse/archive:42.2"
             env:
-              CC: clang
-              MAKE_INSTALL: 1
-              METADATA: asciidoctor-pdf
+              CC: gcc
 
-          - container: "centos:7"
+          - container: "ubuntu:xenial"
             env:
               CC: gcc
               METADATA: asciidoc-pdf
@@ -80,6 +78,13 @@ jobs:
             env:
               CC: clang
 
+          # other builds
+          - container: "fedora:latest"
+            env:
+              CC: clang
+              MAKE_INSTALL: 1
+              METADATA: asciidoctor-pdf
+
           - container: "opensuse/leap:latest"
             env:
               CC: gcc
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
