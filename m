Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4035C87FC9
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 06:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753857369; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=y15T0BpYkhvr22ibuNh49F8JkZEZgz9Fzl2k45DsZwo=;
 b=XGqZ+c85T15KQykp7hKGUnhdR10aj0+HJFHr+0aCTnX5m1IztHBqw/W1mxoSNeNhH28Tp
 Epqlb+TQzgfzxbQ2CF+krBrFodBXnCGk0ZuITulAU3cSBGgb6WqPUxiCbaiQE4DYOkL05Jb
 eAVS+Ap9ijOtgHz4+Hh2aOVSugnKEWI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20C873CAD60
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 08:36:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DD7A3C0372
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 08:35:48 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 98116140007F
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 08:35:47 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b780bdda21so3787141f8f.3
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 23:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753857347; x=1754462147; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xIaGvtfxBKJMcBR6eaeUXw0HwbDq0DbswToCsfIYtXI=;
 b=L7mGVnlS1vhgfcjwi8satRO1b1Ujffao9RYMqmSaQfvXj7/VwohgWhARHaSIkpJirO
 apRB2Rxj3Z27aFcmyAVwty94b+LBQgeF6d2MkC8E9zd/Ct0ZqEQ4EGdoSh2C20np3w/9
 eOl4iib6iJBPxL7xtIE0RRz3p/V8TcxDA8QqBHTMX5K/MfVQJJ05M50bz8jmSiSUDoTF
 UEYxZKIgpgTGG3ifHH0BasYKWxASjkxdqfyS5jnLVALxapPO4oP5bpmT8jwkzYsWvZOi
 nFLEaySRdybJcxpWgoGe9XX8AY1vt7y9mHomSdj76qipFZuL4VqyCHVM1pWjAjLyF6AQ
 Cx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753857347; x=1754462147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xIaGvtfxBKJMcBR6eaeUXw0HwbDq0DbswToCsfIYtXI=;
 b=Xy7XOpeH+9pNyxTKaEPGbxQ0qD+EB/taIJL2RBmesYpA0LwvDIhRMOJSqf9Q4GmiD3
 WClOAZ4XI9pNxJ5OMbkuoL1IoNfjPMgZh00NFhx04IPL80VkkTi7Kau0MOBxKjiR91Ql
 eraxzBKuHI7OjzErPFTQRXjwjNmd/mmaGe/18XoTtmhsS3DnTXYz1yHmH3c1EWAt2hhu
 Evaqh0D527AS+TlnDzoc7r18tRsKetudryxWA6AHP0E8NMTHGXZUlZC3ONaddzPU3j8W
 JN1Q9lXJHYASNDRFJk5AjU1t2A4ZG/PPVf7Mh6Egi5Cjxxrk0t7to44KaF649HbzwNIF
 1ZbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRk6XkGLKtZu7Sb245RuFibesPrbHeduhqDi/7Pue99+tmBj7DOrmG2HglHPhQNmNGI84=@lists.linux.it
X-Gm-Message-State: AOJu0Ywj2T7AM8T4Z28hx6tFTj3M5UBH8Lz7XkgOdkwG5eyr6TpD6CGf
 zMfMnUHmzqtW1shH8ET31P3KuTtv8YQcIVIZgQUKFGbW+VXl5wvSDM5EqwkBauMu9xU=
X-Gm-Gg: ASbGncsB/NSl+DjYsmmSNxZVaYVDJzFLXl8C4aaJgYSZ1kb8XZdyXyySPhaWlSs0V+6
 yyJ4mBcHzFVU+u1yPIhAE8DomqloZ2LiFYqjn9GyPt572zcA2bhR+OkklF4R/oijgxDbh3SYqtE
 nxM1sxbQQ1x5KY24BL4FL1z+OSRtRgVzNY9bi9P5dbwnCQpqb9JUuFmATnM6QHkMz7Ft6x7EtgL
 tsyAf8SbpAUw1PvQh6Tqg2vzdoBOjnkVAegjjjRW8zBk5MBR8A4xmP8kpU9rIJlqMohu9ETKVYR
 sjCkwZLVdX9WVAvH+xvsXrFFbdVUwKxRXXakx+cF+fF3XZNVR7eloc/LJTRR4F8Oa5QP5z64+FT
 20cg+OEvVNDwEGKajiPDUu+bQ7WngHTtCtQ==
X-Google-Smtp-Source: AGHT+IHPPuPS9MOoCetDcaEgBwUmnqX7x6bXFRpF2aIJloa+x8+BYWpTlYef4Z6NefHU8FFpbngBdw==
X-Received: by 2002:a05:6000:188c:b0:3a4:f661:c3e0 with SMTP id
 ffacd0b85a97d-3b7950089d7mr1659492f8f.45.1753857346972; 
 Tue, 29 Jul 2025 23:35:46 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.248.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f6ae8bcsm8495515a12.46.2025.07.29.23.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 23:35:46 -0700 (PDT)
Message-ID: <7ac1840e-098f-45d4-a783-619a1760eca6@suse.com>
Date: Wed, 30 Jul 2025 08:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
 <5913636.DvuYhMxLoT@thinkpad> <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
 <20250729084720.GA13357@pevik> <aIj0Jyn9cq9JVNbI@yuki.lan>
 <46e5368a-71a2-4a7d-9987-a9face630f20@suse.com>
 <aIn2hOwIadEPpxz0@MiWiFi-CR6608-srv>
Content-Language: en-US
In-Reply-To: <aIn2hOwIadEPpxz0@MiWiFi-CR6608-srv>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/30/25 12:40 PM, Wei Gao wrote:
> Just FYI discussion on similar case for fanotify14 handle selinux
> https://lists.linux.it/pipermail/ltp/2024-March/037564.html

Thanks Wei for pointing to the fanotify14 discussion. I'm going to 
implement the same solution we had there, even if I'm not 100% convinced 
about it.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
