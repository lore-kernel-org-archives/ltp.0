Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CB0C43327
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 17:54:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DDD53E4D83
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 19:54:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACCE83E1BDF
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 19:54:25 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7AEF11400332
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 19:54:25 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-139b914bab6so1813266c88.1
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782496464; x=1783101264; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=498bbvoVjgm/ZIEr2of4g1GRc0UpxkLcAnznBLjD2uk=;
 b=cXiZyE3kvsTkaTyWDDzPtniXVJHEW0U8fvKpzgKF9uvOpJr6ua1NxY7sp4IHkMFWno
 zu1tXX/zJaihTo+9LIMiiApy1oLHfkLhJxZC3L420wke6HYNHFGZEYaHgp+eLwkyFkRu
 4Uyff5dXbjr3Hv/65Umg24ZyLu8Q48sA+B5oLWNm9RSAhMYWiFAPNYp0WUUKZLCEi4Gj
 dtnjfZlc+LJQeqn3iYYotguj/r10OXv7f9qEdQgiFuqebwdh8Rp2WF/4Asqs31Aou5Tj
 rMTeluN9STwGDFTZiTHQAIOlrAiEUZQ/2lLF64h5pPTQz6cXKwBnavAJfvt8XLSLqcLS
 iRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782496464; x=1783101264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=498bbvoVjgm/ZIEr2of4g1GRc0UpxkLcAnznBLjD2uk=;
 b=MylGoFG8CiGxdMQWqzkbdatq6oyLUckwsSqGq8SO/3Y5TNh1Gqs/IZ5/+0HXXREkdk
 9vNzNxW0rfMrAIufSi+HRdslbyEZ/Ww493kNR4F6zPDPnn4Pbdz8mynpdi2/BCjTF6Nx
 qDmOx73Kk7xWa4wumTzt/JXE71vkAk1iEX4sp5BCAbdAPx4GAaBT8TIJ1qctMHgk8te/
 Pg9DX9JtW4te8fBb5eCB7ayF/Z9PSKbC/o/49jSO2XP1DJFUHnps6vqvtWAS6kyqve3a
 8WUAsd3bIBwxP2K4CU2HuynpFwYvj4OPIKIW6I/TJ2hqy+11ehG7Z1fS1HvEHFwsvABB
 cUtg==
X-Gm-Message-State: AOJu0YzYzlf5+RA3wHYwHy+OYZGaadb4L3EdKx6F9XkTjd/B/zTQWYDs
 9dN+8hHVoTix+PdP+i/Xpyj/IAdl16Xzsu8Qp//YsZG2SGneduXDm2J1CLQKXbJS
X-Gm-Gg: AfdE7cm4K1j5Ev8AI6Bee5rB7Ux/4yWWJ1EvGlF/QHa8G2XAN+146GaJ9P2YvKepWc0
 W2HChepJYBJ+ac3qgmCxjwBOV/h3C6L70XyV4GN9i2hteTm5lK+F13yqsUSDNt59sXNb3ThG2T8
 fb8hEGGfOMiZcAHTEmelmHHfqcGLLa1fM2kYzKrvex0GoiTqjjPi4xaoqx7MuEdpxPZjpRxfcK6
 AsaXHh5Qb1M7aGxtCeEy/+O2u4yvUgJAopmlTfmA8Tu96UMO8VwX/PzK5GujKXeHHXgKxHPgnYW
 Wucr1SJ18PM9eJPOcLYtvzsfSEavS9JGBumGrj2xgHf7Epy/QNdN6HLk9m38KdTS61lewLomho4
 lJmpWvYREz2QkCXYB3icsVY+XYkIXzwUyc2hYKyuGvSFrRJFrf3i/l34QyXJUYj7AiIlPrv9u7P
 VvfqE8wb+LPHukjyesWeMZfMaAlt0rUnj10ajMokjYQlsTQpWxTpEZDpyQN9OFINklYyPtAcl0c
 cy+cxtzy5+91o2600yMieTC+A==
X-Received: by 2002:a05:7022:fa05:b0:139:ed5a:eeef with SMTP id
 a92af1059eb24-139ed5b05b5mr641082c88.46.1782496463546; 
 Fri, 26 Jun 2026 10:54:23 -0700 (PDT)
Received: from
 runnervmmklqx.wgpiwlgfu34u5cm1v304iezhba.dx.internal.cloudapp.net
 ([13.83.42.64]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca8b918sm21732462eec.28.2026.06.26.10.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 10:54:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jeff Layton <jlayton@kernel.org>
Date: Fri, 26 Jun 2026 17:54:21 +0000
Message-ID: <20260626175421.3974-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626-master-v1-1-e4fcb95b232d@kernel.org>
References: <20260626-master-v1-1-e4fcb95b232d@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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

> -	unsigned long vm_inode;
> +	uint64_t vm_inode;

> -			if (sscanf(line, "%lx-%lx %s %lx %x:%x %lu %s",
> +			if (sscanf(line, "%lx-%lx %s %lx %x:%x %llu %s",

The type change to uint64_t is correct, but %llu is the format
specifier for unsigned long long, not for uint64_t. On LP64
platforms (x86_64, aarch64), uint64_t is unsigned long, so passing
a uint64_t * where sscanf expects unsigned long long * is
undefined behavior and will produce -Wformat warnings on 64-bit
builds.

The portable fix is to use SCNu64 from <inttypes.h>:

    if (sscanf(line, "%lx-%lx %s %lx %x:%x %" SCNu64 " %s",

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
