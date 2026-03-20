Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FC91098782
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 13:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774013672; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=EiTauMj1X3ig7qeGIiSOojFLG4suh0c7w3+S5rHiLCw=;
 b=dJ6x5H34ll667UnZbuFWAc6SBWUCxM3K12NAbWf3dvqqg05G84UtdlejEA10RUydt3dFC
 n5V/x/1/2fFV9TUFSL1gA9UvAfg1iWk09wtjP968P9dkUzVbBqEWWFx4dads84ix7ccnHwU
 ldikhp0FbObIA4bg1uaiOj8HI06Fxr4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFFC23E55B9
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 14:34:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 051A53C0322
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 14:34:09 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 37E271400BD9
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 14:34:08 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso14796475e9.2
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774013647; x=1774618447; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ihQPuyLxh+uT37xJjVrfLzidA1yNNi0sMltFXpj2zp8=;
 b=AdAPWYhwlR3z9qVYvtHWx+KFc/YoAk8CiPbtXmfJvDgzLMBSYv+TG6b6qwa3HgTlTv
 5zNQwQkQYx/NT1ckNF1iZ7ku2rD+RmPo36Di1LbTe9yMddHCUwoLqIjVS+jUzhw0LGXf
 3wAqILoP73ZaF1nPSNTieBRNOfRU/DcxAGyrZANjjfe503PhaQrv3ziWhEECM/NEBWJv
 WVxLucBMk335OVtzxJOJYNEzRzD0ZEi8E2YlevdSFG99Qs/s7eoSjziCJH5WMFXnoK+s
 K9EY4CbdHCiLK6LsNMVsgA821peqQj1pp6GUD8toFaBkfgSbimz2LTpd4W0fqkaLekXj
 G7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774013647; x=1774618447;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihQPuyLxh+uT37xJjVrfLzidA1yNNi0sMltFXpj2zp8=;
 b=WfstAVnUd+ISEZsMveiDLF1ljcc+OAOyryRE0iM8bQfvoeLkmIHm4NHgnjGEHgTmG0
 LKQeBbCH1OWQQpvZsLdYqfbRyxa9audnipAdHdvqQzqkE19Qh/eOUhlbJBlLNauNeOgT
 WS1ITHqUE3kE8Z/Hf5rCHxhOiE7nBM+2C2VHAyq3rCy/wvJ6R3DTqT5ZWuaRlBrn7CM2
 7ucFYWP1HOW3C1nv9K8HnDIeeu7QU/Kx0dz5irSXNqQXkyjNxsOgbPkOcnODXcTMm6su
 t112nT83Ik0+6SordL92QWBOQm27Tc5BgRVvLu2fARfg6pugyB14JAib9dso+bw9l+Zh
 YMjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYl+g3ks0rcIde9bzdUaZS1z2OtRaYjoQdsn6bEyWuR8q2O9wpaq1Y3pxN4fVIXY6RfHI=@lists.linux.it
X-Gm-Message-State: AOJu0YyLQ6yQB9JB4IqEIAFKltt2MjaNWKgC7ThEWu3RA5ZIwiRJ/P76
 T0k38QCOev8oFvynExQeKaGZsv2yGaXu39TpPDRRz74JdH86+gNk+chVBlWXhLY44F4aD3voUrZ
 RKCl9Iw0=
X-Gm-Gg: ATEYQzz23HvjhdFZmObxA+BrucGpKiIcdXf1zsT4bQ3Rv1GoFl+k5lP4Rc/onUvZaEG
 1mcSPgD+5xeYccq7Q5SQFUpnt2+Zxwrmol/uqDNgESH2qJPhgCpiVtAGfksqO8++Z2eaOk9if6I
 vWOCmzZbrpdplPfJ8F/FpmoVnuGYU/aDnpNvngbo6TiYYryS9Cktvy4mxtRKOlMXHcjvSboBD/h
 aLadIx29XLZiJQvJMT3eT2xs2ffZR/BoJReqCTRM9RduhsAs880dwLObr+fto9MoiieFfErYyuc
 VEnYAY9DhGVBlYFk6g8Am5tPM9aQatcW6flo5ZbwsFsifrNihzRBnvxSO0PfKjHtH6xW2rEmwCV
 d3MhYzGO3dGMSBg1uezgTV0NXnLt8oRsZ4PD5Nb2bdRJuDpg6CvauwZjH+pVb8BEp0NfIuI4dXV
 Ym4cvVGN6scFiiKZ+DzVp33l3WEeTaB6QhDmwcILZOTyZQmI4=
X-Received: by 2002:a05:600c:c167:b0:486:fab9:a578 with SMTP id
 5b1f17b1804b1-486fedc3843mr45817385e9.11.1774013647385; 
 Fri, 20 Mar 2026 06:34:07 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644ae619sm7281334f8f.5.2026.03.20.06.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:34:06 -0700 (PDT)
Message-ID: <69bd4cce.df0a0220.1f9b07.885e@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ab0i-cmCvbuJc8dv@yuki.lan>
Date: Fri, 20 Mar 2026 13:34:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] Add listns fallback header
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

Hi!

> Hi!
> > +static inline int listns(struct listns_req *req, uint64_t *ns_ids,
> > +			 size_t nr_ns_ids, unsigned int flags)
> > +{
> > +	return tst_syscall(__NR_listns, req, ns_ids, nr_ns_ids, flags);
> > +}
> 
> Do we need a configure check in a case that glibc happens to eventually
> add listns() syscall?
> 

Does it make sense at this stage?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
