Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E964CD4855
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778578260; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=tfN1EE4FzgAdaLDpr+Qy0R5JHgPjZXjDTPkRcnW0Ypg=;
 b=qEg1daApr8qxq7x/igpPAPZup7GyypPAvbVi09VGivO9QFjRSW4re5MrcspGG68jvL844
 GhcG6vMTrBnBvF2SbT6gEr+jM0SHt69Nodv8K1qJmPCmnJShrJZUGBJQC37PPVM3VzH5e7K
 qu0fY535bwR/NAD3Yo+fX1RgwRYAjAM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1D4A3D000B
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 11:31:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 377973CEB8F
 for <ltp@lists.linux.it>; Tue, 12 May 2026 11:30:39 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 86FC41400B89
 for <ltp@lists.linux.it>; Tue, 12 May 2026 11:30:38 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso37128325e9.1
 for <ltp@lists.linux.it>; Tue, 12 May 2026 02:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778578238; x=1779183038; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KZk+WdEm8yc8wpSGVXBp/RrHFrm0V2LJS8PdCE/4pgI=;
 b=WhkrzKO7jKd05v+nww3Mhi5ITMICH3hwJ/uF3D3vNgUjE3gDoREWKaYbvCSkawguEu
 qAEkfkGvkMhrANiHSuTfh6xyROEmrMjoqfyqXGabvAXC4cLUPbHAEEZ6JdX+eizckvVf
 akJkFeWZHGZLjVD98SN46PsNYzKU3Zm1BjexZhG/kIQ1qMsIjAL9LjZyGuGsqktMJ1MT
 Yy+zqNfCY0mWhrm5WXScBYADka4OTeaQZ9OZ2+SQdHw86xyBAEJW0659ge8nExGpz2ao
 IFCWzeT4eAq6c2Vi8ofxro53KYywZImo8fs2Alg4sDvoJx3n1dKCq4x2YCSiCV2fnvP9
 zEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778578238; x=1779183038;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KZk+WdEm8yc8wpSGVXBp/RrHFrm0V2LJS8PdCE/4pgI=;
 b=NcMZyuO8o8PIBe6sxzHSJLcg4RlW0ARvvVmNy3x28Y5c/DRnCW8Wbiueh30NxE6ieM
 ROMA1J7zC4F+bP584WuhQujTx1fU8tvwrgOWrTSwvLM6lC3YnUg2XBuzQFSIO/7xu466
 G/XhhRf8Hg+14IPEH1VuyxA7tMVVIkP5ZT2x1nZxaAtqlYNu3b0iKVnONe3TQTslkHwa
 f3ntYCacb+IskZAsV/W03T2vaxL7JgSLLDGo4s2tnRTmWRN7Ns/miRJAxnwA3O6pcEEM
 G+drH6qNJpxyv8PYexpPfIl/Djfo+H1wspX7+GAERpbpBAQXY3V9OM2BJQtfkm5IgL/a
 REQw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WlzC1JF3uhS8iebY7jKOblTFJ6r+dki3ZZZsAEywrPvaiRttslbP0LdPDUce7lMvdnro=@lists.linux.it
X-Gm-Message-State: AOJu0Yzw6E/Giej9VJCaEiUVPlc4dJAVBlC7FfT7GjId68SYyan7r7ru
 OHu59TIC2NhVURXgPktrbAZjEhRUXhf1hOKjJLWJN2SFZnv5Tb1udB0fLNlanCjesfWt0kF/k+j
 +wy5cQrw=
X-Gm-Gg: Acq92OFthfluxJrE2UI2rSRUaaUF2U+1SGNVbM1YWcUiXnGVOd1V84yePuJNIf54WIN
 7s4uUAumlyHQKn6Q0JIbBJrNwXk+x27iiVBOpduYovTZGzwK5Ph6thxJfUZFCC85LqCoxGXVQiy
 1bAFGkbE8R+RJU1Ff2ubej1h18EeWJsxRVnRo39hBx1DBZPwigIXEPqpXzvredT5JDqRVHOGpli
 oHIWFy9RxNynmf0bLAuNxtPJk3hLhV6UdEimcxvtowvyOvUS353zkQR7kcgQZgb01xbqWfMPjkf
 kMrNqTjpc7begSdvqWl4bybKmEENJU8F7hiqrUBVJltYZIlq4Kf+q8eCQOpaian7cEKSpx02DGy
 fNBjoA6I+3CAkHMEoB6xousJkgdfGYtxB81Q/CavgOsa/F8KJtdkl1hv2XPBznRg4G55iER/WIC
 MM42Csu0BW85j0TJ7/jGSrQY9lIir935p7xux82dNPmBmFBoEg1i0kNW7fuG3N44X2m8zOlXA/m
 TG7L7gsk1cqrzTMgDxw8/8SkUnvZ3+ZT4o6KSF+kTHKWHCoQyubiFFtkq8Sr0NmbfZ7onl6aP5P
 rQ==
X-Received: by 2002:a05:600c:4686:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-48e676b6882mr288660925e9.26.1778578237648; 
 Tue, 12 May 2026 02:30:37 -0700 (PDT)
Received: from p200300ef2f4fc90038232d0ed1260eab.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a66bfsm27565834f8f.4.2026.05.12.02.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:30:37 -0700 (PDT)
Message-ID: <6a02f33d.5d0a0220.4a223.8584@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <agLxLVAPo293qE25@autotest-wegao.qe.prg2.suse.org>
Date: Tue, 12 May 2026 09:30:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Allow 0 return value when detaching or joining
 joined thread
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> On Tue, May 12, 2026 at 08:18:21AM +0000, Andrea Cervesato wrote:
> > Hi Wei,
> > 
> > if it's ok for you, I can merge it with Signed-off tag.
> My patch has Signed-off, i have no idea why AI can't find it :)
> > 
> > Regards,
> > --
> > Andrea Cervesato
> > SUSE QE Automation Engineer Linux
> > andrea.cervesato@suse.com

--- a/nptl/pthread_detach.c
-  if (INVALID_NOT_TERMINATED_TD_P (pd))
-    return ESRCH;

--- a/nptl/pthread_join_common.c
-  if (INVALID_NOT_TERMINATED_TD_P (pd))
-    return ESRCH;
-

Everything that is after --- is threated as a patch comment
by the `git am` command, as well as b4. So after applying the
patch, agent correct seen SOB tag missing nad reported it in
the review.

I will remove this comment in the patch before merge.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
