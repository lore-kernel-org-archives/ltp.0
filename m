Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCCEC5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749127169; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=uTfXBOV0kU98LedbHTFu6yz44DIUTLcTY2JSZqfh45A=;
 b=SfLhp3GtH2ufKwHOZGyKEMtdwTAKQ//K6tGuH8n/Sfi9Ilc7lQi7xYus7dNKEIN4JpBrN
 lvDljYngtJoLHcGtXGXFa71wOLledGOga/IVhkOnIvrJgtnqCxt4+h4OuF0ZZaxjT0BxjCH
 nhB0u97sZ1YlEKqZgZletI4rT4gwSBg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36F153CA3BF
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 14:39:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D64E03CA11B
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:39:07 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 73480600D32
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:39:06 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so8983175e9.3
 for <ltp@lists.linux.it>; Thu, 05 Jun 2025 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749127146; x=1749731946; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZFSvuGMX+KyIIhcb83F0wQiNrfaVDiDvNRX9TpX3Lk=;
 b=BiMAsYu1wx9iarB+GU7Sal9GVb/qFQkn2OFAVJFOiuDj/Y7fpx7q7ikUKt92Sr+a1d
 HZYBTcpoDkWq2ieLVwG+oJAedMrT5qeRfCdMXjlaPqsQPtWxBe51IcyN41+A3oo6xFbU
 FXLgVNsO3dJZQdWRlRmOI1od8dczbgvOHtdmY48lQK6lj54DkcVApppPIoBkXvDQePtT
 zCXCmLGeA04oivfyOUH4AK3uhmobJZh0E/BBQdBuUtPXJokEaWAxVg1UW2l6NanKcPfl
 kX/EYuD0M3kEkLotUFQEgxe7eS7zWv5lSxEzLBgu6xa15DD0yOqNptTFXB8Fk3Ywpkgh
 wTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749127146; x=1749731946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZFSvuGMX+KyIIhcb83F0wQiNrfaVDiDvNRX9TpX3Lk=;
 b=WaTVTC6nVvasG61Ga/SPSh3ZQMBKDgafvyj9LwQjadHoibOFeQyzIyFtzvwt39wo2X
 ZtS/1rvieEDrYYjfsVvcHsaxkneRyGESsGe60EF4X6iVOxpfBvzmDJaPEHR4qWzlTyfr
 maUoA1cQwcMl92PeTLFqvv/wwCnqreXZ7ABMIEeFVWkg6IuN+FqbhQ8lPteB7AJEzJyL
 8PzCsxJ7A6RF3aO0RxYQLVZZE/fawTgKxVFPKE3emQ7R1nSNmXAxsrmE8mx3zg3z9p4Z
 8zvbZW1onbKdyucGHgq3wBHB7Bg3r7g6cbzYWKakenvH4ShcmL4VAsUk65WqQzvaVQDW
 ZE0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9y3ISkmi/ktes9lmnd8B47xm3j12rgOMndCSBkaBFbYOTohyVzs0wHSVq9ISsHxXL9Cc=@lists.linux.it
X-Gm-Message-State: AOJu0YzQtmMCxmjsgGUTuoRMNmSc+pQdqSnjGo4UTjbqfkeT0fQ8rs4W
 4rqNYISE4iiFB5g5lsZxf9q5a45nzbYn6+4nlElo429GLSckAWVUjwHsndl3024Hcdk=
X-Gm-Gg: ASbGnctLFGgyLnDsV2GVphg7ie7a6e9i/ln5NsW+JwRTwEP5u5SJ3LP60LoiPgrtark
 9paV3tnRn0zvcqTQSwyvCBBjTJ4OOuiq2oqYGmKPEuw3WEXNOF3nCtbogCvlFsn3cOR2ISLfKru
 ysWrmqZUavPdk6ErCRv/kv1O/4N7eAiCBzrysSJh/IQ2nvXj6jeuuuySnVZdB21peR9s8tWjyPQ
 A5p/BXOl/Im3NrI6mhECL4DU1aGsDsseMztsnVg6uMsksbcT8fQQpUs8B2LKuwTlZlkzebEb0Bu
 FE2iewlu88s6abABEm58djs0LYJe+moOqZf7Dr8VJupGknUKrdOHOz2+uTpIUxkYgxwQqBB0xPm
 gdpkCD0zcpwkTaq2AhEZrj18Cz/ELHkU5wmeigIH3zRkGIVAlLtAfjNliQi/PVoLQ8ion80+Jux
 ClO2BuUl2lscsfyg==
X-Google-Smtp-Source: AGHT+IH582sVhNm4ogEoToJxGm9ALxkeVtULnr2Dzfl/knzdwT3L+88bSDOjGNLGNYaqLT7VVJEQUg==
X-Received: by 2002:a05:6000:4007:b0:3a4:dbac:2dc1 with SMTP id
 ffacd0b85a97d-3a51d985ba9mr5853509f8f.54.1749127145801; 
 Thu, 05 Jun 2025 05:39:05 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f18:9700:bff9:d9af:e929:c0c4?
 (p200300ef2f189700bff9d9afe929c0c4.dip0.t-ipconnect.de.
 [2003:ef:2f18:9700:bff9:d9af:e929:c0c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506d14abdsm119103865ad.239.2025.06.05.05.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 05:39:05 -0700 (PDT)
Message-ID: <059015cb-e453-4552-9f98-dba1e4ed697a@suse.com>
Date: Thu, 5 Jun 2025 14:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
Content-Language: en-US
In-Reply-To: <20250527-landlock_unix_socket-v4-0-80d3d579094b@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/4] Landlock tests for ABI v6
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
