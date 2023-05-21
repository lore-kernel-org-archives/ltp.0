Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6527CC7EE2A
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 08:45:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66F683CB0EB
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 10:45:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02B563CB15E
 for <ltp@lists.linux.it>; Sun, 21 May 2023 10:19:41 +0200 (CEST)
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C057F60045C
 for <ltp@lists.linux.it>; Sun, 21 May 2023 10:19:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.cs.ucla.edu (Postfix) with ESMTP id 3A91E3C02213D;
 Sun, 21 May 2023 01:19:34 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id w4u1zlOlXwIX; Sun, 21 May 2023 01:19:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.cs.ucla.edu (Postfix) with ESMTP id 30F3A3C09FA29;
 Sun, 21 May 2023 01:19:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 30F3A3C09FA29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
 s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1684657172;
 bh=zw3Y2ULVDREqfOT/QgS8rLelROV4JBxYCxDjY+zDqtE=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=U6+EJ6mlqWcihsbKxfP6kmhtUSA1zAtuc7H9RoKAUCiDI83y4ewJz+1mV8f5kuC6N
 4KMF0uuDfu/v5dr6P26OYlAr/3CmMajq6tn0FbMD0cEpNDa4j8RLq+hd9c7L6Xxcbp
 rSyLnjFPg7XgeYUfdg6r5xG1juHk5YkD3hVtitTsk3kyWLazbwBtP25Xmy41wuAyo9
 WPqdtmdbaRyCFipyw3p1pnUIEjdQLIugkmkaU6hX/roOYJmDstOWLOq+dB82FRaYFC
 PWAMSFBYgKrb/xvyBN6b4fJSeJKDy4SwsJrXqxkwK/N3nl2cZRt0xMY/ZGcJ1LmVRg
 whvkFAbcXb0Iw==
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id rRiYEvTPiiNS; Sun, 21 May 2023 01:19:32 -0700 (PDT)
Received: from [192.168.1.9] (cpe-172-91-119-151.socal.res.rr.com
 [172.91.119.151])
 by mail.cs.ucla.edu (Postfix) with ESMTPSA id EB0783C02213D;
 Sun, 21 May 2023 01:19:31 -0700 (PDT)
Message-ID: <1c688849-f992-029e-30e8-8990c311c8a3@cs.ucla.edu>
Date: Sun, 21 May 2023 01:19:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Xi Ruoyao <xry111@xry111.site>, lixing <lixing@loongson.cn>,
 Carlos O'Donell <carlos@redhat.com>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Peng Fan <fanpeng@loongson.cn>
References: <lxnjka-9sevacf455zj-1fthj246gvr4-712jsi8w59t4969pqyxmxkaq-l3n4z6dp0ybpuvpiuudtnfot-dl7onwkii2tq8gtprte6cu4fgip6f-ikuh33-a5p9ixcl44cx2h7mimcgl3xt-13bjom.1684553069255@email.android.com>
 <0cb83efa85ae32d956f81e6b9d4966c38fd54bcb.camel@xry111.site>
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <0cb83efa85ae32d956f81e6b9d4966c38fd54bcb.camel@xry111.site>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 22 May 2023 10:44:30 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Increase judgment on buf.
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
Cc: "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyMy0wNS0yMCAwMzoxOSwgWGkgUnVveWFvIHZpYSBMaWJjLWFscGhhIHdyb3RlOgo+IElm
IGEgTFRQIHRlc3QgcmVsaWVzIG9uIGEgRUZBVUxUIGhlcmUsIHRoZW4gTFRQIGhhcyBhIGJ1Zy7C
oCBZb3Ugc2hvdWxkCj4gdGVsbCBMVFAgdG8gZml4IGl0IHRoZW4uCgpMVFAgZnN0YXQwMyBhbGxv
d3MgZWl0aGVyIEVGQVVMVCBvciBTSUdTRUdWLCBidXQgbm8gb3RoZXIgYmVoYXZpb3IsIHdoZW4g
CidzdGF0JyBpcyBwYXNzZWQgYSBudWxsIHBvaW50ZXIuCgpUaGVyZWZvcmUgdGhhdCB0ZXN0IGlz
IHRvbyBzdHJpY3QgZm9yIFBPU0lYLCBhcyB0aGUgUE9TSVggYmVoYXZpb3IgaXMgCnVuZGVmaW5l
ZC4KCkl0J3MgYWxzbyB0b28gc3RyaWN0IGZvciBHTlUvTGludXgsIGJlY2F1c2UgaXQgaW5zaXN0
cyBvbiBTSUdTRUdWIAp3aGVyZWFzIGFueSB0ZXJtaW5hdGluZyBzaWduYWwgd2lsbCBkbyAoZS5n
LiwgU0lHQUJSVCkuCgpQcm9wb3NlZCBMVFAgcGF0Y2ggYXR0YWNoZWQuCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
