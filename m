Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AF5E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 09:37:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77CDC3F03FA
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 10:37:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C15D3F03C1
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 10:37:09 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EC1E9648709
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 10:37:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735897027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXSiD21+PTsuaMBMiqWUgNYE6RHy5lfLdMG49TIXGUw=;
 b=X6kB8+3yg+e61tEvvUFowcVcc+1e51LjodroY1Ms2ycERgSrXi+OVTlPSDyGK0plADAZO1
 NmQA9dItKIUyASfqeiSqAiDJzSGL8JpA9oRaA89+HqQopSwZyjdqttN/g0yJXm145PUX98
 SzIHvHZtzpH1Kx9QrJrVhcGBL5rBP9Y=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-ZhpMkAgGNhyUeYBdlAPVPw-1; Fri, 03 Jan 2025 04:37:05 -0500
X-MC-Unique: ZhpMkAgGNhyUeYBdlAPVPw-1
X-Mimecast-MFC-AGG-ID: ZhpMkAgGNhyUeYBdlAPVPw
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee9f66cb12so17124573a91.1
 for <ltp@lists.linux.it>; Fri, 03 Jan 2025 01:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735897024; x=1736501824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZXSiD21+PTsuaMBMiqWUgNYE6RHy5lfLdMG49TIXGUw=;
 b=tNlcFT2XEnYNcIcfzjRO854zadiINDsnJdYlEUy9jDUuF2UwjhY5SZfrWVNLsDztls
 iFZ+OFi9qrvx+cBphZE7JDo3Zs1ODDcmy+Ol5n34CstP8r8ihCDpkaoBK/ZQxn8RmBiQ
 9HJjkIGjAOZBzc7gMzfjWlJ3KTSPAnY4PmbnxBo6EZBo6rjKcnYRVIziEGXmQkbdPLpi
 TvrkPaxlMO5sT2It6S+6pbzVOiRyNYfrUDEFAQBs+SkGYM7TzAHggmq45egDYwtUIXVC
 QD4D4eZ+lBvItxKQvnzC5K/jqJnsUC72SJs02QjXmLsoZJnvUO6O1AcLsg3Mg5HAgfNS
 sElA==
X-Gm-Message-State: AOJu0YwawLsUdW24NRJB1xzPnaYn9ROzGHqIV7Bc/ghXYwCDnTmwBpj8
 +DhDhgoCjIsG8Bsfh3LyVEraECRaqvX4Mh3UGYmdvEgkfIQIBs8n2m9lpDUXxdD3KpIklY7FK66
 yOcK0Q2+zfGts5VgSYujlHyYjlBWbzSTMtabuQozJhvJpcXFbSinD7HRhEaXfDPtmjlRbbmJTME
 dq0taUY07jwJ1YbjHITadCt8E=
X-Gm-Gg: ASbGncuegnakTJUsKTSROl4yycMzCpIaEDAV1ICwNgAOT0D5efag045cAGCI8WZnW/T
 ntlqzJZF/nOr874hurCMhgvIUuWdlG4pl6lM9rQs=
X-Received: by 2002:a17:90b:2745:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2f452ec6d2amr74220814a91.29.1735897024513; 
 Fri, 03 Jan 2025 01:37:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRKDkToOp24kvMbbCcOxkmND/8dySApsvcitrr8QOz+9XDuowcacbn35D6ObCcROvjmtCsPPBNCerXttsZ+ps=
X-Received: by 2002:a17:90b:2745:b0:2ee:c5ea:bd91 with SMTP id
 98e67ed59e1d1-2f452ec6d2amr74220796a91.29.1735897024208; Fri, 03 Jan 2025
 01:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20241126085808.14616-1-liwang@redhat.com>
 <20250102145903.GE94207@pevik>
 <CAEemH2dNVsJ4QhdNkQ=d8hPpEqvCTPGXQm6stCjfg3uVQkwx7A@mail.gmail.com>
 <20250103085040.GA188652@pevik>
In-Reply-To: <20250103085040.GA188652@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Jan 2025 17:36:52 +0800
Message-ID: <CAEemH2dGe210G3P3cJNZJmJw7JhJbxu0gJdUGxe7s8Hd-5cYRQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wY1xQw9FwmALYVoyWIRVYf_w_H3lteF4j3xR9AmaA7s_1735897024
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] process_madvise01: running the test in mem_cg
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKYW4gMywgMjAyNSBhdCA0OjUw4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+IC4uLgo+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3LCBh
ZnRlciByZWFkaW5nIHRoZSBwYXRjaCBzdW1tYXJ5IEkgZ3Vlc3MgaXQKPiA+IHN0aWxsIG1ha2Vz
IHNlbnNlIHRvIGFwcGx5IGl0LCBzaW5jZSBNQURWX1BBR0VPVVQgaXMgaW5kZWVkIG5vdAo+ID4g
YSBtYW5kYXRvcnkgb3B0aW9uIGFuZCBzdGlsbCBtYXkgaWdub3JlZCBieSBrZXJuZWwgaW4gdGhl
IHRlc3QuCj4KPiBTdXJlLCBwbGVhc2UgZ28gYWhlYWQgYW5kIG1lcmdlIHRoZSBwYXRjaHNldC4K
PgoKTWVyZ2VkLCB0aGFua3MhCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
