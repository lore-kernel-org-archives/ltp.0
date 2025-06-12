Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57920C61CE8
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 05:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749704943; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fHkMfl9SniZmQWCVm7f/O06BPldEZi2SKXO/rt0/kKY=;
 b=QW0H7RtKNYDfgy6REcoi4+5JkauvDVuZnVsBD+WkcKf1j00Y289Dfc74UJuF+H89tGf8m
 qx+16y6XgUPh4ZXnpx1lBFZvHQlGq+EblpTr9Kp8/+wCBsQaroo1+zv5eHoJDgA2tOheqvn
 guK+oZE8VcS6oFV0n///fsgo0M9v8uo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC2DF3CB2A1
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 07:09:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B205F3CB295
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 07:08:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07BBC6002C8
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 07:08:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749704910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJjNdw5pqXr8iLI2F3bLdgs0EcM+n0NGxsCpHDx1rhU=;
 b=XbgOJNBLlkTr7JSll7w2iidHuaesnOdSYBK+fmyOYvPlsEbGldE992ZRz8hIAknEEhmOT/
 EX2bQ9sABYPEHTx6SfKGIK11Egn7kz1Du1tnY2hCpj5gFxFGgTGnsKGv7hJ4MNuxAyoZvV
 h5Cm/1oej6goM05a/BGuJFGRiuknaLE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-SwSmsqIaMvi8kGcqOgjZ1A-1; Thu, 12 Jun 2025 01:08:28 -0400
X-MC-Unique: SwSmsqIaMvi8kGcqOgjZ1A-1
X-Mimecast-MFC-AGG-ID: SwSmsqIaMvi8kGcqOgjZ1A_1749704908
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b16b35ea570so531785a12.0
 for <ltp@lists.linux.it>; Wed, 11 Jun 2025 22:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749704907; x=1750309707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iJjNdw5pqXr8iLI2F3bLdgs0EcM+n0NGxsCpHDx1rhU=;
 b=WWZN9FrjC5VUqUUFaf9PCHgcdrgC6B67j/L1Wz3qE2cs6JF60NC/Y0U6T1nY8kogww
 cQdZhXjYlz8mKjwGhI/eUNXrbO1n54Ophunsb1CaUA5HnAzO1P9al2jYilBmU1uTIZBJ
 iM3LDaiEo+bxMheR3l4VEJ+vIxzhuRPqY7TFwaSwD0kCHK1GiPqsEjzncSNBzNuVIfCB
 k3tJTb/970TnAmcT5YTg7t/kO3NySklDHzSU7aQVw9hk00s6HGykpnrkBo06KCfikT2O
 eJGnz4GSgLDjU+zqMeF7c4MS24U1s68cHtXwPNayyf9mlDUwqFvfH+bSN5dTSuxsi9Bj
 50nw==
X-Gm-Message-State: AOJu0Yw7CuCbE1hdZ+mIzDLlatCpCrlf/n4d5UMHaSf0k94KSjA/WSMv
 XKNxh2IfniFwYGl0cdlkMWGQD9qFufuyNbWuH90920wbBj2uxzXizJtrWD08yJZsDGHO/VhFs/s
 vFGN+xh2y0bIiCPkHDVaZilBU1VrJAZ42o0cbhMU2pOvYy6HjHmanzW483NbHmXqd+Sp1ept+TP
 rAiuzNqhan3fGLHCqLc+FzB3cNF8Y=
X-Gm-Gg: ASbGnctZn/nSsRHxHpAEMICJ9C2pHIqD/gwjXJnf6f0Qo9A/jP04Wa6Cc1kwhl/3w7s
 t/LFrtPPsyWNkGHEYWOUf4wCB1bEWT0OiE8WAGS99gtq3Jq/IWy7et9uAwKUNfBipriDuqbvCoe
 /J7/ce
X-Received: by 2002:a17:90b:528d:b0:313:14b5:2525 with SMTP id
 98e67ed59e1d1-313c08dc6aamr2685256a91.35.1749704906858; 
 Wed, 11 Jun 2025 22:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH65/MhX+X1+FVLaOyUEEClshe3MMkqVBUcdWECEqoBwN9IZMW/0ir7qYuAwbVlZhiZo7TFk+PZfZ0RLkHtzxQ=
X-Received: by 2002:a17:90b:528d:b0:313:14b5:2525 with SMTP id
 98e67ed59e1d1-313c08dc6aamr2685233a91.35.1749704906524; Wed, 11 Jun 2025
 22:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250609124506.1454420-1-pvorel@suse.cz>
 <20250609124506.1454420-5-pvorel@suse.cz>
