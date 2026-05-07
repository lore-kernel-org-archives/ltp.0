Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8715DCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:02:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F14033E5F70
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:02:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B97D23E28A2
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:02:33 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8C1DE200926
 for <ltp@lists.linux.it>; Thu,  7 May 2026 11:02:32 +0200 (CEST)
Date: Thu, 7 May 2026 17:02:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778144551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lO1KEQ4CCRk2L4icM23NR2GEHZIUbsinv8mddcP0QJ4=;
 b=e6V5tuvNbJg3mA2AYAdDU/BOJfA1CNLreN5zPUZWx5oZK21Xzu+a4aHKZfDKq0oB2j7Ijm
 6d7SOk0YDhx5A/C4GkwBNml4I/XN7MVwrLjWRexoZb6nOHaupY1/3Jmb86sesR7z/1heTw
 vn9erKbV9IQGtZinuCQlCZyZAMm1dDQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>, pvorel@suse.cz, ltp@lists.linux.it
Message-ID: <afxVF3S-m9zDuZnF@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, pvorel@suse.cz,
 ltp@lists.linux.it
References: <20260430091956.10915-1-chrubis@suse.cz>
 <afMwMO1yTBGDLQJc@linux.dev> <afNQuLNeBcYC_zAG@yuki.lan>
 <afvkSly0fxGwFiLY@linux.dev> <afw4Kz6SLbzZ1EKj@yuki.lan>
 <afxQIR7bdmlJmCIr@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afxQIR7bdmlJmCIr@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_test: tst_reinit() abort when already
 initialized
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

> > I guess that we also need to revert:

I look into Petr's patch, seems we can go another way to replace
the checkpoint method.

How about this:

--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -34,10 +34,7 @@ static void run(void)
        file = SAFE_MMAP(NULL, MMAPSIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
        SAFE_CLOSE(fd);

-       tst_reinit();
-       TST_CHECKPOINT_WAIT(0);
-       /* keep running until ima_violations.sh open and close file */
-       TST_CHECKPOINT_WAKE_AND_WAIT(0);
+       raise(SIGSTOP);

        tst_res(TPASS, "test completed");
 }
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
index d7dcd077b..e772cf53b 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -156,6 +156,14 @@ test2()
        validate $num_violations $count $search
 }

+wait_process_stopped()
+{
+       while true; do
+               [ "$(awk '{print $3}' /proc/$1/stat 2>/dev/null)" = "T" ] && break
+               usleep 100000
+       done
+}
+
 test3()
 {
        local pid
@@ -173,13 +181,13 @@ test3()
        ima_mmap -f $FILE &
        pid=$!

-       # wait for violations appear in logs
-       TST_CHECKPOINT_WAKE_AND_WAIT 0
+       wait_process_stopped $pid

        open_file_read
        close_file_read

-       TST_CHECKPOINT_WAKE 0
+       kill -CONT $pid
+       wait $pid

        validate $num_violations $count $search


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
