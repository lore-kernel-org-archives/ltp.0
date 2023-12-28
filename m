Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB99CC3DA6E
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 09:59:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D3603CEC1C
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 10:59:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B8ED83C8876
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 10:59:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E96C1400061
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 10:59:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703757576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o3kvVeL4vTTZCdZ/9lGBZhhybznmjgCP0xuz48eLybk=;
 b=O93A/yk3Ai8QYdkeHav+0oWpASQxJkfHN/GCV9ynyjh4hUq4gnzl1d04+iu/mWtHpX3wru
 V447WuROXKjDIjqwjNtYAFXeuE7zv05/mrhTR/IRS0Mfu/9FvNqbUfOlieLGZ66Hx918X7
 Icsw7XWQyeJwMHNnbSdFIYcoBh5U3mk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-ynTljwvWP8CVmbLj1w_Wng-1; Thu, 28 Dec 2023 04:59:34 -0500
X-MC-Unique: ynTljwvWP8CVmbLj1w_Wng-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-50e7bfc47fdso2165933e87.0
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 01:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703757573; x=1704362373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3kvVeL4vTTZCdZ/9lGBZhhybznmjgCP0xuz48eLybk=;
 b=HKnXgsBUN9V6OK6TMeheEDjwfRJC4gA9KUWvmZxk/AhelWiZSjAXDJbwDjI2XjcH9v
 +2gxNTUeYlwdUnhaR0RbMEHp7hafhIlIx3/3wcsCA80aGyoAY6jyVYVhTv5Swy2nfXY+
 1jbh2wTySt59QA5APDMyN1Y4EqreowxufHElmAql/GzWVkFVwAk3myzKG159c14kS3Zm
 apnxeVqArhbOVQIDb0+SjI+vD12Ics9Ri1bvp0/jH6w9/A36z/eJ45HqXvJPPvbSIyc6
 gKA1kFrvOPv10t1/p6Q0wV6JVhGLaS2iB0W7hU/fOht7JIfQticNa6qhCDywCmgOE6RY
 lIYg==
X-Gm-Message-State: AOJu0Yy8uw6ieAzZEX9qaRZnpbiDgU/gf4BDibqS4lC8pI+L7kPJvztt
 UNsh/eMbdwIgUSnvb1JbRQ6io3pEadIB9rZ8ngqhLCjNsIHq8iLZ38bYKMBzRc2LskugF4I9Adt
 LHuam3DsfGuN5wClU8ACnZX2grYQJ7M7r4gg=
X-Received: by 2002:a05:6512:110a:b0:50e:7b4d:430e with SMTP id
 l10-20020a056512110a00b0050e7b4d430emr2244411lfg.180.1703757572890; 
 Thu, 28 Dec 2023 01:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgUO7siOdjAxHt+7sVQi9dsMs21cZWfE6iwPf0yj1VqZT5OJdPsFbk0hd36iyWSk89Y782c9IeUztSLcER0Jk=
X-Received: by 2002:a05:6512:110a:b0:50e:7b4d:430e with SMTP id
 l10-20020a056512110a00b0050e7b4d430emr2244406lfg.180.1703757572570; Thu, 28
 Dec 2023 01:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20231227065118.209595-1-shichen@redhat.com>
 <20231228072109.349636-1-shichen@redhat.com>
In-Reply-To: <20231228072109.349636-1-shichen@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Dec 2023 17:59:20 +0800
Message-ID: <CAEemH2cPFWZ83vyQibZVvkDExaiS+iMHBYmno7Dkh3WVN8gZ4Q@mail.gmail.com>
To: Shizhao Chen <shichen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] tools: Fix syntax error caused by "; ;
 " in create_dmesg_entry awk script
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Pushed, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
