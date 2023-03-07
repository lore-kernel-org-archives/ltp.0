Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196B0C678D4
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 07:14:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B3C43CCDC1
	for <ltp@archiver.kernel.org>; Tue,  7 Mar 2023 08:14:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF3933C58E3
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 08:14:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C0CFA1A002EF
 for <ltp@lists.linux.it>; Tue,  7 Mar 2023 08:14:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678173252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KVzId34mPV+coMp9uHs8SjCNzYIaco0nXa2hDevAqR0=;
 b=CfvOMxV4Bc/n13QR6GOTJOcHT12+4xfbgFJDvSKYeYjZw7LAibIVul8PxE1eINEDHnygoL
 bZJh+qyH9mOYNszUCEjQLJTN5Lbq5jUGcHh0EHNn29FmlRtevQNEauQyJpHDg74wlaDvKO
 ZSx1vRPzyOk30/SWMBOheZn531+jNLw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-iJ0XCo2fPuChPwXL0-kNrA-1; Tue, 07 Mar 2023 02:14:09 -0500
X-MC-Unique: iJ0XCo2fPuChPwXL0-kNrA-1
Received: by mail-wr1-f69.google.com with SMTP id
 l14-20020a5d526e000000b002cd851d79b2so1900398wrc.5
 for <ltp@lists.linux.it>; Mon, 06 Mar 2023 23:14:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678173248;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KVzId34mPV+coMp9uHs8SjCNzYIaco0nXa2hDevAqR0=;
 b=DRazBZxxIdN/KLjobr8T6A/YrE130XxA91CfWOjI+Iv4I+C4WJxMHKrC+4CBtGsD5r
 9Z/h+K0MzP6f9QCF8SHR8pUhbRpskVl7eD73UHBjCVHsc107VyucFGXKx2552nLfrfXd
 Jz/tEZjm/de3a+WTF8ukn6AiMD7+zxf3Xf1YGEAWU2qk8cSbM7AZOM/M72IFXReJ/uPE
 scCwl0sM3FB/16xwF5gvsXT8w6sh+nxFQj1hqeRfZXdpn2bGZMJcCFtA33FOaHXCrk6v
 SauveY2aBx1RqwSeRQqfB5ju9JBe49W9XqAiodzVxXFkIupkC6NpXeLaFoSuj73Nafzt
 b6ng==
X-Gm-Message-State: AO0yUKUFQDK2ps64HybHBAB9Wwt5cPxyB4/PRSkD2BieeCvvDXalgZCW
 FG8Hsx5WrHRjXoB1MFRhq0lXfCrtol8STrtYwnFLAQPH1/ukJPI/dtphLWyYp1iok23g7EDwwGc
 OJK4+lwBh9ixtQY2BJGQfaYqpLtSgBg/WTnZHag==
X-Received: by 2002:a5d:4084:0:b0:2c9:96b6:1a4a with SMTP id
 o4-20020a5d4084000000b002c996b61a4amr2881176wrp.8.1678173248105; 
 Mon, 06 Mar 2023 23:14:08 -0800 (PST)
X-Google-Smtp-Source: AK7set8gIi891F4I86BfjhUSiSnLTSEGjcw838/qdl0W5FbCpllWp5WG29del9MsaY2T84nBSzfVwKfNnoQTAJY7XwE=
X-Received: by 2002:a5d:4084:0:b0:2c9:96b6:1a4a with SMTP id
 o4-20020a5d4084000000b002c996b61a4amr2881175wrp.8.1678173247794; Mon, 06 Mar
 2023 23:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20230306151303.2757-1-wegao@suse.com>
 <20230306235715.29868-1-wegao@suse.com>
In-Reply-To: <20230306235715.29868-1-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 7 Mar 2023 15:13:56 +0800
Message-ID: <CAEemH2fZs33CkwHY+Jre71eKpkB6bPPmOOxuHZQTGHOofa9KaA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] kill01: New case cgroup kill
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

Hi Wei,

The new test generally looks good to me.

I'm thinking maybe we make use of guarded buffers which could
remove the setup/cleanup function then. And doing memset(buf,...)
before reading into buf[] is quite necessary, to avoid someone
running this test with parameter '-i N' that the buf[] is polluted
by the first time.

https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L1799

<https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L1799>
e.g.

--- a/testcases/kernel/controllers/kill/kill01.c
+++ b/testcases/kernel/controllers/kill/kill01.c
@@ -26,7 +26,7 @@

 #define MAX_PID_NUM 100
 #define pid_num MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
-#define buf_len (20 * pid_num)
+#define buf_len (10 * MAX_PID_NUM)

 static char *buf;
 static struct tst_cg_group *cg_child_test_simple;
@@ -60,7 +60,6 @@ static void child_fn(void)

        while (getppid() == ppid)
                usleep(1000);
-
 }

 static int cg_run_nowait(const struct tst_cg_group *const cg,
@@ -82,6 +81,8 @@ static int cg_wait_for_proc_count(const struct
tst_cg_group *cg, int count)
        int attempts;
        char *ptr;

+       memset(buf, 0, buf_len);
+
        for (attempts = 100; attempts >= 0; attempts--) {
                int nr = 0;

@@ -121,23 +122,14 @@ static void run(void)
        cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
 }

-static void setup(void)
-{
-       buf = SAFE_MALLOC(buf_len);
-       memset(buf, 0, buf_len);
-}
-
-static void cleanup(void)
-{
-       free(buf);
-}
-
 static struct tst_test test = {
        .test_all = run,
-       .setup = setup,
-       .cleanup = cleanup,
        .forks_child = 1,
        .max_runtime = 15,
        .needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
        .needs_cgroup_ver = TST_CG_V2,
+       .bufs = (struct tst_buffers []) {
+               {&buf, .size = buf_len},
+               {}
+       }
 };

Anyway this version you could add my reviewed-by:

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
