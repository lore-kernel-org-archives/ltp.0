Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB34D5C0DA
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 08:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765873778; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+67nVwbk5pP7qUQiv0DE8HLZ+3MXBIBlAcR965LsSvs=;
 b=QdaK2Z1geG6r3baNO1Ve18DKc/jLaVrXRtjihJClZYhtk6pUZx2ZZCnx8ooyu8zQv/jvU
 iBAAR3u/nHKbp/GtCQ/rQejeu7HsGRJrgQyOGjlUPf32vNConNNp4Qh4EQvVDrKVAX9hxTU
 EeKYOjb2acO/8F9DYtjygoyN0C6CGrw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB6D63D032B
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 09:29:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 702EB3C9DEF
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 09:29:15 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8E7BF600789
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 09:29:10 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42e2d02a3c9so2893576f8f.3
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 00:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765873750; x=1766478550; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvaxX0jI6veucQdTm4Z7/XaxgHp3jlCxl8f5D/IfdOo=;
 b=MmSZALjMqADEV2hEFHJoJP9zATO59Kp3FCMXYfFFWucuW37Zdbx9/4iKRVyTwIq1z1
 m3k3U8iphqz5lnOcG+l/t3FyrK49AP1NH+yMBn4jJx2v6ecot6V3qFUazwSmYHJw7OAT
 qw3/m9XTNCP2Bd53H/FD7jJcJmOQK6o6+Q83olguH20EjEIF+EQXUn2UiQ6GITImwUEG
 P0a5oP9JYQZIXjzR2N95I13LUj5/V5lKDXC7eBaGX/Kp0ulcbSsMMkIniI1YttDd0j9w
 iStx2J4DGxauzd/ODt3DAN+Yo3AjVPiMzEKcNlsiDxA/p6CSZhofvFlB1LPIXkjdHJhS
 q6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765873750; x=1766478550;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rvaxX0jI6veucQdTm4Z7/XaxgHp3jlCxl8f5D/IfdOo=;
 b=oVpikdESBbPNrpoOfBl/Gf6z55R5DMmoqEqs6Bw9JeSZSBa338C04f3pf6t+96GyZJ
 RcwELvSuSK20ekuWbBNHV7+YJBOKgcd5HNH13Uo1y09x71RNCaLGvPCqEYRwA8g/EpEa
 nODG8L0c61sQA+w1k2OvChVZDfcNaV9E8T7/I2299NL++36N8CVQC4QJZNbw1t7ntDcE
 b/WjglYDmd7mxGwAESjRZnUivztRJqGq3dv6dXjwLHtXZGIhyThN0RZ0PCHy0wm8y4Re
 iOwl9iZ3P6ReKasZAWJnFWZ4loygNxdXSDlNW98pmOOWceLsDhDyIROEV9UCFyenpqwC
 CJMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs4rym8mL2+OzMuawBxQY6e0gqxPZ+3Tyu6dOWj3FqhEAOZzzSxdjhqw7AyKtnbK2R23Y=@lists.linux.it
X-Gm-Message-State: AOJu0YzIQCthR3X8TEQwj0nG/URVhyFUSwv9D40wYhgZjzsqmbjQBu4B
 JSxbtKRZFSVhD47NEZnlb+kyr9NojjFoQpiA2pPiA8xdgxyvhp6TdVFqX5Vv9wF/xZ8o4gRMLai
 Trfk0FZk=
X-Gm-Gg: AY/fxX6IIdcE/9izYIiRyZ0PgwJ1QC3t+Kw8tCRMm9nZHVJqCfmhL/dtwJEcnT6pcvi
 xieS9LcCx5Xpu7VpKMSaTFsas6Kxub4KKlr92m0o4PedG4+CbNGaev+pRD72WzXSxzkhzQFrJtw
 LLYGO0l3GtjfQ822i7b3vFkP95/loizsz2L4yXhUPdR9oqwOca/LNXxySal3PPG8+/zXwY7kQHK
 uZHHVv9rdDxxdRjF0Ix4OqG1By0CI8qExBlHS2BYukfMKk0sXmv+XGgHlOseHdOgy1SZmRxL3+Y
 3/TQUpHPxYAUKl4z0sNJLTnqJ979lDVnULt0LyyxVeS7HPwJ26W4pb1Z5tkahHyf1RAFtglVMxH
 rPIEqwxv1G3aX5Bj6RrtIleVlUUZjA6mQB7u0NDacCJ7nHgOVw9ePi/rPJpzaM2qpGAFuznubeP
 gbLL5Gwjfqa9my8JRnKpE=
X-Google-Smtp-Source: AGHT+IHrNUJfZa57OMgmMAXRWrCEuhP3z1PCVDIPlCItS/JgxPyGuotEJp1DLJ3WDdhpc8aET1ECVA==
X-Received: by 2002:a05:6000:4024:b0:431:35a:4a8f with SMTP id
 ffacd0b85a97d-431035a4cdbmr2685168f8f.47.1765873749880; 
 Tue, 16 Dec 2025 00:29:09 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b9b750sm33480517f8f.42.2025.12.16.00.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 00:29:09 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 16 Dec 2025 09:29:08 +0100
Message-Id: <DEZI01255INL.37I8OXX6DNZOW@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251215-fix_ci-v2-1-20d837cf9b8b@suse.com>
In-Reply-To: <20251215-fix_ci-v2-1-20d837cf9b8b@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ci: fix patch download when using curl
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

Merged! Let's hope this will fix CI once for all :)

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
