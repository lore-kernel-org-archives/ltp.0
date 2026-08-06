Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16FAC561E6
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 08:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786005448; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lRW1sPgicqglYhtu5Y71VuZKzCzxsydgEHik5hCPpcw=;
 b=BBKnRpHTUenRJcjFD8ANNRrQ0qmUiLM1zhv3u6fmmpW62P8SKeTbuqdT/+XzTWbm07234
 7e97U98AEXIIAcLZj83HdOcgYpQ6kunkbq24vKz56Ads6rBnSwOB3klkk1kZ6/R14xmcQlt
 iA+eJlpfzCMPC/CETi24hoPl/af9lCo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45E003C2BE6
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 10:37:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B0943C2804
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 10:37:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A4BE31400965
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 10:37:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786005424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GQFpJF5MAaz+FIIsXXRJ1LChvp/dCfwBouxOZJKhsc=;
 b=GCvaOzZVPAjG5JaAnpQWAyv+LwAvLMZ7fQUrew6oyMPwAwKsvnJFeHZ9fB97Sq+HXPTuc7
 M85+4GG7HNDr6a59CQtIo8wfq8MqRtetFF4gkRDeChCwgnwPdUPPdjJn+5U6bBXv7wdAIo
 lxOe/WMzRhVdnCPj1jo5AhpKEJnQFzM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-nVhM8FarOTOOaVtucc2fNw-1; Thu, 06 Aug 2026 04:37:02 -0400
X-MC-Unique: nVhM8FarOTOOaVtucc2fNw-1
X-Mimecast-MFC-AGG-ID: nVhM8FarOTOOaVtucc2fNw_1786005422
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955fd77c18so11487485e9.2
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 01:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786005421; x=1786610221;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1GQFpJF5MAaz+FIIsXXRJ1LChvp/dCfwBouxOZJKhsc=;
 b=e1GN62m64DBm+0joNgU9XRuZkj640m2U/+3QzYUEtJF4SQyJUV2I2ua3ccwbfo/H0c
 2hk5E5EUBnNe0I8ayHsJ1mIPTL+q/1hjsPHOcPsPiP91BihNtHf332aWJiY7s1O9qnyp
 MF1s7AuCNLc8tDYJwYsyzfHkX991dUPeaX8r2/q+GgJ3ngtDe+DMh/YE1K51bFTuACvy
 Ig0zOewmNvBGsYUQ1g5x5+z9eS3KNOHsNuQSItWettUSScaJgOpu1mJA+iaAN2qbAHFy
 Ts+vilOj/eOUZzM7sh8Cuum6yZrBJZV93JGs/OW5CdWcs13LtJiOoGcUUCzx+Aeq/Lfs
 4+6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFmNx7S38sXjh6lThgqkKppbrTWk4GSovJTssfIV9qEuWX+JYMsanjFtNouwkFdVQ29uI=@lists.linux.it
X-Gm-Message-State: AOJu0Yz5d8OcuUHOTEil/Tc2CXeUsKbkxxfi1FL4+yc7orDh56l165yI
 1Ejd36uVVyROOlVlpnQosZEzr7NMQX+jwxXZhXBxc/sGdRouMiIT48SnfEIZOKs3r/kKDPZp8Pz
 PI7iYGUUJ4NEgrfojo+IkLm0nngZ7jfCekqMv0RgHu4EzLNaC5bd7yyxepLQXR2eDj/8+lpO6ln
 K7Y3o8mxvv96fV0f7N8uNnsfUHHDs=
X-Gm-Gg: AR+sD13BCfA9sqOgH8V3QGN8M9M3QJY4gV+qJqM/uQYveETIcjpYDKT28qo54Rzdm+s
 AhwvoEZP42SjvSkHMBIQsJgkOXt9Sv8y1uc/4XJuRZInZqS3AbwLJoIvYM8TTiXkenIqg5uJ0qo
 T1MgAXQWuq/6j/+VItL5eg+FZj2NQdFQW8SXaBMOw00rfGYrMCMogZUIk=
X-Received: by 2002:a05:600c:e549:10b0:495:6934:414c with SMTP id
 5b1f17b1804b1-4994e7df489mr139962045e9.19.1786005421646; 
 Thu, 06 Aug 2026 01:37:01 -0700 (PDT)
X-Received: by 2002:a05:600c:e549:10b0:495:6934:414c with SMTP id
 5b1f17b1804b1-4994e7df489mr139961575e9.19.1786005421239; Thu, 06 Aug 2026
 01:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260805145213.3066-1-always.starving0@gmail.com>
 <20260805154727.GB649402@pevik>
