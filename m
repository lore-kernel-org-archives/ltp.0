Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BDAF4645C
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773664245; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ITBGb9qBuG2p0mhm4bLXogfuT2ker6Z+ts8SeosppeU=;
 b=CnPwJKIloE/VtwAerolo/p3/sKj39KhBwb3tqW1bCx8WIsTvkHgmUXUJgj3tjc0DKhotc
 yl5r6sLUysiyf76OAnDuYSy4+q5IoG2nP4peuiOS3f7ej9zShxTxataQXHaqxR7UR1emQG/
 883TXwa/hpOc28lk3zDsLi24z1Fnvoc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C0C53E4B90
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 13:30:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BB733E4B84
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:30:21 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 02DDB600832
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 13:30:20 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso53385255e9.0
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773664220; x=1774269020; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zRqWfP6Pfm1zMzKCZJ8kJXvs1rS0un4ZrCWiZ08pqF4=;
 b=giLzi2ipze3NYMBQKm9pvPAa5BJ9Vl3q0Ar1f1MZTE+QcVp2BeIM2xTohZfft5n8Vo
 fUUIn7C2DDoMV96i4dY6b0f0TPHaHMcF389XOSIIaBPjkHbmzUWJGWpgK7q3i65/d3bm
 fps/UaTfEacxrvD1x1DY66iWK32cljqF+hvp5BFzZCnCzlaMezZA02GORGz+woiivJNI
 ratUdTFsIPbwUz6tnp2XztE9zaTRHGkRX8vDIkPMHkn5g//IgtLUPWwwJVGSQE8PcSXB
 2GTsujfyDge7mCpJue7wUlT54j/bTdsAc0u6kt1u93lU4KQHm/S8gDa7RhkacyFilG2h
 UYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773664220; x=1774269020;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRqWfP6Pfm1zMzKCZJ8kJXvs1rS0un4ZrCWiZ08pqF4=;
 b=Leh/HlTi9keGOW1ApNszTZuT9arhWNi+5xxpqnEVi+pswUlDkdExxHKnrVVv5CvzXL
 8hg53Rc2xKUHfM6MAdFaBiciaq/YKePSqkYMPislbyxzwdVcCluJJMQDXYyEHvBErD+H
 xnxUeqfYL4MHkdxJyTFiLtZ21l2ebpxKvG5bKXh1jty3N7AcEfAgsnkbzKwdn/8vyg4s
 OBheponxXBscTrGhSNgFGVe3hGpxexLEDGML8IxLl5i/5xpKLgu1hnnoLWpr+zSoCzqB
 CllizL0aK2eKEWvb5g6kh8wcOyt7BqQgcMIj3JJmsWJHEPoVtqh5MIBdWzEz9fd8yfRJ
 tRhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ogmZjDSMBd9ehY1yX8n01Y5/zzK6LAJxR2DAyEzXw+tyqJx4C1slJz1mmncQzexw+pk=@lists.linux.it
X-Gm-Message-State: AOJu0YwOENVZMNw9TcaRPWyOfRVrbDL5siURAApT25N+duqJLdrkqcu3
 OYXXPyGb0u2M9raQNL/NqJtsbBSYuqzNp0eOXY7KTz2Snj7FnzkQPVWs9CXlr6TIz2s=
X-Gm-Gg: ATEYQzzX7j7SJpVjs+VfkL77laLwEI2A0NPDm1uWGwMqZRjcywxiH49RLcFLUJn1Doa
 RdiOgRpeYpEL9oeIsDKHNpNBvCj48gy5O7SJ27QinoQdiTtpOpkwGQPMepuFHEzNNPQ5U6CuR0g
 xwyveIQ946H62B4sP6QqzF6ABDu203KkJbnlPR6U1eQm8lO7KU106JsufqoIbFzHkd8AaaaUNqO
 CAX/RTtU93h80aWzjWmSgAoMf/vUA8IWjpkIMcYlLphySCh4xpq+Lhit4gRNQI5GelBMNaArA0c
 rCST90udXxIVqbv19n+zN/w4X17NmP+0gZ7ZFVldqxBkOZ8KYBcbs61fXgufsmagXLzC+hdgYF3
 KeFFcXmccUGR5l6pI+Sxckjye3N3U6C+M/x3+qjxhLGH4WVQ+mlfLX4FL5ICr5UNZb6mh0tLtQS
 WwhwGQ4vdMFEMHTDChjRX6Nup5Ey5M7CGEhtAwtfwqXM2uVRhCkU0oP5C74wy+l+h7IN8mVUbJ5
 jVOJhQqltl8ZwBa42Udz/hVx/m6B3BGg3OxNYrsSkcUMTdbU7VzitPrmC2XgeyX8+khCD2l01al
 Pg==
X-Received: by 2002:a05:600c:a09:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-485566ddac0mr232421245e9.14.1773664220242; 
 Mon, 16 Mar 2026 05:30:20 -0700 (PDT)
Received: from p200300ef2f4fc90053e282780f88a5bb.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6bb4sm411213375e9.4.2026.03.16.05.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 05:30:19 -0700 (PDT)
Message-ID: <69b7f7db.050a0220.14698e.828a@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260313160520.39745-1-always.starving0@gmail.com>
Date: Mon, 16 Mar 2026 12:30:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] inotify: replace strcpy() with snprintf()
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

Hi!

>  #define BUF_SIZE 256
> -static char fname1[BUF_SIZE], fname2[BUF_SIZE], fname3[BUF_SIZE];
> +static char fname1[BUF_SIZE], fname2[BUF_SIZE+32], fname3[BUF_SIZE+32];

This is a hack around the actual PATH_MAX feature. We need to use that one
instead of defining a new BUF_SIZE that might overflow.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
