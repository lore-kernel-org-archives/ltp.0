Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA223606A329
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0TqxmT5K
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EA623EA9D9
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 11:37:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35C283C9FEA
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 11:36:49 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C534C60048B
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 11:36:48 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b408f2d936so4864823a12.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 02:36:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794825408; cv=none;
 d=google.com; s=arc-20260327;
 b=QXEIzRdLu46i5gZUmwMp7Y70FNgrrYBAzgB9UZPZXhdBYjZBMe4NxOB1UyXmw5hmib
 JDoaT3WZyW4XsHVMHqrxsRnqDP5Qrd7zdPRgddoGdYFosVmWOcdwmPL9mvn2RVrkk+IU
 nhXPEl6cJ3DW/yDt/LeGhgxciduyLLN5GlzVOANcQYBE71/wg7hoWRIGeHtdW+qU/E1l
 bw5FGymLpbFM664RwqfyQWfa0i6mV/ccRClxj0ww7/Y1CEhQuSR8B/fXGeqsJjzL42jd
 +6rAzlmjpRVTWu7C0HF89uH6nBNVQ25nCmSseBSc2LjN/ujBDWGuNbAC9gaSxRm1ODhF
 qvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pedML6bHDM7aD8oogul9+mPFZrxypUfomC6Sz1gdUxE=;
 fh=WW/X4kbgagii++oE6GLhljtG5wx8NCy6ixyvMieckW0=;
 b=FJ1fQKCH+6FC36p/iM8tRTNywbK0HljBsYEk1Tha1B2NczVa4ji57ks9C/tS/eOhwL
 JS63KGQt7Dc4H/pXwCgt28IbOfSkDZqQMi7VpqHGv3KHJYWEs2vUQQfTjkA7ltf59r7f
 RtJcywUqcMyTvbVROUSJgeGZY2NXcUyQ9fuhrfl1aBELrq0MmP8O7Hzh4W4V4XzU+UYt
 pLqHaQEz3Id8p+AE7xcqHeYnh7PtEJOvsz9xANvMYKbgr5DhexWSKf9/jYdAh389ti5X
 ZYrrs3d0uCLKFQYmIQ5HBxGDb/9wCLIzUsgQ45PbNmH3cCEZ4CgZ2VdNimNlLHixZ9KH
 rxdg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794825408; x=1795430208; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pedML6bHDM7aD8oogul9+mPFZrxypUfomC6Sz1gdUxE=;
 b=0TqxmT5K3Ou6qaK3ynYd6SP+lRBYtcKfCJofoRAkVMTdNZNNfKD2ku/rTOHAMKzgQz
 VAOqHcLcLzw1oymcx06zEIoMQ2OemRrXfcCm/AgGqQSj9GwWmk8t3a0Ua74G87yH7DqN
 EzkszqoSxBB4yQEoMHKg10nfjabhLAbd60lrc6MkhF3S2yxKJ4hEcn2pydOkKj3s3XTE
 VkMD0wH5IeJ83qbmAI/8zn5bT2dHcc3SXK8xfyNMGA8Q2syXlOKUeTfDNVcWgMe84CPj
 5icKidTiwbFDuOPYlnhF0EkwGKCz+BmYsYDfVuyVEQwxvcXxnj3wHLu9oafeLtwIzNhR
 pJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794825408; x=1795430208;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pedML6bHDM7aD8oogul9+mPFZrxypUfomC6Sz1gdUxE=;
 b=dOhZOL6I1WhuNIXI4/zbJrRyydhI1hL1A22VX4Luq4nEeb/EYDwTUfiUect67IzX+K
 +D/vGq5vgKZ6Q7385JR1kkI0Aw+5MrgHy9bazvexJIHv0oZZBc6yh5LDPob0Wyc6vCjA
 IMwikDqwkNfyOJMQLHpcoYOPokjaMXf36P/AlUAlyElT0MaIONYP348Qtx7Ovar5KwiK
 WIpNTo/znVVxmsqvW0p2glw2Y8SpOYF9GXKeEyyfyXSLDjpCui2S4ceL3zVefxW7KDxS
 1Ee62sqbJKpXgwhyvAEdrsfHNKrowJxIel127olf/4Y3vXyi8iDgOJFH56Y/+FcbILDr
 dJFg==
