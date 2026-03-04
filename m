Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB13EDEC04
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 03:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772595692; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FijGOShpG5ujxrf7/rLeINUXNjDssL88ejzllx8hFVI=;
 b=kii1zDWhv1aZsgkO+Q2x1SwcosgKsN9qh/J+NvuXcK5Q95XoAv1h7smnsDnK37Ki2PvmR
 eDNXdWGHfyT8wY5cOJGwjcWTwqkGJhyatHq738/pf1QK58c/YKO92nrdwWph4VjhLElPMIE
 GnE7jD7qo6tMYRhr4J6uvANgPmoXe9Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 051CC3D888C
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 04:41:32 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB5403CAF08
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 04:40:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3962E1000466
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 04:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772595644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcaURo37dSdJIOW79sqGE3Ewv/rmSAMuYpL4B7/O498=;
 b=IUIu/TniCaC48BAGC2zmrVK6zf4qW3KMXO6VZFTKSqmdw2kfClOgQ6qFE/HcF3osIt85xJ
 I2TNb2jEgfeNxDJrN9FRRloFmPBqJNwGjSyc+lUSlxJi1FSmzKhutLn5PgD+np6vs30dgm
 +lr1fPHM+dS3yqBgenlbuGVIDs3h5Mw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-l6I5YeSYOY6SRNoW6m6weQ-1; Tue,
 03 Mar 2026 22:40:43 -0500
X-MC-Unique: l6I5YeSYOY6SRNoW6m6weQ-1
X-Mimecast-MFC-AGG-ID: l6I5YeSYOY6SRNoW6m6weQ_1772595642
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84FBA180075F
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 03:40:42 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58A5F195608E
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 03:40:40 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed,  4 Mar 2026 11:40:34 +0800
Message-ID: <20260304034034.59303-2-liwang@redhat.com>
In-Reply-To: <20260304034034.59303-1-liwang@redhat.com>
References: <20260304034034.59303-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P9g531_OMf95jQZ6cAuMNutMQ-lrhbixIagTqiHLGKA_1772595642
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] lib: Extend LTP_ENABLE_DEBUG to support
 verbosity levels
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following the introduction of verbosity levels for the `-D` command line
flag, this patch extends the `LTP_ENABLE_DEBUG` environment variable to
support the same levels (1, and 2).

Previously, `LTP_ENABLE_DEBUG` acted as a simple boolean toggle. It now
mirrors the behavior of `-D`, allowing developers to specify the exact
level of debug verbosity required from the environment.

And, command-line should take precedence over environment variables when
set both.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v2 --> v3:
    	* Command-line -D take precedence over environment variables.

 doc/developers/debugging.rst     |  2 +-
 lib/newlib_tests/tst_res_flags.c |  2 +-
 lib/tst_test.c                   | 15 +++++++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/doc/developers/debugging.rst b/doc/developers/debugging.rst
index dcb287bb6..86050aa86 100644
--- a/doc/developers/debugging.rst
+++ b/doc/developers/debugging.rst
@@ -9,7 +9,7 @@ Debug messages
 --------------
 
 The LTP framework supports ``TDEBUG`` flag test debug messages. These
-messages can be enabled using the ``-D`` parameter or setting ``LTP_ENABLE_DEBUG=1``
+messages can be enabled using the ``-D[1,2]`` parameter or setting ``LTP_ENABLE_DEBUG=1,2``
 environment variable (see :doc:`../users/setup_tests`).
 
 The ``-D`` parameter also supports the following verbosity levels:
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
index a14f0df2c..21637a472 100644
--- a/lib/newlib_tests/tst_res_flags.c
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -21,7 +21,7 @@ static struct tcase {
 	{FLAG(TCONF)},
 	{FLAG(TWARN)},
 	{FLAG(TINFO)},
-	{FLAG(TDEBUG), " (printed only with -D or LTP_ENABLE_DEBUG=1)"},
+	{FLAG(TDEBUG), " (printed only with -D[1,2] or LTP_ENABLE_DEBUG=1,2)"},
 };
 
 static void do_cleanup(void)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e01c14638..669d43768 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -675,7 +675,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_COLORIZE_OUTPUT      Force colorized output behaviour (y/1 always, n/0: never)\n");
 	fprintf(stderr, "LTP_DEV                  Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
-	fprintf(stderr, "LTP_ENABLE_DEBUG         Print debug messages (set 1 or y)\n");
+	fprintf(stderr, "LTP_ENABLE_DEBUG         Print debug messages (set 1(y) or 2)\n");
 	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
 	fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
@@ -1445,9 +1445,16 @@ static void do_setup(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (tdebug_env && (!strcmp(tdebug_env, "1") || !strcmp(tdebug_env, "y"))) {
-		tst_res(TINFO, "Enabling debug info");
-		context->tdebug = 1;
+	if (tdebug_env && !context->tdebug) {
+		if (!strcmp(tdebug_env, "2"))
+			context->tdebug = 2;
+		else if (!strcmp(tdebug_env, "1") || !strcmp(tdebug_env, "y"))
+			context->tdebug = 1;
+		else
+			tst_res(TWARN, "Invalid LTP_ENABLE_DEBUG value: %s", tdebug_env);
+
+		if (context->tdebug)
+			tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
 	}
 
 	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