In-Reply-To: <20260805154727.GB649402@pevik>
Date: Thu, 6 Aug 2026 10:36:44 +0200
X-Gm-Features: AUfX_mwbkxo8zVzp2PX8tLR_lPNZoEMRP6SK0bY4FO3fVauX7w38AdMbyhVGWs4
Message-ID: <CAASaF6yfmq8FPtVVzQjG3PFRNkJbJKdWUUM1GiXV-xaQdQwR8w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ea68jSF2MYbYfAfttF4QdgYi74W-UbnLKBY0AcFgOQ0_1786005422
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] power_management: rewrite runpwtests04.sh in C
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBBdWcgNSwgMjAyNiBhdCA1OjQ44oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+Cj4gSGkgSmluc2VvayBLaW0sCj4KPiBbQ2MgSmFuIF0KCkNDIG1haWxpbmcg
bGlzdAoKPgo+ID4gKy8qXAo+ID4gKyAqIEJhc2ljIGNwdWlkbGUgc3lzZnMgc21va2UgdGVzdC4K
PiA+ICsgKgo+ID4gKyAqIFZlcmlmeSB0aGF0IHNlbGVjdGVkIGNwdWlkbGUgc3lzZnMgZmlsZXMg
YXJlIHJlYWRhYmxlIGFuZCBjb250YWluCj4gPiArICogbm9uLWVtcHR5IHZhbHVlcy4gQWxzbyB2
ZXJpZnkgdGhhdCBjdXJyZW50X2dvdmVybm9yIHJlamVjdHMgYW4KPiA+ICsgKiBpbnZhbGlkIGdv
dmVybm9yLgo+ID4gKyAqCj4gPiArICogUm9vdCBwcml2aWxlZ2VzIGFyZSByZXF1aXJlZCB0byB3
cml0ZSB0byBjdXJyZW50X2dvdmVybm9yLgo+ID4gKyAqLwo+ID4gKwo+ID4gKyNpbmNsdWRlIDxl
cnJuby5oPgo+ID4gKyNpbmNsdWRlIDxmY250bC5oPgo+ID4gKyNpbmNsdWRlIDx1bmlzdGQuaD4K
PiA+ICsKPiA+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPiA+ICsKPiA+ICsjZGVmaW5lIENQVUlE
TEVfUEFUSCAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1aWRsZSIKPiA+ICsjZGVmaW5lIEFW
QUlMQUJMRV9HT1ZFUk5PUlMgQ1BVSURMRV9QQVRIICIvYXZhaWxhYmxlX2dvdmVybm9ycyIKPiA+
ICsjZGVmaW5lIENVUlJFTlRfRFJJVkVSIENQVUlETEVfUEFUSCAiL2N1cnJlbnRfZHJpdmVyIgo+
ID4gKyNkZWZpbmUgQ1VSUkVOVF9HT1ZFUk5PUiBDUFVJRExFX1BBVEggIi9jdXJyZW50X2dvdmVy
bm9yIgo+ID4gKyNkZWZpbmUgQ1VSUkVOVF9HT1ZFUk5PUl9STyBDUFVJRExFX1BBVEggIi9jdXJy
ZW50X2dvdmVybm9yX3JvIgo+ID4gKwo+ID4gK3N0YXRpYyB2b2lkIHZlcmlmeV9yZWFkYWJsZShj
b25zdCBjaGFyICpwYXRoKQo+ID4gK3sKPiA+ICsgICAgIGludCByZXQ7Cj4gPiArICAgICBjaGFy
IGJ1ZlszMl07Cj4gPiArCj4gPiArICAgICBpbnQgZmQgPSBvcGVuKHBhdGgsIE9fUkRPTkxZKTsK
PiA+ICsKPiA+ICsgICAgIGlmIChmZCA8IDApIHsKPiA+ICsgICAgICAgICAgICAgaWYgKGVycm5v
ID09IEVOT0VOVCkKPiA+ICsgICAgICAgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05GLCAiJXMg
aXMgbm90IGF2YWlsYWJsZSIsIHBhdGgpOwo+IFdoaWxlIHRoaXMgd29ya3MsIHdlIGhhdmUgLnNh
dmVfcmVzdG9yZSwgeW91IHdvdWxkIHVzZSBpdCB3aXRoIFRTVF9TUl9UQ09ORl9NSVNTSU5HCj4g
aHR0cHM6Ly9saW51eC10ZXN0LXByb2plY3QucmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2RldmVs
b3BlcnMvYXBpX2NfdGVzdHMuaHRtbCNzYXZpbmctYW5kLXJlc3RvcmluZy1wcm9jLXN5cy12YWx1
ZXMKPgo+IEJ1dCBiZWNhdXNlIHRoYXQgd291bGQgc2tpcCB3aG9sZSB0ZXN0aW5nIGlmIG9uZSBv
ZiB0aGVtIGlzIG1pc3NpbmcsIG1heWJlCj4gaW5zdGVhZCBlYWNoIHRlc3QgZnVuY3Rpb24gc2hv
dWxkIGNoZWNrIHdpdGggdHN0X3N5c19jb25mX3NhdmUoKS4KPgo+IEBKYW4gT3Igc29tZXRoaW5n
IGVsc2Ugd291bGQgYmUgbW9yZSBhcHByb3ByaWF0ZSB0aGFuIGxpYi90c3Rfc3lzX2NvbmYuYyB0
byBqdXN0Cj4gZGV0ZWN0IHBhdGggZXhpc3RlbmNlPwoKdHN0X3BhdGhfZXhpc3RzKCkgICsgRklM
RV9TQ0FORigpIHBlcmhhcHMsIGFuZCB5b3UgcmVwb3J0IGFnYWluIGVycm9ycwpmcm9tIEZJTEVf
U0NBTkYoKSBhcyBURkFJTAoKPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
