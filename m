Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368C1CA0EE4
	for <ltp@archiver.kernel.org>; Sat, 16 Aug 2025 07:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755329259; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZT8t6gE/BfOXn0g5CNRQ7uKSZz5uIka+RJwvWW7g+hg=;
 b=Q47UXr8ecCpTi6+IKSkoy0QoPjTr+pyxxNefCk5fLHC8YqztFg0S+t5aThhHwtt6TI7xR
 ycFosM4p0uqemaAfYlCnf3nCDJXfpqmQk1xneCdnUS3giscF08b73Hk4H7n96nwIYjn/XKR
 d3WkFOEd/LxUUdFJHxrPOi8ZlDbNcW8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 019C03CC2ED
	for <ltp@archiver.kernel.org>; Sat, 16 Aug 2025 09:27:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9217F3C2565
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 09:27:18 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0D6ED140018A
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 09:27:16 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afcb78fb04cso413423866b.1
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755329236; x=1755934036; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FpiVReBk4pxi7WdSyaid9+sMC8akMMwfHAVHbbVirOA=;
 b=SAX+gbbDMQ2un3lZEa2t3dhCdNv1OLQml7VXL88CFN0IIhXvM3Cu7+rc57TJtqYO7n
 hE1sjDQkQNj1n1FSFHmfoIDaRsi/HsgNtq3Fq5xELuR5CeXKCJ0HEgQsl8HxIrQ2ivrz
 TU+GdA6cnKPsEZLPtF62B132LR6Xo/As6JB6fPsQI76Pv90W8hVmx7zS2dn0S8pHWLqu
 Nl5nQX0i5dQ7FTFZAXlCjzD3BO4z5FpmmlALYro8I49Yq2aRIItJPGgYzsd1xCjOYnfS
 u9Ib+Jo2/lmuqeUnnwhzVqm1ZXiatgRb7oTxSfJmjIo6/3Y3vvzEdnt2oN2553AbNjl4
 1nyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755329236; x=1755934036;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FpiVReBk4pxi7WdSyaid9+sMC8akMMwfHAVHbbVirOA=;
 b=wxCNOnaE/KaEpXhKEaIPR8flccFoGt6h0axBqzUdwZISLjOpmbH6dhYczmPEpWCSU7
 DkpVYmuX44mdlYN0+1F6kLl0fONB+u2Y+rUBGQcZW+Gn2TLxs9bufv1NYHxCiFbiR8BI
 cswBfcS6UnWLuDpDWq77tJhayjnyBdQ2D84YGwxy4q4DuBKl5QgazZjda1kJhydehm9P
 AqNmo1iMYySrjyUTs2hDIN6qvfkiN/LpDRGaFxNoFvMYUTC5oYslYYuAXqzBxwhXqCni
 WMVvgqIX3YL4QsQJ/+uLO5AA1O3GXHrdInDW/ImU2CbUHBpM06UKuae09/2f4ocQWu56
 3j+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNlSpoD4UkcmlaYDzYdo66uBT14LIHN5h63jkEZ6GTWEpMlvCHpL7qNemgBuzu626TjT4=@lists.linux.it
X-Gm-Message-State: AOJu0YzR87Csv57fupOAY5RwUqjjWvLm+0CVuKdDIrsvav+Ja5wJwSCa
 e8ftKX17qaUtQ6g55X+ey/7oMQYqiyoTqHhhFALI/wI6HWv9xz/p5s0E42dK9rDzuA==
X-Gm-Gg: ASbGncteGaPbGzHlcuDANiowtMfA8w0Ew4ga4IrWhew5wj/3j2p7OUH0mwB+J+kUSkV
 h87IpNfKg7g+6ZSB9qrRDGrRUl1QPl8s+Hr3PpFLJO1ZncVz8xva2AkDiqADxKtbZXYcDMpqohW
 HeP6FYMSoshcG0NR6Yz3uS/60VYEf/CHmr/WpxdL/IYjRn1vQMUKMxWyLJrTf2XDhl/UBadQHYB
 uWvUumo3AvaxlPu3jwboQPhxm/WmfND5fwCtmTJYK/UDfYJU0qWJwM+xJkvuLxPNBNbZbQvsGzQ
 StkrXDQbMEoVP151+8yq73ZcsEdA2rngIf+w2yJZIZ+vi6gTvNUlWmx+9Wh10WH9+yeU6MYNqO8
 3+eNgOGxzkPI=
