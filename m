Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F281BC44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 08:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769072091; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GsUhpkmpLIDiUWHJoEq7Ko7EP6+GqCIVQ7rJkThW4UU=;
 b=TZ4JUVl6k2tMpvpUpvqCrzMHOEGqVlJMrqR4bRkqnzGYg40HYz/O6feQBGif9KgcwEJPu
 2r73/fSB+dCj36u96Tp/yWdwel3E+p1ur8CIhuPWLXSgIbu80uVXvw7vgjoK2mhL2WxSZZI
 /e3DE9zGBpAMypu2hQxXxYqoW/we4Yo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 890213CB28E
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 09:54:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5DA83CB237
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 09:54:28 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E7CAB1000A41
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 09:54:25 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so577994f8f.3
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769072065; x=1769676865; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4em9HFT8RiAVaymkWIv9NOLymMvMiJwbOm2R6tyPSjM=;
 b=PPHBOgPRiEQzp4RmzFYALrIt1xrsRwx79uqdbXT6X49b3k2Ub8ZPjLqEPagm/8mLdt
 dM0qhc/th0P3RKZyZnp9/yJ6vVaCt9OmW9Yprde4wnYw/4ejakxb7yzgT38DPfbPiQDM
 oRAMiX4rXHmz0A2HvtrOWfago0e72ndEkxHe6+5qgcdu6syq8I/JC4g2U4vYuLEyifNA
 hCIWtfcaa7vCznJPOS81AR5o6pllzWC2el6UX3Nc6qyc8o8aM7+i1qOPYe9zGQok+tRF
 rrOaaknQLMzZcBH5Wcv4wtAc7hBhcvaRMEtrWNN7DgOM0lnMBImZV5HJYNlbW4wc3PPC
 fZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072065; x=1769676865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4em9HFT8RiAVaymkWIv9NOLymMvMiJwbOm2R6tyPSjM=;
 b=H2nMZAQy45oaCr9ORBM/KzcR66Xakq7PScVPyH0IosAAlNHjQ5Kddjz/liTiQh2LEC
 Uwk+FBogntH2tS/KTE0woNWhBUlKvN9W+3DdrS4wZI6eFjzDYL9GwSA/6zLlmj+hLG8C
 9XLSmpuifLKIDOwlSwJer4tGbUcEnZZkcwBvDcV6tpZUI3+uD0Y4Umky15gQadgWTZV6
 zITIzAemGN+sDxtp69OLtHSKMPwFWDjDyhVAAIDnLrO2Cu9X3/7jehpdjdTKPVKKJKRg
 y/gQAi0WsW4epxeupayWWhWRNZkn5Xa1wxvzUSmqRwgcsPmX6j85U0KlzE+Qac+i7Xj4
 LDUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4IBzKPlHDfrlHqzWqcpiSu5f179GPmyfj0OQ+4hnIUEG2BtaZH+7NzEr5Stzc4DfGod4=@lists.linux.it
X-Gm-Message-State: AOJu0YwdZKazQfYkujGxrBqeA29i4TdfGZcj63a4wPIdVm+3VCfnEQvv
 1UzakE7qI3LNoov/VXWvNDjDrB4jrOQ4xUVs+QqHPTutU+kxx2xbv5hemETLxGziCA==
X-Gm-Gg: AZuq6aLXHu1h1Lj3W2ErphLl1fbGUOMpFxNck2l+ZVz8DEuwqHBIvYY5nin6YjO0PoU
 /0ehw8Bd4oHKgrU9JmLJEtCe3g//ZmP7l9ba1RGYxpnmE405yeRm85G/XoAVZPQ8GsncArXQKIt
 ssdeO5xJPgiImnG5bvbclexuSdmtzYIhNvfXgP58KdpOK0HCNUwN6WtWApldgizyeMlfkEmqp+K
 z9p4dmHjm+MAmKMN5N8p4tIb1jMgzLaNmDZ8hBdFGrEPZ/DJF0fxKGcKh/5aYbnRu0Rf7vOWRby
 pE4KSuk0b7/Suw6bqtSP8ZMMTwYPHj68NcT/Kt93XzA94CGj/DW9B4pVEI9NUBp5C+gUAH3Vv/T
 Xfck2v40+b6vDSPyBHs4Be+qiAJC7kWvpBwSznX0dl+zKK4TUflIJrVN22ZBCMQrYf/HgS8W9/Q
 bXgVR/SAWqpB9rnm3dEmKYWpJ9DTl0
X-Received: by 2002:a05:6000:2086:b0:432:5d73:79a1 with SMTP id
 ffacd0b85a97d-43569bd6b82mr28168724f8f.55.1769072065230; 
 Thu, 22 Jan 2026 00:54:25 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356999810bsm43069081f8f.40.2026.01.22.00.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 00:54:24 -0800 (PST)
Date: Thu, 22 Jan 2026 08:54:23 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aXHlvyaoa5CIIh3f@autotest-wegao.qe.prg2.suse.org>
References: <20251101012320.24972-1-wegao@suse.com>
 <20251113015242.799-1-wegao@suse.com>
 <20251113015242.799-2-wegao@suse.com>
 <CAEemH2ckPaOroqTW5q42AqT6=PO1N=6kbpKa2kej=kP8+S36ag@mail.gmail.com>
 <20260122080204.GA47888@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122080204.GA47888@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] tst_filesystems01.c: Add test for
 .filesystems
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jan 22, 2026 at 09:02:04AM +0100, Petr Vorel wrote:
> Hi all,
> 
> > > +       .needs_cmds = (const char *[]) {
> > > +               "tune2fs",
> > > +               "dumpe2fs",
> > > +               NULL
> > > +       },
> 
> > We need to adjust 'char*[]' to new 'struct tst_cmd[]' since commit 39a284442.
> 
> Good point, Li. Wei, will you send v5?
Thansk Li, Petr
Will sent it.
> 
> Also whole patchset LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
