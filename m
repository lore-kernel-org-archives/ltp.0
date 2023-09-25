Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFECCE7A89
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 09:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 101CF3C99D5
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 11:44:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33F4B3C99D5
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 11:43:58 +0200 (CEST)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1A682140033A
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 11:43:55 +0200 (CEST)
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-49352207f33so2094865e0c.2
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 02:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695635034; x=1696239834; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LNQh3gPWZLNGBWs6Syw4BOUBLWuSAVzqnOqg+zAodOI=;
 b=Tfhp/88xfAJ4cy8iF1/bFzkdj7dRzTtjSjPmVpUFH47q8e8cD8R2e0Bfr8ULzcf7nn
 l+u0//JhTIwv5Y+jlt/WKYNFCh9nhGgtsUPc2AIqSantUGq0P3gwQOQ5+R9yM8cMW4f6
 Ms/PK9d9lo6Qi7q7ZZib/XMZrpuPIFcJo1EgJ71XwWtpwSV6n7RvWInWD1oEZ/zXzKSH
 uilyyoKFSiF7t04LD4IMokC9E3CI9gsINUozh7BCPbfxFZ7TR2laqAB0otQ4MYMAhtDh
 3wTZfxpVhWxY64SuPZEzLUCT96OTM6/TGXHUFnIG8g0JfIOtzVio/9p30rx12E/pHLO1
 Bdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695635034; x=1696239834;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNQh3gPWZLNGBWs6Syw4BOUBLWuSAVzqnOqg+zAodOI=;
 b=YKsZg8Hf33RT/1fxjNFZvRysStq4aX2vPJ1fYxngGe/ncymZ4MGCAZ2nqEYxNBH7Bs
 cYIWlDMMfBlvhmSxY4fPzBB7N/5LUZNn4bxgR30tQJvIkp+ksK1F19pH8xzxG8TVZqa5
 NkH8SmX5dsC9HZdZ+GPKNNEECJR6eSAxH16pCWNA//Iuv1ZBMfaQNN1qgPozhEyL02JX
 gCUNCpdSe53MYL3IW7EhtvP8NATJNsuLHG19GN0W0SChHqNCsNpS3suiLlTsQvRzn35j
 Ae2eeR3j2SpC1YImgOtIC5PluJoTyGAapQxR7nJN5MkRE8rbzk2bGaGOJE4YK6bycTik
 p5Ig==
X-Gm-Message-State: AOJu0YwrkKWvLnJ6LNNojv6UVPyUM6pvBPTRC5NU+1yFjnCDXwcqnfl+
 NrkEuYGro5BsCjbzYpQktvene8rZfjonOg9pIfw=
X-Google-Smtp-Source: AGHT+IH0jb03GIUmHtK1EkjiqCNYXZEkwUjbBbZYOnt4nVO3r6Y1rHWqSBAU6t3SQmyfZy6Q9UnpfVPqiMGbFW8zN7k=
X-Received: by 2002:a67:f108:0:b0:44f:c528:6255 with SMTP id
 n8-20020a67f108000000b0044fc5286255mr3609591vsk.16.1695635033900; Mon, 25 Sep
 2023 02:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org>
 <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org>
