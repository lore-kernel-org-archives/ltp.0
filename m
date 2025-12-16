Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8287FD5CCB7
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 10:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765881763; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lVVzOyZ3jlLSfFknyZcDGmpTY4qWzifKlGVpkPe2ilM=;
 b=f1wsauw3BTpVxJL83KUH3zWzchBKM4/McczoqbbJTlxQd7c+tGg+66u/uXRN48XYiaSVt
 /CXhhfh+OFkm9Fm39AIJvnf6RneynnUNFgQYXWRzzy1C1v2K0YEt+JtMHaIWi6ZyHpV38BJ
 xSt2AQryTTunXpK3nfKmKOwMQVS/r1k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 149933D0346
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:42:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 905253C01E9
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 11:42:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 87CEC64787C
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 11:42:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765881737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ZapbzppVOwYodN9Vx7ucqDqp8e2ykIMY6S+NNKvpaY=;
 b=LL/3HguswUVdniQOB5vosQx92Ufj/TWVzAG/PRSL5IKmAZJG0w5a0Kx9f/ZOgkww3QbQrQ
 HOz8kQNAGwiZuWF4fgAI5XFHHaIGx6BYCELfmKFkjXZuUW6da5g0SGVjjCVEZ1/amIuyiG
 JXAAD6Ko9Qv2ezpmzxX4P3zMi+NIHeQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-zd_Lm_YyOJyusulSMwjM5w-1; Tue, 16 Dec 2025 05:42:15 -0500
X-MC-Unique: zd_Lm_YyOJyusulSMwjM5w-1
X-Mimecast-MFC-AGG-ID: zd_Lm_YyOJyusulSMwjM5w_1765881735
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-bf493d248baso7805397a12.2
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 02:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765881735; x=1766486535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ZapbzppVOwYodN9Vx7ucqDqp8e2ykIMY6S+NNKvpaY=;
 b=gBWEfjCKD+sEFzVbw2stc0R/wy5/FAAaDQmrOGFE2JBBuCPkzEGy3EFnDviPGGSnQR
 vQj6UMT1YUkqFBn1Q6rYzrfOL9Sa3UQIwcS/DrZJ0pNdnZEoCGDBcjPG6CD5zX1HtLA5
 EVAdVKFNcqDniRf7B6uV89Cc8WbC320BabH3ZU5WACiFzn7m2JFVFZZbTAHZv2tY9hHj
 f7aTevEv/he0RzgYKnTDMiIzEGFHUlGgUsgwlGZGdkhHOy1Ocw4Ecs7gmxGmzYHy0gwb
 hEuyr2FWrGkhTGwP8QfUAuacfFBtqqw8DXMG/3bHnrFCN27F6GnSdemp085EBxeMXx2U
 yvzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZAO8Eo/TfskjVPOUjBrJ+ABWbVmU0iY5fQzRnHamI3/EGtozrXqDmw5Qh3czptXJEpVI=@lists.linux.it
X-Gm-Message-State: AOJu0YxIs3HK9AOAY3h6mr9BKm/iD/zdqbqwrIQki6OqNGZFYbMgXFL+
 QXKLeQQFzkipSc1Rmgb7tjMbkIgenaw4UgTVv1fpyA0YrcQTNvEYB42KvWzt2jPvSaio6x8obJV
 RMikjzFpmQ4QYgcFlmU3V6imbAG/J1B8uPhmb7NZYRPFWYgKunqgQpXzOWh3E+QR712oWWLc5rv
 jR5WqIv0iMyHEpRAvemzc6Itkmj3g=
X-Gm-Gg: AY/fxX6iWdqQu46dR3sDN874vl4C9UH8pqNxN1imCT3/xhiQTxmqNuU8BJcTFf44mY+
 V3WFt60MALNBnI10oziXU9zUOVB5r/OXTtTs4UYLQEfl8QHqr2Z8H2jlTrMl/jEJGwG8HM8H4tB
 /N3A3IoPK8PZ5Igi2XzWXdQIHDpeMlINxlWpjnZVX6YdQXorWCPZyUc07gHYMT5obeOxg=
X-Received: by 2002:a05:693c:6213:b0:2a4:3594:d551 with SMTP id
 5a478bee46e88-2ac3012ba9cmr9177063eec.30.1765881734705; 
 Tue, 16 Dec 2025 02:42:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYT1n0heMsHRrJpRW1wC7aE/YHT4X00fMyV2O1Wwu1OfWbfYexnJRu4M1E4KjZY8Pp+ct0JK+49gLHoUN1CMA=
