Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB66606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=XWHbvM19;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Dan+lrkb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793344962; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ju7XCdSnwyzxECIPpLjK8aezP+OGudFzgw/LcsB4N10=;
 b=XWHbvM19dvLgoIKEiEBMqxvLreRVB/tIrlisGjPO2wsOnqkq3rVwdpAHlrLrYW1OgEt6y
 3j/LElqo3yazskX8IVUw8hd0xJHuaIkO3o2ZuSImCXuLanY9N8tyIvAG6Zvi7SEf9rkvBcH
 PUCOApgKra5EBZp4+fCFl1/uxxWVqYE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 390C83E5EA7
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 08:22:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C15803E1B53
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 08:22:23 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E06B9600AAA
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 08:22:22 +0100 (CET)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67a6cc9acbeso153258d50.3
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 00:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793344941; cv=none;
 d=google.com; s=arc-20260327;
 b=c40j0H0VYOaiUg34AuYFTmvcj+d3Kv5pC+/JcVlxfclyA8T0rMvmt1K7AEO+Nnbqw4
 fE5xo01Dkb4KdEWv/Eq/RujCGmES0tOaoxQBIDMSjWrxolfmMyD3dSUtTMFpnt4tYVFx
 mMxjKOiJ/dsjMbBoAAAlU63wSy2RybCO7ansjEezSse16JPasTTs2l9Y7EvMYobXoooB
 yxooTlDC2HHFVtHl2fbB77Tav/ve/+lwzwJMwax/+vdOzmy8pSj+xWUwB0WcSGUNWrUs
 rmm3moRoEovwJxpGbmmJLDdxzmzJh/72esA8ZqAV+VVvBqdJsyonoRtElMrHSHbFEHG2
 4rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=isr3BhxstJWv2oy7LwGP/91UK/OIHOM3lR9eKMxl94o=;
 fh=boz8XFBVh1Gvdi55OEongOBEDj1zRnKLjhrzYe7e5IM=;
 b=Eyw+GSmnnldZatx5nkU4o8u+4tXzl6Y3TRJmzGMwmfhd1wev7cxC4QEpiYcATTeZeA
 m1h8lCAIjnwEM0YKjCpzWZBGWFWsD0xN6z/LCCjuNIlP/9wTYdc517B/9RQt4CbzN3aO
 nYxpvhfnFX3pD38qDmJkNPOTVFOWHlaa1cVdrIewq6rjJuCs5VNAz/RdKBdMDKfc1N6k
 nvSJME9+9uZnNetnb8opaATLnrHzcCIr2FV97GVRM+9Chp3oZ+vX+mcqWCjDV0KfW3an
 cQeMk9tkZAKFYXh5LNNnyLK8yAPM9igE4iesr34N+O1YoQEITRI5X07ba+3xDvMX+as9
 IT9A==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793344941; x=1793949741; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=isr3BhxstJWv2oy7LwGP/91UK/OIHOM3lR9eKMxl94o=;
 b=Dan+lrkbfKMCzf2R9tQbu5WrjI2AdmnWNFf1CY2oJtpvD5Srd20kV/zlYgtpzTPQwH
 1KNHKOclVgw0dc/t6mqHujdA+a18ahpEtZ/rG2XZaSyJRNs25OntB2W+yvA6ficMr8IG
 BhN/rONnRinwol1LKH2MlYlBfCoZ5sc/jw/pob9vRAYbRmum8ncI6ZTQJHIKXDVlf3vq
 UoTMe58qrOzUgy4N8XZIeICdI7/N+lvUtClcEmq39fPIeqI40hLllZbMKb+zxwouKdTQ
 NlqiaGXsMzgfetRhfcyDhCxLD490T5lIZYLH1r89LTBh0Cx7+HKRPtU3n7izNpiWV4ds
 aqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793344941; x=1793949741;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=isr3BhxstJWv2oy7LwGP/91UK/OIHOM3lR9eKMxl94o=;
 b=h/QP3LXIj9SOTHi61bN6eHSsPxo4osIZqmj9UJ5IrllGuqV4VnMkZdUKT70ynPK0mO
 6/GxZ1lVJMNE2FoM2PAw1aI9ROaQZSDERhVgbOuDJw6IG/S+TLaL3hqKnnHxGAP1Mzfu
 jOfVtMw/BU6OBItfk41Gfm89ZcqVNouUWMFFp92czbecoNc4tG9E49h5BQQ8cjjmLDQj
 mA6toktI3qB3+PPYfRFKFj09mLGvs4/Sz81qildvypNyNd2m6ZUmUEEIxXweQQL3UfkS
 +3tpw2mr63dr/o1rRQwxFMlOHaPa2RlTrpUeEp5p1Z3XZiWAT4sAgaAV19dD6cAi8vGY
 MXeQ==
X-Gm-Message-State: AFq9FYINpfeCkQacikveQQaoYUBDzXcOY/lCjZX4qM2Ux4DOtmRGIPfn
 tNp9mfFbRyiWZQdQLZmFszqnYYwjcFcuzOmMWlQFZZhFsCC0PrAbsUCyrnOhIuGmWDmIXVzwiXA
 Zl5mAkwrBx0qNTciDWxxpeERpcu+iVyR8Q8Y4daNH
