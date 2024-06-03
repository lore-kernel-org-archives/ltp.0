Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83CAC25B75
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 06:29:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25503D0898
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 08:29:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B375C3D0592
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 08:29:28 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F18E32001D9
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 08:29:27 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4213b94b8b5so5500025e9.0
 for <ltp@lists.linux.it>; Sun, 02 Jun 2024 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717396167; x=1718000967; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bmup0jOIxbuXic3Rht3hcHvtw98v7b4WiXDFF76QS5c=;
 b=Zdmaw78yrZmSxvK0UyuMWlOX18vv4jX3qevRjbz3N8cC2UCSB1aF22GIum7G+GPI9W
 4IlJNrW6Td/6NXKa7+AJ6N18ocnzOPM4WIKvlYMUfTq4nSFTh91IBSub/luJQOeg62Qy
 gb4Gssnk8VUZJkaU/HVBFRpAIFwJneNJHb2gjcrzT1PaenLHIFFM/eW7Mf6dz4AKurT5
 9JqPg1uqbH0Bv6fdWfB9TkH6SEfrx6qgukhFWYc1pJs1rHvvEoYb5WZdFH1VOkMUOxe2
 qNcubwYDYx0Sgz1db+LsaFGCSF/XKBMo2X67jYuDFNzwU2YTHwHSlouU3V/UVcbfDf4p
 /HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717396167; x=1718000967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bmup0jOIxbuXic3Rht3hcHvtw98v7b4WiXDFF76QS5c=;
 b=HVPgGfvamARSo8Hy66Pce+oJ6hgOBeNOfmvtnJB8pwW2yXbPhr+S7eytos/8lFUJPS
 3Lz/7O1Iomlbtx1VIZIWj823aVAYF0jVHLCsgbMlt9yaS0S0p94Lvg0uTX0T+0/XPO1j
 ocUqUnVE5zrWl4aGphjHGzBcZsIXjSxHZpHUZAICiq37TOULEGJSL5DszjWSL1B6UkxE
 nVIoQ1jYNaTip1WSWjHJhJaNdxgx6mhz8oEiYWNpdbuGhM5Bji5F/v2hPXEs97WR4vRh
 zZbK0AfYB565gMN/SJal+YA0WBdJPv3ZLWNh7HtDj87ZF+vfLNzXxkyq5i3mm/FWAT/u
 6ROA==
X-Gm-Message-State: AOJu0YzN3foh25HhM8dDXmcehrqfpSPuB9G/aXY6I6M3gUnpMe12J4yO
 wmha682qIgVFa/qLqxSCkfmpzi4hUB5CluHhjiwF2JBsO+0DGKYozuwQZok72p/pIRwBRTcsLXI
 DQjHmhHe1QlyDKcm5zgo8jV0qvjI=
X-Google-Smtp-Source: AGHT+IGq9kpep3i6TyXJLWAum7nLQPXXC5+4PwchtEraZSHHp21oAGcfxTHCM2LG92O5n8ikdixX+62gJixHSsAg7cI=
X-Received: by 2002:a05:600c:c09:b0:418:ee2:5911 with SMTP id
 5b1f17b1804b1-4213d3068f9mr13345765e9.28.1717396167078; Sun, 02 Jun 2024
 23:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240601195149.17570-1-akumar@suse.de>
In-Reply-To: <20240601195149.17570-1-akumar@suse.de>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Mon, 3 Jun 2024 08:29:15 +0200
Message-ID: <CAJCsO8fTwOsVwhCdBksStaPVjXHBi8m3g+_b-ZAnKByUR3cqyA@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] unlink09: Fix open syscall flags
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

Could you please amend the git commit message to explain why that flag
would be needed?

Thanks,
Seb/

On Sat, 1 Jun 2024 at 21:51, Avinesh Kumar <akumar@suse.de> wrote:

> Fixes: 2cf78f47a6 (unlink: Add error tests for EPERM and EROFS)
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/unlink/unlink09.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/unlink/unlink09.c
> b/testcases/kernel/syscalls/unlink/unlink09.c
> index cc4b4a07e..405deb05f 100644
> --- a/testcases/kernel/syscalls/unlink/unlink09.c
> +++ b/testcases/kernel/syscalls/unlink/unlink09.c
> @@ -43,12 +43,12 @@ static void setup(void)
>  {
>         int attr;
>
> -       fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_CREAT, 0600);
> +       fd_immutable = SAFE_OPEN(TEST_EPERM_IMMUTABLE, O_RDWR | O_CREAT,
> 0600);
>         SAFE_IOCTL(fd_immutable, FS_IOC_GETFLAGS, &attr);
>         attr |= FS_IMMUTABLE_FL;
>         SAFE_IOCTL(fd_immutable, FS_IOC_SETFLAGS, &attr);
>
> -       fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_CREAT, 0600);
> +       fd_append_only = SAFE_OPEN(TEST_EPERM_APPEND_ONLY, O_RDWR |
> O_CREAT, 0600);
>         SAFE_IOCTL(fd_append_only, FS_IOC_GETFLAGS, &attr);
>         attr |= FS_APPEND_FL;
>         SAFE_IOCTL(fd_append_only, FS_IOC_SETFLAGS, &attr);
> @@ -79,7 +79,7 @@ static void verify_unlink(unsigned int i)
>         /* If unlink() succeeded unexpectedly, test file should be
> restored. */
>         if (!TST_RET) {
>                 if (tc->fd) {
> -                       *(tc->fd) = SAFE_OPEN(tc->filename, O_CREAT, 0600);
> +                       *(tc->fd) = SAFE_OPEN(tc->filename, O_RDWR |
> O_CREAT, 0600);
>                         if (tc->flag) {
>                                 SAFE_IOCTL(*(tc->fd), FS_IOC_GETFLAGS,
> &attr);
>                                 attr |= tc->flag;
> --
> 2.45.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
