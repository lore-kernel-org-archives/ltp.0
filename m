Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CBDCA0FED
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 22:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757542622; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WJ1aEMCgsy2vcERmtWtBbYWqiJlMmq2N/Wz1KTAdAgo=;
 b=iaopdqWmf9+gcVZ1gArrOJj+YxfhD7nuWzyXx5Ql7tUtliXZ6dHPCWJSPY7dpY3psBC5B
 ytkpGRQ2zJKI053Vpdyb1Ci+SdgixUuqui+qzGQmdS7YE0joPUaoyVDYFmPHav+8+t7tT5U
 Zheql0qZpxOt1SVVLwfQhfKcvSwf7JQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C98B3CD7F2
	for <ltp@archiver.kernel.org>; Thu, 11 Sep 2025 00:17:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C881A3CA59B
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 00:16:41 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D85A3600353
 for <ltp@lists.linux.it>; Thu, 11 Sep 2025 00:16:40 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3d19699240dso701220f8f.1
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 15:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757542600; x=1758147400; darn=lists.linux.it;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMmNqb4tpuZrvwvNRiElq3pTt0cYrizyFeLS4li56E4=;
 b=DO1Gnz7vocOVWsRntdMEYMFtXIGSJq/AI1rA+1TwRxgqomw9Z464qGPwP3Tmwi2FsW
 Bfj7AazUwgYkI2wWF8sUz0kRmSE2CNBmum2p11KYLi1O44Y5F4PUj9ePgTGDfFtkvV+t
 erGpOBau/i8qh8bPH/6KY1/JyvpB/CZydAsDp1pEkdLk32GDpyDKgKhmhexz79OGgBhO
 FCrrTz+b56ZpUtF2aZ9DiT6UniM3kOPW2M3l2yX0soYpAuOzo4oqM8/cAp8f/izpL+rn
 Y1ZBQNcWm5XFj6eesSuIlupDWvsTIHFEJNviQOIJ8npKFKDVzeizJkhGqwv/s05x/ycq
 qr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757542600; x=1758147400;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mMmNqb4tpuZrvwvNRiElq3pTt0cYrizyFeLS4li56E4=;
 b=cLg6j5f3JFxo3yw/8rFi5HdyHVDc5xvOa2SMDDgcSHCVqoNAIEo8usJ5lvBPB9svrz
 yEpefaHfPl5ZFcBWXscGMeRHkZ+GsxtpA19JFsMLTSGSd0bq+AClMgSPiLEjz8Cm1Knu
 2W0zT45VfklSHfOMxxRCMqi4w+lyv7Gf/2kyynYwyIBW1B4wrzg1dO7TFtMFH5sAM6kD
 S7wztRNf9Dombw5s66DaXlqd3Dtb3EmdynCfKTPnhTzUrinfbKS8HcSfQblg8GPKnXbO
 rFIot4ssiufcSzCd/ldNKcDxcFgtqv0RxvGj/DGOzA36ZTodRUd4UcF5WWMo8qu4+YuR
 mA+A==
X-Gm-Message-State: AOJu0YxqSodLbYc5Sz1N81oqP3YI9DyrRCzNfFSJAMmkuC1mk4PDXsyM
 xtffl7Z7rG/RQvm3YtKG+KXZZt21Kd3tl+m5oS5UWu0X7jEmZtZZjY0gsyluUbFaIbk=
X-Gm-Gg: ASbGncsR448/JY0mI3I7SVPOwc+WcAnwFJqrsxw17QI98LT/5Ie+mjdRjCd4pCAahP6
 u0gr8dI1eUbJ4vMmKXmlGT+QXzdXWpUrD6Tnwp6WBSh6hKSJ/oaLmQTRhNpQvon/yt9/qPPII7s
 rUxRAZQ+W7gmku91rLLUZyCSsPjf8JPqap0qhhJF2WjBGxdGDV7urHfvhxOUKHVKmgf43Yr+SAJ
 TATvscH7fYucHpH2pdL3CgaVd57hFt1ndZAKkbi35Me+j69YZuq8qTYL2cDPWZxhBszqwleuDZs
 zbYIBPRJ0iTU2qaCgAUHDNYl9nCFgVAYdvVY/qM6cHLIrAhuLEgSoCCUG6RzV2ySIW5K3S8mYO2
 ZeTzUM4x2dBwNugJGuSrA
X-Google-Smtp-Source: AGHT+IHiofvXDqButQ1PKlxRSrlUCN8YHs4hhioKKhqo+q7s9/8k3rHdAB050vKmKBNxVriBA7/urQ==
X-Received: by 2002:a05:6000:240a:b0:3dc:1473:17fb with SMTP id
 ffacd0b85a97d-3e75e146ed0mr807134f8f.20.1757542600239; 
 Wed, 10 Sep 2025 15:16:40 -0700 (PDT)
Received: from localhost ([177.94.120.255]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8cc199034e3sm21537241.16.2025.09.10.15.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 15:16:39 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 10 Sep 2025 19:16:34 -0300
Message-Id: <DCPGUPHLKT53.37KNS8RMK3KS9@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.20.1-125-gabe5bb884bbc-dirty
References: <20250829-conversions-lchown-v5-0-7c3f25cd1de4@suse.com>
 <20250829-conversions-lchown-v5-4-7c3f25cd1de4@suse.com>
 <aLb-uPKS6ZCmpUTc@yuki.lan> <DCOCPDWMUTF5.PXSIFKQYF1IW@suse.com>
 <aMGeffv7V-wbLfCQ@yuki.lan> <aMGmpREL-beHg00i@yuki.lan>
In-Reply-To: <aMGmpREL-beHg00i@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/4] syscalls: lchown03: Merge into lchown02
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed Sep 10, 2025 at 1:26 PM -03, Cyril Hrubis wrote:
> Hi!
>> > I guess the original code works because the final component is not a link.
>> 
>> Ah, yes, it's not as easy with lchown since the last component must not
>> be a link, otherwise the call acts on the link.
>> 
>> And the original code creates a directory that points to itself, i.e.
>> longpath/longpath points to ../longpath so each time longpath is
>> resolved it just returns back. And with that we can trigger ELOOP by
>> stacking enough of these redirections, which is the reason why we
>> managed to get that. We would get the same result if we stacked enough
>> links, e.g. symlink("a", "b"), symlink("b", "c") ... symlink("y", "z")
>> and then trying to resolve "z/file" which may be less confusing than the
>> directory pointing to itself magic.
>
> Also quite possibly infinite loop with a file component at the end may
> work:
>
> 	SYMLINK("inifinte1", "infinite2");
> 	SYMLINK("inifinte2", "infinite1");
> 	lchown("infinite1/foo", ...);
>
> Since to locate foo kernel would attempt to resolve infinite1 and
> trigger infinite loop.

Indeed! Will send a new revision shortly. Thanks for the suggestion.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
