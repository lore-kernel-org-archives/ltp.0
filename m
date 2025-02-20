Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA846C021AD
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 07:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740038381; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=YVUKxiaRuFtmtmYlpMI3m81X6hNsFfhyRds8HyjWR0g=;
 b=mxhIqwTXBHqKUPvHOqvxlJxBZuSNKPantd055G1PBbesjwbiZq1zqb/+Kogd81RhsdmKs
 /EyrzSoVQdnGV9ZlOkDDZn2o88MprITF10wIcTNAd93vD5M1z/W8mVIr2x9Z+fBGZVxmaAk
 0j36IE6PAaq1+BThQZYwYW4RDCFQ+LE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 527FD3C6599
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 08:59:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C0203C0265
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:59:19 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F4C0102FD7E
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 08:59:15 +0100 (CET)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-abb86beea8cso132958866b.1
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 23:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740038355; x=1740643155; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CDndDUySQhvnRQQNMT9B0Dghs1Lopi2TGQH/lsszqc8=;
 b=bRJuR1yYGY9T1kODcb3wld3i7cfPJ+sMcqBVKepPl4gKmCLEQfVbTjfo1NB5M2eKbx
 V5DXWAqie0FFNeL9CxxYs0mX+yMMmxzBmX4Zme1PDXopq8VXcNmcedygSfpoIjVidsOD
 gTt6+VQwpnOmx4JWVaxLMcNokyMjgdeW5LaMBmiB5TwdJx/ew3V106RqyKo6sWUSbdBF
 pMjCQ7Sox/xj13qsO9Jf3jksXU0lwaW61ZXmUZRwYprqMD1wSgjBjM9xSWuftvbJxSEd
 tCYXrIqkfgjHPayzlfEiGT9KBqqWzJ9vOuUY3NcCi/VmFoutdOBKDtPxxroEBk/1p/cN
 13JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740038355; x=1740643155;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CDndDUySQhvnRQQNMT9B0Dghs1Lopi2TGQH/lsszqc8=;
 b=bRQ/eZ0JCWOD3BBp7Kkl1DXRSHoTny/NfhwB7Ld3fn19J5bk7PuFwsibe6o2iJ/glO
 U7EoCPaUflCd8fz+J2XSYPmpLX7GzQKFuwqjerejn8lXyGXjP3WB/94wUd6oHF6Jlm2F
 O8CFjX+Gi4QiDnTvkkbeCQSQEU/ZEK6nByVYYrSfHo+up9k/kvnpUmEP3z4gTzfKPydO
 xvsWMScCIcQy/IWwDgktldP/vjD1MDbMlFM8SJEhRm8lMlLjQReTs/h8jbHMQPwbKvea
 WOY+UJCnHmcfGvJuy2DmoeBN1pzYBPlv0ZjPTtl9L73zqyr2FOJg0f7BCYyuQzFelITW
 uuCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+vlXU3KFZdCy62JOiT0PRAOFqjNkRunZkuhP68NKS89hAQUf5I8mUP8Dl6Fqa8xS2/58=@lists.linux.it
X-Gm-Message-State: AOJu0YzWjgAijgrlJ95uZUCIZIMkvmtKvl6YekxI8NOpHC7DmiOLJnbs
 IyXGgGSvkzocIrYj2TMzhaFHj+oxd8Vt4vPivQBBTWFwVKXELqWaOaFr8yy7nWGdyc/BY3i8EX0
 q
X-Gm-Gg: ASbGncsuQpZqijObaEi67k70LcOXZhkm3PIA60G57lQOmjjYh9Czt+juE6lLKm5Ehhj
 CqNFbVOI0QwfkiZbdKyUWUADmZJavTTezSoViCPu24jpdcg9AVKgGn4Wp3iW7d5oc92OmzORnVP
 4+cz1GkITldOM+27Yq9J+YXXH5Z1nLvhkO2vODA8gX3AJhBwZIxy8btBKbTQxzlQWpIVtoYR8yA
 LNWqcH2ZoPKXNvVHECh3HPOZX0zfKMwe6wN7rybaXCNwQ45l0k/uD2UwQpodAvuMYDJXmUwvof0
 4mzlJDzujNKHpV1gSB6TO/YAxbBoN8ifyYspHXHAKKjW6hg4XA/zEE66XEBs/9F6s8T/REllNGM
 zCJLGmEJ6QLWbVCdN1IC/LEJ4yuDZ1DQDfGI/E2dPeBSSHbJc8Zw=
