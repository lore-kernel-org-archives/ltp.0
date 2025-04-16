Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787DFC369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744793754; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dINIW/cL2ZSF8gYfGF3WCkzhmzif/u0WHmIeINn+krs=;
 b=JvtnaztvIssSijLzq1/1ZIkXxI6q1D6C9MsEu8fQr4oTJaCcxTU3eM6LDwKeB/+cL+x2W
 nOX2uns4FOuKJGsEGg20RBcCilHBSpzxe1VsLCic34SnD3X0DpkdnqO25ViB59f6A0l0Xd8
 OR2dW2GNlvdPybI/L3A4555fVC5yYAI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E03CA3CB96D
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 10:55:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C58B3C2EFA
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:55:34 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2FEA91000963
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744793730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HZCjqluoM+snvsTkjsxEEyYAND6sN0iytA4CmIO5UrM=;
 b=RXwHuk4zzzSdyakHxkXFGxHTtZgFVU5L8zEory2prZj0uFuIAg+F13aU3WUpBkNw8qGme3
 x4Q4ovX7eTKaJIcVYuzH+1KavPBfoVsoBzWSrc7hrHi06ujv5B9u12b+hQvPL568WCrZrF
 OUJtmg98PkflqQwTZLOmR3bomtKM9C4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-kr7mbAW4PQKHhu11htjV1w-1; Wed, 16 Apr 2025 04:55:24 -0400
X-MC-Unique: kr7mbAW4PQKHhu11htjV1w-1
X-Mimecast-MFC-AGG-ID: kr7mbAW4PQKHhu11htjV1w_1744793723
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff7cf599beso6504482a91.0
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 01:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744793721; x=1745398521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HZCjqluoM+snvsTkjsxEEyYAND6sN0iytA4CmIO5UrM=;
 b=G6lUdnNBgm6x0BSeDpSi6yR62Tng3fE3Hh10MMMtHmxX0VGXfXEnfwUCj7mPfZCgfI
 EGu2W3niCyL3ho+GCoiJmgS5nZG2R9Oln5dS/CPqKVhd6mKq3qJDJSOD4S7+AI5YI3S8
 bnQEO8zxwLSklDU9Yz8/uZwRstXnU9cC4xo7kywg/Hhu4KugG24/Ki8DOopjULhh7aWI
 cPW2w+RQgncUQWnSmvH5Wl+aiTwEECHV4QJFo87qltEdWRtkGD4OHigTLesTlAKQVHS0
 IDLlxHZSxTElm6JS1uEEa4Ks1dgV/gbKnIHSBm9cXmw8ay3c1HM955sitaaa272EKbuZ
 Jntg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOP/eB1adLgjvbHU+cV0caWdtOJdzqw4iEbgH/QDzajl2VYX0ztqq7iPcJpFcMSH8MVow=@lists.linux.it
X-Gm-Message-State: AOJu0YxvT8kF/YDPh75rMc5zti1PYTBWod7sU+yIZStMRjE4BByilQq1
 15I+BjL2wKO9bk4VnyTMOwuE4JB2kk9z5SrKQ009DUDDhXpqrcq9mtnOpEoCX6luKH9+b1o8bkc
 VV6BeEKuLzsH8DLdJWRpZN6JbJVfv8TVY2JvXG6ot3PSj59PFSJOuJt3662LJtIk6HBz2SgLAKm
 +kCz3iNfYU3oNJbMelr9NVW1NsmMcFQ0FAIA==
X-Gm-Gg: ASbGncttqTNoUj6/RYIsJ+i6Vy/MAcRAgffX5zd5RG7jZeL1lYZQ72FfhyDF/VYuZgW
 iHDz34RzrClSjnuIxb9wxGjGQ8LR8wf20fT4bJvdvTeCMSgbXOM7BcdYss/dPz50fIYLJ7Q==
X-Received: by 2002:a17:90b:5690:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-30863d1eb18mr1452509a91.5.1744793721347; 
 Wed, 16 Apr 2025 01:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNR+cCm4aPHhrKfjGHs3qaJgLNCVSzMs8I8YLZG6uU1UPlGRt1Qamr1kmul0b9fgRdYNc6bqvsQFMPPcpEN+E=
