Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B663EC5DF9D
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 07:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787814485; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=2b4NGI21cQHf/WkokvyhnUXDcQ2cvW6UMBfpYW7PKu8=;
 b=koRDrygOf6F1oijKNW3Zs/A9RyLXmJkNb/XtibbdDtUHvHNljx3XKY+MUANC5TxYqPrDr
 NZnSATUnq+bjEyI1wH7dZzq2942CEy4ySW6pb9lK+kGW1UVdbEefnvY9mttisQxpD2IlYYU
 3CSbe764eokfxLQBxjBKnfBX4w7E73M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00BF73D0F92
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 09:08:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A2783C8484
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 09:07:45 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9CE03100044F
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 09:07:44 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47db714766aso441357f8f.0
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787814464; x=1788419264; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jgm/Bt0uENZOZamiY/85sukbmnoUlJXY+J66QxyzlAk=;
 b=hF8qyXK2urewxpurbgTui5ARSJR2pyBkQMYXhmKTnPs0ma3TkyB8YNIRliMy8vxrpg
 xGXHlx93BjPkKHW8ZmFXhu/AOstuF0nM1rWFctxTUuRHq4Ov7rwnNZRNqlDV0yV0JjXG
 O1OPC0t/8Ake52Q3Uw+2bIQE9frOO1ig8lPyxQfzqy3rj2iVos++fx3uGzjr3Fty0o4E
 lTcoiu+DPOd0IvddQIZp8kgL0DGxmfQv6NP1GO58/PBtHxXJ41coDbztyU4c4izvWjsT
 eaOIGgmik6HLfvbmv4rCuW5yiMSHHUcHCtnOSRmNrj/P/pOqWAcBfRbMdAFa5Awtnbpb
 xdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787814464; x=1788419264;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Jgm/Bt0uENZOZamiY/85sukbmnoUlJXY+J66QxyzlAk=;
 b=VShzgp9oqMCflUNrrq2Sbs98mAQoaemX6GQdmC5/EYi25wZyBL2YmboIhaiXUj7wwV
 nRoAHKm9e+4zOYPbhLQr8RksbCBTDKFtctMWMlg4of4H6yW9RYPM4R2eALmaODeQU/3m
 zeKkM5TfCSEu67Q9E2rVHyW+Yfa+w4JWgETxfeb1LZDUu6WZ5veDjxA0yxLMY7F5uRnb
 84dwCd6Gc/qvNqiB4j8Eya9JoqZxtZmwQ1aVMjQ7oc64vMXUuicIE+9sK0kyN93mLFuM
 U8H5+cjGcuv2KdCmbOiUGcG0bJO1qUq3bVQgSJqTRpyCl+QikU7vTkHrUaZ11ZlUiNsr
 sAtw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxnzFtCP/u3rf2ISJS406DEqWsq4EofI088SyLFZzJAhg4fz19tjYWryGs6sLnugclOtQ=@lists.linux.it
X-Gm-Message-State: AFuF++lg0AF8bIqZuMJTNaVBa/7+740F39+u4LuQ1NbfsjCPgO8Fa0ZV
 grBhaErG3ZC4QdlgrDB7svLqnZEKfxTl+vcllrMORxW6xpK6SvaPtXy1CwbHleGU5fE=
X-Gm-Gg: AR+sD11aUzFMHj3aN/14goQ/q4OfI1I/rZ67GA3FIxFVUSZ3zNeIVml3u2MM3CoFkhC
 2t8ttPRSd/w/ZQPl8HEzmPXDOjwoxB2DC5xAqJLV4xBNJv6kTAENylF/kMVfG7SQA05/tNKZgmH
 ytAG0sBEgAR6WE/Ij45MK996QHNDhjN6Whlm5FjlRjfeMj1VaUCH2gPNGmrvwP8M7WGqxoJbBDL
 r4ZCYH3SpOxa236+d4RO1L/JhUF/g+J3eUV0lTSZstsAaegKK3jWuDrifhmDEWWYW8T7iXVyvW9
 epfu7tKRAeGWit63WC8qdTSTIMxdV1NUoqnOKGhL0w60kkaRoIswc9MKuxj+d+z6kLSfDPJSqgS
 mQhoD24kcUrJHNzgzrEJlaHOf/ChuTZULlpKAo3/HC+oP1hsG/oWnsH+wHpuubNqCxz2RXOYYeY
 A96mlXjeLtRCeVA54MOunEVj7UiHqVxqoPtN/9FaCeW39eSf1hGB3Va1YFjXnvaPORDCyoJP4SV
 tHKvfHOAcjePgygWwgq5F3U3gFz26GxCbsueJt9SY2F2dH1VvzgYOAWU8753L+ikCGWPoE=
X-Received: by 2002:a05:6000:2201:b0:47f:e7f7:370f with SMTP id
 ffacd0b85a97d-482eab9f5c2mr4973550f8f.10.1787814463996; 
 Thu, 27 Aug 2026 00:07:43 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28f6119sm7011036f8f.34.2026.08.27.00.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:07:43 -0700 (PDT)
Message-ID: <6a8fe23f.be490abf.117ecb.9102@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260819103310.39525-1-linuxtestproject.agent@gmail.com>
Date: Thu, 27 Aug 2026 07:07:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] openposix: timer_*/speculative: Skip untestable optional
 behavior on Linux
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

Hi Avinesh,

> > +#ifdef __linux__
> > +	printf("Linux does not implement this optional behavior\n");
> > +	return PTS_UNSUPPORTED;
> > +#else
> 
> Could these branches be removed from all eleven tests? Linux 7.2 uses
> scoped_timer_get_or_fail() to return -EINVAL for invalid timer IDs in
> timer_gettime(), timer_getoverrun(), timer_settime(), and timer_delete().
> The installed man pages document the same EINVAL result.

can you please take a look at this?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
