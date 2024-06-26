Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2A1C3064D
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719421297; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=et/EArCpFENVfYD28flVNEKKzn+8BX0916NW15IdDEI=;
 b=V4t43arh47gX2tvA+cKEPB2vPOGTZI8CJgPRi8AkEGvxpJEOTx5oqqmvQ8PZid6VgzMns
 W/nV0RmO1glbPo7VbmmgyNnZ1WGjXwLYTWwiV95VG1XAfWmHZAJ4UoS3TQtvDws/ZpanL6I
 tnK1Rq9PgCbRVcUfm+X/SbM/h2rKtaI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5E793D1191
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 19:01:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D1D93D0D1A
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 19:01:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B5693201188
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 19:01:14 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4255f915611so4425e9.0
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 10:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719421274; x=1720026074; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sxiNJ28ii0hxbyh/LuPjOz6Qbh+A4J1GNrrMrB9060=;
 b=07StmZ2+oPR3fm/78jPFvJeH8UbBLh42lXu6aNHQIkkpIhqRSn6Q6yghYYeFSM3WzQ
 XkViN9m7kwXanJI7TaJgADjnk+47V6RJWF13H3nmXsea0Wru1Ld117PTEwGxWVTR77Dl
 mc63b8UsHcqkI8TBk2wg6dJr/9G2ZYwSmrQ0EX90O0Al2+hPtI4T2nRhJj6wAJtoFwzg
 XA4rkcDrzw4VmgsGFBeHxpVOPbYlzvKImgVGQUJjN5OxZjSuVswjMUHngjsd6txWo7oJ
 b97/NfH1o3DohDp8ExtkK5QtEvX7i/lGOoUVU/kpq+RwTaFmW/8u/8BrsC+/XKB9vFnB
 03dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719421274; x=1720026074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7sxiNJ28ii0hxbyh/LuPjOz6Qbh+A4J1GNrrMrB9060=;
 b=gnHQjOHowyW8UIwgl3MKla85iDbwGNgObBtLun2Pg99BeaxQ+Ia2gL9pzh0gE032/L
 W3INp9o5lsGGHzyi57glfTIY10gW8XjnIeUfwTF32aUCw2RQ8WB3tcDSXaczEaLyvv5G
 k85J9WJTTdg8MahaI3cX+kL69bw6BLzEmoj9aqoioIXUSWP6uyNy57ag9hbJmyaF/Vgx
 VzrLNi7Qg3NfrPY0baLbrx5Vrqm+5C2J7NzTYS5dKuBmkKx8IhYE9znIrcZjAnJCbE+5
 tEplYM/BJrPXkSV/oyov31Dqjsm+QQBvaw/FSota3Bn8O3IUFOHlkn1avMdiRym8UTXi
 jxwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfar9OljkTCm6WmpfpFvUuB0KIO8XUZklM0JNoXQ9hF1TgyvrNNXvTSlBWpUUZM1cjc/jNBSn9Zj7YYO23Yn6cYOY=
X-Gm-Message-State: AOJu0Yxu1OcSAGReGqi09fmEO8LRKxdDGabWp3l+Gvg3iOCU3iqrdpvz
 fauQaOEihob4RVVeTTcx23HJ+PkGRHO7JFnDC52YksnUl5XFwil+SQPqk3m6/cN8SBd77CcrHke
 hqk9Na6cWMoCuzhV2D46A6e8o4hiagO3lpA0=
X-Google-Smtp-Source: AGHT+IG3q9LYrz64EYWXXTidcNyy4xaAQpE9hNJhj2HC22MXRLfYq0uwyI05ckgfhp06ACH76+nRjAFp7b6stpEk/0U=
X-Received: by 2002:a05:600c:3d08:b0:424:891e:a9fe with SMTP id
 5b1f17b1804b1-4256352534dmr78815e9.1.1719421273972; Wed, 26 Jun 2024 10:01:13
 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
 <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
 <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
 <CANDhNCr4-cE7_Uy86Pa3kjzFG_EOOB38C_mSGSfZtc=vd7L5yQ@mail.gmail.com>
 <CAEemH2cUj4U4Z=G437fduyQA6-UrnhE4b1_QtRB0kmPn5OMgAA@mail.gmail.com>
In-Reply-To: <CAEemH2cUj4U4Z=G437fduyQA6-UrnhE4b1_QtRB0kmPn5OMgAA@mail.gmail.com>
Date: Wed, 26 Jun 2024 10:01:01 -0700
Message-ID: <CANDhNCpYjncxr-fn8o5vDDYScf4zvVmH_w_Ms1Jhg9tsn-UgDQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: Darren Hart <darren@os.amperecomputing.com>, kernel-team@android.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMjUsIDIwMjQgYXQgNzoyNuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiBKb2huIFN0dWx0eiA8anN0dWx0ekBnb29nbGUuY29tPiB3cm90ZToKPj4K
Pj4gU2hvdWxkIHRoZSBvbGQgLS13aXRoLXJlYWx0aW1lLXRlc3RzdWl0ZSBvcHRpb24gYmUgcmVt
b3ZlZCB0aGVuPwo+Cj4KPiBObywgd2UgbmVlZCBpdC4KPgo+IFdoZW4gY29uZmlndXJpbmcgTFRQ
IHdpdGhvdXQgdGhlIC0td2l0aC1yZWFsdGltZS10ZXN0c3VpdGUgb3B0aW9uLCBpdCB3aWxsCj4g
c2tpcCBidWlsZGluZyB0aGUgc3R1ZmYgdW5kZXIgdGVzdGNhc2VzL3JlYWx0aW1lLyBieSBkZWZh
dWx0LgoKUmlnaHQuIEJ1dCBhcyBJIG1lbnRpb25lZCBlYXJsaWVyLCBidWlsZGluZyB3aXRoIGl0
IHNlZW1zIHRvIGJlIGJyb2tlbgpjdXJyZW50bHk/Cgo+IFVubGVzcyB5b3UgYnVpbGQgaXQgbWFu
dWFsbHkgbGlrZTogbWFrZSAtQyB0ZXN0Y2FzZS9yZWFsdGltZS8uCgpTaG91bGQgbWF5YmUgdGhl
IHJlYWx0aW1lIHRlc3RzIGp1c3QgYmUgaW5jbHVkZWQgaW4gdGhlIG5vcm1hbCBidWlsZApub3c/
IE9yIGlzIGl0IHN0aWxsIHVzZWZ1bCB0byBrZWVwIGl0IHNlcGFyYXRlIGR1ZSB0byBzb21lIG9m
IHRoZQphZGRpdGlvbmFsIGRlcGVuZGVuY2llcyBpdCBuZWVkcz8KCnRoYW5rcwotam9obgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
