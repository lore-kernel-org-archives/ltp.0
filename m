Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B412C5AD2B
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 23:36:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA6C53E10F3
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 01:36:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E7403E10F3
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 01:36:15 +0200 (CEST)
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 178A1600216
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 01:36:15 +0200 (CEST)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-44cf1835ec3so7902fac.0
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 16:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786145773; x=1786750573; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1t7Lfv1TrBvPSKhRC/YZjLFrdTX5kFkY0Y2Q6qQhkdI=;
 b=kGoTlF5IKkWshtKQQG31IDxUL1U4tZmL+Rr3eht/GuxFBVVI8pN/TY4CmCMVTJVPk8
 VOvOJE/FRmj2mEm0o0zXUgknwKFq+F1pVEjFbWgE7O4cVE1cinhRbGGXHzTFKuK4rNAu
 lOdnBKUietpPnT2kcNMyi+HIs5Qbnl/CWung1LEyAcezYeBVYixhpPIFNbOeneeqodLY
 xTjmn2WKGYLrAJj9PVneEMDHZ6Qx5zIxVI+FV9kqHFhL2lULD19xsmmAZPpeJJJVCQpE
 AKyprtsPxz+ZbSFQy5W+mgZwxiIMMTl2fr/0O/vqfYbuYTE7uxRdDSY+75S+2h1vgW8n
 eDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786145773; x=1786750573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1t7Lfv1TrBvPSKhRC/YZjLFrdTX5kFkY0Y2Q6qQhkdI=;
 b=rEcQuBf1NOkqRIoL5ZoOsScjmoF+6fWlTz6SuGoMP6epWqU5PEsMPSUII4Jerv2AUQ
 rxpKwtfXN7uquUU/jH4ffaRXaDMF70qCR7KrQdX+uuK98c0b9Xi11a7C26hjPtRreaY1
 aKTzqPApx9vwEyi7E6x5D4ti0XuQgOEvsL/Y/RBxKBRz41KSXI4iRx0zsQt1lhdXjbNo
 vKcTP0NeauwI6AX/2isFEAth2kGy3qokG/H5RYiMNMEAhhnIBHFbBr2qU/xBLE+uw2ZI
 4eBTrsfOBAm7vQWo3DzrCQWqGiNPjNCic7+dcQf1aAf6U3YzoBd5mCUsmY86vH7dYcn/
 Coug==
X-Gm-Message-State: AOJu0Yz6rxsSupBX7nY7xD1OqL9qdEgdzzu7d12qOXNc29Ejc9CxOLKC
 Y7/Oe5GfkfYVvtAjRk/Gw7IFwXGk/vVwWvsJ4Zjto8C20Iwqe6uVLSAD
X-Gm-Gg: AR+sD13kOUIbeQ/Fbclp+xMT2NwqzyV6uNOWg6apYp1DWx6nifS0KCRnhYKReqyUrs8
 G6pqadEGROc0QdKO/PydkCyA3alSYC05T3IPmUrZf1B9RuMmbTpi1U5Cme9HZ2TxxAuu33KqWws
 RUSvzRK7kpMpgtnVmuqxuSAUDQXvIaOoB2iDM3xYkvAfBZqntmBIdws8McCydjSa8YQV1f926GS
 a27r7MjFDrewTYMRYUB/hGTW9EpiS1EuvPQpLxgNyxHPMIdeOfo4UrfcOm2+nA3trhApSxtLAE5
 SoGSwIz9HztsUYIotha/QZepXyFb/IlIrIIkdTRjuUx+LgC1G+RVTk4MKRzVMh7253ShhyDm01I
 Dvry6ljvwMEwP6u3bIy73kbAO5LwGz6cgbJXoD0YTHHBXvXKDeGHyFHGeBvz+dcI/BYlb6D6sWP
 TiK672lG25LhShPS8PO0k5XYAt8UASHymWpTh4ZePjUdnVAwDFp+VIY3nb+7+FJyN+5MPvFnzIx
 kzBpCAQg4QXEhwuZQRJj6p1g8XlzO+fEWykPmkW4RtmRew+ZEcnbv4a6qVhiYaQtlO9pUWLR9c=
X-Received: by 2002:a05:6870:f146:b0:447:2ad0:b36 with SMTP id
 586e51a60fabf-4599f0eed12mr13704748fac.20.1786145773580; 
 Fri, 07 Aug 2026 16:36:13 -0700 (PDT)
Received: from
 runnervmvrwv9.rs1abb4vjttepms4xk3a5hmi5d.gx.internal.cloudapp.net
 ([20.118.29.97]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1d77417sm2947287fac.12.2026.08.07.16.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 16:36:13 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri,  7 Aug 2026 23:36:11 +0000
Message-ID: <20260807233611.8714-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807231752.3218267-1-wakel@google.com>
References: <20260807231752.3218267-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] inode01: Use uint64_t to prevent inode truncation on
 32-bit
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

On August 7, 2026, Wake Liu wrote:
> inode01: Use uint64_t to prevent inode truncation on 32-bit

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
