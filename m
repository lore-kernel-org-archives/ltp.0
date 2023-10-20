Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809E2C001DF
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 03:05:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54F453CFC49
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 05:05:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28B9F3CB188
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 05:05:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E1B4B200092
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 05:05:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697771112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QS7VdX8r0qsXXnqqhUnVhJq1Tbc6+ZshYjbIXxXywDo=;
 b=UkQP/r+/G9EV/HDjNs1oCsR9VwQKyA8+GsQUM1IKrPyT4xfQPrf9LR4j9xD0jIyPO4ukM/
 Mh//KcybYVY4A191YTJOuRyHRnWwN0LAP62mi8L/nWtif+3pBYDiZZA6vtas8haEywJJQO
 Zb/WZiKeX8f2U3ssiOwh28+P9pKEH/U=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-1E0fLfgAMTW4UK89ntKTEg-1; Thu, 19 Oct 2023 23:05:08 -0400
X-MC-Unique: 1E0fLfgAMTW4UK89ntKTEg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079fd9754cso307402e87.0
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 20:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697771107; x=1698375907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QS7VdX8r0qsXXnqqhUnVhJq1Tbc6+ZshYjbIXxXywDo=;
 b=tMpmgdUg4qv1e0B/FWCDiwy5IVw//wVQBlgqeNSjkfKaBvnmR6ToBAcKdwN6NYWrEe
 3SyDRBWh16qqVlQgUW2Nku4jYh2mtxnvJ1yYblVlKpsRdjx60FgoBfujx3vOWD4Wt7x/
 JxtPqcA3r1YD9Bixt7kAqkQFXIDVx45Pjj+VZYXzFYMMInerIcMXITDAYRIXQ0f6l6R7
 POUY6q4kw8/i0RmZYqB7TfPNHAee7K3v86iaMyYVMy9MBWOnnaDyeHBxPo4AVQ6FIFNf
 jeIybJHKc1J0prHXE7rAAuXOgnHWJWshLv9jt4kq2M+Tosgv43tVYOkno01eMLmfX2/n
 ZVfw==
X-Gm-Message-State: AOJu0YzY+xxAkAg/9uPQqEnShXPXyYF5v/tMo6X1DkIlvFuB/MR8+Jsb
 THieyOg6SpMTlV2hb7dJDswnJAvpgO3o7l65/+FTHXETBRIYsx4G4SfK4EJhZ9M4ZNFE8ocOtOV
 du/bArugUzDVSwyrngRFZGQbvDMQ=
X-Received: by 2002:a05:6512:e95:b0:503:221:6b1a with SMTP id
 bi21-20020a0565120e9500b0050302216b1amr366879lfb.0.1697771107237; 
 Thu, 19 Oct 2023 20:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZpa4K4gcWxG4V/cojTyi32jSfPCu/rOwtlL06igtPS7yhMvB0Uxk67TEfLdvkjvOg4hJDFOldP9fbA8tguyo=
X-Received: by 2002:a05:6512:e95:b0:503:221:6b1a with SMTP id
 bi21-20020a0565120e9500b0050302216b1amr366868lfb.0.1697771106840; Thu, 19 Oct
 2023 20:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <875y33vsks.fsf@suse.de>
