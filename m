Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C10C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:50:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1F813CD7A5
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:50:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53D7A3C0574
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:50:03 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ED62A600090
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:50:02 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38de693676dso1207001a91.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787212201; x=1787817001; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SS9bxz+t9TfJwvhacYWZzpcbobeiCYJPCh1I34Zy+fk=;
 b=NBRYWHiqKe+ya0n5OJYuzfxXx6bEasRqF9PvTRx6UgI5+D/zdbDd/uHL8lH678bd2z
 x7DAtkUGfx7T7Q+MOWUBzjCbVjzur6nyp8VroaMAQikMLxZpdo3nb8qhuXvlDXl5OvQR
 smnJOsFB8o623qpNjGod7w4DSPxnAQzIsjOgLNRErQ6Hxw9/JfGecbh9RlauMQFOdP9i
 o8onHg2B+vVwQMmMZJH4Zz4reJa4EUmbfaTEeLyrayFE7CQRPiaPVn47ljUbAHLKlKAM
 EoBd0QPGajcLbI0qNoKbd23G/OVjHfU0n3YjXkm4f+IMamnx7MDCT34BEdqEkPFVIOzm
 O3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787212201; x=1787817001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SS9bxz+t9TfJwvhacYWZzpcbobeiCYJPCh1I34Zy+fk=;
 b=JuBWAuSbR1uJ93VBArcTx/07mZqmDn1khMc9O+6767+PblZJfE2Nb7IiYfDR/UAxQz
 JLdFKW2+2UQ9lNeU8U73R90+xSbRS4wslnUkZ4GraAtDF1pOzJha0JL58aFpzg8fRSm2
 oCc9sfVg/ORpdyX6T8FGeXUa2ycrWMsACUsDMMP6xINy/lEO1+1NEZ9xXyE7MfUPgmaf
 Bl0wPwSYKx6vg8jwDiQew0LbHR822ttw52Qw6Y6F1W3VmB0Q9Guv27Ct72/G3wAxj9Ov
 t76wSUUAJO9ofnz1k6LzTFQNJGfdl8P684nBp6KdKi1BzOAZNjwUKWeUCPDFFrT7Fblj
 +wcw==
X-Gm-Message-State: AFuF++mmxn4IeRUD3y5OUijhAmpZjUlYUSv1OGHrZsf7oklrKvkWcqnB
 nfV0QMCgvmWsURX4WMSYcUqypvqUx+MTtKMkoGdsEB3qhjGqnX3iYrKvZqzoJRGb
X-Gm-Gg: AR+sD13FHrfHxY3v9pUcXr5h8uiMLjJScyNftAY8+wfOZq7n1hmL3EvJ0mtgs29NDUv
 4UeQre2w/NqycXc4Kg6Wd7sQTpYleXFUhjsRB/6EEW+hY9fR+vDmR5d/uwcqrtrlOg7ogNvqHza
 jfQpHjpea4pPSVEaBoV+byM97x+TGHMcwtjpuylMNUoJ5tKhwYouNvxBgwX4LZteMRzjYaf9GiM
 JwQvGzjpldeVjf8EtaDVJ5pvhBt0Tzt2OTqbKBzbvo5RT9APKrxePo8L153/WKZ8h/BpPP+pBgu
 OiUDifdLNxpkViEPHRr9RlQUrhDMlPDTEMKjoGlWHY9BqTEvJhg9AyjdFMZkysquQdvV86GbmDw
 ZamC5lThnoiw2RX7fkLTRJILRhKZAv8cMFrIQcCSg2y8JWrpOYIrPO951s/ifT+micCNsoQho7a
 SNF1cV1EWCeS5NhV9SDwEWLlOEZ00/0d8nkW8eb0DlKf4CVMFMpjAp/tz/S4+2z/HTw2x7rkN2g
 a7KAMD/AyMxjThe+Iz+HbCFE7R4NEODWBEiFYKgSDQXFlPiAWTCeO68FLm3CPFXh33ho+ksBho=
X-Received: by 2002:a17:90b:3b41:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-3958049908amr19539569a91.0.1787212201246; 
 Thu, 20 Aug 2026 00:50:01 -0700 (PDT)
Received: from
 runnervm76f27.aygp4ywqhuguzgdq0r011xmwyc.dx.internal.cloudapp.net
 ([52.159.246.2]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bf191821sm13730885eec.28.2026.08.20.00.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:50:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sowmya Indranna <sowmya.indranna@ibm.com>
Date: Thu, 20 Aug 2026 07:49:59 +0000
Message-ID: <20260820074959.3801-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819161032.1883-1-sowmya.indranna@ibm.com>
References: <20260819161032.1883-1-sowmya.indranna@ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs: Add fsplough entries to runtest
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

Hi Sowmya,

On 2026-08-19, Sowmya Indranna wrote:
> fs: Add fsplough entries to runtest

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
