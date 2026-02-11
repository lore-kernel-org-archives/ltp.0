Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B83BEB2700
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770805548; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=7++zoYcKs22/29tsSYRYELsis7ixe0Xxb8pxCs8NTfg=;
 b=G63zDWOdN8vxVPxwiHQa0/8vLfUHC7PMu07IFMfREC/kuI1UeJ/dyjWBDQL99VwDnFJPi
 MiZJAAvkyysLU3YWvj5jYoApXmHg/KfnCRH7sJfQWcz0ZEHyksjJFDCdj1b+Tu13sar7lUh
 31VWzXPzKldcDpox/pJiRZHnNKg9M6A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1464E3CDE20
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 11:25:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 592FE3C4F59
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 11:25:24 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A717D1000772
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 11:25:23 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-482f2599980so19617505e9.0
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770805523; x=1771410323; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ognb9K8cW6vgkBnOj3DvV32zodozFFUMSd2H6PaImbw=;
 b=VJ1WifRKmotahShDKsjLg28FW/l747euW+4acojOW1TbYLHzCmP7QdE8GiCZ4hRjho
 nzpeVpogl3G0rWiCo0lANfEKRf6lmOIvOA1rvRLUZBu6oo8Nr9gpk51AGK+op7UW+Wan
 4GszMglFD1BOZsk/1RnrlO0ezfvBQ50Fpbk5+gA1sLG07LyQAeb+ClUMd6ks5bB4RqtS
 YKkoPQim9oMm/iam3bFXl/Ba9IejOGQ5u6gVzZJqB/fFxm6y8kURoqNAuPJEyKXAypDJ
 ylZX2De7rqJRTBM8CH51gIshPcVvawHWG7kBvZZjS+qKP4XmoR3DIrZzYVtTm672oRYm
 Hhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770805523; x=1771410323;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ognb9K8cW6vgkBnOj3DvV32zodozFFUMSd2H6PaImbw=;
 b=UtyvGMfVhEFme1ZLWNw0Qf61fz/21l1r6sAyfoWjImgZv362qyOLJ+kfb9bVWm+mk/
 7xw2RJHnvaZA0+X4B+i2P8IMabZoGCSKPnp8dMS5SDNChPm2TUWNIevCfapobB5hAVEW
 ATZvPGNDVj0wvZ0KeaW3GUKbUnb/A9PElUV1O2W5cnrwD2XGeAy0kvz/iO1P3irtJtHe
 sKEviZYM6+0dW+Z5fwx+BzAFwQ7p9XlwPROPEwe8Uqkf1wpfJi1DJsyz9ezRODWLHZxY
 qXZQ/tPvEX8mMzD1usMHh7P5ZTDJPD1j+R3/xh5NbI+hiImssXOfmj1YCIIb2NVTJKAm
 TURw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmA50KyUPtC+JheXTWbz2/q6BxUerDtpRJuAOMIKrz5C4gucxqUS/qzfos/oS71Wn6lVQ=@lists.linux.it
X-Gm-Message-State: AOJu0YwVvQFKZo5sGc0MNQENUDtHtFsvU/3JpBnG8TnBYQBkR3AH8Dkc
 pOyzogI5IhZXSNJndgK96b9Hltlu2HFYbT7sfl0yCy1J2bIW8ByXMNLeWMe/KNy168Q=
X-Gm-Gg: AZuq6aIAETB4p0LUsGP7DHC0OJR8Wh+0dikS268Makj0tqWtYQ+OV5xOCK+32Q9yODF
 LFq/LdGc37P8GMV82o+3Q6le0JV0b1hmVxQ+Mh6yHbQ8CxkwNo9bpoNUT5EluDYPaDs+zKNNG3b
 X6Am/EOfnj3oRf82FqJJSdUHLhkWztQx9LwM4NpeXmxIk/zB+1aVtiVX3StYLjvsGqtLgKZdF3a
 0hhLXASixkEbAE9iBaOuq9OlsYI85Dq4St+9oap7okoW8pLTfhMcOsLMiVt+3+RE+pMqh9pg6m8
 WAJNXuGkFse7ulutexPevwWpqoY35n9V/1qizq4BVEUuhqV1kFvD5b18GrVl8FstzSsyd/zPpWe
 IR+lDMxi/zidgRZph/G97XxMaBKo1XK5bPZT7deSfZL1SCO2j56H90D0ulfCA2ldJ3vNyJHFXzD
 oOjBV69fPURWSgOeAveHpe6RFXHxzaExh5YvG6cCLe+HfNrcQjJuYatvMd0NO18m/H/3eVYljgl
 l6uknBvaN6J/clDWELGm1hiDzbCxg==
X-Received: by 2002:a05:600c:35c2:b0:483:54cc:cd89 with SMTP id
 5b1f17b1804b1-48354cccf81mr60765755e9.9.1770805522910; 
 Wed, 11 Feb 2026 02:25:22 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d3464csm4445483f8f.5.2026.02.11.02.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 02:25:22 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 11:25:22 +0100
Message-Id: <DGC262DZPMFP.10MLIF7OXIGS4@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <DGC0LPS5JBO5.DEZE7CY4YTHU@suse.com>
 <20260211101328.1180-1-always.starving0@gmail.com>
In-Reply-To: <20260211101328.1180-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inotify: modernize with SAFE_ wrappers and fix
 minor style issues
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

+1

This patch will be merged when it will receive a second review tag.

Thanks

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
