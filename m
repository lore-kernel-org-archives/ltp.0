Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE17DC55174
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 15:31:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B5893E6F51
	for <ltp@archiver.kernel.org>; Sat,  8 Aug 2026 17:31:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0BF73E6F96
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 17:31:07 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 684EA60015C
 for <ltp@lists.linux.it>; Sat,  8 Aug 2026 17:31:07 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 af79cd13be357-92e56000adeso13972185a.0
 for <ltp@lists.linux.it>; Sat, 08 Aug 2026 08:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786203066; x=1786807866; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kY0WygGhi/558Uhy9QrVJycoVD45oJAiXHZUbkN/LMM=;
 b=FDgSZpb+tQ9vq7lQ7gJ2RVfG10CL9AeqBjzNSIgFMHmdjspMMI/5ItedSjN5AHHjTl
 l22NPYyQFKPMbyPdmL9UyFlO9rBruHy9NdeAhnFamXN27diVbQO9IqvHbKWUcIorAIE4
 /6iI0Za/yAOJa0LGjs918Ga3m7xmmILJwHAwL0gtatP7xH7UkabjUOhqlpjw6uWq1LEd
 rFoJwgeYTIfbzcv9nVKmkwEqTzEaE+5AJ5+dxw/MS/ZF6SeRe9Y6DCB/kDT3PZ4dp7rc
 lmPxJdk3/IsMZJ8A0upieaB9NGGKAJDMQshxroP2qq8lWvDsoqhAMHK6X3GO+ffH2G5H
 gBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786203066; x=1786807866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kY0WygGhi/558Uhy9QrVJycoVD45oJAiXHZUbkN/LMM=;
 b=SiewFBrQzzEpy2khH5Ve3Jbs9App2c+RehaQ7mOVW8GGakIO63dJsX7YmiAkBeRHMA
 sfEINd73ZICePGlUT0mAQ2LrcO5OFDSuxHdaEMAP4UaqRQitgfUoMafb38P4JCD6pCtX
 O2mfOuTHb5QK8DuR/ap3bRQAmSTIy3wQfJgmCf2F3CLeV5//XqVNbaWHYax/DE46bnl8
 JbmNM9CI/mxM6bMl7broVUAxM+AYWONMMUHQnqYP090prvQOiA2LXNVPSANwJ1WLZdq4
 j5uijJ0yagPfrXDqFv4fHyalcKa3ZR1yCSEIjdI1mtM1vDWMDr3U4SVAAW5Yu1/CrrRe
 BPqQ==
X-Gm-Message-State: AOJu0YwJtp8ywuxZrjIQKJupLazDh8Kxgmpwyv6YQ3CS0bgtTnLP90XT
 oW1KpXu29jV6YncR0BG7KsWBiOOZJ2Hfbi7yQMNWEX/s7jfiKCD/Niet
X-Gm-Gg: AR+sD12P1sPncDmmRbz+VMKhCggVwXvv3ZvT/atmy9YkXQclzWLzXmsNLBd/Q6XOadx
 VpH1Bx1EjOKXNICw6MfAYYGPr0/PLoznwvs6qbvX2ovUm8/Jr94/SWqzSX6wfaOUsNTfLdqu8Kv
 fh13ZPKpeDXMml0gz4UXzFH0t54pFHkAUilixPC5dBXbcd3YhyGVwAfFOvec8W4Dc0tTAStFGtZ
 RpS4qtlLviZ8REis9ke/0NmJutbr9agnihwBhgx0eppTfbK+WBTxHsiiKgUqSjokOs4+ZhcVkgx
 4MUyqUsQnxIe0hm444nQgoZg3pe1XwMI3Odk3+6mlKo6S47wskU5gEPTYZV4aVJ7tql0eyGzj/A
 vZ4S8opkEKrgrG4JpwuDNlPLUBBt8KudnVBExkEQv1OH2B8VSj0l4yWL+IOirDzllQoXiZmSO08
 e0UrhmPQK6sGRK9lzuQ3ZHuCNa2l78fh2h55dbIt7WKoNWTyAGmoGs4YoR6ho5AYdjr4WmDI3l7
 k35CIfwArYcJFiDLCxUA+rRTjaM/1pGOmnrbHSUbg/zEmTXno0Mu0AhPI8gYO1vBzDKIR8aylU1
X-Received: by 2002:a05:622a:1487:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-52ce5f449d4mr323099271cf.7.1786203065778; 
 Sat, 08 Aug 2026 08:31:05 -0700 (PDT)
Received: from
 runnervmvrwv9.bgpiw401payeddn0guouu54omc.bx.internal.cloudapp.net
 ([52.188.86.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d16335bb4sm35103381cf.2.2026.08.08.08.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 08:31:05 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Sat,  8 Aug 2026 15:31:04 +0000
Message-ID: <20260808153104.35823-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808150331.127440-1-avinesh.kumar@suse.com>
References: <20260808150331.127440-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timer_*/speculative: Handle SIGSEGV on invalid
 timer ID
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

Hi Avinesh,

On Sat, 8 Aug 2026 17:03:31 +0200, Avinesh Kumar wrote:
> openposix: timer_*/speculative: Handle SIGSEGV on invalid timer ID

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
