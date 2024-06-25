Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B999C2BBCA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 20:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719346861; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9InRQ8Rd+UvwFRQHM81lMsIA60wlBlnaodHoDpNZ5Aw=;
 b=qKr7zMlVCEwx1OOjQ+kpRLD0IMEE37v5azCtOx29VGtoZKgddMUYRYBefQKbV/3E09h3h
 kywtgNv8tNU6d5rICpcX6JhBUUbboWGYEXBqA6RDvHnUZtO7MEx2GJBR4TT8vKmdjpte7Np
 YU+t1g4GlM/P9Sr6VjsakMGKV9KHVBY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEDEB3D10CA
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 22:21:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1F523C97AD
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 22:20:37 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E87C31A00CD9
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 22:20:36 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-422f7c7af49so5845e9.0
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719346836; x=1719951636; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=re7UKVz9NRR3DoAXdbcFEgKydTVLPhxKb3jZeJoQrXI=;
 b=TQWmFhAAUOOzMf2PEH3JY7UOSjF9TeCHMbSE52HOqO2gU6sZOFOS6L4jnHxmsKmwh1
 XTk6kf6PXd4a6XxCZChn/qiFhW8eM7mgzkHd22p5HqG7+/ua9v7+vT7dx6jx0iKMEnUY
 YF+ZcZu+67L5QQ7L2RMxHgN6B5p7w4/MKcLcev8OXG2yYSw7o3pJEfwOZxmLadV2UEMb
 4W3qIErHeOSTxTwRR+yqpWnvfHUKv8HVmks5DW6Ia1NufJMNYdu6Ox8P4+YAp4B8Zpir
 XKvR8P/ASDlAfhXYjW8NhV/CtYgZjxLopoQX0vxAgtQFw1Ev+BkKKMWMUTBc03NvDF4E
 IF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719346836; x=1719951636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=re7UKVz9NRR3DoAXdbcFEgKydTVLPhxKb3jZeJoQrXI=;
 b=SVtEZWhsslrdVXTaHCmA1sAdW6YVcvtYAuwgOrx/9TaTsE+S5OFcy3vmOA6F6injFJ
 WSyVDJmUSJr85Yjeu4qPSGQCu6TiIOGjK0OyCY82T/P8Fs8KPdrh7fsdQzXUz/quQ3yh
 zbDsJi9P/4i8TQlPgrvqqu+CDl9H+gEnx5JPM/XzJwxJh52qd+SjSVjSZrvfhyOOsoYt
 q79AJntqBL79Dlz+O9MUz9w7iO8B/8q8Lpmi8UDXHw42HjX3L3GFMmc5f47NzW/cY+S1
 05ALiQKyAaoCnyUZsnU+KhPu7L2sIFCcG6LIPWUK8zMm+O+qFjofJ8DoWSyRwcYxpbwc
 4z4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHgQ1tiQ2ImCTsTcSqZdEjs/Irntu+dapZS8KB7OEL/TkU8pHWEbbYKEw6lrqjpO9iRhi0TA9YCV8qzJLjymAYK1k=
X-Gm-Message-State: AOJu0YxaWUqywCe7UtwgtMPYx+Af4nzWXHInljB4gTZNVchSEzQvdXdK
 2KGoQjPmibDs0JhZi+Q/zVY9iFqr07k/qC4KEEP2o9/96GPJPG9EmTGpL8uOCDvXwMEq0pp4k2k
 HTOqnkKNqxIWj1OXTZkpiXTJvM0i6qiSFrq0=
X-Google-Smtp-Source: AGHT+IF9JteV1YVi0lkVqRKbfMN3ETPiKhiR2GXSDCf3813+tJLCCPnemGDDn3vJr6k4+VXEHGlnGuxvEV+RCtyLpgE=
X-Received: by 2002:a05:600c:1d93:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-424ad7ffe28mr470875e9.4.1719346836226; Tue, 25 Jun 2024
 13:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
 <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
 <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