X-Gm-Gg: AYBFou0Q17G6hZ4r0Gzt4hBfKdzDyt2xtUmaxWhk3FQxFsuazUoyrntynAasu5vp7qq
 YfwBWmg6J4Cxyz7+NeE/Kl4WDzLOVJNwweGizfgGBL1g4LE/90iGTm8+lx9NqllJSnu4E4vpymb
 bD4zOA2e0GIz2pQzv+yHZ+ZxpY68coJgs9FsvnhcYacExPyVwseybKJDuerP17wFGmro0+adUTH
 Bg3JPzBrxf/IbnpjA8a7gTWF5WeUW2hH0DWPAPdNkRVNZkVODjjmhpTx4shuGuOGEgqIQA7iCiQ
 Gb87Zcvd6tyGfS+s+azm3xsshCEZb+y2GHKXOIr/QTI8jQKVf4ym5v5mcDTPjd91/fS/onzOpvb
 sdOUguqD7OosQFDXr3GdZ3dyY1Kv9ZyUF3o42R410hHPYEUTHg4IUrponOf6+TV3ocIsGdWOOR4
 sWX4MmHjZYRBxVW8sMrmoSNEkjwx6BmqxSSEUsI027Iz2f2VSDtK8dkaVd+O02LyXzo6aAITgIH
 4AABcfagGxFRGbp6ww=
X-Received: by 2002:a05:690e:1c1a:b0:677:d31f:5a6b with SMTP id
 956f58d0204a3-67ba4fa14cdmr1229633d50.16.1793344940979; Fri, 30 Oct 2026
 00:22:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019132621.3943362-1-wakel@google.com>
 <AtUuaJpLQ5fehj5aJ3y4dJHs3nd7boLw8jhr@localhost.localdomain>
In-Reply-To: <AtUuaJpLQ5fehj5aJ3y4dJHs3nd7boLw8jhr@localhost.localdomain>
Date: Fri, 30 Oct 2026 15:21:44 +0800
X-Gm-Features: AclHuK-IGpz3PggYTXHNY9s-uVN2rCKh73VU1IGYG157KNBS31EtfWrEMWkVmvI
Message-ID: <CAOcRiAF20nEXGEw-VLTzF6u0eoUUZYrVZgAaKh6oUYG+ByTqbg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] swapon04: Report TCONF when SELinux denies
 loop device I/O
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKT24gV2VkLCBPY3QgMjEsIDIwMjYgYXQgMDk6MzE6NTJBTSArMDAwMCwgQW5k
cmVhIENlcnZlc2F0byB3cm90ZToKPiBCdXQgZGlkIHlvdSBjaGVjayBpZiBvdGhlciB0ZXN0cyBh
cmUgaGF2aW5nIHRoZSBzYW1lIGlzc3VlPwoKWWVzLiBPbmx5IGxvb3AgZGV2aWNlcyBiYWNrZWQg
YnkgYSBmaWxlIG9uIHRoZSBmcmVzaGx5IGZvcm1hdHRlZCB0ZXN0CmZpbGVzeXN0ZW0gYXJlIGFm
ZmVjdGVkLCBzaW5jZSB0aG9zZSBmaWxlcyBoYXZlIG5vIFNFTGludXggbGFiZWwsIGFuZApzd2Fw
b24wNCBpcyB0aGUgb25seSB0ZXN0IHRoYXQgZG9lcyB0aGF0LgoKVGhlIG90aGVyIGxvb3AgdXNl
cnMgKGlvY3RsX2xvb3AqLCBpb2N0bDA5LCB1ZXZlbnQwMSwgc3lzX2Jsb2NrX2xvb3AwMSwKaXNv
ZnMuc2ggYW5kIHF1b3RhX3JlbW91bnRfdGVzdDAxLnNoKSBrZWVwIHRoZWlyIGltYWdlcyBpbiBU
TVBESVIsIGxpa2UKdGhlIHRlc3QgZGV2aWNlIGl0c2VsZiwgYW5kIEFuZHJvaWQncyBwb2xpY3kg
YWxsb3dzIHRoZSBrZXJuZWwgZG9tYWluCnRvIGFjY2VzcyBmaWxlcyB0aGVyZS4gU3dhcCBmaWxl
cyBvbiB0aGUgdGVzdCBmaWxlc3lzdGVtIGFyZSBmaW5lIHRvbywKc2luY2Ugc3dhcCBJL08gZG9l
cyBub3QgZ28gdGhyb3VnaCB2ZnNfaXRlcl97cmVhZCx3cml0ZX0oKS4KClRoYW5rcywKV2FrZQoK
T24gV2VkLCBPY3QgMjEsIDIwMjYgYXQgNTozMeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4gSGkgV2FrZSwKPgo+IHVuZm9ydHVuYXRl
bHkgSSBkb24ndCBzZWUgb3RoZXIgb3B0aW9ucyBhdmFpbGFibGUgYnV0IHNraXBwaW5nIHRoZSB0
ZXN0Cj4gImd1ZXNzaW5nIiB0aGF0IFNFTGludXggZW5mb3JjZW1lbnQgaXMgcHJvZHVjaW5nIGFu
IEVJTyBlcnJvci4KPgo+IEJ1dCBkaWQgeW91IGNoZWNrIGlmIG90aGVyIHRlc3RzIGFyZSBoYXZp
bmcgdGhlIHNhbWUgaXNzdWU/Cj4KPiBSZWdhcmRzLAo+IC0tCj4gQW5kcmVhIENlcnZlc2F0bwo+
IFNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3Vz
ZS5jb20KCgoKLS0gCkJlc3QgUmVnYXJkcywKV2FrZSBMaXUKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
