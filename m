Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA73C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783941115; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=uCmWmn+k9lK9zCuWCq+BrYfSqp+ex9HAiD2P9ky8y7g=;
 b=CovOl3zirGTbPsXJ2FjXiUqVwQUgXPyQZTxWCOKZpL9Ke4EDn55JvhXKpbg6tgkskFqSC
 4zV59bSuPlIoF8bCaDRpykmfmQj3rKYI0878RZf7ZOQu/b90c8pNZ2ipmWyq6aqddMrlVjx
 41H+rxO1q9ph4xmEjFCi7yVimESY37A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 618B53E65CB
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:11:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 630A23E5BA1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:11:31 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AA4D51A006E0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:11:30 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f36a122fdso1035962f8f.2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783941090; x=1784545890; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0SIFR5lvMcPuFa5zCLTUT5Jy/85YOraoP2LiA7rk+hE=;
 b=QkmYpLQADA7n2X3dIDASQG+tEOLoxf6DEwWRXF51GyKUx0WkXR2UxiUgD6eLm54dgP
 /Fs+uEuON9qg5ATvtXAXqGXnezlHUYlzQ+wb9Rq7iELvaIq3DLBHB/W1MyttwRpIkJx+
 VtpIclZNYinfgytvkyCzYQ1cLopbmk+cG/DTVGNWkEuug4Jo7qjLInq3FbRT4b1ZPi96
 G6ukPjerrtnwFVe1r/FYIKrTotLDKRAziDGD7f5G2qO1qSX2BBJ79uuhlqtoJCPdpVG/
 OAADhPeZzfnOXDAloEMYLiLURcB977W4WCq0FJLkBrj3SGtPSPBay8M4DozgVQJlPnOO
 /oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941090; x=1784545890;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0SIFR5lvMcPuFa5zCLTUT5Jy/85YOraoP2LiA7rk+hE=;
 b=hAsojOHie26Rkpmc5fO3kIckF6xtEE4LFxU/zDdHI3i3n81dqvWcyRuGL6Cp4VIkBq
 MNjopPm0k7J/B3STbx0xHWirruPbzs3redcvS/BfMZxnLRML6B+ZdPZksqEN/EYmSrVZ
 I0N/Z5SRaGolQJV9wveaFfg93AMZ+Qh5BC30UsWI3ktyvYk94ElaMMnresXAh67kEAzY
 B3zB/qJNqZ8E20TD6c9E17PVt0Ld0e7AOXLFxnHvjb7lZz9iC5j/APfniHtnFaDPChNB
 hSN/IPyXcufKUOSxrNLXU8f/3tk1fBN7Hy2TuUQC82Q4xOZakoItLGNZNlhLsYxefPSI
 Z7SA==
X-Gm-Message-State: AOJu0YxV847JNiWzi/3HEtNzbMVLUlA58nsfsFxmpqIBwALltL0fvVN6
 VhUqlghY5ai+3QzYD80XkEx07PbxfRmc6Bd6LOawcSqpjGZfj59fyV8EiqLGFvFh+ryc1zyzgyk
 PWBbzHjuG/Q==
X-Gm-Gg: AfdE7clJ6V7+EYpeXANUbafsbuSOtLXQa+1dwheeM1OM64imYy278vrEzzS4/ifvYz7
 UxQpcCLzgwX8Hg7LqiXmnvUt8y++YqQxDTCbLOsuWvPekf+Jqnm9tQ5V9Lu/mI4Oltj8mPxg2D6
 GeqWaUOqcReC9V4sswAgsB16+Ce4MoIDBG6NtP+6EUfhvHexrP5uDD7d9Pm07Uz/HZ/NjmCZYIx
 0869aE2GirA3rjBOsVzw3KjlNRiu0Z9Q5+l9lyBmDJ6KD8VP7RgmSfGvJK2u5ppEKNS9sgzIosN
 8ggPpYaU+pJoqXJ0f5nC08xJSNN63fxx3VrrggKuujrkR2WBQbJrlLaVXglBAJ/DerBWVLFL0Ne
 9KSWjB3LDi70mvW+pB+qBGAvlyB1tqgvDIgrqaRDZTDgEwSLuKpVKcVPQxSL/exmlaoCgfbuqV9
 Kv0/JSPz7ARHY26Hs5cZLfeafb97XLys6S
X-Received: by 2002:a05:600c:8715:b0:493:a96b:fa0b with SMTP id
 5b1f17b1804b1-494012e2f40mr44760415e9.24.1783941089896; 
 Mon, 13 Jul 2026 04:11:29 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6d4f9fsm364509625e9.4.2026.07.13.04.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:11:29 -0700 (PDT)
Message-ID: <6a54c7e1.c5b9c171.16682a.0118@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710055556.1109220-7-pvorel@suse.cz>
Date: Mon, 13 Jul 2026 11:11:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/8] build.sh: Add support for test-metadata
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

Hi Petr,

> -if [ -z "$run" -o "$run" = "test" -o "$run" = "test-c" -o "$run" = "test-shell" -o "$run" = "test-shell-loader" ]; then
> +if [ -z "$run" -o "$run" = "test" -o "$run" = "test-c" -o "$run" = "test-metadata" -o "$run" = "test-shell" -o "$run" = "test-shell-loader" ]; then

This is getting uglier. What about this?

if [ -z "$run" ] || [ "${run#test}" != "$run" ]; then

The rest LGTM:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
