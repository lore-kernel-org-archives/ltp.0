Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15445FF60D0
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774947476; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=T+wF5d9XDssjOvAEaqWlpTqSu8wfLxFEEO3Gyy9Qt/o=;
 b=qKihLxaNETyEI3hkk+A0P2Ru/xBf7AEpbwbxSad/z1ITWX4U6xhTjULT8cu1QkGo0J9YL
 +OiWLzDOR9ViAsTsFAndsOtM5pIbRnGSoh/PXzzpbhu5VXdKCbPuxYPJqPPdwdZNhHdzMzh
 sqg0chBxyZsiMVqmsxEx5LplCDsaZg4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B1353E2A4E
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 10:57:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FCE03E21C6
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 10:57:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F6FB1A0106D
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 10:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774947450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQ3bClN5mR8dkwSBI7OoAIqJgHfBMK5pTnutiNeDly8=;
 b=U8d+RxaoiWea9R/jcyuuaOrgqygB/av4BjJtICZL7iymwDW9ZCs0A7OJaNX+/ZHdb+/OTj
 N65kjmFCJvX3likGzBRKVKu2NMAQO+TgyMnCA31XtROABXmQBCjmPZDnVAjKZ+p8Oz4bEM
 0/zyi4LZBCrmGWrmc8fY+DOtXLb8880=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-He3XGfTON2moxJ4iy8s5Qw-1; Tue, 31 Mar 2026 04:57:29 -0400
X-MC-Unique: He3XGfTON2moxJ4iy8s5Qw-1
X-Mimecast-MFC-AGG-ID: He3XGfTON2moxJ4iy8s5Qw_1774947448
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43b91b5dd24so2928657f8f.2
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 01:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774947447; x=1775552247;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YQ3bClN5mR8dkwSBI7OoAIqJgHfBMK5pTnutiNeDly8=;
 b=WLOb1j7FhZmEKqmzvMcT0B27J7aP6aw8nT7KmjI+hRjWh5RBh3v/sy6itvGVgVyhYV
 XOQ6+PNeKHvC/KM9ke7TkM05x8yDVnfddg58RoYt8NTiMOebA/mgqjMk+D/8NGlPNAL1
 zOYfFN/XLtkY05JfNUeryJMzN1PzfLUtwEVgpV4wQhg+OjpSECqrgVrOnnpxRLC6dTTV
 E1J4K1IQLh0swB7d6n68V+cYOS0bwSuninNbEYoVzocL+a+1vfs+hlK47kjZAnXIQgIF
 h1tSK1cFDXwDgZhg/ht5Mv2szUI/XgiVFS1D5Vs4Q6xIErfUEBI/T/L2GfkYDTXOrsOQ
 Xw2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkYVzkRxnjZVZ0DDEW/EmuKfiyMzq42eXc8IFz2/t4b/zz9OV4sZ2ZtoygYCJznmCfnkk=@lists.linux.it
X-Gm-Message-State: AOJu0Ywp8aD2vgzffHeKRovPfqkQrtKVxm9qt64UcMg3bj7srwRDiLmd
 S25oK+497u7xe7JK5N1bmc5qx4nAv9itap8hlqcp3RppNF0KXHQ97fAOLGpRmUS9kQrGKso8xsy
 egUE2KJI01XrGEoqLTeswK8LIcy8da2EIGe3tLBsPa5j/M25G8/E3jIGpUHZ/YcsTeBOcMrRsKS
 e0u1WE1pVsTZJrhm/j5cxKpC/yezA=
X-Gm-Gg: ATEYQzwr7jZcKBtBgOqpI6YQXqzxmo15Fikx2KINDq3RZNA2WaY6kvyxvzQhD9YyxJp
 BByskpSvAkMIraRujHljiM6z2k8p+AX7w58htY6blG1PIDShO0urvdeUpVa3PEgQAE9aT9+TIu3
 yCVF5bzWN09Z92cDsFpN2xoevej3EB0HaWm2/96X9iQ9/A0ck1dKmEScj0HjAdYBemRcIorV6rM
 byV
X-Received: by 2002:a05:6000:2c10:b0:43b:4960:60f2 with SMTP id
 ffacd0b85a97d-43b9ea766f6mr27171453f8f.47.1774947447526; 
 Tue, 31 Mar 2026 01:57:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2c10:b0:43b:4960:60f2 with SMTP id
 ffacd0b85a97d-43b9ea766f6mr27171412f8f.47.1774947447036; Tue, 31 Mar 2026
 01:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260331072051.GA5254@pevik>
In-Reply-To: <20260331072051.GA5254@pevik>
Date: Tue, 31 Mar 2026 10:57:10 +0200
X-Gm-Features: AQROBzDEuFVJ4Gw0snwGkNGTPmUyKq77KAs_cRHu0XoKpFknxSQfyu3AWb2Ism0
Message-ID: <CAASaF6xPzR3KWCd=aUTPWVgzfyi1SkftgQ8HG_kvphY2fWMe_g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dEENWjZpyMYwa42_yAzw022NRxzaP37cKPaa8mGSHUU_1774947448
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] linux-git: using whole sha1 hash
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMzEsIDIwMjYgYXQgOToyMeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+IGFueXRoaW5nIGFnYWluc3Qgc3RhcnRpbmcgdG8g
dXNlIHdob2xlIHNoYTEgaGFzaCBpbiBsaW51eC1naXQgdGFnPyBpLmUuIDQwIGNoYXJzLgo+IEl0
IGNhbiBiZSBzaG9ydGVuIGJ5IHRoZSBkb2MvY29uZi5weSBzY3JpcHQgKHVzZSB3aG9sZSBoYXNo
IGZvciBVUkwsIGJ1dCBzaG9ydGVuCj4gdGhlIHZpc2libGUgcGFydCBvZiA8YT4gdGFnKS4KCklu
IG1ldGRhdGEsIGNvbW1pdCBtZXNzYWdlcyBvciBldmVyeXdoZXJlPwoKPgo+IFdlIG5vcm1hbGx5
IHVzZSBvbmx5IDEyIGNoYXJzIDA5MWQwZDU1YjI4NiwgYnV0IHNvbWUgdXNlcnMgZHVyaW5nIHJl
d3JpdGUgdXNlZAo+IFsxXSByZWFsbHkgc21hbGwgaGFzaCAoNyBjaGFycykgZnJvbSBvcmlnaW5h
bCB0ZXN0Lgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+IFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sdHAvMjAyNjAzMzEwMTU1MzguNTMzMjYtMS1sdWZlaUB1bmlvbnRlY2guY29tLwo+
CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
