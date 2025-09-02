Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E9BCA1005
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756809981; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=WlCAyS3Q/3wEtLRlRU0gBpNzz7VerZ+sJvUz8vT+5ew=;
 b=rc2nAujQkiB0IVRw+ks+ZMtxdazHQ9MJ+QQu7Ie0s3iXwlyhsGTeZlUxz8j5z2Nwojax5
 FwiwYCDDAlhmt22+QhkVRmXZEayLmovlTreMcvhMk1eTInMScGxiZh+qn8maFD1ZVfLpSx3
 GDYEQ0V1N7qjwsiZwR7nTWV+QXPNC9k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA14F3CD3A8
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 12:46:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BF303CCB6F
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 12:46:02 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 95BF2140016D
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 12:46:01 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3d48b45f9deso1469202f8f.1
 for <ltp@lists.linux.it>; Tue, 02 Sep 2025 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756809961; x=1757414761; darn=lists.linux.it;
 h=in-reply-to:references:to:subject:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+uKEbycwgvGTVPlF8lZDOmAZZ8ebcEZShaUlk6yazA=;
 b=ZUVEaCIbtAvM3O56q2/TIiPAhIkBrJV3TWPMzIgJRJ0QSQOhlN2yJ2nGy/NQ0KPCFT
 fYMUuKAXgBCFkAIkzmrBPMDnGjMRW6Fvjl+CbP2REFccmAVKnGgn6xcRdn4XbdPA6SNM
 VbPkIHmkilT5wfgp8jlEQ2J60bFmPzTmsEvLsvWvsdFZkJ6beoeUHdvQdV+Uy6FsElGX
 LLKXRBftjs5H96/sDmkJsfZPRSENBwBDQ5UGUVf2IjVnZ5/Qn1CR5P09CTS2SrqRmyep
 AEeVM6XC4Sk/ub3llOxve0ZxkcMKiqZMgJos8cyu4Xs06ED7r3YoG1Kl18HRNm5QRt0a
 O6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756809961; x=1757414761;
 h=in-reply-to:references:to:subject:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S+uKEbycwgvGTVPlF8lZDOmAZZ8ebcEZShaUlk6yazA=;
 b=jdsPoawK43NszZOaQIhVVuPXywJowQGGfYzW8O1I+oFp6tMQ2XzW7R0L4OYzMslnYl
 4rqa8XmP6qpPLXqNIuXKNkUIH6Hhq1mPgBs6Y9I8P967iEDV7Fi/YwspJ7W9gQSVMfKu
 0S10VA02Xw1JIpQL6RS2gmgWRXyJ6K6lC0+NYhZ/wfDaxZDG8SYSq8pexE1PIJeqBrhg
 hqMkpfTrfByy/6Q8MVBnXmC9Ar+MJNgqH+IPknbZUXuxCFI50PjW3cuc5mdZP74MYyf4
 nrWkm4JHWaXObQ5tOq5K89qGK1ZTLI0G2Vapwl7M74jdB5Pcq/+hSjq0tqsp7clc6XEW
 QZpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3KTWCYU0GJLE9LpT6NS2wYHCAH4gkHS03xbAFOodJN7UqdphD41aJpDgD/9EzTteJzQk=@lists.linux.it
X-Gm-Message-State: AOJu0YxEgauYqkfyTfd80DxuyhcKOfIzvDRj+imrJ2WWd68zBUGNwRNG
 CcdmLZdp/E5JuMKgc8lRGMTrFhofK9++dI3wXD3Gp4j+iGsM1UhaoETDbOxHwHj04Uw=
X-Gm-Gg: ASbGncvkJcPi6WoaP16nckM5Dw1NYbsoiLmU3Jbg52AKgw11rY9RSJEe6CRNgWvOPf/
 wH5TyMTzfmusYDW4wdOgyaJGGwjT/8rwkvO2rygriI/MIKolSmB6eqvoAEbMZFdQLHRDiY6icD1
 UkMk3QqIULBjwoxAnR68qQjQas1kSsQsz5+PsdIJbwb9Xwmj2yRdmUYar4RdaMi7DFV2SzOK4Nw
 y7IODE5bFXY1pp0NhiuVehjafqsNZTYHqL+dslIye5ds2a0rOGTEEIfBWSoBSxoxvjLWHSiO7kH
 JRHU/TISgw5JctTrI39s5X3SoHW0Z///8QkV3tkHnWqFD14s4wF4o7IFrmrOarikYqoUeZ3vkzW
 ibqIYOz32cA==
X-Google-Smtp-Source: AGHT+IFFIcgY2nHQOxnlSjAH6MTrdHGiQuaB+0l92nlmD8PBO47IDdWvHbxOZIQhu0gIIU0IO1U2bQ==
X-Received: by 2002:a05:6000:2f84:b0:3d0:9781:6e68 with SMTP id
 ffacd0b85a97d-3d1dea8d2cfmr7259771f8f.41.1756809960965; 
 Tue, 02 Sep 2025 03:46:00 -0700 (PDT)