X-Gm-Message-State: APuU4Z/1jVXGyAbypA1lLtDUxSEU4v6Nfo/5i4GE8OUCcXrhGnXdPdc8
 ZFvG6pbIylwF5DYRuSkA4qnN2mcaOmfQqCeJMVFxviOAPmp+HMVyiutBuvKTyC1LiOHSpPYsy+w
 btiX3c1asTd3+Im5AOQY39xAy8Js+iws=
X-Gm-Gg: AYBFou3X8dAf6Bt2FuGx5SEZjx9XM3DfLfBV+OUp2fXK+1UY8QOHkGYUXMwNvsiGBm9
 GxvUADKF7T3x3aWuEGbZBTu4lPlyIu+I7I52Ec0Bwdc6Voz5g9H/7wLnn5JpkuWm4Ha/uDXXvcH
 +cQ1IOmU3/TZM64Bur0eRx8uNbQdnAPo6zWhX9+z/uFGekzAUpyqek9rrTVe26LJdZ0/fUCAtgn
 1wsDcHdRlXODq1o4gMfKu6oWyH623VovAoCMBIVmo6+PwY9u6QFIfgWYaGY01X1ck25BT2dGOOc
 tIv6qVJS0zfFa3PXYzbXlqclfI+NC4qt9jD9uPpv6tbNoWeAp46r0mULQlu3Lh1txUfwNoz+76A
 hsCnzUzdfk+KNEgVB3z3Fxy9K5bK10P9Who5HEa4TVnUK0AdMIprATmdRMG4ce3QVBBDXqyvtdE
 JhBuaTIbDKz5SkhOQ=
X-Received: by 2002:a05:6402:4025:b0:6b7:84ad:92a6 with SMTP id
 4fb4d7f45d1cf-6b7c0cea4f1mr7201418a12.40.1794825407889; Mon, 16 Nov 2026
 02:36:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116073956.98789-1-zhaogongyi@bytedance.com>
