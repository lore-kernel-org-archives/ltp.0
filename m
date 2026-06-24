Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB5ECDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 08:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782289948; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=uAsucBxypqfkaMoxB9wVxmUhM2jFD40swoLDmQlDybk=;
 b=Q9dsg7W++vLSSJVj3yuK1PUpRdnW5ylIgKXjm5nG6euvP8RMbYjhayEAFiigTfX87PdO5
 7p65LTt5mSIS0DXR8DmrlmnSHh85hlygHJs4RcFUA9CX5ZaF1kNFRMcI+exx9+K6UqsKhGF
 1VaDSFs7l1SF24Yd4VwXiJiFzecjpC0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6B9D3E533B
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:32:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 566AC3E2A81
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 10:32:09 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A32271A0091C
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 10:32:08 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4633193af19so575123f8f.2
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782289928; x=1782894728; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=x8UdQd2SBLZU/xK1S/Ms+xsCFFe67ki2/6wcCBzAq/s=;
 b=g1GM+sRmcMHNyG4bPcer/mBvS7x4fQwBgm0LQnLrVDa/TdPq2/M7zN5q4+Q2BkJ35t
 Z673/AqDWVMAcTBHb7idCWEdyZVGhsE58H+UlDjpWwcMOtr5soOmIJ5VpRGZvdajyaNl
 vI/crqcF+heMQziPsQrzq8I1WbyQ7WPQXOH8339ojPBXvlyUBriM7FOXM6sbcg9suV5D
 H555A1RihCHjo/29o1JDyXglqftzf8GPErBVVJciKb7nZD2hVfPbjH+q/O6waVFpXxhc
 3spopQLwt++BPO42lzVqMT40o0A7gXyX8YpjTC4NDdhJ1R2CX7W2mEhoXpxegZKowFeK
 NyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782289928; x=1782894728;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8UdQd2SBLZU/xK1S/Ms+xsCFFe67ki2/6wcCBzAq/s=;
 b=Yvf75X+erpJo31wi4Dsb/rsCS/HzHN3vkCzsL/+XZ96/UMFJOxjceTmAAbYSm95kok
 vrNPtzLijQ3DpiIKxwubwNS4wig3jjpjRXeXWonynd2RgUUvMy5tPY1lRIkapCTR+dvd
 DQSENdWwI7iiKKZ5eGgAn4OfuPL40T+N8qaaFR9iL6dlngkYkxzta/iRAr78xwAHLb4N
 Cbmu+Kcs4JfKBT88tgckWe0OFZxorUagM6a3OQsYFqqkfV4kSCnmdBjuH6epffKUGvCI
 nTVMYhWCrH9lxXIhpIf5XOlBtivy9iQ6PNW+jxTOW1Hh64oyy6GrAIztJC64rqpskRo4
 F4Ew==
X-Gm-Message-State: AOJu0YzQKaWQqmUjc39L7HVm0a9BtXhnBptjOPuzxJ6BOdF3ya4eSpLK
 d/+WZXaC5PuN8zHWUgPZe5Gka8xcowHTxDF9ip7149GKN6QG8Y6rCHGJLc7gzUmT127ozbBLzxP
 OuUiqeVOOsw==
X-Gm-Gg: AfdE7cnirhyIlL0o8Tq5jFzKFsZr89lX/GlUbKmSysGMoySk+w3RF/bUskKpowYXOze
 jyFhJEi8Wn6VZw4Y0HkPiM1p4+t45jPtesHttRvD5L4PR6j1cV+MT3S7elb4O0JQudDoKuEgHFL
 drV0KSesr3hNmjWSC7etbchVFx2qRLlztl1tp8DwYrS3Ur97bYtbuqwp5sA+WUaUSfEgwTuPuQY
 6TVwLoVWYoA/YhTnzYnJ3JSqunbPLHXIfv9h642eBsYevYQk3MVwrgg0L6aaKYhhYBu+tE+Z78b
 5nLXIPGCZ/uDV8pGCwP6n6tTejoJYziP1C3dvkOKrnpozd5DsxHIhnq87IvU8K0a1yhJDmCASG2
 aZ25TfC/ceRgQ/wyPPm0hTxE6qdpB3KCc0pyrOiZtXWkf1C6g5TPxpFlniLzzJnkacvLQh8wfUz
 dtJXGovcDEkoVR4qVUv1rj69hh9glk8fwcIuSlqXbUcf2XfKvDQ4luXHXP67nR7Lkn2yioN2pTz
 fJXrTZZmMWoG7aqRSN2ERb2Ah62Ada11nwY/Y2lisjUPgdD7XYcFn/PslXUUYrOXiA=
X-Received: by 2002:a05:6000:40e1:b0:460:3233:beee with SMTP id
 ffacd0b85a97d-4666358161amr28943343f8f.42.1782289927931; 
 Wed, 24 Jun 2026 01:32:07 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee018e8sm5023011f8f.11.2026.06.24.01.32.07
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 01:32:07 -0700 (PDT)
Message-ID: <6a3b9607.2224f9ac.254922.cd0a@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260623163144.83028-1-avinesh.kumar@suse.com>
Date: Wed, 24 Jun 2026 08:32:07 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sendfile09: skip on native 32-bit kernels
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

this seems to be a common pattern. Did you see this repeating for
other tests which are skipping compat mode?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
