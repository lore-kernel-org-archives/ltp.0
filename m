Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D598CF6C17
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 09:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767776947; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AvWfggWsPcnmJ+xZtZZG1LUztzUw0E7R+njXHb+Nu6E=;
 b=isjhufmZcsxlkSwrhmMEVTJT0Z20UYt2ODTiaEW27RcFI8b77OmDWmkMdwOCOprehkfq5
 BYEqu9ZRFYokqL7j2hi5GYIkq10HlJJx2c3VlPDWjDoH6nf3qDtc3V5lnEe4OtFIa6PYs9y
 IzBwQG/d8HqJjs5aDr8Zsb6xOCpAITY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCB323C30BC
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 10:09:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DE453C2E5D
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:08:45 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 585F91A00152
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:08:44 +0100 (CET)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so342584266b.2
 for <ltp@lists.linux.it>; Wed, 07 Jan 2026 01:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767776924; x=1768381724; darn=lists.linux.it;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+hoFh5gT7f0lb8+7rrI6rKGjjNKHnKyYNdYxZAFGXiQ=;
 b=XxYmZVhqla5XHECkXjtpTBouVXS7MsPQ70x3LNkmC4xaxtNNTlaoVk/9HHX3/ORE0a
 sX1Mubma8KCVYEIdKEEq5/5AHeiYMCns2VlBd1Vj2USMOWSIlhh9Si+CmCx0uDV0Jz1/
 ChHNHt0+/YYZSJkDxeqUxANqqiqO9e57FMZx38BkaZNm3E8+D6BedltMK7K/PrI960/B
 9XG6AAh3lgWYezPa5/3rFKb2KQp7QzKqh9l8N9zr/Ubv8Omywad0EHU9wr2fWPlshbTr
 9gzqShNACy0JQUG3qlBpQVXDK5Rgg4fPbxJPzHxeoGi14/hqdWi+90Cej3B33BWnS8OE
 5D4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767776924; x=1768381724;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+hoFh5gT7f0lb8+7rrI6rKGjjNKHnKyYNdYxZAFGXiQ=;
 b=XA9+Ygt/HNKEKpUOdpXmDjDiW8/fMZbxj+4/ap68SModNVl6wkLbaDFA1H8B2VBuqB
 zTEwkmOXG0viJbmD7jUW/YuILA+esWsKeCo/Hx3vqmBn6mXIJ+3khlbGeDv57fozQnkm
 Oq1I1J60+ydY0g8FxpJO0wCbBFBS/5F6bvlyfqxUJ7un39bGzEs5DrkOjKuwp41rKfyQ
 R3rrw/3exJ/b6JXjNkQ7f9O2EY7tHLLZ0HaYjkbryfwGt2iZPr//N2dcy25s5Bu1fqYx
 U8z4SqY7In6JpHbxCTA2PHu1z/OmMzatG5pWLn7mopHvsZEbBJyv+sc/tHuLZw9aZgwf
 eRxw==
X-Gm-Message-State: AOJu0YxsF8i5S8jMj8o77LqveaiuqS5+SYN8c3SfuYw9XyNGqDO5QSvt
 x02Mk4Ua89C+llukPxxDexa3RsQBlvsFZuw9jhB5tj3M7gwj04QTf5Etl+il30iEXk8=
X-Gm-Gg: AY/fxX5xXyTXzcKlhfQIWDfw3LLg1B9WutksOaGlxpSS3qvsnR+I7MOxJlCoBOmxxxF
 zcxTGmuRjiTdJJ6gBPRILzpT7LrPD5dxoD+6aPuro26MSWcFfopp3IRfzYZpTp6qqGYGtr0K//I
 Z13ZRVtGA6444Fsm9AK/4k5vHVfVZAIhMD5QpW9cjd5Jt1rzzvH+YjS9oxHUMoWdqt4EAy0Dkav
 2YYf2X3jWUPJLRZOXp/YIKijMAVUyj7myfSWh4L8ETYFGKNiXTDYB89CLChTi7zUxE4KzFEgEKn
 G3ykSLjelLLS0nYoh9rlhtFtn4ar4frue3q8zaIgeig7Dx9n6KBosUZrrlD9bLucl808nHlPFSV
 hHQ0XSKPKJxhCb/8Zrbfnmdfy/tMIQAE8kMwCBI2DV8eReh3qkZCKS+1HLRHi3kMO90iBTzz/JJ
 hpfOWthssOtxWDOUfxFgsjNmOOo0hytJAwFcpt1px6IrYZUP/A6VPGS82rxpY76D0OEVsR/bXCX
 5NbaX6q4jgAIG8ddA==
X-Google-Smtp-Source: AGHT+IEbaNltz0kSJSsNhoAbfKCL+Z/4+VcUiXBZFNy2ZYV9LfJKoIPAwYnfwIALWbhhjE5ybSSh0A==
X-Received: by 2002:a17:907:1b02:b0:b76:f57f:a2c3 with SMTP id
 a640c23a62f3a-b84451ef354mr184860066b.12.1767776923661; 
 Wed, 07 Jan 2026 01:08:43 -0800 (PST)
Received: from localhost
 (p200300ef2f19f800fd6433c69db8d45a.dip0.t-ipconnect.de.
 [2003:ef:2f19:f800:fd64:33c6:9db8:d45a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a563f73sm472595566b.61.2026.01.07.01.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 01:08:43 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 07 Jan 2026 10:08:43 +0100
Message-Id: <DFI8MB7MSSLA.2PKHPF5GPVR63@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>
X-Mailer: aerc 0.18.2
References: <20251222094428.87910-1-pvorel@suse.cz>
 <DFGGXHDQ8OSM.36FM2U880AQKZ@suse.com> <20260105074908.GA589722@pevik>
 <DFHHL0ST0J9B.VIZCKRYAK2TN@suse.com> <20260107075354.GB727950@pevik>
In-Reply-To: <20260107075354.GB727950@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] swapon03: Try to swapon() as many files until
 it fails
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

> FYI merged with just added FILENAME_MAX+28 in the commit message to be more
> obvious.  With recent gcc we can have many fixes like this, I'm not sure if we
> want to comment every -Wformat-truncation in the source code.

This can be challenging yes. Let me know if you need a help.

>
> Thanks to all for a review.
> I'll plan to do the rest of the test cleanup as we agreed.
>
> Kind regards,
> Petr


Thanks,

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
