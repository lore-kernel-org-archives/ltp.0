Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB4BC36013
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 05:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743397602; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hXLFj+HvxHWYRIi7+4yYxJp4h43d5FhB3eA7FBkqhP8=;
 b=gH1mcP2pK6ZiI8LoqOi/Gbpchc4yVPOAwT+/oBvviuSfI5eOqoehRqAkd/0Bljn9smUvK
 zlN7qgJjJ2IzeVHHJ44TMH3nok3VHhCcY5Fxinb7oETLVaxOY3AIdooe/QkO2wB/SxECJmP
 KEzgpICtACZT4dt0UzDnEVGXURl+GoA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580963C073D
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 07:06:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 533133CA846
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 07:06:14 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EB09B60B022
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 07:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743397571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Wh9vNb38xB15jC4CIejQoopJqroCKPr+S+hbXxv/fQ=;
 b=ZSmuMsaFtbMyNbd2k6MnxQfaFlqM9RWJZzNkN0GqpKy29GtY5/yjw0eLg7svWrR6nhfDTa
 rnnPkwYeK8oYWXikg2Y8phJAcETgmhM/J6YX/1udp/IJZ14EZTzzI31EmnLg43ea13SC9s
 lclRBBZRvZFp2+laSppdTSdiZUdkjic=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-BTiUBcWgMJWLavaCCh8U4A-1; Mon, 31 Mar 2025 01:06:08 -0400
X-MC-Unique: BTiUBcWgMJWLavaCCh8U4A-1
X-Mimecast-MFC-AGG-ID: BTiUBcWgMJWLavaCCh8U4A_1743397568
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff53a4754aso10053213a91.2
 for <ltp@lists.linux.it>; Sun, 30 Mar 2025 22:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743397567; x=1744002367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Wh9vNb38xB15jC4CIejQoopJqroCKPr+S+hbXxv/fQ=;
 b=oDaEHhLjiXMPKBC0pWVXYl0lenVLeexwmxw17pyI0M0GPbUsX4jCWD9a5qtKoVj7uk
 I1Hm0LuuUw2LfIxeTDFmMt5wEDwA+sYbUI20ALYglSoJrrCX5yjoq3fSM4tDUi6f5KxG
 PKPBqAZJ1Upj4nl9ttCa9AlKu6UEdgAG0056KiQqdn38tPZS/gNeWuf9JHCDBC9Zwf8t
 xE+4btR/AmGa29bbRyz9tlJNUqWXWO+6Ad6g/+SauPRCU68C9+f+6W8YFwrpwLCXXx31
 DDpyH9dR+OEkvfoImMB5/nVnL+RTwgBi9OX/EnTdgG/cWcUEaVf9dpB+c6CRVufeRVCv
 RfGA==
X-Gm-Message-State: AOJu0YxVhv0lqurvfRkikcHucl1A05xU2J3FcaKCDmHy9NJno+1qtniQ
 i6LDFEs7DjbUpuK9Ed/wbxAiQnwFB3sqUgK6qvapkMiVZX/eUcsYouSQd+a4J4y70GUF/p3BVH5
 2rPYypTOSRYuXKu5SjG9Y8lBQcJ7Qnu1+IoxIkSENOJLamWYo2EwBzEVa7p/BWEYI91xMG0QpQ8
 WeDqI5p7GGf7/cWz6QTdLYKfcEya+dI0RPVdwV
X-Gm-Gg: ASbGncuBwejGxwsvSJNpx91forOFQBo1DNBd5A7INGUqgOwIkxuxvVnYLCsTi0pGWr6
 tUNqvOgLIWe11p3BoIbO07Et6ODLkbkQSpjUtBInSCwg1jAd45VK1OxZoWPIO2qk+vJVXavqiwQ
 ==
X-Received: by 2002:a17:90b:4c0d:b0:2fe:b8ba:62de with SMTP id
 98e67ed59e1d1-3053215e814mr11035497a91.25.1743397566960; 
 Sun, 30 Mar 2025 22:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY1SLk/YrBkFaT7gzPyoelB+8RQuzNPjbS2IYuYov3bDK2rtdm37Hlz8pQGrq/KsZCauTGjss7tQA4of1sdBs=
X-Received: by 2002:a17:90b:4c0d:b0:2fe:b8ba:62de with SMTP id
 98e67ed59e1d1-3053215e814mr11035477a91.25.1743397566691; Sun, 30 Mar 2025
 22:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
 <20250331031945.5948-3-wegao@suse.com>
In-Reply-To: <20250331031945.5948-3-wegao@suse.com>
Date: Mon, 31 Mar 2025 13:05:54 +0800
X-Gm-Features: AQ5f1JpxFWMmaEtKU15-AB-o26B6Anr_gMkBxl6Hob6WVc3BiIPR1bbRkdu0lNM
Message-ID: <CAEemH2eEY4+CxU-LxojL8TY5mi-8FqwYO-ykqQv3n_cBkXTMWw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yJmMg4VoZ-hshZHepGhZOKsRK57YXiha6qL2j59oJxM_1743397568
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v9 2/2] cpuset_memory_testset.sh: Remove test6
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

