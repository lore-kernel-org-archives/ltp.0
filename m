Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB2C1098783
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774012902; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=/E/OCSKU5z8kcuwwCvtV2OZRoB2XZNLRW4QtOWy9ftI=;
 b=jzX4tllrB9j/7ngbhakg1zpv3qoC4lwSVR6s2iS7lUhN3UykzfBPB5V64CzktiH2ChqEG
 d4URS6w3PD1uvU3HhC7aqQdbmUxCjSLWO5Jk8hxfEE5Tjfg7TSyB25vAabRi9uybKYvwNm+
 10pNaga7MjZGKs6GXRJwypbvG4dka3U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B38943E30B4
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 14:21:42 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8ACA3C57FD
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 14:21:17 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 81AAD600E21
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 14:21:16 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso13618965e9.3
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 06:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774012876; x=1774617676; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MVxEEgWchCUMCbqT/QlDQBLrOMwuumWnM01OGaiQmQ0=;
 b=cDN4galPG1QzBFCKrzZ3Bz0g6nb18BjMUy7nT/heQFS6SZpfYUKrD86tzzvr1hFr85
 3Yatcekt9H7RGYxInwtwauknnpYMzLNrtZHpN2QC70+GnXQtfEzHE9eZGtIYB7KlDIa2
 4M0RI+nTGGrDyrkR7DPWiSJgMpHXEPu++WpK4cgO2gboyJ8XggFISrdwusVtiQk/GOmO
 1+kN9R6L/WWjvo8JujTWuKcpl30MN+yaN4ZCDPI125kHkiGn8ioVC59NnvTKGndAZ2Mk
 cLr+2RjWAQEEkxw8Yp3T/5wscXl0qQ9RClk6ms1OEjZl5FC4R1RGbDic8k8iVrnDgH+X
 TbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012876; x=1774617676;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVxEEgWchCUMCbqT/QlDQBLrOMwuumWnM01OGaiQmQ0=;
 b=QhuCmvRXo9fjBm9UqWKn34hcqihFzOmUp2FuElmmDJaZTzdqKbXmL18dMR/lcf4LBW
 I9jCZsMxJJKKafoqiAcxsPc3K8PYkGnSnKemC9kBvSZEy7dAOZx/Z8dIxFcb2CtleOyi
 lvLesPxkfhO/cnouBiFAdPOhreIjJG7q5UmdLclB6qvW1r2DBpfeurkhpa1Pj+He3q3z
 W2I+A9n5GV9TXcbSYgFomzM8Zcdp11W08Nq6tlQqqGLV07cC7e8pt01heS9MOUsQ4u8/
 ehrnzugWuQgC9ZtaRid0iDpJ1ds5coEwjZInkHG+gBrIRIbBwo9y5H87wYVWvF0rRLzZ
 8HeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4AgerCvQgbRmUcEOct9oUuINyCHrm3BxL1HVC8Dwq9QEkJBcjJD0SDs7JTeuhdj8z3Eo=@lists.linux.it
X-Gm-Message-State: AOJu0Yw/JqT1nbV8+TMK6oHPV83ff069ISlX1RiMxguD7pP6nzonaujZ
 R3Cd6W/X9IowhxjWv6UEds+zjFrNmGhTJFOOG5Nf2BgfljN7hwgPk2qcFziy9qafE0o=
X-Gm-Gg: ATEYQzz54tq0u4rcZ/Sk9kXGEXqp3n1nz//YKIXDIAZhiBD2+pmmMTPoiXoTMxVchCN
 ntGVbRbNrSBEd2DLehpZeyD0b0RRHvMzaMKvU31FmHGU/1hVhzJTqylSAWa3Y7btORhTUyF+ahk
 aZ9ge1eboS4Tf6Bqgor29FYIX9j5esMhrO3sYwHXee7zcMGJw5WWoYPcbq2rUSnmlY1zjlTmUtf
 b6TQCcWpmD004avuR61MRR3jr6r2n8FaPQIbLgQo/stBcWm0Uqvmu/Qw8pYJMB2NxUozF/9xacx
 FAW6r0r69bObiDPWZrrbp8eGJOJt1cEY9R6DJGEECNdx+6yGFYoCn/DrjCEDXu4csCMUEdA3E2e
 S3dBvpC/0XTHacjsp/RagbluwxTX99lzPnmqc9c+dssz2xxV1J36MucHUYRdbieRAGj/Ed9QuMS
 /nCMeYskRE2cExMbMZS09VphPh5spPv9k3BeK5H3O/Ret6IWU=
X-Received: by 2002:a05:600c:4707:b0:485:3c66:e230 with SMTP id
 5b1f17b1804b1-486ff039929mr43763765e9.29.1774012875730; 
 Fri, 20 Mar 2026 06:21:15 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe867e41sm17229065e9.4.2026.03.20.06.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:21:15 -0700 (PDT)
Message-ID: <69bd49cb.050a0220.283c33.1d03@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ab0hXPbw1dXD4JY3@yuki.lan>
Date: Fri, 20 Mar 2026 13:21:14 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Update architectures syscalls identifiers
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

Hi,

> Hi!
> >  include/lapi/syscalls/arc.in         |   2 +
> >  include/lapi/syscalls/arm.in         |   3 +-
> >  include/lapi/syscalls/arm64.in       |   2 +
> >  include/lapi/syscalls/i386.in        |   3 +-
> >  include/lapi/syscalls/loongarch64.in |   3 ++
> >  include/lapi/syscalls/mips64.in      |   4 +-
> >  include/lapi/syscalls/mips64n32.in   |   4 +-
> >  include/lapi/syscalls/mipso32.in     |   4 +-
> >  include/lapi/syscalls/parisc.in      |   3 +-
> >  include/lapi/syscalls/powerpc.in     |   3 +-
> >  include/lapi/syscalls/powerpc64.in   |   3 +-
> >  include/lapi/syscalls/s390.in        | 102 +++++++++--------------------------
> 
> Why do we change so much in the s390.in? I'm not saying it's wrong (I
> haven't checked) but even if it's correct it at least should have been
> explained in the commit message.

I generated it automatically with generate_arch.sh script, which is verifying
that the defined syscalls are actually supported by the architecture. It's
all good when it comes to 32/64 bit variants syscalls, but it looks weird for
others.

I'm a bit puzzled as well..there is a risk that by touching so many syscalls
numbers LTP will be out of sync with the underlying kernel. Maybe I will just
add the syscalls which are really needed such as listns().

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
