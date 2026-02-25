Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E93EFD214
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 09:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772011451; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=UdiL8ak7AA/Rv/Tzs8tgp5OBX8ADVHfARwVjo8j9zGY=;
 b=QCx5Fm9JMD+UZGOmOHKu0uhnxLnMJdG7wOGZzecQ4WFMIFPm523YApqwHfNz7RO55wa7i
 9sk5NG17aSLr+Y3Y3GbVEeLjogBZeVCwb13FSTV1rh9RasgCpM2fDojwfZV10QuMeuyEEQL
 Z1Z6/Ew8LsafkSjLCGgEVFUZ2DkpBp8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8ABAD3C7652
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 10:24:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 087EC3C198F
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 10:23:48 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C41D1400DA3
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 10:23:48 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43990aa7dbaso283675f8f.1
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 01:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772011428; x=1772616228; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yovZJg7aWzn8Va673kz6Ko4rrNKqa8iWqSW+YZKt0DU=;
 b=DltUMedmnv5FhNcMNn8Mhh1J9cWsQvaZmZrApqjApIYVbEzmbIYCmeKFdyBPQlIlKK
 wFn/NIAM/dt+9BCTwWdm20OVBWl4DLrbwd6LXjD8UF6S+jOEM6dAPGMD4lEm0ktA66w6
 m2R1fBqR3zAiPlXeGysd7jNDJiwUXJ6iEepm+RIL9DdvB2EkPauETf/uxdR9nJj+u8cY
 Tl3WPd+byFmC0K622gxqvTOpNBYEj6am8+Vw4FETIV6DpNivniJN9nPSsJNHmN3S/Nbl
 v/gqNin9QIEcw1+2nKAnG+pf6TpbBALydo1Q51Q20Xs8ZC6Yz7chdRSGQdqicpg+iNiO
 W05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772011428; x=1772616228;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yovZJg7aWzn8Va673kz6Ko4rrNKqa8iWqSW+YZKt0DU=;
 b=ASUv7CvTWsdv7quoAg3L8tFwuRtI2GQXxnxpa9c+F8TBPFDUzvusK+HvcqCyp45ulK
 6sKfi/2nnMAWSkGJ6v6epuEn+fHMxmMxpJQAR/W7NkwIfosX9LOIH/FiupYBf+7HkaUI
 Fga+HeThXabvuCKL8kKRbHN/dlii0ABHYWwd/GYq0Z2ZPB9bTQ5qNUuD2hv1nPMl64/h
 BCQ6NhoL0kMJITg3zHoEcjALWqtGKCKzMKngAoC2infgx4P+dYT405/0itkqd4bbP4eG
 q4m1+9kQHMD8bkZoqWn7raVNmIeyZOQXbl25Flu3VioDpg8/+mpLBgiJNFMwCStfgKD9
 kiTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6pf+3nOZwl3YD/22Kk8230k/e9FN3d65JkSFf6/NYNYJtfgBCEQWkGPMgHhOwJ4NLh1k=@lists.linux.it
X-Gm-Message-State: AOJu0Yyc12xlcMMcLasO/2N217Cc7DrVCFcsU3tzh3lzAcXWE7U81dib
 d61261O4sVsGYMyUDn85ck9DfPVZ6sXRn/z1dewX3jlkiKBfsVZIkVwrs8QLdYyeXX3Mw1NoMYN
 sksgnpWc=
