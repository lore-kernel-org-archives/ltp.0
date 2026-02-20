Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E81C55ABC
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771589424; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=7QD+ORLyo0VQeIgciJs2Ftt+/KJNdFOgn3liYXJZ8Sg=;
 b=LxKuyDdWUnXiBhOwjgGCDFHz4sbZtXeuo+KOen7ToRX9iHxnDVwREvRTXVu4/clmNAyDG
 i6lbmvrTZ2Ua35Dp2xcBNlBJmEDL4EIhi556eg2EXH1whcw/ioF9E59KZhoV+qNCGvo6TrE
 qZ0WPuCYraNK8ncMZau9sAm6B4VKITA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 907AB3D084A
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 13:10:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F04BF3D07AC
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 13:10:00 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA3A310009F3
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 13:09:58 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48378136adcso12201795e9.1
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 04:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771589398; x=1772194198; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vahb+3DnEj4KXEw5qqyk/3loK9Ndunpk3Kt/4m16ieo=;
 b=GtoUZdCC5KCkPdiPA2F7dYZ9+h4sZLtETyHC2OsB9jpqezpUcBgZNP3NRZApmyYkKl
 ZT1pGZJCeuuG6iRCAhOqG8OZQCv52lazobAXc8Z1tL2+4wm+xiIDGLQECOZmnt3WirLW
 JA+48CvOYsU2WBkpwizpeKbEv5G82LaVdrejtqmpIgzPFwa3pVI4eJJvE85JfE25aHzc
 3xzjzv+fmbytRiOOc81PhecWW0u/9QZQdtgTOJ8JTULAAMzEgbKu52hH9imqAy0YB72e
 F0vMtUTikxA85arzDQ8rkTuQbaTXZqnYVgz/aSo2h/eGw55QTgOWWfs+CvZ4B28eXqiu
 0B0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771589398; x=1772194198;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vahb+3DnEj4KXEw5qqyk/3loK9Ndunpk3Kt/4m16ieo=;
 b=fRJ/C//a7Fq/zu/X+3ogkOk6TkhZgyXkC3hlocC6GVZbu0vTTp1b/af/OaYBM6h7Tw
 UUSE1OURWW2SIBh7KxnyFKJoppykfORH1p6d+pU4REDgrjo0LBelv9QsYokcVetcBYIY
 FWv7JAPNiMA2T9py0SMMSmNlBwQzBKWtVypI4OkFfWy2WYRn2g29/UibuKn1SOqHWjgT
 3LyPqyxxxng91a/Xggnfbqta2DfDJ7JFJ5TZXehj47eDpg8QyH7mjIjluBwW3pLXYKr7
 x478CKKAq5KgNXtxzaXy4CulJDhW0WxhaCs+fP+aEjGG44P9SeCzu32cK7IIVuAwjlGB
 Q62Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCFd7SPTqDW9SXbYAPQ2wUQqPGSHplVUQrgxJnBuLt/Qf3OncKjQAPFc8zflteE4Zdpbo=@lists.linux.it
X-Gm-Message-State: AOJu0Yx2MU4PKzbGgNxJ62eLmMIZMEHhwcDnx4mvsXNtLlzaQC0vEwa9
 O+aXsZWo5/BclKcYeaEFqWfYtum6URG8EQmmE0k/bnGyEOqz14xS/AHDwia8mtRqEl8=
X-Gm-Gg: AZuq6aLUd5glzdmdhJrH6RQs0LPlZmgt2IanbhvCvdTGdeTJr365CXMLyhTo3DtZ1il
 8v/OFKkF+FBFiQmpwrSJWtp++2cauIWq0No4o/Evm4UbD/RrqeGLgXczjy4PQgJq4byg3u6KCSL
 cGF4JU8EuhZfi9v67Owq9fj67xXJg3vz96B8yfFIlCwU2vRcluhQo7zlQX/eeSTkdXbygvSmRt0
 8JIJkrS/oIQElW8u5rUb/onGowKSthenD9wpr9lRa1hy2maEYJXl7DiOZu+S2WJLKk5Z+m2Ra1Q
 A1mvm4+7HNxGEALiKbDLNhO0NiJCgSEZcmwVQgsN2Xz98r8lZjXEHojoNyuwhhKO/oUxzqq2c6d
 Kn0CqF99F0KFFtBz93aGWaWwvsnWh3FfvL47FNn8umHP03vHz9uC5Zd2t8SaUOzGfiI8Hiya93A
 lcxrK4eweYJQ7mjtitEqgpaTOvrzMvMJYfcmT72RGTaN1l7VdmteHrHqiYDFkjyZA3q5oJMVsvX
 /JCXJFQof2m3jjDbY0=
X-Received: by 2002:a05:600c:6308:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-48379bc887fmr346535115e9.15.1771589398183; 
 Fri, 20 Feb 2026 04:09:58 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm115895885e9.2.2026.02.20.04.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 04:09:57 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 20 Feb 2026 13:09:57 +0100
Message-Id: <DGJS11PWKA7O.MCA1LSTM20G4@suse.com>
To: "Jinseok Kim" <always.starving0@gmail.com>, <ltp@lists.linux.it>
References: <20260207170632.2795-1-always.starving0@gmail.com>
In-Reply-To: <20260207170632.2795-1-always.starving0@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inotify: modernize with SAFE_ wrappers and fix
 minor style issues
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

Merged, thanks!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