In-Reply-To: <20261116073956.98789-1-zhaogongyi@bytedance.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 11:36:36 +0100
X-Gm-Features: AclHuK-gvmF6BupwtdPpX82oh2H7hzwkSKq4B-Amhp0GHSqbMiJggb3mUOZTgWE
Message-ID: <CAOQ4uxiADP5-Vx3MGryQiXP9VnKUgFkhjkh7p_w8c84-vX0NNw@mail.gmail.com>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify13: clean overlay workdir when restoring
 lower objects
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBOb3YgMTYsIDIwMjYgYXQgODo0MOKAr0FNIFpoYW8gR29uZ3lpIDx6aGFvZ29uZ3lp
QGJ5dGVkYW5jZS5jb20+IHdyb3RlOgo+Cj4gVGhlIEZBTl9ERUxFVEVfU0VMRiB0ZXN0IGNhc2Ug
cmVtb3ZlcyB0ZXN0IGZpbGVzLiBGb3IgbG93ZXIgdmFyaWFudHMsCj4gb3ZlcmxheWZzIGNyZWF0
ZXMgdXBwZXIgd2hpdGVvdXRzIHRvIGhpZGUgdGhlIGxvd2VyIG9iamVjdHMuIFRoZSBjdXJyZW50
Cj4gY2xlYW5fdXBwZXJfZGlyKCkgaGVscGVyIHVubW91bnRzIG92ZXJsYXlmcyBhbmQgcmVtb3Zl
cyBvbmx5IHRoZSBvYmplY3QKPiBuYW1lcyBmcm9tIE9WTF9VUFBFUiBiZWZvcmUgcmVtb3VudGlu
ZyBvdmVybGF5ZnMuCj4KPiBXaGVuIG92ZXJsYXlmcyBpcyBtb3VudGVkIHdpdGggbmZzX2V4cG9y
dC9pbmRleCBlbmFibGVkIGJ5IGRlZmF1bHQsCj4gZGVsZXRpbmcgbG93ZXIgb2JqZWN0cyBtYXkg
YWxzbyBsZWF2ZSBpbmRleCBlbnRyaWVzIHVuZGVyIE9WTF9XT1JLLgo+IFJlbW92aW5nIG9ubHkg
dGhlIHVwcGVyIHdoaXRlb3V0cyBjYW4gbGVhdmUgc3RhbGUgaW5kZXggc3RhdGUuIE9uIHJlbW91
bnQsCj4gY29sbGVjdGluZyB0aGUgcmVjcmVhdGVkIG9iamVjdCBpZHMgbWF5IHRoZW4gZmFpbCB3
aXRoOgo+Cj4gICBvdmVybGF5ZnM6IGJhZCBpbmRleCBmb3VuZCAoLi4uIGZ0eXBlPTIwMDAsIG9y
aWdpbiBmdHlwZT04MDAwKQo+ICAgZmFub3RpZnkuaDo4NTogVEJST0s6IHN0YXRmcyh0c3RtbnQv
ZmlsZV9vbmUsIC4uLikgZmFpbGVkOiBFSU8gKDUpCj4KPiBQdXJnZSBib3RoIE9WTF9VUFBFUiBh
bmQgT1ZMX1dPUksgYmVmb3JlIHJlbW91bnRpbmcgb3ZlcmxheWZzIHNvIHRoZQo+IGxvd2VyLXZh
cmlhbnQgcmVzdG9yZSBzdGFydHMgZnJvbSBhIGNsZWFuIG92ZXJsYXkgdXBwZXIvd29yayBzdGF0
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpoYW8gR29uZ3lpIDx6aGFvZ29uZ3lpQGJ5dGVkYW5jZS5j
b20+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkx
My5jIHwgMTMgKysrKysrKy0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmFub3RpZnkvZmFub3RpZnkxMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5v
dGlmeS9mYW5vdGlmeTEzLmMKPiBpbmRleCBhNDNmYWU4Li5mZGU3NjVlIDEwMDY0NAo+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkxMy5jCj4gKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTEzLmMKPiBAQCAtMTQy
LDE1ICsxNDIsMTYgQEAgc3RhdGljIHZvaWQgZGVsZXRlX29iamVjdHModm9pZCkKPiAtCj4gKwo+
ICBzdGF0aWMgdm9pZCBjbGVhbl91cHBlcl9kaXIodm9pZCkKPiAgewo+IC0gICAgICAgdW5zaWdu
ZWQgaW50IGk7Cj4gLQo+ICAgICAgICAgU0FGRV9VTU9VTlQoTU9VTlRfUEFUSCk7Cj4gICAgICAg
ICBTQUZFX1VNT1VOVChPVkxfTU5UKTsKPiAtCj4gKwo+IC0gICAgICAgU0FGRV9NT1VOVChPVkxf
VVBQRVIsIE1PVU5UX1BBVEgsICJub25lIiwgTVNfQklORCwgTlVMTCk7Cj4gLSAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgQVJSQVlfU0laRShvYmplY3RzKTsgaSsrKQo+IC0gICAgICAgICAgICAgICBT
QUZFX1VOTElOSyhvYmplY3RzW2ldLnBhdGgpOwo+IC0gICAgICAgU0FGRV9VTU9VTlQoTU9VTlRf
UEFUSCk7Cj4gKyAgICAgICAvKgo+ICsgICAgICAgICogRkFOX0RFTEVURV9TRUxGIG9uIGxvd2Vy
IG9iamVjdHMgY3JlYXRlcyB3aGl0ZW91dHMgaW4gdXBwZXIgYW5kLAo+ICsgICAgICAgICogd2l0
aCBuZnNfZXhwb3J0L2luZGV4IGVuYWJsZWQsIGluZGV4IGVudHJpZXMgdW5kZXIgd29ya2Rpci4g
UmVtb3ZlCj4gKyAgICAgICAgKiBib3RoIHRyZWVzIGJlZm9yZSByZW1vdW50aW5nIG92ZXJsYXlm
cyB0byBhdm9pZCBzdGFsZSBpbmRleCBzdGF0ZS4KPiArICAgICAgICAqLwo+ICsgICAgICAgdHN0
X3B1cmdlX2RpcihPVkxfVVBQRVIpOwo+ICsgICAgICAgdHN0X3B1cmdlX2RpcihPVkxfV09SSyk7
Cj4gLQo+ICsKCldpdGhvdXQgdHJhaWxpbmcgc3BhY2VzIGhlcmUgYW5kIGFib3ZlCgpSZXZpZXdl
ZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
