Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00234D4A5EE
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768532531; h=date : to :
 message-id : mime-version : content-description : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=eO2XBoPSLG7H5xMC6vDFPatEGW6NFuZVfcsSsRGJZ8k=;
 b=MA5kYPd6T3SHcf9aqM3JJQXAIvU55yvEbfL8HBLMeMFi2WtEqvLuXvkRhlPPVgPwrluBn
 FtRyGGFqt/PoVgklzwWzPHmXhDC7vZVJqKYWrS85SnXFQxTHT0hs10GKILbWf1N5OTC0rfp
 QbHHI+CCYOKll0lHvkX+nvXSsJxD7yo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 743E13CA6DC
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 04:02:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AFA03C4C0F
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 04:01:47 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 973F22005FE
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 04:01:42 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4801d24d91bso7504175e9.2
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 19:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768532502; x=1769137302; darn=lists.linux.it;
 h=content-disposition:content-description:mime-version:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fimaVnkXGHzreULaKbbPLW9o+aCqU3V8D41H3j7clA4=;
 b=OXFrFVd4wN9oXG97oXyaZCcOwgmiOf26mTvDgMwSJOYXtK56qh0DFBtv2IswlO1O53
 Vhk/xFFXZjEOHJ/1yPsxC6zOLdCkXhS54uFp2PVtEoJ/jvx65I2ZgfvHHGTvg6i3ty21
 AWvBssGekagtpImXnXzDJM5/YVxcJcSCuy66PXJFStX+HegH4bSjSO6Y1sZ/yqWfCz9A
 t183jIz3EzaWWSZbYqM4HpQ5tSpY9tgVhD10Jjp9G8tBrBgmAj5xE+/rUS7EU0F3V5OZ
 U9T9qagKS6qXUv5inkCMmmajig/BWP8+SCkdWApOMtiEkylcUr2xvV534qErYy5yc0cZ
 pjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768532502; x=1769137302;
 h=content-disposition:content-description:mime-version:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fimaVnkXGHzreULaKbbPLW9o+aCqU3V8D41H3j7clA4=;
 b=ZG6PuQFJv7S3YsvVizy+MQ+fIVTUWUfe5qEBrgtz1GkqZrWNeGDG+XvLs4geNg5o8K
 2/9X0+QQ1eM6h5+JOLqCO4gTe7vFTdnL7EbqhuR6U5ykbj1/rKZw0JMSHhZCjPbeMXgr
 gXiIyqJmkEI1xugfwYe41UxqoUdUUUYPjL4pCpnQGOUfGwU5uEseJamylzy+EbZ144ME
 CRAnRxe6CHYTZKvOaUpjWcYai9VOAVjNmtJ22LCYytzlF6YLABVqPoDkTCPWERzkrBTU
 HRkxdjnB4bK4KLUagN/tSSjesNjpayl2iShJIsV1hp51LfNtyrBlPLUbsaydaUDhpVw1
 Nkxw==
X-Gm-Message-State: AOJu0YwfC7WmMXoyIivxFK4vgZet1yU4W1b3Ch70KTr8eLlr+WOMkOaR
 kgo1aGLk20akbaW4vap3ncmG5TCuaWWhKfxGw9FLYx6e9g/joMgj+e9wdMc4O2rt7g==
X-Gm-Gg: AY/fxX6mn21nxzQHqhW7l/klvE2ntBrQnXz+t00b3cJq1LSSeTdWRQU1lhc7Lg2LpS7
 F2+gk5nNYznbx550sQz72fAkh+80rDmS7byQynpoGSWMH2olGormYRsqnNTMLACV1M1H0YV6wNI
 hHf2KJnDq+q+66EhYADIm5kKkB7pNf+lbwvvjMq2yQacIWrjNwUSUXNSlXTsHglLLyqFn801o3K
 PDjGWC7UtLM5LDgs1XDCMacPsXG1QJKzUzNVFDiIruPiaHnwAUt1PSlExtix+OTlWVC8rllP2NS
 6XLvNNU/jA4KlmuhLrn0+BTZq2R9f8VoakQfOfrnfcomCfKMHmaT7eQt6ujFkaIfFE2N0K0H5rI
 2Ky1Mp5Q0jEjFnupLXUuJ7sawV0w8tKeNuvdcEah87cHF7G8+eeOzvqyJk+QBZ91Or1q524AToS
 cqGrx3A44KGJsbuPGfQOjeQe65rJra
X-Received: by 2002:a05:600c:3b27:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-4801e34836amr18007365e9.30.1768532501860; 
 Thu, 15 Jan 2026 19:01:41 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm2231911f8f.26.2026.01.15.19.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:01:41 -0800 (PST)
