Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC659C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 07:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787728157; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=jx/dwQjF2I1EQSbkQDyK3DiiZ2MF06MMVHv8yScW9Ew=;
 b=KItkZqtinBdHBEcmIxqO4Vts4WWIoU3+TxLIUYg4uf1dhRSZSekgzP/ssPiGtqv+3JgRF
 mkG6M11/hgfuOnD9ZhyI03bQ3Cq/SYBBjlLnDAgfaSVExCoQ8itq4W7rWH5gZqi0/m3DXPI
 ftlJRapijWZSgnjWQKrFTd6/uLlUoTI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B77CB3CBFBC
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 09:09:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26FDC3C2861
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 02:24:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3633E1A0068B
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 02:23:58 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2A46843CB6
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 00:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BCD1F00ADF
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 00:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787703835;
 bh=uUTmiHFEOceLcx9itCYMJtIGYFbMp7iKyog+97ymqj0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=WNi8rtEHOpv6c5q+N+tg2xIhLjQjOyGzIMxMZMW0sc3bpo2s/dU7+NuyxOwoVYRal
 4M4tuq2xyGOxYQpTsA0pzm3TpkiWOrQw+F83ajnPAOroSHnMP0SJAm7oU6R+WV3O+4
 TI6alN6C57pYasJ0YZOXCEQID6Su0BrCcHzGxy/F+IglO0Rekmfyeonm4GPTUdTPSv
 ABRrEGgkXjVrrfZPTyVINvP2A5vl51GyM5+Ck9yluLF305lcxm47KIUMakUJC1wd4y
 i9exey4lrUemz/+SoNulVpozyHRjdu/OOOeQGwGZCjF+SwSMWRuPPpLtl7ctr2uVNn
 dhVdyDtDLx8hA==
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so484013a12.2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 17:23:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpcTfgVVOaV8vp2qzfspoY7FYuOqOfVmJtykgWdQU7sHhYnFSkEpSoyVQ1mEbTgdf9roe0=@lists.linux.it
X-Gm-Message-State: AFuF++m7JnPNsQqzaT02V/zQc6U8VC4YNFFhL8GhoK0eErRFqBxkSzaO
 AhVCisJLEf1PE/OXUYkBTdakPLrpxadCGs65qhIYy00Tnb/uvr2ZtFiHs0QgKqSzk9uG6KjEXs1
 LD6ccOeDcGSyMc7qRpT16DkiLSBTKkjw=
X-Received: by 2002:a05:6402:a0d9:b0:6a1:2863:ad75 with SMTP id
 4fb4d7f45d1cf-6a5df64d838mr2965272a12.13.1787703833588; Tue, 25 Aug 2026
 17:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <ajQFErzQW4qfU_Cp@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <6a463902.41a38e5f.27f5bd.337a@mx.google.com>
 <akzN_iISxNTztbEw@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <20260825112755.GA62429@pevik> <ao2TtyQpCGP5TLpx@yuki.lan>
 <20260825132604.GA70046@pevik> <ao2cpyGYcL-rZLgc@yuki.lan>
In-Reply-To: <ao2cpyGYcL-rZLgc@yuki.lan>
Date: Wed, 26 Aug 2026 09:23:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_3Za8Jzan9VV4WrK1ATB2WXTazLVuGJ5ViQ8RGp0xbLw@mail.gmail.com>
X-Gm-Features: AcwNN1UeAvkSqSZ2B8OwXMcLplrAMtwLAx7uHZMrWWrrghcYdk3dsO2C_j9V2AY
Message-ID: <CAKYAXd_3Za8Jzan9VV4WrK1ATB2WXTazLVuGJ5ViQ8RGp0xbLw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 26 Aug 2026 09:08:58 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
From: Namjae Jeon via ltp <ltp@lists.linux.it>
Reply-To: Namjae Jeon <linkinjeon@kernel.org>
Cc: regressions@lists.linux.dev, Yuezhang Mo <yuezhang.mo@sony.com>,
 linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBdWcgMjUsIDIwMjYgYXQgMTA6NDbigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cj4KPiBIaSEKSGkgQ3lyaWwsIFBldHIsCj4gPiA+IFRoYXQgZG9lcyBu
b3QgbWFrZSBtdWNoIHNlbnNlLCBpZiBzd2FwX2FjdGl2YXRlIHdhcyBhZGRlZCB0byBrZXJuZWws
Cj4gPiA+IHByZS1maWxsaW5nIHRoZSBmYWxsb2NhdGVkIGZpbGUgc2hvdWxkbid0IGJlIG5lZWRl
ZCBhbnltb3JlLgo+ID4KPiA+IEdvb2QgY2F0Y2gsIHlvdSdyZSByaWdodC4gSSdtIGFsc28gY29u
ZnVzZWQsIGJlZm9yZSB2Ny4yIHN3YXAgd29ya2VkIG9uIGV4ZmF0LAo+ID4gbm93IGV2ZW4gd2l0
aCA4MmE4MWE3MzUyYmMgKCJleGZhdDogYWRkIGlvbWFwIGJ1ZmZlcmVkIEkvTyBzdXBwb3J0Iikg
WzJdCj4gPiBhbmQgeW91ciBmaXggMDNhNDM2NzdjYTkxICgiZXhmYXQ6IGFkZCBzd2FwX2FjdGl2
YXRlIHN1cHBvcnQiKSBbM10gaXMgbm90Cj4gPiB3b3JraW5nLiBPYnZpb3VzbHkgdGhlIGZpeCB3
YXMgbm90IGdvb2QgZW5vdWdoLgo+Cj4gVGhlcmUgd2VyZSB0d28gYnVncyBJIHN1cHBvc2UsIG9u
ZSBpcyB0aGF0IGZhbGxvY2F0ZSgpIHN1cHBvcnQgZm9yIGV4ZmF0IGJyb2tlCj4gdGhlIHN3YXBv
biBvbiBmYWxsb2NhdGVkIGZpbGUuIFRoZSBzZWNvbmQgYnVnIHdhcyBpbnRyb2R1Y2VkIGxhdGVy
IHdoZW4KPiBleGZhdCB3YXMgcmV3cml0dGVuIHRvIHVzZSBpb21hcC4gVGhlIGlvbWFwIGNhc2Ug
d2FzIGZpeGVkIGluIHRoZSBwYXRjaAo+IGFib3ZlLCBob3dldmVyIGl0IGxvb2tzIGxpa2UgdGhl
IG9yaWdpbmFsIGJ1ZyBjYXVzZWQgYnkgZmFsbG9jYXRlKCkKPiBpbXBsZW1lbnRhdGlvbiBmb3Ig
ZXhmYXQgaXMgc3RpbGwgdGhlcmUuCkNhbiB5b3UgY2hlY2sgaWYgYW4gYXR0YWNoZWQgcGF0Y2gg
aW1wcm92ZXMgdGhpcyBpc3N1ZT8KVGhhbmtzLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