T24gTW9uLCBNYXIgMzEsIDIwMjUgYXQgMTE6MjDigK9BTSBXZWkgR2FvIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1
c2UuY29tPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKUmV2
aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tLQo+ICAuLi4vY3B1c2V0
X21lbW9yeV90ZXN0c2V0LnNoICAgICAgICAgICAgICAgICAgfCAzNyArLS0tLS0tLS0tLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdAo+IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1
c2V0X21lbW9yeV90ZXN0L2NwdXNldF9tZW1vcnlfdGVzdHNldC5zaAo+IGIvdGVzdGNhc2VzL2tl
cm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV90ZXN0L2NwdXNldF9tZW1vcnlf
dGVzdHNldC5zaAo+IGluZGV4IGMxZTdjZWE4Zi4uZmQ0MWRjOTdhIDEwMDc1NQo+IC0tLQo+IGEv
dGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV90ZXN0L2Nw
dXNldF9tZW1vcnlfdGVzdHNldC5zaAo+ICsrKwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9s
bGVycy9jcHVzZXQvY3B1c2V0X21lbW9yeV90ZXN0L2NwdXNldF9tZW1vcnlfdGVzdHNldC5zaAo+
IEBAIC0xNjIsNDEgKzE2Miw4IEBAIGNoZWNrX2h1Z2V0bGJmcygpCj4KPiAgdGVzdDYoKQo+ICB7
Cj4gLSAgICAgICBjcHVzZXRfc2V0ICIkQ1BVU0VULzAiICIkY3B1X29mX25vZGUwIiAiMCIgIjAi
IDI+Cj4gJENQVVNFVF9UTVAvc3RkZXJyCj4gLSAgICAgICBpZiBbICQ/IC1uZSAwIF07IHRoZW4K
PiAtICAgICAgICAgICAgICAgY3B1c2V0X2xvZ19lcnJvciAkQ1BVU0VUX1RNUC9zdGRlcnIKPiAt
ICAgICAgICAgICAgICAgdHN0X3Jlc20gVEZBSUwgInNldCBnZW5lcmFsIGdyb3VwIHBhcmFtZXRl
ciBmYWlsZWQuIgo+IC0gICAgICAgICAgICAgICByZXR1cm4gMQo+IC0gICAgICAgZmkKPiAtCj4g
LSAgICAgICBjaGVja19odWdldGxiZnMKPiAtICAgICAgIGlmIFsgJD8gLWVxIDAgXTsgdGhlbgo+
IC0gICAgICAgICAgICAgICB0c3RfcmVzbSBUQ09ORiAiVGhpcyBzeXN0ZW0gZG9uJ3Qgc3VwcG9y
dCBodWdldGxiZnMiCj4gLSAgICAgICAgICAgICAgIHJldHVybiAwCj4gLSAgICAgICBmaQo+IC0K
PiAtICAgICAgIG1rZGlyIC9odWdldGxiCj4gLSAgICAgICBtb3VudCAtdCBodWdldGxiZnMgbm9u
ZSAvaHVnZXRsYgo+IC0KPiAtICAgICAgIHNhdmVfbnJfaHVnZXBhZ2VzPSQoY2F0IC9wcm9jL3N5
cy92bS9ucl9odWdlcGFnZXMpCj4gLSAgICAgICBlY2hvICQoKDIqJG5yX21lbXMpKSA+IC9wcm9j
L3N5cy92bS9ucl9odWdlcGFnZXMKPiAtCj4gLSAgICAgICBjcHVzZXRfbWVtb3J5X3Rlc3QgLS1t
bWFwLWZpbGUgLS1odWdlcGFnZSAtcyAkSFVHRVBBR0VTSVpFCj4gPiIkTUVNT1JZX1JFU1VMVCIg
Jgo+IC0gICAgICAgc2ltcGxlX2dldHJlc3VsdCAkISAiJENQVVNFVC8wIgo+IC0KPiAtICAgICAg
IHVtb3VudCAvaHVnZXRsYgo+IC0gICAgICAgcm1kaXIgL2h1Z2V0bGIKPiAtCj4gLSAgICAgICBl
Y2hvICRzYXZlX25yX2h1Z2VwYWdlcyA+IC9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMKPiAtICAg
ICAgIGlmIFsgJChjYXQgL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcykgLW5lICRzYXZlX25yX2h1
Z2VwYWdlcyBdOwo+IHRoZW4KPiAtICAgICAgICAgICAgICAgdHN0X3Jlc20gVEZBSUwgImNhbid0
IHJlc3RvcmUgbnJfaHVnZXBhZ2VzKG5yX2h1Z2VwYWdlcyA9Cj4gJHNhdmVfbnJfaHVnZXBhZ2Vz
KS4iCj4gLSAgICAgICAgICAgICAgIHJldHVybiAxCj4gLSAgICAgICBmaQo+IC0KPiAtICAgICAg
IGlmIFsgIiRub2RlIiAhPSAiMCIgXTsgdGhlbgo+IC0gICAgICAgICAgICAgICB0c3RfcmVzbSBU
RkFJTCAiYWxsb2NhdGUgbWVtb3J5IG9uIHRoZSBOb2RlIyRub2RlKEV4cGVjdDoKPiBOb2RlIzAp
LiIKPiAtICAgICAgICAgICAgICAgcmV0dXJuIDEKPiAtICAgICAgIGZpCj4gKyAgICAgICB0c3Rf
cmVzbSBUSU5GTyAiVGhpcyB0ZXN0IGlzIHJlcGxhY2VkIGJ5Cj4gdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vY3B1c2V0L2NwdXNldDAyLmMiCj4gKyAgICAgICByZXR1cm4gMAo+ICB9Cj4KPiAgdGVzdDco
KQo+IC0tCj4gMi4zNS4zCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
