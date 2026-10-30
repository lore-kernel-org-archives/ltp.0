Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17323606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZmbP5YVy
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A363E3EA330
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 18:31:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F101C3E5FCC
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 18:30:56 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 175A51401104
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 18:30:56 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c418e215671so126732566b.0
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 10:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793381455; cv=none;
 d=google.com; s=arc-20260327;
 b=Xr7816PnNYcjyOISpKDLuVBxw4es/nDBgLt8RoIzQkKBT/wBGtEocK8/JsxVzCNP9E
 NJ4jIE/m2Hoh+Raol/j0WQgT/o3BAS193QSkbSnkGG+p9QDalhowuJaZpQKGJ0dg2xtN
 UM9clD645hyqyytbdqlA0zb4gBE0efdp9jLnEISxKjwvVIknEHqU+gCeW66xoJhurHD6
 vZhP4R71BjZKXltn5JekniM3iCLQePSt4yf85xD35ctWiKWnF3jvkeiFOrJN9o3J3mSC
 K4iVuXqk/SZjq8zHhWF7qUfR8nZaSl0FNxXvknLFjX1JzeVGdckgJSyYG4sAx8ik31yq
 sUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wn/GtdSN1L2m7IIrEXwUsExs/7q/hUuMinHZ8AwcUkQ=;
 fh=Gd7ZdBHhn2t4PCwVb9Uk4s+9BMMs/py2VZt6GOIiTu4=;
 b=MctSrDqOvivzwp/1yPfthNOIMuY5udz6YTEIzEMkv61forpIZeRZwS+N/D4idyz/8i
 TIk25HAGlBGC1sr0iQKB9s/vge246/8uln7ue56GJrtLZdubGfv28M8cy8t/oQdJ9DS/
 txUiGEEEF+M1EbHwTkhvl925SF5EYifErMJxNWJcCIGLeb4a0NasyZu2lgEiMpxXXQGh
 RM8Qd1LbkQg/PS0g1xuNWlpmRfJP4V2brHgBTdr95aa9Y6h620t0aUJ2wYw4rEHoKj5y
 fmFhQkb10y5KpdV+LAvh38ALqz7ChMJrDpeX9wbWDzDQEUa8MsnjeD4mwU91dnc/F0xE
 HgeQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793381455; x=1793986255; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wn/GtdSN1L2m7IIrEXwUsExs/7q/hUuMinHZ8AwcUkQ=;
 b=ZmbP5YVyjQ+o2I9f5z8AOT+WiLpSUqMkK7xI5QbIaxroaaVKl77Lx7XjrLwlmLdtyO
 FPjQ7N7uorknLV1A3GER7OXOjvG2JyLHXB2dxhsAYmNq0jfKG97ouw2tEohWbulk7Tou
 il+bFsnR8PgqsJpEZNJ5pRsowjsSQet9zDNthszki7Cg3Zs9Rdvs3Qu2M3UUe9+jNV4o
 K6mIRAe+5L0qjRs+UC5VN5WwE3t3G8xjLC+y88/V7ju+P/oakBge74C4vae3Kzk1wD6j
 5njFbkbHX3CPS87ogE73+X7mcwi7O58yjkJnzPKlyAMn7CCjott4WdXKklpnUW9ZaPYv
 YF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793381455; x=1793986255;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wn/GtdSN1L2m7IIrEXwUsExs/7q/hUuMinHZ8AwcUkQ=;
 b=PXb2pZp0EbxRrJsBvz+SbialqAQEj48/Tjxs1f3nnGrBU+I+ckJahBYSy4OtsRNHxD
 59RuIjRF1GaO90NREyNu9LGdC8eOJf6cQQWlp2MSmiW3n41j2vsYwgWqiuIexFrj3QtP
 WHYVExT9LH5/Ms52j3dizMlbZjvVOTVI5TnGP+sB01qVwJEqO7RfPg69VMfotj95sTUC
 qFQpT4isnMRrIQwCr/gXxsLdo1MZy6MlzyZOh8T6qpcCtq19tE/71zgujE6tMmm/Z3Jz
 Vn0tmfmP59Qz3pJDBqwLD2WoqeBs8RylEMM3sHdmWX7pWoOoxXbBoknLP3GeocSPmp0w
 Ogow==
X-Forwarded-Encrypted: i=1;
 AKwUvByj0MDWkX1mmTJgr23gecGtscpMBTqncWSaRVWUTXZBhX6zN/35WOVswFO9A3N5DLjAR9Y=@lists.linux.it
X-Gm-Message-State: AFq9FYLFfDgQqMngKP+YuWUwXhkETpCvc437UuQkHq8Ldq26T3Xob39f
 bOTbb1ptCqYS1CvP9WYTtTzyhXjJ94AZc/7HiJHm28YvapycPqsFizGULHejV4+dXv7rzas9KXb
 uTjpmEwuwM/GduoRTL76chVpDuSDhcZI=
