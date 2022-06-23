Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AF3C43334
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 08:26:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5AA73C9564
	for <ltp@archiver.kernel.org>; Thu, 23 Jun 2022 10:26:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A91CE3C071A
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:26:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8EE8E60029A
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 10:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655972783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B5bmBUBvcnuxgxcyiJICa7ky57heK/uhZiJMU9xzdLg=;
 b=i+gXpyEUw1+2OhyFgbAHLAt2Uh9kIXMhnk1ElTmoiyAZ8d+xWzoy/pd9AJ+yHrZ9aWVvwP
 4vZnFHIto9pBSJyfV6CUiF4ZSCFDyMdLCpHWInYLWZb8bfYQWgu97Yi+UIzJVxnFbZI8Be
 ts9uTtqNaa9xJYH2V51yGY9JiBNxlXU=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-MdZUz9e2PO-2Wt23flitEQ-1; Thu, 23 Jun 2022 04:26:21 -0400
X-MC-Unique: MdZUz9e2PO-2Wt23flitEQ-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-31859b57239so25379987b3.3
 for <ltp@lists.linux.it>; Thu, 23 Jun 2022 01:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B5bmBUBvcnuxgxcyiJICa7ky57heK/uhZiJMU9xzdLg=;
 b=KJcg+1tjjXfFHKeGIVq0wQclqb5uKzAFdLCgGA1oXqSLPYDK5y0rtjLQM6MzswgSgu
 2FEEJrON+rB/8O5c5gq5+sIttt4v8ywpYP8pHYxKgnRWrXbPU1Xo1wxeZIzdHxB8wY1c
 uAkB7o88dLi+ELMFiobbJe2FJUa2R4Z/o0yvGOGqdXuB/WOvM5mHZXxkXYyT2iPdKTGZ
 xWlxWAQitNm5dNhZrsHrmW34lRjtNR0VMQKlbX9lGGj8YsYjBPdoRtGPFaENpOmM73iS
 RXvIElUWSvf9sk2zTNy/yZOuz8fYborMOJ/x6UKMBW9HwstLduaFP9oXhzYFKWUHdPoc
 zTGA==
X-Gm-Message-State: AJIora+UIXVOPmEvjt8nL1lnA98i4GF/kvveuSykQmG+Ve1xno6CFq1O
 anaADIokNXL5zQsoHQJRy2h0RwedtmG5vJBpsciNx+UeZD0uEhiiNVYGjqVWxAB46xcfpxMVefc
 9iqJznmriahmVYsVQd5YI6WR55lc=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr5747367ybn.597.1655972781336; 
 Thu, 23 Jun 2022 01:26:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sFzJgcBwtWk1cy3X3pti7EXpPlhGqOYUf6jnkMegY6mH6cgfr3t78UX00Z2NbWQSG/cDHjnmtPqlSzGnwQVgg=
X-Received: by 2002:a25:2e50:0:b0:669:9a76:beb with SMTP id
 b16-20020a252e50000000b006699a760bebmr5747358ybn.597.1655972781125; Thu, 23
 Jun 2022 01:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <2873e7f25ac44d2c103a030bfc5f1d30e0fe80a9.1655795105.git.jstancek@redhat.com>
 <6616c11cdf55d2fd89f6f3c8f9ab1a8c1a3916e7.1655800610.git.jstancek@redhat.com>
 <YrGUJmmVzhFJhlcX@yuki>
In-Reply-To: <YrGUJmmVzhFJhlcX@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Jun 2022 16:26:09 +0800
Message-ID: <CAEemH2cVqL7eO8jee6Zpd_yw4qkT_X+rS4yJoSersaqz9+AEsw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/migrate_pages03: restore runtime to 5m
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1820074802=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1820074802==
Content-Type: multipart/alternative; boundary="000000000000608c3d05e21935b2"

--000000000000608c3d05e21935b2
Content-Type: text/plain; charset="UTF-8"

Cyril Hrubis <chrubis@suse.cz> wrote:


> > --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> > +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
> > @@ -127,6 +127,11 @@ static void migrate_test(void)
> >                       tst_res(TFAIL | TERRNO, "migrate_pages() failed");
> >                       return;
> >               }
> > +
> > +             if (!tst_remaining_runtime()) {
> > +                     tst_res(TINFO, "Out of runtime, exitting...");
>                                                             ^
>                                                             Just one
>                                                             't' here
>
> Sorry I tend to make this typo quite often.
>

I fixed that and pushed. Thanks!


-- 
Regards,
Li Wang

--000000000000608c3d05e21935b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+Q3lyaWwgSHJ1YmlzICZsdDs8YSBocmVmPSJtYWlsdG86
Y2hydWJpc0BzdXNlLmN6Ij5jaHJ1YmlzQHN1c2UuY3o8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXY+wqA8L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+DQomZ3Q7
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWlncmF0ZV9wYWdlcy9taWdyYXRlX3Bh
Z2VzMDMuYzxicj4NCiZndDsgKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9taWdyYXRl
X3BhZ2VzL21pZ3JhdGVfcGFnZXMwMy5jPGJyPg0KJmd0OyBAQCAtMTI3LDYgKzEyNywxMSBAQCBz
dGF0aWMgdm9pZCBtaWdyYXRlX3Rlc3Qodm9pZCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB0c3RfcmVzKFRGQUlMIHwgVEVSUk5PLCAmcXVvdDttaWdyYXRlX3Bh
Z2VzKCkgZmFpbGVkJnF1b3Q7KTs8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXR1cm47PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfTxicj4NCiZn
dDsgKzxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKCF0c3RfcmVtYWluaW5nX3J1
bnRpbWUoKSkgezxicj4NCiZndDsgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdHN0
X3JlcyhUSU5GTywgJnF1b3Q7T3V0IG9mIHJ1bnRpbWUsIGV4aXR0aW5nLi4uJnF1b3Q7KTs8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBePGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgSnVzdCBvbmU8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmIzM5O3QmIzM5OyBoZXJlPGJyPg0KPGJyPg0KU29ycnkgSSB0ZW5kIHRvIG1ha2Ug
dGhpcyB0eXBvIHF1aXRlIG9mdGVuLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1zaXplOnNtYWxsIj5JIGZp
eGVkIHRoYXQgYW5kIHB1c2hlZC4gVGhhbmtzITwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjwv
ZGl2PjxkaXY+PGJyPjwvZGl2Pi0tIDxicj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfc2ln
bmF0dXJlIj48ZGl2IGRpcj0ibHRyIj48ZGl2PlJlZ2FyZHMsPGJyPjwvZGl2PjxkaXY+TGkgV2Fu
Zzxicj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj4NCg==
--000000000000608c3d05e21935b2--


--===============1820074802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1820074802==--

