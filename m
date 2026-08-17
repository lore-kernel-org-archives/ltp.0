Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142D3C5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:22:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 710CF3CC83A
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:22:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DF763C06B9
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 09:39:42 +0200 (CEST)
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de
 [129.217.128.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB6781A00704
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 09:39:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
 s=unimail; t=1786952369;
 bh=ROzgelHjCksFRXJDoTZHiYQsqtaaq51sCU/RNJh7IHs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=JgLUlk6Mgi5YGbiqn8SE3p1CNXspBPxjXoIHGQyUEN+a7lI3NXvx4SH+WuEqmaflc
 KTH5JTY9IeLOI2+iIo+TYe9vixkBcLF4fIRFBz2AqOgyfFPdwqOFUIpUKLGwuV4Iz/
 oQXe571laVEojptT8QqQkbcDC7CC/xzcxKO2JXmI=
Received: from [IPV6:2a01:599:a01:b5ff:b10b:46c3:3de0:9273]
 (tmo-068-246.customers.d1-online.com [80.187.68.246])
 (authenticated bits=0)
 by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 67H7dRah002056
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 09:39:28 +0200 (CEST)
Message-ID: <bf700b2d-4593-41ee-bac2-6438b65e3720@tu-dortmund.de>
Date: Mon, 17 Aug 2026 09:39:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kernel test robot <yi1.lai@intel.com>
References: <202608170325.fbd7c808-lkp@intel.com>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <202608170325.fbd7c808-lkp@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 18 Aug 2026 16:21:47 +0200
Subject: Re: [LTP] [linux-next:master] [tun/tap & vhost] d00c7369ef:
 ltp.ioctl03.fail
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
Cc: lkp@intel.com, netdev@vger.kernel.org,
 Tim Gebauer <tim.gebauer@tu-dortmund.de>, oe-lkp@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gOC8xNy8yNiAwMzozNCwga2VybmVsIHRlc3Qgcm9ib3Qgd3JvdGU6Cj4gCj4gCj4gSGVsbG8s
Cj4gCj4ga2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCAibHRwLmlvY3RsMDMuZmFpbCIgb246Cj4g
Cj4gY29tbWl0OiBkMDBjNzM2OWVmMjRhYzhlMDM4M2RlMGZkOGVmMzM4NGRlMjBiY2ZhICgidHVu
L3RhcCAmIHZob3N0LW5ldDogc3RvcCB0YWlsLWRyb3Agd2hlbiBJRkZfQkFDS1BSRVNTVVJFIGlz
IHNldCIpIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L25leHQv
bGludXgtbmV4dC5naXQgbWFzdGVyCj4gCj4gW3Rlc3QgZmFpbGVkIG9uIGxpbnV4LW5leHQvbWFz
dGVyIDQ0NzdhNzgzNzRhNTdjMzgwOWIxNzJhZDMwY2NlYWJkYTQ4YzQ3YzZdCj4g4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSACj4gICAgICAgVEVTVCBTVU1NQVJZCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gU3VpdGU6ICAg
c3lzY2FsbHMtMDMKPiBSdW50aW1lOiAzbSA0cwo+IFJ1bnM6ICAgIDE4Ngo+IAo+IFJlc3VsdHM6
Cj4gICAgIFBhc3NlZDogICAyMTc0Cj4gICAgIEZhaWxlZDogICAxCj4gICAgIEJyb2tlbjogICAw
Cj4gICAgIFNraXBwZWQ6ICAyMjIKPiAgICAgV2FybmluZ3M6IDAKPiAKPiAgWzE7MzFtRmFpbHVy
ZXM6IFswbQo+ICAgICDigKIgaW9jdGwwMwoKVGhlIHNhbWUgaGFybWxlc3MgcmVwb3J0IGFzIGJl
Zm9yZToKCmlvY3RsMDMuYyBkb2VzIG5vdCBrbm93IGFib3V0IElGRl9CQUNLUFJFU1NVUkUgd2hp
Y2ggaXMgaW50cm9kdWNlZCBoZXJlLApjb25zZXF1ZW50bHkgaXQgZmFpbHMuClNlZSBbMV0gd2hl
cmUgaXQgY29tcGFyZXMgVFVOIGZlYXR1cmVzIHdpdGgga25vd25fZmxhZ3MuCgpUaGFua3MuCgpb
MV0gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9t
YXN0ZXIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bDAzLmMjTDgyCgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