X-Gm-Gg: AYBFou3R/qmujtdkQrKW/fv4T6BAWGEXTJP2+Fx58EzNBkXmW4i6syevADNrbFwM74E
 GkWE2JW0/wLbEOitZUCnQ8RSIwUsjlskoSBATr1DS/wcf23chapnChAHcsSKaBuao49RGNJvygj
 OONSLmFmgS5zhhJVTENemVXzhWfBzd4U8zSjXQhxoxyqtbDJHeM/cbURYzwvq2Hn6y3MoGYWBvH
 v6yhz/jiHMvZdUJ2wmvFSJ+VyuoC2/asiN+3jt4nEY4Colu3FjzJglDRFMaYMpP9Y7fByk8C/7m
 lR48VdoP1CAXqSAziwWKmyqkXyiVc5trUhjD4f50mXzS8vq2xb+syaTZd/jJgtzlh4VjGvGGFQw
 TB/WUPYP7TSc1peEtsS4NuitwhYdOtrCq+WjpbdMARCVxdJAEuOiLA9+ocnu21K1wNm0Dcw==
X-Received: by 2002:a17:907:9410:b0:c34:1ed:54d9 with SMTP id
 a640c23a62f3a-c4ca795ef4amr303423766b.4.1793381455246; Fri, 30 Oct 2026
 10:30:55 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029210701.80050-1-dennylin0707@gmail.com>
 <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
 <20261030170603.GA31132@pevik>
In-Reply-To: <20261030170603.GA31132@pevik>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 18:30:42 +0100
X-Gm-Features: AclHuK_Hp4PUqOVNhv7EARHTCHlyz4-aNYuu1zXh6K09HqFHmjVBq4i8xeI-CkU
Message-ID: <CAOQ4uxjsf=6Do-uNEOS9R61M8jXcmExY1jnrLNY9ex=doNn3wA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] inotify13: check rename cookie pairing after
 adjacent moves
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: linux-fsdevel@vger.kernel.org, Hungyu Lin <dennylin0707@gmail.com>,
 jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBPY3QgMzAsIDIwMjYgYXQgNjowNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+ID4gT24gVGh1LCBPY3QgMjksIDIwMjYgYXQgMTA6MDfigK9QTSBIdW5n
