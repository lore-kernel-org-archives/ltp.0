Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C37D1D47D
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767889199; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=oSI5+zBlnfA77ise/yY79YzY0zZzL68dEap7t1pEdaA=;
 b=S+vX6pyZsWc98DtUJav6SQjjtxBXiK+C98xTM8onHOctMm6tVYQW0jgk0Awym0Desqyii
 6q5FpI+O3o/bf6uo7rgZfCVVWqCSUXOlFOUIOi3m0iZLqARZDbTlL3AJGa3xQQycImF6KYc
 izbRBS/NCQMKKx+foVkBTDfEJlOnhZM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B8183C6614
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 17:19:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBD833C2789
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 17:19:33 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 988831A00215
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 17:19:32 +0100 (CET)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7AB303F7D8
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767889171;
 bh=yP8Cw/TBK0/MG4z/I75EVPos95WpRZ5/geNrGWUFss8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Content-Type;
 b=gDlDjL4mKehWQnU6/B70Auwd8C2+AcYnXDytMl+AukZuB+dnEU1yOtP+QLpVIv9/o
 zqMgWyZSHqqvaUl9iAgBSy4e6draFJrmxUoi2FJnfWogHCHYldec9k4Htrgxma9/J+
 0DxpeySA1Pw0EX3t++1JQOAo4fbJHQgAGqNwqMeGWX3/MT7zBdskBt5BGdUyPznaR0
 reJNAAJfd+odTCBMhvKJZdMs+FiPsnTTG//I4C704H525i/5jEG0h/LzQLx2vE4eHV
 kz/mklX2qgu5JRpxKMg387ta4NBBqOVtjWKy20WRw7MNbjaiIUgrxlzZ/vi5d7S+vQ
 8jkTe7S9vDGJQXhrTaak6attsoZ7EgsbYAs2HWNGMa6mBaEtN+8bnwEwynFSp/mqFL
 beca7P0CGBeH5jidJen89+BhKeGKOo0cPhkMQZMeMBAIoy3cLAvsgJbefgdg8LGP9G
 GLl1EbZFIJ1bshzeZN68ZyFQZPlXf1kYNiLDpqIkx6GeKc4ztgsslGR08NUMsquwpB
 J2S5ei0DyWrjUeg4ET0UhRRFdj4fLva2R53xgo6Tytq/Qa8oXQ/ifyuS77rtrTOuJp
 nrw4g/CNybTVnAPs7OEJfWFanzRXBEq/JyDSgFA4j+2rqCY/UO/iFDgbn3mrftXK+B
 jUo8Oaccjvt6SZXd9aqAH9UM=
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b7fe37056e1so301166766b.2
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 08:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767889171; x=1768493971;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yP8Cw/TBK0/MG4z/I75EVPos95WpRZ5/geNrGWUFss8=;
 b=rsofN0EAzsOvS6vdIwdx9lmGNj6OiITPxaOJbnzROCuqU7vfdYic7EGZSyE+SeTz+D
 0A0X9rP6LwRfwBAYoGPFHs69m56kfCfsnRcnT/uM8Pe/WasPPM3qBFpsThUrXN2/v2Dm
 MBy495eJEF0qr+CCMb+5d3CdmXHqm+0l7F78d9oW+nogNnpHhbIo7GmGh6yEcGQ2ZDmR
 pW1VSFX4cN81NH+/1SdHnmtS97LPPNcyX+1V1V4id1vHNvnabOHPADCRXRAAtzTY+2Jo
 ke/3ww2YqUxTwR1PthytNQCcaoUWeFHdDjyBB4H8YK+xPgUAQoaBXP5qpoWFNWIjUzFY
 9Gqg==
X-Gm-Message-State: AOJu0YwuGirNGTLApwGLswPb5dRsVdC/Mg0xN084a0BJFPQInnkJUevR
 Slac3YCRjq5a8PB7UIiJ4Uqhhet01dx5oyGRHz6K5ykxoMu/ANn5hk31W7Zlk2Ntk9FIWznIQmy
 8myoeK+T3cqT5QzVPqdr3fCrUWp/cuAcTvOUWKhkyGbjT3bU7zpg/KdaTI/WJ7YWFkKrGx/3Q4D
 jSns+rsuXnC+Wqd+CH5ghE6MjqLouovCAvhgQ9+tbmeXOUnC14dU1I
X-Gm-Gg: AY/fxX7VagMgGn9s0j1EjkL/Vm2IBF4UyQlpdi+DSm1MGJz+zMscM0EeHCJfgSUMCak
 2/IQK+/9E9+ChQMC4F7U6Bb5THqpGNvlEgSUwN1XKNsd2zYVlO0S4aU9m6tVO0wJzLk/qZDo6Zs
 KuqdG7PImra6WWzBaSXiYDPEZtb5shT45Y6SwNTXQEuAzZ7tPOdigdlLicLcuUrz6byiEIQf6Lp
 kBuSP20y11Y0EpVrvt5RX+1RDc=
