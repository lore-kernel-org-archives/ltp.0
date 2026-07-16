Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 790EEC44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 08:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784191013; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=NzhJKGMq/uhjO8pbhKiixANHvclcEhPcmcSSm8EwbQ0=;
 b=YRYQ6SZiZ67XalxZN9vszWQrcA8GGadGe+Bla1pR6CYHVIKk10o04RhD56kECyNnpUrGK
 n7JDzfUFNyeSOzEQQrH7oyOLWeLLGUQyTLc3k5L0pYL480YDSNz/Vyv8xPfiBVSxb37joPi
 yKKEd6oHzYuCXvmgFUvUB4qtnQuHFFM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B85263E5618
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:36:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9070B3E2573
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:36:33 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B2B4F2000F3
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 10:36:32 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso56320755e9.0
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784190992; x=1784795792; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sqD5kuLeeyn31dRinx3sQeZDgzvNcKVKty1jEMfmFbY=;
 b=dGdoV9Pd+D3f/xjJFvF8JPPHeIqzMwpA+IVMG3bwspVLbutyqr1auWexSg8qBdgV3I
 U7zdauuImsx86eDz68jAVoQe0V7jScQ1M6d6Dn6KBp5X6Uew7Un1BO3alRPm5kgCO7P5
 6vHge9UdZ8F5sXDrU2Uw4IaU1hABf5Jx4MmmF6EznkBtPEhK7e1LHKSWvIt1VaE8VRds
 YdqS7v4JaFW6zZAnyh2oJIMMIFTzTej9JMlBJSsjNBapzQTS1Z+6woXOyGaebGdaqgBn
 vvrpHXSNULV3I6vFq/8gcyC0OH4YKzxdDvqREfYRsE3qGTEiKJYQ8FU5n8rEk3ru6V7v
 sOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784190992; x=1784795792;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sqD5kuLeeyn31dRinx3sQeZDgzvNcKVKty1jEMfmFbY=;
 b=ET7nWiTrVAVpJuJs0osmenlK9ixIKKvaoDFjc2p5+nLYo3V8OHIyXaVtQM3NHt+SPu
 VyqPA0DXH1znsNjCnpm9h4onpZFjBM7nASmqPWviuwDog6FS9rpDQXtU3Mmzd86h6MNm
 Oyl2eytQaasxutOsLCT1qE912bZo8Bv7hugu+minFQeDn+eAIeATXax757c5pvSk/iMa
 B8wXi1T31AB8bEzjtV4W8KakIPdvD2eJeK9icYVYTYOzxG2Sr+xWsFuu6y5FGIqB1uj6
 RRdyf2ZmcS3VigdblUWve0ncWeDqUhdFNzaiJhDZP0FoCxe9DdX7VD/8e81Fa6U7srFm
 z94w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUoxiR8gpAw7Ghnaevnyr+JcUvkLMLNvSqtZiIatxxSFUE9OSxlPLJT+9bSpvxnYXi4HM=@lists.linux.it
X-Gm-Message-State: AOJu0YxlAzk0HxXqjyVyAg0XBGt6k4IC3E97vlL2LF0fCnksif+FkkK3
 7+zdGxbxSUmHuNbBtaPFwd0lYYrc1L2Hfo2d99XZqppeeKdub/ZXI6q7MMLCmjnyskh1hs+6BGq
 lP/DB8+E=
X-Gm-Gg: AfdE7ckfhmSc3dm7jT8jdzZHFsj6+mLgbxOTCcOdxrynsJJ+UCazHaqIJ79HDqArdLp
 mL6NWB3xWa4AEdE6vJ4rWADQOD6b+6PsqSU7wgD9IMiWg8vkSxVUjVkL95M6++GJHzoPvmvOz/P
 4yMrUoVsz5KBDkO0bQYfOzJui8/Tr9LfIzrU1dOlB28inW3XqBHMzpeLJ23Th38XQ0Ajig/WekP
 bFPusUu4Eu2po2n24OGBSAzWHfaoUUFPOHX69qj+tw032DPzx1qkNVN/7F4/9YlzSB2oYihHu37
 +9OPzdaoUAF390sJOaA1A+h/MSQdFlHy2oGyEiMJ/ikF3EkLj39tOoVl/Lq1okV9rHOam5bSdVK
 s3ZHooe36Mr2fjhIFp3iXhrTlYOTljLTdoqLIJiZjISS8Ga1XbogJLIpSzWvL34Et4yiSuMWeos
 HbkRRJ4uAJwILJ4ijghZWzbEdtNA==
X-Received: by 2002:a05:600c:4754:b0:494:ca0e:880a with SMTP id
 5b1f17b1804b1-495389d2ba4mr107181075e9.12.1784190992068; 
 Thu, 16 Jul 2026 01:36:32 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e8c47esm43903545e9.8.2026.07.16.01.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 01:36:31 -0700 (PDT)
Message-ID: <6a58980f.80d8f3ad.34c319.0fb8@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aliWtSpjgAR_OY51@yuki.lan>
Date: Thu, 16 Jul 2026 08:36:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add pkt_cls.h fallback
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > +/*
> > > + * Same as NETDEV_REMOVE_QDISC() but does not fail when the qdisc is
> > > + * missing (strict=0), so it can be used to clear a possibly absent qdisc.
> > > + */
> > > +#define NETDEV_MAY_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
> > 
> > New public macros in include/ require kernel-doc (/** */), not a plain
> > block comment. The content is fine; it just needs the right opener:
> > 
> >   /**
> >    * NETDEV_MAY_REMOVE_QDISC - remove qdisc without failing if absent.
> >    * @ifname: network interface name
> >    * @family: address family
> >    * @parent: parent handle
> >    * @handle: qdisc handle
> >    * @qd_kind: qdisc kind string
> >    *
> >    * Same as NETDEV_REMOVE_QDISC() but passes strict=0, so it does not
> >    * fail when the qdisc is missing.
> >    */
> 
> Looks reasonable. It may be a good idea to copy&paste this to the header
> before applying the patch.

But then we should do it for all the others as well, maybe we should have
a follow up patch to document all macros instead.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
