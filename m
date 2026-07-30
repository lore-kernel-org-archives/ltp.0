Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB41C5516D
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 21:14:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C96B33E91BE
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 23:14:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86E143E532F
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 23:13:47 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0871310000CD
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 23:13:47 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51bfda2cd53so974981cf.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 14:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785446026; x=1786050826; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+8/PVq6qWLS36/uzKR8+nRO/xyscD/EWL/YRSYvD5qo=;
 b=b/psXgtxrkWfXatZmer6ryn39Dm/qCkdEJNlLO9ggQPv8m2U6LTDgOV4RcxRAfmIdo
 z6hlSD6P5ZZrjh3Ke2Qcnb0sGBVdtUQURZcv8JZKC9lcrbZhaia57t6GCiiqYzLcpSBn
 pZHD3fO0NPxQrYtOCyPUiNMFCdsbwJV8PsI9uDuPgaFecyKc0EpvYiZZd+N+Puro+xKQ
 H3VH3idFLkGIe7sdnwGD5Zo+y1ZDq28AvBpr2tlbfhv8gxIeKLl4+3VxhWt+AMJbzDZn
 YnCsd96b9IZOwkPsIQSX+1rFY0725hDgUpkebqA4XOMtKrGJyAuWf+gHEg9fQvqgcjf1
 aP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785446026; x=1786050826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+8/PVq6qWLS36/uzKR8+nRO/xyscD/EWL/YRSYvD5qo=;
 b=eLwOMuxfnGcoP8TYH+aJsDuk4+kQk4ZFX1rEF0tuS7WYukdGr4ttb+eg1y/D2/cY8q
 4ByK19tk4Rm+0saFF2jKvTlWuy4IZcxPzw8u7uYA4FgQiFBKlN16NPHn8rv1ZnAH3LH7
 rkAR9uVvd2WSDOWRxs9Njeee+xh/lWEuFuhO402/WnCJbUf0VmGeEFACwmtWJtMPzisL
 +DiNXsTQIkdwvfvaGox7BrDeZsVP4soIIvRHrhAfXwnh8fn/Nq3192qwZdihG88E0Qna
 G4GVHF3asbUCdP6kfozvh7oAmKAm25IT47FomCbgTnm40VD9hd6IJ0F0RiOp+7EJ3Xki
 vIUQ==
X-Gm-Message-State: AOJu0YxGcF0zKduXyHe/HF7KcPuBanioO9M0v6rFewjz6kzXZ38X3E2d
 Ni3GaFDrcj7W1O8GnAwFIYbDOrhoG8OdueSlzRrEC06PRRnecGyvmWrs
X-Gm-Gg: AR+sD12J9idINHZ6ivxogA37u2CGM83k3zAOyXAsQ7qjc6GaD2k7d6i5mNfWKK3CMJB
 5DSf7FtRdch6D+SL+R+NPc3Kg3JjDbc7I3uRl1T38sTiOfEc+XVCpokndEaO+7GfyE34zfGJE9U
 Crb6OwKAWenRBfvGZSo2OoNX6Y1bUQXX6Kd1v2YYPdTtHiIoYagZTbcuZMUHOVfadook2SFGh4l
 SphpECEYxAayQUo1bXOGXc4iWlr6+cB84dolE2o4TVS5PdBbtkVJjd2VIM6HbIEzCqRIa3545QL
 dSDW/Ppu3Lzy+wKAfcjd/Op9L3y5SoOp8l7/5BxYjzvxe62mf19fJEqhY1oTVBdWWNKrObo2dL3
 eVFG9hjSt3N43MNNDLJiKPCcJNmL7Hxg6McRY5kxa6tR0GX/5CyTb3dKVjKYzPgZ7nc6sZ6GrTb
 Fjlnfs8kYng37H8pmJ9esD46X+PPO7Aw13h6X9dXaZsr4bZt9EvTei+leqSwxTHXACeUorHDN3a
 0XOPqg/MEQdbytkGpFlEO/PFATVHpFxtrJd+Ot1Gn23KMX14goOx5s4T+UglRKHh0ddwtMvlm1b
 xJ3TEMHewv2k
X-Received: by 2002:a05:622a:1183:b0:517:7e6e:708f with SMTP id
 d75a77b69052e-52b386a7e3emr44172131cf.52.1785446025564; 
 Thu, 30 Jul 2026 14:13:45 -0700 (PDT)
Received: from
 runnervmvrwv9.3xinleeka1zelpky03zrhmkzma.bx.internal.cloudapp.net
 ([48.217.140.235]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e31f25c1sm50607521cf.31.2026.07.30.14.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 14:13:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Thu, 30 Jul 2026 21:13:44 +0000
Message-ID: <20260730211344.3998-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730194953.274721-2-sbertram@redhat.com>
References: <20260730194953.274721-2-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] newipc: Factor out generic get_ipc_idx_from_id() helper
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

Hi Stephen,

On Thu, 30 Jul 2026, Stephen Bertram wrote:
> newipc: Factor out generic get_ipc_idx_from_id() helper

Both patches in this series were reviewed:

  [1/2] newipc: Factor out generic get_ipc_idx_from_id() helper
  [2/2] semctl01: fix SEM_STAT failures under parallel LTP runs

The extracted helper is a faithful move of shmctl01's SHM_STAT loop, the
kernel-doc on get_ipc_idx_from_id() is well formed, and the shmctl01
conversion is behavior-preserving.

For semctl01, the id-to-index lookup, the func_iinfo() and func_sstat()
adjustments, and the added -lltpnewipc link entry are all consistent, and
the per-index STAT calls correctly avoid the aborting SAFE_ wrappers.

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
