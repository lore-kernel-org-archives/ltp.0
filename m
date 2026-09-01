Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3703AC61DD6
	for <ltp@archiver.kernel.org>; Tue,  1 Sep 2026 23:05:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 286E23E997B
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 01:05:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D2B03E5482
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 01:05:30 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 00C6E100060D
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 01:05:30 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-38fd9408220so88945a91.1
 for <ltp@lists.linux.it>; Tue, 01 Sep 2026 16:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788303928; x=1788908728; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xfT8rGrqzUydO/tob9CVdsTib/kuejbVp7C4AG8R6+s=;
 b=aR/h6KNPr5rvhIMSuIpCchmWKkTesvHstbkQ7a/Iq44lCoEMT+KugkmuxUhY7rv0Qg
 Og8ONl0JOSBNp+kbY9qnnUsaYBkSu7K5NgaMq3/nbYRkaqcSgBWo/qLoBf+iS4CBWU0a
 O4+jUQKgwn/efrmOBvrnpFKEnUCXdGD9xRVzietARyuktTRpwi0iBtILH0DeehlmldJG
 zPk03X/V2Mgzstngz0Vam1FbTijTrB0QbKRouTORMLc4u+knNLwEoG1PMzbhcEvw4l6A
 JVnGbm6gqWN9w7wBax5M9IK67R8erhJReNj7cJNfYi2jTyQWKCvlJzqFLYGjOmuAWtPP
 JhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788303928; x=1788908728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xfT8rGrqzUydO/tob9CVdsTib/kuejbVp7C4AG8R6+s=;
 b=ongr3jRhC0NknxHsGdq9E90d6j4Tec259gLdjOyURfl4ql+3U6fgDmLi7ej9n5C1tQ
 Ru6g2AkfqfHuq2V3DlhX9tkudT7B85CftzGtzWgHVVUB7eHrhu06HVwT/D+w8TNngaZP
 S+CakvF7feJFXpiNOG2EkzpVYoYNJoGebWtxUWn0HKzaMnfW9pSBiYW4g1qpZrpJ019Z
 vAR69f2XEIgY+FQWMimh+W1wxEgED84CldtJo47BWsjO6/+pmiRpZb9/vfiKIV22JXlT
 Ya4fduMfh3kGSgYMIfWZtyLW4oJZ0UADS9kTaigEMfGmpDfzFDFSWUX3qHGBmO8ykBbc
 3vkQ==
X-Gm-Message-State: AFuF++m7tsyQ5vler9lc0DooYxgXtrmx4AGVY0Dhs+55ZYWCRXsXwqZ6
 FUUXOubPez1rZp5kIpCG++BGh1++WXuO+2MOC6dOEejSk8yH8BN7cvt3
X-Gm-Gg: AYBFou1ZBIZQxXqYfP5gxAu6PfhdqYVKYfLIpx9PVuQwFny4Q3pg/X3pLarWxsV2YMy
 b+ZFju3EVFIAZqs3aBG5+YX8ugvC2qn+4cPDfaYixawgNVEmD101D04thaSQ3PRPsscAPsZg79E
 50DlgFgLfRDm83rFrf/bCvG7yVX0/Q5GVaTKxrfHyw8ExDK5N9jCAWTK17L6P2PN7XzpfzVxJxe
 azybx/R7nchqfzwP8mufWMt5B4oB7Hy5u3VobvfV1Gd2ogOKnWqpzfYDqdDQd2rtyvp+P3ltsTH
 PlrWwF/e+2rLCqIIgdzcxWX/pK/brGJdNiW49IhAftSjbBhQWy/jafwyDmK3j0QFW7nE0bprIm1
 j5SztjPd0TloEqlpy8Wgo9qzMb4RLd4fqjWzqLUXuxS5rbdvGN9AfdUMFka7ITW7dqEqRPo+YuF
 99p5dU+P3DYYvCuJZ4ZHsnX1XdNIhrZBCWyL58z+1TiCZmwVYmQ/lP8z9wJMB2T1Ts14aR4XcwJ
 ZhEKVmONreJlCj4nz+ocoBVO2qHzwH2U5VtKbkM7XinpKeqJHAFU7XNgfIrdMxr6+FOFmo/gM3t
 hRLC70CWhw==
X-Received: by 2002:a17:90b:35c3:b0:398:bd37:6a49 with SMTP id
 98e67ed59e1d1-39aee0e6628mr504943a91.12.1788303928126; 
 Tue, 01 Sep 2026 16:05:28 -0700 (PDT)
Received: from
 runnervmgx7h7.mdwwigey15hubdk4xsiuhudezb.dx.internal.cloudapp.net
 ([52.157.2.241]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07bb684esm1205344eec.23.2026.09.01.16.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 16:05:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Tue,  1 Sep 2026 23:05:25 +0000
Message-ID: <20260901230525.8838-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901224512.1180203-1-wakel@google.com>
References: <20260901224512.1180203-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/sched: Fix sched_getattr/setattr fallback definitions
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

Hi Wake,

On Tue, 1 Sep 2026, Wake Liu wrote:
> lapi/sched: Fix sched_getattr/setattr fallback definitions

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
