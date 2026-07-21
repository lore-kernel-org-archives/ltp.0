Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313BFC44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 07:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784618638; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=SVgaWDJnwnU+lGYqyRXHWdcGMeI3IEBjr83BsSCPC9c=;
 b=peA/DHM4ul4tKXQbRYNuLDjWbudFEAorkzhC63qtHSywCWQhWDGOTp+aRDP7DAltCnu5k
 CY1doOeLcLY+VTf0K0Cq5j+PoTnkpwt8H6en+yYyC6yFWoAKTBgzcluIzcX4x0G6dgrteHj
 ESTST+7pS9j6aDAg4Q6jB9tMvUBLkUw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78CD43E2168
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 09:23:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4B373CEC21
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:23:38 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 275CB1400B9F
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 09:23:38 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so86048495e9.1
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 00:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784618617; x=1785223417; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6zpqkqxmhIakX+qLWMKMEqPFKC6KnSrlWAd7AMZiLrs=;
 b=V0MasTEWDPYM/4Z2deQQ58uxag96Q94l35WXZMypzfyoM+2rusWHSTHJA4/x8BvrNC
 vEWxi1JZATEDgFDr9aOzI+9/A3+88jsJT2wVtNljs7mc3lTHJCIAZrk8W6DoKVg+CXqR
 oRoj7xQf/1ppJyOs6pcOsuZJIhyigBA/+qVYI0ZAH/1x18uElzOIZP6nPgGm5aoSdb0y
 kNULtCnsmRbTh40dovZwkXpdlkQlF1JhRj/Wsz9bnN2NDyi2H9rpbAu1VXwxYhIGIyo0
 /mcwDHciThwDpwgw2TYk6kXsrKE1TYzEQdW5VoEBFTBlRM/zC+GCj6RB+n/RSSnP33JK
 MOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784618617; x=1785223417;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6zpqkqxmhIakX+qLWMKMEqPFKC6KnSrlWAd7AMZiLrs=;
 b=hUQIgY/EU7ijnWBlGlGsGgtzIuvzVMxgFxnjPfUXZHLbkH9CJxPCz3Q2qkD0U7l8/G
 7BfB1bkOro0OeSzR0F9IE0FefaDfOC1PCz6K6X10io5EAWT5ECcLQxG8Aoebkl5dxBWT
 /MU5RIQPoA1TzzAxouzjhqyPm6X2KoVQ73CQzhMr/YHptzjE5MFCQqd7uaiZFH7GXlLs
 hmJKt0ZamlVhh01xtRBJhXuopOojZPFirSS5Wy0frZqmp0XsyxYtDEyMzmjSOPL+5gF/
 DQ3dyvS/fJthegB0aZjnd98aJ1Kmym3TTu6ya9BhDeH6klnCm9QszFPM4vh0d/MbtX3y
 tI+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RomlgoSkQwWej44UsC9rSgR+fqnAgY08N7gzViOE7hu+gY0qP1t1pvZT7UNI4ImO3g8zMM=@lists.linux.it
X-Gm-Message-State: AOJu0YyO3HV1mNiQshe4Z+GIW4Ih0B+0kRky4ACJ46txSQMTiGbqk/2l
 PE8q4xTg1bZa6nrKKfuonWg342dfStWSiw4fpLotDiW/Oquxp84xzc1asU0qV/KJTGc=
X-Gm-Gg: AfdE7cm6YOIF+Q98d7Fvf7Jr8lw+1iYVVZyHwjNdC+8zTBPzTnUAIubS2yWJgv1IgpX
 II+lJj20OnDcv9FrZgGGrj7dE41/aofFoeyHQd7DPZ/aVsFl41FcLkJziKvR42gjfGJ5eGq2HEP
 BmTnuQrmU2AHOAMoIaU/hm/fi71hFSWjK651s5rIDyieclt+ADRseJgBpwYtRk4EMVgu3ISiMbg
 co070j7y73yymzzVJBOMdiiQsvO8m+k4QX6h3F3BmOTzw5GuRDP8kp2B8AjonRQJ+GzDH2Fu5/V
 oJhRTT5A8E+qdO6m/nDwbFcJZHgDu3q82qgtA3EcUT1ry04+ORnU5v/katJBMP0SwmLi8HHDewH
 vHIDwNwFyKSnAbvfBYva7iC8S98AGY3rG2bdXuftASaLXAD0RTg2gGUSecLlcCtpuZaA+lX67uX
 NOPKIZ+rIyrL2q5xglTV3260/B6g==
X-Received: by 2002:a05:600c:8b35:b0:495:6713:9a40 with SMTP id
 5b1f17b1804b1-4956713a1damr10886375e9.18.1784618617476; 
 Tue, 21 Jul 2026 00:23:37 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e51986sm41487301f8f.11.2026.07.21.00.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 00:23:37 -0700 (PDT)
Message-ID: <6a5f1e79.9b582779.3dac65.e696@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <al4_WWeLFMSvL0tS@yuki.lan>
Date: Tue, 21 Jul 2026 07:23:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_kconfig: add module mappings for
 ingress/matchall/pedit
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

Hi Cyril,

> > diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> > index 44eacc7c2989a5af3347b8f7ed16393fde0122a6..277ac606895046e072cf8f86076ecf7d79f9b1e6 100644
> > --- a/lib/tst_kconfig.c
> > +++ b/lib/tst_kconfig.c
> > @@ -162,6 +162,9 @@ static struct config_module_map {
> >  	{"CONFIG_CAN_RAW", "can-raw"},
> >  	{"CONFIG_CAN_BCM", "can-bcm"},
> >  	{"CONFIG_IP_SCTP", "sctp"},
> > +	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
> > +	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
> > +	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> >  	{}
> >  };
> 
> This is still missing the additions to the CONFIG -> module map.

That's achieved in the just commented code :-) feel free to add RB tag,
I will merge the patch then.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
