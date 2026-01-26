Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F6AC88E77
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769417269; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=0PUkcZmiATp82mj863foJLlX7SOQYnDAtRWyOqyOJSc=;
 b=GwI0EsCpFx/yvmCEaVWKzl6OxR/4udbgAiDOrwPjsx5xKhCQlTDrlyf+8RoskuRRpLX2L
 xYpQtPBgMDCbss2q5NGPbQk5yfHBuUKlini/LjVBKLX71pKiczqqkW6mH9ssa8e8yovq33l
 7eihzUzsUDho87nIi8LT1XFV76/P/N8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32AFE3C5489
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 09:47:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51DA93C01E9
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 09:47:24 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4265C1A0068B
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 09:47:23 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so48787385e9.1
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769417243; x=1770022043; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yj1SmcJgNxrvHY8Ht7XVssrnuBrCLqJhe+LhMIBhyYk=;
 b=XSc8bAjx3OKkLj6x+8eHOWwfP7iArl3PdSrbdEB14UqpGeE9NkicOZD1I+K3J9LCop
 z5F/ttpmA+CoVA0OH0RmxJJJszTuQSzYxj3GkovSxUeOMkxvgTVMVe1FAzI8WbV3Nona
 mytRCTfRFP4owfYxv6H3A67CuHSP1MwHS4F3F54etVgE8crrFeWK4ykf3XweywxsgiHW
 VyRd2bRyIL8nX767PZQmldoXp2smWiqAxdD+SpkSXGwLwUc4y6Gp4Ry4eiNKiBCOvNe6
 6RJLzU6JWKKCkY1u1EJ+3Ow8IRtk2OOlCBfrHoc6mmF08y2DX20Y7UUaS5FEKlKCP/vD
 FW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769417243; x=1770022043;
 h=in-reply-to:references:subject:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yj1SmcJgNxrvHY8Ht7XVssrnuBrCLqJhe+LhMIBhyYk=;
 b=oXVphiWJn57O2tTMtn0tkgGuOz/O9gDVxct9jEXilYsZ/WPWFFTAzviMYlQJCxA73j
 JYXPWO16VaSNyAusyNHAD+x1C/y68lSB3gUcqSzCDbteRovcVa1TDNXLq3aUweiMH4yq
 FcHTiiKzWgSZfX247DE84duBYcOM94h+jwz10IYHZFgDSLHqSYLMWnXqM0s6xqIwJWu9
 QHlcMyJwc4doQCv8ppsDZ59CK9jLMlQsucKvvfzO7ihSD5wtSW8pu5RoZu2A3UrG0eAs
 IDiO920xpa7AJ1T2fM8WUnnsFSzIEttI0aWcH8GTmPtJQF9F/OISF5uzWkrc5HlMrtdG
 7C7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAs1RZrOvO5mvjIC91X43n4KvOwmAv0W6llNxNv9mzHp3F+0CemHK8Ftl/tcOY9Pt6evg=@lists.linux.it
X-Gm-Message-State: AOJu0YykXVXQnMLZURdaEDZt2GCtnpjnUNCHm5Kuohk4b3EufBy9MdEF
 KseF25/A1vjnq5GTB6mdC/neyXV3aAk0BdK7xrZjrwuY39SFqySWp2dbpezgBjtZeT8=
X-Gm-Gg: AZuq6aK/HCMny70nQKfIguE3bDjTTZLyDqlCEhTaeiUPNt3Tcf8CxZR7CYarjM/Kll8
 SNYaJpvs4Eem0O1JzPGutULZVm0ocnhbYznjo5CdbzPjfIhJZoykcGqaM8V5ROS4u7+r3eDhLYo
 pQR4/HQWVEzYlN+kDhfqiJFqOvE8shZX9P5op1Vr7okGY/Viwn3uOZjrriK/vAuJF1wTEo9iiEt
 +9xXNmLhPm5fOqHQMUfTYTDUbUhPyIUl59oX1VZiF/nf4amAWPyGvuMs0wnX2P/uBpJYRJ+dzRD
 S0MqbqKcKUhLeJCOGEz9nFDWLcApWCTuVdrcnbMpU/kqXmAf2Y43lwe/CnGYrSpZw0R2W/Tpsxe
 ySK1K2dEpKVPyc2Wihd8z9j8LUExJVdP78gOXUif/pOpDEpwsNgo0K1vvSshYD+x3k6L+zUR3NT
 2YDi2ZkXYkiljfGPEMMGrMetDoYSYAuyIyB8cIF68Y7R2gufYXK5PZtLCMOAzqDXuBVuZCzMVri
 3UO5rg=
X-Received: by 2002:a05:600c:4ec6:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-4805cf5f167mr62374555e9.22.1769417242532; 
 Mon, 26 Jan 2026 00:47:22 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8bebfasm298722115e9.14.2026.01.26.00.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 00:47:22 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 26 Jan 2026 09:47:21 +0100
Message-Id: <DFYE2B8PCNRI.C7NK5PJU4YW6@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260122175354.83833-1-pvorel@suse.cz>
In-Reply-To: <20260122175354.83833-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/tls.h: Cleanup ifdefs
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