In-Reply-To: <ZREr3M32aIPfdem7@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Sep 2023 12:43:42 +0300
Message-ID: <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
To: Matthew Wilcox <willy@infradead.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgOTo0MuKAr0FNIE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IE9uIFN1biwgU2VwIDI0LCAyMDIzIGF0IDExOjM1OjQ4
UE0gLTA1MDAsIFJldWJlbiBIYXdraW5zIHdyb3RlOgo+ID4gVGhlIHYyIHBhdGNoIGRvZXMgTk9U
IHJldHVybiBFU1BJUEUgb24gYSBzb2NrZXQuICBJdCBzdWNjZWVkcy4KPiA+Cj4gPiByZWFkYWhl
YWQwMS5jOjU0OiBUSU5GTzogdGVzdF9pbnZhbGlkX2ZkIHBpcGUKPiA+IHJlYWRhaGVhZDAxLmM6
NTY6IFRGQUlMOiByZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkpIGV4cGVjdGVkCj4g
PiBFSU5WQUw6IEVTUElQRSAoMjkpCj4gPiByZWFkYWhlYWQwMS5jOjYwOiBUSU5GTzogdGVzdF9p
bnZhbGlkX2ZkIHNvY2tldAo+ID4gcmVhZGFoZWFkMDEuYzo2MjogVEZBSUw6IHJlYWRhaGVhZChm
ZFswXSwgMCwgZ2V0cGFnZXNpemUoKSkgc3VjY2VlZGVkCj4gPiA8LS0tLS0tLWhlcmUKPgo+IFRo
YW5rcyEgIEkgYW0gb2YgdGhlIHZpZXcgdGhhdCB0aGlzIGlzIHdyb25nIChhbHRob3VnaCBwcm9i
YWJseQo+IGhhcm1sZXNzKS4gIEkgc3VzcGVjdCB3aGF0IGhhcHBlbnMgaXMgdGhhdCB3ZSB0YWtl
IHRoZQo+ICdiZGkgPT0gJm5vb3BfYmFja2luZ19kZXZfaW5mbycgY29uZGl0aW9uIGluIGdlbmVy
aWNfZmFkdmlzZSgpCj4gKHNpbmNlIEkgZG9uJ3Qgc2VlIGFueXdoZXJlIGluIG5ldC8gc2V0dGlu
ZyBmX29wLT5mYWR2aXNlKSBhbmQgc28KPiByZXR1cm4gMCB3aXRob3V0IGRvaW5nIGFueSB3b3Jr
Lgo+Cj4gVGhlIGNvcnJlY3Qgc29sdXRpb24gaXMgcHJvYmFibHkgeW91ciB2MiwgY29tYmluZWQg
d2l0aDoKPgo+ICAgICAgICAgaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOwo+IC0gICAgICAgaWYg
KFNfSVNGSUZPKGlub2RlLT5pX21vZGUpKQo+ICsgICAgICAgaWYgKFNfSVNGSUZPKGlub2RlLT5p
X21vZGUpIHx8IFNfSVNTT0NLKGlub2RlLT5pX21vZGUpKQo+ICAgICAgICAgICAgICAgICByZXR1
cm4gLUVTUElQRTsKPgo+IGluIGdlbmVyaWNfZmFkdmlzZSgpLCBidXQgdGhhdCB0aGVuIGNoYW5n
ZXMgdGhlIHJldHVybiB2YWx1ZSBmcm9tCj4gcG9zaXhfZmFkdmlzZSgpLCBhcyBJIG91dGxpbmVk
IGluIG15IHByZXZpb3VzIGVtYWlsLiAgQW5kIEknbSBPSyB3aXRoCj4gdGhhdCwgYmVjYXVzZSBJ
IHRoaW5rIGl0J3Mgd2hhdCBQT1NJWCBpbnRlbmRlZC4gIEFtaXIgbWF5IHdlbGwgZGlzYWdyZWUK
PiA7LSkKCkkgcmVhbGx5IGhhdmUgbm8gcHJvYmxlbSB3aXRoIHRoYXQgY2hhbmdlIHRvIHBvc2l4
X2ZhZHZpc2UoKS4KSSBvbmx5IG1lYW50IHRvIHNheSB0aGF0IHdlIGFyZSBub3QgZ29pbmcgdG8g
YXNrIFJldWJlbiB0byB0YWxrIHRvCnRoZSBzdGFuZGFyZCBjb21taXR0ZWUsIGJ1dCB0aGF0J3Mg
b2J2aW91cyA7LSkKQSBwYXRjaCB0byBtYW4tcGFnZXMsIHRoYXQgSSB3b3VsZCByZWNvbW1lbmQg
YXMgYSBmb2xsb3cgdXAuCgpGV0lXLCBJIGNoZWNrZWQgYW5kIHRoZXJlIGlzIGN1cnJlbnRseSBu
byB0ZXN0IGZvcgpwb3NpeF9mYWR2aXNlKCkgb24gc29ja2V0IGluIExUUCBBRkFJSy4KTWF5YmUg
Q3lyaWwgd2lsbCBmb2xsb3cgeW91ciBzdWdnZXN0aW9uIGFuZCB0aGlzIHdpbGwgYWRkIHRlc3QK
Y292ZXJhZ2UgZm9yIHNvY2tldCBpbiBwb3NpeF9mYWR2aXNlKCkuCgpSZXViZW4sCgpUaGUgYWN0
aW9uYWJsZSBpdGVtLCBpZiBhbGwgYWdyZWUgd2l0aCBNYXR0aGV3J3MgcHJvcG9zYWwsIGlzCm5v
dCB0byBjaGFuZ2UgdGhlIHYyIHBhdGNoIHRvIHJlYWRhaGVhZCgpLCBidXQgdG8gc2VuZCBhIG5l
dwpwYXRjaCBmb3IgZ2VuZXJpY19mYWR2aXNlKCkuCgpXaGVuIHlvdSBzZW5kIHRoZSBwYXRjaCB0
byBDaHJpc3RpYW4sIHlvdSBzaG91bGQgc3BlY2lmeQp0aGUgZGVwZW5kZW5jeSAtIGl0IG5lZWRz
IHRvIGJlIGFwcGxpZWQgYmVmb3JlIHRoZSByZWFkYWhlYWQKcGF0Y2guCgpJZiB0aGUgcmVhZGFo
ZWFkIHBhdGNoIHdhcyBub3QgYWxyZWFkeSBpbiB0aGUgdmZzIHRyZWUsIHlvdQp3b3VsZCBoYXZl
IG5lZWRlZCB0byBzZW5kIGEgcGF0Y2ggc2VyaWVzIHdpdGggYSBjb3ZlciBsZXR0ZXIsCndoZXJl
IHlvdSB3b3VsZCBsZWF2ZSB0aGUgUmV2aWV3ZWQtYnkgb24gdGhlIHVuY2hhbmdlZApbMi8yXSBy
ZWFkYWhlYWQgcGF0Y2guCgpTZW5kaW5nIGEgcGF0Y2ggc2VyaWVzIGlzIGEgZ29vZCB0aGluZyB0
byBwcmFjdGljZSwgYnV0IGl0IGlzCm5vdCBzdHJpY3RseSBuZWVkZWQgaW4gdGhpcyBjYXNlLCBz
byBJJ2xsIGxlYXZlIGl0IHVwIHRvIHlvdSB0byBkZWNpZGUuCgpUaGFua3MsCkFtaXIuCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
