Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D406BC5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 11:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749122302; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=WHQpuyFHrw9tCyW1p/ljLbZqR/j/GXZuUuIv90P+vUA=;
 b=cXCNNJ3t+NguHeXxaLvBFZ31OAu0Gr7dJUyP9Hipdxn/PO3QCGfhWzw2Q9ImfJRUdH2Tx
 PxxYmaiAy2Ho8kjmc1xU/icr6W9Hzij/mrv8q8Aqo7ciOIUmP+zq5pduKu9PBU/bupqhILm
 veNC52uAYCh685RPE+JUNRD+cJkBuiI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B05F3CA327
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 13:18:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4390E3C9AF7
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 13:18:00 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD8B32001B1
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 13:17:59 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so708973f8f.0
 for <ltp@lists.linux.it>; Thu, 05 Jun 2025 04:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749122279; x=1749727079; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
 b=SGkHp9NeA4nEoa9EbQ7H5zMtIDXx7Wn0khoVOCXGE6ACZLWj+TDT8JzPKpD10cXRBT
 iMM5YzK1eGbCdsXaj6PfxrQm9M2SjT0jG0SAZvgM/tk1iRZkQHbgYHNnMMHkWL3uIkXV
 ItDUbYGVM/28acT6nmaYONsVEOgCy35YGcS5ySReo/zg1UssKOB5r1bSaUZHzORnHKIo
 H8MHEEaNtPbS891ePZUc7hvqTYyO/vM0VPZsPQP94YwenzSfM9DS7TebjIxufFtGI/cF
 JQ9O4PUmlHMZRZ9yjn+dtL8q6xfESZqGNFgah2XnatDPjPZVI2GXI0pxou6Pq+8alrwX
 Ai1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749122279; x=1749727079;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DiLFgGEYWV08VMwsx3D3eD3Qjk9lBihrYpCcp2CM0Zg=;
 b=mgExzlo9kWH5qqqtM0gVojxWT4MpOsm+k/elbiosCKdte668uBPlCkU3vY1xyQpj9P
 vceL17pQh86eEARXJ7nPN8tCXU41FCrfiyH+lI5Y6mqK8uQNvL9NQiBbOCg2KNA6ILZU
 IH3q9FlH0ttp9FgW+nT9LCtAmyyN/XJck9I+2VC+G3fJiBi064nLeTpMtiGh+xSQW0Q9
 iV/UptM0YxzqqmP7WuZ46LwyaiwpoNNtyJOkv3itS5NuUhvTCzkZqSb5NXXOCzIXuO0K
 x34LlS7Qu9RVyIueBtUwq84HiqmQO0J6wQtAof5ZQqFLcN7/Hg1N6KvkDEEx8FLK1yPM
 tdbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMkgsViSA0To7Px/9eR8LVbxrQP6TPqpIi3KmGyp2jyEkyqyLU/VOSDqc6FPyqrNBjENk=@lists.linux.it
X-Gm-Message-State: AOJu0YyeNlnUDULYVa1QlCOQQ+SyIKc9mNCALLE1wppO52IIhyNFqiaL
 t+4/EbeLAEaa7OALpCA1wCe159cBJ3kwtGKso562FoqKrSPVBRfXPBvew1dXZ8c4JYo=
X-Gm-Gg: ASbGncvEFkNAB4B8FbJb0K0Ih6CwlOC/1f26Xm41r+B7vwM6f3Y5UFb1AtVECmwA+M8
 /+hE0GkgSXv2n77KOKidtc8U1GYSCleX55ewHx3WQEWCZwkmzKLYKZEoKkf4erZFggMrSdgnHAY
 K8ILAzrvrKLRaWoOsZT2k+ntKBYYLoJpskzjmI9c9ze95UR4XLuRZzNT+RzpVEVbuloUsZkEVa6
 OlLz1Y9zNnJzmNBt7uwtMrCVJzXcj0+CM8F9Ca3PV+SjLYWQDo9b+uJiEepS5DN35oT5JV8QsAY
 lAI3BSkN9ssOXgeqfWtZ0AX0HhecJy7mapSPiCOTtGdh3gNfjTMIIeeGDQB3V0j6378lKVXVePT
 ZMbFPwMxHOeL/nxsbziUi37vawQndP0nV4a1DGTcIT9OYmlYCSw/lMwjjMXw0it6aGmPRLCe2/P
 YQ1Ss2mGSDkZ1gPA==
X-Google-Smtp-Source: AGHT+IFP1EjV4E9gaT07wfw0ERePJcrU7wPEYwd/wMsMGvhyJUh1OuBGGMFWyOWpV1cSM0QSIQVL9Q==
X-Received: by 2002:a05:6000:18ae:b0:3a4:d953:74a1 with SMTP id
 ffacd0b85a97d-3a51d92f7e1mr5369163f8f.23.1749122279156; 
 Thu, 05 Jun 2025 04:17:59 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506bd93f7sm117204765ad.95.2025.06.05.04.17.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 04:17:58 -0700 (PDT)
Message-ID: <b15fa0cb-e893-4642-9aa0-05f732b75131@suse.com>
Date: Thu, 5 Jun 2025 13:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Wei Gao <wegao@suse.com>
References: <20250605142943.229010-1-wegao@suse.com>
 <20250605094019.GA1206250@pevik>
Content-Language: en-US
In-Reply-To: <20250605094019.GA1206250@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
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
Cc: cgroups@vger.kernel.org, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
