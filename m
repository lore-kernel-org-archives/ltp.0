Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DE2C4450E
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 14:56:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 038893E9668
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 16:56:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78BD33CE2E5
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 16:36:06 +0200 (CEST)
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de
 [129.217.128.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4CEB9100099A
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 16:36:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
 s=unimail; t=1784125948;
 bh=hKJ6Qg2LWg5gq7q/ZPC3JQm9ffFjxx+05nF4JeAwcqc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=A2Jl5qrrddCcR+p2mk1pHk/z/FT4JJL21XVrsZZ0UN/wRXMp6U0CsjKJnMc2gYKkP
 esPVyRoLI+s4+rcMlQYe8RIPqp6jLbMkjFCZNCWv5Y5xPcB+uAOAxXp3A9JbdNwOET
 9dFxUSvXhZpQvoujnRh5pZRArIJkiwuDeq5dPrvg=
Received: from [129.217.186.229] ([129.217.186.229]) (authenticated bits=0)
 by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66FEWQm2000998
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2026 16:32:26 +0200 (CEST)
Message-ID: <1ecf0eb8-17ef-4f9c-ba87-da69d207e4d4@tu-dortmund.de>
Date: Wed, 15 Jul 2026 16:32:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel test robot <oliver.sang@intel.com>
References: <202607151550.5d829a99-lkp@intel.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <202607151550.5d829a99-lkp@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:55:46 +0200
Subject: Re: [LTP] [PATCH net v3] tun/tap & vhost-net: make qdisc
 backpressure opt-in via IFF_BACKPRESSURE
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, lkp@intel.com,
 Brett Sheffield <brett@librecast.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, oe-lkp@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, Tim Gebauer <tim.gebauer@tu-dortmund.de>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gNy8xNS8yNiAxNjowMSwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6Cj4gCj4gCj4gSGVsbG8s
Cj4gCj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCAibHRwLmlvY3RsMDMuZmFpbCIgb246Cgpp
b2N0bDAzLmMgZG9lcyBub3Qga25vdyBhYm91dCBJRkZfQkFDS1BSRVNTVVJFIHdoaWNoIGlzIGlu
dHJvZHVjZWQgaGVyZSwKY29uc2VxdWVudGx5IGl0IGZhaWxzLgpTZWUgWzFdIHdoZXJlIGl0IGNv
bXBhcmVzIFRVTiBmZWF0dXJlcyB3aXRoIGtub3duX2ZsYWdzLgoKVGhhbmtzLgoKWzFdIExpbms6
IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGwwMy5jI0w4MgoKPiAKPiBjb21taXQ6
IDA5MTU0ZmYyMDcyZTM2Yjg2YmEyZDkyZDQzNmI3ZjI3ZGYxNTNlZDEgKCJbUEFUQ0ggbmV0IHYz
XSB0dW4vdGFwICYgdmhvc3QtbmV0OiBtYWtlIHFkaXNjIGJhY2twcmVzc3VyZSBvcHQtaW4gdmlh
IElGRl9CQUNLUFJFU1NVUkUiKQo+IHVybDogaHR0cHM6Ly9naXRodWIuY29tL2ludGVsLWxhYi1s
a3AvbGludXgvY29tbWl0cy9TaW1vbi1TY2hpcHBlcnMvdHVuLXRhcC12aG9zdC1uZXQtbWFrZS1x
ZGlzYy1iYWNrcHJlc3N1cmUtb3B0LWluLXZpYS1JRkZfQkFDS1BSRVNTVVJFLzIwMjYwNzA5LTE4
MTIzNAo+IGJhc2U6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0
L2RhdmVtL25ldC5naXQgZmFiYjg4MWRmMzIyZGEyNTQ0MmY5OGQyM2Y1ZmEzNzFlM2M3OGVjNAo+
IHBhdGNoIGxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDcwOTA5NTUxMS4x
NjgyMzUtMS1zaW1vbi5zY2hpcHBlcnNAdHUtZG9ydG11bmQuZGUvCj4gcGF0Y2ggc3ViamVjdDog
W1BBVENIIG5ldCB2M10gdHVuL3RhcCAmIHZob3N0LW5ldDogbWFrZSBxZGlzYyBiYWNrcHJlc3N1
cmUgb3B0LWluIHZpYSBJRkZfQkFDS1BSRVNTVVJFCj4gCj4gaW4gdGVzdGNhc2U6IGx0cAo+IHZl
cnNpb246IAo+IHdpdGggZm9sbG93aW5nIHBhcmFtZXRlcnM6Cj4gCj4gCWRpc2s6IDFIREQKPiAJ
ZnM6IGV4dDQKPiAJdGVzdDogc3lzY2FsbHMtMDMKPiAKPiAKPiAKPiBjb25maWc6IHg4Nl82NC1y
aGVsLTkuNC1sdHAKPiBjb21waWxlcjogZ2NjLTE0Cj4gdGVzdCBtYWNoaW5lOiA0IHRocmVhZHMg
MSBzb2NrZXRzIEludGVsKFIpIENvcmUoVE0pIGkzLTMyMjAgQ1BVIEAgMy4zMEdIeiAoSXZ5IEJy
aWRnZSkgd2l0aCA4RyBtZW1vcnkKPiAKPiAocGxlYXNlIHJlZmVyIHRvIGF0dGFjaGVkIGRtZXNn
L2ttc2cgZm9yIGVudGlyZSBsb2cvYmFja3RyYWNlKQo+IAo+IAo+IAo+IElmIHlvdSBmaXggdGhl
IGlzc3VlIGluIGEgc2VwYXJhdGUgcGF0Y2gvY29tbWl0IChpLmUuIG5vdCBqdXN0IGEgbmV3IHZl
cnNpb24gb2YKPiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0
YWdzCj4gfCBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPG9saXZlci5zYW5nQGludGVs
LmNvbT4KPiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjYwNzE1
MTU1MC41ZDgyOWE5OS1sa3BAaW50ZWwuY29tCj4gCj4gCj4gLi4uLgo+IAo+IBtbMTszN21nZXR1
aWQwMzogG1swbRtbMTszMm1wYXNzG1swbSAgKDAuMDI4cykKPiAbWzE7MzdtaW9jdGwwMzogG1sw
bRtbMTszMW1mYWlsG1swbSAgKDAuMDQ3cykgICAgIDwtLS0tLQo+IBtbMTszN21pb2N0bDA1OiAb
WzBtG1sxOzMybXBhc3MbWzBtICAoMC40NzFzKQo+IAo+IC4uLi4KPiAKPiBFeGVjdXRpb24gdGlt
ZTogM20gMzVzCj4gCj4gRGlzY29ubmVjdGluZyBmcm9tIFNVVDogZGVmYXVsdAo+IAo+IFRhcmdl
dCBpbmZvcm1hdGlvbgo+IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgAo+IEtlcm5lbDogICBMaW51eCA3LjIuMC1yYzErICMxIFNNUCBQUkVFTVBU
X0RZTkFNSUMgU3VuIEp1bCAxMiAwNzoyNTozOCBDU1QgMjAyNgo+IENtZGxpbmU6ICBpcD06Ojo6
bGtwLWl2Yi1kMDQ6OmRoY3AKPiAgICAgICAgICAgcm9vdD0vZGV2L3JhbTAKPiAgICAgICAgICAg
UkVTVUxUX1JPT1Q9L3Jlc3VsdC9sdHAvMUhERC1leHQ0LXN5c2NhbGxzLTAzL2xrcC1pdmItZDA0
L2RlYmlhbi0xMy14ODZfNjQtMjAyNTA5MDIuY2d6L3g4Nl82NC1yaGVsLTkuNC1sdHAvZ2NjLTE0
LzA5MTU0ZmYyMDcyZTM2Yjg2YmEyZDkyZDQzNmI3ZjI3ZGYxNTNlZDEvMAo+ICAgICAgICAgICBC
T09UX0lNQUdFPS9wa2cvbGludXgveDg2XzY0LXJoZWwtOS40LWx0cC9nY2MtMTQvMDkxNTRmZjIw
NzJlMzZiODZiYTJkOTJkNDM2YjdmMjdkZjE1M2VkMS92bWxpbnV6LTcuMi4wLXJjMSsKPiAgICAg
ICAgICAgYnJhbmNoPWxpbnV4LWRldmVsL2RldmVsLWhvdXJseS0yMDI2MDcwOS0xOTA3NTkKPiAg
ICAgICAgICAgam9iPS9sa3Avam9icy9zY2hlZHVsZWQvbGtwLWl2Yi1kMDQvbHRwLTFIREQtZXh0
NC1zeXNjYWxscy0wMy1kZWJpYW4tMTMteDg2XzY0LTIwMjUwOTAyLmNnei0wOTE1NGZmMjA3MmUt
MjAyNjA3MTItMTk2NDktdGM4YnU2LTAueWFtbAo+ICAgICAgICAgICB1c2VyPWxrcAo+ICAgICAg
ICAgICBBUkNIPXg4Nl82NAo+ICAgICAgICAgICBrY29uZmlnPXg4Nl82NC1yaGVsLTkuNC1sdHAK
PiAgICAgICAgICAgY29tbWl0PTA5MTU0ZmYyMDcyZTM2Yjg2YmEyZDkyZDQzNmI3ZjI3ZGYxNTNl
ZDEKPiAgICAgICAgICAgaW50cmVtYXA9cG9zdGVkX21zaQo+ICAgICAgICAgICBtYXhfdXB0aW1l
PTcyMDAKPiAgICAgICAgICAgTEtQX1NFUlZFUj1pbnRlcm5hbC1sa3Atc2VydmVyCj4gICAgICAg
ICAgIG5va2FzbHIKPiAgICAgICAgICAgc2VsaW51eD0wCj4gICAgICAgICAgIGRlYnVnCj4gICAg
ICAgICAgIGFwaWM9ZGVidWcKPiAgICAgICAgICAgc3lzcnFfYWx3YXlzX2VuYWJsZWQKPiAgICAg
ICAgICAgcmN1cGRhdGUucmN1X2NwdV9zdGFsbF90aW1lb3V0PTEwMAo+ICAgICAgICAgICBuZXQu
aWZuYW1lcz0wCj4gICAgICAgICAgIHByaW50ay5kZXZrbXNnPW9uCj4gICAgICAgICAgIHBhbmlj
PS0xCj4gICAgICAgICAgIHNvZnRsb2NrdXBfcGFuaWM9MQo+ICAgICAgICAgICBubWlfd2F0Y2hk
b2c9cGFuaWMKPiAgICAgICAgICAgb29wcz1wYW5pYwo+ICAgICAgICAgICBsb2FkX3JhbWRpc2s9
Mgo+ICAgICAgICAgICBwcm9tcHRfcmFtZGlzaz0wCj4gICAgICAgICAgIGRyYmQubWlub3JfY291
bnQ9OAo+ICAgICAgICAgICBzeXN0ZW1kLmxvZ19sZXZlbD1lcnIKPiAgICAgICAgICAgaWdub3Jl
X2xvZ2xldmVsCj4gICAgICAgICAgIGNvbnNvbGU9dHR5MAo+ICAgICAgICAgICBlYXJseXByaW50
az10dHlTMCwxMTUyMDAKPiAgICAgICAgICAgY29uc29sZT10dHlTMCwxMTUyMDAKPiAgICAgICAg
ICAgdmdhPW5vcm1hbAo+ICAgICAgICAgICBydwo+ICAgICAgICAgICBrZWVwX2luaXRyZHM9L29z
aW1hZ2UvcGtnL2RlYmlhbi0xMy14ODZfNjQtMjAyNTA5MDIuY2d6L2x0cC14ODZfNjQtZWQyNzU4
MTIyLTFfMjAyNjA3MTEuY2d6Cj4gICAgICAgICAgIGFjcGlfcnNkcD0weDAwMGYwNDkwCj4gTWFj
aGluZTogIHVua25vd24KPiBBcmNoOiAgICAgeDg2XzY0Cj4gUkFNOiAgICAgIDY4OTU1OTYga0IK
PiBTd2FwOiAgICAgMCBrQgo+IERpc3RybzogICBkZWJpYW4gMTMKPiAKPiDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIAKPiAgICAgICBURVNUIFNVTU1BUlkKPiDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKPiBTdWl0ZTogICBzeXNj
YWxscy0wMwo+IFJ1bnRpbWU6IDNtIDI0cwo+IFJ1bnM6ICAgIDE4Mwo+IAo+IFJlc3VsdHM6Cj4g
ICAgIFBhc3NlZDogICAyMTQ0Cj4gICAgIEZhaWxlZDogICAxCj4gICAgIEJyb2tlbjogICAwCj4g
ICAgIFNraXBwZWQ6ICAyMjIKPiAgICAgV2FybmluZ3M6IDAKPiAKPiAbWzE7MzFtRmFpbHVyZXM6
G1swbQo+ICAgICDigKIgaW9jdGwwMwo+IAo+IAo+IAo+IFRoZSBrZXJuZWwgY29uZmlnIGFuZCBt
YXRlcmlhbHMgdG8gcmVwcm9kdWNlIGFyZSBhdmFpbGFibGUgYXQ6Cj4gaHR0cHM6Ly9kb3dubG9h
ZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjYwNzE1LzIwMjYwNzE1MTU1MC41ZDgyOWE5OS1s
a3BAaW50ZWwuY29tCj4gCj4gCj4gCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
