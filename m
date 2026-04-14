Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8779ED7B82
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 08:37:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8265D3E2185
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 10:37:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBCF13C6EE3
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 10:37:02 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F302600743
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 10:37:02 +0200 (CEST)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-8a049a767c3so49488946d6.1
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 01:37:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776155821; cv=none;
 d=google.com; s=arc-20240605;
 b=k64vL4FMVXlbpJ4lLL3Z9ayqBp4uY0p07Xe4cxVZ3FDN4TG2naJ+LrehR+Okkxtwan
 fthzuOAgBfjFFITKCWloBYi9oo0NtYMR9MQpEqdcieJUsXS1Hagv7S3Di5DFjejhPQXe
 0gGEDHHUOyJs6J9gcpJM4lcVB4DAvyzeq7bDL5KNxYEXoc0JoNwvyiQtAB5Dbay5Kwe2
 as1+wMVTTtW0BnwH0921DYD3qIgTnoBCD87J7mFQ4yV6S4toKP6mHFU5g3cpSvp7r2P5
 5LOw+smz9JdQYzByUx6gzUTglSVulV5jJZf+UmKMUT2uJ3eU7sGy3qLzJEAj6aQuB/Fx
 Hgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rA6b+XWkCIfnvhkG9gQDnp6zr50UA+qazsG867VESRI=;
 fh=Q3HcMqzsMHxLWjwvmRLIQOf1pJe3Pqj7A2dMy5TaL1I=;
 b=bYbqWopsDjfnaXmkF3iEgyTyVxg70Td78+H2ZmOxylWHEIdIjih/bwohUqOqQHNHva
 2be7PeIoxS+Ex+fodPJxa1JsFtOzWxytktIpFbYZ81NoZrN9RpbSHlMgoAVXSmMa0viH
 1zNkDZFPiLLE3YkPLBqnLJRjokaq8yF91NnQUnoE/J8H/go8eJ+gCZBydjJmyhlEoK7x
 t50VFCQlUWAWl2k5DUHl+BMyaWgOxDFCdj05MkdNy2HRhQY6hotEub5Fb92PIIRlIgi1
 RKkoykLYpLR7qeitn/F22zkKgLRSR2SiswYwMRWASbg9Mrfrt53daMxA/IJI69vDdKxY
 XiMA==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776155821; x=1776760621; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rA6b+XWkCIfnvhkG9gQDnp6zr50UA+qazsG867VESRI=;
 b=C+UFDghGhmNMYXfVIDxLmRCo5eCcotyYuxRdSAC1H+0fg1xQZFBekwGTT+N4+euGHn
 Rojqci6LnjqanH5thzCDKLCEmvLsALY8NP1xJ3cmpurwiqOPAltzbCFCEKG+IXl25ZYu
 bZLKe1vVrVsUNN5BiyJH0K/KCK4Ia3nOqJOoxw8rTyRrC/bk4i42lFj1X8ZeKhEC2wOI
 2H8pYvC9T6Y3H+rGoHUTljcyMfOOXSJ2wvZR5xHOJrj8ELR2wTYFDL+7CFpOl/bLI+FF
 1iBMtz0NfPaFHj/v8LWxAuC4AvO5rn9nwDTrfonz3s18oruVvmXjspXYByQlB1FzMr9+
 GVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155821; x=1776760621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA6b+XWkCIfnvhkG9gQDnp6zr50UA+qazsG867VESRI=;
 b=Q9+HZ0l7l58NqrF6j4TV4LfREnnP/UXkgGbBxn++vI5zN7b8vIR6tmNld/VLrQLjHh
 p8vImh/hOyViZDTwW9kvaqwXLCu1IJDGowoMwudWRzYGuXhmODMfFYUv3RWaLDWVH07K
 M9RC/Fh5s52pJyurPBn01lvS8hFdPoOdkjF5H9MvDGG2/3yPAc7DsUXl3TPRLeWjuAuE
 OmFJNDTJowjKW+a1bJyB3wENs9q8gGzW15rXH/6ZIACyt8/6QxUushF8dEVTP34UoXuC
 jxHZpRgbJo4AgzSEmfD9LFcUDvu8y34fAxHYimNgtDIJYS4fw73HkIYDiBX546+iBtf6
 0HuA==
X-Gm-Message-State: AOJu0Yz7SJX9UvE4OdP/l0XDRXWHgcQ/GD03oHUPWYAi2Utnh1yEZN5z
 7tI4ir5hvUbn5aUBegr1LnJDJC7ULYEsfGX2qfC/Gx/MzE1Gyjwusk518Q5l8rue4nTsydaICmE
 1F9bqaleKohhfSA2l93eeKjv296BJjA==
X-Gm-Gg: AeBDiet/gXBbqOBVTCyZ9AK5fdn8vm7QfER4+QEqbkomOgTCkK9qbh0Oe603tBsDuWh
 LQdwETcIPCzWwmCxXF+Ce0GVkUwHkqOjDsgzjLAacb23HTbyJHB4/mtig4MTmATN7RqCMd3+60I
 7DnFEQ8k0BNRZzdONJLbHJ6lmUYwiOst7uZ6ldEZTAoYdYyFb4dSZm0265zIVlKEaOsH5l+/Fse
 S5HmCJUk0lU5tyPgRQO9kdPUg8j3HmHi5GISG7OT7pM3XgUKfJbYp+l7idZgjGxY3TQFHQIvLOq
 a7CYzA==
X-Received: by 2002:a05:6214:33c8:b0:89c:869e:4972 with SMTP id
 6a1803df08f44-8ac7457263cmr309866286d6.10.1776155821114; Tue, 14 Apr 2026
 01:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <69dce7cd.050a0220.18678b.446a@mx.google.com>
In-Reply-To: <69dce7cd.050a0220.18678b.446a@mx.google.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Tue, 14 Apr 2026 16:36:49 +0800
X-Gm-Features: AQROBzD7wp_hAcf1nJgBYfUn2_uRjw0wcGHd9OH353B_pJ7jixG0C6U24mzavSU
Message-ID: <CANgNiRz+BdnL-yYw3BqcKo+o2tSmPEV-wiaCftxse8rqEA+3fw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] AI review agent
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
Cc: LTP Mailing List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Thanks for the nice AI review tool.
I noticed that each automated AI review email starts with the
following disclaimer:

> Our agent completed the review of the patch.
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

From my view, it consumes a little bit of energy to read or scroll
past this note at the beginning of every email.

Maybe we could just put it at the bottom of the email as a note?

For example:

[... AI Patch Review ...]

Note: Our agent completed the review of this patch. The agent can sometimes
produce false positives, although often its findings are genuine. If
you find issues
with the review, please reply to this email or ignore the suggestions.


I think this would make the automated emails much easier to read at a glance.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
