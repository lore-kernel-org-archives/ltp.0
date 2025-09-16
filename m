Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6089FCAC599
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 07:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758007223; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=HxAq6MauCAMYBB2Ml5lKdagZTyj0JMvXmOvFBGDn41c=;
 b=U2HtUO76u09G0gZ3zoMgSza3MDP2N4HByAA8lKlNe3RtH8wGKKahQhkaBRutlLOdUe0gc
 jeSZQqfL/VoKzNdqoS+wkxSbb6r9f/CsUODnppq3Lb0fiDzkGO9E/j7K/3NXlavGRhpjk1X
 v+2n8yuyWthF2fHa5GUFuEkAJN17HOU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF9CA3CDACF
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 09:20:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2A723CDA43
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 09:20:03 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 088A460092B
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 09:20:03 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-62f261a128cso3871009a12.2
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758007202; x=1758612002; darn=lists.linux.it;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVVILAwNL6Cgm6qFy74hBlhoUqV3wIUz7QMti4HaBso=;
 b=dAULIOvDHVuSiXTkxJt4eo4CmVMleuFzSk7TtuGu3ARkCFlm4oY15zt1nFtJ7ocTG4
 /mshprgGLSB5TPjhv9Eif0yfHsWs1sg/3s42kl1vpGp3zppEZQKRVvG1F49oOATbX34I
 lIsyBRBTLVUOv1FqpqElpoKe2NtENbzbNYuOQdH+aLGPGMJwLCgWgkiNpZJaKgz087F9
 dKU/Gtft6fe0jY4QrBpkTQkU9T2TpGOIPqYJAF5Ygws3hfc91SyPkrmNDKcx2SVQlB8p
 RGjEfd18jV6UdQkEWBy6qb/CH8+ubX6MUG+wPmukMsKN0tzCxRfNH+XN7q1DXb3F++2o
 G5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758007202; x=1758612002;
 h=in-reply-to:content-language:references:cc:to:from:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OVVILAwNL6Cgm6qFy74hBlhoUqV3wIUz7QMti4HaBso=;
 b=otvORu2aQllZKEWg6kPyTdgF45WpqjZc6cAuqQ2XDWmB1hfAcs62qgndGcQ60wvMF5
 9A5ENfoOJX3U1GDQyjvg6SobY+zfecV7xq685dzwOMzSp1dnpm27fgy2dN2ATo2zhiWp
 8/Yu85DUQmty9ul42TzjifpkcfrDgA9zwDPNV9lTRZ6f5cqGLYXIYLxGVQrcC6pV/PTu
 SNwkGWcEr6/pPwXUK9kQN0APKuPsG6eN7wOYRIJu5/AQoVSNWI9lUFL9IZArZFAcfUny
 mzMxteT0zpdMbUaBrDxvw8WuzZUAgJY2AIdKZ7KK4DvVUdBiM7UaHWd/n3d92KXksI+U
 05pg==
X-Gm-Message-State: AOJu0Yyh7p9dl4G55Tc3x4yXFQEP47OW8wR4Ipu6qwM8e1uCG6xs2huj
 sIp2DWs3CYGt+mt2kcYzJ+E5nJkpWGujYXeCadVVOYsgjcOMppzZjOJMIHoQr+XKdnrDOxe80sh
 +F3lnza8=
X-Gm-Gg: ASbGncueTFt1z9cr+rKsOcf2UgY6l6bvWyPNxGWPy739IFQSL2FtjWUxLq2loCLSMJs
 /h8H1uALQJDVHheulCTqrssR3U0RXR9iRZJgSDRvaAWBhv7GOIS8iSEYuCRqADJ0UNgAIt/78Dn
 MApzlScE2J2GcoZJBKU2+KAADB2fukmPWbySaSei5H7zlKmhcxE3LiMw4KTPLso56cYQDV7v4ND
 PAQeVzGRSFn+rgc3d+TVdWId2WwL1g67WM0oS5Ys18xcbIIj9riDPZmom7MXdJwzrrQBbq06aMR
 Ft3TFaaTWBjO+weWf46/yeH7P9zK7u19gE3dQO0fnY4fr7gBxbvj0irOf2RFj4yi08ISsdh8AHQ
 bZu0WoHZ9yIVbvzcTqq3e6ZloHdCp6QWXnA3hkXPDqPkiq/S3uMH7BtCKqj/T2I6Mg4LV75QoDK
 rZoMJuOBrge+7f3rb11oPFLv0f60lAKIq2BB8ixDLPeQnMrGK+1of5cqOKDa1oBQ==
