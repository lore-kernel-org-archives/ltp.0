Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46E606A320
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=klbYXgTG;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=WDz5QtyX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795093314; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=G1ZDuzTla5uspF/97MtET8rWylhpyfLVVSdXO7V+mx4=;
 b=klbYXgTGihHtI8lHAiLZnp6eRv5cnwfi9NOBecqPQnjXff4UFeks2RyDa55IAFYP2xFGj
 2xZoW/WQwhLI4k/CfbdsoxyAshMaE7dQdMEAz6pJwGxiElCBczy6fOfd1E4SbdjWKTur1WB
 7CN7ugrqKwx6r5a2HAPhRrfAOR5OkDE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D6B03EA008
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 14:01:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDA2B3E2398
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 14:01:33 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06EF7600A29
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 14:01:32 +0100 (CET)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b8b20b2538so1871610a12.3
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 05:01:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795093292; cv=none;
 d=google.com; s=arc-20260327;
 b=nR3lrXeBH4DPIEYMEfVW2naB0tAXKT8i94QIg4Q8cv/qsBlYwgFyfgfvcWCV9QUZSX
 ++JQ9ejlocDOt4u19MMb4/yByWfxzRAEfPkN2OVFe7FSkp3aZaqI7MNVHayh7Z3VXFVT
 uTCdof4eqRESCk+j6Sp0WUi+Ab7GeEW0qN8mt1aLN+MAP0xULn1WXY9VTTm+KKF0gkI+
 eS/FIam9hO0QKykX2VYRLkaMfcsR79/MfA1qEoHyus7uMbYyaMFyq4dy59n9zjj1tOwS
 Ea9JQ2+/KWj9TMgXZHnwU88Gs/XuhJw17GD3gCgKybyqm3UTLCHJwB1cmCtv6hROe0c3
 plyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gfVaVOaUXG08/ZKbgV79iR04a5Nf4TltLrYMX/SH6nU=;
 fh=NYWoMbyO/aDAi3xXJVbGUsABdVCG9A3++E34W6l7Zss=;
 b=nYR4Ch1/Y6JETITgryRx1wI3+kcdRauCbIb2sWbdk9HRTm+TV+NMlkg+051idK/Ihi
 FFGio5Y+cBszYqcWPvhu1pdxwHKCqqeLhbkm1BeVkU9bn4Punq2LvquJaIlLgUfbVT2a
 tWKKZ1lSevE+8eMOFCv7Vlx/YqskA3nXqLKb+87zkdvq6bCaT0nsjycGpG4eNkYkWERR
 BNx8/3fKJc1Rn2wJAtMDCNJgBs8iljGUhVmUP+yhJO+XbYD31c4Ypu4BOelmwRyRmQBI
 sFWVP9dzrq2aQWhTkt8d6LQ5Gw+xOv20KR4QZ0n0tJVkwxPDjTXdP52RpfvEuH3YePx6
 CNfQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795093292; x=1795698092; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gfVaVOaUXG08/ZKbgV79iR04a5Nf4TltLrYMX/SH6nU=;
 b=WDz5QtyXUXrXnaOs8kF+CK8pvMmuoL8kCex9cOHxIWWuGDZU+VbXNCjypnA9QpZsJ+
 wqGvHXLqN1WAR/U8X561vk9BA7NmHzP+qWJCL8ViDeXgoSa3yZJJ25KgBG182jP+odZT
 nrXnrgtidlS3GQ2q4KD8ER7VhsmBnpZFleSykg7kejz+yAaXRcJDw6ViBlcPbzKCwXCl
 w0l904h6+PMdthidLLyHEn7qnlvNV/9seySFaGWBfo78WZeSUqnnpYvVcnZDx7oylNde
 4vexZrab5G+0DhX8SVmv7zm1IS3u47hz+QIsBS+F+KBZ2ObvY05q88Y8ZM69NPr/cuy0
 aRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795093292; x=1795698092;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gfVaVOaUXG08/ZKbgV79iR04a5Nf4TltLrYMX/SH6nU=;
 b=Jj3fKgvE63q0H+gVPi7PpE2mTKlEqiUHqK2m9G4bNy6uZkb1o2fo3HZZp32v0npd+F
 AuafP8GEVNi6IVloHJJqJeFMjHubi186or0uqfwmL3rTfMxO660rpzJIPwctAh7QE8SI
 h3vceQAeAdn2ZDC79tPqFjdAPByO7aRqiNejIqlKPYeFD9x83zieDmWdrlSibU07rg3k
 nkMCfFbNkGY+V8yb+aKk2AAbffnHyBE2Ds8CsS3wn54J3erPrJjB5Pgm0zgg6D+XLXxm
 PI/zzz+VupNy4LxBx6YYPOW0BKYr7W0JYhMIZzAyh7vSNIfOQXpuU1K6+42+OvQ8yMS/
 iSxg==
X-Forwarded-Encrypted: i=1;
 AL+hErHMsO6Cu/BLBW3XI59DvFjXyuL0b2fNWJFiZt3Wfu8F0ckSXs6zDf3OzPsZdOt8bqwO2g8=@lists.linux.it
