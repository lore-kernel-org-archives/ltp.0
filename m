Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D151BC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:18:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D59023CC88C
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:18:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 995113C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:17:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A55521A01018
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:17:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669371477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2gqqD27cUGcqGadljReNysqyEqKCjDzEPDTqYk9cjQ=;
 b=BFY/XQ3On9Zc7ZCL+7kxJB3EhWEiAh516uB7IsePI57cmjUwFbcxUcnJp2+6k46a1RGRQd
 FGYY7tRiuV+/PcCJgmQxYorko9O1RLLEphmewMzfmXl+umEKSNGWV9tdTMazFahkZ2Bh/t
 U+L1vQO7uGqv33K/wGGNqSrTKCipCAI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-25-LhEjwCgjMBK4aQNGw_BUMg-1; Fri, 25 Nov 2022 05:17:48 -0500
X-MC-Unique: LhEjwCgjMBK4aQNGw_BUMg-1
Received: by mail-wr1-f72.google.com with SMTP id
 w11-20020adfbacb000000b002418a90da01so750104wrg.16
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 02:17:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G2gqqD27cUGcqGadljReNysqyEqKCjDzEPDTqYk9cjQ=;
 b=516P9/iR1ZodBCg2k2yX61ILrHdA+KK3b2yW0tTlrQ9d8vR4s/MmQB3HydHHK4Sbxm
 7Yr47OqXKz63ozwga3Nj38z4qjyLjqZWfRqXu1CWczSWQW7LCHXeSmnkYwXjZoTPlosB
 ZXkR9rCrzve8g3QreZGN06lXu/L+S3JdF2ESVRrlbNpgF9ZrlyVzIw1BxwT75WYGK5JC
 AmHa9EVqB2HWMN9w4aCM0rXflKwOfYsrTZCAt6+JVPDsVVC4OtaVKsJAaCgSVOogfA4V
 oR+Z7MM6rbG8Unw8Ze4AVC3iQwVIkTIYxjIVSvHJEF2wygRftBYU7jgWXh0SXRF4Y63O
 OB2A==
X-Gm-Message-State: ANoB5plBTEFKj6VONew+pAfzC1Xuomtqr1ZpV2+IU3lEAPsCvh9Bd4oF
 yU40s9k7l5cu70iSBK7waH/Bt0axl/t4rPJzXRjs4Qe2GOgwNuR4QVRwPicZJ4GpCzOtpxodAmq
 uoCOi7bJjPiQ=
X-Received: by 2002:a5d:58fb:0:b0:236:74c5:1b2d with SMTP id
 f27-20020a5d58fb000000b0023674c51b2dmr22322382wrd.14.1669371467075; 
 Fri, 25 Nov 2022 02:17:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4nQ1O6oCGRZxp3AWzB5dCyKlLZSqUURzcjPFlKSeM/pYb4BDD8STFDKXqHkq8sActH5C4dKA==
X-Received: by 2002:a5d:58fb:0:b0:236:74c5:1b2d with SMTP id
 f27-20020a5d58fb000000b0023674c51b2dmr22322363wrd.14.1669371466706; 
 Fri, 25 Nov 2022 02:17:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:d800:887:cbec:f31f:a08?
 (p200300cbc704d8000887cbecf31f0a08.dip0.t-ipconnect.de.
 [2003:cb:c704:d800:887:cbec:f31f:a08])
 by smtp.gmail.com with ESMTPSA id
 p7-20020adfe607000000b00241fea203b6sm3401968wrm.87.2022.11.25.02.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Nov 2022 02:17:46 -0800 (PST)
Message-ID: <596210b4-820d-91df-ad2b-5d0c9389173b@redhat.com>
Date: Fri, 25 Nov 2022 11:17:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 25.11.22 10:53, Martin Doucha wrote:
> Hi,
> 

Hi Martin,

> On 23. 11. 22 11:35, David Hildenbrand wrote:
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		SAFE_SETGID(nobody_gid);
>> +		SAFE_SETUID(nobody_uid);
>> +		SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL);
> 
> Manpage says that the last argument of execlp() must be (char*)NULL,
> including the explicit typecast.

$ git grep SAFE_EXECLP | grep NULL
testcases/kernel/connectors/pec/event_generator.c:      SAFE_EXECLP(prog_name, prog_name, "-e", "exec", "-n", buf, NULL);
testcases/kernel/security/dirtyc0w/dirtyc0w.c:          SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child",NULL);
testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem.c:              SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL);
testcases/kernel/syscalls/pipe2/pipe2_02.c:             SAFE_EXECLP(TESTBIN, TESTBIN, buf, NULL);
testcases/kernel/syscalls/setpgid/setpgid03.c:          SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
testcases/kernel/syscalls/setrlimit/setrlimit04.c:              SAFE_EXECLP("/bin/true", "/bin/true", NULL);

> 
>> +#else /* UFFD_FEATURE_MINOR_SHMEM */
>> +#include "tst_test.h"
>> +TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
>> +#endif /* UFFD_FEATURE_MINOR_SHMEM */
> 
> When the child exits through this TST_TEST_TCONF(), the
> TST_CHECKPOINT_WAIT() in parent will fail. The parent process should not
> even fork() when UFFD_FEATURE_MINOR_SHMEM is not defined in config.h.

Thanks, you're right, that's the remaining case that doesn't
make the checkpoint happy.

I tried handling TCONF in the parent and it got all very ugly.
The following should do the trick:


 From fb13df0ea9e477b8e903d3ef4df317e548200a86 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 25 Nov 2022 05:12:26 -0500
Subject: [PATCH v1] security/dirtyc0w_shmem: Fix test result when
  UFFD_FEATURE_MINOR_SHMEM is missing

We have make the checkpoint happy, otherwise our parent process will run
into a timeout.

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
  .../security/dirtyc0w_shmem/dirtyc0w_shmem_child.c   | 12 ++++++++----
  1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
index cb2e9df0c..eac128e5d 100644
--- a/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
+++ b/testcases/kernel/security/dirtyc0w_shmem/dirtyc0w_shmem_child.c
@@ -24,12 +24,12 @@
  #include <linux/userfaultfd.h>
  #endif
  
-#ifdef UFFD_FEATURE_MINOR_SHMEM
-
  #define TST_NO_DEFAULT_MAIN
  #include "tst_test.h"
  #include "tst_safe_macros.h"
  #include "tst_safe_pthread.h"
+
+#ifdef UFFD_FEATURE_MINOR_SHMEM
  #include "lapi/syscalls.h"
  
  #define TMP_DIR "tmp_dirtyc0w_shmem"
@@ -236,6 +236,10 @@ int main(void)
  	return 0;
  }
  #else /* UFFD_FEATURE_MINOR_SHMEM */
-#include "tst_test.h"
-TST_TEST_TCONF("System does not have userfaultfd minor fault support for shmem");
+int main(void)
+{
+	tst_reinit();
+	TST_CHECKPOINT_WAKE(0);
+	tst_brk(TCONF, "System does not have userfaultfd minor fault support for shmem");
+}
  #endif /* UFFD_FEATURE_MINOR_SHMEM */
-- 
2.38.1



Which gives me:

# ./dirtyc0w_shmem
tst_test.c:1552: TINFO: Timeout per run is 0h 02m 30s
dirtyc0w_shmem_child.c:243: TCONF: System does not have userfaultfd minor fault support for shmem
dirtyc0w_shmem.c:95: TINFO: Early child process exit

Summary:
passed   0
failed   0
broken   0
skipped  1
warnings 0


-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
