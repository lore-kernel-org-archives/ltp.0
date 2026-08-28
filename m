Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86220C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 07:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787903929; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3jnY/NHtEjQIWL1Ny+Uy6Bx5FYDRflFf7QLU/iYerOs=;
 b=YSff4aE8UbBrnFWk+MOgX3+LzniXIvh0RCOhcKbbQwCHwZcO9fVjaYc8lZfX/s+kESVU/
 xH/rgV7GIFoqReVGhhhSY1b74ZwmbdRWYAURaUEvMmZDkHUm5rBjVfzZEkQvSX9Awxa8koB
 2r2qrsXPNPhBm1O1Fv8ybBghLdYvfp0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFC4F3DFA35
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:58:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE3693CC02A
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:58:29 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CF7C1A00A44
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 09:58:29 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so6100625e9.1
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787903908; x=1788508708; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ohx7a71Ado5v/brADDt6gEuiuqeaDsSO4GB4arcSimQ=;
 b=dLn3ir1K6Lf48HIekJ38IiLcBRRobhtd2Q1F71hSQ1yNDZBeS3tcU6uNqWxYCQJ9UI
 vAOEkiBy/sZaGWOrRgsFQpaVV2gqROLKxufTh0eprTCyxprvl8GfNRyW5WuQdcdzUTXe
 lG+vVHByl+vjGPeWpZCPVL5xienJS2FlUY97rlm2hIxiGi/IffACB+2JYhA+axj8GNKB
 itDTaHC58+T/sKtgTCnDcRomgGOhrwlD0RGTYzhFWLSbXacvoVmfGg0A6c7b1i4RVr1K
 P6kxJrXbmJxmvikuPZc7iNqNACftk+bz4wFONMrMhqibsdUsnxru361ErgV7tSKsiQfU
 iU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787903908; x=1788508708;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ohx7a71Ado5v/brADDt6gEuiuqeaDsSO4GB4arcSimQ=;
 b=LFB5d2gKIABac0Z6jKIHHCF5UYWhdxcPC/wHUBKx269iZBoUdXjp8aT4KZiHN5kpF2
 b8oswyughMk9J2lbZhLvDydUm9M8Xtjph+rOOM+SBFzwEk8Uy4/ifs+DrdeaDKVh68Vb
 eYiyXcxoYm0W6zmufdmVtFnH/Qx1YRskMrR6vK2TwVuyxj4uRd0R9Hj03ZROBc8rw4Am
 rGV8ceguLpdJVK1HR5U3PjBOGzBcoE0eIICdulCucoAVH1a9mvXgFtzfzNyxGzD80pCZ
 S8CsFyCEvt0E+CNmmM5/e94qu7u/SmoRYs3qtbE0DW4GiqqCXVXnzCFNJNFjFjGHlVem
 9rAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpG9dumwraUWl01HATD2Hz94xjVZ3qQS+dLiWLdfsLwpE+409fwvXWdjuBmDQ4YdxA8VGk=@lists.linux.it
X-Gm-Message-State: AFuF++kz5yKQv/Q0y/RSYXLeiWhuGFwIwMzMgidyrCCAol1CfbiqqGNa
 5o1FehZPYsjqOKoVfT/Pxoo/Rmbt7lTeBe4qkuyKGJnvc3o5JGnY5QDHgNyfsIvucLI=
X-Gm-Gg: AR+sD11K6G/zSx2NKQ9QusxgiBamtcrXjawHbpq2rD2TPmJut1YiMsDUX/eDVOHos2U
 3evniFTGlX1jsyuG2OcoRNn+HGEntN9NQ3ohsokUgf6yLVz9dkMunb6UrdsykOC5MU1zMLuM+ev
 YgQGRzZHHHtZbd8Povoj+AWuF1Lc1AjEWN9za1bmT+yeH5MtMC1VVEdm9zcenh/bKh1trNLMBAB
 NX2RZ3cCGkO9e9i26AtPTifjRhf+qhze8aQNN/ZW8SolHAhplgwvoUXOyTJO1pKaE4x5TMjZcHq
 OG6G4P3IpTHmhRCqEHa65XT3ifaHrFgES+L0CgE4687CS+iUoK21pls9r5LxZrEtk/KK41rc0/p
 3rYEip/cP3ulQgJPlyJvgjjCxGsRMf5dU6HYKxxVnJqcMh6lU0+v8VZ7HvFYQXO3rciY2ffAMUI
 TkeV8nzXanaoCtSKLjH0hdClTZhSTsBg75BIXfnlz++I6CxxePnGjfSfBzuQMhZOllqAbr+EDQh
 Jigm375DOeYeVEtDasxnhIMZpHRwYPNzxQNx3BCAFbVest/COtYL2sYua7j3UwBdihgXGI=
X-Received: by 2002:a05:600c:698c:b0:499:adb5:e7b2 with SMTP id
 5b1f17b1804b1-49b91c3ddc7mr88915935e9.11.1787903908561; 
 Fri, 28 Aug 2026 00:58:28 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcb3d9sm32356885e9.5.2026.08.28.00.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 00:58:28 -0700 (PDT)
Message-ID: <6a913fa4.4cefb68e.1daeba.f2c6@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a620d3b.bf927062.8cfc4.b1e7@mx.google.com>
Date: Fri, 28 Aug 2026 07:58:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 3/3] open16: allow restricted O_CREAT of FIFOs
 and regular files
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

> > +	SAFE_WAITPID(pid, NULL, 0);
> 
> not needed, we have tst_reap_children().

this is also still valid. Please send a v13

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