X-Gm-Message-State: APuU4Z95awaciwkCXlgQma6XzNwtZL7GffpHiPuAFeQmCoHi8NmTDY1V
 lGLU5gO4bd0rFFc75Xoc5Jp0VdBlzv06qZq5WEoCihHfkMfUvUbTJNyUMcTYNYyQJGQVeTuiYMD
 pKlQ8C4qOg2+LMpl8jNt2y5sFbARt6sP9Ey76Xr5O7w==
X-Gm-Gg: AYBFou0WRntsKDA4Nk55NWhG39NqTZWU9yNfbW9g/H7W6C+hNzq5UfCQOj9MxuIR/Df
 MeYc/yKcAiIaIWtECndFs/SACTdu0dAn5kRIckXP3jH+h7ny03SFb4laj2CMs6Gy9Uzvqf4KFGR
 zQw0zWRl0kpWxObCFhmruIkwZwtIAtTlXWE2V8uF4bSuk9sM89LjnTymmBKjHxsASBOfWVA+vfW
 NZaKiUJImNu9nd1FOFL1xV8ZRBowit3idt1MNRvl8sMta0t2FvzxGI2yoS6LhcOpEQ/3mT06tNZ
 YkBbZVDg/nFMiJJ5JKNNKwMNSzAQXrsv4zbJ58zdTj2Lchcp+5W0pan14qSRstvwaBBtazxuP9F
 yJ4OtoIKcb85MIhxdq6iptUSB1tCINqjzqUH5PA==
X-Received: by 2002:a17:907:1611:b0:c41:266:68a7 with SMTP id
 a640c23a62f3a-c510e22ac27mr539976266b.10.1795093292184; Thu, 19 Nov 2026
 05:01:32 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117125658.1743505-1-wakel@google.com>
In-Reply-To: <20261117125658.1743505-1-wakel@google.com>
Date: Thu, 19 Nov 2026 14:01:21 +0100
X-Gm-Features: AclHuK9-aePwii1_lSieQuY-0NpTAMg24dQl6N4Tsvf9fOn1Mi-m76W2NHGC2tI
Message-ID: <CAGp7zX6g1F04g50OcY9L9JVt0jH7NdtcSPtNXjtYSCs98=y2fA@mail.gmail.com>
To: Wake Liu <wakel@google.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode01: Drop redundant 512MB dev_min_size
 requirement
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 11/17/26 1:56 PM, Wake Liu via ltp wrote:
> Commit ecf418722780 ("inode01: increase dev_min_size to fit the peak
> usage in parallel scenario") raised dev_min_size from the default 300MB
> to 512MB because mkfs.exfat defaulted to a 32KB cluster size on volumes
> larger than 256MB, providing only ~9,600 clusters on a 300MB device for
> the ~10,925 objects created across the 5 parallel workers.
>
> Subsequently, commit 4bf4da8c6fda ("inode01: Configure 4KB cluster size
> on exfat to prevent ENOSPC") explicitly configured mkfs.exfat with a 4KB
> cluster size (-c 4K). With 4KB clusters, the 10,925 objects consume
> under 50MB at peak, and the default 300MB loop device provides ~76,800
> clusters on exfat, which is more than sufficient for all supported
> filesystems.
>
> Drop the redundant .dev_min_size = 512 setting so inode01 uses the
> default 300MB device size and avoids unnecessary ENOSPC failures when
> allocating the loop backing file on storage-constrained systems.
>
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>   testcases/kernel/fs/inode/inode01.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
> index e7190fc99..09e0e9da0 100644
> --- a/testcases/kernel/fs/inode/inode01.c
> +++ b/testcases/kernel/fs/inode/inode01.c
> @@ -260,7 +260,6 @@ static struct tst_test test = {
>               {}
>       },
>       .needs_root = 1,
> -     .dev_min_size = 512,
>       .forks_child = 1,
>       .needs_checkpoints = 1,
>       .timeout = 300,

Unfortunately this change breaks things on tmpfs on systems with 64k
pagesize, as library sets
        if (!tst_test->dev_min_size)
                tmpfs_size = 32;

tst_test.c:2005: TINFO: === Testing on tmpfs ===
tst_test.c:1305: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1281: TINFO: Limiting tmpfs size to 32MB
tst_test.c:1317: TINFO: Mounting ltp-tmpfs to
/var/tmp/LTP_inourxWrA/mntpoint fstyp=tmpfs flags=0
inode01.c:241: TINFO: Testing single-process small tree (depth=3
fanout=4 repetitions=100 workers=1)
inode01.c:228: TPASS: Created and verified 28 objects in mntpoint/inode.5861
inode01.c:241: TINFO: Testing parallel larger trees (depth=6 fanout=6
repetitions=8 workers=5)
inode01.c:61: TBROK: write(3,0x7ffffd679118,73) failed: ENOSPC (28)


so either we need to revert this patch or we can do this lib change

(lib/tst_test.c)

-       if (!tst_test->dev_min_size)
-               tmpfs_size = 32;
-       else
+       if (!tst_test->dev_min_size) {
+               /*
+                * tmpfs charges its size in whole pages, so 32MB is only 512
+                * pages with 64kB pages instead of 8192 with 4kB ones. Scale
+                * it to keep the same page budget on every architecture.
+                */
+               tmpfs_size = 32 * MAX(getpagesize() / 4096, 1);
+       } else {
                 tmpfs_size = tdev.size;
+       }


--
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
