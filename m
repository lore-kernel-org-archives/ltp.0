Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E034DCD5BB1
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 17:11:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03D993E1DBA
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:11:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 923143E1BD7
 for <ltp@lists.linux.it>; Mon, 25 May 2026 19:10:53 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3CBB610006CF
 for <ltp@lists.linux.it>; Mon, 25 May 2026 19:10:52 +0200 (CEST)
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8b4eb1fd5d0so121124726d6.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779729051; x=1780333851; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/d0yN8Ht3EUqszd7rLCyqO6iI76qEQWm8GeFBnpC0HY=;
 b=jy4TFAMEWyYHfoi/x/eyquPLtK//tabVYVXoaU12bXq8xhc+rD+5sFwsF2f/eGpUvY
 54kTC2a8YY6oE3FyF8SW2DIJKHZCaKqvNt0OfHuMv6/tVqyZxg1tPeQq0PjMLI755lFA
 7sGoU8I+/zvgJu6xa/BrVz0EwZotpCmmekccr1in5E6CNvmtS4VDlPxPWqgMnV9yUerC
 N+xr+gaLATSkKnejUHUjEx+jGaJCkvi4gqMpSp5+Vms4jrB/DG6914RBZPPowCEj4WqQ
 wwjMOF6q4eZpx1CZx/uWL6FoGF16NrsB+idysejpPK7jIY9j4SfN8ZLjp+eWoHyBLEab
 LE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779729051; x=1780333851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/d0yN8Ht3EUqszd7rLCyqO6iI76qEQWm8GeFBnpC0HY=;
 b=mUVAFL2fB6SGqty6eJFRMZVXtn2neC9j8L8ecnbupomVV9huT/YsK8o9QZtiOJCmh3
 nneJn34dPDgZY6mVAiUl0suMmu0EfOJK8tjoedM8bvRf4Dx1M0phkSIFewnRoVsJ6YO5
 A2GN4EjLuQt02Re8Rrd9CLIhGgtOmt86uwd063qgWBSaJBBJnxVYhaV/A0AZ08ibwe+P
 USzTzA5Ji6CcbJgce3kzneXGVaI0wJZFjAtnZl1PWEzF0Kkurln3C5/WpXWvFNHEdGrK
 VFPycnQZzllamaxdGFK6yzOd05JkTZeWGXbn8QofKEQphpzmwyrk4Yq3UlHt+jCPl/so
 XlNA==
X-Gm-Message-State: AOJu0YxQ/lhx+Q4ngvFURWwJevcpTXbUogTM+bftCyJwq/jBXVUt11AS
 ur4Qcp8c0xdEwu4xhEMB4fI0ePHiJe4hdU33hy3RcUPGewa276baSw1c
X-Gm-Gg: Acq92OHRrTrYtwpL3xGfIrISvn23FltIEeIU/3yx6Th2yAjwQyfRdLPn3sZiY02u1rF
 FPwY/CyZdDkxAD7pvAdQOwTMKgMT1vsOmDt3apcOCjLpPJAhLEvG+Cwgx4JzOxAKSi8Ns36+OZZ
 fU1bBaeVnt2+USha70bmAhJf561QACh3CbpCGaHCXh7HYCpV5qZx0o80mkB/174HpirlnFMOTn1
 u4CvM+gkF0PPDvq5Z0iuMITEgywURxtdoOMWs9ju9Nz9WOXrKpJ+VX7VU0Zqe/CAI+KEd5dEkm4
 Av75ScQknsRVtR/t9ENk2Bxtzb3NK+oALkAMUwaZGyHXIj/f/mj1hRc6nfdK0PjRaE6nn5+hQqo
 ZUmInauuxCKDh1cp1ZtfG4eoN+Owf8NHWqVU/vNIOvPzj5NyAnYSv6iS0JG2jflV0UvAKSBC5la
 j7u7BbZJfZ4b/99POPAroRdTh3bn4iylJVvjrD1iaDKtqi69KWtAGLRwQJKoFQDCwsMOM9PRdBx
 DItY4c/MmAq/Gi+JtkSzkWAtc06T8J9cIy/
X-Received: by 2002:a05:6214:5c06:b0:8ca:21b5:2e3f with SMTP id
 6a1803df08f44-8cc7b5003eamr250045426d6.6.1779729050938; 
 Mon, 25 May 2026 10:10:50 -0700 (PDT)
Received: from
 runnervmg397c.umeiy342tu3uhnvuif2sqfdcqd.bx.internal.cloudapp.net
 ([20.25.34.43]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc80decd31sm112848916d6.13.2026.05.25.10.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:10:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 May 2026 17:10:49 +0000
Message-ID: <20260525171049.3976-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151449.203586-2-chrubis@suse.cz>
References: <20260525151449.203586-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] safe_macros: Add SAFE_READ_ANY_EAGAIN
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

