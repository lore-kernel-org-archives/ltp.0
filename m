Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530F8C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 09:59:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D1BF3CECA1
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:59:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DFAA3CE1F8
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 21:51:55 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ABBFA600B48
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 21:51:54 +0100 (CET)
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7bed8faf6ebso237141939f.2
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 12:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706129513; x=1706734313; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fQVPErXU290D1mpBNScwazLtfS5510hpywHlBQuGA3w=;
 b=AlIhNwTMEs1swxeBqBSHx3sbzB/5R7nnULksetWum9CzObVKjNR8uuUAC9Xr+IsG7W
 4VbF0OgUG7OqKfwuPu/PzhTiShR4q0Z0jc6EN2Mm+Q2WJIjCbcj4QbZr35H+gOKKIimj
 0ZY+3yrs5JZbYA+xcWfPGWPjKSG8s0fBWdlNxJS64DT8GJgKR12Qk3uJIkqlYwqez01b
 oJfwCgTHxczxG4dcPUn1MyuxOSgR2ufbG/Xe6LJXCwKuSWKHYTdTjsrsm7bt3h9W3WHG
 VoQqjzrxbrw2uS9wa52ewun5617OOrK0GxxXFTWmtUtqzsG/WQSiK+sq2NBqfLtUYlhf
 9mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706129513; x=1706734313;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQVPErXU290D1mpBNScwazLtfS5510hpywHlBQuGA3w=;
 b=dKN6xxIzmG+ouoQaSu6nIDonxFLTLpcqwW4qgTQMdB3QxHeqP7Fw++w99ULwzvb8nh
 qsFbnbTqCwkmaBlOArkeDU18cO4gfKAhyHHlLtYwMhZKhJ7FmVrbR3SYMBHvQ86Ou3Xw
 SoIKXEqx9gY3H7YS7Lhvcqs3kzCjB0pq8vv2Tlnh8FUYJDP1DAWizDYrDZ/a86t1/6jS
 ZJlbvuHcucVSMOjs6aQG2X6RkddZJuHBlA8NOGP3F4vSGSym+3URijV48ptQ8gbC0RBY
 H+0T+fMPuRsq1f58TXs5f56/gyVbBWKca0Zf/AvXSStGX/Mo+XxCvHGNB9QatrErstZX
 XHOw==
X-Gm-Message-State: AOJu0YxykbmUh7q49iM4VwkINhlHafYK6pqBjlHgOUHQ4hNMAOzaAnUo
 j/R0V+PAEkNrP3rTuwUmOuY5ZtaGNi5Op4hDShTMnCUfB27GKVTq
X-Google-Smtp-Source: AGHT+IHjNeWesur/WB2rRojObeX1a+LSe04ratH+e1bBz40qjvSKeqNxLteQ5vzjt/5l3tCMVI0Yfw==
X-Received: by 2002:a5e:a50e:0:b0:7bf:59d5:3b43 with SMTP id
 14-20020a5ea50e000000b007bf59d53b43mr27797iog.3.1706129513250; 
 Wed, 24 Jan 2024 12:51:53 -0800 (PST)
Received: from fedora-laptop (c-73-127-246-43.hsd1.nm.comcast.net.
 [73.127.246.43]) by smtp.gmail.com with ESMTPSA id
 gs1-20020a0566382d8100b0046e9ad3dbe3sm4136813jab.128.2024.01.24.12.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 12:51:52 -0800 (PST)
Date: Wed, 24 Jan 2024 13:51:49 -0700
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240124205149.GA268968@fedora-laptop>
References: <20240124200032.GA343522@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240124200032.GA343522@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 31 Jan 2024 10:59:18 +0100
Subject: Re: [LTP] bcachefs fails to mount loop device on kernel
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
Cc: linux-bcachefs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 24, 2024 at 09:00:32PM +0100, Petr Vorel wrote:
> Hi all,
> 
> bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
> Is mounting loop even supported?
> 
> [...]
>
> bcachefs mount /dev/loop0 /mnt
> => Unknown command mount

What version of the bcachefs CLI tool are you using? Is it distribution
provided or did you build it yourself?

The mount command has been implemented in Rust for a while (since
28f703cc256f "Rust now integrated into bcachefs binary") and if building
without Rust support (BCACHEFS_NO_RUST defined), that command won't be
included in the binary.

In more recent versions of bcachefs-tools, building without Rust is not
supported at all.

I don't think this has anything to do with loop devices specifically.

- Thomas Bertschinger

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
