Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BE5D5B161
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 07:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765870089; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xWtzLNZDodnz8JUJzZzVixegRwAvdnJf4eHXbSHbAQA=;
 b=HkwWeDURxRC5hUjvWnZMn36e1wkL7m2j2/b5lUB2/JLeCKIo0Nq40CfH9k7Ca4gFaWI9o
 f8iOcbxy+4JOOP1LyLW4puP6qD+UBtdBZXeXmMJQ9ncvyoW0Mhrl8sUW5DTAieyO7YGafeG
 V6+WtmJvntpE4bJc/rzacNyFGOIr8+A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E4993CF7A3
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 08:28:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B4293C9DEF
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 08:27:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A3DD7100065D
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 08:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765870058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zgeC3rsmMKh7Cpf2jGs17jAiUvUKgaX5dTzgGun7SKE=;
 b=dwBisx61TOmkyNI504mwO0O/QouuYJ/VIx6k2YjBe67czJ55v9WQ1fE2VzleZ4hvjmwaBh
 P4wYdFGLl/2zFwt26lcWS/ScEWoHxK6kofK05gaar/6acf3exT3752+g4fXwW3Rtjlqs5e
 KwbCCtqzGPK2+HDTifiUpAEe16HVtuo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-jBDHThYQPtqWXshjsMfyYw-1; Tue, 16 Dec 2025 02:27:37 -0500
X-MC-Unique: jBDHThYQPtqWXshjsMfyYw-1
X-Mimecast-MFC-AGG-ID: jBDHThYQPtqWXshjsMfyYw_1765870056
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c0c7e0a8ac1so7199001a12.0
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 23:27:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765870056; x=1766474856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgeC3rsmMKh7Cpf2jGs17jAiUvUKgaX5dTzgGun7SKE=;
 b=p1IYYBowKD8OEOMzLRLm8aGAYIvxbAhNZBjw9ROBet9/cfWTpaVdHiLBTgbviAMQEp
 ns+ttT8KtxiEmcml23hCLoQ4JiK52QGaIc4RKuFzs/RQmsexmsujOgo3SU6649ykBh3W
 E88v4BjV4k0a6gED+6hRLHEJ8Ikptl1uHb2EnxAKBXALuLKqOq0rJZXQYkqPkAUPxWPD
 bX3jmh2jafLy5GDN/Y/nyJk9RU4oNjW/HCi/p+EsxRXxny6SQIrlDyvMSzoXfvJ6jWVS
 sYQobT+I1/oDI3m6btXkBcLO3Mt3CWfY6QZPMKTvkTnjeVpLj8XI+5dWkBoCyUQiviRx
 vpJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+8IYe3dMtIsxVOm8Q9z78RkyqNumhfWDltob90gH3wnyyTgEeIJlACGqX+MyN9IwYB5w=@lists.linux.it
X-Gm-Message-State: AOJu0YygT40vnInst9oNlV8Gr8Z9TVdxfyDfzAP3ZNj8ZaXUFdKMQlxb
 mxmme1Fex6APBhbQdUVWzZjAc+li/d+WEorSaGkt/hSS5aH5DAnh5m6X+9fLlPkuxQxH2CobaOG
 5aygBf7/q55/EQgxwqQx1BAETkXNn2PcOGyQMrJnkpNgAHOBnJ2qwxpbW0TKe/anTRqSHAv3aEB
 jdfEGnc/zkCHkPHN7rLz1FABnNZ3w=
X-Gm-Gg: AY/fxX4gvAE0FbBTUbKqsBp22ttNgn5EtVZS1WZHsVFruzlYzfy4P6IdBB1sGjP5IyO
 a882kymLdj98dqdOsVT0GX9skQltZ1SuesHhxyEEVPczVIsUXzS1QBwAxbDnS+lvCEaYFEG8u9g
 q8/w0D6MwGLJAVYRA7XgyM5HCOYxkUQJGTBNhP15XM+qCZj9Ir0Hdl//XkPAC0eBW8bCA=
X-Received: by 2002:a05:7301:7009:b0:2ae:51fa:b7f0 with SMTP id
 5a478bee46e88-2ae51fabf47mr288110eec.22.1765870055819; 
 Mon, 15 Dec 2025 23:27:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzljNwZF0VI7MnYyar5lHEZstI/Q2UorGy5/y6IHxpyF5TF4bZTaec1AI0iB6ezOKj4xhEBaBfB2xHnsZ18ko=
