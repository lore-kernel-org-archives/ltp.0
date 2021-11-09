Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D7C433F5
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:05:03 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84E161167
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 10:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D84E161167
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34CE93C091D
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 11:05:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C152F3C01FC
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:04:49 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3D3E60120A
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 11:04:48 +0100 (CET)
Received: by mail-pg1-x52d.google.com with SMTP id g28so9377448pgg.3
 for <ltp@lists.linux.it>; Tue, 09 Nov 2021 02:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=5F9J9uhvf1+waHsrC5XAdQS7J/i30GS74vATxdRvesg=;
 b=tQTYtGkme3rwGB1oWIwMlpXrwRFsQbKiKxAyerl+ILOW4yt/LB5uDRHgrrbdiL5GwU
 42nYUP8T0K4A+0WDEWoWkGST/QBDUgM8q47Yl1hYDCBfPWz+SkGII6pGQcjpFRwNP8a4
 O/qgIq5cd7vonnBnidWtbGQXLMOWduFTXznZrh13rsfrfw3gLNVrzv+/McxEBeSkIiQ9
 aAmydT1HQuoJ5iFJB5HJ5MrHaUp1Qpmy4UThgLUY+XUtPBIKG9WzbT5Z4VKeCQr5QjdH
 S9fkvSRvcUnAldn19vNAwhmdyLASY+WDNyNW3vyi2Xj7r4p81Syfxw7YG2+X/KoOFEsL
 zoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=5F9J9uhvf1+waHsrC5XAdQS7J/i30GS74vATxdRvesg=;
 b=ZPEzuBKmzDHEyCsVODu0x4zMPtIaxkRlHwEJ2uYQba+29tP/jm10HRs4P02wvj+ZXa
 /B5cXs+DZ5giFhlA72U9BaWA8cASG65S2k153ZHqr7MOnOIHak3n6tZnieVflOttE97w
 N8WWRujZprQmY5gDckTitKB288dUtmWe9FY22NQi5DmBYHUvAzA6eoPfpzMXlrHQJFlQ
 IYItwua+4I+gRGUL2+5eTixrToA8JlyJazvVndTmRjI4rW9CCr7O0lxvtxBIhNWgQJc9
 JDR+jHazQrm7K550RDHXSiAN38FgcK+IXP6L9sf9RxFp0n8gHhqthIaWND9Br2HTljsy
 fQKQ==
X-Gm-Message-State: AOAM5330Z3bift38AHXR8VkZkmspFsHPj9opIftyv6qIXh5aRHE6q1+1
 chKG/y3FvPRcJY+UUMCAU8cmttqQxwTvZw==
X-Google-Smtp-Source: ABdhPJxWs1nRIJM6BcxYaYpCdHa1vZXrsbbhtcGD2Yi9kFNzyXTAqtkvqIP+K6D2wfcvAa9hOf4Sng==
X-Received: by 2002:aa7:9d81:0:b0:49f:e072:bfc7 with SMTP id
 f1-20020aa79d81000000b0049fe072bfc7mr6628453pfq.48.1636452286910; 
 Tue, 09 Nov 2021 02:04:46 -0800 (PST)
Received: from google.com ([2401:fa00:9:211:49d1:39e8:a7a5:de38])
 by smtp.gmail.com with ESMTPSA id k1sm10961895pfu.31.2021.11.09.02.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 02:04:46 -0800 (PST)
Date: Tue, 9 Nov 2021 21:04:35 +1100
To: ltp@lists.linux.it
Message-ID: <cover.1636451496.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/3] Add test support for the new fanotify
 FAN_REPORT_PIDFD feature
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: jack@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is a follow up series of the previous series [0] that I had
posted through which factors in Amir's recommendation around the
splitting of the new macro helper into a separate patch.

Apart from that, there's no difference.

[0] https://lore.kernel.org/ltp/cover.1635849607.git.repnop@google.com/

Matthew Bobrowski (3):
  syscalls/fanotify: Add a helper macro which checks for the presence of
    specific fanotify initialization flag(s)
  syscalls/fanotify20: add new test for FAN_REPORT_PIDFD
  syscalls/fanotify21: test returned pidfd from fanotify in
    FAN_REPORT_PIDFD mode

 testcases/kernel/syscalls/fanotify/.gitignore |   2 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  26 ++
 .../kernel/syscalls/fanotify/fanotify20.c     | 128 ++++++++
 .../kernel/syscalls/fanotify/fanotify21.c     | 306 ++++++++++++++++++
 4 files changed, 462 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify21.c

-- 
2.34.0.rc0.344.g81b53c2807-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
