Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D477FF60D0
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774947363; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=KXFlht26xrjGSfbAoUeHs2wp5EdtaD+zmB5FGh1kU+8=;
 b=Ol8/m5AJ6x9i+yWvzCnSbuwh+9rzvaq3iqM4MX8WqOhHnXDoSBRw1W9DLhDVsr4Yzy2my
 o2MxnJOVJjTf7Z8/V5ACwUio5BQFKUzgjm1zOG+IPnVGTCLOyxyqcjZe9qN9fBX4afBQ6Ex
 ve4XCTOLXhS9Z/hMlGAkeqIIIt4tDkg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FD403E2A52
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 10:56:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6A23E21C6
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 10:55:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C9A74140124C
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 10:55:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774947335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sph8cvcllNtD7L3njKxACDvtZsWnyUpq+xyavzrvG58=;
 b=RxdoAiakgeDINfqI5hWpkkzHWNtGm7CqgGj8xH39efjeLRlQEN0E4RfhiLAG9u7yqrof9f
 zNisf6+aCblIjMxd87GsfE88nXfkLNLNNmiZ3nYzI0a8iblpxSBwfNL7xlZ08pk4o0UiiM
 SX08odQdnGaY3AXU4Tq/kBpd6fReztk=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-s730QXFtPay7TsZTQtJjXg-1; Tue, 31 Mar 2026 04:55:34 -0400
X-MC-Unique: s730QXFtPay7TsZTQtJjXg-1
X-Mimecast-MFC-AGG-ID: s730QXFtPay7TsZTQtJjXg_1774947333
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so6658020eec.0
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 01:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774947333; x=1775552133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sph8cvcllNtD7L3njKxACDvtZsWnyUpq+xyavzrvG58=;
 b=E3WjurnkX1zvKmw4goQWgdeJH7cVYQ5oyuaeNicOFptpTFzW/UxBp5etxtjvmq44TH
 vVTB+XDzZvIDbt4ETDdLks8PopunNrtFtORdeMnQf0+tT4x6/dou0q+Rew2n4KwZ7ZHO
 XVaYXnR2R+YvkeYzem3XdfvGIC91iNERyaW8m4l8e9DbjHuinKLMAgV2mja5u/hw/gqV
 AiPKWaN8fNAnrXt/NjQtarsT2d8/F/dtAq3mZ4xQFmXCyXDkDnUMpPycYzC0rNNOMl8x
 d6T83ID4IB1gLDVgJBbUtdww3QUOxscV6xp6UjKHgF6DUc8ou4cP6PVcJG00k134pgb5
 TCpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWas/SdxdU1lhych4SL8PFFPdtHjHsg6HtMjkyoTLRqxc3ly583xY2TIon0MQltz8KFVIY=@lists.linux.it
X-Gm-Message-State: AOJu0YyGEm8MgUvsYkAl96HAdjVNLlV4tTaTd16HND1e9ibfdwg08E+Y
 HxtqDMHBbf3kX8RxxJv82HetWlF2DzjgZE2wTrWlixN+0SoQe+fqhabByHoQA5WgZ5hAfwikl4Z
 gmymZv+zc8OX9hhbIz7HWiQPQVKJ3iSGiPH4AYvGTleG4aktCs9nDXIYcUFI17u99SPva2QrZnP
 RRJUX4ceiSfwC2Gom87lZU/i4YfMo=
X-Gm-Gg: ATEYQzxofU5qYt8Z1g77RxLnO8rTjNHqWGlSpZMwEgPB6odLDNDYUhFmVzg1/x+p66q
 aoARZxUxf1RJfSnezXbdp2KdTKYBpn4AOsv1AMLwoGileYwK0ZvIMasoZYECD9r/UMOeQ07SVVq
 oWGNRXWgK9JHUY0YybmRV8RTP3VleEaEHvnpaebl26sohkMIrPaTci5Wm3GaTefk5zVwt4UmI8N
 CX3KjE=
X-Received: by 2002:a05:7301:1692:b0:2c8:1d56:3410 with SMTP id
 5a478bee46e88-2c81d5642e8mr774175eec.18.1774947333054; 
 Tue, 31 Mar 2026 01:55:33 -0700 (PDT)
X-Received: by 2002:a05:7301:1692:b0:2c8:1d56:3410 with SMTP id
 5a478bee46e88-2c81d5642e8mr774170eec.18.1774947332593; Tue, 31 Mar 2026
 01:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260331072051.GA5254@pevik> <act71G89AKEf63LA@yuki.lan>
In-Reply-To: <act71G89AKEf63LA@yuki.lan>
Date: Tue, 31 Mar 2026 16:55:20 +0800
X-Gm-Features: AQROBzBsgWqYS7BKU2mYxJ3aZ6GP_S3I3MxBh3TS3uRO2ci75uTELTwOU8T4BPM
Message-ID: <CAEemH2ezLeVNTaHXDXr9wO+sYr6kzieSsF8Wzkctf72yyM2y2Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q7vL4NVkhUcUDRJAMLGhJLcsbgblMpioTIxY3juV1x0_1774947333
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] linux-git: using whole sha1 hash
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMzEsIDIwMjYgYXQgMzo0NuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gYW55dGhpbmcgYWdhaW5zdCBzdGFydGluZyB0byB1
c2Ugd2hvbGUgc2hhMSBoYXNoIGluIGxpbnV4LWdpdCB0YWc/IGkuZS4gNDAgY2hhcnMuCj4gPiBJ
dCBjYW4gYmUgc2hvcnRlbiBieSB0aGUgZG9jL2NvbmYucHkgc2NyaXB0ICh1c2Ugd2hvbGUgaGFz
aCBmb3IgVVJMLCBidXQgc2hvcnRlbgo+ID4gdGhlIHZpc2libGUgcGFydCBvZiA8YT4gdGFnKS4K
Pgo+IFNvdW5kcyBnb29kIHRvIG1lLgoKKzEKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
