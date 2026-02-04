Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21BBE95396
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770211775; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=APilOLlM3V3HXTdESrt1OPzbkeCQl1d9oty2K2oLdzo=;
 b=dlyrlIiJ7iOQu9s5LEK6X38T1MQgNFArMiSfWKoBTMO3fijMFj1lvFE73WXLtfIRPh2qX
 cuhFJoPd2bm0S3PLR+g6DVTovinVmkkdMChr791UHoFzIun9Wf/hRl8jrRDbGJgaUq7tKj7
 fDrSxgWQmjRG/ScD02n+uLWkVlReMWc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C8713CE0B2
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 14:29:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDC163CCAC3
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 14:29:12 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2E77A600A33
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 14:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770211750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GtzTov/rKRImkpIHwJagM6hS5qHiKW3hWsFcj+dpues=;
 b=NQG6Vj57v+Z5q30O1IJmfQd8Vxr+voWk5jYPpmVEv/oM4Yuw5A9qbqeqEsa9Be457MIBxF
 HBj+oFogslNAThscy7UFFdt47rMsMTaJbfB9DPtJKDdKgsTx/RrmZBwn/AThP4fckdmV02
 hxOx2WPtCVMDoplhuWLHdFrGQReFkr4=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-1lxj-Eo0P7ahqrRuj_P-Ng-1; Wed, 04 Feb 2026 08:29:07 -0500
X-MC-Unique: 1lxj-Eo0P7ahqrRuj_P-Ng-1
X-Mimecast-MFC-AGG-ID: 1lxj-Eo0P7ahqrRuj_P-Ng_1770211746
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-124a95d580cso7414714c88.1
 for <ltp@lists.linux.it>; Wed, 04 Feb 2026 05:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770211746; x=1770816546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtzTov/rKRImkpIHwJagM6hS5qHiKW3hWsFcj+dpues=;
 b=otgaGQwdFUZa9oIe9un8nWmE6JaiYkXcS3d400LwIliEx2PutKrhsQ3aMuBAOXlMef
 fHS7vBoeYzTsuszsmML8hFy7rVOnP/0TtiJU8Ob+/43HoUW3puXe53VktbHzphbXA725
 BGxEIo3Lk1FcBREM3TYxK1hPuvgf3dmvZb8P0hrhNXqBEueNHny3wu+SsmsXUT+JUMAk
 +L6IRgJRp6CUsgy+DnCbhD3KhcMU4DzwEtuulyKZp1yQUKeTpQH9WTKGYEeWojVCWJ5q
 7lv7t94I6QFaUgDaWBy+kfSu1YTBMHkrWorq0V2EFxEz1j9sH5c+9R12wUNxG2kHbcRa
 HE0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6YeaDONBIWH4dSzgO4IDtusYkOG2lM8hJD6L72A3hKdcStimSzFezlMJ8UhA2wzuDuQY=@lists.linux.it
X-Gm-Message-State: AOJu0YyYT0ButwUYxWS4Y41lDqqIvmKU/0o6gYsDAvLE3u3jagzghlAa
 46Z33xhflsNRWx4oPCGvEK7hPW/zKEHNnvXXG66a6hLoE5w2U8JPRhJFxLrOmZI56vyFOfcsBwr
 KqhYrJU2+kIbh4gDGNuCNpIBxLWhGm7k/GhrSl+ZQAx2Txq5wJjWAWa5e6jJNj6p7BT0OARC57L
 cVmiZmfd1zTxbbH8aCU8b6+z/uWA0=
X-Gm-Gg: AZuq6aJzoHynCZo0Vamr2AyL2PQbAEDx2DsVqHPN7HrRQbseQy8Zd5w//Pm/SByDk+g
 BOEmx/mXEwSuUmHc5sbMv8pYUW94Um9YVuA9TEWxllNhX06lHAdTcnr+YaNPc7tEggGVyRIY6oW
 8yrPrCnPJvb7RCK3Ro+UdM5Iw1T7z1FAwREJ8OCcE7FbENwrmgXK7dbicfvWsC736rXTM=
X-Received: by 2002:a05:7022:6197:b0:11b:4351:2687 with SMTP id
 a92af1059eb24-126f477e27dmr1537046c88.17.1770211746079; 
 Wed, 04 Feb 2026 05:29:06 -0800 (PST)
X-Received: by 2002:a05:7022:6197:b0:11b:4351:2687 with SMTP id
 a92af1059eb24-126f477e27dmr1537023c88.17.1770211745636; Wed, 04 Feb 2026
 05:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20260204115339.224261-1-pvorel@suse.cz>
 <20260204115339.224261-4-pvorel@suse.cz>
 <aYNGgCJmEhv5nXYL@redhat.com> <20260204132143.GA209672@pevik>
 <aYNJTSjudAiyk459@yuki.lan>
In-Reply-To: <aYNJTSjudAiyk459@yuki.lan>
Date: Wed, 4 Feb 2026 21:28:53 +0800
X-Gm-Features: AZwV_QierPS9N2T_f9QVAv39S6JPGX3nPHS1JlBDZAy_BHaKNRlwWnIqDVHK7GQ
Message-ID: <CAEemH2e9snNF=Scyiu8co17R=LbWFoUVZNQNRpzR9rsoYNMcog@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kpd1BuPjnTWRXytfF1gCafqIkiScqqAzyBB-HLtd4hE_1770211746
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 3/4] runltp: Remove
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 Tim Bird <Tim.Bird@sony.com>, Julien Olivain <ju.o@free.fr>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBGZWIgNCwgMjAyNiBhdCA5OjI24oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IFdlIGhhdmUgL29wdC9sdHAva2lyay4gQW5kcmVhIHN1
Z2dlc3RlZCB1bmRlciA0dGggcGF0Y2ggdG8gc3ltbGluayBpdCB0bwo+IHJ1bmx0cCwKPiA+IGJ1
dCBpdCdkIGJlIGdvb2QgdG8gbW9kaWZ5IGl0IHRvIHByaW50IHdhcm5pbmcgaXQncyBub3QgcnVu
bHRwLCBidXQKPiBraXJrLiBTZWU6Cj4KPiBJIHdvdWxkIHB1dCBhIHNpbXBsZSBydW5sdHAgc2Ny
aXB0IGluIHRoZXJlIHRoYXQgd291bGQganVzdCBzYXkgdG8KPiBzd2l0Y2ggdG8ga2lyazoKPgo+
ICQgY2F0IHJ1bnRscAo+ICMvYmluL3NoCj4KPiBlY2hvICJydW5sdHAgd2FzIHJlbW92ZWQgZnJv
bSBMVFAgdXNlIGtpcmsgaW5zdGVhZCIKPgoKVGhpcyBpcyBhIGdvb2QgaWRlYSwgYmV0dGVyIHRv
IHBsdXMga2lyayBzaW1wbGUgdXNhZ2UgKG9yIHdoZXJlIHRvIGZpbmQgaXQpLgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
