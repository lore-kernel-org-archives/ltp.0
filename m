Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1EDC021BC
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740485033; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=1STRffXEtkLXUH1ZPU3tC/MJY35DmI4Wpt4MFWkGiZY=;
 b=IUetGnCMUxOPRwSPZIrU1xLpdMhKggX3LLJrffnX7NANrvh+A/twN1nbZRX+QYI1Vyr+2
 z+ColOVqj0ilt/CVtcGbS3GDDveMmseAoNmbdzRNfUsXG9AQeRGkgzaNnh26t7g/lIS3Jw1
 Eeyk9MbYYuhj0tThDadIHzR50RcXdwE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFEE13C9B1C
	for <ltp@archiver.kernel.org>; Tue, 25 Feb 2025 13:03:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FDB63C996D
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 13:03:31 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D900863CCEA
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 13:03:29 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-439946a49e1so34662905e9.0
 for <ltp@lists.linux.it>; Tue, 25 Feb 2025 04:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740485009; x=1741089809; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=5rdk5O3ihGl39Ksa4r0v29M/gWpyoWG3es3Q/C4AtFg=;
 b=W09xv5hLKzP0YHUEVLxuljmd6wcVs015LM9STmKD4YrCln6VovFAEiqFLC3Aq4iDPK
 aMxlFeySjJMX03xcmdwYt4a9M30kHrXO36opYvn+E1yu+36topgWYQeT/kAfl3z9YaOk
 E3wpF+CeQQ/4J90Sj/T9kWkVFHfEToeOF2ETlvE8jn3fl9VFLsmtmM5VHYTlTl5XK4+f
 6z+tJCWTQSp/kZ6Dmvkt5JQkoEyQaWG083eGwnihO7B1ARR+PRkZ/Dz7fbBORQkg0rC9
 p4shsdkZpj88j76GHaNiZ2EBLTwxUAsAL74w2Ou25GMUExpFosFS3cYzPyX9sdznEOOO
 +6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740485009; x=1741089809;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5rdk5O3ihGl39Ksa4r0v29M/gWpyoWG3es3Q/C4AtFg=;
 b=WB4axbDg9uW/aPNsV4cIp+Ef7ynz1G0enhcoKNFQrJZOdJkK7+R9l6CXs6Rp66IB8L
 u/XnKoxDu2jaimnw7gzMid84MHVFpTfvd04SPwcpn/jYgX+tuKc+bVP4coq1KCMUEgBt
 bKLYc7p147dJziZiTCW0L3SSohYUMwrNvEn1xGPw3AWzzPRNrWGDSDPd2KmPhSGQePrq
 tgQXZG0ANuNfSSUPYr0NFItCMhAsWFH6o1U7wBRuVQYlq/1R6YjAbCgxP4FQ+ySd9sRw
 w+ihCElhnK7RqLkEKlS6WFDc2llDZvseXHH9HXyqS8yneZb0EPV7BPjFujJUivZy2IyH
 0bsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9woOH2cS7SNyE5Ii6ulRr1Xt7D6hUGFlsLsARtPxx5X8KqGrYNxx2whfXRDPQfbemNIE=@lists.linux.it
X-Gm-Message-State: AOJu0YxcDXwVioIWMLKwULDPCNPPaybLraiDtTT+ClMWL9cBzSIKCWqU
 gXIpZAnmZ/yOwhkFiMgC+W9B11pDuf8RJq38TDDiNVRQ6mDrcXFd2bleYI1/sZQ=
X-Gm-Gg: ASbGncvQywNc9gLPwPdcXUHBOMuFHbz3AhnKsTn1GQ5+e/fu5+OF/bFG/duRwvpdIiK
 rKIBVP+6pQCyo63PXD+HA/st8BT3UwdStEXTepF8QI1tPtU8tFXO+HOIxg3eG1Qsl3qIck7xJ1o
 J9ZYW2wjtmuRUCz8UYP6m3Qmf0zw53dbJP9pPp6UqpjpVWmR/SxSjvnBH6KY6nT4yX83ZwzalxO
 1GdEjhwQwYtGQB0KPNcoR+CBunf4NoDM47i+K81g72FKj4fT4bTKUEOHsKm9617yAl1gTD9tDDg
 I+92QtBRJ3Bl6TbZY2/+Fttbhh9K1BhsBgY=
X-Google-Smtp-Source: AGHT+IFmhD3akTh6XfBq4fXT3pg4ceOmFsTMbC+FlpkmlbqC9BC3ggpbx8AfiAd/D8DSXXxN38R5QA==
X-Received: by 2002:a05:600c:1991:b0:434:fb65:ebbb with SMTP id
 5b1f17b1804b1-439ae1f15e5mr153180285e9.17.1740485009177; 
 Tue, 25 Feb 2025 04:03:29 -0800 (PST)