X-Received: by 2002:a17:907:96ab:b0:b70:c190:62e1 with SMTP id
 a640c23a62f3a-b84453a125cmr593806066b.35.1767889170903; 
 Thu, 08 Jan 2026 08:19:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5Fy7SQDNZsyqTpNh1nf3nw8xAi6B/tmGnr/s+vphidwyafCZNQP3ghsgMjfqCTFCuPacQlaGLvfFvJf/GhlM=
X-Received: by 2002:a17:907:96ab:b0:b70:c190:62e1 with SMTP id
 a640c23a62f3a-b84453a125cmr593804466b.35.1767889170418; Thu, 08 Jan 2026
 08:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20260108161618.103229-1-po-hsu.lin@canonical.com>
In-Reply-To: <20260108161618.103229-1-po-hsu.lin@canonical.com>
Date: Fri, 9 Jan 2026 00:19:18 +0800
X-Gm-Features: AQt7F2os8oS4_Adr2Z5UFfFHbyVffucXHlsO5Zeyu8V54DG5CUaEblqBUdEx1JE
Message-ID: <CAMy_GT8p0VWByEUBCeXEDCd_EyqqLhDsWawqdLn=FRN4LArerQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCHv3] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

bah sorry the title got clipped. (Should end with 6.17.9)
Please allow me to resend it.

Sorry about the noise.

On Fri, 9 Jan 2026 at 00:16, Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:

> The kernel change 78f0e33cd6c93 ("fs/namespace: correctly handle errors
> returned by grab_requested_mnt_ns") from 6.18 has been ported to upstream
> 6.17.9 [1][2].
>
> Therefore change the expectation from >= 6.18 to >= 6.17 accodingly.
>
> [1] https://lwn.net/Articles/1047684/
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.17.9&id=8ff97ade
>
> v2: add comments for this change into the code.
> v3: correst RST syntax and move comment as suggested by Petr Vorel.
>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  .../kernel/syscalls/listmount/listmount04.c   | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/listmount/listmount04.c
> b/testcases/kernel/syscalls/listmount/listmount04.c
> index 2b8b49101..919f4c854 100644
> --- a/testcases/kernel/syscalls/listmount/listmount04.c
> +++ b/testcases/kernel/syscalls/listmount/listmount04.c
> @@ -7,6 +7,7 @@
>   * Verify that listmount() raises the correct errors according with
>   * invalid data:
>   *
> + * - EBADF: invalid mnt_ns_fd
>   * - EFAULT: req or mnt_id are unaccessible memories
>   * - EINVAL: invalid flags or mnt_id request
>   * - ENOENT: non-existent mount point
> @@ -20,8 +21,12 @@
>  #include "lapi/syscalls.h"
>
>  #define MNT_SIZE 32
> -#define BEFORE_6_18 1
> -#define AFTER_6_18 2
> +/*
> + * For commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors
> returned
> + * by grab_requested_mnt_ns") from v6.18-rc7 backported to v6.17.9.
> + */
> +#define BEFORE_6_17_9 1
> +#define AFTER_6_17_9 2
>
>  static mnt_id_req *request;
>  static uint64_t mnt_ids[MNT_SIZE];
> @@ -84,7 +89,7 @@ static struct tcase {
>                 .nr_mnt_ids = MNT_SIZE,
>                 .exp_errno = EINVAL,
>                 .msg = "invalid mnt_id_req.spare",
> -               .kver = BEFORE_6_18,
> +               .kver = BEFORE_6_17_9,
>         },
>         {
>                 .req_usage = 1,
> @@ -95,7 +100,7 @@ static struct tcase {
>                 .nr_mnt_ids = MNT_SIZE,
>                 .exp_errno = EBADF,
>                 .msg = "invalid mnt_id_req.mnt_ns_fd",
> -               .kver = AFTER_6_18,
> +               .kver = AFTER_6_17_9,
>         },
>         {
>                 .req_usage = 1,
> @@ -154,10 +159,10 @@ static void run(unsigned int n)
>
>  static void setup(void)
>  {
> -       if (tst_kvercmp(6, 18, 0) >= 0)
> -               kver = AFTER_6_18;
> +       if (tst_kvercmp(6, 17, 9) >= 0)
> +               kver = AFTER_6_17_9;
>         else
> -               kver = BEFORE_6_18;
> +               kver = BEFORE_6_17_9;
>  }
>
>  static struct tst_test test = {
> --
> 2.43.0
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
