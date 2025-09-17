Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4724BCAC598
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758100064; h=date : to :
 message-id : mime-version : content-type : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : sender : from;
 bh=wOzr2jkboekSKE+k3jJZkDSN/zUdSFIIOHiWLlQlQjY=;
 b=RYseUGaCxspYqdfku6bQoyiuZ29uf47tBoR6Up2ntUDRX4LNQi+4vK6JZ4bClS+anS6v2
 QIBNOBHnYuYcsq80fUe2ozRDtvYR41OHuceSZtlPeiaWeDpDm773onCOBP79TPNO9J++41X
 4tWIQkQ/YuLmngxaSjsGmSGDUjECti0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CDAF3CDBDE
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 11:07:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 332983C7F94
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 11:07:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F1C89600811
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 11:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758100039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=ihdP8UrJlzj9uDVJ57NzyWhsnnCcsDToS+KlMTZuPZc=;
 b=UkNClEbc1IemnASWQH4eBbv0RwJjBtzEVQy2z0KEW2JCaoJJMprUpkH5fBPxLOCup8Vyee
 rWyuGV+0nJbbxSYkaNf+qXtfmoVwimpouPrJ50dsi3JKQ3lutXh/iQDx3uhON54hLAb5X4
 F7N49X4i/8y4r6gJ3267vrnz7dpuFkw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-OG1gIeZBO52btg5zC0HdYw-1; Wed, 17 Sep 2025 05:07:16 -0400
X-MC-Unique: OG1gIeZBO52btg5zC0HdYw-1
X-Mimecast-MFC-AGG-ID: OG1gIeZBO52btg5zC0HdYw_1758100036
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3eb5130a9efso1908014f8f.2
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 02:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758100035; x=1758704835;
 h=user-agent:content-disposition:mime-version:message-id:subject:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+J67pTOz12UMJkEupyLERbrjHqhTfeIe4BJj/hgOoY4=;
 b=K4xdz20IF3r5ZQ28dZFdtTamrNG5BkciTARxoUpymBwQiJ0yE6pMOXKmE8nQEeEoCf
 pZyA/apz2d7lqPe9zWRbo862DnaUDTXyoEt3lTM7gPRiFhoJQKUINMn47SP9QBOwoLed
 ODS6DXO4J3X1JdRpTJEnpWAmgHmf9O1wdJeveCPhbqKFT3EFNc9IMXfwm+EaWwTIuSwd
 z5zxqlTvvA1gM5Xfe33Ku1jcxjDtPU3jZudRRu4VzNbiAQYLoNrX981s4KCo1hU15eOU
 uNGrrhTm7zCqVocR1E/KFy0jO/riGwc+AG1iwsK/+4yw8wPj+Omc1Y+uX2GiEKixuUlg
 Q8Dw==
X-Gm-Message-State: AOJu0YxUpomYd9invZ2vmX2QL0immxES7WxZFjRFUOWQaQaAqnOwcSHr
 Ihi7zzgwyptXTYbbwA+TJhAkhC5EvZzAPEStWwiO1ginJBO5oAw45SAz9Cek9e9cXTVBP7XkkUI
 Wme2IvbgBxaMor5j037vqpUiOiAf5LdtKmgac4gzvMoqfP7xCii63lu0fjNuBwZJGbtRnnenS1J
 C7z3jQop0cIF4tPDz44TOG0GKTXCdgmF/pWug=
X-Gm-Gg: ASbGncujGMMEG/rsS8//GIH0rbNPkDIgpxh9YqM8fAnkE1I7eBxa1DhO9c/RdIuf6aK
 OQGTr0jwc4AlTI0p95i4aMoo/oe66fHdpEjMcEqFJ9+ywy1nvMEmMvi3VisMxt+wVwVDYtFXjg8
 4jcaQgNhunGa4K5XN5QitqQAUzZf4gjXhgss1T8g4jRaQ7fEAC+Xpw/vFOUx9206PQvuIDkKY6a
 kErxZT6ns4cyGIdKqZJcuTkZIgMwo62vgdvYalXiwM8npWyBa9EcXSnzx5Ewxsc+TikuvSh5git
 Ekjx4STmDV1Dym2d0eH4bi6PVMuw0dyqljGxj82Bdd+qav61WCV9aKRZPg==
