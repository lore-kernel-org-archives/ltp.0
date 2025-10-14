Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF53CCD184
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760428559; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CX5SLSZPe2gARmVcsx3I41SK76G2NSgyR1BWwxnIDlQ=;
 b=q4DGv9P0tSZwcLLEXz/Wa34fKn8eVsuGKfaIKNfMkU3qoa+RiediSfOnM7m8Kc8L7h8rV
 UwMDv9DGsJ+5P6HBLtAGh5GahicjGd33CB/M6DIGZJrvB64nUwmgRS+zq8o2v0pWXhSMAlo
 QXHQnwR8j524V4I714/kRvHVtkz4bVU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C29B3CEC40
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 09:55:59 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 598403C2B90
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 09:55:38 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4E0A61A006E9
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 09:55:37 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b07d4d24d09so316368366b.2
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 00:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760428537; x=1761033337; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=urmUYe+IYp1QxTv6F0tLw1zIWAGxs9qTyXYh4xcGIo8=;
 b=BgxFIOEy6/RoXbEx7CA0ycLNRv07hW7P30OLYB6o62Zje6dV2iH2DIthE7RvYVCTM8
 0jPm2Gqu1wB6gJfrNRZ1LSJURT8Kylx0EgSERUdTixI4pQ9xa2skEW6rkqaFxWYkbPcw
 OZhAkxFNzpOg3Ag65AqM/9ebjFxwGS17+C74vO1oNFTiBJEfL4+mYEpPzANz8sdnZtrS
 t3iSK8+TSDQYNzvdMRMB+nyUSIiCohk1l7Y6yxkS3O+IGtb75MzUYhpu9Ln4ktsDvr5p
 qbHC7yxGnWzKNfsXrBUv1VF42B7qhp+e8OMpBIrYpluAahkVuj0Yx14nIu9MoAD8iCIh
 yLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760428537; x=1761033337;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=urmUYe+IYp1QxTv6F0tLw1zIWAGxs9qTyXYh4xcGIo8=;
 b=ZloO8lvyP4nySY5ivtZ2QklQ50DephTFfx/LoalnbO4DfIrTX+SOhbimttjtqhh8SJ
 XQAj0nG0hMJuWSb0QlnBrbdL9Vhz85tVk2tdaZlKDKQgkwR7/bSke33F7ZZR4xbyTsmO
 UUj1AT9ZJz0tbkqiI6l9N8sV0DCaIuhnSDSDKxk/HisgyiCWyc8f2PP0RqiBoPh7PLxW
 4uyaSQjMxjicDEPyYgCGvvDFuwOri6zHvGHQ2X5bpex97YiCwrvgE7+dKExk3qjHNxb4
 wyZ948Sl1kyxzpFlwD0/oq00j5vNe0BJVpn1kNWK7h5p//97FGgkWedp9c54j1NeaEN1
 jCoA==
X-Gm-Message-State: AOJu0YwGZEvKq4/xPvPbpqMOFuyhWw7fEm0GBbksNF/dCMlb1cwpRGdP
 BwDkKzLUKnCd0k2rbMiispaIbceqm6cpM0v8A4Xhl8yi5zQIF5smuac+t2fPSG8sq1Y=
X-Gm-Gg: ASbGncsdNbBB88SNtYSfokp6znKQxfHgFVPCRFfzS332GaTkvhp0O1+CjiC71cirVD9
 BNTGITSMo0KPzun07YnoypqEB+GTP9lvnrua82uDfaCE93Lu4i3x6ZxTpd5wiuyvmPQFsGRBgI8
 lh/V1pnIGN5wWdIxH3VfB55bYs4Zwy2VZWo429lJ54qJAE0jEENavqJ7JVxJdaIajOlefY3DfEd
 6Yicv84qnIw62seViYoWuQlFel6ecWTZNUq9dCAdEOEfsqjnYVtlnGQp/x3l4sMEk0zh72z1nOi
 j0Laq5dR4dMbAbjHczGpsdi1kBs2+2U0ARBcKIdJgdygd4bTM6mq3i68vRC8ThkG/cEnHzH083V
 RM/Y2GnZ5JxLZOVlQzM5yRGStotNzMbpDjmrS2YmEWNr7KbIx1PrBUzALMW1LAcflFSfZxPeHgO
 bAYIzw36+Z+ORArrbKV00lHHWiCB2Y+geGa7NinLXHhl3E
X-Google-Smtp-Source: AGHT+IGSzjWnaM95ftrtZEppzRUBVjTKM3O/VbmZcxY7VuqADklsEFv/chIVzq7kz7xJFM6XnYVVng==
X-Received: by 2002:a17:907:94c6:b0:b45:913d:f523 with SMTP id
 a640c23a62f3a-b50aa99edc9mr2576981066b.18.1760428536592; 
 Tue, 14 Oct 2025 00:55:36 -0700 (PDT)
Received: from localhost
 (p200300ef2f1c890086c8658517a2433a.dip0.t-ipconnect.de.
 [2003:ef:2f1c:8900:86c8:6585:17a2:433a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12ce1sm1090153466b.57.2025.10.14.00.55.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 00:55:36 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 14 Oct 2025 09:55:35 +0200
Message-Id: <DDHVU0PEAOVX.1M1RA5HB531B8@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.21.0
References: <20251010-file_attr_eopnotsupp-v1-1-a93df1980ac7@suse.com>
 <aO0QiVqDqgxhU6rE@yuki.lan>
In-Reply-To: <aO0QiVqDqgxhU6rE@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: add file_attr05 test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>
> Isn't this wrong?
>
> See:
>
> commit f4af1fb44161d719695c3ce1bcad61d6f3638ba8
> Author: Martin Doucha <mdoucha@suse.cz>
> Date:   Tue Sep 23 17:32:24 2025 +0200
>
>     file_attr02: Enable reflinks and fix blocksize detection

Yes, im gonna send v2


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
