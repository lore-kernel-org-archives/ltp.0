Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA301F94CC4
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 05:27:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EDB93E25A5
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 07:27:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA4EF3E1AA6
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 07:26:55 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D91BD1000414
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 07:26:54 +0200 (CEST)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f83bd32efso3956267b3a.2
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 22:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776835613; x=1777440413; darn=lists.linux.it;
 h=content-disposition:mime-version:mail-followup-to:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kB2aikB0bx5IDh9O5Hn12g8SfA8i4YSnqzmg88Y6Y/I=;
 b=o09AdIruaTrOItmqtFozWTJZrOjta/5gBl2H3B3WqX2yuh8IQQRR7Y4WFrvhMkwEup
 R1TLXOZ7c2CbCYbMqggxjw3BpbadhYEYy8eb05m5RBqhN0CVle3laW5DNl8/2IVCEuso
 Ut4+cko3BKgjgsiaNZgWWpqZbOPOQTwf9uYFB3lExO4I2yU+jUOYmmtSHJif6Pjfznox
 SG7SC7CctINyODJnSrbMXjWKEp+ibO1MKC0AX7TG+knAaaW/fBBPzDlNpJaCo0IotskC
 DIBl2oahg8mWV++LZ+c25KX5m+O4TjiFGzuF3hRjcL8f+SWaqfR1lqyWxvclh9Oup8To
 W93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776835613; x=1777440413;
 h=content-disposition:mime-version:mail-followup-to:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kB2aikB0bx5IDh9O5Hn12g8SfA8i4YSnqzmg88Y6Y/I=;
 b=nyEezKNebUaO17kSsxG1E+F5Ny6HX5jSsb8TINv9+0Al/uHr77je6eftKa4J//FJPV
 9YEyJeRg8z6oC184DZIplApBd/Oe0Wx8GfhE61LlWJiNX90KM99P69K6b5ykaW53lZ6Q
 fJ6HOagQtuWVk2foaxcLtLUHE7T2Vq29TnxMWoXpaieHSYe9pXGhaly6NCD9XT9TzsW7
 F4DJFS02xidFByuHijawptVBMlqjyzH+66PuPjk4KJEBfUF9AYocfzPF1BD2ZSw/3YvA
 EfF8B4sUfyiye22ELZnaq/uPgoygvYlTGdMbONqEhQSn71DJg8iRkNBJl7hzDUs+i7nP
 LYOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96ZpmAKRkqLJ6aIGJvWkuIeXcbDmrzAVJ8Biet8qSj4jONwkjIHiTl1h09UNwmrxdI5mI=@lists.linux.it
X-Gm-Message-State: AOJu0Yzc5Brw+fkx3WpTMZc7SZrNcAiMUTU4c3AkVrWTmGrZmWGvGmeh
 4f/kML7Ak5GlQv3qOOEeGtq4K5tn3rn+shI25Jk4F/KI7uLaO4lV4mUhwOAOt80s6Ixn
X-Gm-Gg: AeBDieuE+qKIyTbRh/sfMy5D/LmSznjr+c8uhL6MU+ZXXx9V1BgP0qi+vqONe6YIbjN
 BkJEFn18cqaP1QolmrvdPkN7AZ1AFkotWuPp7hZ6rEKVt7TMHjpPj9qoavfQPgoLdHkmNINVMDH
 rULAMYlnPNu/Q3Dmimmk1AId18d5/g0eh18zwi+PCW2XK7SKtVU7K23qCfxZ5iJH3ZwXVSkqdgn
 yIHVBEt9u48jTWlOaPiUTb99Yi7xqHUH6Kqps0zQtCx7O0KyIqS9uvkn2LBYlL/SkA4QZ3ESeOr
 4FjCsFUpC8wVCgzix1Q9+nayqHgoL6k8PIWoc8NteGEZelODNMwD4sVBpaiwdDJBQ+uzvmrzppf
 5BkojP26sQO+ZnUoV0aqt1C1dd9t5tJMgaFw6J1Ld0ZBsIxKw2ms/dJzwOdh01Amww8P6r5jQ5N
 ZGIqhVPrn22MX+DmguBWvtz9xk+jd/HB9B
X-Received: by 2002:a05:6a00:2889:b0:823:d2c:b156 with SMTP id
 d2e1a72fcca58-82f8c7db2bemr22335274b3a.5.1776835613239; 
 Tue, 21 Apr 2026 22:26:53 -0700 (PDT)
Received: from localhost ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe41cfsm16617173b3a.43.2026.04.21.22.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 22:26:52 -0700 (PDT)
Date: Wed, 22 Apr 2026 13:26:49 +0800
From: Li Wang <wangli.ahau@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aehcGRoIxh8yW43y@gmail.com>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>,
 Jinseok Kim <always.starving0@gmail.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] include/lapi: add leaf Makefile
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
Reply-To: 20260422051800.GA392764@pevik
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Jinseok,

Petr Vorel wrote:

> > Convert include/Makefile to use generic_trunk_target.mk and
> > add minimal leaf Makefile in include/lapi.
> 
> add minimal leaf Makefile in include/lapi in order to have 'make check'.
> 
> FYI AI is correct it's better to describe the reason (although we have a ticket,
> one day might github disappear and we lost the reason in the ticket).
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Wait little longer if Li has time to ack this.

The v2 generally looks good (with Petr's suggestion).
Feel free to merge/refine with:

Reviewed-by: Li Wang <wangli.ahau@gmail.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
