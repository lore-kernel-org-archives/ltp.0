Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA09DC5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748954220; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IEjBuXxGkOFWlAkp4r2/CzVOUA2Cipse36/vb0ruqMc=;
 b=nhDn/ZBNwQOQwwrPwr3E80cR53ft2ShwvcmwOaQm4L9eZe4FJlgPG0P2O8RFyi0uhf6Vj
 nU7sPk7WJQHcEr8L82gT0j4Sd8uQ9NAimZ0Gc5JLkaPZ71I2UdAxm/xcQQjyXD8zNP/DSmE
 C/iXeClv8ZxD5qr0hHO7tCgSYkRt/ug=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 073563C9FE5
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 14:37:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 540233C0546
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 14:36:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5AECF1000939
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 14:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748954196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dfly8HTKVHqDf+BR8344w6TV9H4VL6i3ErI38bka4YE=;
 b=eSs+9VeN4SQYBU9a1arK8NMyVez/xW0AKVR8EE2cWAQvuk5jY9uXInrQwApjglkJbaWBJH
 sGcOVwhludcC4cf3Gb2TioN/+bLcX20KhN1MClnSCEKEwJw1TJsrOtP2KjEW3YMcd8d+Hf
 ZUfOD+BpXrIKNyS+v+78tfKi43C68M0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-x3L_3Y0UOiS_DLboLCO_6Q-1; Tue, 03 Jun 2025 08:36:34 -0400
X-MC-Unique: x3L_3Y0UOiS_DLboLCO_6Q-1
X-Mimecast-MFC-AGG-ID: x3L_3Y0UOiS_DLboLCO_6Q_1748954194
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4e6d426b1so3249568f8f.1
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 05:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748954193; x=1749558993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dfly8HTKVHqDf+BR8344w6TV9H4VL6i3ErI38bka4YE=;
 b=bdooqdPGCgqoDlgkRu6WZuUSMZthKKWhTyadB/OxMjI19UYb3OJ05Wb3wCF1MHruVJ
 5SBm+FWHh6VTr6N+TXO5ZRXt1Ymg61E0KeXPk32OGXzGHTkCWIfm+R6arfzexo9bdN65
 QHjUqAIShcGecNJ9IaUq+dq8wrhRdNTOPU2MpMEW0Yf9dHXYMxtBKEokS2kvjdvlsDlb
 aVBtVrXQAdatTKmnTirNPe9yQKvWZXNUmTyEe7QfvH8JHss6AgfizaFw4vYT623FJZGP
 AhPuJNELEXldU8qEh7s50eWmbeFxg6N7yvvs5OhUzUHgDiM6Uey70VwEV+TJ/fRO+gg5
 amug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsnBumDjsHiC5shfQptWKUJkYIvwa7VWJI/A8TclV4sjObYEiULc88imi2pE2xyE6LjxI=@lists.linux.it
X-Gm-Message-State: AOJu0YzaEOEwOQoQfUm53JSsAO9Zi8Ia3qios80Oyd4mP9dV9vw7Eaef
 To6Pf0OzbUV46hn7zcwni1HjdF60oop8+ndUb5/IvwoCIoCazeGla1iNTzGY1/yY66lSddEUalk
 l4EJZp8OkSnRQoaWRPHpoeVxVXoy3z05wlwSAqe6blt8V5iGJ694K0cvJ+q4ck7WOffTZaBkBP1
 vHIzXzPLnuRxsgDBB7z4PxsL1dRkwIwAKqlDOxUQ==
X-Gm-Gg: ASbGnct6WaZ58tBmfB1kxXYKgvlgTIq4H0Nl+uAWRQOx32GMGPGgDz1p4FOmTMk+lq7
 iTOIrjCXu+bPL9NAoVkR33j7ycn5VJBGy7vHvTna4/0GOKWfVk+iirpR4EinknQvQpruF
X-Received: by 2002:a05:6000:2004:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a51437526emr2364801f8f.1.1748954193625; 
 Tue, 03 Jun 2025 05:36:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPlOn9Y/YquQ0Zuk3tP9OhxudXhdFNY7suMDv/cxHVwvHzReKVRVfWeQotOMa7r6vRaPopepmBUI0pzbvWpKY=
X-Received: by 2002:a05:6000:2004:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a51437526emr2364778f8f.1.1748954193301; Tue, 03 Jun 2025
 05:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250602170831.404641-1-pvorel@suse.cz>
 <aD7P6mPoJbe_CAgP@yuki.lan>
In-Reply-To: <aD7P6mPoJbe_CAgP@yuki.lan>
Date: Tue, 3 Jun 2025 14:36:16 +0200
X-Gm-Features: AX0GCFu9VnrLJh85V_aje3KLm_7pdnIuPVwue8WdnGv5duBUT2C6ufzxeMgX1wI
Message-ID: <CAASaF6yy8k=zfTxPLUETW2Q=aw0E_BtPNOGCDP7b3bumxi-OZw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: skR4QtNiaZ1ayezCEIDZZ2d-dod8hpDBYTwtdq_AY9Q_1748954194
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] configure: Fix build on kernel 6.14 headers
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

T24gVHVlLCBKdW4gMywgMjAyNSBhdCAxMjozNeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+IExldCdzIHB1c2ggdGhpcyBub3csIGl0J3Mgc2ltcGxl
IGVub3VnaCBhbmQgZml4ZXMgdGhlIENJLgoKICsxCkFja2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0
YW5jZWtAcmVkaGF0LmNvbT4KCj4KPiBSZXZpZXdlZC1ieTogQ3lyaWwgSHJ1YmlzIDxjaHJ1Ymlz
QHN1c2UuY3o+Cj4KPiAtLQo+IEN5cmlsIEhydWJpcwo+IGNocnViaXNAc3VzZS5jego+CgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
