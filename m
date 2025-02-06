Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6643C02192
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 02:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738808923; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JKtCtWqB6cWezpiSKLJy1Pva/ya81VVGPFC9oGrkYCc=;
 b=n3u0Iphyit3HDKSQf7wvu5hJdU7JFjrrrPHQiam8Goo44dVzPmslXoJkNokFihE7BRBqP
 gwTiEYOdORXwIPcaStYbTYNU7somfbZZUPATkMCKCLRUV29aP3dZW7QsS4caN1e7Zh13Nji
 Oj2ko7s09FMvKP+gzYVkACiOx/S/3xs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 443BC3C9287
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 03:28:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714AD3C813C
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 03:28:23 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3718142BF94
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 03:28:21 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso3741645e9.2
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 18:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738808901; x=1739413701; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sgIsObDnT+YU7j+7oU9uG649vOaCGOJIYDajCvVznuM=;
 b=D5sAD9dnm9nFzVIUGhr7a3g3g25EVUVXMULJid2u042+XLLJnMI85F9ItOUmx5Ic1k
 WmHLc+SdeGbze+ksBuSeJ3wOaQ3TE5YjsnGQH/2vGRP0F7ZsCzg6UqNmeSMd5us6J30n
 ONXd6BbDm+67LeKmG7EA/u1eCOB5XjL8NIKnYANVvsPzOmtZrPyg2DbyeErMeryLow1o
 oQEUENqngsfaZ9o92Ae1wTTVWuDpfDM83DPR6ckEWv2jOXxCKxPKoyHRDh9YTcveUvN3
 H7pUC9SGTrpbWJo9wi/yXhtfWYL9HCkRQ+zO8D0AeaYjaxmyI/twTKZvPboyzqdGofbu
 KkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738808901; x=1739413701;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sgIsObDnT+YU7j+7oU9uG649vOaCGOJIYDajCvVznuM=;
 b=wk5mkdCGvDQQQpHpU88B/7WK2Eit7sWdOt9wTswmWA8qu5QGSMn+/EyC02gHYzL4Dt
 zyX0tocZIuW6Q1k1hNRw3Na/GexzakthFMQI+1qi+CuqCbSsYyuEWpC8RzsSlNM6qzrM
 ilI3FVcLTHK9E1Q2+UJ/+Klvu6qVh2AW5PZ5J+K3+zoOpmn1J2IVs5rvZTBgSXeDoaIA
 cYAw2EKvSueIOik9Nmk31tVXKlXKp4VrNn9rQf3QpZhR4xCBGrj2va4gOOGZz9JioPtV
 3TODGocXlQWwE9Jam2GS7Kvcqqps7alol+3zEchkvVCKzbzilQBL6EwnrviCTkBm9uww
 ig+w==
X-Gm-Message-State: AOJu0Yx/Z7nzNfnQRwmC0GvuiIzKZhQyRqVWxiH+c9apznV2PNSF+E38
 dn0vMbG1ngakH75/OevsDn7Zeq7gl55aIAZgiSV5+pptgVJXaAU3P6W0JGJz7g==
X-Gm-Gg: ASbGncserWmwoRlHD/PJU5rr6ofZaznrJxhksSfOOybfRwpQu0+9rT3snwO3Pl7hUXa
 khewyNjVwu0sU0dRe3hty4FuKgmF58LrHCU6va6eZFolB6o2WYUgYTk/GbNcVw6CUaXx5D+OSMI
 nkUxecl7EImUC4T2dpp9TvOGwrlY1Z3BhCCZANv68DplmgAc7eegLDhgzrdd+Gq4iP9QfIlkudh
 mAT0GShyDHqBtf6rYXnzYL67kDC2NddeCZ/slFH28AacTK+OCJka0R99zShDa0CT/D0/k+3O6g=
X-Google-Smtp-Source: AGHT+IHyiHeqg+ZT9e9ggVL7D08JcVjMgqFS+Pj3O2MgtjMUGKLrs0+D0+OUuRuVkCDp+Bk7tB4SfQ==
X-Received: by 2002:a05:600c:3502:b0:434:f5c0:3288 with SMTP id
 5b1f17b1804b1-4390d56cf32mr41677455e9.29.1738808901118; 
 Wed, 05 Feb 2025 18:28:21 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd00sm393474f8f.78.2025.02.05.18.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 18:28:20 -0800 (PST)
Date: Wed, 5 Feb 2025 21:28:14 -0500
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z6QePvsa+SiyiV9v@wegao>
References: <Z6LS8SfWeWnd5A3C@wegao>
 <CAASaF6zAqMoT6J1nAG2uwo1pyQnHAEFvcZPinv4w=5F0=TKnqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6zAqMoT6J1nAG2uwo1pyQnHAEFvcZPinv4w=5F0=TKnqQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap34 trigger oom if compile with
 CFLAGS='-fstack-clash-protection'
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

