Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639D8C77B7F
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750758934; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NoN/6dhZ7Kdl0lm88E3drbUxXLM8yLN5E8zltm1dw/M=;
 b=lSmTMzu0vk40gRZPhQQcEWLzwgwHn8Z7KlU3OX2ITlF+kVWWOMv8e8zK3RDe8ZXo2LlHB
 wHcbmDDnD5aSAT+FTUcmXN143pOOkBKD0ybjplxdEpDrm35GLiZGsfMPjDczNye8qWXYtTk
 tbAwuO4nCRZpdvy+lOCKHhMsbbzDJCM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF9CE3CCAAE
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 11:55:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C2603CB863
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 11:55:12 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8333C1000A62
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 11:55:11 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so4365558f8f.2
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 02:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750758911; x=1751363711; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BhMzJ6mL6N2MK/Vp3r9BHZc8o06AaDxjnnWo8I8rXcw=;
 b=awfcoEFlMni+07PVUuRjf4eXKda8nEv1d56rfuduHiFwmN01NoTeAZbYD0lb0Rl3UC
 5kYVYWgcoZTmUh1QHcJjrgT/qrSVVX11EreKUK1S6TEYYgUf+xGzsNfwO6YasdXJwCEB
 upRnN5wl6OapavIND0NDi4wWnx1Lo3dStvMlcKo/911uQMOb9V4Dj19VFoP0zWVqa1Z3
 HnzdGzLD46ezpijmnohE+lkBPkHU4uRwusHujAcRZSgG8MMiKmjnJZeY0ESqA4GPy0gw
 Zm7krz5KneOk7YDfpFMW1kdjXnJFME/mEi2mUIR/4tc5JFDrJC6W6amYgkqYAt7orFJC
 l6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750758911; x=1751363711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhMzJ6mL6N2MK/Vp3r9BHZc8o06AaDxjnnWo8I8rXcw=;
 b=vZH5uYR+xHF5354/6d6qYRANpEf5M7w7J7g3WpzzXvI07mr3qTtlKgMZVNqotnaRVd
 p9XgoAy405uDh3It5FqiThUfola6HSQJpadStxtKVI5l5rbk24f1nk9OBxM+NArUvthb
 U2w2iaXeK2DOpPIIj9Il7QrnXXRt3+fHPJ/FmAxU+NNWMKhtelvTiuu9Laeu2SlgibXf
 hpGRHKo3X85hLIQyRAZ6pyLiEvZ1qN9RH2fD+fyJ1Ggh8yWIlbLeuhrcqqassYuiv9WX
 5ugBfp1Ujhe40c9typLZvQBTnz3hAh+89DLY41uCb/bysepz0NGpUx1S8PmlCdsBiVgi
 Lq5w==
X-Gm-Message-State: AOJu0YwtOs5j9XSAUTdLuY0B0jfXf7nTreb1j8WknQYb2QfHznOznwKr
 OUCWFaA49lRr3gOiPpqG5Em94ywHMo9ZHb8+0lALsFXl/34wwwx2ICm2WIMZIhm2PwMGCxpKFoF
 Dn34=
X-Gm-Gg: ASbGncvrWHBu/hbJqQpb1w/VMZUZ4xRpVFOILGwTZdZdZQDkYXcMHY+dTiMaXZ75vSd
 YZGeXKwNFRqGKqfsb+kLrZ7D62eskr4RBLKMkEjEpCH7uZOuDsn4WRuiXBI23sO+nW+JBVydLHa
 iJ7ZGCOUoDSXSx60+GlfSmuiLwXzRdEjhB4ve2Dwwh2nV4EtOr9eQu6FMTs6Qyooq//42UqAHDR
 pLfhArbnNSy0WaV3gGCy0isFJHAkb3173tXYK+Qi6AW89l4WuWYhAwyjXimTueegL8tdDjuNXRW
 FN3TqEDqZll6cfmSSuZkcdeFxpyyco8SdhGKEfYVeHxAfVmA1YsvZUTXDzlPJyg/wP95etoL
X-Google-Smtp-Source: AGHT+IFylCcT6JhoDNnjOnU1toYv2JmjPNOw4nT2c20JRz3Y5QuwUrSWKDtj9zjuhOTr3wGJwtrQmg==
X-Received: by 2002:a5d:584d:0:b0:3a5:2694:d75f with SMTP id
 ffacd0b85a97d-3a6d1331a3fmr12595645f8f.52.1750758910827; 
 Tue, 24 Jun 2025 02:55:10 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83f029csm106633605ad.76.2025.06.24.02.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 02:55:10 -0700 (PDT)
Date: Tue, 24 Jun 2025 17:54:41 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <aFseoXtM19UYP8bp@MiWiFi-CR6608-srv>
References: <20250623140210.32347-1-liwang@redhat.com>
 <aFrxBElBT0jg6IOy@MiWiFi-CR6608-srv>
 <CAEemH2ctXX_-xs3UPu4wCikok-b7qq747wgTBoer8q6+vELzXw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ctXX_-xs3UPu4wCikok-b7qq747wgTBoer8q6+vELzXw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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

On Tue, Jun 24, 2025 at 03:52:31PM +0800, Li Wang wrote:
> Wei Gao <wegao@suse.com> wrote:
> 
> 
> > > + * @min_runtime: Optional lower bound (in seconds) applied after
> > runtime is
> > > + *           scaled by LTP_RUNTIME_MUL. If the scaled runtime is smaller
> > > + *           than this value, it will be clamped up to min_runtime.
> > > + *           This is useful for tests that require a minimum execution
> > > + *           time to gather sufficient samples or trigger events (e.g.,
> > > + *           probabilistic or fuzzy synchronization tests).
> > > + *           If not set, a default minimum of 1 second is enforced.
> > Base your logic once .min_runtime is set then .runtime value effectively
> > becomes irrelevant.
> > So i guess we need mention it in above description?
> >
> 
> Yes, combined with Martin's comment, we should at least ensure that
> .runtime is not overwritten when it exists.
> 
> +       if (tst_test->min_runtime && !tst_test->runtime)
> +               tst_test->runtime = tst_test->min_runtime;
Thanks for clarification. I think above logic is better.
> 
> 
> Also, I make the .min_runtime uses the value of .runtime (then
> remove .runtime) for those fuzzy_sync tests, that have a large
> 'pair.min_smaples' value.
> 
> But the default 1024 min_samples I still have no idea how long
> the .min_runtime needs. Maybe we can estimate and set .min_runtime
> on a slow system manually.
> 
> For others, which do not have strict requirements on execution
> time, we only need to set .runtime.
No experience on *good* value for .min_runtime.
But i guess reusing value of .runtime is the safest option.

> 
> -- 
> Regards,
> Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
