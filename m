Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD6BEB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 03:00:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 107853CE0F3
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 05:00:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D1083C9BB9
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 05:00:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 41167100044C
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 05:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687316430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+8hZjxCTA1lApDXHvcCbR2u5lYFvZYMtTws6K/vSxao=;
 b=B+KaPLnilsTdV/QHOmdt9jgAJO4TvQShnT9YEvVVNjvvg1QjhqitqZfb5qACUAecgZvJzj
 5gndDDC6lT3lVn1kvtuylsMQVKiDKyHwxeqF2ntzJMzYclbVk/520631TaE+NgIH6GUXn2
 no2oT2uFcrseBFxtQ4gschjww31v6DQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-tcxdwTFkOmuvR_bdoGb04A-1; Tue, 20 Jun 2023 23:00:28 -0400
X-MC-Unique: tcxdwTFkOmuvR_bdoGb04A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f864ca6243so2616046e87.0
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 20:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687316427; x=1689908427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+8hZjxCTA1lApDXHvcCbR2u5lYFvZYMtTws6K/vSxao=;
 b=YmgzyzYX+LhOBpoq5l4sM+0iLSequFh9Qne4sPvRg5lRVYixXqF6SS5eiKTWaf1L/O
 3N6gK7J7dCgMLHNlcIOrdD7sB2H1tgDTSibLwcJjiTac/gXagfD/4cbgV/4GX0cgCNW/
 xxe440Xb8R7iIn7rEM0A5+O43xlfpkOnxIvRdEFdlM+xcoR4MiM7q5PtjGfnKop9+oB+
 WSph/5B+vdkOvhdQNys7EOfBohHR+6Iobh1HwG09AjZpq442DnObJH6hgJpLpDMGRs3+
 Z0HPUBCWrJW+Z4fo4pZIXsR77tVRYBOQvNI+tOn83GKjW6aSEXqYrJwotTRhyy+ywJ6D
 wKcg==
X-Gm-Message-State: AC+VfDxviH4p0QQkokpIkZwiBajOxZoB7l7nkjGR/zAfChkUFlxpHr9I
 i2q5lH5a8UzF/9zkLNcsNJNO6tP390Kthoo74a18dQn9dqDt6iTXgjAJ1QPles7uhqT4ar81Bw5
 p2J+N7hj0xmcFImYec4ehjbSuXdI=
X-Received: by 2002:a05:6512:313b:b0:4f9:5571:5443 with SMTP id
 p27-20020a056512313b00b004f955715443mr1940414lfd.27.1687316426828; 
 Tue, 20 Jun 2023 20:00:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dZK4/TB5vWaP00TCJpzl1jegqWtC70V5H/v4T8jJd0OPdS4Vwn+UNE3LNz1WlFdHVhXxGvSG0pKAb0bCn/0Q=
X-Received: by 2002:a05:6512:313b:b0:4f9:5571:5443 with SMTP id
 p27-20020a056512313b00b004f955715443mr1940407lfd.27.1687316426563; Tue, 20
 Jun 2023 20:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230620163027.22039-1-mdoucha@suse.cz>
 <20230620201857.GA326205@pevik>
In-Reply-To: <20230620201857.GA326205@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Jun 2023 11:00:14 +0800
Message-ID: <CAEemH2eHRLfveCzqVtGNz6swHNw7v-aRHzU0J09r_zEzPiO66Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] syscalls/madvise11: Ignore unpoison failure
 under kernel lockdown
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

UHVzaGVkLCB0aGFuayB5b3UgYm90aCEKCk9uIFdlZCwgSnVuIDIxLCAyMDIzIGF0IDQ6MTnigK9B
TSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIE1hcnRpbiwKPgo+IFJl
dmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IFRoYW5rcyEKPgo+IEtp
bmQgcmVnYXJkcywKPiBQZXRyCj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