X-Google-Smtp-Source: AGHT+IHtZZ9YwPJVRe5QXs72uJFn//bmVuSN2hNsVEELSVZXph4uMdW8GH+hZ5tGSu7QhQj/weO6xQ==
X-Received: by 2002:a17:907:d1a:b0:b04:8701:731b with SMTP id
 a640c23a62f3a-b07c357503dmr1591829866b.20.1758007202359; 
 Tue, 16 Sep 2025 00:20:02 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b32dd5b4sm1108601166b.70.2025.09.16.00.20.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 00:20:02 -0700 (PDT)
Message-ID: <63d60b27-d732-4525-a62f-5fd0d910511e@suse.com>
Date: Tue, 16 Sep 2025 09:20:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <CAEemH2e0TUFeWS7mjfz5FVW_Jb6Pv76YiEXLHY+ojwfGpvfWWw@mail.gmail.com>
 <CAEemH2cTiKAhn2hjr71Qn1-CRHBoFm_FH4Xp3BPQm1arrxUVTA@mail.gmail.com>
 <3f256fea-0add-413b-939e-b2d252415bfa@suse.com>
Content-Language: en-US
In-Reply-To: <3f256fea-0add-413b-939e-b2d252415bfa@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] kirk cannot handle env variable correctly
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
Cc: LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDkvMTYvMjUgOToxOSBBTSwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPgo+IEhpIQo+Cj4g
T24gOS8xNi8yNSA2OjM1IEFNLCBMaSBXYW5nIHdyb3RlOgo+Pgo+PiBBZnRlciBsb29raW5nIGF0
IHRoZSBsdHAucHksIGl0IG92ZXJyaWRlcyB0aGUgdXNlci1zZXQgCj4+IExUUF9USU1FT1VUX01V
TCBlbnYgdmFyaWFibGUuCj4+IFNvIG1heWJlIHdlIG5lZWQgdG8gZW5hYmxlIHRoYXQgdG8gY29u
ZmlnIGJ5IC0tZW52LCB3aGF0IGRvIHlvdcKgdGhpbms/Cj4KPiBJbmRlZWQsIHRoaXMgaXMgYSBm
ZWF0dXJlIHRoYXQgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgYW55bW9yZS4gV2UgCj4gc2hvdWxk
IGZldGNoIGVudiB2YXJpYWJsZXMgZnJvbSB0aGUgY29tbWFuZCBsaW5lIGFuZCBub3QgZnJvbSB0
aGUgCj4gLS1lbnYgb3B0aW9uLiBUaGlzIHdhcyBhZGRlZCB3aGVuIEZyYW1ld29yayBBUEkgd2Fz
IGEgcGx1Z2luIGFuZCB3ZSAKPiBjb3VsZCBpbXBsZW1lbnQgbXVsdGlwbGUgZnJhbWV3b3Jrcywg
YnV0IG5vdyB3ZSBvbmx5IHN1cHBvcnQgTFRQLgo+Cj4gSSdtIGN1cnJlbnRseSB3b3JraW5nIG9u
IGEgbmV3IGtpcmsgdmVyc2lvbiwgd2hlcmUgbXVsdGlwbGUgCj4gY29tbXVuaWNhdGlvbiBjaGFu
bmVscyBhbmQgU1VUIGNhbiBiZSBpbXBsZW1lbnRlZCBzZXBhcmF0ZWx5IGluIG9yZGVyIAo+IHRv
IGNyZWF0ZSBjb21wbGV4IHNjZW5hcmlvcy4gTXkgaWRlYSBpcyB0byByZW1vdmUgRnJhbWV3b3Jr
IEFQSSBhbmQgCj4gLS1lbnYgdmFyaWFibGUgbmV4dCB0byB0aGF0LiBGb3Igbm93IHdlIGNhbiBt
ZXJnZSB0aGlzIHBhdGNoLgo+Cj4gLSBBbmRyZWEKPgpJIGZvcmdvdCBvbmUgdGhpbmc6IGNhbiB5
b3UgcGxlYXNlIHNlbmQgYSBQUj8gU28gSSBjYW4gbWVyZ2UgaXQgdmlhIApnaXRodWIgYW5kIHdl
IGtlZXAgdHJhY2sgb2YgaXQgaW4gdGhlIG5leHQgcmVsZWFzZS4gVGhhbmtzIQoKLSBBbmRyZWEK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
