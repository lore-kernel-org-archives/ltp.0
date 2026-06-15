Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786C2CD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 08:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781511728; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=tkqtz1rAQAZ2Ll6QNQ71ytORQ4QAvSA+4MEN1eZYx24=;
 b=RxO2lgkrqVuJh5wiZoF3hBrhPFG1OtwYaHrRJiGr12EyjwUNKwWGG4bBOJa53s71U3Hr6
 7a8Irfob9L86Spk4DdoJ9Qqky0YWSg3xzfryRgunk+gZrHVyjBKnGcbu5jiHe/2f8uOqmnL
 GbF9QzgU1+x/hIYBD8GPhq94dCDgABI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCA863E2B0B
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 10:22:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C5873E202A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 10:21:47 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4352360011D
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 10:21:47 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so16231395e9.3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781511707; x=1782116507; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bU8xcVcSQcyQqF8sn0sSTsDXGvFKJlhzxXL9b2FE8o8=;
 b=Z5INaN5iQWhXhpU26GfG0p0UqCx5OhGX7vpWxKpxCXlfGx4DlQvNTqMPoA4BN9lvsv
 PkIQpyZxB4IXipM555mUfRj9SNgOE7tsFfjHw/Wm+/dyUCYJZEsxotk+Tg/B+QqiFZsl
 3iqF5//BqX28tIk5qgszstwc/8+z8Rd9qS+D+X+2Jul9PTxBalwdUs/PB622EzEnKEaj
 gx0pZaEwo+nIr96JToHJBsEl0YVdCioZ5N5usGSjXmlLyQllHmUgCRPKYLfYtUXGLr40
 j+97jFZaPgALq2VMH1nztHFB/5JCWswav/m3pI2FOTOz0Bz1/tFMuOvLsMekUCKSAx4T
 b2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781511707; x=1782116507;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bU8xcVcSQcyQqF8sn0sSTsDXGvFKJlhzxXL9b2FE8o8=;
 b=oDgsUnisZmmFJOwVt2ItQ56xDK3xWR4FtF0aTvU/2R+mhJg1al9QylVyDsOOM1PjZH
 TD5DLMOvj6YYq4YFliFg++E7X8rObr/HzL64dXgTKFjuyYxcVz2elfyZGlS4vyHuXx46
 1IPZ0GV+biY4hksYRu02zC52ZwReGlKB6Xrif9fzYptULhVO13dUiIJr9RfUePJO+ElM
 A6lMaWEY5CKT4M9rCtCAx2ovMxU1UBbQ1FYvvIBdrdY7hiQW1gxhZA6ImUxpbHYZaT/Y
 prZWiMwvIvFF8EwOFUcFJLtZrP8mq0TYaGVuwHBLQAXLpC71X1AY/d2Wkm/B6pp+JF5e
 zh9A==
X-Gm-Message-State: AOJu0YwWFEIjPm2WVwx4Wi80kgYKLAL5W4a+rrP5QP2npaOUVL/r1Oi1
 TroJyrIYaSBrw6hDQpuQylxY/HCmxHpG+cRGULryRGzUHbBT+sDXRA6SoMememuyQh0=
X-Gm-Gg: Acq92OF02UVpgeCCNVOzR/iSL9JUOu8WM3C4XOEz4AxFMIT3BjnjkhcW7VS3CO3+JSs
 Ibpd00z908RUCv/eqnO8w1SMaKElrc4pLZaRY/IRCkkWVNU6kUzbHkyMs/EL+JUYS2y4S67c+Ft
 JbcTwjm1Z+HY2KmpPTzaShj1cZ1pLX4rydCHPAviAZJW3zpAIUoDpOYjOji0AtSxaDCx81RfRpT
 //59UCBITKUFqSHnYSLNwJgeuR6PQnOpqVladEW8iRlFrdZ+XBMteMh8nHoS7xwGms0ij+Zr2KQ
 fzciZs7sQVApOJGUrsYQC/bAFGUcFZf4qOu6V7w4OVQm+ia8BTAj59MWKZzfWsVk3y39QoitynM
 EKWG4FGktQraRs1sPVJo9dEP36wAk/bUpQvsZwBAtGrGTkuBx1tys4xHhJKKyiscW7AELhaXJEB
 B7nJFQ/PP4aYBn9UynEjC2GP1o1cdNxhTTmyXiPaxj7E1dXRElTeRomy0xAQW87PRk5RV8Hbsis
 pkjCFIoY0O6Eumo7WpY+NQRZXyNKjftb2Q=
