Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715E9C55184
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 16:28:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 368E43E74F9
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 18:28:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 083583E16FB
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 18:28:09 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9ED4D14001FA
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 18:28:08 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2ceb5a39c48so12592765ad.1
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785774487; x=1786379287; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b8pDcR73ijopccC02+fhPMTi7FYy/uIZkDzl525GFxU=;
 b=qQ72WmjVhOQr3W9HJBUbX8i4a9VICWdavfQ6esOAmM5YnBN5+YnsrLPjZ9XyPUXw+V
 pQ/DqR64XvCVDNX/eutTkYa3hXRL6plqxoETaLMD5CLqzyJZsWS0pGpiENYZ9ifK65f0
 O5T3F/5oE5ej8LiuNFY8J6Ztx5scYxErh2fXblAnW6RPKldvPIfy6dT9RGpDygnbasHq
 moOQBw+MhK02F56ayFQgPPYaRc2MfatTFIGjeU+D99XpQMKiQV116RxghJRJNknvuCeJ
 eP1OAXJropnKwGNTiJEzbe6YjKsNqzDNPUFQFQlhlmcRrUMyNakP3P71grYa7HGOutTM
 DrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785774487; x=1786379287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b8pDcR73ijopccC02+fhPMTi7FYy/uIZkDzl525GFxU=;
 b=ZyNuKth/upk8wv+qkJAesZwN8cdlqSONVHxtaqbLqx/JlLQtaRCjbO6zHHqHFIC8bo
 wVPeDcsIkGjpmc+yednU3pvdmcXHxL3zv0ZXffoHVgntrqEtVJgf6GFcEUOnpfY9LSo3
 +GC01fVzLv7yUFxbvCJ9I+Q/gtcjQbdtJditoDRpbCtSyzDBayfYbj+cX/v4wgFhTqrD
 co9/RdOho7n2IlkT+fA4YAp/aaBU/mbpClwz7qzQ1Mk3d/amVf8xI+SlOySWniEZ9bNr
 OcZelmfJL8lfsPNxSyDqEmuC7D93Ola2ijrb3tuGxeiO4I/7dGazcv8Yu4pJOmi0EHP+
 v1hw==
X-Gm-Message-State: AOJu0YxYkta14YvaAJDGUwkacN+VL8JKYm0pg2NNKTezukE0msDHGI/8
 jD0y2SjAkwXO1gaiKszPodGtlw+7hwVUPoIdpNgQIJ9jIK5kXUX8XnE8
X-Gm-Gg: AR+sD1222NLUGaouMJw8bCmfzMCaamsretR2uyplBa2/D7GHJeatAQx1pzCWb6xY5Xi
 KbvogIe3wX/uU31HI1ou9oSh2WZSSdwyvctnSYjhBX9SzmasV6wasuS1SM65HtigRynscGhnkjZ
 R1eMiAxIXFVn4anRtmf109sN2pGhO7VKNBgI/fzR/Qt6WMwu5HyB7+ghWnj4RY5sfqHMXNDCP80
 l7Fa8pq4uz/j1TxDHi55S4azfgMuyYpocDDxjFqWYKh+ClaWqAopUuU1/OY9a+seuYsmGq6QNoI
 L0Ao2x6LO88bBIxooS+4AQrwovN1nh6CIGKR+PRcqXANAD0dUcR94E/is+rws0fwDXJmkIMLZTd
 K2c07za8sKlXWBAlEJdxfjrFxg+UoQCW5r/wlzCqSe1q+EVHLZ2fKDsQ254sOC2J+54UBIMM/bJ
 sqArK6vJhFt2+bA+iJv+p9hJ9BB+8rxmtElCuRGZaNuBGkW76hg5I9QbvxZRboIbxqCkhjcgZEk
 V+SX8/VEDhpbDAtHoa1NCuPZKbHVxwTVYYWu01AhLSybXModxXeBL/DWxTmEdrbZgjM+VYtvg==
X-Received: by 2002:a17:902:ebc3:b0:2ca:2079:91cc with SMTP id
 d9443c01a7336-2d052188c55mr115470765ad.5.1785774486896; 
 Mon, 03 Aug 2026 09:28:06 -0700 (PDT)
Received: from
 runnervmvrwv9.xpqqqosmx52e5j5jv2ft215ace.xx.internal.cloudapp.net
 ([4.242.29.37]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae9a98dsm40159315ad.34.2026.08.03.09.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:28:06 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon,  3 Aug 2026 16:28:05 +0000
Message-ID: <20260803162805.9412-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803152754.3991113-1-wakel@google.com>
References: <20260803152754.3991113-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Use exponential-backoff polling to wait for loop
 device nodes
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

Hi Wake,

On Aug 3, 2026, Wake Liu wrote:
> lib: Use exponential-backoff polling to wait for loop device nodes

> 					usleep(usec);
> 					if (usec < 100000) /* cap backoff at 100ms */
> 						usec *= 2;

Could this clamp the doubled value to 100000 and only sleep when another
attempt remains? When usec is 64000, this condition doubles it to 128000, so
the advertised 100 ms cap is exceeded. The loops also sleep after the final
failed probe. As a result, the 50-attempt stat path can sleep for 5.631
seconds and the 20-attempt open path for 1.791 seconds.

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
