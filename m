Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B01C83F27
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 07:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752652644; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=aJ+GIZzyedfWvYe3vm5BQH+HQvtNI6kvvnKxvWTPi94=;
 b=RkaME4ytl4xirfT6ezv3wkP26kvvX1+vA9+j1mVmH8uNJ7JzpKkvlGErayICFJP38Ulwj
 MYmZZyfNA1Ee9tj25hVNM7JaDdVvaTsUfZP8Kx4XhlFk7PARZVhvw9ndciMxRvFrz/QRpzv
 U+bi6y2LqB5M6zSqlAZd07KyAEi0fKQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BA063CBCE1
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 09:57:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E89D43CBCBB
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:57:01 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C2071A002F0
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 09:57:00 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so61471985e9.3
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752652620; x=1753257420; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OIY1ysMbA5WAvIqOZCqiHZAGXgJH+p6u0WEEAxZQTfw=;
 b=ZhWva73dkjybD/e55ctDwrx6tOCaoyrGzKeYbRpgUOo+gRdAhLhAA56HYc0Z24XVZ/
 097+7qdYLJTIA39iLVc/qGJirTebCFki0yxMu9glSmB2wwda1x7ZO5bk7diu4aLBD7HV
 AeOq+8QcamjM7EMzAEXrjTbgwrOBT9+EbqWeL4ID3QvHvawiYCjGdrQcL/NtMu2zZOaM
 ivVlhiy4aGVFmQUwQQeWlkWNDYDYfkSLHuRZx0Vw3TLBaTpYnx7XXadp7sPS/GlxfDpb
 k3mVGUNO1sq4rKiFIBThXfiVcQ9Rj4PX6oyKwlTnddBl+JowPsquzWh+gd7CTtDO+Ior
 pabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752652620; x=1753257420;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OIY1ysMbA5WAvIqOZCqiHZAGXgJH+p6u0WEEAxZQTfw=;
 b=cq1QUKN/SMmFZ4LrtIr3MB5cBFeEeygVjb9Ivq8CJl8PTsVi/TmygWj5ZK2Ajgz3Ri
 P0xEOZWhOprvv92/pDAJZMGz/T/PT3lULb6RocYxgYZdShcE1SOAnDTk+0ILm7yT+bOC
 jDVKV6bCvZjatabP5Ds4CwwU/HjtEYvxSPwW+VYzKp8YYwba6TwK4wGw/vY3WiuT+ZZu
 Zzsmil2qHQmZpkIKrDiAFE4z3/HRWePoBRaD4m7aKIeRbHMtzDX6qEgOfJaIczQvDWf7
 6bfGOtQAFZ91v+w2K4Bo5f1M3p6RIjCLDebdl0/T43M/VAtxxAlLZIyChe0lCQLn0Q+F
 xqMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJw/eexLmXiIhxvsMQrvIlJmIDcjxpsACKEcLJLPidP7en8Wx+K75EKejnqgPNWxE+Bro=@lists.linux.it
X-Gm-Message-State: AOJu0YyL+jMAv3ewHFaTrJc2jzAfaJHz7HW0XCUjMYpUbrmPDbiHbtgG
 gdwdxPgsTY97GC6nyCF4JAQdoZqtX4/7e8z5UP0+/KUR4DW+fBaAypzJDpJBFv6fcg==
X-Gm-Gg: ASbGncuUNMJLtMtf+pSVTn5hscvLuY2dDF94/3NhKm4z7gYBKDxpQpCta9owypeKzln
 fH4vg3jGUhihFfDK/nTEbpEUz/B4UqOhIj7eyNmG7AJOTGukfwjMHG0YhJ9nPGiyIyJFaQnJclt
 ZXqQptBFu+FrPmPVaX92arseoKKdVC44m7arPNl2zXretDrIOiGBJ11Km1JD0PQR/P1md15S/Cg
 snxeIwhM3Jzr5c+5vjhb+u0kiqY1lRHaGGxhLKxzS3IhTrf4uF2UiJh8lc4LFZQYIIg113wRZl8
 Wrnk8V0zasftO2QF1lPGHcPnmYkK9de0zupYCNj0OQNkR8EdJMSX/QdS8nAHKiVxvH1CTkmvKsM
 TtsXB2eHbqBBIqcu0Hz7Riw==
X-Google-Smtp-Source: AGHT+IHcatelOrEdUUkvCfObZhw/jaOfdEvzfI2RVZcrxIaRzRj9zTy5inBuW89nFZFrYOSu1pafIA==
X-Received: by 2002:a5d:5f82:0:b0:3b4:58ff:ed1 with SMTP id
 ffacd0b85a97d-3b60e539e8dmr927373f8f.52.1752652620236; 
 Wed, 16 Jul 2025 00:57:00 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4333d6asm119957715ad.154.2025.07.16.00.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 00:56:59 -0700 (PDT)
Date: Wed, 16 Jul 2025 15:56:15 -0400
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aHgD3wLn7Uw6ywyW@MiWiFi-CR6608-srv>
References: <20250709-xattr_bug_repr-v3-0-379c2c291bb7@suse.com>
 <20250709-xattr_bug_repr-v3-2-379c2c291bb7@suse.com>
 <aHf839WS0BPIa5Zq@MiWiFi-CR6608-srv>
 <f97ca222-fd8d-49e2-8e32-6e888d832f68@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f97ca222-fd8d-49e2-8e32-6e888d832f68@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add listxattr04 reproducer
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jul 16, 2025 at 09:34:30AM +0200, Andrea Cervesato wrote:
> On 7/16/25 9:26 PM, Wei Gao wrote:
> > Current tst_selinux_enabled within your patchset not check running state
> > of selinux. so i guess you need check /sys/fs/selinux/enforce value
> > here.
> > Or you can use tst_selinux_enforcing. Correct me if any
> > misunderstanding.
> If SELinux is enabled, we will have /sys/fs/selinux folder filled with fi=
les
> that can be used to verify SELinux status (sudo sestatus -v).
> tst_selinux_enabled() is using:
> =

> =A0=A0=A0 access(SELINUX_PATH, F_OK) =3D=3D 0 && !tst_dir_is_empty(SELINU=
X_PATH, 0)
> =

> That is enough to know if we have SELinux or not. According to Cyril we
> probably just need:
> =

> =A0=A0=A0 tst_is_mounted(SELINUX_PATH)
> =

> Like it is in is_selinux_enabled().
> =

> - Andrea
> =


If only check enable status then i guess the tst_brk message should use
tst_brk(TCONF, "SELinux is not enabled") instead of =

tst_brk(TCONF, "SELinux is not running") ?

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
