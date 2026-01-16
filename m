Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A87BD4A609
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768551546; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=GNp3Z60OiFdBChx9jGC7Tfjh6RmgeaurKFn3BnIqVfM=;
 b=kiY/4uk7m09ExlDpe1ihJmXRoMF3DFK6fYP4MZVodbGU1tmbiYUrBR9Or3R+wTk3I2lTT
 ELqQ8LbCIUo1dC0RKXqJL4ioMmTTsLQKQ+WgqPHTBPF/ukM6UGdnTVSUQB4KG0YIdWYir10
 vtkWC2EpVseG2r1fiWFhdUmyWkayyT8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D23213CA510
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 09:19:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5009D3CA4DD
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 09:18:44 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B5C714002A6
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 09:18:43 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4327555464cso940947f8f.1
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768551522; x=1769156322; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgQ1M2V9BYJmtrPdeXLX6wAv9mEO9EfXm88jqtUnb6Y=;
 b=GP0RoOB5C+YrkmuBN8AbxJrs5sjnxK/LXD+iVWWYjeexO/SvGc1PEmxt+4QyRXxu+h
 yQihHMQwDhxp0PSEBp32zY5aS9chj43YrtYzlBrN1O/YDs9lQiugmgqZF1whalZf4bPM
 lUP0OgdhmcqptcdrP0ZAOn0iwIp2SrdXdcKy7sDLiNOJG7FKGRWQqsOEczZtCubqu663
 twlfb+1N0rkX621xDUeYG7CEkwB2uF/E3XVt0FWpwEIkqlewcFO8opGkwjusuw+p9wxa
 9W+NbAlQiJHZbIqJfpA16JERYQRkYJKgpNVxKJ6ZDGh+FehMEm5N6m0866jVd1VC0re7
 VF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768551522; x=1769156322;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NgQ1M2V9BYJmtrPdeXLX6wAv9mEO9EfXm88jqtUnb6Y=;
 b=EkHYoiu38FdPY//3qOeYJZXXn8E5eTuCnpI1xscH8LINsTEuydL0bca7mCP2wo1YyA
 ODOxe7fb+SuJpJ3CYoVhWpoTEsAeBj6UA/SO5xjSBjD3m3r3VNG8vndzU83NMcpaEL75
 XZgHWDge1YdxFIXE3GLFKzepfG3qz/5ShkwscNuJRr1SPitXJwwlCioEcxG1UjtlsuGQ
 pzezSDgDzQC9/McUt5m5rplAMXxDD4DkrbnHtrrghuxBFI7FhIhpNi4+4gp3NG7KVLFs
 lRbfawoK1Mn2ldDwoCREclhT3gPqiKzy3dMEDl/hOzyaLFT1rTBsPvhnY2UtRrMsen3B
 8NUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbsKLPZReXfg1mF3ljVq3Jrv900E8lPfU1/GTIYuBsZ/SgchL+34fvX/C/8o3OxOJbwa4=@lists.linux.it
X-Gm-Message-State: AOJu0YynE+WvgHlOCwOKeDDV9/ngKS1+E9tihFh+Lk+i4XWb7smMT38m
 pOhxrGeE607bAM9pttllM3ybNT4YqAVyqTnHjL72/xi8L3gPPumljW5N6ziV9emW6NA=
X-Gm-Gg: AY/fxX4vUBa9+twoohkz5+aQXz+Kr2yyRe91YVh0gwXwLexP3VUYhIDfJeTc2ODF/Sa
 f/gOcnXL3hvVTCsufwHLls/46LKTgxjvkjdz/t/wcHXFw4uJ7M/PAVqjjc373TZ7BFbFXyXQXCp
 1zNggT8dR9ph744ORoskSuUFlaozgTWORSth802TIsOS2QmCiJs/Zvxw59DnpjqSXPSIuiHP2Fi
 dgZN/NyJz/eE0m5ZpsY47mK5yYzlcHpwfKXQNNewDT0NtHSOeYbqALzWLayLplQdVX8rUEmH3EG
 6FMA7mJgISUQy+1G2M7/Gf4Tv/yug/91JnFT1nee/nQgJoarteAe93FfdwneovWMkYMGDkxq3Cl
 12nUsw6Zw+xfp/SvJsl6Tn0BvLRgZYd2u5OcThHNCMS4W/LpVed3Lb+JW8Mq82cxsx1SpD/7vry
 zscOTSXvsZOWZCv5nAR/ecTR3JvgR2lcvWQWef2r6702TCyKApGKap8+TK7S70hm5rep6rW1Wgm
 PFk0e0=
X-Received: by 2002:a5d:5d0a:0:b0:430:ff41:5c92 with SMTP id
 ffacd0b85a97d-43569bc8784mr2636850f8f.53.1768551522500; 
 Fri, 16 Jan 2026 00:18:42 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992211dsm3715990f8f.7.2026.01.16.00.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 00:18:42 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 16 Jan 2026 09:18:41 +0100
Message-Id: <DFPV6WSR7QGM.1KW2ZPT63FYKH@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <aWjZX0fsrTJMqq49@yuki.lan>
In-Reply-To: <aWjZX0fsrTJMqq49@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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

Hi,

I still have file_attr05 pending
https://patchwork.ozlabs.org/project/ltp/patch/20251014-file_attr_eopnotsupp-v2-1-c9827c8d8127@suse.com/

It would be nice to merge it.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
