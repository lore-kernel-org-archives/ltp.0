Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DFFC2A072
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 06:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767596089; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=0PUkcZmiATp82mj863foJLlX7SOQYnDAtRWyOqyOJSc=;
 b=guMwqp2BORRaQUChvD43D10HqnYZnQyQzSAR1qgPV6pk9xwAbDMOunXCLglSlDg01hodK
 E1Tbdtk5Z0wSsWnb2MH30ZqDXJf84gZppkgWp5OYKAOuJNkjPnlD7V92hAtAbaIxdvHZ80w
 SN5qFC9qBr37f15Y2okCeZvN44HV4OY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 874ED3C20AB
	for <ltp@archiver.kernel.org>; Mon,  5 Jan 2026 07:54:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2C6D3C0528
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 07:54:24 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 41EE6600436
 for <ltp@lists.linux.it>; Mon,  5 Jan 2026 07:54:24 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso12709345e9.0
 for <ltp@lists.linux.it>; Sun, 04 Jan 2026 22:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767596064; x=1768200864; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj1SmcJgNxrvHY8Ht7XVssrnuBrCLqJhe+LhMIBhyYk=;
 b=JOhJt4cTde0R1QZkXIO/x0vRHIFUuV61ujRL0BwudFEz6282YuEXyKJ8vedeARfE/3
 qGtElc83fYL7u/l8zssbvGBiLdiKzdUbNlGXN6xdxCnPD0ueWoheQlh/1HFvaKE9XqLD
 hZb4T3Z9rRD8nk+bbnHZBPdlPPBT/0bTULrbU6bGmDok0mbAk6az4Y2671ZlE6Vgk8R2
 QjWkt0dqcAwnizmZsMLHLrI+dN9X+O12wNcoFWfIoF4v/3pdlJErP8uv1EG+OEUUL9cv
 DI0ALBDdXWowC5KXXhELrIM/NiD8iQNSFMvBcf2TkDOXwMPfUOL7SzoGxFGMgctEjwGG
 H4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767596064; x=1768200864;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yj1SmcJgNxrvHY8Ht7XVssrnuBrCLqJhe+LhMIBhyYk=;
 b=vohIJ8QV8M+OqbEvqzP7kpU/2wP1Sq1jrnYKtBlAL5m1/K4O9aL4N3RbWQIMw52hCG
 8E0pjsFAaePH7o0dRZ7ulOfy6RaYGwqKYwQLqhTj5nRYWP06n6M4nU+P/MC+D0U/GLTZ
 Aox//aOBdfQFRU9jGdLRc/ZJCSPqh4JnuwzPtLKZpymZ0P9IUCDtC2eRmyuyL4uB07BY
 Q8HfyYOGLYaEibHMNK+LDNc5pTjnLi2YoOvYfn8OWHgMKK7EE76zgdeVKSM9CjAxJQYk
 egS+X2N807wCFTCqJSEZGK4YzLXTuQaLuNrmchtSV7IqLtz8FPBE/alCVBLjkH4CXmBw
 7e4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Rx7xNcEkyDz0XAdsVFf37rEHDE16LcXOxFyznFHICayFXwZMjux2TcuO/Y5xUGBYkqU=@lists.linux.it
X-Gm-Message-State: AOJu0Ywl26vVbacQXUO0aFEK/LtobaTCZkHANQCGqrIm2N9+k/ZF9Nn5
 sJ/5Z439xkCP5+oljNFZiCuYbmd4Z7O86PTKtZVQIeH+a0vylETh+bfbDG1jVf3lOcA=
X-Gm-Gg: AY/fxX5cw1GknlrSzDysydNziwO1BhFXrh913jH6NHezT0BtYRQcIaQZbq6IZNr0ExY
 H7D/zWEGGru15ETPWWAhyNVqRezf3zArqQVR+ccMXn2Ob8vPG/9MRW/5PRVV3w/zYmEj/w6aHqt
 vFw5OH+dZiaN41Htg+ybTCdp5QMNiHOrpXngZB43KLyeLIGvAxbQc3HJAgqRTQZK2bX2doSlq0z
 GImHhPuy/KmN59JqLRTSbu+6Ww49VGdbye+hAdWDuSGpscgBMegfXjK/JMQjGdzD+SDftEdHUc+
 ROuNDMYRaMK6g9DmM3OjOGrVAHCDKaK6FdIhzev8PAaCGfT2WcN3S1oNJhzA1qQsYNIB9Bvj7YJ
 wEhdCNkRyc9K9fzTobVzkjEbEx21m19VedfD8hgBT/zkum+/4cdi/q/7DK0+59Knsccc5e7/hm0
 BwQkTHRLs9eWzY2QU=
X-Google-Smtp-Source: AGHT+IHa+5JRG3Vy6s4FeZcfgc1Dt8dB8s9OjZwVilgBP42djzRl5FSrRsgIqkbiw+tq5t4HEG06Aw==
X-Received: by 2002:a05:600c:3b24:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47d6c09febemr84459635e9.9.1767596063642; 
 Sun, 04 Jan 2026 22:54:23 -0800 (PST)
Received: from localhost ([37.160.215.201]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6b9efb7dsm56671835e9.0.2026.01.04.22.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 22:54:23 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 05 Jan 2026 07:54:21 +0100
Message-Id: <DFGGICEMD01S.1HQUNM21IKYFM@suse.com>
To: "Po-Hsu Lin" <po-hsu.lin@canonical.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260102115147.2256900-1-po-hsu.lin@canonical.com>
In-Reply-To: <20260102115147.2256900-1-po-hsu.lin@canonical.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17
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
