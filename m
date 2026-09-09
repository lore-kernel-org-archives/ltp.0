Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC15C79FAD
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788955540; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=U5cgI1dNj/S53uW95vqV6SZUDLhxJ5v7gyaONFPcAnc=;
 b=qKREjBw6Pngto18FitL6YhvfberXVoESlTISFYH2r1MtSrdiytbcAAK5pv+PZ3b3+wb/X
 dfwRHX+8JJDvwgoTyzUHz8guuxvQXugfXoZPCH5U6dkGX0sByIbHCCyxPiH4FXxfTZYnwBQ
 1uvYgFcNyNIdGAkkLvGinIywGCLiREo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B912F3E7309
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 14:05:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8E003C2BBF
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 14:05:20 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E15691A0115A
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 14:05:19 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso47290555e9.0
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788955519; x=1789560319; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NbtRtCloL+cMBeUjsLQJrydbGkcLnuEAsJX2aIEevBE=;
 b=aKp2Zw5wafr5ECOWYco3G1h4pcoyEGTnyPUWKBT6rkdctXH+7u3GT3ke1gQyJTjXP2
 lyzz+EPthtyoq8aj5RsxH5hMkLtB1wWll9ypNP0SsoaBrM4Qp9w61JoyKDvX9Y6DcYr5
 2DjVA6QEC5VvtscHJxauKLOx4gIasjQY7nTJGNOHLRnzx9c4+n244fueH0I8gpaEHEyG
 vAtlK9pz9yDdmD5tOydvv65D5hd8PZvMbiIuDbXMCbNLsZ0StM+vnpfhj/81cTHn3Udm
 JrNsSsZEsml/JNHHgWFC3SBfIB6OgA/2EfNRfNDF4P55GWoPK9H0Xjl+DvJEeUK//um5
 9rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788955519; x=1789560319;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NbtRtCloL+cMBeUjsLQJrydbGkcLnuEAsJX2aIEevBE=;
 b=siREtPvU5AuMIHtZj1S5gX1MmMFTUT3Z6LyNiZsOQCZ0YBnf5ZFjdrJbtu4e4HK0jE
 LXpCZ5riw14DxSUBTW14Mi+HoIqslpllvC2FvpwNNQ5aeHF1slFGCeT7HtkWx1VFIReT
 YwYyQOebAbgpwRNbtgW4m6KOLUvDDZ877vcGisnRNmm0SjwWjtzsu11yAdnSNwoOjXVX
 hmKiUn4ZWS0SL/1pR8T7V01NXmuPiCJXq4/LTToK2EZrwEwW0U4PT9hg49F4MhGQVptl
 dlc9YIgOer2IzqNea4fFjKs8wdWw8DnkRFewvCiaFHVghRBrx0BL/2MtVCp4HytI+mvU
 THjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrxDee/38xx7yvoGqvc1jXlkBmHeqlZu3BZYM8U52xbdXWPmMYzzHIJe5ky67OrVuApw8=@lists.linux.it
X-Gm-Message-State: AFuF++nXHwyVcFurcWuuYDenNx0KdQFMYad0/QnNF0hHpiAkfoz+pA7b
 EnMW96T4oUg8mAk9K8AT1heUnd/vL2KZvDLgMCdFLUJu6dgcJVeHgwOhhi1EA2nXehE=
X-Gm-Gg: AYBFou1vdajVc1+v6uuoCajq7TTw4O5Fm1X78h50OD8PT8weXmHYSeMnpPNnTNcuagI
 bUkgPOIv+Zy/okmFCT5QBQVp+hqCYJjzqQTjcqcB7i3X9o2zq8HJOFrQEdZ2Stbt52zHvP35m1K
 XrHhuf4SwG6d2lVmS0qX3a/0BhdRsQRi6L328B1OPw8CmGKfp+cSxvlZOw6CnHcz0tWdCX7Fflm
 sXa5gcQ8KYMQ3RYXlDmy1usR0HzDQ+dNa9/ax+7wg4dficIUFQQRggQ8uVXsNi2zAcmJ982UR9u
 O+cO+NT4jtXYI4vRUrt+eZdxHIc1rekbFWPEPLJrul1e/Nx23BSEXI94leT1WFyO1w1untTcq6W
 xmZ7xWJnDQSip3k1+m1ONVCpoCLXe1Y1jgY3lYR/syi8+JXBvcydUK27tMHIohyi44WhaXz0EXj
 i1oD67UtcZvnaeRTvY1gU5W5kanto4SnJ0Uy5lfM+WVE+YHuTKneeYEWcbSFwslViaOM06JNYWp
 wi6cQbcDVGSa52RGD6IsLI6B6CmGH/HpCmwaBq2WhugR6M1EbegUpEsfbp5Z0A+g1agqjT7gAdW
 Wx7rGA==
X-Received: by 2002:a05:600c:8706:b0:49d:191b:88be with SMTP id
 5b1f17b1804b1-49d191b88e2mr129430695e9.0.1788955519116; 
 Wed, 09 Sep 2026 05:05:19 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20dae82csm36456175e9.3.2026.09.09.05.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 05:05:18 -0700 (PDT)
Message-ID: <6aa14b7e.6ab4d193.68f0d.aae4@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260909103552.9380-1-linuxtestproject.agent@gmail.com>
Date: Wed, 09 Sep 2026 12:05:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add SAFE_FILE_VPRINTF()
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Andrea,
> 
> On Wed, 9 Sep 2026 12:04:48 +0200, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> > [PATCH 1/3] lib: Add SAFE_FILE_VPRINTF()
> 
> --- [PATCH 1/3] ---
> 
> > +#define SAFE_FILE_VPRINTF(path, fmt, va) \
> > +	safe_file_vprintf(__FILE__, __LINE__, NULL, \
> > +			  (path), (fmt), (va))
> 
> Missing kernel-doc comment for SAFE_FILE_VPRINTF(). Public macros added to
> include/tst_safe_file_ops.h must be documented with kernel-doc syntax
> recognized by linuxdoc.
> 
> --- [PATCH 3/3] ---
> 
> > +	if (type == NT_PRPSINFO && descsz >= sizeof(struct elf_prpsinfo)) {
> > +		struct elf_prpsinfo info;
> > +
> > +		memcpy(&info, desc, sizeof(info));
> > +		TST_EXP_EQ_STRN(info.pr_fname, "coredump02", sizeof("coredump02"));
> > +
> > +		prpsinfo_seen = 1;
> 
> Using sizeof("coredump02") as the length argument triggers a
> -Wsizeof-pointer-memaccess compiler warning from TST_EXP_EQ_STRN(). Use
> TST_EXP_EQ_STR(info.pr_fname, "coredump02") since pr_fname is
> null-terminated, or pass sizeof(info.pr_fname).

both correct, im gonna send a patch

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
