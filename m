Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EBACD4855
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 09:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778577734; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EGGVjBWQuzxS//AmscrilLqlzB9zERtp8zteML6numQ=;
 b=Pi0/Pb/3wbTXl8Cd975bHVkbwWWJroIEM9JWjtxVpwkxsUA4htA+JQaEUE56EC+4Ay9+L
 ykq84eQxM3r4pNn44n5FG5FTYCe0GnL4RE5az8qOFzKu7XFH8PttCZoA0/ASBj94i3WTaqr
 EreU+pS8pvdw/Ok/4sF0theiunhm0nk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFFE23D0360
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 11:22:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8315B3CFB92
 for <ltp@lists.linux.it>; Tue, 12 May 2026 11:21:52 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0598760080C
 for <ltp@lists.linux.it>; Tue, 12 May 2026 11:21:51 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-44c4cc7c1cfso4269481f8f.0
 for <ltp@lists.linux.it>; Tue, 12 May 2026 02:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778577711; x=1779182511; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PZ43n4wERq41BYN5ebbXaMLXy7yM6BIYrMzILRQ5Ut8=;
 b=a8OD2IRKMC6XuLQ3XUzVaR+Iii2DOiiiYgT8QIjFMrunNllrV3QZlIQrzciqGGbcYB
 31KpUzmvzQuV1LZXXBhcwCg47IT4lNmORZNKpb1R/hPX3LcpuheZ/kcX3GSXi1gf5qDG
 RySP83CihQ0Xe/n0FJXGNBh72yZ4jL/vRHoFfdaNLB65MjzeEOy/+NZilTtl32Jpe1Kh
 zmo3PNxUoxv1v2qhuAvCfgl4cYdZW6cOp7CWAjHN+xV+aXRsySrZQqYyOfFv+J1Az4FA
 9U+5LTUo6umydpa/SulOjTV5uR7OQHsu9zgq82YjUdffy0oIAWY55ZderKhjv6ipzpUc
 TK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778577711; x=1779182511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ43n4wERq41BYN5ebbXaMLXy7yM6BIYrMzILRQ5Ut8=;
 b=FtVl2dHHWE2Zo/RjknG7/wNQ0y2fSRtnGtBAv0sK/yGR35QlclA+Tz3GP2vRqME+a+
 Vrb9KP3sj07Cz88NASgjn0NJYuAbfMtQyIvR8leCGGzB1p4BrW2IuXx2/ZuelX3QWLgq
 Lee8OfebH4Ex7zD3YhKtDo0IDJ9GuRz86WMp/apWOxkZDq6h9WV1sCgXC6gvOrB5BCex
 lw5gEHKon7dO7dkSjfLHnsTgL64cD2m509fvzt0O3BpZ53FPhkom6uwJ67aEcSIsuX19
 ysSXMTnv109iGxCZTCCB4InGizg3OuTZ4MqkO+ageWxYQCLrkypXEZ93K23TB+oCiefe
 6Sfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+W1GrSWIelInj+Fu3Z2Bfj2FuEaKyIV1cw+KyUZlZLfoL88NJNdRFyI3ySCAo78YMpqu8=@lists.linux.it
X-Gm-Message-State: AOJu0YyyTjA2s+I/9gVGSrLRZv8MTjnO/TUIkfi2LnfKXgyOny8j+ArW
 ZB0fxpXJwUQ7/x8cTEfV2ALlZ548HQLR/bBhb+l17DGxxE/euWTk5klLRAhPD8AkB/Wd1yJbLmk
 Ei94=
X-Gm-Gg: Acq92OGMjgz0emC+ahgV6w5T/QzOnENA+IHhZ0M2Od2ysWxzZh5EpPJ8rEeSZhkiqoT
 og/sjDdTf/t5bMDj9TpxFYpe9P44eWlWom7B1kEMUgEVgvfb6QYMKtvI0JX3Due/zJTm1HV0UP+
 2l+rcD6Ut4Ch288F8A9i0mvL/+5YSemVwHHA5cVHkZhSpcYZmIbSkBfQppvnBFfXGkYTBhU3F4Z
 bNllzh6JW6cs2F3ns/qnqoiFDDi4UEUtW/a3EFCjdXaKZJG6wd5kaiR6AjLdLwEOGg3ACnnrX9h
 dTf7TQSluUqJzJvSPua6OQiMUdw8Ro3O5LUVKty+qpZvLB/849RABHWB+br/s0kcOVRp50LKK2j
 ais7gGb5M5H5FyLldrxEwx9ilQadHPY3dnLAsmuSXq5q+tQSFk1rXtvmddVAiYNJkYBFzFCHUzx
 KMxGwbtBR9/H3/ub9ATxu/jbljhKqJQIKAInBmfArn
X-Received: by 2002:a5d:588f:0:b0:43c:f583:126a with SMTP id
 ffacd0b85a97d-4515b5243famr43811632f8f.14.1778577711354; 
 Tue, 12 May 2026 02:21:51 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491da03a7sm31798776f8f.33.2026.05.12.02.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 02:21:51 -0700 (PDT)
Date: Tue, 12 May 2026 09:21:49 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <agLxLVAPo293qE25@autotest-wegao.qe.prg2.suse.org>
References: <20260512080815.3976-1-linuxtestproject.agent@gmail.com>
 <6a02e24e.5d0a0220.c20fc.ba61@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a02e24e.5d0a0220.c20fc.ba61@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] OpenPOSIX: Allow 0 return value when detaching or joining
 joined thread
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, May 12, 2026 at 08:18:21AM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> if it's ok for you, I can merge it with Signed-off tag.
My patch has Signed-off, i have no idea why AI can't find it :)
> 
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