Received: from [192.168.1.91] ([151.71.237.5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86cc6asm2092217f8f.35.2025.02.25.04.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 04:03:28 -0800 (PST)
Message-ID: <65120f51-6569-4a71-beb1-36b13ab84b56@suse.com>
Date: Tue, 25 Feb 2025 13:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
 <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
 <TY3PR01MB120711C04E10541E612CFFA55E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <2827355b-0e34-4db2-968e-cae1aa54ae0f@suse.com>
 <TY3PR01MB12071554D05FFE6ADC60A5C75E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
 <94414a1e-2c20-4f5b-9c63-9e7939bd9852@suse.com>
 <TY3PR01MB1207196B6B83CD6231943CBFEE8C32@TY3PR01MB12071.jpnprd01.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <TY3PR01MB1207196B6B83CD6231943CBFEE8C32@TY3PR01MB12071.jpnprd01.prod.outlook.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ioctl08: Fix comment indentation to fit RST format
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWEsCgpzdXJlIG5vIHByb2JsZW0uIEkgd2lsbCB0YWtlIGEgZG91YmxlIGxvb2sgdG8gdGhh
dC4KCkJlc3QgcmVnYXJkcywKQW5kcmVhIENlcnZlc2F0bwoKT24gMi8yNS8yNSAxMDoxMiwgWGlu
amlhbiBNYSAoRnVqaXRzdSkgd3JvdGU6Cj4KPiBIaSBBbmRyZWEKPgo+IFRoYW5rIHlvdSB2ZXJ5
IG11Y2ggZm9yIHRoZSBwdXNoaW5nLgo+Cj4gSSBoYXZlIGEgc21hbGwgcmVxdWVzdC4KPgo+IEkg
Y2hlY2tlZCBnaXQtbG9nIGFuZCBmb3VuZCB0aGF0IHRoZSBBdXRob3IgaXMg4oCcTWEgWGluamlh
biB2aWEgbHRwIAo+IGx0cEBsaXN0cy5saW51eC5pdOKAnS4KPgo+IEJ1dCBJIGZvdW5kIHByZXZp
b3VzIGNvbW1pdHPigJlBdXRob3IgaXMg4oCcWGluamlhbiBNYSAoRnVqaXRzdSkgCj4gbWF4ai5m
bnN0QGZ1aml0c3UuY29t4oCdLgo+Cj4gSSB3b3VsZCBiZSB2ZXJ5IGdyYXRlZnVsIGlmIHRoZSBp
bmZvIGluIGxhdGVyIGNvbW1pdHMgY2FuIGFsc28gYmUgbXkgCj4gb3duIGVtYWlsIGFkZHJlc3Mg
KFhpbmppYW4gTWEgKEZ1aml0c3UpIG1heGouZm5zdEBmdWppdHN1LmNvbSkgd2hlbiAKPiB0aGV5
IGFyZSBwdXNoZWQuCj4KPiBCZXN0IHJlZ2FyZHMKPgo+IE1hCj4KPiAq5Y+R5Lu25Lq6OipBbmRy
ZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+ICrlj5HpgIHml7bpl7Q6
KjIwMjXlubQy5pyIMjDml6UxODowNAo+ICrmlLbku7bkuro6Kk1hLCBYaW5qaWFuL+mprCDmlrDl
u7o8bWF4ai5mbnN0QGZ1aml0c3UuY29tPjsgbHRwQGxpc3RzLmxpbnV4Lml0Cj4gKuS4u+mimDoq
UmU6IFtMVFBdIFtQQVRDSF0gaW9jdGwwODogRml4IGNvbW1lbnQgaW5kZW50YXRpb24gdG8gZml0
IFJTVCAKPiBmb3JtYXQKPgo+IFRoYW5rcywKPgo+IEkgcHVzaGVkIGFsbCBwYXRjaGVzIGFib3V0
IFJTVCB1cGRhdGVzLgo+Cj4gQmVzdCByZWdhcmRzLAo+IEFuZHJlYSBDZXJ2ZXNhdG8KPgo+IE9u
IDIvMjAvMjUgMTA6MzksIFhpbmppYW4gTWEgKEZ1aml0c3UpIHdyb3RlOgo+Cj4gICAgIEhpIEFu
ZHJlYQo+Cj4gICAgIDEuQnVsbGV0IHBvaW50cyBhcmUgZW5vdWdoLCBzaW5jZSBvcmRlcmVkIG9u
ZXMgYXJlIGEgc2VxdWVuY2Ugb2YKPiAgICAgc3RlcHMsIHR5cGljYWwgb2YgYWxnb3JpdGhtcy4K
Pgo+ICAgICBJIGhhdmUgcmUtc2VudCByZWxhdGVkIHBhdGNoZXMgYW5kIHVzZWQgYnVsbGV0IHBv
aW50IGxpc3RzIGZvcgo+ICAgICB0aGVtLiBQVEFMLgo+Cj4gICAgIEJlc3QgcmVnYXJkcwo+Cj4g
ICAgIE1hCj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
