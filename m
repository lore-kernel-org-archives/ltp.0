Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA721CD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 12:27:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354013E2A9D
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 14:27:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51FA53E1CF6
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:27:26 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 225F41400C70
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 14:27:26 +0200 (CEST)
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8ccf887de87so10467036d6.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781267245; x=1781872045; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPNkqSob3bHmWatJhnFGyG1LfU/BkJdHFb/ejxiDGiI=;
 b=JsUwRXdQ9n4Kym0bm04g0guI1BPMv+HsP9/D9YRjF9/+jGM/WBRt1j2E8OH9OmwyOS
 z5h8mTvZYcVThVxpAEhObbKYjyDOGRw81a0akAg+AOhq/UYiZS8bvVPeentGjhrFjHBU
 0qHPBTrGBK9tKw4mm/naCjI5BFVZsd+wenZmLilrvjygtpJUcu3bQ7l/SwzpVh3pBwe6
 wvNIk9cVGn2v8SYDykyUr9Siym1zEz0ncdbfA7GYbM3WohMmMZIo2OiZZokgnh3pl7Fd
 u4VSVBn19xOXqGpFbatNQKMar+qnHic4CwOJqupmEZSIZzV/sk9qhQA49zPVEISX7vtz
 kE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781267245; x=1781872045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vPNkqSob3bHmWatJhnFGyG1LfU/BkJdHFb/ejxiDGiI=;
 b=jM7m3cusu8ae/N5GFekVao6OrbSZ1h7MnJKOTOdnIco8moAs0Sg1ITqn3867MCtfvI
 u0hW/zgLxsSIZ3YO6lFFI/z3EmFuvNUPEIWHckS4EyKplxuMnrxAum8P2sxZ2b7E5Ajq
 v6CJYaAuoNfHG7MevZX/D2CMQEjQlmP72p9GB1/itw2Yp0FK2F7uClN3g/r0m91aiYbM
 IrZAY/t3iY1KCQ5XhGz2lmbZNoCL9Ou+JdzLB0j6Z9eKF+NMGxJ9SJIqNq6JcBgD0ujs
 PtNys0G18eegKms62f0FX3z+tVs033NQg0SfWRgXfZPi5t0cGo46hIyxPw+I+nt8pX1f
 MqOg==
X-Gm-Message-State: AOJu0Yx2cMVEoHP9bA2nu1/IctzIia38xA1olWht3qA1+BU0cHGh0fbn
 a0PLFBTb6VLWMYnrJcRk7FJFtT8C0GAR/wrQBbEGufqtdmLbek172AJ2
X-Gm-Gg: Acq92OGymojTit+8Y0UUI+S7dnR+GIGUtrhtOZlcGChW0SkHFqU6Rw8Eh/QysHt8+Fb
 fVykVPgHxMWop4VxYjiCO7Db4nzucMmYLwXCpntfZLbGnFm2BvwdEHcl5V9VjRgHd1jNAX7ppO8
 +p/WHb0GfZs0g6pLMHrJAFy535T5dMlQ4Eb2eDBR3eqGMEjKDJ1BJ9gRFGY+bkbQuUMb9PSEOr3
 KzsqC2yTNdarRSVj7P4vMKrJlciKrPoSQjWYs9GhixE4q2MGUVbD1WTzvFwOmEAkU1N3i18vcr2
 WPoE2viviHMmUhE8kaHSmRtWgQ6NZaXIlvI1qRLBbbQC+n06IWiDTuGR7Q8V3qqebe1hWWi7W8B
 6Ov5oGWuGK4Tn4BVui4lz7EU7fFkLq1uaoYKo7m+/caWSRIeopMJWVYKK5aQYArkyqkOEhe4VDF
 Kr6FiK/9XvTNz1KWValQQvOTzsyffy+z3H0raMzLIoPObz4TLKaC+ZHN5GuIp7nWT4NU0hg2kvU
 p2e5qInGUDhPm/iYncvV+Qgg+97FynLU1otxKOihSZiURdB7/w=
X-Received: by 2002:a05:6214:469e:b0:8b5:e126:e77d with SMTP id
 6a1803df08f44-8d32bb3c950mr43778386d6.8.1781267244730; 
 Fri, 12 Jun 2026 05:27:24 -0700 (PDT)
Received: from
 runnervm1li68.fwbxogqxw2hu1gnhcu514ce0ub.bx.internal.cloudapp.net
 ([52.188.198.104]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d301b271e7sm21867806d6.14.2026.06.12.05.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 05:27:24 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 12:27:23 +0000
Message-ID: <20260612122723.4102-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612-doc_add_missing_headers-v8-1-a4639c49cad8@suse.com>
References: <20260612-doc_add_missing_headers-v8-1-a4639c49cad8@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] doc: Add missing API references to api_c_tests.rst
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

Hi Andrea,

On Fri, 12 Jun 2026 10:27:20 +0200, Andrea Cervesato wrote:
> doc: Add missing API references to api_c_tests.rst

--- [PATCH 1/2] ---

> +/**
> + * struct tst_device - Block device used by a test.
> + * @dev: Device path (e.g. /dev/loop0).
> + * @fs_type: Filesystem type used to format the device.
> + * @size: Device size in bytes.
> + * @is_fuse: Set by the library when the mounted filesystem is FUSE-based.
> + */

The @size description says "in bytes", but tst_get_device_size() returns
size/1024/1024 (megabytes), and tst_device->size is assigned from it in
tst_test.c:

    tdev.size = tst_get_device_size(tdev.dev);

Should @size say "Device size in megabytes" instead?

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
