Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D7EC433FE
	for <ltp@archiver.kernel.org>; Sat, 19 Nov 2022 02:02:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DEB43CCEE0
	for <ltp@archiver.kernel.org>; Sat, 19 Nov 2022 03:02:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4BC23CCEA8
 for <ltp@lists.linux.it>; Sat, 19 Nov 2022 03:02:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 257C86F9D1B
 for <ltp@lists.linux.it>; Sat, 19 Nov 2022 03:02:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668823351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3MIw3uylXZepKRH09gUyVZT8FAkMlQOl4cT89Cckj98=;
 b=aYqFNhpgXrfs2jA3XJ4SyA17tls5RwmByNhDLvEK7dU3MhjyYza8Go65vjOiw7Bq2DPyT1
 QHEfaJiYsMGXg8x4uTbsuvcr6fpl3Z4BIlt1na5R2+tNU3ggwL6kLS1LLB/gkGmJMxFen9
 xuPG/7IkPOQSMKZ3UcwE54HKIj+b/6I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-oVad7DBuN2KnD-DkobevRg-1; Fri, 18 Nov 2022 21:02:29 -0500
X-MC-Unique: oVad7DBuN2KnD-DkobevRg-1
Received: by mail-wm1-f69.google.com with SMTP id
 h9-20020a1c2109000000b003cfd37aec58so3116799wmh.1
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 18:02:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3MIw3uylXZepKRH09gUyVZT8FAkMlQOl4cT89Cckj98=;
 b=wD5eawDV1gApeXs2xqdVMzb85vbDAV3Ks6wOFcQBgM2YpeGdBZHp59osaaz3wqcw4t
 NSVKj1R0J60Lxci/O94wPx9qpVDNefoCRkq6hNVc/+SbVQbU66FM0NN/ewMYWFxsu0/D
 i6HTWppPRyMdgA5avPXm7/qtvl+A3KJ6ifD+u4/+L+7YhkZAF72UCACodmoQ8RQ74E+t
 UHbu79qwiycUS9J23f3zmrE5KhV7q12t1PmfALvP702QzIhkPJ/DVI96aagCyMB2OP0S
 7yuZY1wRMAut8kw+cmstsm+nT7U2CW7ZGUcIcfcN8W1n0KUQ1FEfV3NoCbUsjkkRG6aG
 9UrA==
X-Gm-Message-State: ANoB5pmHHoKikjHrRtrrxu1xT/0mG+xajGFKwQ2T+JZUVaFGFw4jNxP/
 VZL68rr20yjNad5LWK+rrs3zfulX5adZA7imS8qmcdNI3kS37UXt8ntOF3XwSlYgutgQ4afVV/X
 Asg0qvZ7tcNZg8qD3EzaDJCMhnBM=
X-Received: by 2002:a05:600c:4194:b0:3cf:5080:412c with SMTP id
 p20-20020a05600c419400b003cf5080412cmr9633233wmh.99.1668823348395; 
 Fri, 18 Nov 2022 18:02:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4O2ErIVIAFQ/hVyuzgz67siASSMYfisBbJFD5TxoLX1+6IkF5mPg55Jv6PnmvxFdGHWFUJsoIVq7sPP6kSqFg=
X-Received: by 2002:a05:600c:4194:b0:3cf:5080:412c with SMTP id
 p20-20020a05600c419400b003cf5080412cmr9633227wmh.99.1668823348194; Fri, 18
 Nov 2022 18:02:28 -0800 (PST)
MIME-Version: 1.0
References: <20221118065751.4120847-1-liwang@redhat.com>
 <Y3eLHM6Q/W+5Ndcg@yuki>
In-Reply-To: <Y3eLHM6Q/W+5Ndcg@yuki>
From: Li Wang <liwang@redhat.com>
Date: Sat, 19 Nov 2022 10:02:17 +0800
Message-ID: <CAEemH2dDYfX-tYjT_w4M0Of09yeNDanG=bxjtRwPgOFK35CyoA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] keyctl02: make use of .max_runtime
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
Content-Type: multipart/mixed; boundary="===============1048982454=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1048982454==
Content-Type: multipart/alternative; boundary="000000000000dcc55305edc93694"

--000000000000dcc55305edc93694
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 18, 2022 at 9:38 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > --- a/testcases/kernel/syscalls/keyctl/keyctl02.c
> > +++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
> > @@ -81,6 +81,11 @@ static void do_test(void)
> >               SAFE_PTHREAD_JOIN(pth[1], NULL);
> >               SAFE_PTHREAD_JOIN(pth[2], NULL);
> >               SAFE_PTHREAD_JOIN(pth[3], NULL);
> > +
> > +             if (!tst_remaining_runtime()) {
> > +                     tst_res(TINFO, "Runtime exhausted, exiting at %i
> looping times", i);
>                                                               ^
>                                                               maybe it
>                                                               would be
>                                                               better:
>                                                               "exiting
> after %i loops"
>

Sounds good, merged this modification.

-- 
Regards,
Li Wang

--000000000000dcc55305edc93694
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtc2l6ZTpzbWFsbCI+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIEZyaSwgTm92
IDE4LCAyMDIyIGF0IDk6MzggUE0gQ3lyaWwgSHJ1YmlzICZsdDs8YSBocmVmPSJtYWlsdG86Y2hy
dWJpc0BzdXNlLmN6Ij5jaHJ1YmlzQHN1c2UuY3o8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPkhpITxicj4NCiZndDsgLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwv
a2V5Y3RsMDIuYzxicj4NCiZndDsgKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXlj
dGwva2V5Y3RsMDIuYzxicj4NCiZndDsgQEAgLTgxLDYgKzgxLDExIEBAIHN0YXRpYyB2b2lkIGRv
X3Rlc3Qodm9pZCk8YnI+DQomZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBTQUZFX1BUSFJFQURf
Sk9JTihwdGhbMV0sIE5VTEwpOzxicj4NCiZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFNBRkVf
UFRIUkVBRF9KT0lOKHB0aFsyXSwgTlVMTCk7PGJyPg0KJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgU0FGRV9QVEhSRUFEX0pPSU4ocHRoWzNdLCBOVUxMKTs8YnI+DQomZ3Q7ICs8YnI+DQomZ3Q7
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICghdHN0X3JlbWFpbmluZ19ydW50aW1lKCkpIHs8YnI+
DQomZ3Q7ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHRzdF9yZXMoVElORk8sICZx
dW90O1J1bnRpbWUgZXhoYXVzdGVkLCBleGl0aW5nIGF0ICVpIGxvb3BpbmcgdGltZXMmcXVvdDss
IGkpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF48YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBtYXliZSBpdDxicj4NCsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHdvdWxkIGJlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgYmV0dGVyOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICZxdW90O2V4aXRpbmcgYWZ0ZXIgJWkgbG9vcHMmcXVvdDs8YnI+PC9ibG9ja3F1
b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9
ImZvbnQtc2l6ZTpzbWFsbCI+U291bmRzIGdvb2QsIG1lcmdlZCB0aGlzIG1vZGlmaWNhdGlvbi48
L2Rpdj48L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj4tLSA8YnI+PGRpdiBkaXI9Imx0ciIgY2xh
c3M9ImdtYWlsX3NpZ25hdHVyZSI+PGRpdiBkaXI9Imx0ciI+PGRpdj5SZWdhcmRzLDxicj48L2Rp
dj48ZGl2PkxpIFdhbmc8YnI+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+DQo=
--000000000000dcc55305edc93694--


--===============1048982454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1048982454==--

