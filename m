Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369BACA5FCE
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791207023; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=V232oCJfVzuFC8Sgfl8nwA2GWfPVNbpvWxmIsiRWApWEVqT43/qAyGWFHadaZzPjwrXis
 Ti5fem6ShJfsBcoDak/vjB2zqD/UH5enozDTYdOs5CnEfrNiAvNPzsDy7iJ73afJU0jIMqD
 Yis9RzE3/bYh/wRKEybdnfTP5Qp5pn4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF6143C5583
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:30:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88E0D3E5440
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:27:39 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0963014002C4
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:27:38 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so18505595e9.0
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791206858; x=1791811658; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Urn6/rVNzQbEkO+5pffIATOEIKZmKiqDQ0H0wU/D9KaJakdKnPi6NO16GpzlQ82ubr
 EaGl/f34ad1Hmyawni8g8X74h4cMYVMqTj5DoyeBkZUhE6jPJOCVStG5dVFbWoN+cJUt
 Ip9VB5r0V9Xj1NfEgNsbLVZmpMe/Va6wKLQLjeo0ivMhrOQegOdRTEPkuYpzEg+2U3OQ
 c4AZpM5p3ESuMIeTPvub2wIgm6LwFR/MMTEjRymm0D+o+NTGGwhqhS9IOHfuf173flIG
 TJkd2fL8DyZiOC08aj7LTGcN3Kuq5Ml6JT3rKFwnuwgoEp0mc41pollMao0wBbOvWpqb
 I+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791206858; x=1791811658;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Zan8ADePL7ktPeiK2mSMKOu+/zlAN8eF0WB0nDNkC9caeUXHMytPKMQ77Xk3433maT
 1PoAWQWLa9/r1Zp1UvDmqDvOjAme5sQBJ64waTfDO9jWRYCOOLBpVt8qoWfmsjX12D6E
 kf670kpckiKb+jxHtDc5nTRPS4b1gpgHuiNE1GntoEOW2VkLhKLO3GwjUZzlvzhdnjcU
 To+hBigDLafYQmx1QXf3SndTyt9CWBnYHe6WL2iM49/Ghl9D5sDzl1G3gp85VZaxSuT8
 F0RhcViWR/CiGMGFTkhrUHvxUduTvXv6E5gD0U4sXbGyYvhmmV2V9zSwAJwOHqNLLb8Y
 EQCg==
X-Gm-Message-State: AFuF++kPeXi5G3Ynv3Lp5So01wxxDdpwFpe6Y1hOnkECXxZEGVwv5F7D
 fB63Q0Q17P6KpbVEjUyckei8A32H63uhtGqIJIdgR1iU3rbQzFyH4lolKLWCBOsUGmU=
X-Gm-Gg: AYBFou030M9QPpP0JURNe6i8nCLL6/Te22VKEHGvpCgrJOXSQLLIZV9rNPLIePwU42Z
 opPKXL2ymDg+XnTaWfOMVD1d+WhJzXcO0P9RrHWWvuHoQh+dkuW4KNelVatnPieb81fealenQxT
 VxzOhyf6QMsjd5qCagg30k/bKfnX4ytSVmEniSsfrj/NXHEz+lXgpFol6J2COgS/MTZwK+jv5Tx
 DSnP8tqpH9EUudDub1lK0eLpI6UKewUkgP2xqmEwpzHUX2+917e6Zi6l67CLpjbn11G2NZ+UYTQ
 zbgajtEY1r8eeRSsCrBj6a8smVZC3ySlFql7lpJeQ7X+0cfeoFvcvAFjZoWE976Zgye4QJ2I/CK
 saTG6wS3Sf0n45tHu8vYkuPp9atPcsQrNzhi+in8RPFusRRamFXF18oV3Ebc4qMz8M40YqMfnTz
 Y5ZAOmsIkdqY0/fWztK5beUnewXxReZjxkXGG3ymjvqLnkq28YYNp9jqu/WPFIlp4GNTl7QO6F9
 4xd6ynD+Xa0/5eP3qzo8l/sZRi7WGisgZ4/0Sfs4n4uAfI=
X-Received: by 2002:a05:600d:82e8:b0:4a1:71e1:312a with SMTP id
 5b1f17b1804b1-4a171e13212mr58513715e9.15.1791206858215; 
 Mon, 05 Oct 2026 06:27:38 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62100facsm4110812f8f.0.2026.10.05.06.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:27:37 -0700 (PDT)
Message-ID: <6ac3a5c9.041101f3.3501f4.675e@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20261002130556.1236937-1-wakel@google.com>
Date: Mon, 05 Oct 2026 13:27:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/procfs.h: Add elf_prstatus and elf_prpsinfo
 fallbacks
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
