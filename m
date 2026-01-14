Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F73FD29FEF
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768392495; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nq/gUO9uUkDGKbw+y7UPaNMmu0SzQvI/EGmGmZMOtyQ=;
 b=TYWwuN/UFe0DZWlPa5NmARi0AsPTp4XMlrUHfaAH1CdvJwU22qRET8axqQ52/EkruJ6ji
 2o6H/jS9cKkBSBMC8TWST7H/+mc6npd8TDiauz5l6M9jfoEldgdbHX0oKv6rVlnRwVtmXDF
 83DaFFuFZH8uR70cgFyPX3GVkNX7wLo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 239853C9AA9
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:08:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BB5F3C99E0
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:07:51 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC6B6200AEC
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:07:50 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so7098297f8f.3
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 04:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768392470; x=1768997270; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5gptFfDp93zrc1bzSQrWs+B2wexeiZ+9re6raz0VoUY=;
 b=TValBdxmY7w4UFzEOKga6uER/Dh398CAZT2Cq7p0Qh4nrt9PGsDH0IO8XMgqKt5ARu
 0mCl+wavUNdGyQwmzTPyFyTc0xlMbxtcSVpsmOyLusD3QK1iRhAN6GplZDzaoY8mZD+G
 K0Jcl7a6qSCgrrL9WHmnykOl6Fgdh7q4BN3xVcmBNYMEwRBB3h9/aJM18hwYYeuM9G5k
 fjbBqL5YTOk9jVnPdQdJFZ/K+twrP9N4HmNGKRjFU04mia7g8XJk5trjnry91yqGctQf
 1+mpCvBArAW/VFVdoaPSkRy+1WORD0PP1kQ3l+1olTzd6cLdbm4yzyxxx2fRdLCrab2M
 t2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768392470; x=1768997270;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5gptFfDp93zrc1bzSQrWs+B2wexeiZ+9re6raz0VoUY=;
 b=Q7Q3+rcnmPpDEmtGRAbRvFXaP4VeqkeNtx5mNZGIkm9b2/AP9+Lg0AzIjTyQM5ulSY
 +PhKyr/eP19pNLHkQlSzNuVqaHw7Oyib5lPUUeMa7kWaLepaODaPQgWuUgN4PwP6HhfF
 RcXO4D4qWSWA9YjE5J+hHOuBfyk1Tf4FG+WdpaYs1nwE2LyIp7WGnZH77odH+Xf+0uq+
 ibu3OLdNlNIO1KYvVQ3WdAbp7ft81Y6NTlcvZzR7T8JMOVlpV4HbyX3bOhSWZ/x0H+xf
 N9mfFI/zj3gDD9Ip1rtDMoZ0P0OnUnZ/Dh1I3hV7rFwc79Yz1GU1wlgWMxHxwYh8/D7p
 bxBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3eys6RsBtgItIhbtg9ifwRalUN/WCwJ6p+8n8y61rWO5Ir8CAEPW86qOnf75WSnn/dZg=@lists.linux.it
X-Gm-Message-State: AOJu0YyiaZKLFKOs1xynHtOd8zdjaOVfZy02pChGvF9qHpMxnfeEKAWz
 Nq9HcQpDBGpRu0DNacFH20/FNmFmMfr6eYJs41QlYJP4sv84zH7T1KAZYaCgF1M25do=
X-Gm-Gg: AY/fxX7efQ7ZaTdqj+UDlhYFN5dn0+Exlp+MHGaCA/oEaAsl01Si4xE4pDrBpuU3UMB
 XRNIeFzhJDxu10BGYF49Dnjkf/luLbZ5bYkQycf9zWvV8clym693SWb0dQ3JoT6M5ozrOwBMj6s
 UY3YJ/eFWC9i5U9aqiIGCOQl6sIOq7w09q2YkzdevabDPhJ1UDbvSS2OZtVMzjkR5nnR6DjgkuY
 SeLqUtPFwGsGVGOv8qy89zPsUViFM3zPjNVUli0sTd5PjlpuaBUDhKEsUmOtvJNa+N76xAXAPgi
 UYvL/ontkL0DMHQi+UvryO9iQqPCSKrrcG+tUPWwE/KHJClcMuX49KUy/yK+a1vZRCL/gxtMYkI
 +RQYsR2yaR0Xd0jLuJc/NMn5rnrHnukvQjtsxhDYlheG9mJkMEOLGTPHdnRxaEoKRpiCFOpZb6Z
 vAFhJtT3bA0OiWrzzohmKbswghfTghnQ7nRUVes6r5qHMWEmvH72fIdz2DZkG1WQPA7AriqfqYx
 G66/IHi6HtuR3E=
X-Received: by 2002:a05:6000:2c0c:b0:430:f3fb:35fa with SMTP id
 ffacd0b85a97d-4342c570e21mr2830545f8f.57.1768392470263; 
 Wed, 14 Jan 2026 04:07:50 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5fe83bsm50141251f8f.38.2026.01.14.04.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 04:07:49 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 13:07:49 +0100
Message-Id: <DFOAT97WU1QS.V5X9ZUZ9J6U4@suse.com>
To: "Li Wang" <liwang@redhat.com>, "Jan Stancek" <jstancek@redhat.com>
X-Mailer: aerc 0.18.2
References: <20260109023914.45555-1-liwang@redhat.com>
 <DFMMND84JK0B.27NIM2SX4YYGR@suse.com>
 <CAEemH2c-Maht3X7Qu5Shv+amXVWJaU2NKsCYdzNE2t9jnoWbzw@mail.gmail.com>
 <20260113115148.GA314748@pevik>
 <CAASaF6xrnNY5gpURDqgxQBWvQ5BqzXQN07NTkVbFae0bKB5PZg@mail.gmail.com>
 <DFNI6KO750G6.13XP4I5MYH1HQ@suse.com>
 <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
In-Reply-To: <CAEemH2d6=vmEKKf65WuAGRhfU4FE8mBf-dAzNWLmgYtFO3WA6Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libs: adopt lib* prefix instead of tst_* for libs/
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
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> Perhaps we can use a lightweight name for the extra libs/:
>
> est_*: extra test library
> xst_*: extened test library
> lst_*: ltp test library
>

Otherwise we can have `tst_` tag for all libraries inside LTP, but
divide them into categories according to their meaning:

- tst_*: test library
- tst_lib_*: libraries inside LTP
- tst_old_*: old test libraries

This will clearly state what are the LTP libraries, but separate them
according to their purpose.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
