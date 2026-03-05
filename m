Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CB1EFCE56
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 01:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772673763; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ymuc8uhrvYca8uC5cHIvs+c16HAcwlrpUZd5sQRwiu8=;
 b=NJqFUYiwMAxKERamVPPwheFNoPZtKGmm3skjBwJCLXGUzxq35rSuvRuJ76Lky0w+Ce2ad
 8z6cCh4sftD7d1YzqkQlvcBTwihokSrWIJvEdczTx1Q+7XnlMKJtwSRTFflLVlhJZJMw56M
 xFdaftJpu4uclSrrI52shHBg4SZZyq8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 805933CBD96
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 02:22:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BC883C5DB1
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 02:22:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D4D216002AE
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 02:22:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772673737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2pDKlqRuLyCWTYFYlFhLAg/wViYsapWLjOhPOL5H7U=;
 b=hohLdRAWVr4rr4f2PB9O0lrXxVvORKxTGd3vibL6NeBdnCdypVa44Mc4C8f6oTfSXTzL9l
 quK4Zn5abSU0ui5TQfYfd0jh5c8zoA6joOLgiE0WWcvNtKtw+qra3RKRuaay7pF6oAX+Ft
 MdvnnEkGQ/x9bsh51kJfw66PVJWHHjw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-CNaC7nvXMVauc2oaRSDZRA-1; Wed, 04 Mar 2026 20:22:16 -0500
X-MC-Unique: CNaC7nvXMVauc2oaRSDZRA-1
X-Mimecast-MFC-AGG-ID: CNaC7nvXMVauc2oaRSDZRA_1772673735
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c7385e8fa73so461792a12.3
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 17:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772673735; x=1773278535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2pDKlqRuLyCWTYFYlFhLAg/wViYsapWLjOhPOL5H7U=;
 b=O9voCviQ//iwo/HBzm6kJ7jGYumGeNrNEw0/yxT9w8Y8UQ7FjHb56iRfmfm4HaV+FS
 7+Est/DJhexC5Apq22H4Q0zml8i+ZkrdJE4+TZ/BBdtWcPO6SRcmqz41puuKatiQzd5l
 zRD2hWTNljox0yZBtzcxAt5OKy8KPSy/nSD3ah3D06MVMoFWb40o+ePxdtwRkr20cf5f
 HfNRLT02VtvL/Agwbm9GiX7HFq043UoBg4JvxQPfHPS35aGvufDPI3gmAcGn+OSApyJA
 BSMdlD5Ubb6b2//ZYHcuO2y105Og6MVV8ujCtZHuKDVwdfllG3wYoGWXJons1NQ7ivR4
 NG6A==
X-Gm-Message-State: AOJu0Yx47kO+aQ1e75Sm5ChkYXyQIvbxLbzoJUS1GeJIOBTxo18NWvIy
 qnUnKRhmkFqOX9IIZKGq/i7tHfe3f1efwA6QZYgb6A8icuCcd4/jVBUDHfu9CZK8pjasojSmna6
 tVdxFzvvbmhLBl5yHA5F2wVrozkpf+3xzm11xe1U6KZKb2QjZzmNh
X-Gm-Gg: ATEYQzy7l5yEBjG5AXEb7wHzSI9b8MArVndxM/Y2gXsINJqxdpn9WWrXgRuZLgMkgog
 +Qr5vx/OaYoQ+xZUkTCOSM3nQh7sMzKjGpP3f1kSdcgZclTfiVb5trsRjw32le6ps5SZ4qlNWsY
 BzAYbtXjCOIFxK9vWyUTCfsbBy73KzuBcZ5OPBnRL1CSJtOErpEv39rdK5bzugD2iiAXJ0wbzj7
 evpfzbAUBpWw7LiQa+8pKZTU6m4m79GWQ5CL3Fvu/HGbvB5SOz/vRhzNYSGJxD41XKX0VjZFdmW
 J6gw0oawmDNH7MVhpvRoR2kFJKQ5KX+bg+VLwHcnDPDssTzFjwFNt3feqjfl9oUY8vt0PK0NK7z
 q7myNh6F1YTXV8lWs
X-Received: by 2002:a05:6a21:6b01:b0:392:e6c3:7426 with SMTP id
 adf61e73a8af0-3982e22aee6mr3831133637.62.1772673735359; 
 Wed, 04 Mar 2026 17:22:15 -0800 (PST)
X-Received: by 2002:a05:6a21:6b01:b0:392:e6c3:7426 with SMTP id
 adf61e73a8af0-3982e22aee6mr3831109637.62.1772673734906; 
 Wed, 04 Mar 2026 17:22:14 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7389126194sm1040892a12.24.2026.03.04.17.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 17:22:14 -0800 (PST)
Date: Thu, 5 Mar 2026 09:22:11 +0800
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aajaw0f7H-iYqviI@redhat.com>
References: <20260304034034.59303-1-liwang@redhat.com>
 <69a7f940.5d0a0220.27e3ef.38eb@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <69a7f940.5d0a0220.27e3ef.38eb@mx.google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: II-3bXyI6j4Tupy9DRdz0-O037cPBJxTA1LzJIhrVl8_1772673735
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: Extend -D flag to support multiple
 debug levels
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Li Wang via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 04, 2026 at 09:19:59AM +0000, Andrea Cervesato via ltp wrote:
> > +
> > +Suppress all debug logs if no '-D' flag passed (by default behavoir).
>                                                                   ^
> 								   behavior

Hi Andrea,

Patchset pushed with the typo fixed, thanks for reviewing.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