X-Google-Smtp-Source: AGHT+IGYUdLEBCQIO4TA9lsmsK9V+FgnOZT8P/EX/kyLzq0woCzubRSLH3qzDSu0TuDLSimhePkzFQ==
X-Received: by 2002:a17:906:314d:b0:ab7:d946:99ef with SMTP id
 a640c23a62f3a-abbcce67b6fmr623864366b.16.1740038354855; 
 Wed, 19 Feb 2025 23:59:14 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1c4646sm11707106a12.27.2025.02.19.23.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 23:59:14 -0800 (PST)
Message-ID: <2827355b-0e34-4db2-968e-cae1aa54ae0f@suse.com>
Date: Thu, 20 Feb 2025 08:59:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Xinjian Ma (Fujitsu)" <maxj.fnst@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <20250219100027.1049238-1-maxj.fnst@fujitsu.com>
 <1d1bed1c-0537-47a8-ac68-1b108453e8c2@suse.com>
 <TY3PR01MB120711C04E10541E612CFFA55E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <TY3PR01MB120711C04E10541E612CFFA55E8C42@TY3PR01MB12071.jpnprd01.prod.outlook.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

SGkgTWEsCgpPbiAyLzIwLzI1IDA0OjMwLCBYaW5qaWFuIE1hIChGdWppdHN1KSB3cm90ZToKPiBI
aSBBbmRyZWEKPgo+PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tCj4+IOWPkeS7tuS6ujogQW5kcmVh
IENlcnZlc2F0bzxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+PiDlj5HpgIHml7bpl7Q6IDIw
MjXlubQy5pyIMTnml6UgMTg6NDIKPj4g5pS25Lu25Lq6OiBNYSwgWGluamlhbi/pqawg5paw5bu6
PG1heGouZm5zdEBmdWppdHN1LmNvbT47bHRwQGxpc3RzLmxpbnV4Lml0Cj4+IOS4u+mimDogUmU6
IFtMVFBdIFtQQVRDSF0gaW9jdGwwODogRml4IGNvbW1lbnQgaW5kZW50YXRpb24gdG8gZml0IFJT
VCBmb3JtYXQKPj4KPj4gSGkgTWEsCj4+Cj4+IEkgcmVhbGx5IGFwcHJlY2lhdGUgeW91ciB3b3Jr
IG9uIGNvbnZlcnRpbmcgdG8gUlNUIGZvcm1hdC4gSSB3aWxsIG1lcmdlIGFsbAo+PiBwYXRjaGVz
IGhhdmluZyBhIGJ1bGxldCBwb2ludCBsaXN0Lgo+PiBGb3Igb3JkZXJlZCBsaXN0cywgd2UgY2Fu
IHByb2JhYmx5IHVzZSB0aGlzIGZvcm1hdCwgc28gaXQgd2lsbCBiZSBlYXNpZXIgdG8KPj4gbWFp
bnRhaW46Cj4+IGh0dHBzOi8vc3VibGltZS1hbmQtc3BoaW54LWd1aWRlLnJlYWR0aGVkb2NzLmlv
L2VuL2xhdGVzdC9saXN0cy5odG1sI29yZGVyZWQtbGkKPj4gc3RzCj4gSXQgbG9va3MgZ29vZCwg
YnV0IEkgZm91bmQgeW91IGhhdmUgaGVscGVkIG1lcmdlZCB0aGlzIHBhdGNoLgpZb3UgYXJlIHJp
Z2h0LCBJIHRoaW5rIEkgbWVyZ2VkIHRoZSB3cm9uZyBvbmUuIEZlZWwgZnJlZSB0byBzZW5kIGEg
CmZvbGxvdy11cCBwYXRjaCBpZiBuZWVkZWQuCj4gQW5kIEkgaGF2ZSBhIHF1ZXN0aW9uLCByZWdh
cmRpbmcgZXJybm8gdGVzdCBudW1iZXJzLCBzaG91bGQgd2UgdXNlIGJ1bGxldCBwb2ludCBsaXN0
cyBvciBvcmRlcmVkIGxpc3RzPwo+IFN1Y2ggYXNodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAv
MjAyNTAyMTkwOTA1MDUuMTAzOTQ2Mi0xLW1heGouZm5zdEBmdWppdHN1LmNvbS9ULyN1CkJ1bGxl
dCBwb2ludHMgYXJlIGVub3VnaCwgc2luY2Ugb3JkZXJlZCBvbmVzIGFyZSBhIHNlcXVlbmNlIG9m
IHN0ZXBzLCAKdHlwaWNhbCBvZiBhbGdvcml0aG1zLgo+IENvdWxkIHlvdSBwbGVhc2UgZ2l2ZSBz
b21lIHN1Z2dlc3Rpb25zPwo+Cj4gQmVzdCByZWdhcmRzCj4gTWEKPgpCZXN0IHJlZ2FyZHMsCkFu
ZHJlYSBDZXJ2ZXNhdG8KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
