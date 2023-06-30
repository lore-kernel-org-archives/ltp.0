Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61F4EB64D7
	for <ltp@archiver.kernel.org>; Fri, 30 Jun 2023 11:03:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09C1D3CC2DD
	for <ltp@archiver.kernel.org>; Fri, 30 Jun 2023 13:03:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1D473CC288
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 13:03:16 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F28C5601BAD
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 13:03:15 +0200 (CEST)
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7870821d9a1so1217182241.1
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688122994; x=1690714994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qaSOpIJ34lE/i1x2tvGLBrOLs+W6vzHjfhEOuxV19ks=;
 b=YSIXiaEyLlHOfSAOzhdmuXHBtBRPuHjhe0IyZTMaZXYA8Q1ogf9WjKBK4ubNa8yy7T
 LPOgne/3levBQ5eJi0FN09VM7LWClcOYf8OFKIifA7n3KB2/DUE54fg+dKc+24t129xF
 E2KBQTXY9m+XcIz9Ujq2xvREBbBwO8z/Uh10CgDirRTkaB52VnHSl8ntL2w+A2TdOwPl
 llqETPyym5UZag9qJKX2OTZYfAwR8IkaIhATI3sfd8UagvhSwpst3NtH0pCf9yHoK+nK
 40y36X5oIgJ8j4CrAeXf3euSOpzbUlybMgLZ3wE3fdPIr6lmhZslW2AWFTfa//A/vsr9
 L1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688122994; x=1690714994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qaSOpIJ34lE/i1x2tvGLBrOLs+W6vzHjfhEOuxV19ks=;
 b=T3k88hbQJIi96MKipzHmmQyqZbrrFiberYPYkhpn/YUr8xjNvZPkx4no3mMmb0l4pH
 DYr4J6ti0H0kKwvg7zfa1RJpR7LnpvpAwFbCvh3YBu6+8gdWgEWrCQl0bwUrH6mSgeFw
 NEQJ0Z4f58iAMesYx0uCV/P3fu3XmBWo64j2/fYjHdL9Qw2TRhfW1y42wvyq9kuI5GdH
 9Y8zxfF1+fPPPuTRfveSJKW8UdkciwjVLMcXSsk7RFCLFomjlwcxBEGiBsURJ2c6b+C5
 +GaGRF2xqWltGpWKcAFJG7rMw9PU/Q/5s/0SV220hIKCi7uA88SZXCCQCrpRL7D2Nqx6
 1xYQ==
X-Gm-Message-State: AC+VfDyO7KTfIhrBQusoInlFWcYvUsaOiPM/ZYFDnNdWO1Uwq2rKrsW1
 VxULoKCtI4x+lT6XmZShFcOZFo4rfcFUcQ+gXOw=
X-Google-Smtp-Source: ACHHUZ4oNPOjaFNEydL2qyGVP7Z5jKQXqW/31qp5iGWHqBT5c1C+evMUhHBNERjdX4J6ki6cDnI2zUPb7veFKa1qmlw=
X-Received: by 2002:a05:6102:ec8:b0:443:8053:f969 with SMTP id
 m8-20020a0561020ec800b004438053f969mr3563175vst.17.1688122994516; Fri, 30 Jun
 2023 04:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <t5az5bvpfqd3rrwla43437r5vplmkujdytixcxgm7sc4hojspg@jcc63stk66hz>
 <cover.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <e770188fd86595c6f39d4da86d906a824f8abca3.1687898895.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAOQ4uxjQcn9DUo_Z2LGTgG0SOViy8h5=ST_A5v1v=gdFLwj6Hw@mail.gmail.com>
 <q2nwpf74fngjdlhukkxvlxuz3xkaaq4aup7hzpqjkqlmlthag5@dsx6m7cgk5yt>
 <CAOQ4uxh-ALXa0N-aZzVtO9E5e6C5++OOnkbL=aPSwRbF=DL1Pw@mail.gmail.com>
 <3nfsszygfgzpli4xvwuwpli5ozpqtcnlij737qid6riwramjkv@pj23p6q5tzrb>
