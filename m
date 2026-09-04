Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC813C79F80
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788513965; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KpuWe/DjUBiXYwWAR/Aa61OOKEm1BEfNt45XuheWyGw=;
 b=RCoNeNeEqDTMJqvOcLZrNsb1mLjS5y4JQTIBC/PRyV08YQE/oL4/Ae9amWAXdzu7oTsa1
 VJ6IC7O7071izZTa2ROD5R2XeOl6R+6o8u+tQcImyTyQv5spCP8+/dDhE7zpRl9dVvVvHoC
 xK0G8PWHWQ5srLewvwOWFAhTa3rbjTw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 491E13E974B
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:26:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02DE03E264C
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:25:45 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8760B600E4F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:25:45 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so6829475e9.3
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 02:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788513945; x=1789118745; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4U1ORGcW0dSMjBKN9dznWUUIhHP+2fpI6AgI8b/7zKU=;
 b=GYaZ0ZX0RAiLCX72GTu3zDMPRChdJHLlAod6ylj7YW/NZ4YYtzpdTHnryrMg/qG6Y1
 V+2ispGfIHThwjcXzJ2UPMo0k+ovX6bdC6B3oh+Vcf+VmNZaO6nFgR84z++ue/B46FiH
 3mcIeU/K7Czm5YbvvSE3wxyfWZt4hEkuX6pKembejytlhfgGDtHHxLkEAbi3EP2+jm8j
 ZosP5JW9FfD6P54fPo9THK43Xu9mXrQfU4N7BHLztwqS/hFbtX/s7tMnudrMbySyibdY
 evy5VVCC97NLje5pMPcAlSV74CRp7D5/AF+1eEG9l+LCn/3n48huYIKXLqx9Yuv8aXgo
 Bqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513945; x=1789118745;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4U1ORGcW0dSMjBKN9dznWUUIhHP+2fpI6AgI8b/7zKU=;
 b=VVYc6Agg6s6M/cnZ1hK1NgeNaKfKTFpe2FcXXgGiSaURVp1BayCRMwEG9Kd40NHVGv
 k9rdNA/Tcp89WQQMz0MtVCAfe+q3MMvy2yTT6NvQjJ6OCZBcxef2JfQ6GcU5511Sd67d
 FMhXB8+Rwe2KgCXAYQGuVPcI1DoOkZRoGmTz63tW0WAO8b13zERSbbWcc9TOnOucpFZN
 nNJFgO+S8t1eo3Ud95kI+2AwWevhDRVAZI4jxh+UL/uWsrTLhstvZPElBjEcocdGeFqC
 iEUBIYs50vdCVOAd3uC0xEcAH1ghHgXk9Fc0Y0rE9os8mGc9N436xMGNWr8L4I92wDt6
 JxUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdi56WucLu9vc1Xft6Rax4GoTbeyG5lzKsrau53i5vq73leruOhb6q3PzHnpQizqt5bIU=@lists.linux.it
X-Gm-Message-State: AFuF++nQwuKgWvRfUDvq36+/FWVGZs86Cxt5MkRZ2yfoQXjdyp5/gBEQ
 8w/QvyrCILHWNQOWJ8E7ks/nVGwUTQ9YEif+0Tgc7OUo2fKuj2Y/PJBhbh+11DOAeFrbXhnRsCx
 rJ40sCq1+3g==
X-Gm-Gg: AYBFou0IhLF94ugtIsmLLI24hI0Ae1n1f0OgRuQUMFUovymiHCTUi14zUxpXYvCZkXP
 DUyXRHpPTTF691bNmBz+83WqacbmSG0MxrVZrMZpo4BJXBl0hII+PlvUxbc4lmeTKLhF56W7mwF
 cS/fQCbkhxGRZ8ixeejhHV2tbfkqeAu5DH+U2uWlUcmfyXAfooQQnWjSCFEvyFUjkXhxJ7Xz4NW
 fXOJGfziYIkGT0B70+f+bYPtoPOrXf8aI0IrU3ylxfDs+TBwXE8bV/WuqNihljz99bbfjtzw7LF
 c5ntbOEr1wFAXDLfTpyHoVqG4N6p9nkXPmWMJtB5IdU+AZadRfFRxw7LdAILRq7akoQ5J/KB7VP
 LXN4VqifnDQRlUdw2autxeyqS8SdKgRZVknUM0sTx299ieHN3/kIZTIhpY4fhEtZR9whznmQqbK
 bkYmPCy/U5IW+w73GcRtXjnuSqVCIGdMvNlu7w67XYs2U46VtSKoS/wOX+bCw6Dn1ju+4TIUxAg
 5EfDBmMncj/CvQYOssz4Hk=
X-Received: by 2002:a05:600c:1d08:b0:49b:96a0:5c00 with SMTP id
 5b1f17b1804b1-49cf825168cmr51194895e9.13.1788513944896; 
 Fri, 04 Sep 2026 02:25:44 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm170895275e9.9.2026.09.04.02.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 02:25:44 -0700 (PDT)
Message-ID: <6a9a8e98.2769c8e3.41cb0.a328@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <apqNcb103ZVuzpIf@yuki.lan>
Date: Fri, 04 Sep 2026 09:25:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Check minimal supported kernel version
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

> Hi!
> > LTP does not support kernels older than 4.4, but this requirement was
> > only documented in static text without automated runtime validation.
> > 
> > Define the minimal supported kernel version in tst_kvercmp.h so that
> > the documentation fetches it dynamically and the core library aborts
> > unsupported kernels with TCONF during test setup.
> 
> Great idea, but I wouldn't tst_brk() on older kernels, I would just
> print a message that there may be failures becuase older kernels are not
> supported or tested.
> 
> LTP has been historically used for many different purposes, e.g. for
> testing BSD compatibility layout for running Linux binaries and I fear
> that hard stop on older kernel versions would break these usecases.

makes sense, I will send v2.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
