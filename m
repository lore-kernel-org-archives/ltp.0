Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C5CD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781539790; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tjabDnAhSANUs48EPP0vslomRQO8+WNOXYBqw6Erdso=;
 b=BpJP9822yC998vLtAVJ/lCuC1LxkEDhGAjejJ5Okl6JkKKIBGnyz3qlj/HUi4FzBxQmw9
 SBmwmIx/uUSedwEP9lqrymvWdkyPKK1rzrR8yKXwMOJzxkh7Ao5E4e3r18vL34k9Q6+NWEo
 z+a7/exxuRshHx7B3o6y01ZcYD0bplQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B58913E2A2F
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:09:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05383E235C
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 18:09:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15AAA600746
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 18:09:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781539766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9grHLKLS6BydaYcAoLToyviGmn2gGWCIXARyy3rumE=;
 b=TuNhdfnIoywmPljhn3rq8LPEZGB8iHRa1yHlRDAuePP/HcIRxZ43IQ2wQziqA/+TIgfw73
 Redox03NEXgunwY8NQfpr7ahVxnLpYlYLcNe4MidQaTIsdY7swJah9N1EthtIirJzaUL2P
 LgmH+hrFzUcHidzJ3IdVHPC/NKjDemk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-0ZTmWxmeNpuNe9xpYs3FtA-1; Mon, 15 Jun 2026 12:09:23 -0400
X-MC-Unique: 0ZTmWxmeNpuNe9xpYs3FtA-1
X-Mimecast-MFC-AGG-ID: 0ZTmWxmeNpuNe9xpYs3FtA_1781539762
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-45eebc943bfso2642611f8f.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 09:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781539762; x=1782144562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d9grHLKLS6BydaYcAoLToyviGmn2gGWCIXARyy3rumE=;
 b=jxrpfjXqNNhPRjVzhYQ+YNtpLKwelfnTBRmxkz+DzXMKfJktEO5g9wJzGijh/5kCjZ
 0tG0HntuMFYLQZZHtHr7aw1NbzgNqHXqujiOeHJRwzfC/csTeKWuiw6nrXsxk6FOrATx
 jIEPlk4EL7tfk2ffNcZXTI6vqQVBo851jjXkREW0OvRy2XUEsAS4iSej/VykWZ2N6H+V
 f1ZZt5LezlvSB5l1gpQIAZUyIT8pgptj6OS9kdbyucTFc2wGa2HHcwJsrc/Ez5ql3dvT
 Vc2p62r+QCujaQJ2j6ZJWtE6NmD9SK7qiKhlwdxgOiyTRX4YRFTH4DHLYndn9ZIwcdoP
 G5TA==
X-Gm-Message-State: AOJu0YyZfaHb/CTWbDWS57voRQqt+eco7ph/Xzj6MVwyIfH9Nkbxnk30
 UugsIaNCbMDW7DXWYi7qJldZgdn5CFG9uXef2FpQtv1aoVAKaFGpxCzZGKQwrRsU8VI+xridqcH
 MyH7W8p1gVMwbzxSd/VFcoDaCjzD4Hh5kYc/3jlv4Q0G9rIBzL+xtSCxF7Q46t7yd/Iow5Ba+CZ
 kybgli1dpIGnsgYUZUjkWUogqO/3ODAiIBfAsGNA==
X-Gm-Gg: Acq92OE8I8+r3l28N3aCktYwpLPAAqat3sY9vgS4Pdc8cmYgXa3ezW3nCaf6BlTWBZg
 twt0kINK/hqxY+gu64iv5Dd5B/PxZeey2ULudZVFBcfrllVI54XrByHM79Nw4k3deUHE4DIPz7S
 j44cIJROw5/Q/B1E35ztmS7SNv3GG1/DPuKtKa4RbjHFVTDzhBecoTnuUW7ps8P9L17Kr1rxEbt
 sIQdw==
X-Received: by 2002:a5d:4535:0:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-4619f2efb2bmr129951f8f.12.1781539762147; 
 Mon, 15 Jun 2026 09:09:22 -0700 (PDT)
X-Received: by 2002:a5d:4535:0:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-4619f2efb2bmr129911f8f.12.1781539761749; Mon, 15 Jun 2026
 09:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260615142526.70655-1-mdoucha@suse.cz>
In-Reply-To: <20260615142526.70655-1-mdoucha@suse.cz>
Date: Mon, 15 Jun 2026 18:09:04 +0200
X-Gm-Features: AVVi8CfC5rXOPXjARbBxLZdmfOgGSYACClLZrLXX_B5J6dC1T7Asg7EMmEdjD5o
Message-ID: <CAASaF6yLzXOOzwZkDy+C2-Jn=-EN+LBHydPNWsmB+sxOO3vmgg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9qxAHkY18wIMDbTw-5YhGNUH4My6MpxzCFIo4PCMpJc_1781539762
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Remove pthread_detach_1-2
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMTUsIDIwMjYgYXQgNDoyNeKAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cj4KPiBUaGUgUE9TSVggc3BlY2lmaWNhdGlvbiBvZiBwdGhyZWFkX2pv
aW4oKSBoYXMgY2hhbmdlZCBpbiByZWNlbnQgeWVhcnMgYW5kCj4gcHRocmVhZF9kZXRhY2hfMS0y
IHRlc3Qgc2NlbmFyaW8gaXMgbm8gbG9uZ2VyIHZhbGlkLiBUaGUgUE9TSVggc3RhbmRhcmQKPiBp
c3N1ZSA4IHNheXMgdGhhdCB0aGUgYmVoYXZpb3Igb2YgcHRocmVhZF9qb2luKCkgY2FsbGVkIG9u
IGEgdGhyZWFkIElECj4gd2hpY2ggZG9lcyBub3QgcmVmZXIgdG8gYSBqb2luYWJsZSB0aHJlYWQg
aXMgdW5kZWZpbmVkLgo+Cj4gaHR0cHM6Ly9wdWJzLm9wZW5ncm91cC5vcmcvb25saW5lcHVicy85
Nzk5OTE5Nzk5L2Z1bmN0aW9ucy9wdGhyZWFkX2pvaW4uaHRtbAo+Cj4gVGhlIHRlc3QgY3JlYXRl
cyBhIHRocmVhZCwgZGV0YWNoZXMgaXQgdXNpbmcgcHRocmVhZF9kZXRhY2goKSBhbmQgdGhlbgo+
IGNhbGxzIHB0aHJlYWRfam9pbigpLCBleHBlY3RpbmcgYW4gZXJyb3IuIEFzIHN0YXRlZCBhYm92
ZSwgdGhlIGV4cGVjdGVkCj4gYmVoYXZpb3IgaXMgbm93IHVuZGVmaW5lZC4gUmVtb3ZlIHRoZSB0
ZXN0Lgo+Cj4gU2lnbmVkLW9mZi1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PgoK
QWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
