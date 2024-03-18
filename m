Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640B9C54E5D
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710765616; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Z99LlLD7FRF2XQYcma9xoqe7s7wYgoNDdiR7wVG8x/w=;
 b=iNG3FuwwhISfxjwvkwMdGurCyo/owypgt7JG8KXxTAEzJ5HNYpK8EgdHNhYZK2cqhrDIa
 JOosJA5NPTNwwhnQzFv7Mm1p4nnupSTSwQPju9ASpoWwsAvLgPy9lAgeya5EcNPCEQ6qPgr
 6TbnBXdvZ0g0NWhQc5QghUPlWrUaWnA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F09D3D09E2
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 13:40:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D704C3CDC55
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 13:39:55 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E8CAD1400040
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 13:39:54 +0100 (CET)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513e6777af4so1823678e87.2
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710765594; x=1711370394; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5BWbeMoxS/sCqJC32q46quZdesjatvbfvKSH7KbJ9oU=;
 b=ev6+pPgHiGDYg7Pveb7znrdoTJGQrHBwOh248rDkcVUPtGAPaNT94Nl8Tg5FydH4qO
 qEy2gLe/w1HuBYJM0JRTTWN95CFFxjL1O1dFOktPpFaQX/EzTRGzXtfZiV/zdmovPLNQ
 qVreWcIcpJipDU73Y8vurjIc3eRGzBF/OrOK/eF1SaBzO+kOwE4FntBIyb9P9aR9gaw9
 G+hJJh7Rdtbw2P1hjHHQdmPvXQ1iov+WZid+pce1ktcXyTKtCwa5/db+5dSgqDltX+wX
 IfiicsqXp8Wt+6HEdvgFbcKzCFKnfwyze23JXZK5/cL192ZCxfVnYQkgrIM7XGlLoy0w
 //SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710765594; x=1711370394;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5BWbeMoxS/sCqJC32q46quZdesjatvbfvKSH7KbJ9oU=;
 b=ENI8F3UYH6w4EnOkmZO0el1UWD97u+dCiOl7RPVNmQZk2V44VMAkUCeaV83NJU1DVa
 793EiXlQ1PWK/pceoEMmlSC5dZau0dj51BAJhieBWz9GGf/WhKahvpvya5QnnK/HP70t
 C5FnujzE1bbMIHUYMedDG749ZvuxMvl8U/L1+zFLU3wOMqGXwP/K7LGB1KyL+fDYCNZv
 H0xAoZDvbCZh36CbaVTCKCHsoFnEXdQhKWT7eOWVL/LNmeNOQdA65znNfcbuTOfwSOtJ
 /diDsoFQk7NREj87NRYPv2RZxmrDILrXzci1Mv254ScD91LYWnR3LjH9T1p3w09Y3FBq
 4QbA==
X-Gm-Message-State: AOJu0YyFGjmmwuMazAmgNsq7xG5zLmhMhNxF9GvDaSKsW08FVdmDWYa0
 IGpLm8YFLNbRLShX2zOMgQcqmPvkOI7k9Fq0qs2i5x6OhF3m8bhh4Zh6JEJRHw==
X-Google-Smtp-Source: AGHT+IELIG5QJ/Dzmr0FiDaS2Ka5MJHduvyDKzgonYweggOgjl/0AxYFLcz/0vrXoaSpYGAqXoNl9g==
X-Received: by 2002:a05:6512:3a90:b0:513:cb71:f9b with SMTP id
 q16-20020a0565123a9000b00513cb710f9bmr5640332lfu.68.1710765594077; 
 Mon, 18 Mar 2024 05:39:54 -0700 (PDT)
