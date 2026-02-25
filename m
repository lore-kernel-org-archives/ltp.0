Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB41FCEE8A
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 11:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772019312; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Wfk4xEpsZVROzV0N0e3SuChL9KlOeX3vk3tHsiIT3B4=;
 b=q7cPcrNEcO1UJR/935z9R9GKuD/zAEjxLsZJzd2fzBPWq7oXtkiPqe+B7pmXrOMi6FS1+
 oQKrtCVeWbqZIG1LykvvYnwPuxyqupEzf3Ej1FK5x9FBk2Pgj2N8HBnfRHuH8820DS60QgZ
 2xEoXr2DYSDTw4tdE++7Se7QEmJDkow=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53A3F3C7A5F
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 12:35:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 743B33C2C9C
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:34:49 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D34F620009C
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 12:34:48 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483abed83b6so30784195e9.0
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 03:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772019288; x=1772624088; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=gXTbGpKD6wZZoln3FMuqCEbnZpiyi9S1ReLrE34PRCI4F3xzq1N7rmwkDOnqgqnLWC
 NuogtTNmdClqWkC7Hk3ulk+AW5ZnkFQLPQos7rMWhRkgtwZrdJPOyB60kgnaJeIY7hL2
 yeNtuwuTv8aDExNU4hjhmkas3/1Znm9uKNA/qP8v+68E4Ho1Is4fxRB1z03ZldiG4tEJ
 o1mOzqE4r2OMCOK1zAyQ9AWDVmPQ0CE+jBhvONQqNZZif8aKDeSzJvv7OGGoc+fGJj/m
 R88WPPIwK+y/4uAapPpBE02Tt2UIqJi5+Wph60Tg3Tj+uD/mGak7qyuzHpXM+0bayUKF
 3XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772019288; x=1772624088;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oWYXEUEifFZBMHeVmrbJAPnEJvyyfnEVusXUsSRAp9o=;
 b=Qox2QEABRhRAZIoRMm1f4WZ3uM/ujyQE0hvImCiAq2gUAbB2JZUXcGVmiUGDHBufTu
 kiMm/BKJfGA5bmZl5rHreaHaYzA3Nu4IDqJ9TSa1nVaG28RhhMgfzvG5WjL5Irev/BMp
 jhgERjEfIY83Vg20zVpyq5EzIu2CS59OwL9cNOKnKa/bGx5KKZi1QBGlu94jm1AEqz0x
 gESfbsdAfw97bLWT4UtaAmz5nOiOM0xigZ0fXj5sC/Q7Ye7vEeENFA/Fj0cAVuk7ApeG
 LZOMSo5yr1hhbUBb4lvtsojZiT3rXgsu/DTJyZwQAKqo9HRlpn0yMLsrjlOoyRHT1JFD
 O6Pw==
X-Gm-Message-State: AOJu0Yz0V5ZMegtjc7YkThJkuHNQyai3PMT2DL2ahW45Pq+N7Gopbv9O
 Wgv6rBl/bY0iY2Ldng5c7AsEuJihi+SAqmomXj1J23Qq8xaF34Hsp94VYEs04yCZFF8=
X-Gm-Gg: ATEYQzzzi/ha/7OLkuumYrlXcyrQc8NTO129tN4rqJfbq5H0TDx25gVm9ImlfpAKpCB
 yV01mp4CwNNHNkrp4oRD2zcEPP3JbOfTl0cQwtVH0jjJc78Q7ZHura6JBFBovP+NnplLd8vDHUo
 bWaLjbXOWnZvsP/j98d7Q/WHzI9dTEYRTq5k2vYj4LNdtp8pNJyXMtdF7dG9KQl+iZKZCsIgO/E
 fjY7GTFY8CPqaydTx0rxwf5B0I/Vo1t0ZafNh5L1kZJZ0UfxKZ1+4Ev84R7jaofH/XEBiZKF4yU
 zAzqOiI4wQgedhcpLclEl1TkGvJ6nEwATLPLrraN1ADcED+W2Ca0U/SaqQykgl5ZBDpcuXqe6T0
 qjo3ItvHOwH3lxUO4Iuj+Kfp6wyerJgN4p1PtC9F0W0IctYlXmlidqh7KbIbxnmWRVvTDJ/1umx
 8tbBuR/zgfCSyFhBfrHD6cROTg
X-Received: by 2002:a05:600c:4f93:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-483aaa15e35mr278127835e9.18.1772019288137; 
 Wed, 25 Feb 2026 03:34:48 -0800 (PST)
Received: from localhost ([88.128.90.40]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bffc17dasm17108215e9.2.2026.02.25.03.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 03:34:47 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 25 Feb 2026 12:34:46 +0100
Message-Id: <DGO0EU9A2Y9J.32UH4T0T69JBI@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <chrubis@suse.cz>
References: <aZ7Q-PB-_LV2K1xK@yuki.lan>
 <20260225112903.1978-1-always.starving0@gmail.com>
In-Reply-To: <20260225112903.1978-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] poll: add basic POLLHUP semantics test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
