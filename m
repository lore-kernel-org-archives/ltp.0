Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300E7C43458
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 19:50:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53AB33C8438
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 21:50:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35D253C25E8
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 21:49:53 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A64BB2002BF
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 21:49:52 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-30c8b23420bso2292258eec.0
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 12:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782503391; x=1783108191; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDTucI//wkguUr6JW4+Xf/oBqWx3aY0IyjMQT5LVrYE=;
 b=Sxi7IN9RHYNccUCm7LigYFtjGEHnSLdLUXmjg/Fzg3iZCzHqPkFnDDBfvro3wbEN67
 VE+VNsc3Tu0dWjiDS6nwG+D91+ePz2X7SpheyIOD8qLm9gMEMGsn8cbMbwZdagRu0Tnp
 Fyx8etQDauOxgjY1mGLegba8Qx6BV1RDKMlp7mcmBQBQ4LFar2PPvQdaVY6xNAPLnm/4
 AYAAr6g7bG+O9HF78cRrkWMRg4ztavHXcOkEkh2HPQQ1AJQdin9bLbndZ06+3dHiiFqV
 bHZBUxxhR40nTCoxUeXLdrn6BXd64uWaMGijD5d7bxT430iAbiFi0ei53R95vRfCBNom
 HvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782503391; x=1783108191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qDTucI//wkguUr6JW4+Xf/oBqWx3aY0IyjMQT5LVrYE=;
 b=OT4XoGUMsw/YOIWNCciksPQis+sX8fLDji8H3zqP0dIXgCIZ4fMfiFXoZzB9IHiZqA
 cBwu4LlYJmFokqILrWH1WyIabZWZ8782As0GwCh5LL0jNlAJG7InICyTiEIubqBgDvoa
 LJlOMe1oZYR3zPHRuOFIUoeF4slilhsG16myyXPZ8oCV5ujpeoPLBlhHk5Z5vmsUouxt
 hDiiZNoAgIPIJnyhOcjPWobAb1Rsub3uu21Bj8Val067TzjPOp0VFMABLYVQb2uyRjWe
 kI2f9xA3ekQLkvjCvWpq67+47Uea3GSfX0NBBVYgDigFppHYQqWPKwbiI572mfZVXRI3
 W2wA==
X-Gm-Message-State: AOJu0YxYmH84gtYFpyFx45Jd0nc21P18n9OQ0pT7uH8lHsoXJzPXhSzS
 Cg8FdrNizKt6PYVQE+Gof2zJhDPiGU5VzgiR2HBUv7q6Sybr3fDUubUz
X-Gm-Gg: AfdE7clzvcUGv4/ztDVbV5YOZFjEnHxawKlXEWktqP4CsA+LyhJNQyHkGiuYA3Qq3Pk
 djzSQGj0sKKCK9daAAD3GV5L8r60+bK2IlM2oHJbN1+tGryjhV0eQ/6KCmoAvbfKfgX1ZiPEm2+
 MlbI2dAddeG0cNTmPtPG5PfS5VBuuRwkwBu+3d5WHN4USQndPSG3ZO853yzwtdorD7jMUDY+pAr
 MobR1/ygakEBpNrog9oLr6gjOnpir4TnDka+pJhfGwpr6eWpNCFnDBw0wJlb4kzd1NUk8I1gQXX
 goSO1WEDLUHodkCU/ckstkeNEoUbUabVTatlulJ40HZ73683EQF101sKzFn5rHCQ1iDCRysLZyH
 B8V1YUQQhmE/4QsQfZGBQk/mvrVzt1O0sFZsHN51y3RR+ADrlPFgxo0kXx5luSVNT02wTsHyBQ4
 qJMxJ1rBduou3TaEhBGEoBQ21Oz/u1nBHnLepCB23G3KyVDQHeXy8mvPrrVciUrSVxCUxpCdTFE
 GSxuVjdj2BXGRSZYWlcjsg/0WzI0/bUoiS3
X-Received: by 2002:a05:7300:2144:b0:304:13f3:e461 with SMTP id
 5a478bee46e88-30c84d0ed61mr8067794eec.3.1782503390861; 
 Fri, 26 Jun 2026 12:49:50 -0700 (PDT)
Received: from
 runnervmmklqx.jugp4dghd53ezkxajpihhsqn3f.dx.internal.cloudapp.net
 ([13.83.98.83]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca87caasm19569191eec.27.2026.06.26.12.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 12:49:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jeff Layton <jlayton@kernel.org>
Date: Fri, 26 Jun 2026 19:49:49 +0000
Message-ID: <20260626194949.3951-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626-master-v2-1-d1365499b710@kernel.org>
References: <20260626-master-v2-1-d1365499b710@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ioctl10: fix the sscanf() call to handle 64-bit inode on
 32-bit arch
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

Hi Jeff,

On Fri, 26 Jun 2026, Jeff Layton wrote:
> ioctl10: fix the sscanf() call to handle 64-bit inode on 32-bit arch

Verdict - Reviewed

Pre-existing issue (not introduced by this patch):

> 	SAFE_CLOSE(fd);

SAFE_CLOSE(fd) inside verify_ioctl() closes the fd opened in setup()
and sets it to -1. When run with -i N (multiple iterations),
subsequent iterations pass fd=-1 to ioctl(), causing EBADF. The fd
should only be closed in cleanup().

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
