Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFD4C3DA49
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 12:13:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E84543CDE6A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 14:12:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F34F03C0746
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 14:12:44 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 921041A0BC5B
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 14:12:44 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58b447c51bfso973463a12.2
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720699964; x=1721304764; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JII7D1PvabeHx0X00FhjvmyYds3ixgCaTBUnMHI2x7A=;
 b=R4qOQx7uzCAtFePQboHarD9vlT8LNHkS4FoA7cfaQav/XI+isfED2suRdXt0jfBMgx
 I4Ub9ItFioDgb49JDQs2GLW5M5Hzc6AIfZHorrzfrRdu/8rSmDGsZiX5DPNYo0GjRVSg
 aa4dF7zWlx4C6ppQSNALxIN7BDwYOq5hY5Aq53IrbaCvBtM/uUnwWhiezJLuHmcOLFmi
 Gi5pBOyKS9WDuSU2bqaoBc+WY5YkDD7evleZrb0XFD/oMy8lYp71kuDMI1JVi26Xg0Ob
 xzeo0G+G7iIHx00nM/ze7uaz8SS6NpuVR2lZ4VV4ST3PFlc8nMoRU+V6KCAXx4prDKc0
 tyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720699964; x=1721304764;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JII7D1PvabeHx0X00FhjvmyYds3ixgCaTBUnMHI2x7A=;
 b=VYD7j8N0FrkN0rrQOMIuEKJQ5KzhjIEGr9mB+c9E6IRtOdLvW4mlYOdeeO9q099SzF
 2E9vgagys3OefredOYnONrwofkoVbft6/xujJzhLeRPkxHwgNxPtQUYabdSnrrXoH0se
 4i6i6ciV9KsEUEsl3q01qNOuolGM9FPehgb+45v7NW4eqFH4M3AbR428tQc7QZdYsix4
 Jc7owMwRDjKnHAxGk81u8NqqxB2Gp2pirr4AEho3uxbld2SMeqv0U6d2A3mho1qHjCCt
 eEx4cyqZmdt/KFkteFd2LU9Mt0uhAzWcTME6WSagPXE4YyBGGDvIC+X3izmXaylcu8OR
 Y9Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/vzTaHP05p/03cr48n4NstXfCS6fTtIc7vcG9SFI0Y6Y/Qyc0eOha1MnKLjPxjLH0n35bTHo/ElpRUrdGqkml+5k=
X-Gm-Message-State: AOJu0Yze3Yniet3a7RB0FUvYHlXiFabPYmh0C+q7uE23FT7U3VwEIbE5
 Rz5eVHkjFOB7AlFjuukgH1Vb0swNIk8HqhI6vN42ru1lyWIu/nAtW7jBsQ==
X-Google-Smtp-Source: AGHT+IH/l2uWdReBAWaqoribkGmDg4KawLcVBVive6P9qzz2dR1sAVFlYF73fg+S5jc11kFSnsqw6A==
X-Received: by 2002:aa7:d6c1:0:b0:57c:78fb:1a32 with SMTP id
 4fb4d7f45d1cf-594bb56a641mr4957190a12.19.1720699963374; 
 Thu, 11 Jul 2024 05:12:43 -0700 (PDT)
Received: from pevik (11.90.241.94.client.nordic.tel. [94.241.90.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-594bda3089dsm3376944a12.94.2024.07.11.05.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 05:12:42 -0700 (PDT)
Date: Thu, 11 Jul 2024 14:12:40 +0200
From: Petr Vorel <petr.vorel@gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240711121240.GA64682@pevik>
References: <20240711-stat04-v4-0-d30c26fdaf5a@suse.com>
 <20240711-stat04-v4-4-d30c26fdaf5a@suse.com> <Zo-cyFmICaJDp1Oc@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zo-cyFmICaJDp1Oc@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/4] Add open15 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

the rest of the patchset merged, thanks for your patience.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