X-Received: by 2002:a05:7301:7009:b0:2ae:51fa:b7f0 with SMTP id
 5a478bee46e88-2ae51fabf47mr288101eec.22.1765870055342; Mon, 15 Dec 2025
 23:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
 <20251215143048.GA267467@pevik>
In-Reply-To: <20251215143048.GA267467@pevik>
Date: Tue, 16 Dec 2025 15:27:22 +0800
X-Gm-Features: AQt7F2qgsv4KnGXVgXFFAr8EMln1DsL_N8KEE7RMdrCW_sSyCjDw0Cy4UOm5C9s
Message-ID: <CAEemH2cmuxr7jKBA32eXQHOwQLvq4tPMDsmcen_9C7di=eSpDQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S4J-OOlXgRWAVsdIvSS4ZOCdo0OlBmmAWLQTdToIFGs_1765870056
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBEZWMgMTUsIDIwMjUgYXQgMTA6MzHigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gQW5vdGhlciAqaW1wb3J0YW50KiBydWxlIGNvbmNlcm5zIGFydGlm
aWNpYWwgaW50ZWxsaWdlbmNlLiBJJ3ZlIG5vdGljZWQKPiA+IHNvbWUgYmVnaW5uZXJzIHN1Ym1p
dHRpbmcgTFRQIHBhdGNoZXMgZGlyZWN0bHkgZ2VuZXJhdGVkIGJ5IEFJIHRvb2xzLgo+ID4gVGhp
cyBwdXRzIGEgc2lnbmlmaWNhbnQgYnVyZGVuIG9uIHBhdGNoIHJldmlldywgYXMgQUkgY2FuIHNv
bWV0aW1lcwo+ID4gaW50cm9kdWNlIGEgd2VpcmQvdW5yZWxpYWJsZSBwZXJzcGVjdGl2ZSBpbnRv
IHRoZSBjb2RlLgo+Cj4gPiBCZSBjYXJlZnVsIHdoZW4gdXNpbmcgQUkgdG9vbHMKPiArMSBJIGxp
a2UgdGhpcyB0aXRsZS4KPgo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiBBSSB0b29s
cyBjYW4gYmUgdXNlZnVsIGZvciBleGVjdXRpbmcsIHN1bW1hcml6aW5nLCBvciBzdWdnZXN0aW5n
Cj4gYXBwcm9hY2hlcywKPiA+IGJ1dCB0aGV5IGNhbiBhbHNvIGJlIGNvbmZpZGVudGx5IHdyb25n
IGFuZCBnaXZlIGFuIGlsbHVzaW9uIG9mCj4gY29ycmVjdG5lc3MuCj4gPiBUcmVhdCBBSSBvdXRw
dXQgYXMgdW50cnVzdGVkOiB2ZXJpZnkgY2xhaW1zIGFnYWluc3QgdGhlIGNvZGUsCj4gZG9jdW1l
bnRhdGlvbiwKPiA+IGFuZCBhY3R1YWwgYmVoYXZpb3Igb24gYSByZXByb2R1Y2VyLgo+Cj4gPiBE
byBub3Qgc2VuZCBBSS1nZW5lcmF0ZWQgY2hhbmdlcyBhcyByYXcgcGF0Y2hlcy4gQUktZ2VuZXJh
dGVkIGRpZmZzIG9mdGVuCj4gPiBjb250YWluCj4gPiBpcnJlbGV2YW50IGNodXJuLCBpbmNvcnJl
Y3QgYXNzdW1wdGlvbnMsIGluY29uc2lzdGVudCBzdHlsZSwgb3Igc3VidGxlCj4gPiBidWdzLCB3
aGljaAo+ID4gY3JlYXRlcyBhZGRpdGlvbmFsIGJ1cmRlbiBmb3IgbWFpbnRhaW5lcnMgdG8gcmV2
aWV3IGFuZCBmaXguCj4KPiA+IEJlc3QgcHJhY3RpY2UgaXMgdG8gd3JpdGUgeW91ciBvd24gcGF0
Y2hlcyBhbmQgaGF2ZSB0aGVtIHJldmlld2VkIGJ5IEFJCj4gPiBiZWZvcmUKPiA+IHN1Ym1pdHRp
bmcgdGhlbSwgd2hpY2ggaGVscHMgYWRkIGJlbmVmaWNpYWwgaW1wcm92ZW1lbnRzIHRvIHlvdXIg
d29yay4KPgo+IEhvcGVmdWxseSB0aGUgbGFzdCBwYXJhZ3JhcGggd2lsbCBiZSB1bmRlcnN0YW5k
IGhvdyBpdCBpcyBtZWFudC4gQmVjYXVzZSB3ZQo+IHJlYWxseSBkb24ndCB3YW50IHRvIGVuY291
cmFnZSBwZW9wbGUgdG8gc2VuZCBzb21ldGhpbmcgZ2VuZXJhdGVkIGJ5IEFJCj4gdGhleQo+IGRv
bid0IHJlYWxseSB1bmRlcnN0YW5kIGF0IGFsbC4gSSdkIGNvbnNpZGVyIG5vdCBzdWdnZXN0aW5n
IGFueSBBSS4KPgo+IEkgcmVtZW1iZXIgYnJpZWZseSByZWFkaW5nIGtlcm5lbCBmb2xrcyBkaXNj
dXNzaW5nIHRoZWlyIHBvbGljeSBbMV06Cj4KPiA+IFdlIGNhbm5vdCBrZWVwIGNvbXBsYWluaW5n
IGFib3V0IG1haW50YWluZXIgb3ZlcmxvYWQgYW5kLCBhdCB0aGUgc2FtZQo+ID4gdGltZSwgZW5j
b3VyYWdlIHBlb3BsZSB0byBib21iYXJkIHVzIHdpdGggZXZlbiBtb3JlIG9mIHRoYXQgc3R1ZmYu
Cj4KPiBBbmQgYW5vdGhlciBvbmUgSSBjYW4ndCBmaW5kIGFueSBtb3JlIHRhbGtpbmcgdGhhdCBp
dCdzIGFib3V0IHRoZSB0cnVzdC4gSWYKPiBzb21lYm9keSBzZW5kcyB3cm9uZyBwYXRjaGVzIGdl
bmVyYXRlZCBieSBBSSBoZSByaXNrcyBwYXRjaGVzIHdpbGwgYmUKPiBzaW1wbHkKPiBpZ25vcmVk
Lgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+CgoKPiBbMV0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMWJkMDRjZTEtODdjMC00ZTIzLWIxNTUtODRmNzIzNWY2MDcyQHJlZGhhdC5j
b20vCgoKV2hhdCBhIGNvaW5jaWRlbmNlISBJIGp1c3Qgc3Bva2UgZmFjZS10by1mYWNlIHdpdGgg
RGF2aWQgSGlsZGVuYnJhbmQKYXQgTFBDIGxhc3QgRnJpZGF5LiBIZSBleHByZXNzZWQgY29uY2Vy
bnMgYWJvdXQgdGhlIGluY3JlYXNpbmcgYW1vdW50Cm9mIEFJLWdlbmVyYXRlZCBjb2RlIGJlaW5n
IHNlbnQgdG8gdGhlIExLTUwsIHBvaW50aW5nIG91dCB0aGF0IGl0IGRvZXMKaW5kZWVkIHBsYWNl
IGEgY29uc2lkZXJhYmxlIHJldmlldyBidXJkZW4gb24gbWFpbnRhaW5lcnMuIE1vcmVvdmVyLApo
ZSBoaW1zZWxmIHJhcmVseSB1c2VzIEFJLgoKRnVydGhlcm1vcmUsIHNvbWUgZXhwZXJ0cyBhdCBI
dWF3ZWkgdG9sZCBtZSB0aGF0IHRoZXkgb25seSBhbGxvdyBwYXRjaApzZW5kZXJzIHRvIHJldmll
dyBwYXRjaGVzIGJlZm9yZSBzZW5kaW5nIHRoZW0sIGJ1dCBkbyBub3QgcGVybWl0IHRoZQp1c2Ug
b2YgQUktZ2VuZXJhdGVkIGNvZGUuCgpBbmQsIG9mIGNvdXJzZSwgY2xlYXJseSBmbGFnZ2luZyBj
b250ZW50IGFzIEFJLWdlbmVyYXRlZCBjb2RlIGluIHRoZSBwYXRjaAptaWdodCBoZWxwLgoKCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