X-Received: by 2002:a17:90b:5690:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-30863d1eb18mr1452494a91.5.1744793721109; Wed, 16 Apr 2025
 01:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
 <20250415-patchwork_ci-v7-2-bc0b9adca971@suse.com>
 <CAEemH2e3CX4-oW98HhPt7+CaiNf4OYE8k7EkvNnZCV7spuwQmA@mail.gmail.com>
 <3cfc1784-dbf1-4230-a1ff-3cce2336997f@suse.com>
 <20250416083800.GA577362@pevik>
In-Reply-To: <20250416083800.GA577362@pevik>
Date: Wed, 16 Apr 2025 16:55:09 +0800
X-Gm-Features: ATxdqUGeuRzJ6Mjt3aAhp5GGb07IwZjQevkD8l76vB1WAYmoOh2ff5wskiwJbBk
Message-ID: <CAEemH2eZF-tuYR=Pbp+2O5avg7o_wPtsjjbhOmQ96weQJoJgZQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -36AslGbYoCShvu1XvN9tZdnx-1ANK35AIYd0-jVyMk_1744793723
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 2/4] ci: add patchwork communication script
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

T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgNDozOOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIEFuZHJlYSwKPgo+ID4gSGkgTGksCj4KPiA+IE9uIDQvMTYv
MjUgMDk6MDQsIExpIFdhbmcgd3JvdGU6Cj4gPiA+IE1heWJlIGJldHRlciB0byBtb3ZlIHRoaXMg
aW5kZXBlbmRlbnQgdG9vbCB0byB0aGUgc2NyaXB0LyBkaXI/Cj4gPiA+IFRoaXMgY2kvdG9vbHMv
IGlzIHNvIGhpZGRlbiB0aGF0IGl0IGNhbiBlYXNpbHkgYmUgb3Zlcmxvb2tlZC4KPgo+ID4gV2Ug
dGhvdWdodCBhYm91dCBpdCwgYnV0IHNpbmNlIGl0J3MgbW9zdGx5IGEgcmVsYXRlZCBDSSBzY3Jp
cHQgd2UKPiBkZWNpZGVkIHRvCj4gPiBtb3ZlIGl0IGludG8gY2kvdG9vbHMuIFRoZSBzY3JpcHRz
LyBmb2xkZXIgc2VlbXMgdG8gYmUgbW9yZSByZWxhdGVkIHRvCj4gTFRQCj4gPiB0ZXN0cyBkZXZl
bG9wbWVudCwgc28gSSdtIGEgYml0IHB1enpsZWQgbm93IDotKQo+Cj4gPiBJIGxldCBQZXRyIFZv
cmVsIHRoZSBsYXN0IHdvcmQgYWJvdXQgaXQKPgo+IExpLCBGWUkgSSBhc2tlZCBBbmRyZWEgdG8g
a2VlcCBwYXRjaHdvcmsuc2ggc2NyaXB0IGluIGNpL3Rvb2xzLyBiZWNhdXNlCj4gaXQncwo+IHJl
bGF0ZWQgdG8gQ0kgYW5kIHByb2JhYmx5IG5vYm9keSB3aWxsIHVzZSBpdCBkaXJlY3RseS4gSSB3
b3VsZCBsaWtlIHRvCj4ga2VlcCBpbgo+IHNjcmlwdC8gb25seSB0aGUgc2NyaXB0cyB3aGljaCB3
aWxsIGJlIHVzZWQgYnkgcGVvcGxlLiAgSWYgeW91IHJlYWxseQo+IHRoaW5rIHRoYXQKPiBzb21l
Ym9keSB3aWxsIGJlIHVzaW5nIGl0LCB3ZSBjYW4gaGF2ZSBpdCBpbiBzY3JpcHQvLiBXRFlUPwoK
Cj4gKEFuZCB3aHkgaW4gY2kvdG9vbHMvIGFuZCBub3QgaW4gY2kvPyBJJ2QgbGlrZSB0byBrZWVw
IGNpLyouc2ggZm9yIExUUAo+IHVzZXJzCj4gYXMgYW4gZWFzeSB3YXkgdG8gaW5zdGFsbCB0aGUg
ZGVwZW5kZW5jaWVzLikKPgoKU3VyZSwgSSdtIE9LIHdpdGggcHV0dGluZyBpdCBpbiB0aGUgY2kv
dG9vbHMvLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