X-Gm-Gg: ATEYQzwVx5+4IeDVrxTpBRRQPT72mxJ/UdhKsfDzQStmEsEC8sb6HU8QBKqEF/XF3C5
 BAOOOQgZm3eo7ZOK1nZcHBELXUAiQSw8LJK82nVyStssTiV5LCQPGl8TxoilqzKs/rnC3GSIY8A
 mjwJ8FrwIAoicdfHiqIH9uZOkP0EEbKBv9b+iHY/pH6CyOsGh1qYzJGnbADvgx+gh6z+ZnJueCt
 0npq/IdnLwITA2XFHImuceglSTNAUAok9SAc7+43Z8aP0v5U4cNHOd0rlUFiywO9yaFTl68cIds
 mCVGZ1ZqBHRBHZL8jFmVbSex4ZZQgcIvrDcLLr2iToVALfrZKCxezacyGZltwVxnqfjQ9ncPUhF
 gQuGKgUnoalUZX+RZ4mWC1aeWfJIXd/hWf+4Q3HvKVX4k284KoqU4lntqO2DrgjST6/i1eY+d89
 3T1hkWgmTlG0xyLdLrUGgqTEi8BEr4QmtCbHvt9b9tvdgFteWbs2MIDj0YLOIhsp2t44rNKU0GM
 COqSxiWn9I5hxHInCI=
X-Received: by 2002:a5d:5888:0:b0:430:ff0c:35f9 with SMTP id
 ffacd0b85a97d-4398fb229bfmr2866614f8f.48.1772011427580; 
 Wed, 25 Feb 2026 01:23:47 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9f77sm32997878f8f.5.2026.02.25.01.23.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 01:23:47 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 25 Feb 2026 10:23:46 +0100
Message-Id: <DGNXMJ74NVTB.2DY53W36K3GET@suse.com>
To: "John Stultz" <jstultz@google.com>, "Jan Polensky" <japo@linux.ibm.com>
X-Mailer: aerc 0.18.2
References: <20260224104544.101292-1-japo@linux.ibm.com>
 <CANDhNCrrZY=5bvRQGGJsigjwRNmDz8shbtM-Vtn5UkdRDGU_uA@mail.gmail.com>
In-Reply-To: <CANDhNCrrZY=5bvRQGGJsigjwRNmDz8shbtM-Vtn5UkdRDGU_uA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] sched_football: harden kickoff
 synchronization on high-CPU systems
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>,
 Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIEZlYiAyNCwgMjAyNiBhdCAxMDowMyBQTSBDRVQsIEpvaG4gU3R1bHR6IHZpYSBsdHAg
