Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293BCC3DA59
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 18:36:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F9003D1B53
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 20:36:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 884FD3D0B1D
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 20:36:41 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A598A100112B
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 20:36:40 +0200 (CEST)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-760df01858cso239888a12.2
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721414199; x=1722018999;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VgIIPiy59LqH51i7mlHEje4QzpR5GMIWcabgwztNVyk=;
 b=sVU/11h4CaMXkV7SCX1ebmVAAUyBxidfA7J4kri/fVtjK/dgI0fN/V3SNnAsWvC2sl
 hURSQVPA3xcnTrDCzE8tMrg8jXgzDZn69zS1+05lcBGVHAKNu9EmfPrYfIsZgPSwqXR6
 SESVV+dqv+rtR2jcom3T6/UTMb32faL/7heJUDUBUkBNQY5Gc4KnF3dl5MJ0meVk5lvH
 0IgBaUz2ZmB0PHUbP5R7rFi8wDvaxF6XDAEMZXGLGzK4X9wK/9yUs8seRT2viRgTrl9d
 mteRrblT8m0nhO0ILfYAIzg2/GqKsUEiWcAj60pJB1xT6+Nz2O3jsYsH1tJnfKP4jpT1
 LN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721414199; x=1722018999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VgIIPiy59LqH51i7mlHEje4QzpR5GMIWcabgwztNVyk=;
 b=fHaa2PRMzusVbPSClGQlcBknF/BH8bPD6RWbWBHVh9I3os2G9ezRBQ3lW+LfVFiOtA
 sTkJvl9ZXs2TAH9KQVKWViHEtW6uU9xBRfKeTRlZ8o8i654ianCTOpEgVmDZAKDxhhn7
 RVIMNZGnklzBBKOjJtKWUu6VgHvXJqO0lJ1qMwfrzwmfqFTgYWfHSsPr94X3FuKftOUX
 3vYk+fDgX9YRhgylIMECLKIayZmuWuCYF21OvxjMPc0X24wEKubWrIgyeQh+29iMpP0Y
 1VVzN8qTM2VrDKzGBqcDVojfpQS1M/mdJFvjla4FsG5DMhzvYBPmWL6hf7Wejsw+aKQQ
 aMtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt6XgWKaaqGsGxfBbuuPJPBwPz3oxu4j9yCLC5SHxv2JdqE9Zcy3VkdHdqZr/L47alPzmty9e+0jC/X/JjFx2Oj4Q=
X-Gm-Message-State: AOJu0YyuwHrHtpQKWfRxx+GvWkZSKh9kKpGvmUtdJomY2op0/cQNC4CY
 RsWafWdf4RXJPYxTvWzYFEKfNYKkl6HpDxtN92vxwxws6eqj2DLBBI2ueXKNA+Q=
X-Google-Smtp-Source: AGHT+IElkL/zBCFHHaWiQ9kI38/vtt00gS40YnBc/B370nhydxYj7oNbKI27NQ4SuuKDpOrOGcNOuA==
X-Received: by 2002:a17:90b:20b:b0:2cb:4382:99f1 with SMTP id
 98e67ed59e1d1-2cd16191fcdmr555838a91.6.1721414198645; 
 Fri, 19 Jul 2024 11:36:38 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ccf7b2f300sm2025155a91.10.2024.07.19.11.36.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 11:36:38 -0700 (PDT)
Message-ID: <a59b75dd-8e82-4508-a34e-230827557dcb@kernel.dk>
Date: Fri, 19 Jul 2024 12:36:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20240719174325.GA775414@pevik>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240719174325.GA775414@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Slow down of LTP tests aiodio_sparse.c and
 dio_sparse.c in kernel 6.6
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
Cc: linux-xfs@vger.kernel.org, Jan Kara <jack@suse.cz>, fstests@vger.kernel.org,
 linux-block@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 7/19/24 11:43 AM, Petr Vorel wrote:
> Hi all,
> 
> LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3]) slowed
> down on kernel 6.6 on Btrfs and XFS, when run with default parameters. These
> tests create 100 MB sparse file and write zeros (using libaio or O_DIRECT) while
> 16 other processes reads the buffer and check only zero is there.
> 
> Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> (Non default parameter creates much smaller file, thus the change is not that
> obvious).
> 
> Because the slowdown has been here for few kernel releases I suppose nobody
> complained and the test is somehow artificial (nobody uses this in a real world).
> But still it'd be good to double check the problem. I can bisect a particular
> commit.
> 
> Because 2 filesystems affected, could be "Improve asynchronous iomap DIO
> performance" [4] block layer change somehow related?

No, because that got disabled before release for unrelated reasons. Why
don't you just bisect it, since you have a simple test case?

-- 
Jens Axboe


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
