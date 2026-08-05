Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724FBC55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785938869; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Xfj+6W0vUKhkQQ0EsGLKS/mcdOJKMKug5BuRGpyqS0/s87Ylaf4GZs1xsegx4pbIhty+7
 7/5XglbCAwzYB3PvfJFr+tcy0gBJ7EezaHIJ3WIg+A1R+Y1dnrySUHDVkwjwWN/Z047GN81
 ejAk1mMyx6L+vDg/bN3TH9e6k6ZXIoE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A67F43E7151
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 16:07:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69EA83E2FAF
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:07:30 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BCA42200AD8
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 16:07:29 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47fdd674e17so641219f8f.1
 for <ltp@lists.linux.it>; Wed, 05 Aug 2026 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785938849; x=1786543649; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=cgUcQlKK6ncBWojugDcXmC9f7j3rO92nuAMQPYtaXaQNrbfeVX4+vgl8aeNO7cUgsC
 mjztkOx94FabpX40qRc4n/nb+Ud50Dkqp47vOpiF5uYYHzsNQSSRvFdellJRMWjeGS5j
 y0W+xf07tKL8vw6WECGgQHU8Upnt3DfhWmnw7IWB7dvioiunj0WLTZX2nwJi0Jz1hgT8
 boYetqkSgbgx/VNBqw9a72jcD60qlaEG70rwTwNU1/2CxCMtn8lFA/ZglaBRf8gAhiAN
 nksCwgtuX+KqN+ZYtNUOZ/1K+V6lzqvVjzaGUYgSa7KwycMKB/J5yKjDQh0b0cfyum4d
 jrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785938849; x=1786543649;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=q9FyBDwjgYMzn4lhCKjLjF6MsCcD+eI+Ba7bapPwaOVe5vojxlrCkW98NZ16tdR9ZA
 2/1keyg7YEP9xeX8MAZvY7Gz0pK+otXRrYEqZ15eP2OoLnlecX981/LaCaGQYWmX3e/q
 u+EDQsm4NeKA1Qhan7ptluNT4GojSxVwngJ/J/aGkaEmHtkdFs3NACjq0RwG/LryF81c
 Pqywz+9GS9NyIHFukASeovjItZTQRrZXANXKrchyFfLOdqVemjyD5dcIG11i1eiX6Pm5
 oh2bRERv1xUxEuO0HMIvZozMUpBRG3I3p8cWfXTKo1KgHXIPaG9KCIpsOJ4RK8MwKDCp
 KjUA==
X-Gm-Message-State: AOJu0Yysez2/F8KRX95o2JnkDk3fM8R5jG3wukOmnTeuzfdA0fFz5Bzv
 NYKodpu+d/dFnDGD6PqjovMwNJ0j0xlPCO1ICCpQDrZak/GRjRb8JFwuN7S0dAD2Y5qgVlMtgs5
 yCjw8Yds=
X-Gm-Gg: AR+sD13KEfRjubWHU1AhuMgtlomJba13pzRofhcTc6EEhQd1PAlyd7tak/paf5typYl
 qZ1JognqFljfcBalbo2MwLZ4wAnC7A/oEm6LbuZaQX9VzwWtHQ5tBmz7poagMZ/gs3xDS2aRNch
 S8e2Akh+4vX7X82r+Mewa8E7sJeH7ELwo5o5UhRQUsUg17z2aP0eISkhCBMZijPojdrxw7B5VKq
 wBwgrtYIdUMw8OtMOHQ+tl6sTqY4i6awMXrMHV0VONUeR2zhQ1l4PywZVZWgnpdz3BEzxwRo2TZ
 WmCaMNXM5tCBZD+oszFZQS3SJcoR1SobXtR/Tz/G6AvnKtVy7OPP0LFYb64cmE63f1XSCkH42hz
 yWmPJ+d9bfnnGiXq7Mf3hGACd3DFrrjazufdazav9U9Uo/pkjZHcZhp6Ai80gbety5kMABTiWeE
 ee3IUbjOxRj4CkceM5N//U9OBIqOOpwsmnWYqiVdsdIS8PYJzQXPpsz/1XU69DZx5ACNMN7HN7U
 tY+hQVozLyxj+XFWEyPG+0WiAfQQOH0Osj4yk6IByqKMLCGzSCeLXl0e5fAWN4SDLXAouA9+ySb
 BqbDwhYHEUOq6npmfgi/OCIFNb1VAKfW7yTeeA==
X-Received: by 2002:a5d:5185:0:b0:47f:ecbb:59a2 with SMTP id
 ffacd0b85a97d-47fecbb6f45mr8502941f8f.29.1785938849112; 
 Wed, 05 Aug 2026 07:07:29 -0700 (PDT)
Received: from p200300ef2f1109007d27a2191b5ea63b.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfe5e85sm9028920f8f.14.2026.08.05.07.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 07:07:28 -0700 (PDT)
Message-ID: <6a7343a0.bdd87efd.2c8554.7c3b@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260805094935.448896-2-pvorel@suse.cz>
Date: Wed, 05 Aug 2026 14:07:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] readthedocs: Update to Ubuntu 26.04,
 Sphinx 8.2.3
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