d3JvdGU6Cj4gT24gVHVlLCBGZWIgMjQsIDIwMjYgYXQgMjo0NeKAr0FNIEphbiBQb2xlbnNreSA8
amFwb0BsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+Cj4gPiBUaGUgc2NoZWRfZm9vdGJhbGwgdGVz
dCBoYXMgYmVlbiBpbnRlcm1pdHRlbnRseSBmYWlsaW5nLCBtb3N0IG5vdGljZWFibHkKPiA+IG9u
IHN5c3RlbXMgd2l0aCBtYW55IENQVXMgYW5kL29yIHVuZGVyIGxvYWQsIGR1ZSB0byBhIHN0YXJ0
dXAgb3JkZXJpbmcKPiA+IGhvbGUgYXJvdW5kIGtpY2tvZmYuCj4gPgo+Cj4gSSd2ZSBub3QgaGFk
IHRpbWUgdG8gY2xvc2VseSByZXZpZXcgeW91ciBzdWdnZXN0aW9uIGhlcmUsIGJ1dCBpdAo+IHNv
dW5kcyByZWFzb25hYmxlLgo+Cj4gVGhhdCBzYWlkLCBJIHdhbnQgdG8gd2FybiB5b3UgYW5kIGVu
c3VyZSB5b3UgYXJlIGF3YXJlOiB0aGUKPiBSVF9QVVNIX0lQSSBmZWF0dXJlIGluIHRoZSBzY2hl
ZHVsZXIgYnJlYWtzIHRoZSBSVCBpbnZhcmlhbnQKPiBzY2hlZF9mb290YmFsbCBpcyB0ZXN0aW5n
Lgo+Cj4gSSBzZWUgdGhpcyBhcyBhIGJ1ZyB3aXRoIHRoYXQgZmVhdHVyZSwgYnV0IHRoZSBzY2Fs
YWJpbGl0eSBSVF9QVVNIX0lQSQo+IGFsbG93cyBmb3Igc2VlbXMgbW9yZSBpbXBvcnRhbnQgdG8g
Zm9sa3Mgd2hvIGFyZSBkb2luZyBSVCB3b3JrIHRoZW4KPiB0aGUgbWlzLWJlaGF2aW9yLiAgU3Rl
dmVuIGFuZCBJIHRhbGtlZCBhd2hpbGUgYmFjayBhYm91dCBzb21lIGlkZWFzIG9uCj4gaG93IHdl
IG1pZ2h0IGJlIGFibGUgdG8gZG8gdGhlIHB1bGwgaW4gYSBtb3JlIGVmZmljaWVudCB3YXkgd2hp
bGUKPiBzdGlsbCBob2xkaW5nIHRoZSBpbnZhcmlhbnQgdHJ1ZSwgYW5kIEkgaGF2ZSBhIGJ1ZyB0
byB0cmFjayBpdCwgYnV0Cj4gaXRzIG5vdCBiZWVuIGhpZ2ggZW5vdWdoIHByaW9yaXR5IHRvIGdl
dCBiYW5kd2lkdGggeWV0Lgo+Cj4gU28geW91IG1pZ2h0IHdhbnQgdG8gbWFrZSBzdXJlIHlvdSBk
aXNhYmxlIHRoYXQgZmVhdHVyZSBiZWZvcmUgdGVzdGluZyB2aWE6Cj4gIyBlY2hvIE5PX1JUX1BV
U0hfSVBJID4gL3N5cy9rZXJuZWwvZGVidWcvc2NoZWQvZmVhdHVyZXMKPgo+IHRoYW5rcwo+IC1q
b2huCgpUaGFua3MgZm9yIHlvdXIgZGVlcCBhbmFseXNpcyBvbiB0aGUgcG9zc2libGUgaXNzdWUu
IEknbSBub3QgYW4gUlQgZXhwZXJ0LApidXQgSSB0cnVzdCB5b3VyIGV4cGVydGlzZSBpbiBoZXJl
IDotKSBXaWxsIGxlYXZlIHRoaXMgcGF0Y2ggcmV2aWV3IHRvCnNvbWVvbmUgd2hvJ3MgbW9yZSBz
a2lsbGVkIHRoYW4gbWUgaW4gdGhpcyB0b3BpYy4KCkkgaGF2ZSBhIHN1Z2dlc3Rpb24gdGhvLgoK
QWJvdXQgdGhlIE5PX1JUX1BVU0hfSVBJLCB3ZSBhcmUgbHVja3k6IExUUCBwcm92aWRlcyBhIHNh
ZmUgbWVjaGFuaXNtIHRvCnNldCB0aGUgc3lzIGNvbmZpZ3VyYXRpb25zIGFuZCB0byByZXN0b3Jl
IGl0IHRvIGRlZmF1bHQgdmFsdWUgYWZ0ZXIKdGVzdC4gWW91IGNhbiBmaW5kIHRoaXMgaW4gdGhl
IGBzdHJ1Y3QgdHN0X3Rlc3RgIGFuZCBpdCdzIGNhbGxlZApgLnNhdmVfcmVzdG9yZWAgWzFdCgpJ
IHRoaW5rIGl0J3Mgd29ydGggdG8gZm9yY2UgdGhpcyBvcHRpb24gYWNjb3JkaW5nIHRvIHRoZSB1
bmRlcmx5aW5nCnZhcmlhbnQgKGFuZCBwcm9wZXJseSBkb2N1bWVudCB0aGlzIGluIHRoZSBjb2Rl
IHdpdGggYSBjb21tZW50KS4KCldEWVQ/CgpbMV0gaHR0cHM6Ly9saW51eC10ZXN0LXByb2plY3Qu
cmVhZHRoZWRvY3MuaW8vZW4vbGF0ZXN0L2RldmVsb3BlcnMvYXBpX2NfdGVzdHMuaHRtbCN0c3Qt
dGVzdC1kZWZpbml0aW9uCi0tIApBbmRyZWEgQ2VydmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBF
bmdpbmVlciBMaW51eAphbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