X-Received: by 2002:a05:693c:6213:b0:2a4:3594:d551 with SMTP id
 5a478bee46e88-2ac3012ba9cmr9177046eec.30.1765881734205; Tue, 16 Dec 2025
 02:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
 <20251215143048.GA267467@pevik>
 <CAEemH2cmuxr7jKBA32eXQHOwQLvq4tPMDsmcen_9C7di=eSpDQ@mail.gmail.com>
 <20251216101117.GA295306@pevik>
In-Reply-To: <20251216101117.GA295306@pevik>
Date: Tue, 16 Dec 2025 18:42:02 +0800
X-Gm-Features: AQt7F2pB82YAJ6t5zCoW6kyCZxCj39LS6tR6ALCDfkc3gu_50PF2zWP9PBXk-nY
Message-ID: <CAEemH2dyDmwz=bCMAUCgma5P7dYbfeD16Cey-anLrVxyFRmg4w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fnWwAjEI3_D13nMfDxHLVyNlcoDMr1zR3ItplJtmXqs_1765881735
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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

T24gVHVlLCBEZWMgMTYsIDIwMjUgYXQgNjoxMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gLi4uCj4gPiA+IFsxXQo+ID4gPgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8xYmQwNGNlMS04N2MwLTRlMjMtYjE1NS04NGY3MjM1ZjYwNzJAcmVkaGF0LmNvbS8K
Pgo+Cj4gPiBXaGF0IGEgY29pbmNpZGVuY2UhIEkganVzdCBzcG9rZSBmYWNlLXRvLWZhY2Ugd2l0
aCBEYXZpZCBIaWxkZW5icmFuZAo+ID4gYXQgTFBDIGxhc3QgRnJpZGF5LiBIZSBleHByZXNzZWQg
Y29uY2VybnMgYWJvdXQgdGhlIGluY3JlYXNpbmcgYW1vdW50Cj4gPiBvZiBBSS1nZW5lcmF0ZWQg
Y29kZSBiZWluZyBzZW50IHRvIHRoZSBMS01MLCBwb2ludGluZyBvdXQgdGhhdCBpdCBkb2VzCj4g
PiBpbmRlZWQgcGxhY2UgYSBjb25zaWRlcmFibGUgcmV2aWV3IGJ1cmRlbiBvbiBtYWludGFpbmVy
cy4gTW9yZW92ZXIsCj4gPiBoZSBoaW1zZWxmIHJhcmVseSB1c2VzIEFJLgo+Cj4gTmljZSA6KS4K
Pgo+ICJEb1Mga2VybmVsIG1haW50YWluZXJzIHdpdGggQUkgc2xvcCIgaXMgYSByZWFsIGRhbmdl
ci4KPgo+ID4gRnVydGhlcm1vcmUsIHNvbWUgZXhwZXJ0cyBhdCBIdWF3ZWkgdG9sZCBtZSB0aGF0
IHRoZXkgb25seSBhbGxvdyBwYXRjaAo+ID4gc2VuZGVycyB0byByZXZpZXcgcGF0Y2hlcyBiZWZv
cmUgc2VuZGluZyB0aGVtLCBidXQgZG8gbm90IHBlcm1pdCB0aGUKPiA+IHVzZSBvZiBBSS1nZW5l
cmF0ZWQgY29kZS4KPgo+ICsxLiBJcyB0aGF0IGR1ZSAiQUkgc2xvcCIgb3IgbGVnYWwgaXNzdWVz
Pwo+CgpEdWUgIkFJIHNsb3AiLCBjdXogbW9zdGx5IG5vd2FkYXlzIEFJIGlzIHVuYWJsZSB0byBw
ZXJmZWN0bHkgZ2VuZXJhdGUKc3VpdGFibGUKY29kZSBmb3IgY29tcGxleCBwcm9qZWN0cyBzdWNo
IGFzIGtlcm5lbHMuIFRoZXkgb25seSB1c2VkIGl0IGluIHRoZSBmaXJzdApyb3VuZApvZiBwYXRj
aCByZXZpZXcuCgoKPiBXaGlsZSBJIGFsc28gc2hhcmUgdGhlIGZlYXIgb2YgIkFJIHNsb3AiLCBJ
IHdhcyBzdXJwcmlzZWQgdGhhdCBRRU1VIHJlYWxseQo+IHN0cmljdGx5IGJhbnMgQUkgZ2VuZXJh
dGVkIGNvZGUgZHVlIGxlZ2FsIGlzc3Vlcy4gSSB3b25kZXIgaWYga2VybmVsIGVuZHVwCj4gdGhl
Cj4gc2FtZSBhcyB3ZWxsLgo+Cj4KPiBodHRwczovL3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9k
ZXZlbC9jb2RlLXByb3ZlbmFuY2UuaHRtbCN1c2Utb2YtYWktZ2VuZXJhdGVkLWNvbnRlbnQKPgo+
ID4gQW5kLCBvZiBjb3Vyc2UsIGNsZWFybHkgZmxhZ2dpbmcgY29udGVudCBhcyBBSS1nZW5lcmF0
ZWQgY29kZSBpbiB0aGUKPiBwYXRjaAo+ID4gbWlnaHQgaGVscC4KPgo+ICsxLgo+Cj4gSU1ITyB1
c2luZyBBSSBmb3IgaGVscCB3aXRoIG1hbnVhbCB3b3JrLCBlLmcuIGNvbnZlcnRpbmcgZG9jcyBm
cm9tIGFzY2lpZG9jCj4KClllcy4KCnRvIFJTVCBmb3JtYXQgaXMgb2suIEZvciBtZSB0aGUgcXVl
c3Rpb24gaXMgd2hldGhlciBpdCBjYW4gYmUgdXNlZCBmb3IKPiBnZW5lcmF0aW5nIGEgdGVzdCBj
b2RlIChuZXcgdGVzdHMgZnJvbSBzY3JhdGNoLCByZXdyaXRlIGludG8gaW50byBuZXcgQVBJCj4g
d2hpY2gKPiBpcyBvZnRlbiBjbGVhcmVyIHdyaXRlIGZyb20gc2NyYXRjaCkuCj4KCkkgZG9uJ3Qg
dGhpbmsgQUkgY2FuIHdyaXRlIGJldHRlciBjb2RlIHRoYW4gbWFua2luZCBmb3IgdGhlIHdob2xl
IHRlc3QsCml0IG1pZ2h0IG9mZmVyIHN1Z2dlc3Rpb25zIGZvciBhIHBpZWNlIG9mIGZ1bmN0aW9u
LgoKSnVzdCBsaWtlIFlpbmcgSHVhbmcgKEZyb20gQWxpYmFiYSkgc3Bva2UgdG8gbWU6CiJJIGZv
dW5kIHRoYXQgQUkgcGVyZm9ybXMgYmV0dGVyIG9ubHkgd2hlbiBJIGJyZWFrIHRoZSB3b3JrIGRv
d24gaW50bwphdG9taWMgdW5pdHMuIgoKVGhlcmVmb3JlLCBpdCdzIGVzcGVjaWFsbHkgaW1wb3J0
YW50IHRvIHJlbHkgb24gZW5naW5lZXJzJyBleHBlcmllbmNlIHRvCmNsZWFybHkgdW5kZXJzdGFu
ZCB3aGF0IHByb2JsZW1zIGFyZSBoaW5kZXJpbmcgdGhlbSBhbmQgaG93IHRvCmNvbW11bmljYXRl
IHdpdGggQUkuCgoKCj4KPiBBbnl3YXksIGJlY2F1c2Ugd2UgYWxyZWFkeSBoYWQgc29tZSBBSSBn
ZW5lcmF0ZWQgcGF0Y2hlcyBpdCdkIGJlIGdvb2QgdG8KPiBoYXZlIGFuCj4gQUkgcG9saWN5LiAg
QnV0IEkgd291bGQgbGlrZSBub3QgdG8gYmxvY2sgdGhpcyBwYXRjaHNldCBpdCAoaXQnZCBiZSBu
aWNlCj4gdG8gZ2V0Cj4gdGhlIHBhdGNoc2V0IG1lcmdlZCBiZWZvcmUgQ2hyaXN0bWFzIGFuZCBz
b2x2ZSBBSSBwb2xpY3kgYWZ0ZXJ3YXJkcykuCj4KCisxCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
