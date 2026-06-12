Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D994CCD4F2C
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 08:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781253167; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lVw8dt/em1Qe52yHFr3Yn+YzCSh2D+GeqPI6ExJgFSA=;
 b=M8HGyMD9bTOPtx9jwUCNlOjI/UXD1gME2x2bn8q1QGa+2nSznU9NFP4ZE5KxTlKlFyI6J
 +aWuT9oJpEf72EoR7fgwDCFL7ypr9mqqVqnXKNyjU4ZhM0xysEPNzQ67dKNg4qe91JdveRD
 LidiD32zNsTwD31mE7zTgBt7QVk3w6w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 443DE3E5E53
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:32:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21E303C22A5
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:32:28 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7DF6410009B0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:32:27 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso5530255e9.1
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781253147; x=1781857947; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=qkLfSG4SjU53L4Ew7hvBqu5K1BUj1yYc8oYQbe4f9dI=;
 b=Q0OMLMXpCdONi8lfUdB03N5/Q2k4T77oc27b85pjAULSFmy3kLNhKTxFqoHbH1Cab4
 qgoafWqsKcZIoiQN9ddoG4s3X3RLi0Ge5OuwV+aDJHJf901voTQ4uc4jlgpBEzm9ZI9O
 thpYSvuPzygg0F5AtccnSdYCkzbX7bN1sCaQ2qAxlAVxkYTsnRId9PehAr6Bk6k0OKqa
 R44asiA9RqJM5fdb+HdI8szouYmzZRh2MM5UxiH16zZADsaezwpyfw1Zwo4nZuPH+oBa
 yczQkL9TIuOPb/VNLvT6LMRXgS+ejvDgnOPt4ZP/LZ4JJtSbBtZNBZIALLYCcjo1/xWR
 a6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781253147; x=1781857947;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qkLfSG4SjU53L4Ew7hvBqu5K1BUj1yYc8oYQbe4f9dI=;
 b=GAzkVtb3+mJ/iD+FGXVNAozN0OjQOu+553oNM+EjCI2akwDqvkaKoEsfnstzbzM2hI
 oAc7AhpbC+dlxPFnnDWTdzie/Zbdh5OZZrOI7dC5aVQfqwxYH8NGLx8NmZvKcpQVWNbp
 JZTNJjNZe4BBIE8Gy1R5Mt8PH++kszFRsym5subGcpiQzYTv6Y6xMC6ZZnmY/6fCFkpU
 t8tXz9mC13Q4i7TCy9Sz00EPGxi0xayUHXVkzXETX8TttYrk9gGC6XdTh/xaJYNA/erZ
 T1HVHS5i9PvCJXCLfut13G9D8JB52t5RRCNeQnXVHQrVCB8LmJL+sXivNwoPL2MQHqcV
 ynlg==
X-Gm-Message-State: AOJu0YzwHvA+ALqbEelTur64AwUzBEn3T9ia3r/rlET8vddcmnmrPFnC
 ELkawr4tydon+ShwgRQrUMuN2uyMbWn7iviasCCqbQBYS5Xeq/iighJfQFrlhwpSRbC6Q4xgQ4j
 S0vs86Nn4xQ==
X-Gm-Gg: Acq92OHfxLu/6fkK/C8pfD1/62LQqA+iU+/qZUUDicKF6ZvMYrSR41ic0HCLj1+0Pnk
 Bs3Ky429kmr8OvlwFS+chv80SHUY2uqmFVJoSI0HjmpYJZAgSMmwu8SJlPkBE78KN8QSHOGGlWw
 BUS+5cEk5Tv+dJeA0r8a7lsGmNDuCs7TsqSYi/s8ogucPboe8EBMARXwh3ZXttxzuCIt1nd7jvJ
 bnZiDsDVLZ+jDbLPBAWTivsmOCKvCMP0e7dTZOP4u4eqIOtOLO2DER/vCSMqf/9MXA8PyXykm4u
 zOWi+Erag10VDbPvqFNyMQABxFEq8ATIkZRLUXxnTgn+C56ZLoZ7Gz8BqB3tAmagpsNnNip9397
 ObrZynOpzDg6GgyHtlNBW5kVGaIWz/d+Uc+mfG2w9s02CswcbTCFIZX8daqCVGifdB0rqltQAtl
 K1Ow9XlYf+HHVa+cOqD+1vRUuQNQzv0YQphThJtGssELd6tNrO/NPzN+gli0/SFOiSlpNqlcHuA
 BUs/jNRf4TfanHlXXc4vx+G4uFLHKH+qfZl9aK05TgGEGdp5FxQztes4nY1ZcT1zWx0m7SSMr+c
 zQ==
X-Received: by 2002:a05:600c:3153:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-490ec4fed29mr21803255e9.21.1781253146903; 
 Fri, 12 Jun 2026 01:32:26 -0700 (PDT)
Received: from p200300ef2f13eb00017f7d76deb7e8bb.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea843d6fsm49539865e9.14.2026.06.12.01.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:32:26 -0700 (PDT)
Message-ID: <6a2bc41a.16c38fd9.38778b.a98a@mx.google.com>
To: Samir <samir@linux.ibm.com>
In-Reply-To: <20260602100512.404810-1-samir@linux.ibm.com>
Date: Fri, 12 Jun 2026 08:32:25 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cfs-scheduler: Fixed "make check" warning in
 cfs_bandwidth01.c
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
Cc: Samir <samir@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks. I also fixed the commit message that was not
following the right conventions. Please make sure this will be
fixed the next time. In particular:

- commit subject was too long and verbose
- you added patch tracking into the commit message

Fixed into:

    cfs-scheduler: Fixed "make check" warning
    
    Fixed make check warning in cfs_bandwidth01.c to comply with LTP
    coding style.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
