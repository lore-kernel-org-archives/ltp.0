Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FD1C982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 22:25:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 767013EABB9
	for <ltp@archiver.kernel.org>; Sat, 19 Sep 2026 00:25:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F5973C7277
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 00:25:17 +0200 (CEST)
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B3B391401203
 for <ltp@lists.linux.it>; Sat, 19 Sep 2026 00:25:16 +0200 (CEST)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4ab2d72ff13so447902b6e.0
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789770315; x=1790375115; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8c5oRvG6yNa3gZJspY7G7NY1b6UkFVIL1lSPh9jHmhc=;
 b=N3G606gMisxcsh7PnRhrkz+WKDKMkUUx3eJr+KNB3wu4dz7D5Epp7Ekag3uzw59ygd
 8afwNYTEM47O1dJsmzWuctGI2JgtzapokhEREbkFxytxcKKZkhJbQRiohnY1oiC73iTj
 4OXiF4kURIACP8ZJFXtV3Ht2K1a14CgwOhRKiU5QmD5S8hSWTldSr8cZErrQy8k//Ao0
 v7oUe6Ii11Ypz5fpjBxoyP/vf97KJu73okULDhU7EYKOq7qiFNiqs1alPtkhQZmiGgtl
 gc7IICAD3y3WzI1GWpqk5kvP6kFYWHZOd5DwlqW5msspVQ6kvh3tmJw3PjQdbHJQK6oJ
 5PDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789770315; x=1790375115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8c5oRvG6yNa3gZJspY7G7NY1b6UkFVIL1lSPh9jHmhc=;
 b=Za/YbVnqg4yw3sNsIYz1l8m0G2r/egALd5KRvWgHZALmcVfh0MgDYYmi/GbANLNlBg
 v0U01Zv3TpdpKXWhVq+d8h0vpatnTlKLXmh6Fd2F5yb7DvL7gbrl2vVBjtD0Kb/zX84f
 DyzhZSlhu1PmW2HZ9DrqlzJGvDZyjmuUSEzBAEHJSWosfJ54XQQF8jqu32psTSkmjKb8
 04t0N/70Q80gYsvfKiX/hRuKGL96CyLSmVrLmykeWP1tB8AoRq3lTy5WINxvJPUeH06g
 nTIAbRl4UtcthnX9ZYJHwOqBDaJUGvK+3Bh7UigdcEfL0Xo6mEB0UR64KXcyfpYIGnQ2
 /4Tw==
X-Gm-Message-State: AFuF++n1J3fonXEgOZ6x/XuNeBixafldWdQ6PPDrvVF3aQhWCBUYoN/6
 ZXrEbxqfYmFo9/9d7N/LtL578hVxIQ+bHo6iXvTeH9nfbWSZPhUGfTU1
X-Gm-Gg: AYBFou2LRzRrMpB/mvzJzvWGv7RtKG/JJ9YeqVYW1VoEsKZbNra/xK9MnEwg9h9gaO2
 +tMq5XCl6prKi1A4ZsqcloV08XrtR8YhcH+ztqmmi/88ZqIT7ivMQJZoKiqeA8n1AEg6kpkmlfu
 zYdrLACOon+Y8YCs8+SIzZ2j1C5rhNHPnZ2ySgGa2NcR2iNfNkfSno+DzfQrcI4iJ5irYpsYB9k
 VxaLlBmE5HEHQxAFd4FPcmCLxm9NgSWMwxe/l2FVLNqzydoBj1t4MLpmtARaBXbhYeFXIT+3pS7
 NnQ7CS+bE2AHar12oTYQETtgCNvDVfUjmAspXZiH0sU/IjLrqb8aU5s5gFbKWt2QtFQqMHs6/Ea
 UhuYIO7CoycXfhw+b3Cz/tbKbKjgDuceXYgYDz0TeECbDibSe4mqGtEbI1T6gtRzVyHdy9UowfT
 UgHOZNBQWY47RMhSMkq6zX764fssbGofku3/tky2RMl3AWEHBAgNIvCLm0mAGTVKv5nj9JU9lDP
 hOVqaQZvPt8r3/8LbBapP4ebJmebOA+l+/H+3JtNnkh+mJt4gopn405pYX+P4lZSjmos0mmfW5G
 hMhm+4Nvyfw=
X-Received: by 2002:a05:6808:2f13:b0:4b9:e65b:8c2e with SMTP id
 5614622812f47-4ccf79cbaeamr4855396b6e.28.1789770315140; 
 Fri, 18 Sep 2026 15:25:15 -0700 (PDT)
Received: from
 runnervmlun5p.xnlx33ok0m1enei2y4o3hlrmgg.gx.internal.cloudapp.net
 ([20.46.239.216]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cf3f7675besm533044b6e.16.2026.09.18.15.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:25:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Fri, 18 Sep 2026 22:25:13 +0000
Message-ID: <20260918222513.8977-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918194316.109853-1-avinesh.kumar@suse.com>
References: <20260918194316.109853-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: Skip pipe core_pattern under SELinux enforcing
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

On Fri, 18 Sep 2026 21:43:08 +0200, Avinesh Kumar wrote:
> coredump01: Skip pipe core_pattern under SELinux enforcing

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
