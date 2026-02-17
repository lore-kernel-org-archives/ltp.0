Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F911E68166
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 10:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771323829; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TFQ0IZu9TjP0/H7nSxR5HzgtqMwi15kJg/uoHU7L2js=;
 b=Lzk21A7izx+x7hcAnCkrrHJq8r+Izqt3iATCXyTaJ1erzs7tOelIA7Uq+vA4vh8FRbmyV
 Ch9QkhdCPkPl0/sZzDumI5QEL6nzMfUTIKGoder5cVWadcaXIN/hvRHCa5RSXqKp2Xu/hLC
 KSo7DfxtBTYNNWjeEeQIJhBEZmaYK/4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 271363C04B9
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 11:23:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 048A83CC713
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 11:23:24 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BD08860020A
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 11:23:22 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so37822065e9.1
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771323802; x=1771928602; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P2FSW7TknW+b+LteADoyHpUym2MF/oTqEXeTyal2WTE=;
 b=boIDBYKT8LQGPSo1YgWRvtn4ADZOKgvHK2Mwe7136CyxnNbz58YlrASmpFW/i8m+dq
 8ERFJ55/7ydDxhMeCvKJDWNhmPGlq+Y2SiKlT6dCszvmY9Z39F9qkzciJCcEwb0NK1hm
 GE81lCfnmcTUa4tPFJ+qYD4zkTfPNpWwU3fiFPRRW1BC+lWhw0s47EQGfrn1PPcLyz/j
 4EiCBk4vHeUeLA5MXTQvSF3DmgFYEm1jnAplsGFWAT2x5Qf2PhTA+c4IHOwGlOZx3BGf
 /9hWlCMG+FrPk8H9xMOqqNgjU+GaueY583a2ay74ygWyv1WrBmY589FQOcQVyZZ5MoAY
 GMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771323802; x=1771928602;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P2FSW7TknW+b+LteADoyHpUym2MF/oTqEXeTyal2WTE=;
 b=r2xJf0Ig8UX+kiQkj1L+8+HSdfb0N9v2hYeA9B8H0TEAbf+1mH5McGrLBmyTWpsYgh
 CnzIdFYjCQtG8+E993zxFhC8dI+rkrvv5o08c8m9g2lGBZMs14/kprJQNOMwY7PmRXSi
 QcQuKH2qdhd1Sv82d1IdaEcxmI3v2I4S5t+0WLAtE6jT1uu6H/joidpslNS5I5GANwUP
 o75vN2hLa0RrwNhF/vYbrPI+QK9lhiRWGM+oXCbcfhe9BO7ntEBhPb/PobuHVYLQVc3u
 FwDzX7R3pb+UxjbIRrS9/3+K+qUAV+pLD7ozTv/kFFCH9yzjftScBotdyakdl203XS6/
 LxPA==
X-Gm-Message-State: AOJu0YwxzpoqzyVk8O6t8/me3yRMUT/s9XmJgSaM/I56JD0xzCVfQZHM
 alHiszru77ifZuSbnhrDWcK0gBunwTF6j5yHpqYSi0hVaBFcxA23af9l5BWc+OB6niG7DvCpAY3
 aTVURyik=
X-Gm-Gg: AZuq6aL8RhBLgwSN/7fV+we6fsHAnamUpc0+VQFz8XDUK6gAQges9QDY6TzdKc2rB0S
 JXT3FIcaGdVl2paNykHzabUB+aY+FhriXPeK+v8kWMuib34UdddTdCqSt6AT+UczBk026+J26mg
 nw4OFOvZxPIDa2rbW8Xr+TVdoMLu+5Hy/ux04wlkj+AeR7W0WSBYOBFTYK1Y2Rqw5IvrGV0O4bs
 d2+ei8XmwACuZ1oYE1Nk75eSwDvlE1ikqpbxcf6YhXH8bpTUh+tdtgVAhkBjzJb2cfPBRDl+TDX
 GK94Ovy/Cqztts7BPmKsnsl2BQlzAVziLEqdUMB5jjkksQK7IbYIWexlGYPuo/HsIhiMnjdXnot
 h6enzpc4dTfy9S/sR7rSipw09h4wR0w+k/rFk8XwqRLjH7YGE6k04S6cGLcNcaWcok0RRvJr0oE
 YsELLEJhszAVHl7DNufAvJT6sId49+g27J6kQrPxk7aW1hZNis9uTM5syMQi7cUjkhb/seiNH3c
 hUEiC9KsV+88ZomJD8=
X-Received: by 2002:a05:600c:3144:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-48373a6d36bmr200869655e9.27.1771323802070; 
 Tue, 17 Feb 2026 02:23:22 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4837b68e5adsm307492745e9.9.2026.02.17.02.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 02:23:21 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 11:23:21 +0100
Message-Id: <DGH5VSH24OZM.2MGZOUVM6R1HF@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20260205121540.329921-1-pvorel@suse.cz>
 <20260205121540.329921-2-pvorel@suse.cz> <aZQytH7k6pVXqdsz@yuki.lan>
In-Reply-To: <aZQytH7k6pVXqdsz@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/6] doc: INSTALL: dma_thread_diotest.c: Remove
 runltp from doc
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I also noticed there are a couple of bugs in the documentation, where
kirk command is still used with the -U (framework) parameter. That
should be probably fixed.

Kind Regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
