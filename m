Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C6BCD5BB1
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 18:37:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 745DF3C72A7
	for <ltp@archiver.kernel.org>; Tue, 26 May 2026 20:37:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4349E3C59CC
 for <ltp@lists.linux.it>; Tue, 26 May 2026 20:36:50 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B85A660093F
 for <ltp@lists.linux.it>; Tue, 26 May 2026 20:36:49 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50faeb8317bso99767781cf.2
 for <ltp@lists.linux.it>; Tue, 26 May 2026 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779820608; x=1780425408; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mwg0IRzQr43Ir7n24+UrYbMVBQsY4yGJXh2G+HB8IP8=;
 b=dKyOYXakMROrTHt8IukGJaThVLcLUgyEMBbeKJ/gp20TdDeVlb27C+TiAZz+UJpF/9
 JCu+YVovOpqj2LbKSXBmc3O64f4R3Iq6HueTpvlplsKgTPRZ4mzLsQe4MkHktcxHaGm7
 4SGhjsa1mOnUfpjyGFhgjvGJRwJ+z8xXT2yb+4asTgmS+L0jt5EAQAKpCqJEOinx4+2/
 CVegUPGhfTjzryeTYH0NKRw44YFGupvLld5Qs+451dLCEQ0jUcmjiIIhuz1ZqIjql4r/
 5b8fkNGljbIfO+bf1vZeT4naF3nJO9gN/0uvQstvBa/ndGb/tAU1gUW3stQblUe71lwI
 8cLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779820608; x=1780425408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mwg0IRzQr43Ir7n24+UrYbMVBQsY4yGJXh2G+HB8IP8=;
 b=pEmhfS5qkVXVq6g6FpQZWdCm6/TShqnrqU1xy25uUCG2ROLwxkmUTrWg1uG6+kXQAL
 jh8/5K5f1WM84QHur4m0DOFBKG0tIDgbGzCKXkO26ZVFf5i+Kj12/8qBy5Xg1cIMbu+9
 XbMUeFvmwhUt+uMsxz/utaZMquWovtDSCQvr1uFqfqift1iuvusiBui4Xcmk1sumFm7z
 h++ZtNM0FF8kGeLrA4Omz0L+9kfHDkqAKIEy0i1Pe5rssM0ywdf+78mKlkg2q5Dl1k2r
 KRcN2isHqWWyAoUDTfeXak+ito9YpzhGwTZJhCypmYoQbfdhCZuyJtF6JALNGZd6AQ8G
 tXqQ==
X-Gm-Message-State: AOJu0YydfAaqW52z/GL47IOeX8ESSxO4lPz1tHwmafxw2tc73Yx0XXuU
 Ldy0bRzH4RdH/yBUIoRJhK62ctGrLjM87u34k+LGC/wMHS3I7MlYRaV8
X-Gm-Gg: Acq92OGhiq1l7KMOIvn9Pr2YWBMa1g/7GQVERiUW7Eqj0O2xqcUcSO9MXx8sq21Wcgt
 Je4qzu0m/dXGqxQQ5aXbsEHB9TboBtO7mLqBYxXtfZ9KrdVjHLBmKdHb5HAMoWq5A2N3jyM9wGw
 ClqI5x04pqzF9Cw6it5Ux2f9pD+p49vU2TPwM95lBTE32o/SqmJgME6rDH0PwL2t/tMkWPHi7Jv
 Gj1E34dYpzDWSecWbmXbl3DGEV5gYeotpEQ+i2cWMidQdyjZi12H2Hnm50lJgIjr/zwEcsUmjBE
 2BUjvRfWly6kv4gNXy5vAgdcsM6L2+vIYVOxilZz3BNXBXGMM8P3VfVKKvyV8eUxaEWhlyGIlCJ
 OEOXkirkapc9zN8evbxkY+b/V1Msnf3+g2lco+TDrgEAr9EkpfNI5EhiaUTRj3ym7kWCvq2aeeH
 ZmOoAnYnUr36kpSRWvIz+KlUsS6bXfagJooXxDZ+3GrE3ISBD/BVj2/b2ixM8lMxIvQgqxP0wcc
 bpxley88BRskbMMQ+vySSIIkYv6NOTo4a1KAn/bijYhaRvS
