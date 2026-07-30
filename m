Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696FDC54FDF
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785404756; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=aE0bsMwIk5+Q6HnTDNrtvQfAfHrczTGIVr61SPzky7I=;
 b=di0lBt8GKxwQp/cUdVpqAg9fulfdXNSpUHEn8nmXijgWx55cqiqpWtU2cbNazxbbwlKDi
 KV44El6gGuYB48vj7TFzkSLo3fTQCqW4JCpKjixkMfoyZVVAqZe4v9CdIU5VHNvoeNqHHnv
 b/KUH0UvJ/PIADMlxBnD+PjoPyVK+90=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEB323E723E
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:45:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 250443E49EE
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 11:45:36 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8BFF6100034D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 11:45:36 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so15407945e9.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 02:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785404736; x=1786009536; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0cuyzEYIuN+7ORlVPKaROAQcS/HkqVTcucyFnaIdEtg=;
 b=G0ny2ZzDKVhyfCbzB8NaLuP5tqx7lTstyZ4ICmRXjpKUrsw+9ZDb7d+g9X3UZ6Fyou
 oflkeVs0PawqEIp7y7ICGtKseU1fBU5JTVyApmOpJJs37diQ58QrPgrCoXJaIEoit3d1
 t3h9xggiCe4egM4iAD1y/eNbxVc//aIRV4DyIDQ0iPo/gH9zPbfilo+y86EOKwUf4JxK
 HzdHTmiXy+AUVoyucNZCyikOFY/HRTo40M322WAr1iv+B84BO7ULJ/hplb4Z5utfh0RV
 kULho+B0iSueu0p2TMkyq5fczhd+z6zH6RRILEFjERwbMZUoKcif3f5FEnxaIQU6O5Mq
 Vxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785404736; x=1786009536;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0cuyzEYIuN+7ORlVPKaROAQcS/HkqVTcucyFnaIdEtg=;
 b=FtB/lSHkUupGy0fd2sgg8ESZH04Z8W9Kl6AEfDrpHE+KD+Xe6uUYZPgDWf6utthJGe
 B77NqKuHb1wkXrxEHMel3qP7q8pn468fMNvCx6lWZM42XMKpKA0tbcO1fdDBAdHrPMWi
 c73/zeEfv57VmiU/CQvGNnK0UtpGQ02T1pObkjrJyrF0B0xvAeN1tXaVHO/StJdWRPrb
 HcK6tM53/DvV3pY5e02QIkssWVhvPw1aQzQDF9FwuQ4mL0q0AZpDbmqDvSKEyuthLwr+
 fF58Tm+Nct8g6NcxiaUrXKbj/PDXirtasfj3Ms9qUOuXz1NYGULN3M6UGo0PpamrAJoJ
 R4lg==
X-Gm-Message-State: AOJu0Yyh1fzBCnJfyZsLPKsDiLlwz7zwyPHNgEx2rwwoEI2+wQUJshZ4
 XBW288pwY12KEp0D5h7rxNq1GCsBU4XT3Xgaz7zeQ/hxF5vbSBnezz58+EoCcR9d6sjzmAeVKpu
 vstfkZ0fRzQ==
X-Gm-Gg: AR+sD12Tk5SoNf89T+fSRi+UEQvkHhb2zmz+yJmDUkGgAjEhSfohcPG4mub8K51sdhF
 OXogNdMoQCFQrruSnqTW2cEB18/Cp2g93+tv5Zc4GpjWhJK8oQekipGr6QDFm+JWNX2OVpBnvuE
 t1QFfxLWnBnRKxf+bWHmDkNqwMdEyH38Vl4bm3VRkHbDcOPZWNvl0FhVkV+stpvfKyrFBwg9mng
 uNcY3XR0aGQH12Tqmo4N215VpAYtusCzqfqYBeWBvlgxVNgV+68zWKs/GdsDAPCEG+kAB1oiuwp
 wNmOZhFS9BgfKhZYceNrstGaGbxU1FiLA8Fn+uqf1QblAkibkYTFBkDMFBcYNSZSSIQuAqyflE4
 Zl6kZIhlxBnloeNJzn6CY5+6Y+4Ndniy1NaHbewM4pnLp6pMlkNDNfdHxo8vqsvYhLbSitxH1z2
 pnpjUvT2O6kQslZE/591fAuJM6D3HRw8T9XwvpzPL4Rb7k06PSa7ZexVnV8zDJBr2s7uL3cJ6kR
 yTFNe42d98X+r+7M5zJX+z7i39tleXUXW1MlGZ0ixYAgZD6OG9Xl1c1eKsTzBER2Fwoqmw=
X-Received: by 2002:a05:600c:8b26:b0:496:c06b:9fb4 with SMTP id
 5b1f17b1804b1-49800e93e81mr22479205e9.14.1785404735846; 
 Thu, 30 Jul 2026 02:45:35 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d6f4csm5356269f8f.2.2026.07.30.02.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:45:35 -0700 (PDT)
Message-ID: <6a6b1d3f.18b7d65e.2fa147.0e3b@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <20260721202452.315581-3-japo@linux.ibm.com>
Date: Thu, 30 Jul 2026 09:45:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] ptrace: add test for /proc/self/mem write
 rejection
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

Hi Jan,

> + * Copyright (c) 2025 SUSE LLC <japo@suse.cz>

did you join SUSE? :-P

We don't have a no-AI policy, but at least review patches before
sending them, thanks.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
