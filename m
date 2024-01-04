Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7D6C47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 21:24:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F2BB3CE717
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 22:24:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79B653CB53B
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:23:58 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C2EB620093A
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 22:23:57 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55711962c3fso773440a12.3
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 13:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704403437; x=1705008237; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SN4/vQ8WjyN8ER288GjgADf8hV5BlfSbKdPC6qnvSX0=;
 b=bcXdlI4BJC18ywKODN8b5ts7/8RlfvMKlYCQ+Bnc7OEB9kNZ0unjQC/0GKhUiFWIXS
 DlJsj+AJPbwvH+J2T0e2ck3EgJhoiWA2oibegXC94gQ+9k3DIcF+MNWZNHlLEY8Of6DJ
 jVuu74hTvSfk2hY0V+deunLTQXHBV/xABXiwE/5zZ7QppOqJlRckZuoNBmvf7fyaQZHL
 EJ/fSE3uFxMKqO1pa4L9L8hFUrEBa5t3xagPi08qq+DSW7xVuZz+a0LoCyMTPU0mqQxP
 Zuhg+GNaPClDF5zyIMYDrYFnDw2Tt6MKW+/QutFxk6wdspYPVpdJvAG3bUafr2eVsGrT
 1zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704403437; x=1705008237;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SN4/vQ8WjyN8ER288GjgADf8hV5BlfSbKdPC6qnvSX0=;
 b=kh3WXKypE9sjcuPorZli+1rfJviZNUl8AfXS1+Yd4591JaRguLGWOFtODSV1HbHRY0
 uXHXGp6eHgjRGH5DXyRWIQwYnqfZMTCdqVCOl2mDfWMY9ANn8bPGXCvL9iGL95Y858t3
 0AHdtBrnCv2VF7aEe0If5sgWYhqGA5XZCDhMQODOLCN2IhlAbb4aVVflQFs70O6hdvB6
 Tp3iP9bjY+5/+mT1JOaWI24D9ra5bQjrfGkaSd6KNHzhUDMGFGYmJFqIh7exSEDbtfOT
 WwGAaJ47g1okBWoMRw2Hl5N+QwFnewCBHGmyXtW8IDvLDC4uHFP7aNjfUNFw9a/WPIyr
 66Ow==
X-Gm-Message-State: AOJu0YzUS/7qIifHBlcqCfv8Y7QaAIsw/tSnBSo751BhLd6NUL6BIcUu
 GDR+TG0g6pDX3qw7PYaDVCqK19JNkVzCYw==
X-Google-Smtp-Source: AGHT+IGAqJGxHYSos0Qk3hOnZdpp8yHZiQiBhDQf5VbnVXcz7M4XYrxsY8YG4DsVjDSP1Sde3ZVjLA==
X-Received: by 2002:a17:906:7815:b0:a27:f5fb:502 with SMTP id
 u21-20020a170906781500b00a27f5fb0502mr575246ejm.75.1704403437224; 
 Thu, 04 Jan 2024 13:23:57 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a1709063d6a00b00a1df4387f16sm85464ejf.95.2024.01.04.13.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:23:56 -0800 (PST)
Date: Thu, 4 Jan 2024 22:23:55 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240104212355.GA1438378@pevik>
References: <20240104204614.1426027-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240104204614.1426027-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

tested:

https://github.com/pevik/ltp/actions/runs/7414522840
https://github.com/pevik/ltp/actions/runs/7414522847

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