X-Received: by 2002:a05:600c:820c:b0:490:c2a3:3302 with SMTP id
 5b1f17b1804b1-490ec526f4fmr168631755e9.35.1781511706515; 
 Mon, 15 Jun 2026 01:21:46 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f23fsm32176683f8f.9.2026.06.15.01.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 01:21:46 -0700 (PDT)
Message-ID: <6a2fb61a.53cb9477.13cf23.546d@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260612171415.988-1-always.starving0@gmail.com>
Date: Mon, 15 Jun 2026 08:21:45 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] power_management: rewrite runpwtests04.sh in C
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSmluc2VvaywKCkkgY2FuJ3QgdW5kZXJzdGFuZCB0aGUgdXRpbGl0eSBvZiB0aGlzIHRlc3Qg
aG9uZXN0bHkuIFdlIGFyZQpjaGVja2luZyBpZiBhbiBvYnNvbGV0ZSBBQkkgWzFdIHN1Y2ggYXMK
L3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1aWRsZS9jdXJyZW50X2dvdmVybm9yX3JvIGlzIGFj
dHVhbGx5CnJlYWRhYmxlLiBUaGF0J3Mgb2ssIGl0J3Mgc3RpbGwgdGhlcmUgYXQgbGVhc3QuIEFs
c28sIHdlIGFyZSBub3QKY2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvciBpZiB0aGUgZmlsZSBp
cyBub3Qgd3JpdGFibGUuCgpXZSBhbHNvIGhhdmUgb3RoZXIgQUJJIFsyXSB0byB0ZXN0LgoKU2Fp
ZCBzbywgaXQgd291bGQgYmUgYmV0dGVyIHRvIF9hdCBsZWFzdF8gdmVyaWZ5IHJlYWQvd3JpdGUg
YW5kCnJldHVybiB2YWx1ZSBvZiBgZW5vdWdoYCBBQkkgaW5zaWRlIC9zeXMvZGV2aWNlcy9zeXN0
ZW0vY3B1L2NwdWlkbGUvCndoaWNoIGFyZSBub3Qgc3ViamVjdCB0byBkcml2ZXJzIGJlaGF2aW91
cnMuIEluIHBhcnRpY3VsYXI6CgotIGF2YWlsYWJsZV9nb3Zlcm5vcnMgKHJvKSDigJQgbGlzdHMg
cmVnaXN0ZXJlZCBpZGxlIGdvdmVybm9ycwotIGN1cnJlbnRfZHJpdmVyIChybykg4oCUIHNob3dz
IHRoZSBhY3RpdmUgY3B1aWRsZSBkcml2ZXIgbmFtZQotIGN1cnJlbnRfZ292ZXJub3IgKHJ3KSDi
gJQgc2hvd3Mvc2V0cyB0aGUgYWN0aXZlIGlkbGUgZ292ZXJub3IKLSBjdXJyZW50X2dvdmVybm9y
X3JvIChybykg4oCUIHJlYWQtb25seSB2aWV3IG9mIGN1cnJlbnQgZ292ZXJub3IKCj4gK3N0YXRp
YyB2b2lkIHNldHVwKHZvaWQpCj4gK3sKPiArCWlmIChhY2Nlc3MoQ1BVSURMRV9QQVRILCBSX09L
KSkKPiArCQl0c3RfYnJrKFRDT05GLCAiJXMgaXMgbm90IGF2YWlsYWJsZSIsIENQVUlETEVfUEFU
SCk7CgpJbnN0ZWFkIG9mIHRoaXMgY2hlY2sgd2Ugc2hvdWxkIHVzZSAuc2F2ZV9yZXN0b3JlIHdp
dGggVFNUX1NSX1RDT05GLgoKWzFdIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0
ZXN0L2FkbWluLWd1aWRlL2FiaS1vYnNvbGV0ZS1maWxlcy5odG1sI2FiaS1maWxlLW9ic29sZXRl
LXN5c2ZzLWNwdWlkbGUKWzJdIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0
L2FkbWluLWd1aWRlL2FiaS10ZXN0aW5nLmh0bWwjYWJpLXN5cy1kZXZpY2VzLXN5c3RlbS1jcHUt
Y3B1aWRsZS1hdmFpbGFibGUtZ292ZXJub3JzCgoKUmVnYXJkcywKLS0KQW5kcmVhIENlcnZlc2F0
bwpTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKYW5kcmVhLmNlcnZlc2F0b0BzdXNl
LmNvbQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
