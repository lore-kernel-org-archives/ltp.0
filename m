Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B4CCD343B
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778139021; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=fpzpaRYvHzuhSkilE165LjAsqZsEEzcd+d1osIPDwvg=;
 b=FLYmqBL03NePqrAjx+bVOEBO8Na8SeeJ0emh0R+WMLJ72TYJwAnAscYdlnQqzX31+FrnB
 KCHThhp7SUccBBiU8C82nQ0sJ+3AgrmJe//TMDkX2gYYO/bmB8cdJIBWAInd/ROfZrAGInm
 t82J5+dyT9gN5j1y/W6WAwTtbaZZlSQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A94CF3E2499
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:30:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B48B13CB935
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:29:57 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E18681400435
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:29:56 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so292399f8f.2
 for <ltp@lists.linux.it>; Thu, 07 May 2026 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778138996; x=1778743796; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gINiS8aL8R5JbgEfiLpD2ZtFzXInljt4oscn+6d/2A4=;
 b=eQg8OGpaZ4iErHijrTAgtIsmOnjQcq4LUJpsswQCB5jlF00Rd3ZbR/yu8m8+nsHYBz
 6D42APwBEw4bBWTPPiCRWj1j2HIcrRBIJo2nIhcYk25TUj/718Mpo25Howl9X6wg3AUH
 QSGUnbQteVPG2kO5R1F4Rp8Y19a1JxBC9l6D2UahDdAXQqzC5FBbZtlZuZqMt/nkzHEg
 WR1nvdvZEka3EnqyavOArtmIyUm56SZBIgDI99jq+Zz4iGealZy4iNI1f1FYGSfYFEaQ
 eErHdVYOOaRforZm+VR0F/MYHcggOGVlOAqYZQaSk15RLTvgenBRDUnnlRj/9OhsFWHr
 /8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778138996; x=1778743796;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gINiS8aL8R5JbgEfiLpD2ZtFzXInljt4oscn+6d/2A4=;
 b=JV+tvCR6RGxNs75d6mJOUfueCtAqQQE38A4jN047XkM02W5CnTa0DjB2WS3rHkxR1m
 vuMp9wLiP7kYIsr2qwlhPE1V/FIscDZuBEJo7m8DZw2mMKAAx95RijlEmsH+E9V4B0Ei
 7uF1GGSrrB4abdQIrikV0jixZ1P/DmkiP5zx/lfzmrd82lFbn325ipyusBRU5EEEZOo8
 LxiQ/e79ih5MRyZBRCRKHsB5HosPJB+V1Y7BllCdEYQTWx1E2Zfae07khKqOKMnQ1avf
 tUVTGMdjkHAw67kohwjSXqMJjemCtYaUimdVggAJwyrbZvngYUSoN4Ob1CVRDi3QYhkv
 wNdw==
X-Gm-Message-State: AOJu0YzqDM9o1sxI+fQXrnVQTiu4hDuYIl01dC/Bk5XuFnsHsVGI3k8w
 p/4ujRcMUZPQDHFGpX2UYOvAvsLhkLCU50NmPeUqs9+n6DQiqCnEEfEJK+2HILNOLEg=
X-Gm-Gg: AeBDieuUKkA35uaciUlSipeM1q5rwoubESr9LbAwQ6QbYwdfxYyPu7K6VI49OFGfe0z
 hkNVEQN5VPM3wkD2WUKCJdtL62br5N6OTnQZx/O2r2uN3TBhiz77O3NUswwCBniy2ZiNyz3QOPB
 GR1o2ZQg3RAgq5vyXLK2ek4Pt7Svv7o5azSX7faLOZKuV8wClnggmHFo8K6Fr3hCxNecYipNLHu
 7iikWuuwRKY/d59tYYBTKy3QQe+C1p1979ntyVOGzMk9MK7KWLZzBN7GKXKf6RDe9+9BHCX4r5X
 1LCxvSxABHuYR2FDpS3HoaL9w7vGTdevW8yuwUigRVdhFTFHWeoByVgjeHtId14tW0RvY6gN1Be
 2/yTxi4HxEe8A7jPTDxhImRG2fwKf5V8/ouD1T4cLs0HtKd75oq76a9+j6ww3riDYiI758Io37B
 7PnKnJI2K98g6NqAEkzeW6GV80wPr8Tp5C2Wi5Dah4vncRiX0JLm4kkCPleXZt4fIHH95Zieod6
 6r4q2KF8b1eJ0FMFIminUvXRE9ht0RK0u+VYApxKYvWWA==
X-Received: by 2002:a05:6000:4283:b0:43c:fdd:ea96 with SMTP id
 ffacd0b85a97d-4515cf125b0mr11023225f8f.26.1778138996094; 
 Thu, 07 May 2026 00:29:56 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4505238e6e0sm17936674f8f.6.2026.05.07.00.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 00:29:55 -0700 (PDT)
Message-ID: <69fc3f73.050a0220.3c8a7b.8474@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260507072238.102543-2-piotr.kubaj@intel.com>
Date: Thu, 07 May 2026 07:29:54 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12] high_freq_hwp_cap_cppc.c: new test
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

did you read v10? None of the requests was achieved by the
next versions.

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