X-Received: by 2002:a5d:64c7:0:b0:3ec:db87:e8a8 with SMTP id
 ffacd0b85a97d-3ecdfa07b86mr1009954f8f.37.1758100035556; 
 Wed, 17 Sep 2025 02:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDbnwPtC3cq6g5WQx0ON7MiVlfpUknJHcqZvfMsFM9Z0Zu/o/+7vieRGcOuJpwuZ9k+i1vAw==
X-Received: by 2002:a5d:64c7:0:b0:3ec:db87:e8a8 with SMTP id
 ffacd0b85a97d-3ecdfa07b86mr1009922f8f.37.1758100035014; 
 Wed, 17 Sep 2025 02:07:15 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-461383b7a40sm28613315e9.11.2025.09.17.02.07.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Sep 2025 02:07:14 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:07:12 +0200
To: ltp@lists.linux.it, valgrind-developers@lists.sourceforge.net,
 Mark Wielaard <mark@klomp.org>, Martin Cermak <mcermak@redhat.com>,
 "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <20250917090712.5tbidlr7yvqvikj7@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CIP3pnRrrWL59oLZheNEkchCPWhYulSFpETN_Jti9E8_1758100036
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="fb2tnhla5owrwfrb"
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Proposal for new LTP config knob: LTP_QUIET
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--fb2tnhla5owrwfrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi folks,

some time back, LTP_REPRODUCIBLE_OUTPUT was introduced in LTP.
I'd like to propose a new, related LTP knob for our Valgrind
test automation purposes: LTP_QUIET.  See attached patch.

LTP_QUIET is supposed to suppress certain types of test output
messages, such as: TCONF, TWARN, TINFO, and TDEBUG.  This would
help us keep our test logs briefer, while still keeping the
information we need in the logs.

Please, consider merging upstream.

Thank you,
Martin



--fb2tnhla5owrwfrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Introduce-and-use-LTP_QUIET.patch"

From fb13e461ac76f6843f0fd9cc37ff42b971e8057c Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Tue, 16 Sep 2025 16:15:22 +0200
Subject: [PATCH] Introduce and use LTP_QUIET

Introduce LTP_QUIET env variable.  When set to  1 or y, it will
suppress printing TCONF, TWARN, TINFO, and TDEBUG messages, making
valgrind ltp test logs cleaner.  In some cases such as  eventfd2_03,
shmctl05, mlock03, poll02, prctl09, setsockopt10, and select02 this
update avoids false positives.
---
 .../0002-Introduce-LTP_QUIET-env-var.patch    | 73 +++++++++++++++++++
 auxprogs/ltp-tester.sh                        |  7 ++
 2 files changed, 80 insertions(+)
 create mode 100644 auxprogs/ltp-patches/0002-Introduce-LTP_QUIET-env-var.patch

