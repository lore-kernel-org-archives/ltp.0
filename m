Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0A5103E174
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773839074; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=8oCAsoDXbLaPQDS5l7IlFRxQQB9a/6lH9iAuqYg4n7M=;
 b=Dy0MJuvYw+yMFRjbwfbZuFKYXD1eEMAOv7jXRCWf6kgTxZM8zB1tBvwMDHXtFXwTP3qSA
 DQ68X8WRuHHwNeKmndgRZ3H/WixIu2pVzljJQEdfvIPeGchR/xZCkiUk/7zuX0p66jb2pZt
 7pjsGkCdS5DdrEhS6+Hy7MWnJAzvILo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B174F3E608C
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:04:34 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26D103CD52A
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:04:11 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E11A600D3B
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:04:10 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so60859445e9.0
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773839050; x=1774443850; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=creFJZ6QlFXaHMN3W6tnqi98r87LVQ5Imwu3O+ay5wg=;
 b=P762PoD1z/XTaHop8vqNiI/MVjhb2BxNfz5WZpU2vHL1sqsAq6WYIhvB3NBBuhrFru
 vxp11pA/S85dfao7UvCyyVhwR4BI9OsMDmqL2nIcX+4ZRtP636yKjbZK7dr3/XU5HJGD
 tQgPS0SvoNWjVeXqFJkaCb+UxcC8u9N9gYenNDc2tLSNQA6J19TtyxSDn9w0+wZOUNbi
 E8CSogXLgmldpiPCO4Ub/x892ge014bEXp9izwrT6sbpjWYO5jvo39xVlXSpXL3DmSOW
 yMb1QIF2/+yz9gHLnP2sKiDWUVOQZaG5IlyYQbwTHZFgwdhNloIi858e9pmvjU4Z6u5W
 zzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773839050; x=1774443850;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=creFJZ6QlFXaHMN3W6tnqi98r87LVQ5Imwu3O+ay5wg=;
 b=qMulCc9YRPbE3gcOFp3clLm0eaVJt9ApU4fgqIq2Vn8aWWwZZHLUQ7gwPp9Au5KieC
 wHrmyAWLS7Yd7PjL4rWYFO4q2VdBX7m/XDlvPMFuBQ4VhaqzdqZkfjFX0LDkpfpIxY+l
 zyHqif8FbbNJ5Zjp+ex/eu9xFNdIJuuRyd0Sthz9dSfVL5iRaIgGmKx78qc5k/e5PrU3
 TJ9cjl51CNT32BNjkaqztjviBnI0kG1tDcMq57BIf9A6XToNQ+yN6qaHg0hPw0Rwptzx
 3/iZL87Oxcr3rLh5PRx1jiAZSoxawphYskub8iv1nUZiHVjPU/ghS7RwUSokqECwHh4t
 SmZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEV/+WNzj/5yVGTjjodcGgSYk4BCwY05KC3sqXaMSFIa11/J+YOFSEw1ETg3K0Z9WTmUc=@lists.linux.it
X-Gm-Message-State: AOJu0YwoTxjYsLmAPNozusnMXbQSOWLZNfBuaDR0F1VWx8bG5B5hjcvN
 2C83yG3eMDP7yuQEukCSUYkSaS7tJ3pPc/WVfv/SPWNCkQ/Ff6RZhxn1FKPusMPpHJw=
X-Gm-Gg: ATEYQzx0qqAgRhS80F2XVY95m4f4xlfuDY6h2ml5Rof8a+zIgXx5XDFckoen6UuRd9R
 uGfL6x6XMggKj/ohc/2cfHYa+sXzSeXOPzwSmkC/kJQnSHeCk6SVL1oqy6GZprYTvzURa64j/mm
 t/v4QRsJ31rqFZreCe8zRKHtCFFxZub6hvNUSV0SMS+esC4C5frg6BbrznrucYYmh8Ex8sw5Jfs
 Cpb19XSYBXUxD7CDnm74G5NXJ/IaTQCNxCKnCUJEncClMSw1gpOOfg4+8JGZhCoDab/e0QakVYN
 FPge2fWuNbj3JFIvR6ox1otEv0KhYcY9kTpZRNC+Ye4sj+3X71t+JAJqKxNzGZfdJrAVCOCqi/p
 5kTPVIUbPFqVQioy+RRTZ+Zyl1re4pJ6JNomKKl58Zv+cDzUwJFVVv1pMn071SR9NAgxnup6tr4
 GTHUOwfApuSCf8cnS+BX/e7Tdqb3AMRZWkDLnHDYnK
X-Received: by 2002:a05:600c:c491:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-486f4469363mr54127425e9.17.1773839049744; 
 Wed, 18 Mar 2026 06:04:09 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4e48ad5sm80014355e9.1.2026.03.18.06.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 06:04:08 -0700 (PDT)
Message-ID: <69baa2c8.050a0220.3719be.4e9a@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <69b97807.050a0220.26befa.70b8@mx.google.com>
Date: Wed, 18 Mar 2026 13:04:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP old API conversion
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

> An another thing is how we want to push these patches in the repository. At the
> moment kernel is using some special tags to identify if patches have been
> generated by LLMs or by humans. This is something we should think about,
> because we already have a few examples recently (i.e. your ulimit01, newuname01
> tests and my listns() testing suite) where LLMs where doing most of the job.
> Also, we are receiving more and more patches which seem to be written by AI.

What about this ?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
