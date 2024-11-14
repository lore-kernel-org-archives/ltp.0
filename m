Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9B1D637CF
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731549356; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5Nwyr3ITUIixLNdXFZhbb/spDXiVqlEfZwnjHrWy7GM=;
 b=kDSiz7+0GmPg/5BIHcTujKR84RFZbydbjLPNMm6FEzulApy9xb9Xcz36SdRWl+ify+6+i
 3cS+dDDdp1DvFZjbMK7wal+B3jgfxLNzywqFSgH+0g9eWEv0nZ5iEEcwINmQa99pdojUAv7
 4NXGspppNZ7VpfCFd7Cc8cEgW0p43q0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF5F23D6AD0
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 02:55:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E22C3D6AC7
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 02:55:36 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D7CA648F76
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 02:55:35 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso1090225e9.3
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 17:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731549335; x=1732154135; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jbzzY6BVzUfw4O4rsUyvX8QWXxPnn9ZLjZ8I/DlRVKo=;
 b=N2rGDDDClvY+dgosOQKYnKXxeVeDPJoJ0JRcWEY7qhUcF2KqynjCrtBN1Lp96K4rBa
 7OI9Tj5hU0fdxphZ1uqxZmcld8mbpZ/GorF4hRwRfGguwF5XfE+bq3c1OCqqY36JnYIY
 X8sckzIMPBijyYL8s2kNxpFSsjEB7quL7zce1SXMxPNhQSkmW6N19+7/FlvTVBw0V4c+
 NRqCSXS6PBsJOQ+/TR/rQIjCpT7oK8VynMsT9fLsze1P3gSES1KtWhu7RF8OUnAdu+TL
 9P9EwWhGhVkEngLROZ3yqhi4PhbVK9OuNsRX1m5odHqA+1W50Axb1eSivPkEPFRUK2ml
 B+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731549335; x=1732154135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbzzY6BVzUfw4O4rsUyvX8QWXxPnn9ZLjZ8I/DlRVKo=;
 b=VXuzQR8Vt4TnkXw1Pgj6uNo+Y1CCLvN7T8aGJVue7ljuosBDvnIS3Ry+Sz29wriDC9
 8V8OtY5ZyZNb7ZTjY+TPMh6ki8t3OGpjeDmbsx1VWkvmFyhRkRLIXRolQCz3X3qJrYZi
 1gmGBXNqkX51CS+5Zp6NUYjMldOovVJkhXpEjljZ48G9vmaij/S0FGJTWnWWdyY4sp8m
 oSzS3FOJ3ZRo72cOLEzFESuv4k0EhHF7bQwjHt1/ukNOBA+szBV2fPZSXY89QoHLiL7M
 IJxarbbDQvDXQX1WfExOT6mntR60e4Ale76bjCRNIHLm8jq9KxV4KZVHrdbPbspNX8Fj
 /Y7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXhL3TPGZYpyPg9dckyD6THwoIcsnS4KvfTeMTe0NzYM6jKguUvRWMlw4NON1PaQAgaS0=@lists.linux.it
X-Gm-Message-State: AOJu0YzxphZEjpg2SW+Logc+8DBw9CXu7lLYKlnE0mR5c1OhcH+lW57u
 w/ZX0IYIq2omAtsb8n9F9f6tqEPvo22/svb9kiiU1+4PgAYf9+EQ75w/RWcv1Q==
X-Google-Smtp-Source: AGHT+IH5iWIIGwsr0cbJh+F4ik+u+6mPx5JJvxIKYhja7OmUYxMAQirYc5P36vYrygPp4SkOD/Xr6w==
X-Received: by 2002:a05:6000:460b:b0:381:cffc:d40b with SMTP id
 ffacd0b85a97d-3820df7aea0mr3756773f8f.39.1731549334868; 
 Wed, 13 Nov 2024 17:55:34 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d2a6f9sm95625ad.250.2024.11.13.17.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 17:55:34 -0800 (PST)
Date: Wed, 13 Nov 2024 20:55:30 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZzVYkmvbuc+Qfgp7@wegao>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-1-e293a8d99cf6@suse.com> <ZzMRKZdtyIbsy0cN@wegao>
 <20241113231156.GA306618@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241113231156.GA306618@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] Add fallback definitions of LSM syscalls
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

On Thu, Nov 14, 2024 at 12:11:56AM +0100, Petr Vorel wrote:
> Hi all,
> 
> ...
> > > +#ifdef HAVE_LINUX_LSM_H
> > > +#include <linux/lsm.h>
> > > +#endif
> > I guess s/#endif/#else ?
> 
> IMHO this is correct. This guards just <linux/lsm.h> (added in 6.7).
> All other fallback definitions are guarded by other checks, because UAPI headers
> evolve over time, thus it would not help to guard all fallback definitions just
> by HAVE_LINUX_LSM_H. Check other lapi headers, vast majority of those who
> include header add fallback definitions will do it this way.
Thanks for clarification!
> 
> Kind regards,
> Petr
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
