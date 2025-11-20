Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A50CF8851
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1763643961; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lC/vJ+MxU6z6NKGIYT9EC1PEESu+ZSNx8Bq7uTAifpg=;
 b=MeDSqJEO/zM0JosMHjSzCZpCCKkNM6qR9kJvJTeeLKkbAmajqlMN1MVkEdPct1GNjU4Mj
 MqDa9AceQGYlT6PpNaqVYWIuhIe0EHJ4DwYPCe6PZ3TEQHMHrdT+p5VsC6iWBA2v5nYUX1+
 7w0cLUhZEyQtAoOJXY4/QjRHVVaShI4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9149F3D00A0
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 14:06:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6F003CF7F9
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 14:05:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 24223200DB9
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 14:05:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763643938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rBIU6+V3+XVLJAF+i5oCV3PETPapw7m//o7H1JoJIu8=;
 b=MpWX+RDy1VSjEQASheBsr1Wii3VzzRwquq3xbmDjl4Yh/OPJRixJKaO3p0dsGaCZ9FfVsd
 fedPym5DZoWePTprNZFnuaCaIWR4FBn7xDgqC043vdljlLO5mfUHkbEJdhRQJNt3BpwACo
 /yIl/LZnVnnsxgC11520iqjOv76zwCA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204--B6ROmMHPNW5vTxwddsdFQ-1; Thu, 20 Nov 2025 08:05:36 -0500
X-MC-Unique: -B6ROmMHPNW5vTxwddsdFQ-1
X-Mimecast-MFC-AGG-ID: -B6ROmMHPNW5vTxwddsdFQ_1763643936
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b26bc4984bso393464785a.1
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 05:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763643936; x=1764248736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBIU6+V3+XVLJAF+i5oCV3PETPapw7m//o7H1JoJIu8=;
 b=RTSSliCAI6WT5BT6dOYk3Sk6vWJxynS8w4hSbDTTSoLw3v0OdGR5ajWDV2RDFNcLuO
 YnK2/SpqWu77iaUbj6IzQUb5avY2lqsUmWa2W7UKft7LCqClyYtL8V9qqACKcIG+gH8M
 mosQ8g4hRR9bZf9xTr/uX4pltwFMedX2gk3+P+cfcOed/Qilbdl6W6Lg2IjuXUcOOClA
 WtERvBK1albbi2Y0MR9Eqsxzqb4Kah5egE2JcnObA5nrQpL1qmhl2tGNlmMm+0C1T76L
 iuBglrO/V2t470VQ1cYj/0x2PrbokyFBmt6J3y/famxNUQkJtWS/MG8xtwHvdiiobu0F
 zS1g==
X-Gm-Message-State: AOJu0YwidpJO6pOaSRg5Uy8U2pG8zlSdSxsZUUEym/0Wu7ZNHVIxQ6NL
 dwii7gYYtMLYEGzoeS7Q9s65HB5IttgEUlQmdIQC6ajWQLA31S0HVppSWy4gsZD8DBEVvrun3jl
 PP5Upsl7Ms7MOmqIYeDeaKyHB74Km/b4tsjs3LPKF+K1bS2aFTEp4o3+OLnXKtRVKBpgJs2WVrI
 h5nw2SS8PF/wUCtAvxajpsCxrn/c8=
X-Gm-Gg: ASbGncvaYFWa5AHaBpMqEy6fKjF//02pK8gPyo2Wr68/KYW7Opxg4ZTSjnwejkq+OpN
 isoNCq3Xh5lkC4mWvtFMLOah7lPCcprHLerKnq49AlmRAnsfagvhNAdGf6/9qklgC+iT9ELd5+u
 hDiRiVvq2H8gQPfdl3WzKDy3VvFxPacQGf5QqY3Ctrv47xve+fgqxdHGR4f0YypVyB/WI=
X-Received: by 2002:a05:620a:4045:b0:8b2:a049:4ac4 with SMTP id
 af79cd13be357-8b3272feef9mr383302985a.27.1763643936031; 
 Thu, 20 Nov 2025 05:05:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpGDxTEKvsap1YD9NeT76xayc/gbvN/a/aMzTQx2hL33CPwFIzhGsd57hhf3TZ9PDT2Lhq6v6nRUOr+4B4D7A=
X-Received: by 2002:a05:620a:4045:b0:8b2:a049:4ac4 with SMTP id
 af79cd13be357-8b3272feef9mr383297085a.27.1763643935588; Thu, 20 Nov 2025
 05:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20251119185642.80816-1-sbertram@redhat.com>
 <CAEemH2dDAnvC7E0jzbpxFsZ_eNEptF5A2SP5KRA3D8K07_Yh8w@mail.gmail.com>
In-Reply-To: <CAEemH2dDAnvC7E0jzbpxFsZ_eNEptF5A2SP5KRA3D8K07_Yh8w@mail.gmail.com>
Date: Thu, 20 Nov 2025 08:05:25 -0500
X-Gm-Features: AWmQ_bmbvBJODM8n5i_Z6g2J5K20o6Q8nzShOzUp222n42Ne73873TGRqUciwHQ
Message-ID: <CAD_=S2mBHPG+uynV=RtXNvEr4BF7aFEUt7XvR6sg70A7S9EGyw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dMd5Hge9QIXET-fCA7Grs_5luCAzz2uXqK3TNkfa4NQ_1763643936
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7] Add EPERM test for clone and clone3
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

VGhhbmsgeW91IQpzdGVwaGVuCkhlL0hpcy9IaW0KCgpPbiBXZWQsIE5vdiAxOSwgMjAyNSBhdCA5
OjU34oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPgo+IEkgbWFkZSBz
b21lIG1pbm9yIGFkanVzdG1lbnRzIGFuZCBwdXNoZWQuIFRoYW5rcyEKPgo+IC0tCj4gUmVnYXJk
cywKPiBMaSBXYW5nCj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