In-Reply-To: <3nfsszygfgzpli4xvwuwpli5ozpqtcnlij737qid6riwramjkv@pj23p6q5tzrb>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Jun 2023 14:03:03 +0300
Message-ID: <CAOQ4uxjqnaB1JJbd3u_oeFsH3V-zYwKftWy=gLhqTQVJvxAgKQ@mail.gmail.com>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] splice: always fsnotify_access(in),
 fsnotify_modify(out) on success
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Chung-Chiang Cheng <cccheng@synology.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgMTE6MTjigK9QTSBBaGVsZW5pYSBaaWVtaWHFhHNrYQo8
bmFiaWphY3psZXdlbGlAbmFiaWphY3psZXdlbGkueHl6PiB3cm90ZToKPgo+IE9uIFdlZCwgSnVu
IDI4LCAyMDIzIGF0IDA5OjM4OjAzUE0gKzAzMDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOgo+ID4g
T24gV2VkLCBKdW4gMjgsIDIwMjMgYXQgODowOeKAr1BNIEFoZWxlbmlhIFppZW1pYcWEc2thCj4g
PiA8bmFiaWphY3psZXdlbGlAbmFiaWphY3psZXdlbGkueHl6PiB3cm90ZToKPiA+ID4gT24gV2Vk
LCBKdW4gMjgsIDIwMjMgYXQgMDk6MzM6NDNBTSArMDMwMCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6
Cj4gPiA+ID4gSSB0aGluayB3ZSBuZWVkIHRvIGFkZCBhIHJ1bGUgdG8gZmFub3RpZnlfZXZlbnRz
X3N1cHBvcnRlZCgpIHRvIGJhbgo+ID4gPiA+IHNiL21vdW50IG1hcmtzIG9uIFNCX0tFUk5NT1VO
VCBhbmQgYmFja3BvcnQgdGhpcwo+ID4gPiA+IGZpeCB0byBMVFMga2VybmVscyAoSSB3aWxsIGxv
b2sgaW50byBpdCkgYW5kIHRoZW4gd2UgY2FuIGZpbmUgdHVuZQo+ID4gPiA+IHRoZSBzX2Zzbm90
aWZ5X2Nvbm5lY3RvcnMgb3B0aW1pemF0aW9uIGluIGZzbm90aWZ5X3BhcmVudCgpIGZvcgo+ID4g
PiA+IHRoZSBTQl9LRVJOTU9VTlQgc3BlY2lhbCBjYXNlLgo+ID4gPiA+IFRoaXMgbWF5IGJlIGFi
bGUgdG8gc2F2ZSB5b3VyIHBhdGNoIGZvciB0aGUgZmFpdGggb2YgTkFDS2VkCj4gPiA+ID4gZm9y
IHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24uCj4gPiA+IFRoaXMgZ29lcyBvdmVyIG15IGhlYWQsIGJ1
dCBpZiBKYW4gc2F5cyBpdCBtYWtlcyBzZW5zZQo+ID4gPiB0aGVuIGl0IG11c3QgZG8uCj4gPiBI
ZXJlIHlvdSBnbzoKPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9hbWlyNzNpbC9saW51eC9jb21taXRz
L2Zzbm90aWZ5X3BpcGUKPiA+Cj4gPiBJIGVuZGVkIHVwIHVzaW5nIFNCX05PVVNFUiB3aGljaCBp
cyBuYXJyb3dlciB0aGFuCj4gPiBTQl9LRVJOTU9VTlQuCj4gPgo+ID4gQ2FyZSB0byB0ZXN0Pwo+
ID4gMSkgRnVuY3Rpb25hbGx5IC0gdGhhdCBJIGRpZCBub3QgYnJlYWsgeW91ciB0ZXN0cy4KPiAp
IHwgZ3ppcCAtZCA+IGlub3RpZnkxMzsgY2htb2QgK3ggaW5vdGlmeTEzOyBleGVjIC4vaW5vdGlm
eTEzCj4gdHN0X3Rlc3QuYzoxNTYwOiBUSU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAz
MHMKPiBpbm90aWZ5MTMuYzoyNjA6IFRJTkZPOiBmaWxlX3RvX3BpcGUKPiBpbm90aWZ5MTMuYzoy
Njk6IFRQQVNTOiDQvtC6Cj4gaW5vdGlmeTEzLmM6MjYwOiBUSU5GTzogZmlsZV90b19waXBlCj4g
aW5vdGlmeTEzLmM6MjY5OiBUUEFTUzog0L7Qugo+IGlub3RpZnkxMy5jOjI2MDogVElORk86IHNw
bGljZV9waXBlX3RvX2ZpbGUKPiBpbm90aWZ5MTMuYzoyNjk6IFRQQVNTOiDQvtC6Cj4gaW5vdGlm
eTEzLmM6MjYwOiBUSU5GTzogcGlwZV90b19waXBlCj4gaW5vdGlmeTEzLmM6MjY5OiBUUEFTUzog
0L7Qugo+IGlub3RpZnkxMy5jOjI2MDogVElORk86IHBpcGVfdG9fcGlwZQo+IGlub3RpZnkxMy5j
OjI2OTogVFBBU1M6INC+0LoKPiBpbm90aWZ5MTMuYzoyNjA6IFRJTkZPOiB2bXNwbGljZV9waXBl
X3RvX21lbQo+IGlub3RpZnkxMy5jOjI2OTogVFBBU1M6INC+0LoKPiBpbm90aWZ5MTMuYzoyNjA6
IFRJTkZPOiB2bXNwbGljZV9tZW1fdG9fcGlwZQo+IGlub3RpZnkxMy5jOjI2OTogVFBBU1M6INC+
0LoKPgo+IFN1bW1hcnk6Cj4gcGFzc2VkICAgNwo+IGZhaWxlZCAgIDAKPiBicm9rZW4gICAwCj4g
c2tpcHBlZCAgMAo+IHdhcm5pbmdzIDAKPgo+IFRoZSBkaXNjcmV0ZSB0ZXN0cyBmcm9tIGJlZm9y
ZSBhbHNvIHdvcmsgYXMgZXhwZWN0ZWQsCj4gYm90aCB0byBhIGZpZm8gYW5kIGFuIGFub24gcGlw
ZS4KPgo+ID4gMikgT3B0aW1pemF0aW9uIC0gdGhhdCB3aGVuIG9uZSBhbm9uIHBpcGUgaGFzIGFu
IGlub3RpZnkgd2F0Y2gKPiA+IHdyaXRlIHRvIGFub3RoZXIgYW5vbiBwaXBlIHN0b3BzIGF0IGZz
bm90aWZ5X2lub2RlX2hhc193YXRjaGVycygpCj4gPiBhbmQgZG9lcyBub3QgZ2V0IHRvIGZzbm90
aWZ5KCkuCj4gWWVzLCBJIGNhbiBjb25maXJtIHRoaXMgYXMgd2VsbDogZnNub3RpZnlfcGFyZW50
KCkgb25seSBjb250aW51ZXMgdG8KPiBmc25vdGlmeSgpIGZvciB0aGUgd2F0Y2hlZCBwaXBlOyB3
cml0ZXMgdG8gb3RoZXIgcGlwZXMgZWFybHktZXhpdC4KPgo+IFRvIHZhbGlkYXRlIHRoZSBjb3Vu
dGVyZmFjdHVhbCwgSSByZXZlcnRlZCAiZnNub3RpZnk6IG9wdGltaXplIHRoZSBjYXNlCj4gb2Yg
YW5vbnltb3VzIHBpcGUgd2l0aCBubyB3YXRjaGVzIiBhbmQgZnNub3RpZnkoKSB3YXMgYmVpbmcg
Y2FsbGVkCj4gZm9yIGVhY2ggYW5vbiBwaXBlIHdyaXRlLCBzbyBsb25nIGFzIGFueSBhbm9uIHBp
cGUgd2F0Y2hlcyB3ZXJlIHJlZ2lzdGVyZWQuCgpUaGFuayB5b3UgZm9yIHRlc3RpbmchCgpBcyBK
YW4gc3VnZ2VzdGVkLCB3aGVuIHlvdSBwb3N0IHY1LCB3aXRoIG15IFJldmlld2VkLWJ5IGFuZCBK
YW4ncwpBY2tlZC1ieSwgcGxlYXNlIGFzayBDaHJpc3RpYW4gdG8gcmV2aWV3IGFuZCBjb25zaWRl
ciB0YWtpbmcgdGhlc2UKcGF0Y2hlcyB0aHJvdWdoIHRoZSB2ZnMgdHJlZSBmb3IgdGhlIDYuNiBy
ZWxlYXNlLgoKUGxlYXNlIGluY2x1ZGUgYSBsaW5rIHRvIHlvdXIgTFRQIHRlc3QgaW4gdGhlIGNv
dmVyIGxldHRlciBhbmQgYSBsaW5rIHRvCm15IHBlcmZvcm1hbmNlIG9wdGltaXphdGlvbiBwYXRj
aGVzLgoKVW5sZXNzIHRoZSBrZXJuZWwgdGVzdCBib3RzIGRldGVjdCBhIHBlcmZvcm1hbmNlIHJl
Z3Jlc3Npb24gZHVlIHRvCnlvdXIgcGF0Y2hlcywgSSBhbSBub3Qgc3VyZSB3aGV0aGVyIG9yIG5v
dCBvciB3aGVuIHdlIHdpbGwgYXBwbHkgdGhlCm9wdGltaXphdGlvbiBwYXRjaGVzLgoKVGhhbmtz
LApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