In-Reply-To: <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
Date: Tue, 25 Jun 2024 13:20:23 -0700
Message-ID: <CANDhNCr4-cE7_Uy86Pa3kjzFG_EOOB38C_mSGSfZtc=vd7L5yQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: Darren Hart <darren@os.amperecomputing.com>, kernel-team@android.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMjQsIDIwMjQgYXQgODoxNeKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiBPbiBUdWUsIEp1biAyNSwgMjAyNCBhdCA4OjA14oCvQU0gSm9obiBTdHVs
dHogdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPj4gSGV5IEN5cmlsIQo+Pgo+
PiBJIHdlbnQgdG8gdGFrZSBhIHN0YWIgYXQgdGhpcywgYnV0IHRoZSBtYXN0ZXIgYnJhbmNoIG9u
Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwLmdpdCBkb2Vzbid0
IHNlZW0gdG8gYnVpbGQ6Cj4+ICAgJCAuL2NvbmZpZ3VyZSAtLXdpdGgtcmVhbHRpbWUtdGVzdHN1
aXRlCj4+ICAgJCBtYWtlIC1qID4gL2Rldi9udWxsCj4+IG1ha2VbM106ICoqKiBObyBydWxlIHRv
IG1ha2UgdGFyZ2V0ICdNYWtlZmlsZS5hbScsIG5lZWRlZCBieQo+PiAnTWFrZWZpbGUuaW4nLiAg
U3RvcC4KPj4gbWFrZVsyXTogKioqIFsuLi8uLi9pbmNsdWRlL21rL2dlbmVyaWNfdHJ1bmtfdGFy
Z2V0LmluYzoxMDg6IGFsbF0gRXJyb3IgMgo+PiBtYWtlWzFdOiAqKiogWy4uL2luY2x1ZGUvbWsv
Z2VuZXJpY190cnVua190YXJnZXQuaW5jOjEwODogYWxsXSBFcnJvciAyCj4+IG1ha2U6ICoqKiBb
TWFrZWZpbGU6ODU6IHRlc3RjYXNlcy1hbGxdIEVycm9yIDIKPj4KPj4gQmlzZWN0aW5nIHBvaW50
cyB0byBjb21taXQgYTA1Mjk4ZWM0NDk0ICgidGVzdGNhc2VzOiByZWFsdGltZTogR2V0IHJpZAo+
PiBvZiBhdXRvdG9vbHMiKQo+Pgo+PiBJJ20gdW5mb3J0dW5hdGVseSBub3Qgc2F2dnkgZW5vdWdo
IHdpdGggYnVpbGQgc3lzdGVtcyB0byBoYXZlIG11Y2ggb2YKPj4gYW4gaWRlYSBvZiB3aGF0IGlz
IG5lZWRlZCBoZXJlLgo+Pgo+PiBBbnkgc3VnZ2VzdGlvbnM/Cj4KPgo+IExvb2tzIGxpa2UgeW91
IHdlcmUgdHJ5aW5nIHRvIGNvbmZpZ3VyZSByZWFsdGltZS10ZXN0c3VpdGUgaW4gTFRQIGJ1aWxk
LgoKWWVzLCBhcyBwcmV2aW91c2x5IHRoYXQgc2VlbWVkIHRvIGJlIHJlcXVpcmVkLgoKCj4gVHJ5
IHRoaXM6Cj4KPiAjIGNkIGx0cCBkaXIvCj4gIyBtYWtlIGF1dG90b29scwo+ICMgIC4vY29uZmln
dXJlCj4gIyAgbWFrZSAtQyB0ZXN0Y2FzZXMvcmVhbHRpbWUvCgpUaGFuayB5b3UhIFRoYXQgZG9l
cyBpbmRlZWQgd29yay4KCj4gU2VlOiBodHRwczovL2xpbnV4LXRlc3QtcHJvamVjdC5yZWFkdGhl
ZG9jcy5pby9lbi9sYXRlc3QvdXNlcnMvcXVpY2tfc3RhcnQuaHRtbAoKU2hvdWxkIHRoZSBvbGQg
LS13aXRoLXJlYWx0aW1lLXRlc3RzdWl0ZSBvcHRpb24gYmUgcmVtb3ZlZCB0aGVuPwoKdGhhbmtz
IGFnYWluIQotam9obgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
