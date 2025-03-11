Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948FDC282EC
	for <ltp@archiver.kernel.org>; Tue, 11 Mar 2025 13:09:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8ED7F3CA34F
	for <ltp@archiver.kernel.org>; Tue, 11 Mar 2025 14:09:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B47A3C829A
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 14:09:28 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 74927200220
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 14:09:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741698565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+LI7+2lnzJYKh6sMzBCd+5OCY/9yMQxJCS+RyOZNgA=;
 b=D03hW4PMDm+J1oCLNYgZiUOyRamXIdS5z/5O0ZjPVaZzJ/L6Asbj4x7S1i0ZvYNKNscvZ2
 e5fZ1To+FfAj/fOr6dk4AXVo+tsM1Pq/R5Ba3EYAmSzH0gJHW9MY6/BcnUUF2Q+kBZerfW
 dH8+apP4Twr9L4OKMYDGEB5d66CtfIE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-UGaZXNQ7NSyQyvABcYXQIg-1; Tue, 11 Mar 2025 09:09:21 -0400
X-MC-Unique: UGaZXNQ7NSyQyvABcYXQIg-1
X-Mimecast-MFC-AGG-ID: UGaZXNQ7NSyQyvABcYXQIg_1741698561
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff605a7a43so15597736a91.3
 for <ltp@lists.linux.it>; Tue, 11 Mar 2025 06:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698561; x=1742303361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J+LI7+2lnzJYKh6sMzBCd+5OCY/9yMQxJCS+RyOZNgA=;
 b=dCa4FqtuwHOiJNEMjpqBF8i5MYHdbGNfhdIqrp8Ake+9Oz7c6PAu28So0SpfCKNk9D
 ehvXP6w4TZ/blFCB0BhQfc0T9WBzfWkT4hj/JziAMnZR2M0+G4yBRqZDoIx9F1piWzLV
 +iHCiyKEe+M0823l3BIoFtHCmjgNkPF9pFb551j3ZN4gY8VlueKYc2zwUdv7pBqJo2j/
 tevrHETWAM/SL5OaqW/Tont1OcPCyPeEAiMIPM4lREXZ66CmLtNNob9fPC2+sU58xddH
 cWU62UrzxqSWPWjrqFSn/LoMalSn1a8kC98l9iw8nM0ImeTuivCz3eK0gzsBZTDpoRUA
 t2HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOsgHz4MeHqeQPwwcz3VclKG+mTbN9Mf8KMJYktLaAOASE3m2ot234L6jqw3rJs3IhypU=@lists.linux.it
X-Gm-Message-State: AOJu0Ywm+lzU3qC+OkU93cn5Yx/ZzLFG4YaPCNfnipU/acvJMy6Po9HC
 MimH1psFBwNu+MREQ8lxXVSTiDjDQfi7+r8v9jGqZu+XSskAy8gkYUjo5u/Wy05SN59ly0O/qdk
 +K25DwTPZd06nNFVh62kz2L9GUOaDefSIpHcg/PK03HvQ1bGR/h+m2hspMeHxKOzsFEw0K9js5e
 LNns45233tqLa0Ho+69t54f94=
X-Gm-Gg: ASbGnctgZfFku5IwMRglaKqKWNRVxgBbShmVjCxfHJKGo/fbjCtDsz/Nj0qM0vHYkJp
 FCx6aYnZ4PzMLaXhvp1EKMIkjBSs33xuJdk+uYs/Ht2NhNOHCh2W800C6ICzlNFoInrXGIPD6QQ
 ==
X-Received: by 2002:a17:90b:1b0b:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-2ff7cea9a99mr30714721a91.18.1741698560800; 
 Tue, 11 Mar 2025 06:09:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfWT+wYrgBggkzhRfWt+2/vckJpJ2Ygr1ArVyOKu+aA/HJ+Ql4+MBisSxY/LvCYkKz/Q0SldW+00EbjI0LyZ4=
X-Received: by 2002:a17:90b:1b0b:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-2ff7cea9a99mr30714683a91.18.1741698560438; Tue, 11 Mar 2025
 06:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <202503101538.84c33cd4-lkp@intel.com>
 <CAEemH2egF6ehr7B_5KDLuBQqoUJ5k7bVZkid-ERDBkxkChi7fw@mail.gmail.com>
 <CAB=NE6UWzyq+qXhGmpH2-6bePE+Zi=dJjBH7y3HeJnYyh6xvtw@mail.gmail.com>
 <CAEemH2c21vrSOKdJvHkyH+UOv-aXefXeFVZuv4-DSZ_P4Z3Mxw@mail.gmail.com>
 <Z8-tV0zJKP7wRAxK@bombadil.infradead.org>
