Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C049CA5FC7
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 14:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790779740; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=WL83Efrx0UmuEzVr0MsHv+N6DSqRoeCk0xN+lnbPuB4=;
 b=TBKE7VHOOwnimDKA+vQmR1ZiJRyu+cQy7GSIFw6+7zDBRWff389TdN3kjvUERKVrXA4nu
 Ovlg1NGXgTWjHilf/4fqxA8Q7ja/WoA8y3qEHOucKgq7X6LYvcaFwVfDqBgrd78ieRH9xQ4
 K+nGn1ew2s7ENhRGN96MEqbYfMdSizE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 507953E56A9
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 16:49:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 317523E1A5A
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:48:41 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C4FA210005A1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 16:48:40 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d8239so44473495e9.0
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790779720; x=1791384520; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D1xzIKoYH2D08NIZmds7sqYs1Fl022w/IDXMRzPPToE=;
 b=dvkm5fAV7BjJAmnG+OJjJMTn2Hfv57gW+RzDtnhEkkwtMYLa3cSxM6+376jmGHQRJU
 DNpnujwYCx0N0gW0pnss/MDmXoPmWcF4AIU0xemHSTK8VViPJfJWybFQViviqDtE3cGN
 /T2g3nXWqAoT9suiBVrjKMZI5UkHssawiOUQBOd7eWjzAhHZAd32IzK35tGj/gTWYWJ9
 7YTxRaeai8I29y4+DhsMm6kvgcQWk15cL6ISz/jCbAadKT1bdyZTnROEQ9M/+u6RSyiu
 /PBUP2kDws2pRzuCTHbJ29yFy3Dv+lx+922ps0C6GMT87g42rtSwEXx3TAyLua7hcVI5
 6bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790779720; x=1791384520;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D1xzIKoYH2D08NIZmds7sqYs1Fl022w/IDXMRzPPToE=;
 b=uoCHxAaLB/a9P5peNl0TrfRH9JZvLOubp5oHCf1u9WVZ/P28SURciNGSQmJ0HmwOwS
 ah+TtvuB0yg6djA7tD3Ku28MKdbBUpvLHyysZIml07hsZJwHAXI6nfp96tqhCSEUFIif
 K6vAHLQQi4pujiYNGrCzNm/FWFzXhwgjZc/f309ycJbsX3s9yLwbUvnjDrfDEx+aKq8j
 tgKLqQsg7TYlvTlL0Lw5k6GzyyDQkAzS+aNbwxarpy14uBSoaSiU0fWtp9/M/Vowx8lw
 XYkUDrNWdLJqogF+sERdhZbhSlt8YKg8pGg2fiScB63f9mihUesJ5DK5N7y7LzeZoM7g
 jivQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1n1iQOcla+y7466Psz3hGRBhqyRFiChCbNG1N+3l09eOO1YfxL+jMJ47GDM4tBRKtoSc=@lists.linux.it
X-Gm-Message-State: AFuF++mypzS1cI63JfUU6xbF+1FAgzImGJK43VNgOs/K7Tu4OCRAJZrI
 XDxPZVH5aBGAXon+DQAEt+qFc4oEY5RmRY3a5vl9NnWcM1n1DoDny7f5BFW4yeXGEnQ=
X-Gm-Gg: AYBFou2KsO8mtPaf3/2frnudqhV9bTlCqmhxPQd48pkQ6Km5wpSiBLzWT62fiHepYDo
 KyvrNOyDbQIzIq5bytQXTEtMHBNDNpNdLqRUQbHwyMqymxBHXnLerpL+Rn9tjazpZWqyOXerQyK
 dOuTsk/Jy4nMzIPDkUfVNT8H9gHQZ/dslrNmxrGV5yfwOa2vnD9UejF+PIeLVBlScdLCf8Wtwj2
 ukB8uuxauQIG4hZir9sHApAYj4p23VbEdXz6PBfsyFOUO5w0zn2pkCkvoCV+CIcfcbtU2I7Z25I
 AKRa+DtjCayg9G9PCBGK7KXFjd2VK5if7SHVXijGaf9w1gCj1tLbxvkfz7GjTvJKNfL7ncXEH+J
 gYwQehzmuXAzpIyR0dUtT5X13nZXrztzTu8t2Ga97OprCblJvBfFaVvpe9dWSbH+hlynET++DLa
 Z9ZgvvFdmgiNVy++GqKg1He5ITVGkhXo3rf6N0Cl4SCYB5Bu2gnQTmmxgLqz1pA5AmqMfa9aveb
 Q9JlUNRERZRnZWrodKvGxFBZCULDhZJt2K86ZdSXbdY683dVl7Uin6/Rh+2LbHn1PfDiIGsusc3
 gA==
X-Received: by 2002:a05:600c:1f8b:b0:4a0:108:3b48 with SMTP id
 5b1f17b1804b1-4a01addee56mr28136285e9.7.1790779720146; 
 Wed, 30 Sep 2026 07:48:40 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01e66b10esm4246495e9.14.2026.09.30.07.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 07:48:39 -0700 (PDT)
Message-ID: <6abd2147.149e66fd.2390d.0cf6@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6abd212b.ea8c0684.18c111.8e28@mx.google.com>
Date: Wed, 30 Sep 2026 14:48:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls: Update numbers to Linux v7.3-rc5
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> thanks for the review. I will merge before the release

                                      ^ after :-)

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
