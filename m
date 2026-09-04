Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F853C61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788519019; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=OBQDcC7PA9Bj6Zuq503UqlxJp+MffNqrlXS5ry3StRE=;
 b=kd94G8cDK18pUu3V8pODYPgzxUVWJ4NHGvhcxZvpUmDu2B4isglNQYEcjbJGfAUMuhY/e
 AVS73m1ypytSvR+m4quxn8DtTcVMxt0/FKGy5IsplDrQL1YyMi6dgHwIQFiQh/eknW9pgdj
 lJqYCtO2xJsqx+bDcjETnd18CjWhGKs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6B3E3E976C
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:50:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E96C43E4B98
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:49:59 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7D77810005D5
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:49:59 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso9955865e9.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788518999; x=1789123799; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VGvIqs57arLE81PU0rY+Pu0taas4YGkxGdkpa1scWI0=;
 b=bts06hVXQ/NH8L3h18SDL/Av1c+/UamP4DAS25XGrLBNVOJaHoNKFADBENEGYAoEC0
 FzfRLfbCc17Q9y3s2Co+nYOChtXRmnpxwXs156ECr3NS90u0hjYOEb7r0REZZHAaAO4/
 rfErxp7O1jbbqZieEw6CXjXxIAcjAnu2rKrQ+yO6MZNl6rTpV5vDXRlUAArP6QgaTga2
 j0Uoj4izBKWkYCM4Xhtr4nlfsvx2J2iFWauGgQ88kfiepP88IPqDoUI8J+HqUCs9vJhH
 Vz1EHfueeaeaO0mLbtBJmteZKeVVzrgPHUBmP0yatUiEw7ymOD0IfWeMj+tl8jum42dj
 XaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518999; x=1789123799;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VGvIqs57arLE81PU0rY+Pu0taas4YGkxGdkpa1scWI0=;
 b=EcLPJwa4IUEO+at4SpCAEO++UIImvo7Aj1l99bpPX85SZXWY3qgdgfthwPpYPwflgL
 rOtwm0tobMry1cuI8oZ+Gc8U0YzHbP2xMtcVWVAKGRhM0paKwH8ojAVa/lzDwqbFd76M
 xwB+GpHfXdYxa7uPNW0JeJe3y+7bTWPdUMTbyv7dJpXQdc7EjNeoH1a7xjD10MYklBIL
 +EedLVnL3AlLSEdoZ1r90z/r32eqsTJEqNMVdLHHeGkho0525JpQrlXom+rXmF3ml/TY
 nNwVh6fIANxMDNkzk8WcABC85yq8QyyJoLtC3LiWIzAnA8W3KqBcDqPHHA9zF2ZWZ16U
 sMLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDbQiomwyvSUZwO0x/cNUU3/6pIyS/ib8YgxSdRsLsr7XCNxt3qFHzOHS3ZyLle/OVkxs=@lists.linux.it
X-Gm-Message-State: AFuF++mLQcl7Hda5UmjbYP9HkdB0US8ZmOdSUpSAAH3cqPIfyg4Y8z1a
 GcW24RYTIIcSeSqPAEVTK2j7Pvz4yVa2VSt7SHlD2YI+TV7cT2P55rTfluCHYh5aN41VOWBqj5C
 4oNdC/c6k3Q==
X-Gm-Gg: AYBFou3RHWqSpsz3YbVz2gdlQit7sk1S1kUmHrQw/baWpGF7T/BgRwiSFalVTM46+ch
 yqtJXw2GlXtFpFp7xXRXWvfPKRY6WlSrzRfrQB0xARXK37MLh4Is4PfmwsURIZ7eiURb43moR8P
 31QBfKtFvBPNt5/7uhzmzXX7LAxrnY5aKFDHt9mlQw1AAgv3NUVcoM35PTBm8cdMGY5lD3+TR9/
 rxu25PjcolH5h6UIRxLBZu308wNtDIUVk+LP5XhYsfZ0jUlgSl1p2L1TMPPcloLyKUAdhWBznBT
 oV+aOBn7viAm2KMb99Ne6eN1I4u/Vq6TxWkF1YaUiY5U4e8JlC4IP4nqR6wbucRiLlT0mvzpWjQ
 RGwM+YeGUprQcH84U/VpNsLFbdUkoeneF9ArqE8HAjYrox7Dw569O2xC35P13oNVWA4FFXRHgcb
 jpSDszOKiafar0qmVf4zPDfi2dF2lOwYPEYvjupfWI8cOTb++Jz9Mptn1pa+74AoH6243aM+Ktc
 GdqQLuzfBEB
X-Received: by 2002:a05:600d:8445:10b0:495:48d7:f178 with SMTP id
 5b1f17b1804b1-49cf825d77amr40590075e9.11.1788518998829; 
 Fri, 04 Sep 2026 03:49:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm386978975e9.0.2026.09.04.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:49:58 -0700 (PDT)
Message-ID: <6a9aa256.ed0817e7.6bb22.ec68@mx.google.com>
To: "Li Wang" <li.wang@linux.dev>
In-Reply-To: <apqM3bxh26RrnN3g@linux.dev>
Date: Fri, 04 Sep 2026 10:49:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] coredump02: Verify ELF structure and notes
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Splitting the core file parsing into a separate test is fine.
> For the duplicated code, there are two approaches - I'm okay
> with either.
> 
> 1. create a seperate coredump_common.h

It makes sense, I would stick with this one, because I'm trying to keep
tests as atomic as possible. They are way easier to maintain and to debug

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
