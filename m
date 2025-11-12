Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7BDCD1297
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762958468; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/B0ubDL2ucodMbQgMe2F8IvRKKVgy9R+x7Ex4LQB6Kg=;
 b=g0WqgCg9GVYo7rBfnAvcmJv/c1duHXJ8ropYmYlwUfjX1nUNuVBPD9+4eXVvvP6GKZp97
 GS0du0IM+hTSykYG8Bsde0tawQrgy3NMx6uuzVZoLfksjJ/URpjmaRqRv2puCWDNUaJWll9
 844EbFwvY9maeDrZQKVgltaeVuIVFLk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DA833CF79E
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 15:41:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99CD03CF774
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:40:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB2BC1A006BA
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762958444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1lrTrKiyDEmDMv0CKGB4HLASS+74BWWNFw3Kx3MUTA=;
 b=EIopClkKZCTujsHMWLTDe9DsQiNgW0a6v/DsX6BqtojAjy4K8XUBO0g9THMmFOv/7KjhR+
 /r0ez37AWHdv//CptUp363pxJruJie2u3HV9CYJ0bkQuTUE7nUe+CvSXH65stDlI0TXZUy
 AXCGiXcHEyrzv87fzjA/E8ggBkCg9LE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-jQjnSIlxOzKCzHcE86g9lg-1; Wed, 12 Nov 2025 09:40:42 -0500
X-MC-Unique: jQjnSIlxOzKCzHcE86g9lg-1
X-Mimecast-MFC-AGG-ID: jQjnSIlxOzKCzHcE86g9lg_1762958442
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-88249865db8so19881306d6.0
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 06:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762958442; x=1763563242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1lrTrKiyDEmDMv0CKGB4HLASS+74BWWNFw3Kx3MUTA=;
 b=gp+67bUnrdTmH9/5FcN0d7NKVWc0I1ZszkO+1eiB4u1G71BcGUg9h7a57OwiBVNGTI
 teQb8ihCBuK4xJur+xolfQfO810RuwKmJwhpZ6oKwX5z74tWzSnDMA/Ub+a4o1BLFnKH
 iLAAc6LM6aEq3uX6+My3C1G8yJa05NShA/n2c/XRANHl0rYZWQcbxFKZPj2BnNUflicy
 2qj3cXVRr6tqzKVwIhwcAz32AeDCMAakUcyUAi2IVamLkhVURGcR+3z7sszrtjiBig1r
 ZxeoZxEviJnQjRIXDgZOlCnQ+b5WYMOrkrLXyuHO7EpASI7myMBWjuSXURSBu0iqKtFV
 urSA==
X-Gm-Message-State: AOJu0Yy17szkt1UAl+8iFoPYPRunsIIsj6cWam1P+9T0lIECqR2r2BcQ
 G5yFCcoFBLI10+ukcekyF1uJS/k5SyzVeBn60bUWuLNTzTmz7cYnvFd/uS4jeFRFTlyotENhpdm
 YVIGYjqIytZX6hQMBhkHZwco7qiEnKFc92LmjYMNau03TNSyPRYn3sGRFTfCZW7cSgApKhK2IGU
 HoUXrg24WhYD5aGy5CUw1Mi9Q03qo=
X-Gm-Gg: ASbGncu4htjvgQNKS77YO8eDVZRMAuFxn2o0TymrvFJGnPQnBrqa+JEnOHVreOGAc3e
 0Ui+BWu78EGu9k8+jdmUN90z5M7l8WzxqEWnrBxLLC34f08+C8Gb2fw0XnEPuy1yA4Y+JYnNSOZ
 RRLuGS9/K/Q3q7CWLao4/ZBOsg8nn97hmfYLMMrnGSg0q6CSiP3ZIw+JAQ
