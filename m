Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946FCC433FE
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 14:28:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927D0613D3
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 14:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 927D0613D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 193E23C8B3C
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 16:28:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 718FE3C6DF5
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 16:28:10 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AC1991001280
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 16:28:09 +0200 (CEST)
Received: by mail-il1-x134.google.com with SMTP id j15so3040702ila.6
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 07:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5iBXdIGgxweNNV5b8hPatfsLjTXomXv+XrkI5wSls78=;
 b=tIDlnx0NW62z7GrS3cDtnIPiFtFhlC8Jp5bcVjQRevl2upi/hyVj/QPc/zESsaFh8o
 aIE7U5GlGTaYsic0cfW7iGrxdrMGC6LraArZDwPnNIt5HPJ+GvzaVKHQUJ5MPJyLmtmy
 WjWrsDZJSPfz8DUufo/g1VJ9Op5B5d7zSykU72KLrABbPjMiH5iMcZ0YT1lxImcJYInB
 B07mCwSOytMwdKe6NdhSZcnkwKTRioADOQE286IVrPbjgJ+H+Ka3n0AjxySiM1aw1+me
 1vVAtqT4WhhVBN1VAM/wN+Olu/k/JKmUcvl4JoBT0UWjsVypTaDOiQt14bcEgfc0hUvV
 C4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5iBXdIGgxweNNV5b8hPatfsLjTXomXv+XrkI5wSls78=;
 b=W1MQ1V7+582j+ekVdQiYaWfsv+LPAgbF+2LxK3tMELinOfCG49tlNyYC/TgoPwFswz
 kVCHkAh9QXltMX9aNiVopYrLtFzOUunBiXHyqUbptdm52+2SkjZEO21lyzHSwYaRawjS
 SwWbZXJcHvzc/ydx8zdKUSRKF+yFwXfheRRfvQ+SOBG7eiFZDEI6MOnahEx2YWKLcJb9
 4pkzMP4PcPmFfcfnlMMjDTpOYytFGMwNA+H+/TyDwVM83IdzWuC0PbnlvOqWWOb+YZGi
 xGEw+69f+yZ43zi0gd9iPSWtjh2GrMT6vX/gXKYwISto6ML8gN4zQSzAjV3HGCzfCSGo
 E5yg==
X-Gm-Message-State: AOAM531iE2mVm3QRYsHWlYXDGiOkwURu15Jodlv3smv01WLZ85R7az0y
 s9cX84qyPFU9c/GKG7lZQg6Frw==
X-Google-Smtp-Source: ABdhPJxVFa6OD333otGQmJC4/vmWYPDWlXST5c69FSbf+ABG5Rdsnpo03oFGcN2pfsiAI1ccv0ry3g==
X-Received: by 2002:a05:6e02:1c2d:: with SMTP id
 m13mr8494532ilh.2.1632925688409; 
 Wed, 29 Sep 2021 07:28:08 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id b6sm1464194iod.55.2021.09.29.07.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Sep 2021 07:28:08 -0700 (PDT)
Date: Wed, 29 Sep 2021 10:28:06 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20210929142806.GA3993090@maple.netwinder.org>
References: <20210928021850.2015065-1-ralph.siemsen@linaro.org>
 <87ee97g5gi.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ee97g5gi.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: fix MemAvailable parsing
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

On Wed, Sep 29, 2021 at 09:14:56AM +0100, Richard Palethorpe wrote:
>
>Just curious, did you find this on 32-bit ARM?

Yes, it was on 32-bit ARMv7. It happens on the real hardware, and also 
under qemuarm emulation.

You can see my replies in the "fallocate05: increase the the fallocate 
and defallocate size" thread, so see how I ended up discovering this 
problem.

Cheers,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
