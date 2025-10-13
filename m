Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3CFCCA476
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760345532; h=mime-version :
 date : message-id : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ZKlTqv9TiQw9uUHXj0t7Hb/C6hb/HicuPyqT0m9zKCQ=;
 b=Bl/COElK6mwPbOiAKI8k/aasD52+fGobNGxYmycPWr4HFCZubzjTPfLOIjHgNZxmLboPv
 /zccEm14kDgaVEshhTAiBzOYEocrQc1pp544Y32Qr4xvFKuuAHH0jFFqpiN6v7XTID9qQIR
 y93JoYz/xu5xusOF9MVrt9mbzit7/60=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 492833CEB77
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 10:52:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 96E6C3C8212
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 10:51:49 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B16896001B8
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 10:51:48 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b90so2310741f8f.0
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760345508; x=1760950308; darn=lists.linux.it;
 h=to:from:subject:message-id:date:content-transfer-encoding
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TQ+LVGWUrlw/SUDbYaC0AT0/7ZQuLbRDJOTOliKspL8=;
 b=TRF8xU/MaLCHefzkjl+TzSn5iOlZlk8NkFRqYeOPuBLxb10YMavX62aya0bYtk16xH
 EVl9FKKm9ZLKHsb3HAMURq6+ml0hLpVHL1xWMqSQmLwLLPYJDUFeUamH9SxWUhDpxM4G
 V4Of6WLjHUvnUJdrEHn2SXD0H5zmVSOsrebCoosVH5SL8joPrO6oA9jcRdhdIFkDzxdG
 smNWdPBFRmYNjkN2J4WBawsmiZmeUZWbpZ0Di587dDgrmKA3zuo63iF4qBycpHmvufaG
 qhUO3no7f/yQ+H867rBw8xfSbOezKfYUFgJWannk/fOIi3LentK270M/yrk85Jvgqo+f
 KD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760345508; x=1760950308;
 h=to:from:subject:message-id:date:content-transfer-encoding
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQ+LVGWUrlw/SUDbYaC0AT0/7ZQuLbRDJOTOliKspL8=;
 b=lwcdBN8wZJLDNtv5DwLFRm352xUM8YWKptDzNRqca8IGiYTYN5dMLLlr0A1XWBE4GD
 SLrPDKgU35S5qnXGEin73QZ83FrUfexekzpC0j4FkPDSTOE0BISo+H2oIuEWBg5Yq8Kf
 YyTPSR/pFZ2bfVDc0UmNoHdIM3qJRwGhHiw8741IczSSsT/SCwCrHVjKDg+QNNy1YOjU
 Kn2wy+65xBNwNOEx+WHg33XQbttVG4q3znxnOPrp9tVOsec4zIQCDGQDWDa/zp7qdkXa
 KBIPd0mt1estR5y0wwNkuZ0yckzQD+PJTkzL8XRpCcwFLOPS3UHIU2SzuBYLhyE2LI5G
 yM6w==
X-Gm-Message-State: AOJu0YyS2q2zXa/46YMFiGP+DYVjvpKTnzrQ/H1ZTUqjdgbzJNNPpgRm
 8NcEcgqoZhFAu4ciKtKb90PPhN6qCPfYb5LVbqKqfNv7nscMUIqx23Q0APUauwghE2TE/2KqBEs
 Fmdz5PvE=
X-Gm-Gg: ASbGnculhmDapBk24wRoajjUdaG2Q6/X5X2oPEFDliN+a4/oqsVWV/7lN+GNW5ub/8q
 t0Er1wrU0LV0yVSYhWL5mhWacwkBbevdFulh+no6BR/Wpupf6cthia8H24DUH0aGSEOhgtM8OjS
 MiVGo0AI9qfB5IZyx5JzQVAd8whzjmgyouz2QhB+CyjEaxv1Ns84dUZ95MjEkux66g+xJBfEAeo
 4s/sWpp8fCK5iRrLmeIViYrWbKv327Jx7xBrBPGu1yLgS82fKJC6UK3rpJqsvakovtHN72IHp0X
 kpyUY7Pe2rOI51jkffdjqhQaSJRzSzuA4sNzCJXrTcSpmn+A9qEtYEjzTGIQJboW7XdA6EPrKMj
 QCqMU/MU8KIeABH/DXeemlI2Xtu+yxhnirHJG/SBp8uI+9KQrgxcqIUw7kxyOegXf+xC9QbYWoI
 x/hrlbK3Mf3NSnLaXrndcTXI6v9ZaPPFAotOV7dzZQA3nBjg==
X-Google-Smtp-Source: AGHT+IGXEurh5Cmh/n0J/V1fF+J+vgq9FVgm2r98SWjCh4Wv3Vz6zKM7h2nk75XfwlFZoe0qh42+fw==
X-Received: by 2002:a05:6000:1a8f:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-42666ac7279mr12891214f8f.24.1760345507661; 
 Mon, 13 Oct 2025 01:51:47 -0700 (PDT)
Received: from localhost
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426e50ef821sm2379058f8f.38.2025.10.13.01.51.47
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Oct 2025 01:51:47 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 13 Oct 2025 10:51:46 +0200
Message-Id: <DDH2EHOMAZA2.3W3YUL70IUKB8@suse.com>
To: <ltp@lists.linux.it>
X-Mailer: aerc 0.21.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] kirk breaking change
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello all,

soon we are going to merge an important PR for kirk:
https://github.com/linux-test-project/kirk/pull/71 .

This PR will introduce the possibility to customize SUT interfaces
via plugin system, in a way that users might use multiple communication
channels to initialize, communicate and teardown the system under test.

A practical example might be:

- run a VM via shell commands
- communicate with VM via SSH or any other supported protocols
- when VM is crashing/freezing during a test, kirk will reboot the VM
  and continue with the next tests run

In the past we adopted workarounds, such as the "reset" command for
SSH, or the `--run-command` option, but they were not integrated with
the kirk API enough to provide a full support for kernel crash or other
corner cases. For this reason, we will support SUT custom
implementations which will permits to use multiple channels and avoid
any issues when complex scenarios are showing up.

This will come with a difference in the command line that will
eventually break CI(s) if you are using `master` branch (this is is NOT
a good practice, btw).

kirk executions which use the default behaviour (run on host) won't have
any issues:

	kirk --run-suite syscalls

But when a different communication protocol is used. For instance, SSH:

	kirk --run-suite syscalls \
	     --sut ssh:host=myhost.com:user=root:key_file=myhost_id_rsa

you will need to update command line into:

	kirk --run-suite syscalls \
	     --sut default:com=ssh \
	     --com ssh:host=myhost.com:user=root:key_file=myhost_id_rsa

This will tell to kirk: "use SSH communication channel with the default
internal SUT and execute the syscalls testing suite".

If you want to implement your own SUT communication, due to complex
testing scenarios, what you will need is to inherit SUT class and to
implement its methods. kirk will discover any custom implementation via
`--plugins` option.

The PR will come also with an updated documentation that will be
available at https://kirk.readthedocs.io/en/latest/


Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