Received: from localhost ([177.94.120.255]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8069d5ba3besm114957885a.64.2025.09.02.03.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 03:46:00 -0700 (PDT)
Mime-Version: 1.0
Date: Tue, 02 Sep 2025 07:45:57 -0300
Message-Id: <DCI95KWIKRQE.2TU03DKTNGORL@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Andrea
 Cervesato" <andrea.cervesato@suse.com>, "Cyril Hrubis" <chrubis@suse.cz>,
 <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-125-gabe5bb884bbc-dirty
References: <aLVzVyaVhr4IHkyd@yuki.lan>
 <69ec2719-0603-4cf2-8774-9f3ceb70a3ca@suse.com>
 <DCI913J2P8P6.2PAJP94GAZKSY@suse.com>
In-Reply-To: <DCI913J2P8P6.2PAJP94GAZKSY@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlIFNlcCAyLCAyMDI1IGF0IDc6NDAgQU0gLTAzLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3
cm90ZToKPiBPbiBUdWUgU2VwIDIsIDIwMjUgYXQgNzoyMyBBTSAtMDMsIEFuZHJlYSBDZXJ2ZXNh
dG8gd3JvdGU6Cj4+IEhpIQo+Pgo+PiBPbiA5LzEvMjUgMTI6MjAgUE0sIEN5cmlsIEhydWJpcyB3
cm90ZToKPj4+IEhpIQo+Pj4gSXQncyBhYm91dCB0aGUgdGltZSB3ZSBzdGFydCB0byBwcmVwYXJl
IGZvciB0aGUgU2VwdGVtYmVyIHJlbGVhc2UuIEFzCj4+PiB1c3VhbGwgSSB3aWxsIGdvIG92ZXIg
dGhlIHBhdGNoZXMgaW4gdGhlIHBhdGNod29yayBpbiB0aGUgbmV4dCB3ZWVrIG9yCj4+PiB0d28u
IElmIHRoZXJlIGlzIHNvbWV0aGluZyB0aGF0IHlvdSB0aGluayBzaG91bGQgYmUgcGFydCBvZiB0
aGUgcmVsZWFzZSwKPj4+IHBsZWFzZSBwb2ludCBpdCBvdXQgc28gdGhhdCBJIGNhbiBoYXZlIGEg
bG9vayBBU0FQLgo+Pj4KPj4gVGhhbmtzLiBJdCB3b3VsZCBiZSBuaWNlIHRvIG1lcmdlIHRoZXNl
IHBhdGNoZXMgYmVmb3JlIHJlbGVhc2U6Cj4+Cj4+IC0gZG9jIHRlc3RpbmcgaW4gQ0k6IAo+PiBo
dHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL2xpc3QvP3Nlcmllcz00NTQx
ODkKPj4gLSBvcGVuX3RyZWVfYXR0cigpIGNvdmVyYWdlOiAKPj4gaHR0cHM6Ly9wYXRjaHdvcmsu
b3psYWJzLm9yZy9wcm9qZWN0L2x0cC9saXN0Lz9zZXJpZXM9NDcxODIwCj4+Cj4+IEFsc28gQFJp
Y2FyZG8gaGFzIG1hbnkgcGF0Y2hlcyBzZW50IHdoaWNoIGFyZSB3YWl0aW5nIHRvIGJlIG1lcmdl
ZCBhbmQgCj4+IHNvbWUgb2YgdGhlbSBhcmUgaW50ZXJlc3RpbmcuCj4KPiBUaGVyZSBzZWVtcyB0
byBiZSBhIGdsaXRjaCBpbiBwYXRjaHdvcmsuLi4gVGhpcyBzdWJtaXR0ZXIgaXMgbm90IG1lOgo+
Cj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9saXN0Lz9zdWJtaXR0
ZXI9Nzc2MjcKPgo+IEkgb25seSBoYXZlIHBlbmRpbmcgbGNob3duIGNvbnZlcnNpb24gYW5kIHB0
aHJlYWRfcndsb2NrX3JkbG9jayBmaXg6Cj4KPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3Jn
L3Byb2plY3QvbHRwL2xpc3QvP3Nlcmllcz00NzE0NDUKPiBodHRwczovL3BhdGNod29yay5vemxh
YnMub3JnL3Byb2plY3QvbHRwL2xpc3QvP3Nlcmllcz00NTc3MDEKCkFjdHVhbGx5IEkgZ3Vlc3Mg
dGhpcyBvbmUgYXN3ZWxsOgoKaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0
cC9wYXRjaC8yMDI1MDcwMi1jb252ZXJzaW9ucy1raWxsMTItdjEtMS00YmEyMTliYmZlNTJAc3Vz
ZS5jb20vCgo+Cj4gVGhhbmtzICEKPgo+Pgo+PiAtIEFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
