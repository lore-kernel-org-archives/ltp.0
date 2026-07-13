Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AED5C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 12:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783946080; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KVUsUAg+xJwvBQbcaWND4Zmm5h93dnq0zHS4BI8Uy18=;
 b=iaLiS89WcPTVzyDBLpCbCEeP1mdAufSM9sF4cSVbB0Paln+E9QqDs7UrPDBQVZgkvqala
 dkVxAPp5qLg4Jg9zpsFtZBjyj3hfSqrJY4FSN2uowOXWDqawdZ8d1F8PPSio6MkDQiB+OXp
 DEDC7v/5OLdIrI9B/VbcAXCFPP3tz3c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01D293E266F
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:34:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC3BD3E266F
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:34:19 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E0BFC6003BD
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 14:34:16 +0200 (CEST)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-39c9452243cso27936361fa.3
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783946056; x=1784550856; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mCjvkgH31ArW5AucClOvtjxRu9KsUMuXSoiKb7uiw5E=;
 b=V6o1THkfDtFBF1oBiG/dVFzsrfCW5D0fc/xSyEKlwFyxrzcnJ2JtHecr2SiVSxck2z
 lJ6800ZG0ZlncJAPAMibVVpl1ZCPZVxNnF9ejBty5q3iMdmFXC0wqtODzmtRrcWhfAW8
 wEH4Kc6gBaAfCVUnpvSNu5qPoRAOboZdKIAF4KbYBZgHiAjLtcxvL89v9ajOcBC32oQP
 BE14RSpnDqtU9Ld5jnyc4rLLvd20BWP55KJJ6MWr09qITkozmsmWyVrv6TQouBuHZIL3
 p9lw5ZM3AT6UMjoH/FkcNIoh7MBUoM3mnDQLwQ6p48nIUSj3TRPD0/j391Fny98VNGnS
 UpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783946056; x=1784550856;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mCjvkgH31ArW5AucClOvtjxRu9KsUMuXSoiKb7uiw5E=;
 b=hzxp6iMck+BhKbSfGtEjQ5IM1BKFFJ+Wpav7TqpYv3BGcCKqhLFnF5SdVHQIYGYmqL
 aPqDH3M58SmOGP+97cUEvdzKysGxObX5PwdepSIrIp3XxUjz4RpY7c5iwXos0VpGOxm2
 nwaCQ1KGwyjCMxC94u6xvLM/5wbUsteFQ13RbvnI7Adbgksk2u3wrdJyheUT5l/4g7MG
 H7lK671TtuUv8wD0dW7aAKrgLuGVsxmJyVWmURrtx9b0EK6dJZtF5McLB5eX/X7xn/Dh
 PXhD7sg61dI45U6Up7w8lx90rdwGcFOWcNVlVplTOyqvTFAj7hhba7mMQifHg0uKTkne
 zzdw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgK6kECleHHFM7urF9oVgdI2/2UHaEJPfv3iu82vfnb1KQYl/MMQdUuusMeVsbrh0+X4k=@lists.linux.it
X-Gm-Message-State: AOJu0YxhuyPNKnNTUNJWJgmz/6KqEdPHegy2ZJ4UrYNoQKFyd6D3E7LA
 pMVsbfeWkm6y8ICyjTUTYoZJZ1RtjEGoooQmFW4keNd39gkv5sV3VBWuIOgW/coxvAc=
X-Gm-Gg: AfdE7ckSMITbO+MJqNj351C1ItJvjCeF3yz1j2YzFItExXGxKWA2ahQ0w7WsaXQKO8I
 H54lzuUFsVkHHEJWQmOZP1uRHPb6Pr3Fyqc8MoNQF2IETuXnp5TTv2ei6mRWVgkkJvbQaafj4y/
 9Ab2TLobUn61cGpSBAxYiRiJOJw8fBIkayu60QbWIRcOtFVpUgLmNCLdEK6qgKvuKVblghKywlU
 l2z1viQdN45p0YCHo5UMGvsqhNLTNY1uer9fT57oItx6bPodrflHazN4aMnWtPdmp1tDwvzO5hz
 SlxCFauXdU5wlFKqewYl0iKnL2gxmw2FzXUb/aiYz1tMBq28yakPfXpgWi1meZLZZgjMyM7uiyF
 ZiTNdNT/DmT3ok2ANO+OpIKmAFxZvIg97zPAOH0+PpUDra724ltt67VFpuWqKEqEXHNAZsdIKLN
 Zkk4kfAmi5gcp3eA81bsA9ixO+TOWLAX9i
X-Received: by 2002:ac2:51d5:0:b0:5b0:f9cb:2979 with SMTP id
 2adb3069b0e04-5b0f9cb2d0dmr1687340e87.15.1783946055887; 
 Mon, 13 Jul 2026 05:34:15 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b01ca54fddsm2792048e87.33.2026.07.13.05.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:34:15 -0700 (PDT)
Message-ID: <6a54db47.575b0a19.360f85.5cea@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260708114106.GA812068@pevik>
Date: Mon, 13 Jul 2026 12:34:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] cve: Add act_pedit page-cache corruption
 test
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> cve-2026-46331.c:198: TBROK: Failed to modify traffic filter: EINVAL

I think it's caused by the wrong enum fallback. I'm going to send a v4.
Let me know if it's fixed then.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
