Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AADFC433EF
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 10:57:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D26E60EBC
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 10:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D26E60EBC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 359E53C716A
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:57:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 828F43C6268
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 11:57:30 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3D392201157
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 11:57:23 +0100 (CET)
Received: by mail-pg1-x52a.google.com with SMTP id j9so11667717pgh.1
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=Xm+dgiS88VOix8KcBAlErT3IBRooz4Yz2g/lZvYEMCw=;
 b=RWT+O+2bO5aGc3ZQKakKsn/lNO/5kaPsq/McefadlER9LQmi8cRb4WEEdXN8yFu3YY
 FDIfypTpNtJd+VIyB8BGM1QBz9P143so3isGZi0wwMmYM4YMrGFDBY0xEe0b8ePUH4jK
 crghG/wDb5rUi55JISLZSPY8EgJ3yn7P7iH2Jm3OjHOJT3UQQNR08bRv7B+rBm16dLBV
 uqY0BZ1KdLy000H7Iq3elRh4hjXziyL8Leo1HodUO3RRgEUS1j4KJYVakE65EuCjI3A9
 91CCXIsgIFFh15d3W1pdIZZIioMk+NRTSfDfSK086zvP/ekKxFhHHUfHfMSa7oSWfLKH
 vY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=Xm+dgiS88VOix8KcBAlErT3IBRooz4Yz2g/lZvYEMCw=;
 b=vAHQ0ILg2QdRdmtXcEMY+dLtpE1abvFZwQ5GcLmgciIWssp5OibP1K/yRQ/W89rLmo
 fnzADirkkSEv44/0kCrLllb4cHCaLE/7wR7NN9nTFxLt60ykiEt9/viuINeDkGC2uTwN
 yEHKYBfojR9pzewN5O1EO+/85NlqSb6QEGPRAX/HBN5Ez5xAxmsfs5rbs/hUIcLV5D+8
 LFqgfRsnrJXmeUHAodlBm/WZnj29/+JlUpuBGkyk+EJBRGczF2uxRPHmuMgybjGdE3ET
 2dEjDogEnyWbfph6Ni8HZ0UYvbYImKGMamYshzIZT5unKNwWf3/6H8NRgF38F5VCNUzK
 vw5A==
X-Gm-Message-State: AOAM530b/tnAx9h6rNRFdCbem766yq7xLEKVHsHTV5ZrjqdAeR6DdfVt
 dGhcwFYbgzR8dcW3nllhrrJLgMeXP5SHmg==
X-Google-Smtp-Source: ABdhPJyFQN6k4Aq2iO2tfoqWy3QVChjU8S0NOQpFv5ZCGjKwSUFI2+zlvg32Et1mVkp6WAjFOWgUKg==
X-Received: by 2002:a05:6a00:244d:b0:44d:c279:5155 with SMTP id
 d13-20020a056a00244d00b0044dc2795155mr35351693pfj.0.1635850641095; 
 Tue, 02 Nov 2021 03:57:21 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com.
 [35.240.157.64])
 by smtp.gmail.com with ESMTPSA id r25sm15269169pge.61.2021.11.02.03.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 03:57:20 -0700 (PDT)
Date: Tue, 2 Nov 2021 10:57:08 +0000
To: ltp@lists.linux.it
Message-ID: <cover.1635849607.git.repnop@google.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Test support for new fanotify FAN_REPORT_PIDFD
 feature
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

Hi,

This patch series introduces LTP tests for the new fanotify
FAN_REPORT_PIDFD feature which has been merged as part of the v5.15
release.

I've addressed the minor nits that came out of the first round of
review, which can be found here [0].

[0] https://lore.kernel.org/ltp/cover.1635327490.git.repnop@google.com/

Matthew Bobrowski (2):
  syscalls/fanotify20: add new test for FAN_REPORT_PIDFD
  syscalls/fanotify21: add new test checking the returned pidfd from
    fanotify in FAN_REPORT_PIDFD mode

 configure.ac                                  |   2 +-
 testcases/kernel/syscalls/fanotify/.gitignore |   2 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  26 ++
 .../kernel/syscalls/fanotify/fanotify20.c     | 128 ++++++++
 .../kernel/syscalls/fanotify/fanotify21.c     | 306 ++++++++++++++++++
 5 files changed, 463 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify20.c
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify21.c

-- 
2.33.1.1089.g2158813163f-goog

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
