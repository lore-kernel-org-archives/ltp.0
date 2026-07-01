Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2706C44502
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 12:22:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2511C3E9B63
	for <ltp@archiver.kernel.org>; Wed,  1 Jul 2026 14:22:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 316B43E4AB4
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 14:22:06 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CCC901400B88
 for <ltp@lists.linux.it>; Wed,  1 Jul 2026 14:22:05 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8efa6c5bebdso1344566d6.1
 for <ltp@lists.linux.it>; Wed, 01 Jul 2026 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782908524; x=1783513324; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NDgVdL6xECtirNsT0UZLG1gVyubksuJkUv1W4KwO6c=;
 b=JZ9q2m6fL4eJkh9h5O4Tt+s/Wbprte2Wdl6W86D1B2MBOzQ7h4SAJ/advalWuVhsLX
 wdRzUjPuqxhF2moxaRw0Lsy6lyVLxlfX4W+IzyN4ixmPlQMx+44jW+ZBexG0WNqPWe4k
 DRsvhuzhB7yhsHXythcJQ54hW7zUwF0WLN06M6RFvyHh/0k5oCXHA7pONCh8kJ/Z3THw
 SIt73eXgX3H3eG3aU6eJTt8TB5KT0kl+pYxXrBntXG4WR4q5jZvRYt3LUps4ea3zEG3/
 0GzXeS9rMtonXkDo4tdRm7hmjZJNSU4U9JblgctrBHV3mJwE7JhKibtv19fNhwd50LwV
 mbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782908524; x=1783513324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7NDgVdL6xECtirNsT0UZLG1gVyubksuJkUv1W4KwO6c=;
 b=e3AgoImeqDZ9n8CrDj33SlevuL28TW8JIMC9S9Q/UYL/ZeSpp24uPTUk5VmIYlEiOK
 6iUM7ycQ7gP1bb4ferrCXCkUmP91I8ZoVunCSfTyiQ67PnwZCOENo+8dA3YqCKQwTEN1
 tl2vp0R7Z1vFWoW/GHwklMvAMavOMH7Ixm+88J6QLdixv8sfuHU9r+RTBlGflCLzl29A
 w/OB9Ccf7USZoHIzyOE3jr9sPsvowJySF7Q8wh4U56wp3HKwTPZMpIDopEO/VHrk2BLB
 ZNlMzf4ltmoWPnebveZTmk/iEf9Mg/Hk5/Sm3DD3SUEorLIuVvShbMJhNAOjOfNzZVO+
 Ay4A==
X-Gm-Message-State: AOJu0YwaMqQ/DAkchdvUzOxE5IfDDcbLfjjPikc72qbDLeQCTIULMfGW
 8D+bc0OXMyslfsK6FODZNbzMB6SPd5ZGeuLG9XwNWvO0Lp3aleyZwl8e
X-Gm-Gg: AfdE7cnD1Lhj89GtTgz4vYJFhRoKJ7vqnh1Fcut9ejl5/z2WZ6uQSAHHAJF3YRUrPb3
 R+KoQN4jnzL/f2BzJGqZsAxz01bNFkXN63gQEngq9r9kGcW2pYkodXssZBRsYOEuMYZslsoRKNf
 QWCTvDzOAGDittamaZ0oke9QR8b0D1Xl0OcHhUPxG3amWAXvclzEZeVGP6+y4OYfe3njPdfpvCs
 DMrXAamoRhrJ9Z0hC1JXFDxRpFD1tvN6z6ih5plFve59rD9PWWbr+msqHjLw9Y65j2Y/NRIiCyt
 KlG04HD92c49QA3sb9fyP9Sr/vfEkDPHZND0PHPVViCFjIXdT7M8dslBGPJcC1jwYxVR4Unsr0R
 1c9pUz2nkcr2z4Ugn6ywKrSHG3eiAw+YDSB0j3MMGd5yAl9uo57d3jspjXa6ZdNcDXmnhqcYc8P
 WnEo1L9H9+lROXh7ZOfDQLq6c6K3GaZwofpQYj3ycQt+mFj+2lJsDm80VdrtbBW9RFk12OoOo08
 tEJkxQTyz4dfECrek+bWkde1BdgUg==
X-Received: by 2002:a0c:fecf:0:b0:8ef:892d:375 with SMTP id
 6a1803df08f44-8f3c95d93f3mr13035506d6.48.1782908524341; 
 Wed, 01 Jul 2026 05:22:04 -0700 (PDT)
Received: from
 runnervmmklqx.m5kpmtvhf15edb5qvthl1r1zqf.ex.internal.cloudapp.net
 ([135.232.200.23]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f35e88813bsm20307626d6.9.2026.07.01.05.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 05:22:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Date: Wed,  1 Jul 2026 12:22:02 +0000
Message-ID: <20260701122202.3998-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
References: <20260701110038.175976-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] df01: detect "fuse" fstype in addition to "fuseblk"
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

Hi Vasileios,

On Wed, 01 Jul 2026 11:00:28 +0000, Vasileios Almpanis wrote:
> df01: detect "fuse" fstype in addition to "fuseblk"

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
