Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE23C77B70
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 07:59:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A0453CC183
	for <ltp@archiver.kernel.org>; Mon, 17 Apr 2023 09:59:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15B763C01AA
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 09:59:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EA5C0600642
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 09:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681718379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YPUKD9VYMELF3gpKFhv/31cdRIYF66rOnUDtmzO0wjw=;
 b=HEO3/uKxVAuBIWoMkIE9fJYh+lAxL1ai3A3LM8vrq49AMnpoGCV+us3x9mhtXT9bmad7Sr
 cQujlhQ5sCldHjwlQgz4M3bP12Litb+VrLgOdZH4JKwkVRqSsBYgUznk8TJ37XQ5TIe9Cz
 NjbsISWdkJp/bWIDx2HekCXEtR/+p/U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-PRFaCFXwNOS7996Z0o0zVg-1; Mon, 17 Apr 2023 03:59:37 -0400
X-MC-Unique: PRFaCFXwNOS7996Z0o0zVg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2f479aeddc4so758471f8f.2
 for <ltp@lists.linux.it>; Mon, 17 Apr 2023 00:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681718376; x=1684310376;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YPUKD9VYMELF3gpKFhv/31cdRIYF66rOnUDtmzO0wjw=;
 b=DECuF1p2pgOjfGsiikDsXPPwwO4oIxRdyk0Ilii61nLrvfSBtBzbKz0WGf4kwXK2gJ
 hiSs4nGwmG88bpxwa2ZgjV6IQCDtlXbj0ir8KS2hJwy4w8fzrpsVXf9YcXUWNKOL0Daa
 fC36keOTFp+QZByFfad/+BIjNjq2ach1yaGhOGBnsM+1FqDSnytwAsA1Vol5N/Lh5nqv
 tvKH2dXudJDK6zWXuaYmI2ypwojMG8iH7dbe5q2KQfDV6HHsez5jTW1F9sOZru8iQ2LA
 zVl/bgKfHNDpkSfb75IMZLgg6EQzBU19/MBGdlvJxFhX2h0wNaj3PGNsul8Xl1+bA3E0
 9vrg==
X-Gm-Message-State: AAQBX9f4XKmfhtVTwzqPpDDB9mYKdSiwXaD+MLYRDlrvW9hHhBfanejx
 rska96ME5I6hQNI10PYT1uMOhjNiszPhkDceUTDD+fjc53W9GRjJrCbDedT81xAidNlmJxFYVC2
 OyZMCjf9ZMP3BGweQ1qj0omhA+p1H9c7+NehOm8TM7Gw=
X-Received: by 2002:adf:f306:0:b0:2fb:600e:55bd with SMTP id
 i6-20020adff306000000b002fb600e55bdmr396365wro.39.1681718376117; 
 Mon, 17 Apr 2023 00:59:36 -0700 (PDT)
X-Google-Smtp-Source: AKy350aRX03RyfvutLuBwHbfdCN9WZEGm7P4/eMT13jCDTttKi2abMNVHYtvr0fd8FKBsuiICv2Xm67aYTeTTpWB43M=
X-Received: by 2002:adf:f306:0:b0:2fb:600e:55bd with SMTP id
 i6-20020adff306000000b002fb600e55bdmr396355wro.39.1681718375843; Mon, 17 Apr
 2023 00:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <1679293822-19378-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1679293822-19378-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <CAEemH2eTxhuQ+5YGMVbQwf9ZY1ttOHZxCySux-s0sDjXvhC4zw@mail.gmail.com>
 <c35fc5da-d420-7cb2-88a9-6327b46ed738@fujitsu.com>
 <9ff1f71c-9f21-e7ad-bfb7-c552306892d1@fujitsu.com>
In-Reply-To: <9ff1f71c-9f21-e7ad-bfb7-c552306892d1@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Apr 2023 15:59:24 +0800
Message-ID: <CAEemH2fN=JANooAt6u5wHJxZDDM5KpHDvQWcDHh90neP8odT=g@mail.gmail.com>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 4/4] ipc/semget05: Convert into new api
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBcHIgMTcsIDIwMjMgYXQgMTA6NDDigK9BTSBZYW5nIFh1IChGdWppdHN1KSA8Cnh1
eWFuZzIwMTguanlAZnVqaXRzdS5jb20+IHdyb3RlOgoKPiBISSBMaQo+Cj4gSSBtZXJnZWQgdGhp
cyBwYXRjaCBpbnRvIG15IG93biBsdHAgZm9yaywgc28geW91IGNhbiByZXZpZXcgdGhpcyBwYXRj
aAo+IG9uIG15IGx0cCBmb3JrLgo+CgpZZXMsIHRoZSBwYXRjaCBsb29rcyBnb29kLCBmZWVsIGZy
ZWUgYWRkIG15IHJldmlld2QtYnkgYW5kIHB1c2guCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