Date: Fri, 16 Jan 2026 03:01:40 +0000
To: chwen@redhat.com, liwang@redhat.com
Message-ID: <aWmqFAzdtsR0t5aJ@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Description: a
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] clone10.c failed on 32bit compilation
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Chunfu Wen Li Wang

We're encountering an issue where the new test case clone10.c is consistently failing in 32-bit mode. Have you experienced similar problems?
I've attached some preliminary investigation results for reference. Any insights or suggestions would be greatly appreciated.

uname -r
6.19.0-rc5-gb71e635feefc

export CFLAGS="-m32 -fstack-protector-strong"
export LDFLAGS="-m32"
make clone10

tst_tmpdir.c:316: TINFO: Using /tmp/LTP_cloV8soQm as tmpdir (tmpfs filesystem)
tst_test.c:2025: TINFO: LTP version: 20250130-546-g13dbd838c
tst_test.c:2028: TINFO: Tested kernel: 6.19.0-rc5-gb71e635feefc #11 SMP PREEMPT_DYNAMIC Tue Jan 13 16:16:15 CST 2026 x86_64
tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
tst_test.c:1846: TINFO: Overall timeout per run is 0h 00m 30s
clone10.c:63: TBROK: clone() failed: EINVAL (22)

Trace kernel source and found error will triggered by following function:
arch/x86/kernel/tls.c
static int set_new_tls(struct task_struct *p, unsigned long tls)
{
    struct user_desc __user *utls = (struct user_desc __user *)tls;

    if (in_ia32_syscall())
        return do_set_thread_area(p, -1, utls, 0);  <<<<<<<<<<<<
    else
        return do_set_thread_area_64(p, ARCH_SET_FS, tls);
}


int do_set_thread_area(struct task_struct *p, int idx,
                       struct user_desc __user *u_info,
                       int can_allocate)
{
...
        if (idx == -1)
                idx = info.entry_number;  <<<< entry_number is 0 which set by clone10

        /*
         * index -1 means the kernel should try to find and
         * allocate an empty descriptor:
         */
        if (idx == -1 && can_allocate) {   <<< can_allocate is 0 so SKIP, means 32bit mode can not support auto allocate
                idx = get_free_idx();
                if (idx < 0)
                        return idx;
                if (put_user(idx, &u_info->entry_number))
                        return -EFAULT;
        }

        if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
                return -EINVAL;  <<<< idx now is 0 so finally hit this return to clone10


Try following patch firslty still got EINVAL since tls_desc->entry_number will be -1 still go same error.

diff --git a/include/lapi/tls.h b/include/lapi/tls.h
index a067872e0..aedc907d9 100644
--- a/include/lapi/tls.h
+++ b/include/lapi/tls.h
@@ -73,6 +73,7 @@ static inline void init_tls(void)
        tls_desc->limit_in_pages = 0;
        tls_desc->seg_not_present = 0;
        tls_desc->useable = 1;
+       tls_ptr = tls_desc;

 #else
        tst_brk(TCONF, "Unsupported architecture for TLS");

so i try to change entry_number to correct one base kernel src logic.
diff --git a/include/lapi/tls.h b/include/lapi/tls.h
index a067872e0..9e69244da 100644
--- a/include/lapi/tls.h
+++ b/include/lapi/tls.h
@@ -64,7 +64,7 @@ static inline void init_tls(void)
        tls_ptr = allocate_tls_area();
        tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
        memset(tls_desc, 0, sizeof(*tls_desc));
-       tls_desc->entry_number = -1;
+       tls_desc->entry_number = 13;
        tls_desc->base_addr = (unsigned long)tls_ptr;
        tls_desc->limit = TLS_SIZE;
        tls_desc->seg_32bit = 1;

Now i get following output, no EINVAL now but it seems child and parent point to same tls area.
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_cloa20awq as tmpdir (tmpfs filesystem)
tst_test.c:2025: TINFO: LTP version: 20250130-546-g13dbd838c
tst_test.c:2028: TINFO: Tested kernel: 6.19.0-rc5-gb71e635feefc #11 SMP PREEMPT_DYNAMIC Tue Jan 13 16:16:15 CST 2026 x86_64
tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
tst_test.c:1846: TINFO: Overall timeout per run is 0h 00m 30s
clone10.c:48: TINFO: Child (PID: 5262, TID: 5263): TLS value set to: 101
clone10.c:72: TFAIL: Parent (PID: 5262, TID: 5262): TLS value mismatch: got 101, expected 100


Thanks.
Regards
Wei Gao

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
