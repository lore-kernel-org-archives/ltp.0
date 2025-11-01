Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26794CCF9F0
	for <ltp@archiver.kernel.org>; Sat,  1 Nov 2025 08:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761986872; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zbK/Q8aT/vogNL4AKxHny/U0ulH+LL9uPIrTCVL/8LQ=;
 b=WUSqDMv+vfXZyLDGOGp5iQvRWzSZ2JkU/tVIp+eO92HTbhZM4hS/Z59DO7qugPcVWmGWw
 BCWW/ifJqPCnr74itM9UcaDVCjXB8u6EaFMf8dDmkzGRhxam13FOFsrWuOLe+5mGku7Dn7K
 hmynnGfKT9KxpU/T1cF2yJEmmikkRp8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB78B3CD77F
	for <ltp@archiver.kernel.org>; Sat,  1 Nov 2025 09:47:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 865DB3CD1A3
 for <ltp@lists.linux.it>; Sat,  1 Nov 2025 09:47:31 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2C0220034F
 for <ltp@lists.linux.it>; Sat,  1 Nov 2025 09:47:30 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63c523864caso6339669a12.1
 for <ltp@lists.linux.it>; Sat, 01 Nov 2025 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761986850; x=1762591650; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AThthSlH1b00SrG2OffH7qinYp1oyRSr0Mhqi/ZDdg0=;
 b=POnNjeGTX0D89ux1e4nQ+LA5rZP5/syYRYtBnBep8wMrcE4xmxyHHNqi07K4F2Gf7s
 aAs9Hud6X7DDeUGgGFLBSjipEXfsZ6JX2i5cijrrlBQGEllAzxWcUac8koQ/2EC1C+J9
 d6KPLwlKa9n0mEl3U2LyUdNqxyRaRCWtPlG2BPwN3lQjKLb3lnodNnEl+5NkVsYi/mak
 DSYvYBTdhYOOMbOjGDgSvtdOMxWwYkM12MmN1MPxpWJV8EhU27cyvG9OGtntPfv4mRbA
 gzUAvcCbTSKEVK/364W4BqKdOlQMD/vplxHmW0IQclXeuRqm6cLywgdxHV2crxeeKguH
 CVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761986850; x=1762591650;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AThthSlH1b00SrG2OffH7qinYp1oyRSr0Mhqi/ZDdg0=;
 b=KgdnQ6uK9Dg22xgn03waPi3Vlay7DIk1b8tGShwYeVOd3OpwDJ5waE979v+ftFzt86
 h7HW0xC2dao4qttlhTWMAJ1m1VeQ0viQ0RR9b7urg+EtmwoHJCE2lYOoYixgTmk6O5v0
 PN02PhkUtpvppN3qsEa2MkRV2XRRvp2vgkyF9WKtAyXLt6m3g7SsRo8cpErN48y2HtdZ
 mDz3zqFleS4ROqm7lPduetYVp+Y61yDFJI0zZAgh/YRw2uzZy0NU2bAuD6LrK6Cogal7
 u8dRJFRKbayxa6Svr2gtpqhPqOntjv1MfDB4h0MU7viqUXxoGsYe6guHkLsdBh5TrTan
 zIMw==
X-Gm-Message-State: AOJu0YyAKnTXl49OmszOx9uLUzcUAMNkZJgz+Ej1l0v8+miNG/2ticXB
 vdqqH9zck48KPuIE0JYjSDqe6xcil8IBYzy4py0/XiPsMG6+n9z9XUAgh2hKh+IGz6nH/0eZ3L2
 lZsQ=
X-Gm-Gg: ASbGncut6xS+pqQVfi42TdF4hRsM5KCfvGepEInXt7pC2R7e2tmU0poGSNyugPeWCw3
 rqHmmNaSp+fcmqK1W1PJd7Bdpunbp5FahRqDSDvDMVp/1WDhEzyYXyFYDtqnqidOJAXL+UFvc1o
 GDzqDDA9Zniq5Yl4hcY1A77CasETEMt3388om4Qkw5oYnILDVId1uiHeBTUSkgdnSpyJxPpPDje
 QyraQoaDvDJpI9+WjBExXO13yGx3dYj716Zv6oSPQhq8nh3KIlxwh7YDOLES9ut+LEZGlnZ178v
 xuYqNRFabk3TmR0G1ABHtoejLHtFGX3ve20OfqU9yzxv7JROLRvTGCLrIK9Bk7m5aP7284ovstB
 7jh6h5vwyWdEcUvEUw47ncbFHQ5otZKujBtm2lOlIMG+CM2pORAXuUmhQKwqWvvMBIqglSLiTQS
 17FoXJUqsea5AVm+zFfIxfsjzN5MPe
X-Google-Smtp-Source: AGHT+IGWts3Qe0HnttM1noxjK0kO3AsJ1piTJVlc9gTZNlArXMChePcAe4WbJImr7j58sUgJ9TQqSw==
X-Received: by 2002:a17:907:94ca:b0:b55:e023:5e79 with SMTP id
 a640c23a62f3a-b70706200acmr640296566b.51.1761986850199; 
 Sat, 01 Nov 2025 01:47:30 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7077d05d42sm417750266b.73.2025.11.01.01.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Nov 2025 01:47:29 -0700 (PDT)
Date: Sat, 1 Nov 2025 08:47:28 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aQXJIPX8M8aKqL0l@autotest-wegao.qe.prg2.suse.org>
References: <20250827230301.32614-1-wegao@suse.com>
 <20251015031540.2120-1-wegao@suse.com>
 <20251016133203.GA284465@pevik> <aPH1a43lTn_CKnH1@localhost>
 <20251030193952.GA763610@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251030193952.GA763610@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mremap07.c: New case check mremap with
 MREMAP_DONTUNMAP
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

On Thu, Oct 30, 2025 at 08:39:52PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > > And please use #ifdef.
> > When MREMAP_DONTUNMAP can not be found config.h will contain:
> > #define HAVE_DECL_MREMAP_DONTUNMAP 0
> 
> > So i suppose we should use #if instead of #ifdef otherwise compile issue
> > will happen on old platform.
> 
> Indeed declarations are really defined (instead of commented out undef).
> I'm sorry for a wrong hint.
No worry at all, thanks for confirming the correct way. That's help :) 
> 
> Kind regards,
> Petr
> 
> > If you agree then i will prepare new patch.
> > Thanks.
> 
> > > Kind regards,
> > > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
