Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BFBC55838
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786003323; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=T8eALSB8kdwXJWgWvWJiLe1AMCCUrq42m1za4AIerXgSk7Us2u+25oe01QrW1Le3caKNa
 tFYrgNoJVPbSo/SD7VJ4OLBlB8tho+QOq3vD1CPF9baA+HOY/4lod+qVP+uYVCFplgPyfiI
 DJ+tZVviKTKfJme3rMY1cCqrfC5wLKk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B57853E264B
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 10:02:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 787BB3D064D
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 10:01:43 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 69DC51400429
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 10:01:43 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c197eaaab00so294863666b.0
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786003303; x=1786608103; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Xuh7B9QVRdtpX1iEvqDDf1oQOCO4sIOKRqw3h8FWcsc9VRnvQheB6+0U+hzeGVmFg0
 pZ1i4Y6vJY3YMwnppoOWlI+ku2GmSc3MFKLjsalfagD3m33GhJr4Yn31dokZtGT87s7w
 MWtvHfM5T4ouPsS2DZz/l70RRutJ10MtccvQGfu2OQDkFNUWtNYhZjJXKD6VlJYfFiZf
 Jo8bzdMUvCSIGv68Z2g8AsIXBDANMbhAZbqNQmZ85qljx5yme1N6nTtNi8tP5FdyE3/v
 fN+YPZ3oHmu7TUPUbzWWUPTe5qdRiA0zoJMQA2Yv9v778uXviwpegFPT5yNMVJe4YA6O
 JNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786003303; x=1786608103;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=bYuBYwlHuh0/FDAyrEGZWe0zrZv1LEDUGsVYDoLiRzMOWjhGiGNOhKC/kQNEvmNKIP
 OtGegZ6trDJaxur6Uj6rxzyxMrwls01RFJiCsIDZqnQFRl5bynmVHoyqYcKYeORwNWCs
 uVXSW1QgTAIfQ09AfviugCh+y1DHczOYtr0g/lM1iEfcToE0JerZNz/joPTM4MAQ0etG
 HdP94/wYCN8+PYiXbv0svqkig5kRqqRpKgzdMos8gFrrUtk0/waj8HtqcInPxJbFrBj4
 wXk33p8XSxazCsqA691aUXhbPX1BDQfTuwXvM3e5tIlAADpoNemxmbqRTVPNUMov5B4w
 jWXg==
X-Gm-Message-State: AOJu0YzziiXESDgDzBlOKYedbneXtvV5u6hWpvIdtlARewMT4XqyA6JL
 FkYAjgVWar5HMVkydLghACbhG9M+WfygElahSd3MShsuOEf2laTM5XrMDyqBPEJG/f7f8JKxH7W
 C0gbKmW45kw==
X-Gm-Gg: AR+sD11o5mw2maUkGaOBP2Vho3gO1qWhznQBokmDOhMTGtXr9zIw1u1eN66OLjyIrZy
 leQrf/yhdMzDbuxly7suZj2knDmbXhDld4dHMdM9Ie4A1UMBVrtSxqT/39w0M5+uwt5g2uXLUf1
 0+Gq2Mm27H8j3iIvR8kk6pya7FDK5VBu2fu6XHwpS9FWkDWsly9SqERhmoVMRCD7zBoTsNksckE
 NXFExzN1SW4MW4EYXzAMJOQM/9eHfWdGZ1QUw7tHnCgtqOj1GuEv71Z0ezYjwFJVeFX3j74lHRD
 K9NYhDfsK2aF4GxKKceIdVYczpNAElj5mmNNgV5rCU8yAn3aBbfrGM86E+rBVUpspc7d58qODlF
 VYKmc9q927b0gb+nVVc/WpQ+pVtfiE8xSbSICUTosAkZNaa1oCq0YtZmPKAdmp0DvWyyeggR5Wn
 aw1Jk34IBFK4cyy8g7BI4nSSp+MxbBogCrL/1w4/y37L+QgQinUe3rRFKRPlvb8C2MNlyBLYkDN
 k34R2GHf08gPYBaL3w/9CG1HEQ4yHNujw8IUrJuKNzj+cbrG/PhlwBw0bevTgzV25u6MMOE0pPO
 Q0WOS07MpwBy3MVaTIwxTjP5Cluw/UMjr8I9ClwHf+DLLrjA
X-Received: by 2002:a17:907:3e0e:b0:c19:fb6e:5fec with SMTP id
 a640c23a62f3a-c2039c39840mr668930166b.18.1786003302621; 
 Thu, 06 Aug 2026 01:01:42 -0700 (PDT)
Received: from p200300ef2f1109002813f5f2a1fe61f5.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff79a728esm4351671f8f.7.2026.08.06.01.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 01:01:41 -0700 (PDT)
Message-ID: <6a743f65.a02854e2.1dc6f5.e4b5@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260806070625.19475-1-chrubis@suse.cz>
Date: Thu, 06 Aug 2026 08:01:40 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap36: Fix compilation on alpine
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
