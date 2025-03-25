Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AE0C35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 03:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742874916; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2oeC6lrzubCKlZQHjEENnGaAOCMlAeRsax2xhrI9fSI=;
 b=Vgr2M1RRyH66iQlK9y99SLdwuK61cCsI8Ns7pgib5bgACZycVRBWPxdd+7zdzD/3pMiJx
 tQDuJEs/F5ojZim2rE5NErbkmVw1pP+nePuExd0VCM/N1qgWQx6xR88ylOF1UqYpuhiIUlk
 2c5aYTItgrLwKUzaJ+nkKtEGXGbnxRI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1456D3C98EC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 04:55:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F1A03C919F
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 04:54:54 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EB48E1402E20
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 04:54:53 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so35005f8f.3
 for <ltp@lists.linux.it>; Mon, 24 Mar 2025 20:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742874893; x=1743479693; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IqXCTJA35jHzx+x9cf6oDJzXnk+sdLMufcZjBPJmvBo=;
 b=Ku0xtDk1BmlXxn1A3lh7kOG5XxRm2WAesnUIhOX3ltywVUQdE00BKNBJdTDHaZVss8
 PEAp4u4uMXo0ANby1Mla92e1bUz8GQuaxMJ4aJk2/C8IOJuCARAnrQO1MrrnCcf3F2Tq
 +OeESEK4s5swDkLi/oYWX5/2gPNZuoTswFcT9Xm12S3sP4Dq/3aPVz8/FpCkT4JXOVzR
 VQNVdr9/os4xkuTgj160qYqKZ/s68F4zFClW8kT4bfrUOPxp4/pgekQLUywga/bGb38T
 vrTwqXw/nKnht6AoW1rLxqL01ViDtb8K2fs67c/dUuvoYvx4Yz2HQHrL9MyZVXr86Nxi
 FQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742874893; x=1743479693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IqXCTJA35jHzx+x9cf6oDJzXnk+sdLMufcZjBPJmvBo=;
 b=uhst+DIIZooEu/AQvfqW6r7Y4Poi/jYPptXllQydrRSBrk/coROmV6JI9Xgh1jQ2Om
 YVhWG4YOi+Dvyn55M0ZnYEe8UiO+GAj+ZQyY6HX2R8AiPHXSm1Lo7+EXXP6OYrmBore4
 T9HzxQ7NLusRUpVSr+fm9VVSLyKbFO+eRrYi3BT7pjocW+N4xVlIf8WTHzFuYvn2xnCw
 cQ6r73/Sqsem+SQgXYCu7DtoQpVjzaQxFXGNT7teylJZXMTD2V8rrqMJ2m0cnHAxTjpN
 nErNYN6cSWzFBHOkurSazO+UMOl23puO8/yU5PsSWHTMRnf4zJWzuAAe4BbBYF613l13
 qDmQ==
X-Gm-Message-State: AOJu0YyYXFn2MWcXcTcPeG0cIHvijyg0DfrOWZwyMrnJgI2FvdUpoPC2
 XXqI3qQ40IcIrvm7lUrhVYvzr+yHy5PthACq5vrbLvlofFPZgrGPzHEI2TCY11WIdmYvNeiBAq9
 feQWv8RR4dLGRFoLxSorclPMlHM4BbROz1XQHlF/FjGdMJqqc4iYI
X-Gm-Gg: ASbGnctI3qqPtqHl1JdM5Num0MwCMmfcD9RnUEE00dUXds3mWuxJ+4ftuPdrq4cb+9m
 fqraDgZ7u0OzB2eLK7hMNEEUF+rtuhA10oz9fgjuJhxFUG3lhu3pCm0S5uJt8xrZoHdDMHbD4HY
 +JcWl3UD6JlHDNrgLWcRSXrNaUzrjRbHGZQrGHcyA7u58xG+b1Bz68Im0=
X-Google-Smtp-Source: AGHT+IGtgesHTD6YPhu2lrsznvHEttuqll5flywm3FFjCSNSqL/kYkqu20wlc6BZV27Mu508H9849UEi13FEcGw/aWA=
X-Received: by 2002:a05:6000:4014:b0:391:2d61:4561 with SMTP id
 ffacd0b85a97d-3997f8f9178mr11189304f8f.6.1742874893134; Mon, 24 Mar 2025
 20:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-3-wegao@suse.com> <20250324153252.GB251879@pevik>
 <Z+Ij0gSOYnsJ+pio@wegao>
