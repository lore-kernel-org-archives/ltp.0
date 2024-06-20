Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6444EC2BA1A
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 01:39:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E6C63D0E05
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 03:39:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3CA93CE037
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 03:39:12 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D63AB201DB8
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 03:39:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718847550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=biVTorIvY0HvaUcyLBcKcMgmj/wiGw2psHKUIihKb+I=;
 b=ZgO+PEiK6F3lQsIaNyYXKQkRbOTY7jQNjnuHubIjnvss+tJjLnjGes3d8PBfqCkk6Kz900
 ReuI6pfJiOVRiw+EG0DTYgLXK7gDApoHvT4i0eR6VHs1tgtBhUBPW5PTTdRzZ2LA1RdfRk
 rKi7CFv97ICcuEcGPS+JJwiUgUkwdNg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-f5DCYk19PB2jjJ5VX5-w1Q-1; Wed, 19 Jun 2024 21:39:07 -0400
X-MC-Unique: f5DCYk19PB2jjJ5VX5-w1Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c7e3d54957so325285a91.3
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 18:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718847547; x=1719452347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=biVTorIvY0HvaUcyLBcKcMgmj/wiGw2psHKUIihKb+I=;
 b=Hxqpb224/PTOXgL00T+trkycF95ZqAH1Dlcc8Fyvwwp2/CTPWQuhCt9O0hHLy4LZl+
 tEK4HegLSzXUdoU89Z1bFzAdg28FRFppkglM1YHYR51+7rdKYXTyJQkoRtx85UuD+OOj
 OIDbBcT3eX2MGJKx66jhSsZsPfjBUfjMM8vCFTisOSuez/7AjKyY+Sccb+ruzdX0BklM
 lSqohlDwHHws8w3gLjC7Fx3khKIIasaLTl7O9WFHs1jhs5IDpvAUKJBoMfiiz8bbuUuN
 M7Mb9lMOOC9ZD4NH82K5ONza8p1WcjZ5KlADFipjIpk0yR9aqJknJvJV+kIE+NJ+r3q0
 LTsA==
X-Gm-Message-State: AOJu0YwKjH03QuLdxQN6odJNIktNKpir929iwzK2WC2Vlmnwc4SKtxBd
 1ZdxMveeqTXpapquySuVnZoLwTjaDtkDW1VM1R+zg6fGGLoXH66xfUtJK8Viwgqgc4A65Y0UlxK
 N8LcC2MLoNfTyxOS+25SWvE6UEpjTgXUKE9qhUH4jBRt7DlK5XHXYiTciTwIO9M8e8JYxTnvmbi
 Db4dIA/zckKiRSjFE1w2T6OGI=
X-Received: by 2002:a17:90b:1485:b0:2c0:341d:1e30 with SMTP id
 98e67ed59e1d1-2c7b5ccbbd9mr4441119a91.23.1718847546788; 
 Wed, 19 Jun 2024 18:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjR+OVHcBGF9DXcbtW1Ga2GaZy+0fOdMb4cOTNzu/xTDO/oFPs5kn9JeS070AUACAqdLC/w2mjygLcn776jLY=
X-Received: by 2002:a17:90b:1485:b0:2c0:341d:1e30 with SMTP id
 98e67ed59e1d1-2c7b5ccbbd9mr4441106a91.23.1718847546441; Wed, 19 Jun 2024
 18:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240617031324.298353-1-liwang@redhat.com>
 <20240619164221.GB497886@pevik>
In-Reply-To: <20240619164221.GB497886@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Jun 2024 09:38:54 +0800
Message-ID: <CAEemH2ddg+rLhkp8-GAhngGUj1hX5fTrY3qZ5biHXMkACkRcvg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] libswap: Fix tst_max_swapfiles() for c9s-latest
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

T24gVGh1LCBKdW4gMjAsIDIwMjQgYXQgMTI6NDLigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gPiBDb2RlIGNoYW5nZSAobWVyZ2VkIGluIC00NDEu
ZWw5KSByZW1vdmVzIHRoZSBgQ09ORklHX1BURV9NQVJLRVJgLAo+ID4gc28gdGhhdCBjb25maWd1
cmF0aW9uIGltcGFjdHMgdGhlICdTV1BfUFRFX01BS0VSX05VTScganVkZ2VtZW50Cj4gPiBpbnNp
ZGUgdGhhdCB0ZXN0Y2FzZSwgc28gd2UgbmVlZCB0byBkbyBpcyBhZGp1c3QgdGhlIHN3YXBvbjAz
Cj4gPiB0ZXN0Y2FzZSB0byBnZXQgY29ycmVjdCBudW1iZXJzIG9mIE1BWF9TV0FQRklMRVMgdG8g
dGVzdC4KPgo+IEFja2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKUGF0Y2gg
YXBwbGllZCwgdGhhbmsgeW91IHNvIG11Y2ggUGV0ci4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
