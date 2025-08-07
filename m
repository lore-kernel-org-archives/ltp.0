Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB8DC87FCA
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754553453; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dHutxm/cM4k13sdkK1GUYGSY/NBecAav5LD+62kM8Yg=;
 b=UsN0/RFkQK3xGCCl++nq2xDRUcoc2l8LKO5CMnPH+WtL+VCj3gMAg5btmL+ndA5D9Ihsi
 D4vO6GxNt5YSud/sqJiiCFdMl5On8XYr0Cmx3P7/hanIpRD97VENGDxKIz/JGySm/p/pchw
 DhFo57yV6BhwvcBXY7ZvWw8149ZxlXo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 291853C83D9
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 09:57:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 903A63C73A6
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:57:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C755C600274
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:57:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754553427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hw237WQsO9VsIBT/uyx02KWZnFBF3xD0ioDqxUaccas=;
 b=OHiKhzj4veWYW2VDZZsCauHaBtMrrRwoCvpyWnYoC++OVc8U2rVGbDNbYlgWKlb30umAXb
 zkOwqTYIT/OrvnDf2EPsJIbWG40TLuqsJo3jGX7qWhK9zFG/7ZS7/ggCpbnH1eewj5kqWs
 bigoEwpZzvbVkXWrSuOWHSJ9YclQMmA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-4HEb9LNqMNOajFfMmWSxDw-1; Thu, 07 Aug 2025 03:57:05 -0400
X-MC-Unique: 4HEb9LNqMNOajFfMmWSxDw-1
X-Mimecast-MFC-AGG-ID: 4HEb9LNqMNOajFfMmWSxDw_1754553425
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3215b3229c7so903481a91.2
 for <ltp@lists.linux.it>; Thu, 07 Aug 2025 00:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754553425; x=1755158225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hw237WQsO9VsIBT/uyx02KWZnFBF3xD0ioDqxUaccas=;
 b=g2Z+hCugRzNJ1JjW8UlQgBV3INyleVKXokmTL5BM+jEWIKdmt80wUaSZPtycSOmtG7
 bEVmYEZFdsZjwKTrnbSJ2JH8GC5oXl78u8GQkwBneDNcSs5tCU2A/QtnRB7HCRDOoNYa
 imxB8G1qIl7ojTk+3Nl2iLdaewNhhM+i7SY4/W/N4hBogSu+VcUo8hdhsPMxS1YE/tCg
 YaQ65hoK3Kxzo+sgSCWSq1CnJ0p+vBXwPGqwsIBjhet+QWk5Q1Qk1I7r7C8pqcj/ndhF
 m9LcwtYd073WPHjzEFwQ+ztRkNZUtLJoO1aD2G6hhQYoaBqttkBmpQ0BMC55m3CwTUsB
 +k2g==
X-Gm-Message-State: AOJu0YwHSm1RA1VCl04xb5wbloblTa8gJ+Uj/1zUI9xcznCAOjwhsHAB
 YoNxNx+MEw4w/1p+O6oqLlKby4sH6P9ZGsituLUCssJ1zvkTjNVaYpeaKZZMhpnHhUibxCSCzrp
 FpI9EwWCWnN6aEFAFvWB9FvHjPu3SMe943CyvWO4xscGM0RTAbLb44kPdtTsiP7eQx3WCLG2bi7
 Wirnb5tN24CWqt+YeyGu9dx58xulY=
X-Gm-Gg: ASbGncui20FRFQRAoDt3nq/Bx0m68Abp0rHT1t1pvtgAtu9w150g2kely8lSvm85M1M
 XbdZ4d/FDxFsdog0up+NUztmveuLpXdvR7lxGjAorFFkktx5ETCEJdW2GM1tovSMzCKjbiMO8Bj
 R5HznTu+t0NXjI0xE0US5+Hg==
X-Received: by 2002:a17:90b:55d0:b0:315:fefe:bebf with SMTP id
 98e67ed59e1d1-32166c2d3a9mr7380804a91.13.1754553424653; 
 Thu, 07 Aug 2025 00:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaJSSgOK+zOvr9lffnLMxSe9Wdy2ZNz1DybmMUf4/Z4yn+wrPAYmLpgfoVw+YKWbl5MTt8lib2Xah+TNLKRTg=
X-Received: by 2002:a17:90b:55d0:b0:315:fefe:bebf with SMTP id
 98e67ed59e1d1-32166c2d3a9mr7380776a91.13.1754553424153; Thu, 07 Aug 2025
 00:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250806211420.445452-1-pvorel@suse.cz>
 <CAEemH2cgv6vwZvK4J5cquG4=sXt2076CdNtB-fuMzx0+OOFcDw@mail.gmail.com>
 <CAEemH2ddKZwocZbpf9vUVjNssbonifJG5o7hu-PoBggZocXVSA@mail.gmail.com>
 <20250807051133.GA331644@pevik>