X-Received: by 2002:a05:6214:19c8:b0:882:3654:5768 with SMTP id
 6a1803df08f44-8825e7b208cmr104626156d6.15.1762958441833; 
 Wed, 12 Nov 2025 06:40:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfk4XbVHYWJwF2zgVOhNB7l9mVInsv/HV2I2N7EE/TPiRiDXR9oIwKoLdbWnqtM4TimvxvyMMz6oJuNwotbRc=
X-Received: by 2002:a05:6214:19c8:b0:882:3654:5768 with SMTP id
 6a1803df08f44-8825e7b208cmr104625786d6.15.1762958441453; Wed, 12 Nov 2025
 06:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20251111153453.547195-1-sbertram@redhat.com>
 <CAEemH2cQam9tOeQj_4SdvoYG5ZNmar6Quc5M6mtr==2-HQR9yQ@mail.gmail.com>
In-Reply-To: <CAEemH2cQam9tOeQj_4SdvoYG5ZNmar6Quc5M6mtr==2-HQR9yQ@mail.gmail.com>
Date: Wed, 12 Nov 2025 09:40:30 -0500
X-Gm-Features: AWmQ_bnrLiYQErDDBF6mgxEVRtsUza8Kusg-xYRTnLD2wgxguJiz8-G7P8WRHcA
Message-ID: <CAD_=S2kXBpaLiFQc_EXCKY5+UrJ0B7HqBX08V098HxH13PidUQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k--yTcpyKLNKFrEUkVjXelYT1YksoEoN194cN_ZoopY_1762958442
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] Confirming EPERM is returned when
 CAP_SYS_ADMIN is removed from clone3. Signed-off-by: Stephen Bertram
 <sbertram@redhat.com>
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgpPbiBXZWQsIE5vdiAxMiwgMjAyNSBhdCA1OjM04oCvQU0gTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+IHdyb3RlOgoKPiBIaSBTdGVwaGVuLAo+Cj4gQWNjb3JkaW5nIHRvIHRoZSBj
bG9uZTMoKSBtYW51YWwgcGFnZToKPgo+ICAgICAgICAiRVBFUk0gIENMT05FX05FV0NHUk9VUCwg
Q0xPTkVfTkVXSVBDLCBDTE9ORV9ORVdORVQsIENMT05FX05FV05TLAo+IENMT05FX05FV1BJRCwg
b3IgQ0xPTkVfTkVXVVRTIHdhcyBzcGVjaWZpZWQgYnkgYW4gdW5wcml2aWxlZ2VkIHByb2Nlc3MK
PiAocHJvY2VzcyB3aXRob3V0IENBUF9TWVNfQURNSU4pLgo+CkkgbWlzLWludGVycHJldGVkIHRo
aXMgYW5kIHRob3VnaHQgaXQgaXMgb25seSBmb3IgY2xvbmUzLCB3aWxsIGFkZCBhIHRlc3QKZm9y
IGNsb25lIGFzIHdlbGwuCgo+Cj4gICAgICAgIEVQRVJNIChjbG9uZTMoKSBvbmx5KQo+ICAgICAg
ICAgICAgICAgc2V0X3RpZF9zaXplIHdhcyBncmVhdGVyIHRoYW4gemVybywgYW5kIHRoZSBjYWxs
ZXIgbGFja3MgdGhlCj4gQ0FQX1NZU19BRE1JTiBjYXBhYmlsaXR5IGluIG9uZSBvciBtb3JlIG9m
IHRoZSB1c2VyIG5hbWVzcGFjZXMgdGhhdCBvd24gdGhlCj4gY29ycmVzcG9uZGluZyBQSUQgbmFt
ZXNwYWNlcy4iCj4KPgo+IFNob3VsZG4ndCB3ZSBzZXBhcmF0ZWx5IHRlc3QgYm90aD8gSW4geW91
ciB0ZXN0LCB3ZSBkb24ndCBrbm93IHRoZSBFUEVSTQo+ClNlZSBzZXR1cAphcmdzLnNldF90aWRf
c2l6ZSA9IDQ7ICAvLyBHcmVhdGVyIHRoYW4gemVybyAtIHJlcXVpcmVzIENBUF9TWVNfQURNSU4K
Cj4gY29tZXMgZnJvbSAic2V0X3RpZF9zaXplPjAiIChvciBDTE9ORV9ORVcqKSB3aXRoIG5vIENB
UF9TWVNfQURNSU4uCj4KVGhhdCBpcyBleGFjdGx5IHdoYXQgdGhpcyB0ZXN0IGRvZXMuCiBTZWUg
cnVuIHJlc3VsdHM6Cgo+IFtyb290QGxvY2FsaG9zdCBjbG9uZTNdIyAuL2Nsb25lMzA0Cj4gdHN0
X3Rlc3QuYzoyMDI1OiBUSU5GTzogTFRQIHZlcnNpb246IDIwMjUwOTMwCj4gdHN0X3Rlc3QuYzoy
MDI4OiBUSU5GTzogVGVzdGVkIGtlcm5lbDogNi4xMi4wLXh4eC54eHguYWFyY2g2NCAjMSBTTVAK
PiBQUkVFTVBUX1JUIE1vbiBOb3YgMTAgMTA6NTY6MjcgRVNUIDIwMjUgYWFyY2g2NAo+IHRzdF9r
Y29uZmlnLmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25maWcgJy9wcm9jL2NvbmZpZy5n
eicKPiB0c3RfdGVzdC5jOjE4NDY6IFRJTkZPOiBPdmVyYWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAw
aCAwMG0gMzBzCj4KPiAqdHN0X2NhcGFiaWxpdHkuYzoyOTogVElORk86IERyb3BwaW5nIENBUF9T
WVNfQURNSU4oMjEpKmNsb25lMzA0LmM6Mzc6Cj4gVFBBU1M6IGNsb25lMyhDTE9ORV9ORVdQSUQp
IHNob3VsZCBmYWlsIHdpdGggRVBFUk0gOiBFUEVSTSAoMSkKPiBjbG9uZTMwNC5jOjM3OiBUUEFT
UzogY2xvbmUzKENMT05FX05FV0NHUk9VUCkgc2hvdWxkIGZhaWwgd2l0aCBFUEVSTSA6Cj4gRVBF
Uk0gKDEpCj4gY2xvbmUzMDQuYzozNzogVFBBU1M6IGNsb25lMyhDTE9ORV9ORVdJUEMpIHNob3Vs
ZCBmYWlsIHdpdGggRVBFUk0gOiBFUEVSTQo+ICgxKQo+IGNsb25lMzA0LmM6Mzc6IFRQQVNTOiBj
bG9uZTMoQ0xPTkVfTkVXTkVUKSBzaG91bGQgZmFpbCB3aXRoIEVQRVJNIDogRVBFUk0KPiAoMSkK
PiBjbG9uZTMwNC5jOjM3OiBUUEFTUzogY2xvbmUzKENMT05FX05FV05TKSBzaG91bGQgZmFpbCB3
aXRoIEVQRVJNIDogRVBFUk0KPiAoMSkKPiBjbG9uZTMwNC5jOjM3OiBUUEFTUzogY2xvbmUzKENM
T05FX05FV1VUUykgc2hvdWxkIGZhaWwgd2l0aCBFUEVSTSA6IEVQRVJNCj4gKDEpCgoKU3VtbWFy
eToKPiBwYXNzZWQgICA2Cj4gZmFpbGVkICAgMAo+IGJyb2tlbiAgIDAKPiBza2lwcGVkICAwCj4g
d2FybmluZ3MgMAoKTGV0IG1lIGtub3cgaWYgSSBtaXNzZWQgYW55dGhpbmcuCgpIaSBDeXJpbCBh
bmQgQW5kcmVhLAoKSSByZWNlaXZlZCB5b3VyIGlucHV0IGFuZCBJIHdpbGwgbWFrZSB1cGRhdGVz
IGFjY29yZGluZ2x5LgoKVGhhbmsgeW91IGFsbCwKCnN0ZXBoZW4KCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
