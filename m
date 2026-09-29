Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CB7CA5FA5
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:51:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DC9F3CD51F
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 19:51:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54C593CD51F
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:51:24 +0200 (CEST)
Received: from mail-dy2-x09.google.com (mail-dy2-x09.google.com
 [IPv6:2607:f8b0:4864:36::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C8A9F1000668
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:51:23 +0200 (CEST)
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-34bd87d789aso184494eec.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790704282; x=1791309082; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ErcM9kgU4zd/d3JwY0jCX6XdiZqk5VWDSdQm/q8ADI0=;
 b=fczaAqAwI0rHghD3vBgGXguehBY342dBBX/BPT4Q1/fM1mgSBejEIhqSsVCgwSgw0e
 67VmYY8nUX0EUXEOqafUbOxO0u6PUt7d4wkFO1voDGp0jpH5PJuQLO5J39SzIAa5Pepc
 lSTiTArnVWj1yo1vdWJkvblOkwDrCMSUSK87PRjJMp5D3rGWYBSEg+8BgGNEJ6ixjoRx
 tG26aHX0N96pnKUbnvR5rZvWME0SCSkrC7ZIS23k9GTPJ9JMiBW6jylRbEskrB5hkqKb
 wXCRcnjTSDlObV+aXNG1fHV2vflzRb2xM4adRPl4B7KyzyJZA2RLjlP5Os7qyByR189B
 eBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704282; x=1791309082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ErcM9kgU4zd/d3JwY0jCX6XdiZqk5VWDSdQm/q8ADI0=;
 b=BkL042glvc8P6dpZLnj/BXslbSev0woPVAZeBmB3gtbJJ0UANcIuWCVWiDspH1zJrA
 iZ9p2m4dLpq23tLHyZE4fme1udbyXvlywVeUMq2KiRtpOWzWF4oqsCyOLxqLQVVLHuTb
 RADzfxe9XiCX/v+M+hImnm8RPeEwSaxx3Sos0fHgFP8yD4HzKMe6d9W2DNE0IEt2X951
 XZPQ7uXdPnfWucX5/eqRZki4bdRuBxXweMyZV6Kzp9zmQsCSQA9I39R8RmGeEXrBVgou
 GU/qF+SRcn/LWGfZ+k5Oui/MYHVRIWw48bfpBJ4v76Mt8JYkUkY3t4pBLnxZJEdqHopi
 cWcg==
X-Gm-Message-State: AFuF++lGk8L50HtH8vx407BDwDZxfAJhq0FbnQLx0ANouPkuYZO6fq4d
 O1ApUzjSPjRc7YfIVa/NzYSxW8WhZEsuG6oGCfOWgSqrumrYbtID0AoR
X-Gm-Gg: AYBFou1JojaDkoF7f4iI7zN65rV2Iydar0wTk4DD5XLRByqP2EcDR2AFfQn+Jl3FWnw
 yZW7gJPUQigMTkBYtABbzVGNnuN1/TqmnXFuR+/4CXPRZGoy3iA6q2Wytq5NXxPJY+pNbnLPqvW
 /ZEfPXrijkt5VkxhIlphG5nA4sLQYr9f2zuRpfZR/riXJO3HMGRd2rHpbN4NfBcDM1Uh2mRgRUo
 M+k/THrNIhkIuJoLnxVRrOJNYc+wOm8NKj1wMqEMemw5zUMP3W8cq6ZRKCDs9wiY6Zd/F/Tk84y
 Z1BVfFjgnCYoBa93GEMQSXEdA0++ErcWgntjEdgIMfnf2TTdCJxBYXH1jZbPfFMGT0FoiB+0Q5D
 1V+56dnH8jX7Xn0FrLotjXf1YP2yljLMEOgYw1Ni9e0L+2fqvMuerkJtmgraB1j3Wo3KEQRtEez
 33gNlIPiJDa+Zomkmcv9CyBx0kVeU5PGi6S0o+eIwwzzNvBrzKZQOWlMsHAIYXlOAtuQ/HQD7aZ
 fTzHr0rU3RXQ4lWTeAM7cyQsmnKCKKWsL1ioFCOE80qKTVkYfaJYTlfkSQjnjeQjNg+UmeFdSkM
 QAhBUcKcGqU=
X-Received: by 2002:a05:7300:a21e:b0:33e:d4ae:e10e with SMTP id
 5a478bee46e88-34c68570e27mr53629eec.40.1790704281637; 
 Tue, 29 Sep 2026 10:51:21 -0700 (PDT)
Received: from
 runnervmtr4k5.hxjakfajtdtuxlv55ejn1q2nha.dx.internal.cloudapp.net
 ([52.157.33.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c378ca8basm629771eec.9.2026.09.29.10.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:51:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Sep 2026 17:51:19 +0000
Message-ID: <20260929175119.52267-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929141659.2513510-1-pvorel@suse.cz>
References: <20260929141659.2513510-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Update syscalls numbers to v7.3-rc5
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

Hi Petr,

On Tue Sep 29 16:16:59 2026 +0200, Petr Vorel wrote:
> lapi: Update syscalls numbers to v7.3-rc5

> diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
> index d0238dec5..158350976 100644
> --- a/include/lapi/syscalls/arm.in
> +++ b/include/lapi/syscalls/arm.in
> @@ -109,7 +109,6 @@ readv 145
>  writev 146
>  getsid 147
>  fdatasync 148
> -_sysctl 149
>  mlock 150
>  munlock 151
>  mlockall 152

Do not remove _sysctl (and timerfd on mips/s390x). LTP tests such as
sysctl01 rely on fallback definitions from lapi/syscalls.h when running on
older kernels where sysctl(2) is available.

> diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
> index a6cb85da8..357b04ceb 100644
> --- a/include/lapi/syscalls/s390.in
> +++ b/include/lapi/syscalls/s390.in
> @@ -10,17 +10,12 @@ link 9
>  unlink 10
>  execve 11
>  chdir 12
> -time 13
>  mknod 14
>  chmod 15
> -lchown 16
>  lseek 19
>  getpid 20
>  mount 21
>  umount 22
> -setuid 23
> -getuid 24
> -stime 25
>  ptrace 26
>  alarm 27
>  pause 29

s390.in has been overwritten with 64-bit s390x syscall definitions. This file
is used for 31-bit s390 (#if defined(__s390__) && !defined(__s390x__)) and
must retain 31-bit syscall numbers (such as getuid 24, time 13, stat64,
mmap2, and clock_gettime64) rather than 64-bit s390x definitions.

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