Received: from wegao.115.61.67 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c1d8500b00414109c66f7sm3046581wms.38.2024.03.18.05.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 05:39:53 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:39:47 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <Zfg2E59Pa1uF84di@wegao.115.61.67>
References: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
 <20240315062448.3181177-1-liwang@redhat.com>
 <ZfP8YEwKpLGweAe1@wegao.29.253.26>
 <CAEemH2e5BB=L6-uT25ppcjGnXqJu7U-MmTCNdFsu8FE3sGv=Lw@mail.gmail.com>
 <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
 <ZfezDUSKwUdoSamA@wegao.215.20.80>
 <CAEemH2cLfO9nMnOdB3wTuK6bmkfsPJp_fdQOXSFU-SfHfdQSZA@mail.gmail.com>
 <Zffm+yWYrGhyVTsf@wegao.213.190.243>
 <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e4iC1+dViTu4WgNz4-BOTg+f9+9sggy+WKhK+ZsCQmvQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgMDM6MjY6MDBQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBNb24sIE1hciAxOCwgMjAyNCBhdCAzOjAy4oCvUE0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5j
b20+IHdyb3RlOgo+IAo+ID4gT24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgMDI6MzI6NDFQTSArMDgw
MCwgTGkgV2FuZyB3cm90ZToKPiA+ID4gT24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgMTE6MjDigK9B
TSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4gd3JvdGU6Cj4gPiA+Cj4gPiA+ID4gT24gU3VuLCBN
YXIgMTcsIDIwMjQgYXQgMDU6NTI6MDFQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToKPiA+ID4gPiA+
IEhpIFdlaSwKPiA+ID4gPiA+Cj4gPiA+ID4gPiBDYW4geW91IHRyeSB0aGlzIG9uZSBhbmQgcG9z
dCB0aGUgdGVzdCBsb2cgaGVyZT8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBBbmQgYWdhaW4sIGl0J2Qg
YmUgaGVscGZ1bCB0byBrbm93IHRoZSBjb25maWcgb2YgeW91ciBTVVQuCj4gPiA+ID4gPiBlLmcu
IGBmcmVlIC1oYCAgYGxzY3B1YCAgYHVuYW1lIC1yYCAgaW5mb2Zvcm1hdGlvbgo+ID4gPiA+ID4K
PiA+ID4gPiA+Cj4gPiA+ID4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBv
bi9zd2Fwb24wMS5jCj4gPiA+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3
YXBvbi9zd2Fwb24wMS5jCj4gPiA+ID4gPiBAQCAtMzcsMTEgKzM3LDIwIEBAIHN0YXRpYyB2b2lk
IHZlcmlmeV9zd2Fwb24odm9pZCkKPiA+ID4gPiA+Cj4gPiA+ID4gPiAgc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkKPiA+ID4gPiA+ICB7Cj4gPiA+ID4gPiArICAgICAgIHRzdF9lbmFibGVfb29tX3By
b3RlY3Rpb24oMCk7Cj4gPiA+ID4gPiAgICAgICAgIGlzX3N3YXBfc3VwcG9ydGVkKFNXQVBfRklM
RSk7Cj4gPiA+ID4gPiAtICAgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAxMCwgMCk7Cj4g
PiA+ID4gPiArICAgICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAxMDI0LCAwKTsKPiA+ID4g
PiA+Cj4gPiA+ID4gPiAgICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgImNncm91cC5wcm9j
cyIsICIlZCIsIGdldHBpZCgpKTsKPiA+ID4gPiA+ICAgICAgICAgU0FGRV9DR19QUklOVEYodHN0
X2NnLCAibWVtb3J5Lm1heCIsICIlbHUiLCBURVNUTUVNKTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+
ICsgICAgICAgaWYgKFNBRkVfQ0dfSEFTKHRzdF9jZywgIm1lbW9yeS5zd2FwLm1heCIpKQo+ID4g
PiA+ID4gKyAgICAgICAgICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5zd2Fw
Lm1heCIsICIlbGQiLAo+ID4gVEVTVE1FTQo+ID4gPiA+ICoKPiA+ID4gPiA+IDIpOwo+ID4gPiA+
ID4gK30KPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4g
PiA+ID4gPiArewo+ID4gPiA+ID4gKyAgICAgICB0c3RfZGlzYWJsZV9vb21fcHJvdGVjdGlvbigw
KTsKPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPgo+ID4gPiA+ID4gIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rl
c3QgdGVzdCA9IHsKPiA+ID4gPiA+IEBAIC01MSw1ICs2MCw2IEBAIHN0YXRpYyBzdHJ1Y3QgdHN0
X3Rlc3QgdGVzdCA9IHsKPiA+ID4gPiA+ICAgICAgICAgLmFsbF9maWxlc3lzdGVtcyA9IDEsCj4g
PiA+ID4gPiAgICAgICAgIC5uZWVkc19jZ3JvdXBfY3RybHMgPSAoY29uc3QgY2hhciAqY29uc3Qg
W10peyAibWVtb3J5IiwgTlVMTAo+ID4gfSwKPiA+ID4gPiA+ICAgICAgICAgLnRlc3RfYWxsID0g
dmVyaWZ5X3N3YXBvbiwKPiA+ID4gPiA+IC0gICAgICAgLnNldHVwID0gc2V0dXAKPiA+ID4gPiA+
ICsgICAgICAgLnNldHVwID0gc2V0dXAsCj4gPiA+ID4gPiArICAgICAgIC5jbGVhbnVwID0gY2xl
YW51cAo+ID4gPiA+ID4gIH07Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4K
PiA+ID4gPgo+ID4gPiA+IGxvY2FsaG9zdDp+ICMgZnJlZSAtaCA8PDw8IGJlZm9yZSBydW5uaW5n
IGNhc2UKPiA+ID4gPiAgICAgICAgICAgICAgICB0b3RhbCAgICAgICAgdXNlZCAgICAgICAgZnJl
ZSAgICAgIHNoYXJlZCAgYnVmZi9jYWNoZQo+ID4gPiA+ICBhdmFpbGFibGUKPiA+ID4gPiBNZW06
ICAgICAgICAgICAzLjhHaSAgICAgICA0NzhNaSAgICAgICAzLjNHaSAgICAgICA5LjBNaSAgICAg
ICAzNDZNaQo+ID4gPiA+ICAzLjRHaQo+ID4gPiA+IFN3YXA6ICAgICAgICAgICAgIDBCICAgICAg
ICAgIDBCICAgICAgICAgIDBCCj4gPiA+ID4KPiA+ID4KPiA+ID4gSSBzZWUsIGl0IGlzIHZlcnkg
bGlrZWx5IHRoYXQgeW91ciBzeXN0ZW0gaGFzIG5vIHN3YXAgc3BhY2UKPiA+ID4gc28gdGhhdCB0
aGUgVEVTVE1FTSgxR0IpIGNhbiBub3QgYmUgc3dhcHBlZCBvdXQsIHRoZW4KPiA+ID4gT09NIGtp
bGxlciBoYXMgdG8gYmUgY2FsbGVkIG91dC4KPiA+ID4KPiA+ID4gSSBjYW4gcmVwcm9kdWNlIHlv
dXIgcHJvYmxlbSBieSBkaXNhYmxpbmcgYWxsIHN3YXAgZmlsZXMgb24gbXkgc3lzdGVtLgo+ID4g
Pgo+ID4gPiBTbyB0aGUgcG9zc2libGUgZml4IHdheSBpcyB0byByZWR1Y2UgdGhlIFRFU1RNRU0g
c2l6ZSBhbmQgaW5jcmVhc2UKPiA+ID4gdGhlIHRlc3RlZCBzd2FwZmlsZS4KPiA+ID4KPiA+ID4g
SSBndWVzcyB0aGlzIHBhdGNoIGNhbiB3b3JrIGZvciB5b3UsIGhhdmUgYSB0cnk/Cj4gPgo+ID4g
Tm8gb29tLCBidXQgU3dhcENhY2hlZCBzaXplIGlzIHVuc3RhYmxlLCBtb3N0IG9mIHRpbWUgaXMg
c3RpbGwgMAo+ID4KPiAKPiAKPiBUaGF0J3MgYmVjYXVzZSB0aGUgYXZhaWxhYmxlIHN3YXBmaWxl
IG9uIHlvdXIgU1VUIGlzIHRvbyBzbWFsbCwKPiB5b3UgY2FuIGFkanVzdCBpdCAodGhlbiByZXRl
c3QgaXQpIGJ5IHlvdXJzZWxmIHRvIGZpbmQgYSBwcm9wZXIgc2l6ZS4KPiAKPiBUaGlzIGlzIGZp
bmUgYXMgbG9uZyBhcyB0aGUgc3dhcGZpbGUgc2l6ZSBpcyBsZXNzIHRoYW4gMzAwTUIsCj4gb3Ro
ZXJ3aXNlIHdlIG5lZWQgdG8gc2V0IC5kZXZfbWluX3NpemUgbGlrZSB3aGF0IHdlIGRpZAo+IGZv
ciBzd2Fwb2ZmMDEuYy4KPiAKPiBBbmQsIG9uIHRoZSBvdGhlciBzaWRlLCB3ZSBjYW4ndCBndWFy
YW50ZWUgdGhlIHN5c3RlbSBTd2FwQ2FjaGVkCj4gaGFwcGVuZWQgZXZlcnkgdGltZSwgaXQgZGVw
ZW5kcyBvbiB0aGUgc3lzdGVtJ3MgY29uZmlndXJhdGlvbi4KPiAKCjEwME0gaXMgZ29vZCBlbm91
Z2ggZm9yIGN1cnJlbnQgc3lzdGVtLCBjb3VsZCB5b3UgaGVscCBjaGVjayBmb2xsb3dpbmcgcGF0
Y2g/CgotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKQEAgLTE0LDEz
ICsxNCwxNSBAQAogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPGVycm5vLmg+CiAjaW5j
bHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8c3lzL3N0YXR2ZnMuaD4KICNpbmNsdWRlICJ0c3Rf
dGVzdC5oIgogI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKICNpbmNsdWRlICJsaWJzd2FwLmgi
CgogI2RlZmluZSBNTlRQT0lOVCAgICAgICAibW50cG9pbnQiCiAjZGVmaW5lIFNXQVBfRklMRSAg
ICAgIE1OVFBPSU5UIi9zd2FwZmlsZTAxIgogI2RlZmluZSBURVNUTUVNICAgICAgICAgICAgICAg
ICgxVUw8PDMwKQorI2RlZmluZSBTV0FQX1NJWkUgICAgICAgICAxMDAgKiAxMDI0ICogMTAyNCAg
LyogMTAwTUIgKi8KCiBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQpCiB7CkBAIC0zNyw4
ICszOSwxNiBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9uKHZvaWQpCgogc3RhdGljIHZvaWQg
c2V0dXAodm9pZCkKIHsKKyAgICAgICBzdHJ1Y3Qgc3RhdHZmcyBmc19pbmZvOworICAgICAgIHVu
c2lnbmVkIGxvbmcgYmxrX3NpemU7CisKKyAgICAgICBpZiAoc3RhdHZmcygiLiIsICZmc19pbmZv
KSA9PSAtMSkKKyAgICAgICAgICAgICAgIHRzdF9icmsoVEJST0sgfCBURVJSTk8sICJGYWlsZWQg
dG8gY2FsbCBzdGF0dmZzIik7CisKKyAgICAgICBibGtfc2l6ZSA9IGZzX2luZm8uZl9ic2l6ZTsK
KwogICAgICAgIGlzX3N3YXBfc3VwcG9ydGVkKFNXQVBfRklMRSk7Ci0gICAgICAgbWFrZV9zd2Fw
ZmlsZShTV0FQX0ZJTEUsIDEwLCAwKTsKKyAgICAgICBtYWtlX3N3YXBmaWxlKFNXQVBfRklMRSwg
U1dBUF9TSVpFIC8gYmxrX3NpemUgLCAwKTsKCiAgICAgICAgU0FGRV9DR19QUklOVEYodHN0X2Nn
LCAiY2dyb3VwLnByb2NzIiwgIiVkIiwgZ2V0cGlkKCkpOwogICAgICAgIFNBRkVfQ0dfUFJJTlRG
KHRzdF9jZywgIm1lbW9yeS5tYXgiLCAiJWx1IiwgVEVTVE1FTSk7Cgo+IAo+IC0tIAo+IFJlZ2Fy
ZHMsCj4gTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
