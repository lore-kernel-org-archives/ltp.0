Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF38C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 06:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786603244; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hsROCtwns3AOc5y3MnY/5LmyaCh8ARm8QIRDJl16B5w=;
 b=Q/xiHXXk6RKBfGNXagIi9xfqh74schZNTj1DnO5AP4pe9BbUgHUD7y/4XJY7no2rUdsqO
 eRrhn+BjIjVEUyprMfBzFHXNrrItqOssX/Xo5VRiQoQADsmNnY267xeGRMLZKNJL5iH71Qx
 hbhdbSmZSF0p+2PI+pZINMeXFvwrkfE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64BC33D8D59
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 08:40:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C0283CB4C4
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:40:24 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 229E7140053C
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 08:40:24 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso627407f8f.3
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786603223; x=1787208023; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g4fTPcsxd/wzg8vPYXWcvBtO3O0IehSsHiXO4xVSBtU=;
 b=FXyW4HgsnKbxwo4syYb/oE/uVlCv0qbOyG8qhcoE9AS8ljo/QrmZ5kxC7fgBUZ7rbe
 /Sq+dK5pglgdp6DiM1GCXcLw03ArQV2cnm9qwGV7czN83abuEmQLqOrHeujCYQZEQXMT
 0unX3x1bTAfAe0gBlFsl/LB1hd7h92oKJm4CLQUejogfQVtn3Bce5oIyUvLgzye3uL+t
 TPpUDtNoe8vfDj213qXHZ5SRJ1oEFze9wjEGT7AddhMyXLaFd33SgQp6Z6t626VJIpjE
 z1vsq4PH0uhcxEJACdibD0+yIjCduqm6NT28fncfU9mwP7U3BuFQMQHLqH/ZKsoFzIuI
 UbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786603223; x=1787208023;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g4fTPcsxd/wzg8vPYXWcvBtO3O0IehSsHiXO4xVSBtU=;
 b=szT/cx6c5hkEtwtRZEYIeP7KkhkuvfglCcZ2bLKsl4wCSAOM62t/5GH/jE4GZN6TJl
 N0Y5mkPIaLXNqhYDi7BHdmpXM6xTbSRYuZAy0n0FMMh1GQGLds6yNPTqHvupEmIZYKzA
 fC+GZ+3GaDHneci5174Cxtbi2f9mP1lRD2/axOaGb3AzPEFr7Si2FtOR2qwLr4Vq1si2
 dm7MXf+vIrl0Qfk5gvq4S8i/0/yOAgpE3otiHjZt/TxRcfKdr/2aOV1u/s4Jwxnc44l3
 F7S1gmYUr/LrpRjrQBwe9Ntoe4Oznh1Lk/z1U90/rrJeYB3TsnxW/bGy1XtV4oIkyut3
 kt4A==
X-Gm-Message-State: AOJu0Ywybt0RkvUj+a4tcFrqhnITESqKK8BKn2+iz51xgk2Fsf9pRPwS
 hSecxAIJ9KuJf3OZq6LDp/tdBy4S/3NUcYxL60sAdJhQlTUG4u5IPKCw0h2J2iYRa1y4Q8186cA
 il+geJRc=
X-Gm-Gg: AR+sD124pXF23lYRD7k2mtsgieN8SPex+fcuPdmZLszw4D9PpbdAI2ELJbw527+2xrK
 8T4UlW6+BcQicnRy3sYaDt8ePqWaDs93y1j0ZZtRePwn2vots9+5uXcSzlJEAmNI2rS6KFp5VqK
 fs50Hdw1LjvZ2mmM+7hiQ34nlvut4kzwx+pZB+lQOZdhGYsWpGVXCSEMD88mufwgPXo79KahG4l
 ViHwIRbZWWa9jcGePPqv6ON8u8F4T/xOzZcbA9cnEgAPZiCmMnPmchpqwkx6BpGaebt9m69Rd34
 NM7ry/afaZSNvU6d6gtwI14Yyck2hXEdxhtJk9BX+69S4uBpxJBtjdJ7hfhSaF5mPijob20wHMA
 aV5dV5xdnJtKkFZq+aEwvPC3gdItEMABvifFU+DSUEIHlsWaHe2RbWFYQb8wZ0x2gkVzRL7bHXP
 wJ87e7+th+HDtThyhsnAM6m1dNj430/QziACMcY9zSWAevtsUHDvwq2P2NDt3PDK1QgZu3b0w=
X-Received: by 2002:a05:6000:46cf:b0:47f:9447:62bf with SMTP id
 ffacd0b85a97d-48159c90a2dmr3241129f8f.2.1786603223433; 
 Wed, 12 Aug 2026 23:40:23 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5c2352sm3281025f8f.34.2026.08.12.23.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 23:40:22 -0700 (PDT)
Message-ID: <6a7d66d6.be490abf.203406.d67e@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260811155202.1744316-4-pvorel@suse.cz>
Date: Thu, 13 Aug 2026 06:40:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] tree: Use TST_EXP_PASS_OR_FAIL() and
 TST_EXP_FD_OR_FAIL()
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

> +	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);

the correct usage should be:

fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