SGkgQ3lyaWwsCgpPbiBNb24sIDI1IE1heSAyMDI2IDE3OjE0OjQ4ICswMjAwLCBDeXJpbCBIcnVi
aXMgd3JvdGU6CgotLS0gW1BBVENIIDEvMl0gc2FmZV9tYWNyb3M6IEFkZCBTQUZFX1JFQURfQU5Z
X0VBR0FJTiAtLS0KCj4gU2ltaWxhcmlseSB0byB0aGUgc2FmZV93cml0ZSgpIHRoaXMgdHVybnMg
dGhlIGxlbl9zdHJpY3QgaW50byB0aHJlZSB3YXkKPiBzd2l0Y2ggd2l0aCB0aGUgbmV3IHZhbHVl
IFNBRkVfUkVBRF9BTllfRUFHQUlOPTIgdGhhdCB0dXJucyBFQUdBSU4gaW50bwo+IGEgcmVhZCB3
aXRoIGEgemVybyBsZW5naHQuCgpzL1NpbWlsYXJpbHkvU2ltaWxhcmx5Lywgcy9sZW5naHQvbGVu
Z3RoLwoKPiArZW51bSBzYWZlX3JlYWRfb3B0cyB7Cj4gKwkvKiBubyBsZW5naHQgc3RyaWN0bmVz
cywgc2hvcnQgcmVhZHMgYXJlIG9rICovCj4gKwlTQUZFX1JFQURfQU5ZID0gMCwKPiArCS8qIHN0
cmljdCBsZW5naHQsIHNob3J0IHJlYWRzIHRyaWdnZXIgVEJST0sgKi8KPiArCVNBRkVfUkVBRF9B
TEwgPSAxLAo+ICsJLyogY29udmVydHMgRUFHQUlOIHRvIHJlYWQgdGhhdCByZXR1cm5zIDAgKi8K
PiArCVNBRkVfUkVBRF9BTllfRUFHQUlOID0gMiwKPiArfTsKClRocmVlIGlzc3VlcyBoZXJlOgoK
MS4gImxlbmdodCIg4oaSICJsZW5ndGgiIGluIGJvdGggY29tbWVudHMuCgoyLiBNaXNzaW5nIGJs
YW5rIGxpbmVzIGJldHdlZW4gbWVtYmVycyDigJQgc2FmZV93cml0ZV9vcHRzIHNlcGFyYXRlcyBl
YWNoCiAgIG1lbWJlciB3aXRoIGEgYmxhbmsgbGluZTsgdGhpcyBlbnVtIHNob3VsZCBmb2xsb3cg
dGhlIHNhbWUgc3R5bGUuCgozLiBUaGUgZG91YmxlIGJsYW5rIGxpbmUgYmVmb3JlIHRoZSBlbnVt
IChvbmUgd2FzIGFscmVhZHkgdGhlcmUpIOKAlCBkcm9wCiAgIHRoZSBleHRyYSBvbmUuCgo+ICtl
bnVtIHNhZmVfcmVhZF9vcHRzIHsKPiAuLi4KPiArfTsKClRoZSBzYWZlX3JlYWQoKSBkZWNsYXJh
dGlvbiBhbmQgZGVmaW5pdGlvbiBzdGlsbCB0YWtlIGBjaGFyIGxlbl9zdHJpY3RgCmluc3RlYWQg
b2YgYGVudW0gc2FmZV9yZWFkX29wdHMgbGVuX3N0cmljdGAuIHNhZmVfd3JpdGUoKSB3YXMgdXBk
YXRlZCB0bwp1c2UgYGVudW0gc2FmZV93cml0ZV9vcHRzYCDigJQgZG8gdGhlIHNhbWUgaGVyZSBm
b3IgY29uc2lzdGVuY3k6CgogIHNzaXplX3Qgc2FmZV9yZWFkKGNvbnN0IGNoYXIgKmZpbGUsIGNv
bnN0IGludCBsaW5lbm8sCiAgICAgICAgICAgICAgICAgICAgdm9pZCAoKmNsZWFudXBfZm4pKHZv
aWQpLCBlbnVtIHNhZmVfcmVhZF9vcHRzIGxlbl9zdHJpY3QsCiAgICAgICAgICAgICAgICAgICAg
aW50IGZpbGRlcywgdm9pZCAqYnVmLCBzaXplX3QgbmJ5dGUpOwoKWy4uLl0KCi0tLSBbUEFUQ0gg
Mi8yXSBzeXNjYWxscy9pbm90aWZ5ezA3LCAwOH06IEZpeCBUQlJPSyBvbiBvbGRlciBrZXJuZWxz
IC0tLQoKPiBXaGVuIGtlcm5lbCBmYWlscyB0byBnZW5lcmF0ZSBldmVudHMgdGhlIHJlYWQgcmV0
dXJucyBFQUdBSU4gYW5kIHNpbmNlCj4gd2Ugc3dpdGNoZXMgdG8gU0FGRV9SRUFEKCkgdGhlIHRl
c3RzIG5vdyBUQlJPSyB3aGVuIGtlcm5lbCBkb2VzIG5vdAoKcy93ZSBzd2l0Y2hlcy93ZSBzd2l0
Y2hlZC8KClsuLi5dCgpTdW1tYXJ5OiBwbGVhc2UgZml4IHRoZSB0eXBvcyBpbiB0aGUgY29tbWl0
IG1lc3NhZ2VzIGFuZCBlbnVtIGNvbW1lbnRzLAphZGQgYmxhbmsgbGluZXMgYmV0d2VlbiBlbnVt
IG1lbWJlcnMgdG8gbWF0Y2ggc2FmZV93cml0ZV9vcHRzIHN0eWxlLApkcm9wIHRoZSBleHRyYSBi
bGFuayBsaW5lLCBhbmQgdXBkYXRlIHRoZSBzYWZlX3JlYWQoKSBzaWduYXR1cmUgdG8gdGFrZQpl
bnVtIHNhZmVfcmVhZF9vcHRzLgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSBy
ZXZpZXcgb2YgdGhlIHBhdGNoLiBUaGUgZnVsbCByZXZpZXcgY2FuIGJlCmZvdW5kIGF0OiBodHRw
czovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9hY3Rpb25zCgpUaGUgYWdlbnQg
Y2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMK
ZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcs
IHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJl
Z2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