X-Received: by 2002:ac8:5849:0:b0:50e:60a0:acb4 with SMTP id
 d75a77b69052e-516d45c850cmr258581791cf.44.1779820608380; 
 Tue, 26 May 2026 11:36:48 -0700 (PDT)
Received: from
 runnervmg397c.3yfpea4z2k4uzlvhpxuwhmis4f.cx.internal.cloudapp.net
 ([68.154.54.32]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5170691af70sm28916281cf.0.2026.05.26.11.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 11:36:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Michael Menasherov <mmenashe@redhat.com>
Date: Tue, 26 May 2026 18:36:47 +0000
Message-ID: <20260526183647.4070-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526152613.109485-2-mmenashe@redhat.com>
References: <20260526152613.109485-2-mmenashe@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] futex_wait06: Add EFAULT error coverage test
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

SGkgTWljaGFlbCwKCk9uIFR1ZSwgMjYgTWF5IDIwMjYsIE1pY2hhZWwgTWVuYXNoZXJvdiB3cm90
ZToKPiBbUEFUQ0ggMS80XSBmdXRleF93YWl0MDY6IEFkZCBFRkFVTFQgZXJyb3IgY292ZXJhZ2Ug
dGVzdAoKLS0tIFtQQVRDSCAxLzRdIC0tLQoKPiArICogQ29weXJpZ2h0IChDKSAyMDI2IFJlZCBI
YXQsIEluYy4gTWljaGFlbCBNZW5hc2hlcm92IDxtbWVuYXNoZUByZWRoYXQuY29tPgoKTm9uLXN0
YW5kYXJkIGNvcHlyaWdodCBmb3JtYXQg4oCUIGNvbXBhbnkgbmFtZSBhbmQgYXV0aG9yIGFyZSBj
b25jYXRlbmF0ZWQuClVzZSBvbmUgb3IgdGhlIG90aGVyOiBlaXRoZXIgIlJlZCBIYXQsIEluYy4i
IG9yICJNaWNoYWVsIE1lbmFzaGVyb3YKPG1tZW5hc2hlQHJlZGhhdC5jb20+Ii4gU2FtZSBpc3N1
ZSBpbiBwYXRjaGVzIDLigJM0LgoKLS0tIFtQQVRDSCAyLzRdIC0tLQo+IFtQQVRDSCAyLzRdIGZ1
dGV4X3dhaXQwNzogQWRkIEVJTlRSIGVycm9yIGNvdmVyYWdlIHRlc3QKCj4gKwlUU1RfUFJPQ0VT
U19TVEFURV9XQUlUKGNoaWxkLCAnUycsIDApOwo+ICsJU0FGRV9LSUxMKGNoaWxkLCBTSUdVU1Ix
KTsKPiArfQoKcnVuKCkgcmV0dXJucyB3aXRob3V0IHdhaXRpbmcgZm9yIHRoZSBjaGlsZC4gQWRk
IFNBRkVfV0FJVFBJRChjaGlsZCwgTlVMTCwgMCkKYWZ0ZXIgU0FGRV9LSUxMIHRvIGVuc3VyZSB0
aGUgY2hpbGQgaGFzIGV4aXRlZCBhbmQgaXRzIHJlc3VsdCBpcyBjb2xsZWN0ZWQKYmVmb3JlIGNs
ZWFudXAoKSBydW5zLgoKWy4uLl0KClBhdGNoZXMgMy80IGFuZCA0LzQgbG9vayBnb29kLgoKLS0t
Ck5vdGU6CgpUaGUgYWdlbnQgY2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBh
bHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3Vl
cyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRo
ZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
