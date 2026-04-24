Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F03FE5200
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 10:25:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 613563E2D98
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 12:25:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 392663CD9FD
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:25:06 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCA5810000DD
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 12:25:05 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8dbbc6c16b2so960567585a.0
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777026304; x=1777631104; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EshKBwm23PLgE79KZw8dNZ+yOyRIWEUCqIV9FU8xCk=;
 b=CfMRUnpUwLjbzpYD8bbbBccQLG1pLQ0UDfcse0fgovtXyzc8YM4C+1upjJCLLeOINW
 TJlrj+yhkVqyeGHp6Rwl0C4DkhXIJNjKqkmazgo3dN4Ovycn0F6vXhwd0zeGyJM+/+y9
 KTyefUv6bBpBsQ494YrHyxjbpWAiP5Xs9DH+ZfapFBYN81XsGhM/VEvV5S5+5qytgwTq
 SOIrB/fIk79D3Jb+CCkADW4gQ/KgRNwGoJwt9aLS00c0bT2lBHfVPwkQY0Uz3zRqZq80
 zPxycooo2V7LUV+t3nzyHVxCl4+xJNql9EMyGKSvHGdcHIbvjlMXmqjqzmfZv6jzL8K8
 kjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026304; x=1777631104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7EshKBwm23PLgE79KZw8dNZ+yOyRIWEUCqIV9FU8xCk=;
 b=Kz/dXpFeZbmUUe/A8C1SrB3OWYU7iRCcVOAxq+w1aU3miWF239LOFCqqBcYla+n/1D
 y+RQpnW6xeNqQ0zGHOrw68ZNxrWv6BQRGzOlPe2XxYkPzk052JOYApMwb5/culZnB3nj
 oAHY0JxhuBPd9CO8lWSDMdwBbRT5NlANbD8k9a4TdDoytq+KwaEi8g4y6Rt2llZ4mRh7
 Qiot14xX3vgawTZGafuNbe6QZ+2d38x3L1pPsm0fzJSlbLeGtUCn3LH6USBsgs0gz7/9
 Vm0e5UqV32ZuWdExGf3J7VZZQa3eNFp2LZdHnBKA7OK6T2GvsFEaELDOX9+hI6nmkAO0
 VjFg==
X-Gm-Message-State: AOJu0YwxjtOYEwgfaOqupsISF7Udfb1mb0ht/+hZW0CRg8b5LC1v/CVE
 BxdwP/Nfl7k0LKqkMqUL/ROuQGc07FH7J92VPKiVwRlte0YzuNcU4V2o
X-Gm-Gg: AeBDieuSZ8+I/CgAdK683F8KN8tbsOtoeiiaTjvAvI3hSicb40lGKzX3XY+tpYNIbRO
 /XEfqELIk+aS3iNmGVD45ZJBUzAfbSymLTZgc9q2P+nXCthoohUySMSHxEU9yIxhmgqfD+FL/Fk
 WeVW1PVFD5PYxphKDEeZKQgVtGEtu9UsXVkwXI2PeML5Z0XWZ5TW8WvrVvyL9IoLnn43dsMoGqa
 Zxjpb3oJ0ntBpiJzqmigrBT0Ax2Rj1OWDpQX3GgqlOBQaBKWMa/cAfkv9/Ylp9CjqbKTOQKxRK0
 gcqDSDBAl9i2qCmHR7MazjheeadcF/5nm5DLYLiTU/gS9kSa6lEkzSaf54RYgfXzDaq5SUrkwvy
 67r9YuEgNr0ImYRvuLJUO6JcdzA8Dk3QWId/9BGlJ3MgBoUOs8VNaZFzUMAO2D7LhsZ3ljEwEYA
 rjnrzHdsPbXR4DIEDvRT8Ml9kzSeJ7Q5QIuHVz1DGxWHkqFUVOYPEGLPS/DRcXXRSc6dFmZyAKp
 FsKCmg+QAz3S7G19JE6sMtfzFqArJB43egL7oZ84yv5gWRI
X-Received: by 2002:a05:620a:4413:b0:8cd:b317:d69f with SMTP id
 af79cd13be357-8e78a626397mr3818839185a.17.1777026304556; 
 Fri, 24 Apr 2026 03:25:04 -0700 (PDT)
Received: from
 runnervmeorf1.waqj2igf0bnehavxy3b4j2vbqa.ex.internal.cloudapp.net
 ([64.236.135.4]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c44esm184201296d6.27.2026.04.24.03.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:25:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Apr 2026 10:25:03 +0000
Message-ID: <20260424102503.3911-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424101508.505501-1-pvorel@suse.cz>
References: <20260424101508.505501-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ioctl_pidfd06: Update kernel version
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Fri, 24 Apr 2026 12:15:07 +0200, Petr Vorel wrote:
> ioctl_pidfd06: Update kernel version

> -       if (tst_kvercmp(7, 0, 0) >= 0)
> +       if (tst_kvercmp(6, 19, 10) >= 0 ||
> +           (tst_kvercmp(6, 18, 14) >= 0 && tst_kvercmp(6, 19, 0) < 0))
>                 err_nr = EREMOTE;

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24884569804

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