X-Google-Smtp-Source: AGHT+IFg7imxaFEagNP0U5Ayia7U3tygLpXsVf6xKmyOpZitxVfNDophojGzUA2/MzddJEvPpEzhfA==
X-Received: by 2002:a17:906:6a0f:b0:ae8:4776:fbb1 with SMTP id
 a640c23a62f3a-afcdc03d360mr411785966b.11.1755329236202; 
 Sat, 16 Aug 2025 00:27:16 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afcdcea179esm312796166b.57.2025.08.16.00.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Aug 2025 00:27:15 -0700 (PDT)
Date: Sat, 16 Aug 2025 07:27:14 +0000
To: Kuniyuki Iwashima <kuniyu@google.com>
Message-ID: <aKAy0nu2p6X9sKUw@localhost>
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <202508110750.a66a4225-lkp@intel.com> <aJ_qbZDvDJwVoZGA@localhost>
 <CAAVpQUCEGiRjoobf69Jd5M9vnZyi0N6crNUgSBpDTGNfrap1cA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAVpQUCEGiRjoobf69Jd5M9vnZyi0N6crNUgSBpDTGNfrap1cA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH net v2] net: ip: order the reuseport socket in
 __inet_hash
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
Cc: kraig@google.com, lkp@intel.com, netdev@vger.kernel.org, dsahern@kernel.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, edumazet@google.com,
 kernel test robot <oliver.sang@intel.com>, horms@kernel.org,
 oe-lkp@lists.linux.dev, kuba@kernel.org,
 Menglong Dong <menglong8.dong@gmail.com>, pabeni@redhat.com,
 ncardwell@google.com, davem@davemloft.net, ltp@lists.linux.it,
 Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMTUsIDIwMjUgYXQgMDc6MzU6MTBQTSAtMDcwMCwgS3VuaXl1a2kgSXdhc2hp