In-Reply-To: <Z8-tV0zJKP7wRAxK@bombadil.infradead.org>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Mar 2025 21:09:08 +0800
X-Gm-Features: AQ5f1JoHrLR73BefZogi6hnZrxhXC-m4GK46v2XEAp1UbjQMgVmnLBNuxzXp-qI
Message-ID: <CAEemH2d36bY-q-+P_vHKvj+kg6qi2k=y37PRNOr6mkY=pdFQrQ@mail.gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qm8IqYlEtcXGrp7Ra1a5qe6PCLXokRHnkReSi5txnNQ_1741698561
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [linux-next:master] [block/bdev] 47dd675323:
 ltp.ioctl_loop06.fail
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
Cc: Christian Brauner <brauner@kernel.org>, 0day robot <lkp@intel.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, linux-block@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 oe-lkp@lists.linux.dev, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMTEsIDIwMjUgYXQgMTE6MzPigK9BTSBMdWlzIENoYW1iZXJsYWluIDxtY2dy
b2ZAa2VybmVsLm9yZz4gd3JvdGU6Cgo+IE9uIFR1ZSwgTWFyIDExLCAyMDI1IGF0IDA5OjQzOjQy
QU0gKzA4MDAsIExpIFdhbmcgd3JvdGU6Cj4gPiBPbiBNb24sIE1hciAxMCwgMjAyNSBhdCAxMTox
NeKAr1BNIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3JvZkBrZXJuZWwub3JnPgo+IHdyb3RlOgo+ID4K
PiA+ID4gVGhlcmUncyBhIGZpeCBmb3IgdGhpcyBhbHJlYWR5IGluIG5leHQKPiA+ID4KPiA+Cj4g
PiBPaD8gV2hpY2ggY29tbWl0Pwo+Cj4gT2ggc2VlbXMgbGludXgtbmV4dCBoYXNuJ3QgYmVlbiB1
cGRhdGVkIGluIGEgZmV3IGRheXMsIHNvIHlvdSBjYW4gdHJ5Cj4gdGhpcyBwYXRjaDoKPgo+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDMwNzAyMDQwMy4zMDY4NTY3LTEtbWNncm9m
QGtlcm5lbC5vcmcvCgoKLS0tIGEvYmxvY2svYmRldi5jCisrKyBiL2Jsb2NrL2JkZXYuYwpAQCAt
MTgxLDYgKzE4MSw4IEBAIEVYUE9SVF9TWU1CT0woc2V0X2Jsb2Nrc2l6ZSk7CgogaW50IHNiX3Nl
dF9ibG9ja3NpemUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgaW50IHNpemUpCiB7CisgICAgICAg
aWYgKCEoc2ItPnNfdHlwZS0+ZnNfZmxhZ3MgJiBGU19MQlMpICYmIHNpemUgPiBQQUdFX1NJWkUp
CisgICAgICAgICAgICAgICByZXR1cm4gMDsKICAgICAgICBpZiAoc2V0X2Jsb2Nrc2l6ZShzYi0+
c19iZGV2X2ZpbGUsIHNpemUpKQogICAgICAgICAgICAgICAgcmV0dXJuIDA7Ci4uLgoKClRoYW5r
cywgYnV0IGxvb2tpbmcgYXQgdGhlIGNvZGUgY2hhbmdlLCBzZWVtcyBmaWxlc3lzdGVtcyB3aXRo
IEZTX0xCUwooZS5nLiwgYmNhY2hlZnMsIFhGUykgY2FuIHN0aWxsIG1vdW50IGxhcmdlciBibG9j
ayBzaXplcyBwcm9wZXJseS4gSU9XLAp0aGUgdGVzdCBpb2N0bF9sb29wMDYgc3RpbGwgZmFpbGVk
IG9uIFJIRUw5IChYRlMpIHBsYXRmb3JtLgoKSXMgdGhhdCBleHBlY3RlZD8gT3IsIHNob3VsZCB3
ZSBhZGp1c3QgdGhlIHRlc3RjYXNlIGZvciBGUyB3aXRoIEZTX0xCUwphcyBleGNlcHRpb24/CgoK
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
