Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037DFCAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758539201; h=date : to :
 message-id : references : mime-version : in-reply-to : content-type :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : sender : from;
 bh=WYRuxteMh7Fl3ABSZIqX4kk9XdPXIGIbAvrR/XuVhH0=;
 b=C2CsJu+76E7gJYhd9Mm6iExHKtHMQeifJ4AA8YozkKf2u6yPsBq61SGQ60ez+a75jUWUF
 3h+uh5MPhJcEPdsvHhJedMotWBAFHcBrjLwtqygpICYKGGf1B/UEyNy3KjTRJ13/hjvbGJQ
 HgQoNB0bf0jmoUETKtwRhs7N9zIAOeU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AC143CDE4F
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 13:06:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57E1E3C530B
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 13:06:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6F28D2009B2
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 13:06:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758539178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x02oye+0gqR41QTCgkCKW8qJ9NS4S4F97SdNoe0wIJ8=;
 b=bBwgGFFs4L/JeSHF9tP7jTFEq2YNznLnnOlttWa5m2eDo8mEnQ80LJrmWBOjVH7GCq5KbN
 k24ovW9Ino6vMmweWN5BXLLvs0z1VpzZVXmHCXfdJmry9XsH6q2P4yYGWye1P6BJ/YPUKY
 QByURsFWUlrXW/tjZIm22PrBhHU3vtk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-WkZrxWfZNwSiFoAyHhl4IQ-1; Mon, 22 Sep 2025 07:06:16 -0400
X-MC-Unique: WkZrxWfZNwSiFoAyHhl4IQ-1
X-Mimecast-MFC-AGG-ID: WkZrxWfZNwSiFoAyHhl4IQ_1758539175
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f4fbdf144dso833967f8f.2
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 04:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758539175; x=1759143975;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAoz6RjdcOXP8KT36SCiulL+cKRfn3XUG19skibAozM=;
 b=fvZD3YnvZaVBOySnT6W0HgA988x2vTucUr+1WFHYquxV3FPlrMukvjONr5juvzqrdZ
 ePZWcuoYGf648YM+AQV70BRTSXUlKuozOc0r9bg4Ywgpl1oALutyHrkK19HNDmdGXJhZ
 Bzf+OespX7zycJUVxR72nepTLZ036auB/qEIlxsIKAXFmwP2oVqx95KcahblVkQ7ljWB
 a7KRp/xqDMYPtiWsbnfwG1OklB1KMK3z+DRNCoO96fvaC+gX7CFbX3Ze63vYz6en28Sc
 ta6lKJYjgYiESvrSFFOl722OgsuoD2uIkWAJ6+Bc9kINqLSSL4LVOTAGu+AXJyqwJ6Wk
 yW4w==
X-Gm-Message-State: AOJu0YwueJOwiVISvUGrVvJgdtlfesqcNmzsmUiNit57EtjEsCZ0/CER
 pKNbknKLj332TgHuJumar217fqmUVx8pn+nFCTvIhp/No2GcOhV1fyQXj1J6ZJXt+hthROBsgUu
 WZGPW/TUZZlib87eAoZZmKJuAisuy+z2VatcvZ4WIvHJeZzeXPFcbyzwxzQqB
X-Gm-Gg: ASbGncs7zo4SK/EyNSfrD0Ram/0cGC04CxCT/8U6YXgZsX5CgtjGrLTHnUWjK0+n+VB
 jF9NGHJxRBytMblt0TGEmuZiZgoRiPpQDQaIFII5mp7NtrwuYKxsexXhA+EO16M3ZzUqTuxjdco
 MdrSnMC8r9s4O/SL/13tq8I47xbmopWbQ+TIO/wvtWaDlRG4vIjmSk9s0Z0+aoPje4hCgVnmiVI
 yz+OoX3BZRK/roILqZtuCdhcoB3Xy7Qf64uSJKMQYvL66GrcXDFYBnmsMlUJkXAHnoZ29G7aV1+
 VkqF1pnjRhadA+8hKz7CpIDgZXFaBDl06JdZUBmlwE6nLi2xvkdXNrUJ+Q==
X-Received: by 2002:a05:6000:2285:b0:3b7:9c79:32bb with SMTP id
 ffacd0b85a97d-3ee8585e40amr10766932f8f.44.1758539174641; 
 Mon, 22 Sep 2025 04:06:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIiJaJxDCNbnw8IADSsxJOJS3pykQhffxSgPSgaJIBJSpsIYiaCMkr2Sy4ZZQ9RbgoK/31FQ==
X-Received: by 2002:a05:6000:2285:b0:3b7:9c79:32bb with SMTP id
 ffacd0b85a97d-3ee8585e40amr10766907f8f.44.1758539174193; 
 Mon, 22 Sep 2025 04:06:14 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee073f3d73sm19195694f8f.8.2025.09.22.04.06.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Sep 2025 04:06:13 -0700 (PDT)
