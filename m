Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EEAC07545
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 14:01:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 495163CF90E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 16:01:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C207E3CEC34
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 16:01:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FA44602ADE
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 16:01:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18DFD1FF69;
 Wed, 25 Oct 2023 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698242476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLRhbKuK+YthjYj1x4ZlQbeO6xgffrq2naLE1grmH7c=;
 b=3X6pW7mkAvjXlKVQg1p8s0D0thVVapSvUZ6cHg8KLIS/AKOu2R0DHQK4qaMzF9P2BNSsTj
 MJrrsrlv6OwjQL/WbyC6b0woUidugdKfQXZSCkYGcdqE32+JVALCCrNPS+squMkRcfhdOO
 7fj87fDCHN55Qc2dx6hJ1t3Nx8tKtl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698242476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLRhbKuK+YthjYj1x4ZlQbeO6xgffrq2naLE1grmH7c=;
 b=frjgPT1PAQppGhwDC04FNNLIgHh1CVJ+EMKsrk2x51RafPRnUKu1cUciS/5R4qxE//6/7B
 FExjNjOdTH/821Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 544EB13524;
 Wed, 25 Oct 2023 14:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SL6iEKsfOWWAEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 14:01:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 16:01:08 +0200
Message-ID: <20231025140109.340441-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025140109.340441-1-pvorel@suse.cz>
References: <20231025140109.340441-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.08 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[15];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.98)[99.92%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] CI: ReAplace CentOS 7 with openSUSE Leap 42.2,
 Ubuntu xenial
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
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CentOS 7 (kernel 3.10, glibc 2.17, gcc 4.8.5) is not yet EOL,
but IMHO nobody test it (or other distro with similarly old)
with the latest LTP (older LTP release is used). It's not worth of
effort to keep LTP compilable with that old kernel/glibc headers.

Therefore replace CentOS 7 with two distros with similar age:
* openSUSE Leap 42.2 (kernel 4.4, glibc 2.22, gcc 4.8.5)
* Ubuntu 16.04 LTS xenial (kernel 4.4, glibc 2.23, gcc 5.3.1)

These will become the oldest distros in LTP CI.

Although both has EOL (Leap 42.2 in 2018-01, xenial in 2021-04), they
still available in docker Hub (thus working in GitHub CI).

The same kernel release 4.4 is also used in SLE 12-SP2, which is still
being tested with the latest LTP release. Also CIP project uses kernel
4.4, people might test it recent LTP.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

Li, Jan, do you want to introduce another CentOS version? As there will
be none.

Tested on: https://github.com/pevik/ltp/actions/runs/6641429013

Kind regards,
Petr

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
