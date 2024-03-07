Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CABFC54E49
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 08:54:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1E683CFE1D
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 09:54:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 23CFA3CE8A8
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 09:54:23 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 146AF21F6A0
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 09:54:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709801661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xuMKcRCvB5tHnerPYgIEyxAxD7qu7P1WlIxutjYnAM=;
 b=YKzoRKN77ezf1NifyCHolR1ZeiV6+lcpJRzcyyBZFGOogRsILjoUwvX6sLy8I3JGpwtOSr
 XsXWHq7zouYd8A6VUdlR8swL0P/JP0bF8BUN+w4BObZLM0g9djiZy1xKtGfjsAg3VrK+dS
 7eYefwyLoXrokpknq59JWnXxVaLf+bg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-HeGefNy-P8WVWiwHoIg53A-1; Thu, 07 Mar 2024 03:54:19 -0500
X-MC-Unique: HeGefNy-P8WVWiwHoIg53A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29b976631dcso148228a91.0
 for <ltp@lists.linux.it>; Thu, 07 Mar 2024 00:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709801659; x=1710406459;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7xuMKcRCvB5tHnerPYgIEyxAxD7qu7P1WlIxutjYnAM=;
 b=O1VCmNHi+5zAvNxoT3g6fp7P1ckiStxAmC4PwmPzIlmq+W6FypW5vQR5Pn0V8mVkq9
 3BHckKqEiZvTWPEmVdcAtoEuJV0oLlTlc1A3C/EP2B71LTf4WjfOCJZe0GzM3ljg7u31
 Tk095nDCqJsDAYk4WMlbWBIzFhCsvdIJKTlEcUzuwJzpN2SFbIG77OKyHthyZXjOKS4s
 Eau5xECOKX4/KXTpgmsmdNc6gJqdRz6RdmVHIyGKZsc+LZMSv91vMMtxbiMGXrsI8vxF
 T8Og5FfOjjLKFUs4S5AnXxvtO5HaMm/fb75OQ2Iir7TkYtVtgwu2SpJU07Cvj1XTqymk
 28zQ==
X-Gm-Message-State: AOJu0YxvKttFNnXXO09qTzpw0+W3iDxiJ7+OWvnyl6HM24s2BseA4woB
 I8Q4os4e89YQ1gqWt/1UPM+UftKoWTZKmovQ93iwBDJYcQPJR+mDhFEBz35EKDw/1X8k6XF701+
 Z6oTJz7RlHvepKHKXeBRvWp4+7oLDeKYY5ZRRyMXNQ/70ElCJjR0SHOXm7sxoWM7p8Az52qFLfO
 790zUp+wJqs+BR65wHof0U2ZI=
X-Received: by 2002:a17:90a:d514:b0:29a:be0d:4038 with SMTP id
 t20-20020a17090ad51400b0029abe0d4038mr13916640pju.3.1709801658855; 
 Thu, 07 Mar 2024 00:54:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9TXpZWG/h1daNzAzL3PyzLtQCkJzagzNa/8LO4axUu61slebq6FMJKjMMA3yAMOb0t8g7wF1r4Du8zCz8unM=
X-Received: by 2002:a17:90a:d514:b0:29a:be0d:4038 with SMTP id
 t20-20020a17090ad51400b0029abe0d4038mr13916625pju.3.1709801658482; Thu, 07
 Mar 2024 00:54:18 -0800 (PST)
MIME-Version: 1.0
References: <20240307074019.766020-1-dbrendel@redhat.com>
In-Reply-To: <20240307074019.766020-1-dbrendel@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Mar 2024 16:54:06 +0800
Message-ID: <CAEemH2fTCB8SB85DY1NUVsFK_hSmAXqaFHtsWngU7hPdkcHtMw@mail.gmail.com>
To: Dennis Brendel <dbrendel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] munlockall: re-write test case
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

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
