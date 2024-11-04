Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB675D111BF
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730710669; h=message-id :
 date : mime-version : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-transfer-encoding : content-type : sender : from;
 bh=TN5djzzl6/bZb4kFxVwjZA/Tax5PcYHvjNmlHLHUXVI=;
 b=qxGXtODPhj9H8SpPWOH3LfCoRamGgmsqlHOU6TKN7bKyNmbsLVAvVohhFnWVmnRYoA++s
 eMwMbIwcklmrqPweL9ovaZVgDpTgblmn5HJgI8t9pLf5/vCBDvrvy99jB7XDuCAFnQVQYER
 iWAeGqR8AK6SG1l2eYVpiPCH6WGC2eo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41C4A3D038C
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 09:57:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E61B3D032A
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 09:57:27 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 06C6F65AEE3
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 09:57:26 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d8901cb98so2963699f8f.0
 for <ltp@lists.linux.it>; Mon, 04 Nov 2024 00:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730710645; x=1731315445; darn=lists.linux.it;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmdj5ROEa/IeppXisX8XSO1BGlwchCUeXjD7O5bRI50=;
 b=YmC0/+rHAaslqZFkkbupaPAZJ+SrsMAxy9yQTcGzs3jMgG5Lhh8W6jb3sKpnkxj+KB
 vv34SM6liRgw1GK6x1xd0D6GbG9jexeId0GGWnSCxafIllN4v+PBrBWB5q44vgCeTewZ
 1N0cptr5E0HGFve5pGMj4EjslHvJP89oohjOPOtWC+SSf9DZE2EU7e7NpyQAO66S14Zl
 +E73bWeewkpRuDAOivLSukG9JyJRyy98/4b6xvrnLyDc6nodn4BrmvXeNq1NmiQzkZe9
 KdhGqKtvOUzoYBRRun9EmF8YgTBobiuh8PwlgM0o54B5YBTcYR0ZRYpJeWNfxXtZ08S0
 8V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730710645; x=1731315445;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nmdj5ROEa/IeppXisX8XSO1BGlwchCUeXjD7O5bRI50=;
 b=nYvyRcdqoX1p+36T+DOmHF1+e/SMrjv3H/Z9cVrvGWpwj6oG+EzbhUuZq5iCfhCWny
 sT5t1Vc7kviCVYapAeI5lX0V016f2E35ifWUFKn1H5J2InY7RosO8n8SIlN4kNJY3CLO
 8sEjRNbxklB9zJ0ZwOwZwc+SSnO5SG8WE7zXb9P3BNxnlOo3SfGjLsTeZLw2TdXRlwMw
 tfzkh/ax5vNZOg539ktNJvHbtPZ1BeXjk4WfDoA1+R/RkrZXAUv42nDo+RPxi6Ctpyzo
 FS3c2Dor5PIpQKbNJ30gx0OWS+iMoNVoq6cYx7lwnyNlyX1lJ0LTMaZPEuNKM4NZ+V0L
 dvRQ==
X-Gm-Message-State: AOJu0YyA1lTenz/DUCJfiI4py9nz8k8zpbSVZ93uSW+fFNovkoEJnP4X
 XeL+gmH15X1j6f431jc0lXHZujJGJJw/zav+KdrlRe4uAOgGuEgwcLpayn5pP1XdzRHOKyatAWK
 X
X-Google-Smtp-Source: AGHT+IFgdGkbPvZKskwQT1hMHG2IUidNr3DLN6ZjDEpYmqenmo1WYzNNpnfs+aRel/K36wDJVS3aHA==
X-Received: by 2002:a5d:6d82:0:b0:37e:d6b9:a398 with SMTP id
 ffacd0b85a97d-381c797433bmr8298291f8f.9.1730710645133; 
 Mon, 04 Nov 2024 00:57:25 -0800 (PST)
Received: from ?IPV6:2a00:20:6080:67fd:6fbc:226d:733:4783?
 ([2a00:20:6080:67fd:6fbc:226d:733:4783])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6983b7sm145068195e9.43.2024.11.04.00.57.24
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 00:57:24 -0800 (PST)
Message-ID: <10cd93cb-4514-4d79-9ab6-e33e2a08435c@suse.com>
Date: Mon, 4 Nov 2024 09:57:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Open LTP meeting in November
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I was thinking we could have a LTP meeting the 11th or 13th of November.
What do you think?

Best regards,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