bWEgd3JvdGU6Cj4gT24gRnJpLCBBdWcgMTUsIDIwMjUgYXQgNzoxOOKAr1BNIFdlaSBHYW8gPHdl
Z2FvQHN1c2UuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEF1ZyAxMSwgMjAyNSBhdCAwMToy
NzoxMlBNICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToKPiA+ID4KPiA+ID4KPiA+ID4g
SGVsbG8sCj4gPiA+Cj4gPiA+IGtlcm5lbCB0ZXN0IHJvYm90IG5vdGljZWQgIkJVRzpLQVNBTjpz
bGFiLXVzZS1hZnRlci1mcmVlX2luX19pbmV0X2hhc2giIG9uOgo+ID4gPgo+ID4gPiBjb21taXQ6
IDg1OWNhNjBiNzFlZjIyM2UyMTBkM2QwMDNhMjI1ZDljYTcwODc5ZmQgKCJbUEFUQ0ggbmV0IHYy
XSBuZXQ6IGlwOiBvcmRlciB0aGUgcmV1c2Vwb3J0IHNvY2tldCBpbiBfX2luZXRfaGFzaCIpCj4g
PiA+IHVybDogaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1sa3AvbGludXgvY29tbWl0cy9N
ZW5nbG9uZy1Eb25nL25ldC1pcC1vcmRlci10aGUtcmV1c2Vwb3J0LXNvY2tldC1pbi1fX2luZXRf
aGFzaC8yMDI1MDgwMS0xNzExMzEKPiA+ID4gYmFzZTogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9j
Z2l0L2xpbnV4L2tlcm5lbC9naXQvZGF2ZW0vbmV0LmdpdCAwMTA1MTAxMjg4NzMyOWVhNzhlYWNh
MTliMWQyZWFjNGM5ZjYwMWI1Cj4gPiA+IHBhdGNoIGxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI1MDgwMTA5MDk0OS4xMjk5NDEtMS1kb25nbWwyQGNoaW5hdGVsZWNvbS5jbi8K
PiA+ID4gcGF0Y2ggc3ViamVjdDogW1BBVENIIG5ldCB2Ml0gbmV0OiBpcDogb3JkZXIgdGhlIHJl
dXNlcG9ydCBzb2NrZXQgaW4gX19pbmV0X2hhc2gKPiA+ID4KPiA+ID4gaW4gdGVzdGNhc2U6IGx0
cAo+ID4gPiB2ZXJzaW9uOiBsdHAteDg2XzY0LTY1MDVmOWUyOS0xXzIwMjUwODAyCj4gPiA+IHdp
dGggZm9sbG93aW5nIHBhcmFtZXRlcnM6Cj4gPiA+Cj4gPiA+ICAgICAgIGRpc2s6IDFIREQKPiA+
ID4gICAgICAgZnM6IGV4dDQKPiA+ID4gICAgICAgdGVzdDogZnNfcGVybXNfc2ltcGxlCj4gPiA+
Cj4gPiA+Cj4gPiA+Cj4gPiA+IGNvbmZpZzogeDg2XzY0LXJoZWwtOS40LWx0cAo+ID4gPiBjb21w
aWxlcjogZ2NjLTEyCj4gPiA+IHRlc3QgbWFjaGluZTogNCB0aHJlYWRzIDEgc29ja2V0cyBJbnRl
bChSKSBDb3JlKFRNKSBpMy0zMjIwIENQVSBAIDMuMzBHSHogKEl2eSBCcmlkZ2UpIHdpdGggOEcg
bWVtb3J5Cj4gPiA+Cj4gPiA+IChwbGVhc2UgcmVmZXIgdG8gYXR0YWNoZWQgZG1lc2cva21zZyBm
b3IgZW50aXJlIGxvZy9iYWNrdHJhY2UpCj4gPiA+Cj4gPiA+Cj4gPiA+Cj4gPiA+IElmIHlvdSBm
aXggdGhlIGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEg
bmV3IHZlcnNpb24gb2YKPiA+ID4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBm
b2xsb3dpbmcgdGFncwo+ID4gPiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8b2xp
dmVyLnNhbmdAaW50ZWwuY29tPgo+ID4gPiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvb2UtbGtwLzIwMjUwODExMDc1MC5hNjZhNDIyNS1sa3BAaW50ZWwuY29tCj4gPiA+Cj4gPiA+
Cj4gPiA+IGtlcm4gOmVyciA6IFsgIDEyOC4xODY3MzVdIEJVRzogS0FTQU46IHNsYWItdXNlLWFm
dGVyLWZyZWUgaW4gX19pbmV0X2hhc2ggKG5ldC9pcHY0L2luZXRfaGFzaHRhYmxlcy5jOjc0OSBu
ZXQvaXB2NC9pbmV0X2hhc2h0YWJsZXMuYzo4MDApCj4gPgo+ID4gVGhpcyBrYXNhbiBlcnJvciBu
b3QgcmVsYXRlZCB3aXRoIExUUCBjYXNlLCBpIGd1ZXNzIGl0IHRyaWdnZXJlZCBieSBuZXR3b3Jr
Cj4gPiByZWxhdGVkIHByb2Nlc3Mgc3VjaCBhcyBiaW5kIGV0Yy4gSSB0cnkgdG8gZ2l2ZSBmb2xs
b3dpbmcgcGF0Y2ggdG8gZml4Cj4gPiBrYXNhbiBlcnJvciwgY29ycmVjdCBtZSBpZiBhbnkgbWlz
dGFrZSwgdGhhbmtzLgo+IAo+IE5vdGUgdGhhdCB0aGUgcmVwb3J0IHdhcyBmb3IgdGhlIHBhdGNo
IGluIHRoZSBtYWlsaW5nIGxpc3QKPiBhbmQgdGhlIHBhdGNoIHdhcyBub3QgYXBwbGllZCB0byBu
ZXQtbmV4dC5naXQgbm9yIG5ldC5naXQuClRoYW5rcyBmb3Igbm90ZS4gClNpbmNlIHRoaXMgZW1h
aWwgc2VudCB0byBMVFAgZ3JvdXAgc28gaSBnb3QgdGhpcy4gU2luY2UKaSdtIGludGVyZXN0ZWQg
aW4gdGhpcyAna2FzYW4nIHByb2JsZW0sIHNvIHRyeWluZyB0byBmaXggaXQuCj4gCj4gCj4gPgo+
ID4gRnJvbTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gPiBEYXRlOiBTYXQsIDE2IEF1ZyAy
MDI1IDA5OjMyOjU2ICswODAwCj4gPiBTdWJqZWN0OiBbUEFUQ0ggdjFdIG5ldDogRml4IEJVRzpL
QVNBTjpzbGFiLXVzZS1hZnRlci1mcmVlX2luX19pbmV0X2hhc2gKPiA+Cj4gPiBSZXBvcnRlZC1i
eToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4KPiA+IENsb3Nlczog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjUwODExMDc1MC5hNjZhNDIyNS1sa3BA
aW50ZWwuY29tCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiA+
IC0tLQo+ID4gIGluY2x1ZGUvbGludXgvcmN1bGlzdF9udWxscy5oIHwgNCArKy0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9yY3VsaXN0X251bGxzLmggYi9pbmNsdWRlL2xpbnV4L3Jj
dWxpc3RfbnVsbHMuaAo+ID4gaW5kZXggZGE1MDBmNGFlMTQyLi41ZGVmOTAwOWM1MDcgMTAwNjQ0
Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3JjdWxpc3RfbnVsbHMuaAo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9yY3VsaXN0X251bGxzLmgKPiA+IEBAIC01Nyw3ICs1Nyw3IEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBobGlzdF9udWxsc19kZWxfaW5pdF9yY3Uoc3RydWN0IGhsaXN0X251bGxzX25vZGUg
Km4pCj4gPiAgICogQG5vZGU6IGVsZW1lbnQgb2YgdGhlIGxpc3QuCj4gPiAgICovCj4gPiAgI2Rl
ZmluZSBobGlzdF9udWxsc19wcHJldl9yY3Uobm9kZSkgXAo+ID4gLSAgICAgICAoKigoc3RydWN0
IGhsaXN0X251bGxzX25vZGUgX19yY3UgX19mb3JjZSAqKikmKG5vZGUpLT5wcHJldikpCj4gPiAr
ICAgICAgICgqKChzdHJ1Y3QgaGxpc3RfbnVsbHNfbm9kZSBfX3JjdSBfX2ZvcmNlICoqKShub2Rl
KS0+cHByZXYpKQo+ID4KPiA+ICAvKioKPiA+ICAgKiBobGlzdF9udWxsc19kZWxfcmN1IC0gZGVs
ZXRlcyBlbnRyeSBmcm9tIGhhc2ggbGlzdCB3aXRob3V0IHJlLWluaXRpYWxpemF0aW9uCj4gPiBA
QCAtMTc1LDcgKzE3NSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBobGlzdF9udWxsc19hZGRfYmVm
b3JlX3JjdShzdHJ1Y3QgaGxpc3RfbnVsbHNfbm9kZSAqbiwKPiA+ICB7Cj4gPiAgICAgICAgIFdS
SVRFX09OQ0Uobi0+cHByZXYsIG5leHQtPnBwcmV2KTsKPiA+ICAgICAgICAgbi0+bmV4dCA9IG5l
eHQ7Cj4gPiAtICAgICAgIHJjdV9hc3NpZ25fcG9pbnRlcihobGlzdF9udWxsc19wcHJldl9yY3Uo
biksIG4pOwo+ID4gKyAgICAgICByY3VfYXNzaWduX3BvaW50ZXIoaGxpc3RfbnVsbHNfcHByZXZf
cmN1KG5leHQpLCBuKTsKPiA+ICAgICAgICAgV1JJVEVfT05DRShuZXh0LT5wcHJldiwgJm4tPm5l
eHQpOwo+ID4gIH0KPiA+Cj4gPiAtLQo+ID4gMi40My4wCj4gPgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
