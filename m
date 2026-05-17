Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B81CD4F3C
	for <ltp@archiver.kernel.org>; Sun, 17 May 2026 02:29:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7004A3E5904
	for <ltp@archiver.kernel.org>; Sun, 17 May 2026 04:29:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0E953C305B
 for <ltp@lists.linux.it>; Sun, 17 May 2026 04:28:58 +0200 (CEST)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 74728140045F
 for <ltp@lists.linux.it>; Sun, 17 May 2026 04:28:56 +0200 (CEST)
Date: Sun, 17 May 2026 10:28:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778984935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L2PhYpR9oBaIHhT97yRtl4T/s9xrvswKDBf61vhSOwA=;
 b=NrdLMpjd/i6y9V73ML5xARGk9ZTf1iSubu4hfWhjJyR+G8MUu5+8/8fN1tPO0lI96hnUxD
 aaelt9DCNuHq5p/a5eZOdlRKEbeceb+dcNeu6vtwmKvRRNV5t/dFXxKFsI0t7zW4Ek4zVb
 rCBEnd0P5BHxqqkJeD4iyfALKgXpwGI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <agkn30ZUs1h8Da3s@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260505083016.36843-1-li.wang@linux.dev>
 <20260515155814.GB45497@pevik> <agf53mSShy735Whu@linux.dev>
 <20260516171536.GA190882@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260516171536.GA190882@pevik>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: Introduce tst_path_macros.h to
 consolidate system paths
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel wrote:
 
> The problem is even now on master:
> output of testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c contains e.g. PATH_OC_HPAGES
> from include/tst_hugepage.h.
> 
> https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html#hugemmap10
> 
> da3088183a ("metadata: metaparse: Implement recursive include")
> skips certain LTP includes e.g. tst_test.h in skip_includes[] causes
> all definitions not being propagated. I guess it could be fixable to parse
> include/tst_test.h and include certain headers.
> 
> $ metadata/metaparse -v testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
> does not print INCLUDE .. because include/tst_hugepage.h is included via
> tst_test.h, not directly in the test.

After looking into the mataparse.c I think we have two methods:

1. Explicitly parsing tst_path_defs.h in metaparse.c:

   Since tst_test.h is explicitly ignored by the skip_includes[] array,
   any files it includes (e.g. tst_path_defs.h) are consequently bypassed
   by the parser. To resolve this, we can instruct metaparse to proactively
   search for and parse tst_path_defs.h during its initialization phase.

   We can achieve this by adding a dedicated function in metaparse.c to
   read this specific header file, and then invoking it within the main
   parse_file function.


2. Simply adding the list of macros to the internal_macros[].

   As long as all the konbs definitions are listed there, metaparse can
   convert them into string paths in tst_test for use in ltp.json.

--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -881,6 +881,66 @@ static const struct macro {
        {"TST_SR_TBROK_RO", "TBROK_RO"},
        {"TST_SR_TCONF_RO", "TCONF_RO"},
        {"TST_SR_SKIP_RO", "SKIP_RO"},
+        {"PATH_KERNEL_HOSTNAME", "/proc/sys/kernel/hostname"},
+        {"PATH_KERNEL_OSRELEASE", "/proc/sys/kernel/osrelease"},
+        {"PATH_KERNEL_VERSION", "/proc/sys/kernel/version"},
+        {"PATH_KERNEL_DOMAINNAME", "/proc/sys/kernel/domainname"},
+        {"PATH_KERNEL_PRINTK", "/proc/sys/kernel/printk"},
+        {"PATH_KERNEL_PID_MAX", "/proc/sys/kernel/pid_max"},
+        {"PATH_KERNEL_SHMMAX", "/proc/sys/kernel/shmmax"},
...

I don't have any preferences, but method-1 looks more elegant.

> My fear was that to clash with existing system headers causing build failure due
> macro redefinition (that's IMHO reason for "TST_" prefix). But "PATH_" might
> be safe, because /usr/include/paths.h contains "_PATH_" prefix - with leading
> underscore (e.g. _PATH_CONSOLE). And the only "PATH_" prefix is PATH_MAX
> in /usr/include/limits.h.

We now have PATH_{KERNEL|USER|VM|FS}, so conflicts should be very low.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
