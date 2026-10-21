Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB753606A31A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=aGWOcbl6;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=X6MetgE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792578529; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=q46PF0Y1WxwyvZX+urTVQnkvhGsTJkdsjR6teCQ1jWc=;
 b=aGWOcbl6LbzuRXzAFxVvaeOOMkqbwauT7kMTEBjOEbwLxJT3smVjYoOMLEWOXy4yu24ej
 zShVzh/uhLccxps+H3fojGQtVc7GbctMJnB1OSIKYn5rcYUmt0Y6oDK8b8tY4sKokRELANu
 XATS3LxRyNmr4Oq8cooBHBNXpZzLiZQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C673CAF51
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 12:28:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E44CA3CAF51
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 12:28:27 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 443A2600957
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 12:28:27 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so4061045e9.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 03:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792578507; x=1793183307; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Js7xPtdPFEIdeDa+fT6f6wNUxvFkKan2vsDIo2W54K8=;
 b=X6MetgE1mUrn2AT4IxmbY/M4r88A/5qajNd9Y+IeTt3GiWfwDU2sfmg/RwLq3r8Iak
 AlbhqUElLTZEeDjbdqJId6UMmrk/AlA68wYR9LDvsJaLXMCw7/HcIZFLPVAdCVmFmE2c
 S5K+AFDj49sCybBb6fhXbe/vESFmuPzC/qg92dtEGiy4CwXIeVjKgmaPMEYwNIlqfW+P
 pLm7omqHfBQZGjae+o9WENoi7Awad0xFbiCgEinKBzX7vzhEB1EdbajRDSdOTovLYBpS
 S1ehDwrtr2QckopUDJXkSffHqF15H5v37IvoME586DatCO6y0a+JHjZB/vqPsc5XGnHz
 2ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792578507; x=1793183307;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Js7xPtdPFEIdeDa+fT6f6wNUxvFkKan2vsDIo2W54K8=;
 b=z4sfDlQV6XdHCsGiUb+zpO2Zo0GQ6bd/DEqopWjarjxLi7LipSOW67sj6eeWGJT04q
 nLMSJvufqBsbYq/+Cotl8FGwT3Ms4c8NgGPBks3tA0TuBKY5mHqC/D9xBpsk0tNb45uu
 dWMfWuRDrBkelEc6dyKXfHDRjt0vvcFU/Z7W1L+/7sO7lyNLBalr5rGMk8fu6QlHbnRb
 u7a5iehpsnDcrhhqlczdFuIaGGs+5zlUi+HcX8vxhUEWFfximHEMZmXu9QSb7JClodZC
 05mgt6Qw7TKJSJ7JTAUlG9/eABevUTKFSSDD3GI2CYJypT/6leaadUmVsZ1OZO/iYm5d
 RCog==
X-Gm-Message-State: AFq9FYJ7yhsxbh6XEtHrzROBcLro8LPbTHkmB8Y3sw+BQ16gZeHMQ2og
 qFVw5Gxcc22IR9eX9ZAuQmd+alOHqDr1J8CHbooZgrOc8H1C+WVer0d4urWrv4rzmiD/ZB0w1mC
 bw9sRG/8=
X-Gm-Gg: AYBFou0ZJzhNgTla2E7Z7k2KVGLQTlfwWj+N2lCmftLFDUrRnaoP4N1Skr/jzuUXSw7
 8gAeLBOhSJUJ1jqFAeY8OhXCDB659HR+SJhpnXrb1BBPtKz6pOUD5ZMBjwicXcUe6W5VIm5oygx
 QQ2WUE3aYqNtY/sOeAgh8/NS1IFnDyidO8vN0KfhTIDW4fXQl6BEwKw2IQmDh68YIUTfGcfhbEK
 3u+HtZCl2vpgdQh9t3AYSK0Sua0H70MFwJRdK4UI1xdNEb3PDDR19Lgtnw3lmCfsZzI1t63VZnW
 L9KM8IfiUuMNe+rL8p7KSxY3Y7EiojsgOCx9LyRPB/624h0sSOBhEUFY97QFPivOuQRRwplODk+
 R4TyJrcsEgfpvblGghTiCD2fZPmfro5PmbibNMYeOZxN+VDi96jdwlODTIg/S0V2LFIrbJ25gie
 dqxoGWdNXZi3Kk0IxMvma0Tkmtv+lkseu1HK9U8MhAEdRTO5WdCGyHNuPjUhTxqkQi227SvwNIW
 kE0HZzigHUjAUxvKYJPzsU3EiL4LMrmlsMDbjsKFSZOApsZVdzEHgZbQzjloNwweYmfIC3oEGwx
 AlB84ksR3bPYaVa9lLC379kCBDY9C6DFVH6x1lrDOVig/fovItULreuazqA=
X-Received: by 2002:a05:600c:a0b:b0:4a1:7bae:d80a with SMTP id
 5b1f17b1804b1-4a1fdd245bcmr30614195e9.9.1792578506501; 
 Wed, 21 Oct 2026 03:28:26 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc1060f3sm40130755e9.1.2026.10.21.03.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 03:28:26 -0700 (PDT)
Message-ID: <c8lzDFi6IhhZRMae8OPvTrZHlBNppVQza0kG@localhost.localdomain>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20261004015344.2862110-1-wakel@google.com>
Date: Wed, 21 Oct 2026 10:28:25 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_pwait04: Use raw syscalls to avoid SIGSEGV
 on 32-bit Bionic
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

> +	if (!timeout)
>  		return tst_syscall(__NR_epoll_pwait2, epfd, events, maxevents,
>  				   NULL, sigmask, _NSIG / 8);

This statement requires parentesys {}.

Otherwise, LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