eXUgTGluIDxkZW5ueWxpbjA3MDdAZ21haWwuY29tPiB3cm90ZToKPgo+ID4gPiBRdWV1ZSBhbiB1
bnBhaXJlZCBJTl9NT1ZFRF9GUk9NIGV2ZW50LCBmb2xsb3dlZCBieSBhbiBJTl9NT1ZFRF9GUk9N
IGFuZAo+ID4gPiBJTl9NT1ZFRF9UTyBwYWlyIHdpdGggdGhlIHNhbWUgc291cmNlIHdhdGNoIGRl
c2NyaXB0b3IgYW5kIG5hbWUgYXMgdGhlCj4gPiA+IGZpcnN0IGV2ZW50LiBXYXRjaCBvbmx5IElO
X01PVkUgc28gY3JlYXRpb24gb2YgdGhlIHJlcGxhY2VtZW50IGVudHJ5Cj4gPiA+IGRvZXMgbm90
IHNlcGFyYXRlIHRoZSB0d28gSU5fTU9WRURfRlJPTSBldmVudHMgaW4gdGhlIHF1ZXVlLgo+Cj4g
PiA+IEFmZmVjdGVkIGtlcm5lbHMgY29hbGVzY2UgdGhlIHNlY29uZCBJTl9NT1ZFRF9GUk9NIGlu
dG8gdGhlIGZpcnN0LAo+ID4gPiBsZWF2aW5nIHRoZSBJTl9NT1ZFRF9UTyBjb29raWUgd2l0aG91
dCBhIG1hdGNoaW5nIElOX01PVkVEX0ZST00gY29va2llLgo+ID4gPiBDaGVjayB0aGF0IGFsbCB0
aHJlZSBldmVudHMgYXJlIHJldGFpbmVkLCB0aGUgdHdvIG1vdmVzIGhhdmUgZGlzdGluY3QKPiA+
ID4gY29va2llcywgYW5kIHRoZSBzZWNvbmQgSU5fTU9WRURfRlJPTSBtYXRjaGVzIHRoZSBJTl9N
T1ZFRF9UTyBjb29raWUuCj4gPiA+IENvdmVyIGJvdGggcmVndWxhciBmaWxlcyBhbmQgZGlyZWN0
b3JpZXMuCj4KPiA+ID4gU3VnZ2VzdGVkLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21h
aWwuY29tPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIdW5neXUgTGluIDxkZW5ueWxpbjA3MDdAZ21h
aWwuY29tPgo+Cj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0aWVuY2Ugd2l0aCBteSByZXZpZXcK
Pgo+ID4gUmV2aWV3ZWQtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Cj4K
PiBUaGFuayB5b3UhCj4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+
Cj4KPiBJIGhhdmUgbm8gcHJvYmxlbSB0byBmaXggdmVyeSBtaW5vciBpc3N1ZXMgcmVwb3J0ZWQg
YnkgYWdlbnQgYmVmb3JlIG1lcmdlLAo+IGJ1dCB3aGF0IGJvdGhlcnMgbWUgdGhlcmUgaXMgbm8g
a2VybmVsIGZpeCBmb3IgdGhlIGZhaWx1cmUuICBJZiBJJ20gbm90Cj4gbWlzdGFrZW4sIHRoZSBm
aXggaW4ga2VybmVsIFsxXSB3YXMgcmV2aWV3ZWQgWzJdIGJ1dCBub3QgeWV0IG1lcmdlZCAoSSBs
b29rZWQgdG8KPiBuZXh0IHRyZWUgYXMgd2VsbCkuCj4gVGhlcmUgYXJlIG90aGVyIGZpeGVzIGZv
ciA2M2M4ODJhMDU0MTYgKCJpbm90aWZ5OiByZWltcGxlbWVudCBpbm90aWZ5IHVzaW5nCj4gZnNu
b3RpZnkiKSBpbiBzdGFibGUsIGUuZy4gZTQyMjc3N2ZkZDQ3NCAoImZzbm90aWZ5OiBGaXggc3Rh
bGUgb2JqZWN0IG1hc2sgYWZ0ZXIKPiBjb25jdXJyZW50IG1hcmsgdXBkYXRlcyIpLCBidXQgSSBo
YXZlbid0IGZvdW5kIHRoaXMgb25lLgo+Cj4gTWVyZ2luZyB0ZXN0IGhlbHBzIGtlcm5lbCBkZXZl
bG9wZXJzIHRvIHRlc3QgaWYgdGhlIHByb2JsZW0gd2FzIGZpeGVkIGJ1dCBicmVhawo+IGZvciBp
dCBmb3IgYW55Ym9keSB3aG8gdXNlcyBtYXN0ZXIgZm9yIHJlZ3VsYXIgdGVzdGluZyB3aXRob3V0
IGV2ZW4gZXhwbGFpbmluZwo+IGZpeCBpcyBXSVAuIEJ1dCBJIHN1cHBvc2UgaXQgd2lsbCBiZSBw
cm9jZXNzZWQgc29vbiBiZWNhdXNlIHN0YWJsZSB3YXMgaW4gQ2MsCj4gcmlnaHQ/Cj4KPiBXZSBo
YXZlIHJ1bnRlc3Qvc3RhZ2luZywgYnV0IHRoYXQncyBmb3IgbmV3IGZ1bmN0aW9uYWxpdHksIG5v
dCBmb3IgdGVzdHMgd2hpY2gKPiByZXByb2R1Y2UgcHJvYmxlbSB3aGljaCB3YXMgbm90IGZpeGVk
Lgo+Cj4gQEphbiBAQW1pciBpcyB0aGVyZSBhIGdpdCBrZXJuZWwgdHJlZSBmb3IgZmFub3RpZnkg
YW5kIGlub3RpZnk/IEkgZm91bmQgb25seQo+IFZGUy4gSWYgeWVzLCBwbGVhc2UgdXBkYXRlIE1B
SU5UQUlORVJTIGZpbGUuCj4KCkZTTk9USUZZOiBGSUxFU1lTVEVNIE5PVElGSUNBVElPTiBJTkZS
QVNUUlVDVFVSRQpNOiAgICAgIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+ClI6ICAgICAgQW1pciBH
b2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KTDogICAgICBsaW51eC1mc2RldmVsQHZnZXIu
a2VybmVsLm9yZwpTOiAgICAgIE1haW50YWluZWQKVDogICAgICBnaXQgZ2l0Oi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2phY2svbGludXgtZnMuZ2l0CmZzbm90aWZ5
CkY6ICAgICAgZnMvbm90aWZ5LwpGOiAgICAgIGluY2x1ZGUvbGludXgvZnNub3RpZnkqLmgKCldl
IGNvdWxkIHByb2JhYmx5IHJlbmFtZS9tb3ZlIHRoZSBmYW5vdGlmeS9pbm90aWZ5IGVudHJpZXMg
dG8gYXBwZWFyIGFzCnN1YiBlbnRyaWVzIG1pbWlja2luZyB0aGUgVkZTIGVudHJpZXM6CgpGSUxF
U1lTVEVNIE5PVElGSUNBVElPTiAoZnNub3RpZnkgaW5mcmFzdHJ1Y3R1cmUpCi4uLgpGSUxFU1lT
VEVNIE5PVElGSUNBVElPTiBbSU5PVElGWV0KLi4uCkZJTEVTWVNURU0gTk9USUZJQ0FUSU9OIFtG
QU5PVElGWV0KClRoYW5rcywKQW1pci4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
