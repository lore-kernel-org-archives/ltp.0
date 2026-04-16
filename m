Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62242F8809D
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 07:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776324334; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=vuNMnvyZPqeA0leVL30JblKiJd2p3WqyWiXBCCrIFXE=;
 b=IiteF+OxMFZxJCgK78Eq5SHSznPsTbMVA70q9a8cbmiXJHDbbK+VCJgWayRvOUVVDBejv
 CvkUo4RiZBxzw6WCMy5PWnySr3OzTAEFfmn/6e1ViUZk1lOz7aMHmubl2mgqOypLZddRJsZ
 JZC7xImyd5OySTd8RguHYSFRRp9SJL8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B8063E2140
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 09:25:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 178CF3C98AB
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 09:25:09 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6EFD360085F
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 09:25:09 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so3723160f8f.2
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776324309; x=1776929109; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Phn5IJVZ/94FjNGRzNXc6NrOx78Bx7ByFTHjmMzYX6Y=;
 b=WN99AACfTLLhyM29398WNKzlzOTEJDDOTCQ01hyZgTzy0OmD8gCGRcCQNQWyh7EfD8
 KilMMVH9rtUB/RHQwzIQuXNryBCJxYONbmD6xHccv3jKb4T1byouXIRcnsN2FJBciVW0
 DEUCLM6IgZPa1/ekxnlM9FsmUwE/o1JyCz87Py6NEoeb4IwodLnHC0koks3gGIBO0y7u
 /et5DMKG0ACXhRTFTpV88602hMzhh7fvixyhDdiLNGr7Sqrqs4roge1f1TF0L2ITIsyX
 LC/I5gQxgyLxQWNJcq9oToFHccFXptVhZX0hCgVIxDyih1oKKt2CMI9tDFF3Ig5cFbl5
 tTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324309; x=1776929109;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Phn5IJVZ/94FjNGRzNXc6NrOx78Bx7ByFTHjmMzYX6Y=;
 b=dJM8xM0NzjJvhmrF7+8euPAZKC9jcRcaFDyLfcJ8lHLjG6RqpbR40Ywr1x6KImzJWi
 5TRhFyldr18Se4hjPLS9eU0LBQapq6jn6U3NxeILdQb2F9El2zZHDOsYZJeAP6SHuDTq
 mxtM02qdI9146QVt4KK2zDXY2SjXFj4e0evtrtezFEezDK94cM9bIWMPoMfEgv9GYS/7
 rD0MnDKNngM8pfPrzwsSmkfQ18S4JWgHg6lelg7E+ZaeLSdNzTjr8znProEyJuFp6H4I
 +x73OR49r9G4NrU3VldAkfwbqVGIXgiIPUoipT24JP+tYUwiR6LhUA3FnY8X0X7Jig5z
 B1BQ==
X-Gm-Message-State: AOJu0YzQMsFljKoHflVGZNT+LQACzzP+ywKxYGtW3B2w4vnX0CVd6m4w
 LQXYu7rl/wKRjkN4yZqTvxYqOiWMdadXhasPE7NFoFwdv425BMaidvceLAG8bwSaQx4=
X-Gm-Gg: AeBDievDOXT2vB1BowGZaJ1SyN04PaGly590h3bdF8KjW6vCHgBZjR/qX25gaVt+trv
 YCWLQ2MpH/bc5lEAa5k5ySDLt3+mCNTg4mhs3LqBrlKPiXBXoailKwLg8dveDltwh9bW0yfvIdp
 xNfppNfHMX0DuJCRnZN5AukZ5i+aS52RpzUnR2H5C4MmopTKX2pWx6WwHeQpAmihKyFKjY6xmnO
 lhB6uct1MLyzA6qXuSLJH4C+cFPuAJd8X+B72umT9nVmnRTIw8j1t8LivuBC7zmveKY5t4zQqPB
 aZ8W7pUCz/cIP80uXdhQTwQ/zO0gyKgsVkHLZnduMrXnUe9gvzcGe2ajv2aFSZcfYUTt57D3R+a
 pEerJzDXU5okIOR7BDtoRiYPx1RVNIHF6cxWkoXlJgWA21LCGf4MuoMwszk9vzF51n9JhpxRReq
 kieRRapAJn7EETo72TjKF/mx7aaMLfFlt1J5DrMqYSvkBjFKGeUdcutl2KPGou8EDHwmYBwmaZL
 altuxz5dV6c9BY0H7SVFy72C2fp0zhn19A=
X-Received: by 2002:a05:6000:290b:b0:43d:775b:c9c1 with SMTP id
 ffacd0b85a97d-43d775bcb4fmr23530803f8f.1.1776324308747; 
 Thu, 16 Apr 2026 00:25:08 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3e00b3sm10716765f8f.27.2026.04.16.00.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:25:08 -0700 (PDT)
Message-ID: <69e08ed4.df0a0220.57300.4db0@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260416070128.GA286748@pevik>
Date: Thu, 16 Apr 2026 07:25:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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

Hi Petr,

this patch is not applying anymore, can you please send a new version?
So we are making sure that it's correctly implemented.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
