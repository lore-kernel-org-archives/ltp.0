Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4B6C27C53
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 13:54:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C52B93D0992
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 15:54:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB2AC3CD671
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:54:08 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F73C140121D
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 15:54:08 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a68f1017170so258937766b.0
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717595647; x=1718200447; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QTYnKO28j3YI9ux1Zgv39qkSZnMjwNV2K+hqhI8JYnc=;
 b=u5MYloNRqEdWGMyjHHirx1ukxmFOdFD2JLE3YKxD19XQ1TRplNFMnFfOdwe6hZJuFM
 hAT1IH9Qfnz70+n+qyTGTVHNUcyKQaBL5WJ5ZyIv8qlVyu3zKt/V9yXGxueLHxGOQL7H
 7+ApXUbEzCy5SXfpx/yycK/e30zJPiug+tdf1bWY12rEDTkmVKNZavI0Mm+VHsd0BdSA
 95QYIT/vIe2Qn3WBrC/6XWICH3btIsD0zRfAFOOBxya1Vq+UAccGbu37FTg+nYs/c0pX
 F5+76iojcahLQt0zt+GcSG5u5caHXjxesvn3QDEN/cNnhpBpgft0V4HQEfcq3QNNa6Eq
 X0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717595647; x=1718200447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTYnKO28j3YI9ux1Zgv39qkSZnMjwNV2K+hqhI8JYnc=;
 b=ZENNZz0SyPR+maA5NKSsutvwNqBKq7aOFp/rOIW9ptgCcWKL9fKhtGO7EgOQZWyLes
 pzX2mSvQs0Mdmxnk7pGuc18qFHITYMAJKmH5DQANOmrlyAwiQhoawTzz5x3Vu6eGFPj0
 leBvjrtnvm0RrlSPHX/upbxdO9g9gPT0d+CsCMyyIU2x3m2Exmg2E8IphunBeeVRkKAQ
 U7TyWVNOBwICIp5yfqlUeZHodqJWwqu6SyS673JKyVSRLdOPy9rYhskSIeN3oi+yPX6u
 oEccLTGyZH5nAWINxrm16jjdlIyv3s0TLCJtsbPMRZ6yBdzkQaS723hSmYTDaWz5ktn5
 uw8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRkmvqQzhggObi36ljz+cu0RFjoR2zOPZ7sAHymcIV09soNMfgljSKiJ/Gl7Qi+c23kYUP8lBOjAeMwmVPGhyIuuY=
X-Gm-Message-State: AOJu0Yycv2tDqQfHqcHk2D6xoQfY6dtQmrPbt7zRel6oiICexyTc/qBq
 VJUNH+oWt6gz5OIoJ90yf3Be9DrUcmKM+30X/ncI8XteJrQNwrsBdoQF55p+C6Y=
X-Google-Smtp-Source: AGHT+IFdZN11IhO+Wzyc/C0Q4Y5W12qxkiMbqEoJ7pPfnvvovPjrkZuFmtGBH6F4gxxBTXjxG8vPLQ==
X-Received: by 2002:a17:906:2750:b0:a68:f1ca:a8df with SMTP id
 a640c23a62f3a-a69a0016ed5mr163026566b.71.1717595647239; 
 Wed, 05 Jun 2024 06:54:07 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68b7b8c33asm642098566b.69.2024.06.05.06.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 06:54:06 -0700 (PDT)
Date: Wed, 5 Jun 2024 16:53:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <ec11cd23-18a8-443c-8dc4-bb444a15b35b@moroto.mountain>
References: <CA+G9fYuzd9Cz2Ndwc7HFOimJPRZL7w376N=2R2cV-d0mjzT+nw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYuzd9Cz2Ndwc7HFOimJPRZL7w376N=2R2cV-d0mjzT+nw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] WARNING: at fs/nfs/nfs3xdr.c:188 encode_filename3 on
 rk3399
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
Cc: linux-nfs@vger.kernel.org, kasong@tencent.com,
 Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 NeilBrown <neilb@suse.de>, open list <linux-kernel@vger.kernel.org>,
 lkft-triage@lists.linaro.org, Anna Schumaker <anna@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, May 30, 2024 at 06:54:05PM +0530, Naresh Kamboju wrote:
> The following kernel warning has been noticed while running LTP statvfs01
> testcase on arm64 device rk3399-rock-pi-4b with NFS mounted test setup and
> started from Linux next-20240522 tag and till next-20240529.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Test log:
> -----
> mke2fs 1.47.0 (5-Feb-2023)
> tst_test.c:1131: TINFO: Mounting /dev/loop0 to /scratch/ltp-9gvw[
> 5211.161721] EXT4-fs (loop0): mounting ext2 file system using the ext4
> subsystem
> F2L8n6/LTP_stadLH0F7/mntpoint fstyp=ext2 flags=0
> [ 5211.169391] EXT4-fs (loop0): mounted filesystem
> af9dfac2-88f6-453d-9d02-c14cc888a51d r/w without journal. Quota mode:
> none.
> statvfs01.c:32: TPASS: statvfs(TEST_PATH, &buf) passed
> [ 5211.175518] ------------[ cut here ]------------
> statvfs01.c:44: TPASS: creat(valid_fname, 0444) returned fd 3
> [ 5211.175938] WARNING: CPU: 5 PID: 786885 at fs/nfs/nfs3xdr.c:188
> encode_filename3+0x4c/0x60

I believe this was be fixed by Neil's patch which was merged:

https://lore.kernel.org/all/171693789645.27191.13475059024941012614@noble.neil.brown.name/

regards,
dan carpenter


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
