Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7867C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 17:34:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF4573CD519
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 19:34:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37A213CB035
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 19:34:28 +0200 (CEST)
Received: from mail-oo2-x01.google.com (mail-oo2-x01.google.com
 [IPv6:2607:f8b0:4864:31::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9915C1400205
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 19:34:27 +0200 (CEST)
Received: by mail-oo2-x01.google.com with SMTP id
 46e09a7af769-7f193d62888so18765a34.1
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787074466; x=1787679266; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WKTyMJhd7wXk5+8LYwzcSEg/gvVuptz3ShBS2s0r6Fs=;
 b=JyztYnqAaScLhX9qKTIojs0qjkN6XiwMSDsAPMFD30AUspWZvIpP3QeFi9HOiLz6Ls
 guCJ6DOFO9rDUMRoiyjCjR1FdEntafAlMoqW3HFn5XOczYjw+IPkoOKejZbl8apUXhPU
 D/Qy2TOFQ85y3JuaxdmfVRTVT5/JLXapQER+qmbtCdJ62n9f0yK5xNcAe5VScaNb7GwT
 l047ceA9i17iZsObTGA5RIA4Bw4+OLw1HNgjD3bnppWC75gOsmG8TD1+ehqBn3rU7H2b
 Ui/2SyZ63dQz6kk12TpevIVmHJVnunmaKJC0qnXuL13W73HemyWossU4F5hup3ZxSgXq
 IRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787074466; x=1787679266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WKTyMJhd7wXk5+8LYwzcSEg/gvVuptz3ShBS2s0r6Fs=;
 b=P8yEVilF5g+KiAGL2T/jib5knRLmHNs7vauozhU/9Db7tuPEMVc1g9CLar1YAIYoPG
 61fdF46yrqK7ouKsEOFOZas6QO7NSvBpH2HKo6USvLSxCl0WEWv1nxNhY8GJl762+olD
 cv1hNzj8MoYwkatP+JnSfdtJgbVO+qzHNkY79PkkwgB5oYKT0EYn3ff+sqbt8kAxwiGY
 ugsU//WToAD8GZa+E+OxZ1H2LUSSCFx5JSu9fmy6d0MmHKv8DGKhBITJlEsH9FsUuY92
 ks0h2m5vj1lXX1vqQkgu3kcazDEYdU7LLI0ryoc66KhTckdk5Tv6wPofHxt4GVoECIlu
 q9pw==
X-Gm-Message-State: AOJu0YwpOoLtfZ5K8EKsyvUylejrYmVPPeTlUSQb1ujNsYZzBC65Yv1v
 ggNmDq0aO5JfCjr0w3z6XyUwv13/w0rfE0uAszbNBWVKpBiaz/x1Y+2/
X-Gm-Gg: AR+sD10OpgN5rBxxqKHkC9uBtDcBBLffGyr19UCOKmBVbxOGtdjzHsFfOx5z61bjdQx
 kpZCXOxPe6C+TAwjZyezAXH0FCYBZyi/WRnLTBunsh6qXv8XtN0OsfyohmvZU3YYo+hthBIJyub
 f/Q8GldNTi6RD/uEuQcyDiT+xnGFreXcHZlDynSmUIZdEbKpKdqxV+c+ZDIGS6MJ+w8UWl9W6gd
 ohYgiGdQnaUQ1sY41OWI6S3QWU0VzIfI1vpNUuqOG4M7K2/3jLXkLkXAnGntz2jdBbgZTq+NgZ4
 dlNgFm5IU3J7YGGhQnmPpMIZX3XwjvURobzxefFseG0TospMu3PqdY+hwMq5CA2SyN4jxSBcmGE
 WYEynaowSWujx7/01Nb9Xh9WBQmld88C0NDI2e5yls4Gtn7m+gEc1UyCqqWt6au5z7NlpGF9nRU
 KYzwJV8IEvnSvWTpE4Dhhp4CF4G94DPhTWNQAasaJ5xTNzexHP1V3w/e2x6fXKF/cGnLvH2OgjB
 0r1OdFqVbWtRkZZHopE+OMdQwstPIWF73ysIX+YqFqx8UcZnU2tcMV/WamSPaVHeLhbci25gV71
X-Received: by 2002:a05:6830:43a1:b0:7e9:eb13:d042 with SMTP id
 46e09a7af769-7f3de6eb9b7mr33719042a34.8.1787074465990; 
 Tue, 18 Aug 2026 10:34:25 -0700 (PDT)
Received: from
 runnervmzvulz.zfkur4ax2nlu5onhaw0pux0jqe.ex.internal.cloudapp.net
 ([64.236.145.67]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f41bcffb48sm4916375a34.0.2026.08.18.10.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:34:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir Mulani <samir@linux.ibm.com>
Date: Tue, 18 Aug 2026 17:34:24 +0000
Message-ID: <20260818173424.8975-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818113032.41963-1-samir@linux.ibm.com>
References: <20260818113032.41963-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched/cfs-scheduler: Fix 'make check' errors and warnings
 in hackbench.c.
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

Hi Samir,

On Tue, Aug 18, 2026, Samir Mulani wrote:
> sched/cfs-scheduler: Fix 'make check' errors and warnings in hackbench.c.

> Fix all 'make check' warnings in hackbench.c to comply with the LTP
> coding style guidelines.

[Minor] Could create_worker() and reap_worker() be made static, or could the
claim above be narrowed? The affected directory's make check still reports
that both symbols have no prototype or library prefix and asks whether they
should be static.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