In-Reply-To: <20250609124506.1454420-5-pvorel@suse.cz>
Date: Thu, 12 Jun 2025 13:08:12 +0800
X-Gm-Features: AX0GCFv7qnftjx0mEhulQxdVbRfOPSqwcH5JlQ7O1uncYNxv4BD6HYhG5knkbB8
Message-ID: <CAEemH2f3BeOq-H4tnVox54MSrirm_KgcjkvJ86BwgtdwJLhRdw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pt2GIj65iBzL4BKEK0hVjLiKnZsZmBxhFHqoTpmdUcU_1749704908
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 4/4] shell: Add shell_loader_setup_cleanup.sh
 test
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

T24gTW9uLCBKdW4gOSwgMjAyNSBhdCA4OjQ14oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4K
PgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKLS0tCj4gVGhlIHNh
bWUgYXMgaW4gdjIuCj4KPiAgdGVzdGNhc2VzL2xpYi9ydW5fdGVzdHMuc2ggICAgICAgICAgICAg
ICAgICAgIHwgIDEgKwo+ICAuLi4vbGliL3Rlc3RzL3NoZWxsX2xvYWRlcl9zZXR1cF9jbGVhbnVw
LnNoICAgfCAzMSArKysrKysrKysrKysrKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5z
ZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdGNhc2VzL2xpYi90ZXN0cy9zaGVs
bF9sb2FkZXJfc2V0dXBfY2xlYW51cC5zaAo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIv
cnVuX3Rlc3RzLnNoIGIvdGVzdGNhc2VzL2xpYi9ydW5fdGVzdHMuc2gKPiBpbmRleCAxMjhjZWUz
Mzc3Li41YzMwOWJiZWI1IDEwMDc1NQo+IC0tLSBhL3Rlc3RjYXNlcy9saWIvcnVuX3Rlc3RzLnNo
Cj4gKysrIGIvdGVzdGNhc2VzL2xpYi9ydW5fdGVzdHMuc2gKPiBAQCAtMTAsNiArMTAsNyBAQCBz
aGVsbF9sb2FkZXJfa2NvbmZpZ3Muc2gKPiAgc2hlbGxfbG9hZGVyX3N1cHBvcnRlZF9hcmNocy5z
aAo+ICBzaGVsbF9sb2FkZXJfdGNudC5zaAo+ICBzaGVsbF9sb2FkZXJfY2xlYW51cC5zaAo+ICtz
aGVsbF9sb2FkZXJfc2V0dXBfY2xlYW51cC5zaAo+ICBzaGVsbF90ZXN0MDEKPiAgc2hlbGxfdGVz
dDAyCj4gIHNoZWxsX3Rlc3QwMwo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbGliL3Rlc3RzL3No
ZWxsX2xvYWRlcl9zZXR1cF9jbGVhbnVwLnNoCj4gYi90ZXN0Y2FzZXMvbGliL3Rlc3RzL3NoZWxs
X2xvYWRlcl9zZXR1cF9jbGVhbnVwLnNoCj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUKPiBpbmRleCAw
MDAwMDAwMDAwLi44MTg0Mjc4MzEzCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBiL3Rlc3RjYXNlcy9s
aWIvdGVzdHMvc2hlbGxfbG9hZGVyX3NldHVwX2NsZWFudXAuc2gKPiBAQCAtMCwwICsxLDMxIEBA
Cj4gKyMhL2Jpbi9zaAo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyCj4gKyMgQ29weXJpZ2h0IChjKSAyMDI1IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+
ICsjCj4gKyMgLS0tCj4gKyMgZW52Cj4gKyMgewo+ICsjIH0KPiArIyAtLS0KPiArCj4gK1RTVF9T
RVRVUD1zZXR1cAo+ICtUU1RfQ0xFQU5VUD1jbGVhbnVwCj4gKwo+ICsuIHRzdF9sb2FkZXIuc2gK
PiArCj4gK3NldHVwKCkKPiArewo+ICsgICAgICAgdHN0X3JlcyBUSU5GTyAic2V0dXAgZXhlY3V0
ZWQiCj4gK30KPiArCj4gK2NsZWFudXAoKQo+ICt7Cj4gKyAgICAgICB0c3RfcmVzIFRJTkZPICJD
bGVhbnVwIGV4ZWN1dGVkIgo+ICt9Cj4gKwo+ICt0c3RfdGVzdCgpCj4gK3sKPiArICAgICAgIHRz
dF9yZXMgVFBBU1MgIlRlc3QgaXMgZXhlY3V0ZWQiCj4gK30KPiArCj4gKy4gdHN0X3J1bi5zaAo+
IC0tCj4gMi40OS4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