In-Reply-To: <Z+Ij0gSOYnsJ+pio@wegao>
Date: Tue, 25 Mar 2025 11:54:41 +0800
X-Gm-Features: AQ5f1Jrk9YyddmY60YI16E4GaVsmH_wUkhHpaaOydrrUF--2lrgg2iKELXITdXQ
Message-ID: <CAJs-1pWXhJJ0i2NLJtia5vuv+fScZsggcOD0nK_rQXrVAtqy6g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 2/2] cpuset_memory_testset.sh: Remove test6
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0cgoKR290IGl0LCBjdXJyZW50bHkgdGhlIHJlYXNvbiBmb3IgcHJldmlvdXMgY29tbWl0
IGNoYW5nZSBpcyB2NidzIGNvbW1lbnRzCmZyb20gQ3lyaWwuCgp2NjoKaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDI1MDMwNTA1MDgwNS43OTA1LTItd2Vn
YW9Ac3VzZS5jb20vCkNoYW5nZXMgdjYtdjc6Ciogc2VsZWN0IG5vZGUgZnJvbSBub2RlbWFwIHdo
aWNoIGdvdCBpbiBzZXR1cCgpCiogcmVtb3ZlIHVubmVjZXNzYXJ5IHN0ZXAgc3VjaCBhcyBsb2Nr
aW5nIHByb2Nlc3MgdG8gbm9kZTAgYW5kCnNjaGVkdV9sb2FkX2JhbGFuY2Ugc2V0dGluZwoqIGNo
YW5nZSBhbGxvY2F0ZSBtZW1vcnkgdG8gc2luZ2xlIHBhZ2UKKiByZW1vdmUgY2hlY2twb2ludAoK
VGhhbmtzLgpSZWdhcmRzCkdhbyBXZWkKCk9uIFR1ZSwgTWFyIDI1LCAyMDI1IGF0IDExOjMy4oCv
QU0gV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+IHdyb3RlOgoKPiBPbiBNb24sIE1hciAyNCwgMjAy
NSBhdCAwNDozMjo1MlBNICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gSGkgV2VpLAo+ID4K
PiA+IGl0J3MgaGVscGZ1bCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gd3JpdGUgKnRoZSByZWFz
b24qIHdoeSBkb2luZwo+IGNoYW5nZS4KPiA+IFRoZXJlIHNob3VsZCBiZSBhIG5vdGUgdGhhdCBD
IHRlc3QgaW4gdGhlIHByZXZpb3VzIGNvbW1pdCBpbXBsZW1lbnRlZAo+IHRoZSB0ZXN0Lgo+ID4K
PiBHb3QgaXQsIHRoZSBwcmV2aW91cyBjb21taXQgY2hhbmdlIG1haW5seSBiYXNlIEN5cmlsIHY2
J3MgZmVlZGJhY2suCj4gPiBBbHNvIGdlbmVyYWxseSBpdCBoZWxwcyBhIHJldmlldyBwcm9jZXNz
IGlmIHlvdSBhZGQgYSBjaGFuZ2Vsb2cgd2hhdAo+IGNoYW5nZWQgaW4KPiA+IHRoZSBwcmV2aW91
cyB2ZXJzaW9uLgo+IFRoYW5rcyBmb3IgcG9pbnQgdGhpcyBvdXQuCj4KPiB2NjoKPiBodHRwczov
L3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL3BhdGNoLzIwMjUwMzA1MDUwODA1Ljc5
MDUtMi13ZWdhb0BzdXNlLmNvbS8KPiBDaGFuZ2VzIHY2LXY3Ogo+ICogY2hvb3NlIGEgbm9kZSBm
cm9tIHRoZSBub2RlbWFwIHdoaWNoIGdldCBmcm9tIHNldHVwIGluc3RlYWQgb2YgdXNpbmcKPiBo
YXJkY29kZSBub2RlMAo+ICogcmVtb3ZlIHVubmVjZXNzYXJ5IHN0ZXBzIHN1Y2ggYXMgbG9ja2lu
ZyBwcm9jZXNzIGludG8gc3BlY2lmaWMgbm9kZSBhbmQKPiBzY2hlZF9sb2FkX2JhbGFuY2UKPiAq
IHVwZGF0ZSBhbGxvY2F0ZSBtZW1vcnkgc2l6ZSB0byBzaW5nbGUgcGFnZQo+ICogcmVtb3ZlIHVu
bmVjZXNzYXJ5IGNoZWNrcG9pbnRzCj4KPgo+ID4KPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIK
PgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