T24gV2VkLCBGZWIgMDUsIDIwMjUgYXQgMTE6MzM6MDhBTSArMDEwMCwgSmFuIFN0YW5jZWsgd3Jv
dGU6Cj4gT24gV2VkLCBGZWIgNSwgMjAyNSBhdCAzOjU04oCvQU0gV2VpIEdhbyA8d2VnYW9Ac3Vz
ZS5jb20+IHdyb3RlOgo+ID4KPiA+IEhpIEphbgo+ID4KPiA+IENvbXBpbGluZyBodWdlbW1hcDM0
IHdpdGggQ0ZMQUdTPSctZnN0YWNrLWNsYXNoLXByb3RlY3Rpb24nIGNhdXNlcyBnY2MgdG8gaW5z
ZXJ0IGFkZGl0aW9uYWwgc3RhY2sgYWRkcmVzcyB2YWxpZGF0aW9uIGNoZWNrcyBkdXJpbmcgYWxs
b2NhIGNhbGxzLiAgVGhpcyByZXN1bHRzIGluIGtlcm5lbCBzdGFydCBhbGxvY2F0ZSBtZW1vcnkg
cmVhbGx5ICwgZXZlbnR1YWxseSB0cmlnZ2VyaW5nIGFuIE9PTS4KPiA+Cj4gPiBJbiBvdXIgbm9y
bWFsIG9wZW5xYSBlbnYgd2UgZG8gbm90IGhhdmUgc3VjaCBiaWcgbWVtb3J5KDEwMjRHQikgdG8g
c3VwcG9ydCB0aGlzIHRlc3QuIFNvIHdlCj4gPiAgaGF2ZSB0byBkaXNhYmxlIENGTEFHUz0nLWZz
dGFjay1jbGFzaC1wcm90ZWN0aW9uJyBpZiB3ZSBzdGlsbCBuZWVkIHRoaXMgY2FzZSBydW5uaW5n
IGluIG91ciBlbnYuCj4gCj4gSGksCj4gCj4gSXQgc291bmRzIGxpa2UgeW91IGFscmVhZHkgZm91
bmQgdGhlIGNhdXNlLiBXZSBzZWVtIHRvIGhhdmUgY291cGxlIGNob2ljZXM6Cj4gCj4gMSkgc3Ry
aXAgdGhlIG9wdGlvbiBmcm9tIHRoZSBDRkxBR1MgZm9yIHRoaXMgdGVzdGNhc2UKPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9NYWtlZmlsZQo+IGIv
dGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9NYWtlZmlsZQo+IGluZGV4IDJk
NjUxYjRhYS4uMTE1NGFiM2RlIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1
Z2V0bGIvaHVnZW1tYXAvTWFrZWZpbGUKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
dGxiL2h1Z2VtbWFwL01ha2VmaWxlCj4gQEAgLTgsNCArOCw3IEBAIGluY2x1ZGUgJCh0b3Bfc3Jj
ZGlyKS9pbmNsdWRlL21rL3Rlc3RjYXNlcy5tawo+ICBpbmNsdWRlICQoYWJzX3NyY2RpcikvLi4v
TWFrZWZpbGUuaW5jCj4gIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNf
bGVhZl90YXJnZXQubWsKPiAKPiArQ0ZMQUdTX25vX3N0YWNrX3Byb3QgOj0gJChmaWx0ZXItb3V0
IC1mc3RhY2stY2xhc2gtcHJvdGVjdGlvbiwgJChDRkxBR1MpKQo+ICsKPiAraHVnZW1tYXAzNDog
Q0ZMQUdTPSQoQ0ZMQUdTX25vX3N0YWNrX3Byb3QpCj4gCj4gMikgaW5jcmVhc2UgdGhlIG1lbW9y
eSByZXF1aXJlbWVudHMgZm9yIHRoZSB0ZXN0Lgo+IAo+IEknZCBwcm9iYWJseSBnbyB3aXRoIDEp
IHNpbmNlIHdlIHdhbnQga2VybmVsIHRvIGNhdGNoIGFueSBpc3N1ZXMgYW55d2F5LiBBbmQgaXQK
PiBhbGxvd3MgdGVzdCB0byBydW4gb24gbGFyZ2VyIHBvb2wgb2Ygc3lzdGVtcy4KPiAKCkFncmVl
IGdvIHdpdGggMSksIGkgc2VuZCBuZXcgcGF0Y2ggCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyNTAyMDYwMjIzMjcuMTE4MjEtMS13ZWdhb0BzdXNlLmNv
bS8KClRoYW5rcyBmb3IgeW91ciBxdWljayBzdXBwb3J0LgoKPiA+Cj4gPiBUaGFua3MuCj4gPiBS
ZWdhcmRzCj4gPiBHYW8gV2VpCj4gPgo+IAoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
