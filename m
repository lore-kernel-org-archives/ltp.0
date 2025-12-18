Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74A6D6ACF5
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766063534; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Ant4c1SKbv4jyXX5I2R25n/51dinmrF0io8ZZ6+e4Tw=;
 b=nq/LwLDtaBHBjreDyo1UKiXW6XtFCyKmovlFMf0KNiL0xDVTNWYlS7hB2LxOfMLxJ4Y1a
 24CuKniVd/FXFocAYFNfmwlR2x36V/r1LEJuduCJ3vnGAcyZUKdXEJTzZgGqm7Y+AKt4pBz
 ySJV4vcg6m8Eq7zxjAfZL6Wu9CwY4QA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4009D3C2B90
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 14:12:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8AA13C2B90
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:11:51 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 05F311A00CBC
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:11:49 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7a02592efaso86619466b.1
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 05:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766063509; x=1766668309; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJaoFpUNPT7IBaZM6XCAmkC4xlx4aZKkr0oiBZmQIhc=;
 b=DCIXsJuRCdy2V3TRWuegbh3F4ukfU0AR8IyLhiRNavN0eEYFXsf5sgZhI8q/k4czdd
 pp2TFUQzg0thNyFMMkAcOIpiaB3nWmBmOGjDq4lzeECSe5JsOuOJSU76h7fAQUZcXWHV
 BQHSGj+YVcEH1RCGv8/MRoFJiDYA0ucOkpCZM6ila1q/eB17wiUl5GFnUxIMEZFggAGW
 +PJwA8Me2mtPfHHY/7GpQLFNAYImJ3B3dqet1uCUybOQ7cwYp28H1sWETXO7j7ENNHkA
 kNi2PeX92ZP53i38zHsRscUZ4CveEnzPmpA48QcSLQTq+eclPbK7SRXFPc/CgDRkEW8p
 Txsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766063509; x=1766668309;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eJaoFpUNPT7IBaZM6XCAmkC4xlx4aZKkr0oiBZmQIhc=;
 b=R32q4s9UyRidh85Meul5dy0b1uZUhlbjRQSGMmXxqhYHIOPVmw0bXDLuhnH7G95Zvw
 LN+HKonTP3SBAKvKRfhnSgcx5/CjwBuBn/1hvqgUFefyAMsg5dBLJka60Xy+02JzB/cn
 thcIwL1WzoXS6f/JF/AFB/9c3/aDOu02iEc5hFJcyK6nN2l3ezVaZ031TEhbXrnGcIIV
 41CkTGZHgNEjt26/gLReYJUI/b0O+cWjBJXyRuZ9I9cA9MxkThRottBTIJWvuG0LD1FW
 F5qRbTaqRGGTkKJK0ewaeGW4ZwNfufz2HMmp7TxAXIW42iRXwZ7H5PxpMnRVdHyUwnL3
 8yng==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7oi+XbJ8QxTuwMoNUlEw1Uti6J9bP42wvZ9Z9/kvQ8KemmI7Nu9i04UHU7vHh0ErH5B8=@lists.linux.it
X-Gm-Message-State: AOJu0YxSPblNGR9RPOrzx60yvS0vQI2u5gLm0L5hZLFNucFZd4GO7Ej+
 enkzivNRkpEECC5QUg5TIPdQAHmvujrSwebO0GKuTE52eLnNJR5l51EZAQlyldlTsAn8PnjOyOj
 Jz9warQA=
X-Gm-Gg: AY/fxX4Luu//wc2/x4xiVuR9VlMFJ8uAZyiUddW0o6Ufx56FUShrv4k/U+/qyp5VWZu
 p+3BVlssBUNmqH+SetYIfq+GNKT5yjkBd9StBwEkjpywCay9xKGBex1Tzpt4hYTVbq+J2ZypQRQ
 +qqI8NhiQ2oL3TX8h+wObqZZJfEOcMCjOVvOiH92fQAki+5Aoit30FUBeDtZCZyIkYbmpKGGvbH
 OPMfu3bziHi9fDWynUXD8WrGiqbO1pMidWwseejfLv1Im8eHdCGNhpk9+lZna1B0cTecgG0RZta
 lXbimm1ty8IM3fJ5ZCWInvfNA+nS7e3ligwF9oUC/iZiVdV8RSkw3EP/pAe4LvP89LCQ4Oy2VZD
 WbGIHNZa7XHXyiXQIselp7sGc6DlkR24M992rPtsYQv5z55KAImGQdfsoRtbVTmtFntjs3/FGsa
 bVluaqin5jzdLIMS8=
X-Google-Smtp-Source: AGHT+IHLPPgHAGj7oAFNeKvt+NkfzQZysqdmaLjeD14UN7YygIHaDsqbvl/bbz13knhAhDRhZfGIpw==
X-Received: by 2002:a17:907:7296:b0:b73:6d3c:e0f2 with SMTP id
 a640c23a62f3a-b7d238c40afmr1984654466b.37.1766063509234; 
 Thu, 18 Dec 2025 05:11:49 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b802294928csm235246266b.0.2025.12.18.05.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 05:11:48 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 14:11:48 +0100
Message-Id: <DF1D9J8IUP1P.1MRZOA57C7C2G@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251212104025.15924-1-mdoucha@suse.cz>
In-Reply-To: <20251212104025.15924-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_detach_device: Clear leftover partitions
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

Merged, Thanks.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