diff --git a/auxprogs/ltp-patches/0002-Introduce-LTP_QUIET-env-var.patch b/auxprogs/ltp-patches/0002-Introduce-LTP_QUIET-env-var.patch
new file mode 100644
index 000000000..a77162bfc
--- /dev/null
+++ b/auxprogs/ltp-patches/0002-Introduce-LTP_QUIET-env-var.patch
@@ -0,0 +1,73 @@
+From 183df3240f8e7ca38fbe2fd472c31c9417ae7eb2 Mon Sep 17 00:00:00 2001
+From: Martin Cermak <mcermak@redhat.com>
+Date: Tue, 16 Sep 2025 15:46:40 +0200
+Subject: [PATCH] Introduce LTP_QUIET env var
+
+Introduce LTP_QUIET env variable.  When set to  1 or y, it will
+suppress printing TCONF, TWARN, TINFO, and TDEBUG messages.
+---
+ lib/tst_test.c | 11 +++++++++++
+ 1 file changed, 11 insertions(+)
+
+diff --git a/lib/tst_test.c b/lib/tst_test.c
+index 92872cc89..609a7b075 100644
+--- a/lib/tst_test.c
++++ b/lib/tst_test.c
+@@ -68,6 +68,7 @@ static int iterations = 1;
+ static float duration = -1;
+ static float timeout_mul = -1;
+ static int reproducible_output;
++static int quiet_output;
+ 
+ struct context {
+ 	int32_t lib_pid;
+@@ -307,15 +308,19 @@ static void print_result(const char *file, const int lineno, int ttype,
+ 		res = "TBROK";
+ 	break;
+ 	case TCONF:
++		if (quiet_output) return;
+ 		res = "TCONF";
+ 	break;
+ 	case TWARN:
++		if (quiet_output) return;
+ 		res = "TWARN";
+ 	break;
+ 	case TINFO:
++		if (quiet_output) return;
+ 		res = "TINFO";
+ 	break;
+ 	case TDEBUG:
++		if (quiet_output) return;
+ 		res = "TDEBUG";
+ 	break;
+ 	default:
+@@ -670,6 +675,7 @@ static void print_help(void)
+ 	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
+ 	fprintf(stderr, "LTP_ENABLE_DEBUG         Print debug messages (set 1 or y)\n");
+ 	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
++	fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");
+ 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
+ 	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
+ 	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
+@@ -1361,6 +1367,7 @@ static void do_setup(int argc, char *argv[])
+ {
+ 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
+ 	char *reproducible_env = getenv("LTP_REPRODUCIBLE_OUTPUT");
++	char *quiet_env = getenv("LTP_QUIET");
+ 
+ 	if (!tst_test)
+ 		tst_brk(TBROK, "No tests to run");
+@@ -1391,6 +1398,10 @@ static void do_setup(int argc, char *argv[])
+ 	    (!strcmp(reproducible_env, "1") || !strcmp(reproducible_env, "y")))
+ 		reproducible_output = 1;
+ 
++	if (quiet_env &&
++	    (!strcmp(quiet_env, "1") || !strcmp(quiet_env, "y")))
++		quiet_output = 1;
++
+ 	assert_test_fn();
+ 
+ 	TCID = tcid = get_tcid(argv);
+-- 
+2.48.1
+
diff --git a/auxprogs/ltp-tester.sh b/auxprogs/ltp-tester.sh
index ba8fd8be4..a95c603c5 100755
--- a/auxprogs/ltp-tester.sh
+++ b/auxprogs/ltp-tester.sh
@@ -21,6 +21,7 @@ PARALLEL_JOBS=${PARALLEL_JOBS:-$(nproc)}
 # https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#t
 export LTP_COLORIZE_OUTPUT=0
 export LTP_REPRODUCIBLE_OUTPUT=1
+export LTP_QUIET=1
 
 # Initialize LOGDIR for bunsen upload (https://sourceware.org/bunsen/)
 mkdir -p $LOGDIR; rm -rf ${LOGDIR:?}/*
@@ -110,4 +111,10 @@ done
 
 wait
 
+echo -e "\nBrief LTP test results summary"
+echo "-----------------------------------------"
+find $LOGDIR -type f -name '*.trs' -exec grep -F ':test-result:' '{}' ';' |\
+    sort -r | uniq -c | awk '{print $NF": "$1}'
+echo -e "-----------------------------------------\n"
+
 echo "TESTING FINISHED, logs in $LOGDIR"
-- 
2.48.1


--fb2tnhla5owrwfrb
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--fb2tnhla5owrwfrb--

