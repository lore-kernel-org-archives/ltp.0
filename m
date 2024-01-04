Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E91C47073
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:22:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EE183CE718
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:22:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A0A53CB53B
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:22:32 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BD8A510005FB
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:22:31 +0100 (CET)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50e8ca6c76dso1053475e87.3
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403351; x=1705008151; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uuna4ey3GlskxDV4xJnO/zAE3WC5mliaOnNa6DiaHU=;
 b=iQRNBUrobuIPuYBEdnn7aa9arlfv5+qo0JdD8GTkV/LQWYWDDOaeiOURj7yBpZiMAq
 bSY3ZvYAaguBjIRGed0fCI1x+v9EIgxGGIId55rtGh+C78+pO0D1dmeCU8vFkhw8GOXo
 C8w5Lj4t8xuHFO8RlAn0LWZZQQOI62I2TTTMZga2K8StnHpvatfCxawdMxyj/0JILDnp
 UpwqDRqBYZrl+j4GFq700r4x3i4olRZmVsxDUjYZzl8fRvCI+cNCLLTer35U420AEwbu
 /o2gE8a6P9UIJeq+0bjql8xu/tzRCoTTwwvUd681H34sMaaWUn1hJS3T/8xF6EvwgaRV
 eS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403351; x=1705008151;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uuna4ey3GlskxDV4xJnO/zAE3WC5mliaOnNa6DiaHU=;
 b=gaSG9tUC/Uj0lV+h0Ohl5B69Wqdzgc2MDRftNYdLoQkTP4rJUQHv1bb5kpQYYFD7xR
 KCKOs976JLAByZdb9E9KExTPpc5+55jjUeYz9FzMRA3c7sQ7iyoberNGEdn5CaUMQeTD
 R/KkwQGM3Y+7NdTDDLTbNpli4ulvB35tsd80r7oF38oXTgcseZL0gAnFI7Qqu/9fimHt
 0MhSgOh/b8OqiPfUIByrEEZ1jy6zuVxm06NIv40xi2FcMSoAuWmynK7EpvCxglNHnHc4
 ipQlHFuE0w2qrEAuQ98yUdAY6YYlv/9T7gzsYeo5v9+anSCgBegfCoYyf7w2p/akOvfS
 XjGQ==
X-Gm-Message-State: AOJu0Ywzoo8hgm1+qkfpX22mzauCM3Xu62qWAI+so/5VaMZuRUzFlres
 WH20sGZCqdG4SInYn+RRY1x11JuYNDyMsQ==
X-Google-Smtp-Source: AGHT+IGjHxyQr3Oq4J9LOESjVjJ3KYe1Ru4sr0MPoJnWkxcQAVHV9G9JrbMxew1VaRjUF/FBvT4aqA==
X-Received: by 2002:ac2:4247:0:b0:50e:84a7:b49c with SMTP id
 m7-20020ac24247000000b0050e84a7b49cmr584871lfl.130.1704403350921; 
 Thu, 04 Jan 2024 13:22:30 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 j27-20020a1709062a1b00b00a28e1c420a6sm80624eje.171.2024.01.04.13.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:22:30 -0800 (PST)
Date: Thu, 4 Jan 2024 22:22:28 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Message-ID: <20240104212228.GA1438029@pevik>
References: <20240104211654.1437671-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104211654.1437671-1-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/9] metadata: improvements
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I'm very sorry for the noise (I sent part of this patchset 2x).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