Date: Mon, 22 Sep 2025 13:06:11 +0200
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250922110611.duahjf4vqvwp4zs4@lida.tpb.lab.eng.brq.redhat.com>
References: <20250917090712.5tbidlr7yvqvikj7@lida.tpb.lab.eng.brq.redhat.com>
 <aNECd4Qw4JSpjqxP@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <aNECd4Qw4JSpjqxP@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tzgOTQYyi1nRxNr9Rfm2ySKkKOCAKj7ADvS9OX-Gl20_1758539175
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="er6e4lufp67spljy"
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Proposal for new LTP config knob: LTP_QUIET
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 "Bird, Tim" <Tim.Bird@sony.com>, ltp@lists.linux.it
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--er6e4lufp67spljy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Cyril,

I'm attaching updated patch.  Hope it does address your comments.
Please check.

Cheers,
Martin

On  Mon  2025-09-22  10:01 , Cyril Hrubis wrote:
> Hi!
> > some time back, LTP_REPRODUCIBLE_OUTPUT was introduced in LTP.
> > I'd like to propose a new, related LTP knob for our Valgrind
> > test automation purposes: LTP_QUIET.  See attached patch.
> > 
> > LTP_QUIET is supposed to suppress certain types of test output
> > messages, such as: TCONF, TWARN, TINFO, and TDEBUG.  This would
> > help us keep our test logs briefer, while still keeping the
> > information we need in the logs.
> > 
> > Please, consider merging upstream.
> 
> Generally looks good, a few minor points below.
> 
> > From fb13e461ac76f6843f0fd9cc37ff42b971e8057c Mon Sep 17 00:00:00 2001
> > From: Martin Cermak <mcermak@redhat.com>
> > Date: Tue, 16 Sep 2025 16:15:22 +0200
> > Subject: [PATCH] Introduce and use LTP_QUIET
> > 
> > Introduce LTP_QUIET env variable.  When set to  1 or y, it will
> > suppress printing TCONF, TWARN, TINFO, and TDEBUG messages, making
> > valgrind ltp test logs cleaner.  In some cases such as  eventfd2_03,
> > shmctl05, mlock03, poll02, prctl09, setsockopt10, and select02 this
> > update avoids false positives.
> > ---
> >  .../0002-Introduce-LTP_QUIET-env-var.patch    | 73 +++++++++++++++++++
> >  auxprogs/ltp-tester.sh                        |  7 ++
> >  2 files changed, 80 insertions(+)
> >  create mode 100644 auxprogs/ltp-patches/0002-Introduce-LTP_QUIET-env-var.patch
> > 
> > diff --git a/auxprogs/ltp-patches/0002-Introduce-LTP_QUIET-env-var.patch b/auxprogs/ltp-patches/0002-Introduce-LTP_QUIET-env-var.patch
> > new file mode 100644
> > index 000000000..a77162bfc
> > --- /dev/null
> > +++ b/auxprogs/ltp-patches/0002-Introduce-LTP_QUIET-env-var.patch
> > @@ -0,0 +1,73 @@
> > +From 183df3240f8e7ca38fbe2fd472c31c9417ae7eb2 Mon Sep 17 00:00:00 2001
> > +From: Martin Cermak <mcermak@redhat.com>
> > +Date: Tue, 16 Sep 2025 15:46:40 +0200
> > +Subject: [PATCH] Introduce LTP_QUIET env var
> > +
> > +Introduce LTP_QUIET env variable.  When set to  1 or y, it will
> > +suppress printing TCONF, TWARN, TINFO, and TDEBUG messages.
> 
> Can you please send a diff and not diff of a diff so that we don't have
> to hand edit it before applying?
> 
> > +---
> > + lib/tst_test.c | 11 +++++++++++
> > + 1 file changed, 11 insertions(+)
> > +
> > +diff --git a/lib/tst_test.c b/lib/tst_test.c
> > +index 92872cc89..609a7b075 100644
> > +--- a/lib/tst_test.c
> > ++++ b/lib/tst_test.c
> > +@@ -68,6 +68,7 @@ static int iterations = 1;
> > + static float duration = -1;
> > + static float timeout_mul = -1;
> > + static int reproducible_output;
> > ++static int quiet_output;
> > + 
> > + struct context {
> > + 	int32_t lib_pid;
> > +@@ -307,15 +308,19 @@ static void print_result(const char *file, const int lineno, int ttype,
> > + 		res = "TBROK";
> > + 	break;
> > + 	case TCONF:
> > ++		if (quiet_output) return;
> > + 		res = "TCONF";
> > + 	break;
> > + 	case TWARN:
> > ++		if (quiet_output) return;
> > + 		res = "TWARN";
> > + 	break;
> > + 	case TINFO:
> > ++		if (quiet_output) return;
> > + 		res = "TINFO";
> > + 	break;
> > + 	case TDEBUG:
> > ++		if (quiet_output) return;
> 
> The LKML coding style requires the return to be on a separate line.
> 
> > + 		res = "TDEBUG";
> > + 	break;
> > + 	default:
> > +@@ -670,6 +675,7 @@ static void print_help(void)
> > + 	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
> > + 	fprintf(stderr, "LTP_ENABLE_DEBUG         Print debug messages (set 1 or y)\n");
> > + 	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
> > ++	fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");
> > + 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
> > + 	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
> > + 	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
> > +@@ -1361,6 +1367,7 @@ static void do_setup(int argc, char *argv[])
> > + {
> > + 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> > + 	char *reproducible_env = getenv("LTP_REPRODUCIBLE_OUTPUT");
> > ++	char *quiet_env = getenv("LTP_QUIET");
> > + 
> > + 	if (!tst_test)
> > + 		tst_brk(TBROK, "No tests to run");
> > +@@ -1391,6 +1398,10 @@ static void do_setup(int argc, char *argv[])
> > + 	    (!strcmp(reproducible_env, "1") || !strcmp(reproducible_env, "y")))
> > + 		reproducible_output = 1;
> > + 
> > ++	if (quiet_env &&
> > ++	    (!strcmp(quiet_env, "1") || !strcmp(quiet_env, "y")))
> > ++		quiet_output = 1;
> > ++
> > + 	assert_test_fn();
> > + 
> > + 	TCID = tcid = get_tcid(argv);
> > +-- 
> > +2.48.1
> > +
> > diff --git a/auxprogs/ltp-tester.sh b/auxprogs/ltp-tester.sh
> > index ba8fd8be4..a95c603c5 100755
> > --- a/auxprogs/ltp-tester.sh
> > +++ b/auxprogs/ltp-tester.sh
> > @@ -21,6 +21,7 @@ PARALLEL_JOBS=${PARALLEL_JOBS:-$(nproc)}
> >  # https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#t
> >  export LTP_COLORIZE_OUTPUT=0
> >  export LTP_REPRODUCIBLE_OUTPUT=1
> > +export LTP_QUIET=1
> >  
> >  # Initialize LOGDIR for bunsen upload (https://sourceware.org/bunsen/)
> >  mkdir -p $LOGDIR; rm -rf ${LOGDIR:?}/*
> > @@ -110,4 +111,10 @@ done
> >  
> >  wait
> >  
> > +echo -e "\nBrief LTP test results summary"
> > +echo "-----------------------------------------"
> > +find $LOGDIR -type f -name '*.trs' -exec grep -F ':test-result:' '{}' ';' |\
> > +    sort -r | uniq -c | awk '{print $NF": "$1}'
> > +echo -e "-----------------------------------------\n"
> > +
> >  echo "TESTING FINISHED, logs in $LOGDIR"
> 
> This is a part of valgrind, not applicable to LTP...
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 

--er6e4lufp67spljy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-Introduce-LTP_QUIET-env-var.patch"

From 3b77308f8f71a4dfd10815b35d783aaddbecb149 Mon Sep 17 00:00:00 2001
From: Martin Cermak <mcermak@redhat.com>
Date: Mon, 22 Sep 2025 12:58:13 +0200
Subject: [PATCH] Introduce LTP_QUIET env var

Introduce LTP_QUIET env variable.  When set to  1 or y, it will
suppress printing TCONF, TWARN, TINFO, and TDEBUG messages.
---
 lib/tst_test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 92872cc89..53b53af1a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -68,6 +68,7 @@ static int iterations = 1;
 static float duration = -1;
 static float timeout_mul = -1;
 static int reproducible_output;
+static int quiet_output;
 
 struct context {
 	int32_t lib_pid;
@@ -307,15 +308,21 @@ static void print_result(const char *file, const int lineno, int ttype,
 		res = "TBROK";
 	break;
 	case TCONF:
+		if (quiet_output)
+			return;
 		res = "TCONF";
 	break;
 	case TWARN:
 		res = "TWARN";
 	break;
 	case TINFO:
+		if (quiet_output)
+			return;
 		res = "TINFO";
 	break;
 	case TDEBUG:
+		if (quiet_output)
+			return;
 		res = "TDEBUG";
 	break;
 	default:
@@ -670,6 +677,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
 	fprintf(stderr, "LTP_ENABLE_DEBUG         Print debug messages (set 1 or y)\n");
 	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
+	fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
@@ -1361,6 +1369,7 @@ static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
 	char *reproducible_env = getenv("LTP_REPRODUCIBLE_OUTPUT");
+	char *quiet_env = getenv("LTP_QUIET");
 
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
@@ -1391,6 +1400,10 @@ static void do_setup(int argc, char *argv[])
 	    (!strcmp(reproducible_env, "1") || !strcmp(reproducible_env, "y")))
 		reproducible_output = 1;
 
+	if (quiet_env &&
+	    (!strcmp(quiet_env, "1") || !strcmp(quiet_env, "y")))
+		quiet_output = 1;
+
 	assert_test_fn();
 
 	TCID = tcid = get_tcid(argv);
-- 
2.48.1


--er6e4lufp67spljy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--er6e4lufp67spljy--

