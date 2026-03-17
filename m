Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEC9F3382A
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773740423; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RVAyLhT+lA87bMkYoWA3lIb4uozNWweSStqxnm3S02w=;
 b=O6q1BakCyU0mBD9B6lfgEK6e6cimLZa6Fz/BBnRQBD/67XVVMpbdhFWwqrRD0Uzcs5xuX
 7wtHXoYehm1oq8dq5QOumw6qHnL2m7GeHv6YwvH0EVwUBEaxCAGmV4Yo7Hr08+8uSH6Z55L
 WvZwC35Lz0hdxpFVn0sOVNnz8APkFyo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 301793CE084
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 10:40:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695133CDD00
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:40:00 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E12DC600121
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 10:39:59 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439bc14dcf4so384494f8f.1
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 02:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773740399; x=1774345199; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6qLNppA1I4WVp6wkPMqLwJWo01okm2qT8wkrHnJSoPo=;
 b=VEXHzlZSDugWu41mI5XGFJ3FHii++eYdYhDR4CnoFfZcawmCB7ZkXZeudMt7bT/mdr
 fJLugMPOUQsBUH++BlCCdRZUIYvGqeQWKqKA/6/9TIWlXCrfuKa9oRbqj9I3ogqRkPwH
 qjREQJTn+VVQ/6H4snkcPrXTv+5NZuQp9l9TP3GUMRlMq4Z2ZeO6eJU0aHMVRZrhKWvr
 7h6RhXCF9A2MMWDuIKsE4vAJH/B88EJB/l3PBXmMBxBEbOVTMQI+C+yMagneBlau8SqN
 GJu4+lTOGjJJT2W5Trh8+w2PAIOCRaawO8N6ZfxNi8fqjodAXl80X6n0AuLh5KFfQmw3
 mvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773740399; x=1774345199;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qLNppA1I4WVp6wkPMqLwJWo01okm2qT8wkrHnJSoPo=;
 b=dHhr+5PclDwQfoceh0uKVJgVUOikxIAoULiKlm6I/pJ6SSvzA/aa19ZZv9vDpWrF3g
 q3ZwqM2cKT7Vx2klUBsQU+aGLpcTnVIO74MLSLtA7RsOwlMNspTBQFO6gwPWUugtJc0e
 ii3yChBuMQJ+5YOTDA2kDvgRhGYtdnpR6ZR3xWnR9J8zr4Kxquqj8oUfDcL44J2XqOHx
 iF7UOzU1DyqkdRSInZ5VjDVm4SCJtVVBX5cAKB3zRHLwPAFXrKL1341YyNAC7tySSmWL
 6Ulj15GqRgiom3LWkyKjymo+LFdOo9zU9K0zyjoXk+hs0jo+bAbmNDjBI9a6eIBkFoBA
 BWAQ==
X-Gm-Message-State: AOJu0Yw3CNeaTP2wJ7JeDfH+XjCEDbLw1vfVw1F2mH6QH+sYeP9LJcbn
 wv/kK+F86pwzeQq7eJovmrBkIhfxhr44fQX/CLeX6TofsLxuojgGAvtCJDKgf0M4HzhfIi1eF/Z
 RDqxMJto=
X-Gm-Gg: ATEYQzz/GWgHlntpRc2j/zjd33g9O9UBPNSBbc6mqg0i5GNCuTcq0cIRsBbt0/3pBvl
 lDjl0MrUfRhcZsykqKNHnLBCy664TTvjNyRxOUJcPUHMQgJY8bWrsL7N8KcT/NRyxpcCA4pIx9Y
 Ur9bDriH3jRgmMpJZtknDJVOBcC2JoSF89s5j01bJeaxB0MHoNZW/beIBUPkm5b+bu/wBnrNeGw
 Q81aFJVRxqKviWKxV2EY7cCkiLnhdwF5uH5Fi0Q5840xnL6nwwC3AAVNmTrv5W4hV7DzFFek8cn
 EkMu9aIGy7Fa4kBF/E9/Bl7tHJtH1NpQ9C1G4WUTozoffIzrlAmGojKlPYxefsJdvoAeqNGqnHs
 6yVs5a9Ck435+3zsB3r1GwXOfiycA5r/vRn1WPIlla0QPQpHZ0smO35a0bA4uJlFxLPSl17+AB8
 BxwQeT+OBR00ijWotnqtBE/k9NNlFamD9iX8KzT5QL0AWjDMF1rTOVVvtQ/y03JwgGDbgtA2HqK
 qesGnZ2XGXLxOCeO7zQrGf6bGN4GJVCJkduG66HVj/JOaNxS+t+jLDeTUcwE2obyT+6uJWTzZ5Y
 gQ==
X-Received: by 2002:a5d:64c9:0:b0:439:ceca:421a with SMTP id
 ffacd0b85a97d-43b4981cff6mr4805169f8f.9.1773740399199; 
 Tue, 17 Mar 2026 02:39:59 -0700 (PDT)
Received: from p200300ef2f4fc9002549698ebd81b8fb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe2186e3sm55379617f8f.26.2026.03.17.02.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 02:39:58 -0700 (PDT)
Message-ID: <69b9216e.df0a0220.302919.f339@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260316154457.117543-1-always.starving0@gmail.com>
Date: Tue, 17 Mar 2026 09:39:58 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] inotify: replace strcpy() with snprintf()
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

Hi!

> 
>  #define BUF_SIZE 256
> -static char fname1[BUF_SIZE], fname2[BUF_SIZE], fname3[BUF_SIZE];
> +static char fname1[BUF_SIZE], fname2[PATH_MAX], fname3[PATH_MAX];

Still using BUF_SIZE.....

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