In-Reply-To: <875y33vsks.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Oct 2023 11:04:55 +0800
Message-ID: <CAEemH2fvE0z4zDfbKEG0Vj60cVZ1v5MuA9iSDZGMPHzMw8amtA@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC] LTP open monthly meeting
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBPY3QgMTksIDIwMjMgYXQgNjowMuKAr1BNIFJpY2hhcmQgUGFsZXRob3JwZSA8cnBh
bGV0aG9ycGVAc3VzZS5kZT4Kd3JvdGU6Cgo+IEhlbGxvLAo+Cj4gSSBwcm9wb3NlIGEgbWVldGlu
ZyBvbmNlIGEgbW9udGggdG8gZGlzY3VzcyBub24tdGVjaG5pY2FsIHRoaW5ncyBzdWNoIGFzCj4g
cGF0Y2ggcmV2aWV3IHBvbGljeSwgb3ZlcmFsbCBkaXJlY3Rpb24gYW5kIGJpa2Ugc2hlZCBkaXNj
dXNzaW9ucy4gQW55b25lCj4gaXMgd2VsY29tZSB3aG8gaXMgaW50ZXJlc3RlZCBpbiB0aGF0Lgo+
Cj4gT3JpZ2luYWxseSBJIHRob3VnaHQganVzdCB0byBpbmNsdWRlIG15c2VsZiBhbmQgc29tZSBT
VVNFIGNvbGxlYWd1ZXMgaW4KPiBhbiBhZC1ob2MgbWVldGluZyB0byBkZWFsIHdpdGggUmV2aWV3
ZWQtYnkgdGFnIGRlbGVnYXRpb24uIEhvd2V2ZXIgSQo+IHRoaW5rIHRoZSByZWFsIHByb2JsZW0g
aXMgd2UgaGF2ZSBubyBMVFAgbWVldGluZyBpbiB3aGljaCB0byBkaXNjdXNzCj4gdGhlc2UgdGhp
bmdzIGFuZCBjaGF0LiBUaGUgTUwgaXMgbm90IGFkZXF1YXRlIGZvciB0aGlzIElNTy4KPgo+IEZv
ciBtZSBhbnkgdGltZSBhbmQgZGF5IHdvdWxkIGJlIGZpbmUgZXhjbHVkaW5nIDIyOjAwIHRvIDA5
OjAwCj4gVVRDL0dNVC4gUHJvYmFibHkgTW9uZGF5IHRvIEZyaWRheSB3b3VsZCBiZSBiZXN0IGZv
ciBtb3N0Lgo+CgorMQoKRm9yIG1lIGlzIChVVEMgKyA4OjAwKSBhdmFpbGFibGUsIEkgdGhpbmsg
aXQgc2hvdWxkIGJlIGZpbmUsCkkgYWx3YXlzIG1lZXQgd2l0aCBFdXJvcGVhbiBjb2xsZWFndWVz
IG9ubGluZS4gQnV0IEkgd291bGQKbWFyayB0aGF0IGFzIG9wdGlvbmFsIHRvIG1lLCB0byBhdm9p
ZCBjb25mbGljdCB3aXRoIG90aGVyIGFjdGl2aXRpZXMuCgpCdHcsIHNob3VsZCB3ZSBjcmVhdGUg
YSBjaGFubmVsIHRvIHRhbGsgaW4gdHlwZSBmaXJzdD8KCkkgaGF2ZSBkcm9wcGVkIHVzZSBJUkMg
Zm9yIGEgcGVyaW9kIG9mIHRpbWUsIG1heWJlIGEgY2hhbm5lbAp3aXRoIGNoYXQgaGlzdG9yeSB3
b3VsZCBiZSBiZXR0ZXIuIGUuZy4gU2xhY2sgb3IgZ29vZ2xlY2hhdC4KCgoKPgo+IFRoZSBhZ2Vu
ZGEgZm9yIHRoZSBmaXJzdCBtZWV0aW5nIHdvdWxkIGJlIHRvIGRpc2N1c3MgaG93IHRvIGRlYWwg
d2l0aAo+IHRoZSBzaXR1YXRpb24gd2hlcmUgc29tZW9uZSByZXZpZXdzIHRoZSBWMSBvZiBhIHBh
dGNoLCBidXQgZG9lcyBub3QgYWRkCj4gdGhlaXIgUmV2aWV3ZWQtYnkgdGFnIGluIHN1YnNlcXVl
bnQgdmVyc2lvbnMuCj4KPiBBZnRlciB0aGF0IGp1c3QgaW50cm9kdWN0aW9ucywgcXVlc3Rpb25z
IGFuZCBhbnl0aGluZyBzb21lb25lIHdvdWxkIGxpa2UKPiB0byBicmluZyB1cC4KPgo+IC0tCj4g
VGhhbmsgeW91LAo+IFJpY2hhcmQuCj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
