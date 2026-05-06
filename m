Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCA6CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778077426; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=o/Lmm/eyJjvnJFL267VvtMJkMlqQElNXgBy8Xqoy29Q=;
 b=cqf4LmScz2LXfAMJAz0JNfrQibJ+IUIgsSiF8SWM6Ne7mnkJyyfnBvQU9Bd3wc/Nf8gl5
 0sMA/d9o51xqryEKwH6VO1sjQrX0EdHlBxwUMoRRg8l5wggfCRDUx5cSUlLpqwtVrwowQF8
 sJv6u1+h21d9bLZ7DTleGVGf7Jz4Z4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDE563E65B5
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:23:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2A893E24FD
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:23:21 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 22E201000A0A
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:23:21 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4090660f8f.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 07:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778077400; x=1778682200; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=G2nf3tH4taDtHYKre1PhLRfXuWCNFA9qcGYrHLkLuws=;
 b=ACYsxAxXQnNA3VDY/L5gYlTUwJmyTT/+TJesNebR0SjM7OTtlAnK/+cnaslHtK128B
 JxTXG0hSr7GAQ/EqLwsaxqNBdagEmcuOgpQs8J5gkZp3kYInjEKx7gHeaxLOBEt7n9KN
 iAXbCAC/FbVLRO2HnQNmkXpGGqHJZnYBFfue2yzJS5Ohlv5mB+ycPYs+FqeIPyBbvnhk
 g3O63sizpx4Sg/vLyIT9dSLEGKoLlDU+vTF1QUOx+TPv5x4MMU8S1prxdUlTBv4eNj9F
 mnGXpwLfX+Uwl2Xf4YiQi24B0FzJ9pY6xdLsF63A7DXX4YHfLE0YTDRy/u+r6QO92noL
 zNQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778077400; x=1778682200;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2nf3tH4taDtHYKre1PhLRfXuWCNFA9qcGYrHLkLuws=;
 b=cKkgTcCRY9+wRyHqUDIVN9GWKgSsjlberpO6ubiiCtculxkN8sndauoI1HbhPgOzcf
 Mz7v2F6f+yKYhhzGP4cW1kyulpPcOhuqlJfKMJYF8y+OsZJdBBbXWrUFeNXJfIopSIh1
 G818PkKGrDIGSsNIHlgHG93jEPfMI8d6aEMJNHkHFw0zgYf3anK2FMwe6q4iO1kHsUIT
 IsZqN7r/t5eTNEmuoSHN8GduJQL6Y93CQp5wHYud7z69W/cVleGL3rPaYEIM6WgztTSR
 qqPd474PnnHg2XE1Ld1q0gOWhoVtx2lxQDP8pXdZMWiH75ZfQxEgVY00l4EJDbpEL/D7
 Lc5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PS8o1YJwlvwbsNlzF4RbbwH76JBTwz04ZXMptVPtoljMrwaFWRZR1/IyJLqS2uFQIoLg=@lists.linux.it
X-Gm-Message-State: AOJu0YyPxaCdWcmfrAsTBb8liSLaNjnQ7liU+70ZrRjAFTNgf0YDSGFZ
 Klz6yQEHUqQt86tZHxUIgxt+OrpBNgF13VGfoNVUXGrgXxd1ojhConcB6s89SJR+W5Y=
X-Gm-Gg: AeBDieuTNv/ocQKHE8hzjWcJJ2cSjqQSQrLsb6wOhEjiHMFtC/xm6zStRVHTDku0DWN
 9OoT/WaGYrAFlUxAXdtX1KyyXR7OMjOfMePlDl2auQMP8cDoGevQNkUcHewpzuBXYJaAmYLRtl+
 yYRM7ft1JTMACJRiaHrWGzdQDmAp1zZZiqwm29v8EghqlpOrO4m/rUP4RhECDrzqg3+UCbsvNNI
 Vwjmy0SCO5+/vIzkLtNeoFfzTaryzAqZ7d9y4cHFUxVvpJbqv52PUJfvg+wAXatMrCgqs37hKue
 PrZe3h9CFh5idd5n6rqBw1tQwRlVO++cKLVj/b/NfYtqY3sGWFn8vZ7pm5jvNSlmDUSvI9TfP2T
 sX+HoPdUyOxpYQk5AHLqcBB5EXDc92pcR+Lr28nL8hbvJHuxSAkcY9CIqqeNy2fXcGtOX5f/sud
 mvZBTpYOSlswbiEK3L9ehcU7JCE+pkcIIk1UnkXswKFuOVvUlZtyG9mjsEieIMcoyC+ElvOkOBH
 4DHUgyMkqH3Uti9D7b6583agN6wQJOGdWl6gh2LqM8r9yYn2YLzVOt9/BHGtR7ipytqisyxeyhn
 sZpYLLFVUJwAUuUNwr1k7Pg=
X-Received: by 2002:a05:6000:26ca:b0:43d:7d6f:f535 with SMTP id
 ffacd0b85a97d-4515cc31ee5mr6401677f8f.35.1778077400406; 
 Wed, 06 May 2026 07:23:20 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-450524834eesm12419247f8f.4.2026.05.06.07.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:23:19 -0700 (PDT)
Message-ID: <69fb4ed7.5d0a0220.2b948b.bb86@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260506141636.3929-1-linuxtestproject.agent@gmail.com>
Date: Wed, 06 May 2026 14:23:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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

Hi Piotr,

you can ignore the AI agent review in this case. We already
talked about these issues and the patch looks ok to me and
others. Hopefully we can merge this soon.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