In-Reply-To: <20250807051133.GA331644@pevik>
Date: Thu, 7 Aug 2025 15:56:50 +0800
X-Gm-Features: Ac12FXwslAnK8iq_Mny3D_jNK3uBSiifqu9ihv2RIbXPgiQvrN-kTeCyNT7qxuA
Message-ID: <CAEemH2f-YHNh-d28LonDErRiip1PAoBcGOTY-eLW41DecvjTkg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bk7S_2RgxxQwlDKCDqNinRjxXU1MIvs1yXgWFvVBfTU_1754553425
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] Makefile: Add kernel modules related make
 targets
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
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBdWcgNywgMjAyNSBhdCAxOjEx4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwgYWxsLAo+Cj4gPiBPbiBUaHUsIEF1ZyA3LCAyMDI1IGF0IDc6
MjLigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiA+ID4gSGkgUGV0
ciwKPgo+ID4gPiBPbiBUaHUsIEF1ZyA3LCAyMDI1IGF0IDU6MTTigK9BTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+ID4+IExUUCBjb250YWlucyBmZXcga2VybmVsIG1v
ZHVsZXMgYW5kIHRlc3RzIHdoaWNoIGFyZSB1c2luZyB0aGVtLiAgVGhlc2UKPiA+ID4+IHJlcXVp
cmUgdG8gYmUgYnVpbHQgd2l0aCB0aGUgc2FtZSBrZXJuZWwgaGVhZGVycyBhcyB0aGUgcnVubmlu
ZyBrZXJuZWwKPiA+ID4+IChTVVQpLiBTb21ldGltZXMgdGhlIGJlc3Qgd2F5IHRvIGFjaGlldmUg
dGhpcyBpcyB0byBjb21waWxlIHRoZW0gb24KPiB0aGUKPiA+ID4+IFNVVC4KPgo+ID4gPj4gQWRk
ICdtb2R1bGVzJywgJ21vZHVsZXMtY2xlYW4nIGFuZCAnbW9kdWxlcy1pbnN0YWxsJyBtYWtlIHRh
cmdldHMgdG8KPiA+ID4+IG1ha2UgaXQgZWFzaWVyIHRvIGJ1aWxkIHRoZW0uCj4KPgo+ID4gPiBN
YXliZSBiZXR0ZXIgdG8ga2VlcCB0aGUgbWFrZSB0YXJnZXQgY29uc2lzdGVudCB3aXRoIHRoZSBr
ZXJuZWwgYnVpbGQKPiA+ID4gY29tbWFuZDoKPiA+ID4gICBtYWtlIG1vZHVsZXNfaW5zdGFsbAo+
ID4gPiAgIG1ha2UgbW9kdWxlc19jbGVhbgo+Cj4gPiBBbHNvLCBpdCBsb29rcyBsaWtlIExUUCBt
aXhlcyB1c2luZyAiLSIgYW5kICJfIiBpbiBpdHMgbWFrZSB0YXJnZXRzOgo+Cj4gPiAgIGxpYi1h
bGwsIG1ldGFkYXRhLWFsbCwgY2xlYW5faW5zdGFsbF9kaXIsIHZlcl9saW51eAo+Cj4gSSBjaG9z
ZSAnLScgYmVjYXVzZSB0aGF0J3Mgd2hhdCB1c2VzIExUUCBmb3IgbWFrZSB0YXJnZXRzLgo+IHZl
cl9saW51eCB1c2VzIHVuZGVyc2NvcmUgYmVjYXVzZSB0YXJnZXQgaW5oZXJpdHMgaXQgZnJvbSB0
aGUgbmFtZSBvZiB0aGUKPiBmaWxlLgo+Cj4gY2xlYW5faW5zdGFsbF9kaXIgaXMgdGhlIG9ubHkg
dGFyZ2V0IHdoaWNoIHVzZXMgJ18nLCBJJ20gbm90IHN1cmUgd2h5IHRoaXMKPiBpbmNvbnNpc3Rl
bmN5Lgo+Cj4gPiBTbyB3ZSBtYXkgbmVlZCB0byB1c2UganVzdCBvbmUgc2VsZWN0aW9uLCB3aGlj
aCBjYW4gYmUgZG9uZSBpbiBhIHNlcGFyYXRlCj4gPiBwYXRjaCBhbnl3YXkuCj4KPiBJIGdvdCB0
aGUgcG9pbnQgdGhhdCBrZXJuZWwgdXNlcyAnXycuIERvIHdlIHdhbnQgdG8gdW5pZnkgYWZ0ZXIg
eWVhcnMKPiB1c2luZyAnLSc/Cj4gSSdtIG9rIHRvIGRvIHRoZSB3b3JrIGlmIHdlIGNvbnNpZGVy
IGl0J3MgdXNlZnVsLgo+CgpObywgSSBoYXZlIG5vIHByZWZlcmVuY2UgcmlnaHQgbm93LCB0aGUg
cmVhc29uIEkndmUgZGlzY292ZXJlZCBpcyBiZWNhdXNlIG15CmZpbmdlcnMgYXJlIHVzZWQgdG8g
dHlwaW5nICJtYWtlIG1vZHVsZXNfaW5zdGFsbCIgYXMgYSBtdXNjbGUgbWVtb3J5LgoKCkkgcGVy
c29uYWxseSBjb25zaWRlciBtb3JlIGltcG9ydGFudCBmcm9tIHRoZSBsb25nIHRlcm0gdG8gY2hh
bmdlIGJ1aWxkCj4gc3lzdGVtCj4gdG8gbWVzb24gKGRlIGZhY3RvIHN0YW5kYXJkIGZvciB0aGUg
dXNlcnNwYWNlIHByb2plY3RzLCBpbmNsdWRpbmcgdGhlc2UKPiByZWxhdGVkCj4gdG8ga2VybmVs
KS4KPgoKTFRQIGtlZXBzIGdvaW5nIHVzZSBoeXBoZW5zICgnLScpIGluIG1ha2UtdGFyZ2V0cyBz
aG91bGQgYmUgZmluZS4gSGVyZSB3ZQpvbmx5IG5lZWQgdGhhdCB1bmlmaWVkIGJ1dCBub3QgbWl4
ZWQgd2l0aCB1bmRlcnNjb3JlcyAoJ18nKS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
