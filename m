Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AA1CD4F5E
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 07:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779263105; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=G99gFZ5ACE8vqPT0mA5UtQJOB2BJzHSxtp773vS7VMA=;
 b=FzKlopGpKA76BSbVjtjp/Ic8sKUrpo9BRJ363TE8ARs7KzQnZ9ZeorhzS6aVW/2p3ChNs
 Bor5UnuKRWLVkSPX2WsZp09sMliyVtoqOEIK3pxyM4puLELPPs8vPGuZtddrygz66CyynpU
 na0yclH6EgnawA///jBInYZ6AcqsDpM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE0BA3C70F0
	for <ltp@archiver.kernel.org>; Wed, 20 May 2026 09:45:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5147C3C70F0
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6157B2009E1
 for <ltp@lists.linux.it>; Wed, 20 May 2026 09:44:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779263074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2z7SeOTnuy5Om2j+kCO8fJQ7NAQW9hahCJXkE8r9UxM=;
 b=W8Bz5zguPNzM41AHxe2HMDEzvLdzbCrfylSPrsRSW3utk95NwcQQgKDkqqyZ8Tj8fgznVB
 ocLKB0ywhl34YGH4lXv5A7aoXCt60EPUOvi5KuHQG78JgHXGl+jFFCXLNpr2S8+vLFjnOC
 HZI/KqpiNp2pT7yCBP+KpfEhwmxpP3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-66lHvP2eP96pzFflRQuQ5g-1; Wed, 20 May 2026 03:44:33 -0400
X-MC-Unique: 66lHvP2eP96pzFflRQuQ5g-1
X-Mimecast-MFC-AGG-ID: 66lHvP2eP96pzFflRQuQ5g_1779263072
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48fed2519daso23444695e9.0
 for <ltp@lists.linux.it>; Wed, 20 May 2026 00:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263071; x=1779867871;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z7SeOTnuy5Om2j+kCO8fJQ7NAQW9hahCJXkE8r9UxM=;
 b=KaV79nFHYCmhaP+4C83wOf4FjF9yzKheBRhrnOo9DQBN9xs6yvVAXY3fVA4F7t/zkp
 vyR4etu9SnKcAV0XcwvoGzSTetiN2zfY1cshNBnK91qazgFSGqs90Qg5/hUL61GO8jxE
 2JBII1g6yPo4//bO1akgYTjATkPOVDCHA0nNGl2j9d6M4scr7b1/r3Pmw340+NHo8HpN
 iPP0T0lM1HpLDzOsoS77+P/PuihI9L5b4Bj6GOUBVDpG/mifKPhQWWOaKo44AmOh+H3T
 8NXCnXDpv86KXdRDIGq9zTFhldku0i2ff0pvZDmLNQO2hiBo6NwMN0g3FtJfCrrBA7C6
 VgOw==
X-Gm-Message-State: AOJu0YzY84V1nR98XYlL90Sc0d6wz04r3Jo3hwroErRNu44xvilUu/TG
 lOQu3sKJvCaam7kOucM4QnQdxL9EdlqxqjjsRf73d3c60f2q3IV/n7zmrqCzItTgCf1OZhyw585
 uMIoXFdIsh2YgT6E8ktG9Cg1vPbidL+sYPaIPtKz9IG94HdTlIF9tte0BGVQ7b7cpf5PG5mXEjz
 mGqKjUUFEZAnlpkRieZ/gva6xe+F6l7EcJOvIV
X-Gm-Gg: Acq92OGvfXa7sNQQsAe53CwkFUFk+7aI7SOjB26g7OCCHbg0/6vrt4/tYsZR4AeyTxv
 pv/ZtNCCn3TdJKSV8JP8/CujG+Sn1/Cvb1TKBG/V4ykEii4Ex8w9tUN+LlYCan0bC40jmj7R8ay
 RK5+d5VsNUwvFM+pFgj919SrxeQ+CRietUVTSOQIJ0MIiZyhCiv31A2ybX0XHaZbBNhnfNslTmV
 b4hOrq2HDLOlAQhxlmMyxoYkQYEMhOx3927fP6ozambdg44eobIH+KREPlNhgLd0HFlRqFdivuI
 S3DKcWnz06gB6Aq5v8i+HwmTNYkl4JiS3VLfNcfPApJDJX2JLPUCTuqv5JjVDuBl2+oIpRIGjag
 1aMUh/9b0MQZekuvdXyKQvDh0gRM6cztHllpPxmJtSA==
X-Received: by 2002:a05:600c:4e87:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-48fe60e51bamr373918575e9.4.1779263071303; 
 Wed, 20 May 2026 00:44:31 -0700 (PDT)
X-Received: by 2002:a05:600c:4e87:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-48fe60e51bamr373918085e9.4.1779263070780; 
 Wed, 20 May 2026 00:44:30 -0700 (PDT)
Received: from fedora.tlv.redhat.com ([5.28.174.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb8d838dsm127721625e9.1.2026.05.20.00.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:44:29 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 20 May 2026 10:44:23 +0300
Message-ID: <20260520074427.39155-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yMtPTlom9pJkYo9jQQDoLmq7vnr4SnJ-lx8p_OuaftI_1779263072
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Improve error handling coverage for futex syscalls by adding tests
for missing error conditions that were previously untested.

v6:
- Fix doc comment in futex_cmp_requeue03 to mention both EFAULT and
  EACCES outcomes for the PROT_NONE case

v5:
- Use compile-time testcase arrays with double pointers instead of
  runtime initialization in setup()
- Fix sparse warnings: add (void *) cast in SAFE_MUNMAP calls
- Remove unnecessary braces in single-statement if blocks

v4:
- Use TST_EXP_FAIL instead of manual error checks
- Add kernel version check for EACCES in futex_cmp_requeue03
- Restructure testcases to use direct pointers instead of flag fields
- Replace raw mmap() with SAFE_MMAP() in futex_wait06
- Remove manual SAFE_WAITPID, let library collect child
- Remove obvious comments in futex_wait07

v3:
- Fix copyright year 2024 -> 2026
- Use /*\ comment format for test catalog
- Add Signed-off-by

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT error coverage test

 runtest/syscalls                              |  4 +
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 98 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 75 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 87 ++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 86 ++++++++++++++++
 6 files changed, 354 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
