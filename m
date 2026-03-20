Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BA51093180
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 07:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773991718; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=h/iyHVk8U01w9G7V0WxHq2WN6mfq/+vmZOlvpyk6WRc=;
 b=j5ohplbJ8uppu67iCArM6qVN0Jw1hYs2sZ/17hR1i3SXS7+AMe1Yi8xaTANuPtxfC+gg2
 38lAGOqtviSk+CFBgijxQdbINjapOKa94NwQNiOb5WcddGvli3pNoLOT9za2mnpl/0PzmLI
 eBhLhU71nQ848FE//+uS0+U8PQ93Mvc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20A4F3E232B
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 08:28:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 404093E1C3B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 08:28:13 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 664771A007A0
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 08:28:12 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-486507134e4so20265025e9.0
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773991692; x=1774596492; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WqkwtVsc+HQ2+NvOKn5KZ3X0nbMhkE0J5p5mIEeoF30=;
 b=f37dDBkbDQ666PyNPKSDOH/ST4BpNjogASmju2m8xSSoz/cs1KGfw6yLlREAG/lrwA
 Za9jms+63LgCfh4yznKLCXs82SMlP6hT9DPSBCP3huLFfwbzkgVbeZZ3a03vagNHQEUu
 N6xS0MbqIEClCI2wFhCR03Lvw3c8buNy0vx28Lnt2LeDS9VkYkew29hSBsBak37pxRB0
 uso1sVdLlCYeFc0qs7N0D9L7nJZ2f1eiYDqaSdiqh3xoAkpuhjXPbc0Up6KdDDVyJYAW
 gBo4849nyEwf1oK4hY6idfbwcBCepLtwrd+ayPXgbhfCBuxfX2h1UM+NdYbSw88MqVMU
 9FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773991692; x=1774596492;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqkwtVsc+HQ2+NvOKn5KZ3X0nbMhkE0J5p5mIEeoF30=;
 b=Ac3rrzqeJ/Zw5US08g1F66VheQko0r9Zn+uqVZhDkrF0fUtz2BOQDocIi4khR4qn+0
 6jk9UPVWgk9EJ163NhZsBmYCkoS/FQjvF5c78zCtpu/mL+ii0wyW2vqLkzbu+29kGBNQ
 AwDY2V0oS1mwYi09ZXokRfJYJcpHJ1DszAShzaq32siSSEeVxtzK09ZiSLsQYwZvRWkH
 o3GSV0d/1sLl6BxdAhXonxmQBPkdIDZz88jylqNF0y4xhkvwsLphNYykM0Ys75tdUeGp
 H077QGFmofUKjLqB9iQ/g+jQkHwo1yDS34HabmXOHsBcLGC+aXXisiyB0YPzFTcGxtdw
 E3OQ==
X-Gm-Message-State: AOJu0YwdNbKtOFO368kzTf+dYW8Ry9SQ5kxr1L91RXq+PKmDkAf5rotB
 qbQqxhAory2lodUcu8Cs8nHt6LAsNqSO1YCF8+ZwLm/NoKWkLsN7x8Vn68jRj37eeCKcJracAk9
 yAsS8IQ+KEQ==
X-Gm-Gg: ATEYQzwIQ5ZRk8jpL9zwkRc+jqnEdv4QGIgJWibgNk+6RajxvqdnlwzipHrk1wt2/We
 uPbEEnKBeB80wJUrd8gRGfO3TvNhxj0cUrNPZ1SZXyHXBMzX2o2wEoHCBh6h8tsCJ/4GsKOEMGr
 25M4vBcULtnxYnbm6GKws1kN3HNQkz1v1T3NGAV66q77WOU3k3e0yF0yMD/8v2vJn4XlRUbgPkz
 h+Q8WLiMd+vb9rwL0ynn5fJCQeIgwuUupivPDYTgAqMEO3DF1fyixmvf2Lm050WUlHSI1E2GWHk
 yguajVLR6oMBliVVwfuYD/WID2PT78CMMx2NEtiqsxIyCXJKDIJeNn14BqCgm2vPzapJPdq9CH+
 TM4iMMtNqIU1CamclxKJPw7CciGrLf20LZv4X3ThMbLwIqJNg6Uz9GLQ16j30mC14RuDJK9m63y
 9dnIjFxMSqeFmnfGSKqzN+NYpap1Qm1nsky8fbTrHLNcU4T8pMXPhIrGdtiQ==
X-Received: by 2002:a05:600c:45c7:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-486feddb6d8mr26499735e9.15.1773991691554; 
 Fri, 20 Mar 2026 00:28:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe032a55sm86735185e9.7.2026.03.20.00.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 00:28:10 -0700 (PDT)
Message-ID: <69bcf70a.050a0220.22f9e7.8e9f@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260319160318.6867-2-chrubis@suse.cz>
Date: Fri, 20 Mar 2026 07:28:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] runtest/ltp-aidio.part4: Remove dio_sparse
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
