Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11ECE7717D
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 11:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733743548; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JS4pTj0cqpKJRiqUHi40UwpSbZvhiYc8KHNpMiYc/eI=;
 b=CwcdQIW2QxtEdCIr9r6VBLq0USteKHhW3WUSeFsT1wAiHrGzNJnLP8OAEzwiI0CQXa4jC
 mNUYeAbkj8LSJjSmmzIOSmLokFRXnbapd5+ZfSNXKar3tnUAoSIcxzsz7DhfjDpQ7gtcEyi
 yH3U2Z9h7PWWyA7S7IWIoGV5qrt3LRQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 526F23E7C25
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 12:25:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24D8F3C0070
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 12:25:28 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 53A0C140E460
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 12:25:27 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9f1c590ecdso751677566b.1
 for <ltp@lists.linux.it>; Mon, 09 Dec 2024 03:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733743527; x=1734348327; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EtHmUm4k5to8MIeymLfQ/P1j90Zg+ooWPCZqXoPBtcQ=;
 b=XltnFSC4mX43UHMQWU5BlrWUuyIfl4gAZH+DwtmKds9SDJjwLDWZtNUWA5XcyuAOr4
 yrEoE42foCstNP2LsFQrDWiwDZXSMrd+0y8H3++qDsXctMZzhrfOZlzcnOFVhaVzemj5
 kp5RmRtnbklxblhw/B0HM0DRLP5c6I/M7r9xwZv97tzt/2DHCtQVBSEta5WQbLS5KNSc
 VH1/OTWiScTlyQVJY2pooU3K0nWnhxp4DoiVCxn0B/D1CgyuFTz+3pPrTV/P7UmvRkgd
 xNz6qyE+6+SIV3u3uq0xzs2EFXU2J4hZnLC6lFVedgyhfxPGFVpi1IWOCxmUPvP8RFDR
 OH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733743527; x=1734348327;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtHmUm4k5to8MIeymLfQ/P1j90Zg+ooWPCZqXoPBtcQ=;
 b=xRL3j5kVXEqY2QiRAo+U9kgVMKoWdhY8UmnIfGxvo8/D2mRHfr7fp4HDO7ChSDiyAX
 YrIYYNJ32b+4hkCDaNFFPLpMTSgPXmR/VLZb4fmfJcatTDq0/Ez4OcNaqi+pCgtJFl12
 6zUYCOsMDkiNsvD6ztD2pEz+EHT7Mx2LJ1jubcd9s0wRzDNMCwVKX3wBpprVNNpQtJ3A
 g3o0ZPDmt5P3UHusNUpDB2l2TlHI42MOfIFZwK8gYNublKxpaNe1zehw4fW6hxUZ9BZD
 zlg8Or0SWoN66e7cyjGccCqVnEhf8GEGBZH38zfRxYculGkBMZh3Q0pupq57L9z9Mq1W
 D7sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUguwnpJH3EMdYOen/GtP7VHdyZjD5Q4G4cs9ep7wWfRXpn6OHuDdP5P0rJPlGY48CjXg0=@lists.linux.it
X-Gm-Message-State: AOJu0YzTJQSmyO6jFFoNlsc8zgtuRi/DIQkIiuO3ecPLRhQPswcTHsf8
 aLfQql4wKwG8YF5ckayXPz3lswvaca7zbaXVozTuKGcZnsuvKjkIfsbNIJiOoQ==
X-Gm-Gg: ASbGncsinx66tDncarfUshA97uHfuPE/EEZE/LbvwcFhJqk/j+DyniUy1TkR0KvWeQE
 /Eh2n/wnih4iCsdvniujKFnKj6WLRTWHiUU92IU+bgMCDnvJP/TxtsC2o1tewF2uGmNStVYeJuo
 MAhyeVicOl8ASL8IrPvBPKRvrjU5WKpkal7KrQwbXpa9ZF6/RVLPpv5aa/9poMjUXrj+na6cZBr
 NE2O9u8vCpsiVK3zoZvXautiL9KvqA5PE28rjo=
X-Google-Smtp-Source: AGHT+IGVxKWt77DWQARpIknDnCN18ttgKiO8Wi9MTCTir8m8l/Iddze87LXsWzKbS7qoNrOxlJc0FA==
X-Received: by 2002:a17:906:32d3:b0:aa6:8600:24df with SMTP id
 a640c23a62f3a-aa686003e92mr341775066b.26.1733743526710; 
 Mon, 09 Dec 2024 03:25:26 -0800 (PST)
Received: from wegao ([223.72.85.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67770d264sm243230566b.64.2024.12.09.03.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 03:25:26 -0800 (PST)
Date: Mon, 9 Dec 2024 06:25:20 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Z1bToBuD9yI2Whd3@wegao>
References: <20241108053710.8639-1-wegao@suse.com> <Zy3fh5YZeJ5djPt3@yuki.lan>
 <Zy30Vzk/14/GaEVk@wegao> <Zy30xPImjjRMKnC0@yuki.lan>
 <ZzFwK5nP+cegx2fK@wegao> <ZzHzs-jVLwurbLm0@yuki.lan>
 <dnhjiv6iqwbref6kaq2amylqbwrksnph3l7ewxgqetp6crrz3s@3k5j5t4sy2gl>
 <Z1GntmAaGo_alyE0@rei.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z1GntmAaGo_alyE0@rei.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_cgroup.c: Force tst_cg_scan only scan
 specific cgroup version if needs_ver exist
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Dec 05, 2024 at 02:16:38PM +0100, Cyril Hrubis wrote:
> Hi!
> > > You are supposed to get an error here, at least that is what I thought.
> > 
> > That depends -- if the controller's tasks are all in its (only) root
> > cgroup, it can be re-bind between hierarchies (v1 to v2 or vice versa).
> > 
> > > I do get error here on vanilla 6.10 but on debian 6.1 the mount succeeds
> > > as well. CCing Michal.
> > 
> > If /sys/fs/cgroup/cgroup.subtree_control contains `cpuset`, it's likely
> > used by some of the services, hence not all tasks are in the root cgroup
> > and re-binding fails. That's what can differ between systems.
> > 
> > > Michal I was under an impression that a controller that has been bound
> > > to v2 cannot be removed from there and bound to v1 anymore, but it seems
> > > that it may happen in some cases.
> > 
> > It can happen under the condition above.
> > (And in a future kernel it may be truly unavailable in v1 with
> > !CONFIG_CPUSETS_V1.)
> 
> Thanks for the clarifications.
> 
> I still do not think that re-binding controllers to v1 is a good idea
> though. Firstly v1 is being phased out and we will eventually get rid
> of it, so there is no point in investing too much effort into v1 testing
> in hybrid environments.
> 
> And secondly I fear that we may end up skipping v2 tests because of the
> rebinding. What I think may happen is that the cgroup cleanup is
> asynchronous which means that there still would be remnants of the v1
> cpuset cgroup even after the particular v1 test would exit, which would
> cause next test a v2 test to be skipped, because the rebinding would
> fail.

Thanks all for feedback, so we can skip this patch.

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
