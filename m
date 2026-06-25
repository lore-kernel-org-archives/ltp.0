Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C43ECDB479
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 13:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782393262; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hZXdKYG9Wkae1bi3Hdb5jHyPzYaxxgzZmhpg3Oihoz8=;
 b=YO4oHU3XABeHC3LohjzmB5YXIGKEL+wxS4x6yd/ev5wXHygD6FXYGEbeZBKcDsWgCqiRB
 3ZEhc+eKbx08GV7TmVDu+PGNj/DCqzVtVAoBO9RyLf9rp18wXWqA1NLmdLAOiy9CPvwbAS7
 nnBBM+KvCyrfOYbVmoYMfRBFEr1acGU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F32D73E1459
	for <ltp@archiver.kernel.org>; Thu, 25 Jun 2026 15:14:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E14183C5AED
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 15:14:02 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 47B90600850
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 15:14:02 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4924f8db066so12862905e9.2
 for <ltp@lists.linux.it>; Thu, 25 Jun 2026 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782393242; x=1782998042; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=h2D+WpcbqtiP4op44mU/RwU3jH21tzHNcrNNYH539dw=;
 b=G69eQNlVk52Gh2c5myt0/DcPac+3ah5Qtrq6UZA//4E3rdLyEhQ980GmmfQNA1XBhx
 u27gX/6sBtuyAKMbz+3uKQ4Sd+BjQLypwBwhoY7BLjU8PZfyTMOZvGKqLU6Grri9ChH6
 ELXpyCHtn+RhJKwKe/OkQPMlZ/oDai0uzo9irovFBeTtEYZ2VMjuFj/vn3Y1yNnnYd5T
 5KqxBG/MGgzMvplVrobx1mAx9LtsY+UEKaBIqwvsNuarnGzzajcw7rFf4uxSq4CyN5YG
 i0r6HI78uFX2XawI1TqhLNwE64DlDHLC+VIvSbKXTNJsniadSSIYVUQ3Nec5FkIWOTor
 ObTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782393242; x=1782998042;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2D+WpcbqtiP4op44mU/RwU3jH21tzHNcrNNYH539dw=;
 b=rwlNRy3KuanaQaqQXWcKsdpNiq9Lbot2hLYRHyG1lsdeOKgfP6yjEV91gmSxuviCYG
 e5B+8T5bYOb5elMKMTnW/rWrhN+t8oPlzBHvIRyuaSKQF+H7XXKngfmPXqkduubq+S3v
 GjeasmrsRgZoE+pDhm4MOYMjcer1hh4Q4YEqmEhV6iFjJ+7Q2Bv0INJGl20BpYkrvxMX
 qk5tzAy+H8CS4zLmldSvwD80LxUIlhnFFMj0qH5yIIWBeGtA8Qe1Nz+tzuxPO9L78gUx
 R58tQzLrx/O1lCWV6pjDn037RIwfj5EkDUbq5xaXtNI/nbAM+WHul6n3vqU9ldX9t/5b
 K9yA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dgiGIdD/uvTwkqcrHTvftvXaEHqRIoJllXYXGHVq0PKAlcGtuU/bH6dz/KCn1pbc8SdU=@lists.linux.it
X-Gm-Message-State: AOJu0Yy3YUddPGPZOO0S54l0rsA4/WTGOskgdBERLIAQBgAAX7rhowRH
 VFfRPSsmPQxJIch4xa9HtDPEo/0oM7dh8dR291ACGbuj8rR0cug88BqzuRcYoAfOynSHOeICW5Z
 jeV/xeNGqDA==
X-Gm-Gg: AfdE7cn+JHBunzYVwki7eS9SoMlBuOWhcUUqIa8Ue2/77I2rUjSzCY9ycm6wmKpzK4p
 FX7tMeFpWd/JfZdvqI40BOPJtIJjM2iaR1UD4J/SoYizekWeSUyVvCLZWjpw9iHHZWWOR7wRe7C
 0Y8Hrn1iK/AaunF1wMvjt6mer/LH9TSy6wDfIMq25U4mrt95BN1xzLbJ+PPI3JnsRpoPebHr7p+
 6ANqPE+k3lvu2fjUNGvsZcAsS2r58xD/Gx9fVtH/reEbSB6BUwq20jBI+zERor62cN5wCPDTK4d
 yiO9WxbJqatS8YxtxJ42UGY7NRbq0Lp1XCHqiKofw+2tjCP3Moh4pdiUh/fLuLAevZ5MD80q7jy
 9SgC9KrpcwsMxwGkL53JbqPhJ8bWWJnEZ+4iHCRw7dLMIAyJbK+21HxqrjDs97vYdReueFEJAD0
 WjhaJO0cPLYZ3nZhDVNZCZliup5bDUEirp+rftlhyP1VRbIC832BMTNZ6kxIoEWQ==
X-Received: by 2002:a05:600c:3b89:b0:492:4363:e7d6 with SMTP id
 5b1f17b1804b1-492668bac34mr29738505e9.37.1782393241492; 
 Thu, 25 Jun 2026 06:14:01 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49264184210sm82764405e9.15.2026.06.25.06.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:14:01 -0700 (PDT)
Message-ID: <6a3d2999.6161eb1e.16fd01.bf6a@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aj0GFfssb2dRhBSm@yuki.lan>
Date: Thu, 25 Jun 2026 13:13:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] metadata: add linter for JSON file
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

> Can we also error on invalid groups?
> 
> Invalid group would be anything that is not in the expected groups or in
> a hand written list of groups (which will be added later and maintained
> by hand as needed).

I would decide now a set of bare minimal ones:

- memory
- syscalls
- stress
- cve
- aio
- io
- ..

others?

But I'm not sure about it. This will be extremely strict when we want
to select only specific syscalls. For instance, if we want to execute
only tests which are triggering a specific syscall (i.e. mmap only
tests).

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
