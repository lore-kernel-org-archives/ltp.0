Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE782EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 08:35:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02D9E3CB041
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 10:35:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17F7D3CAC32
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:35:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A31C46001B2
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 10:35:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687250103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vHGpNeCGhP2FfWRJntqvPF9MJGyna2NYv59QhoAG01E=;
 b=WFPuN8tLkDni+UaLi1cqslMtUmoKRy+ppnY/l75O/63Fq3LG9rp6lB0sJ4ky9MUdoRkZCY
 I4rEzJDokITtKWIGGLn0noYne/7NYI4IVj+AbWOX/sPu8nyXjwOTEBYggcglvd6O7yKWwy
 kK72kOa9IwUxiKM/INO1l7H0yHvc4lc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-QPjsqjbSNgaPZ74unxaQew-1; Tue, 20 Jun 2023 04:35:00 -0400
X-MC-Unique: QPjsqjbSNgaPZ74unxaQew-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b341f911acso20465071fa.1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 01:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687250098; x=1689842098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHGpNeCGhP2FfWRJntqvPF9MJGyna2NYv59QhoAG01E=;
 b=KN8zdc/GlZBj30/qM14N6NONvV0okORhrsNrtZa6aVQh/k2eKsWta/yzsKt54MxQIS
 usPVFwEhwqHwI6VmsqcfGCCfy369m3OvPOL6EQTRK+2SfqNiK13RppcpyrxpmhlpuzcZ
 z/NPWvGxffFGV45wTSsCfq2ODxkkcIBH5Qv0odC7vR+Zyq67N48mjPzr0lMe4TWrOZWV
 aUVqjXHtWrOwqoFS4cy1Z2XHb2lIJg5kZW0bYuLlAQlB75OrzIjsZsr/oIsDqeLPPAaU
 e12FCZWENctdm4iEQm9MrMJLqBh04zVF3Tca4tEnCS8ENFV4eB3GN69kp85kqQMOIrHf
 NRCw==
X-Gm-Message-State: AC+VfDxOBrbcWNCGTcQCY3C4yZtcODmI2q1AYf1DeD3Tvv8KIgWMjLfK
 JhomIIbU+iBehStS1UktM28kpDI8KMkDBRb5ti0peqcf6wY52CDNwN/+akjWh2QIe32sbCGH8i1
 AKymctAc5OFuVOms3keO/CtLKv9MLtpzgs0IZ3HAC
X-Received: by 2002:a2e:b532:0:b0:2b4:5c28:908a with SMTP id
 z18-20020a2eb532000000b002b45c28908amr3857928ljm.7.1687250098470; 
 Tue, 20 Jun 2023 01:34:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+qpwUbeg8DBrV5wxojdlX7ygAIbPELp1FduGnoXRq9Sp/BecU186heaJTYc6P16a2e95pvwCx4CC1W8c2F7U=
X-Received: by 2002:a2e:b532:0:b0:2b4:5c28:908a with SMTP id
 z18-20020a2eb532000000b002b45c28908amr3857919ljm.7.1687250098109; Tue, 20 Jun
 2023 01:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
In-Reply-To: <80595ab205ea7b3f633bf4228bb43ee999aef3a1.1687247273.git.souta.kawahara@miraclelinux.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Jun 2023 16:34:46 +0800
Message-ID: <CAEemH2doFsjjQwDA2P_-_vDrFSBtNoCXLXh3U__3W6jED4mhTw@mail.gmail.com>
To: Souta Kawahara <souta.kawahara@miraclelinux.com>,
 Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/1] runtest/cve: Add some existing CVE tests
 to runtest file
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU291dGEgYW5kIEN5cmlsLAoKT24gVHVlLCBKdW4gMjAsIDIwMjMgYXQgNDoxM+KAr1BNIFNv
dXRhIEthd2FoYXJhIDwKc291dGEua2F3YWhhcmFAbWlyYWNsZWxpbnV4LmNvbT4gd3JvdGU6Cgo+
IFNpZ25lZC1vZmYtYnk6IFNvdXRhIEthd2FoYXJhIDxzb3V0YS5rYXdhaGFyYUBtaXJhY2xlbGlu
dXguY29tPgo+IC0tLQo+ICBydW50ZXN0L2N2ZSB8IDEzICsrKysrKysrKysrKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9ydW50ZXN0L2N2ZSBi
L3J1bnRlc3QvY3ZlCj4gaW5kZXggZjlhNDQ5ZmU3Li5hYTEwMDkzYzAgMTAwNjQ0Cj4gLS0tIGEv
cnVudGVzdC9jdmUKPiArKysgYi9ydW50ZXN0L2N2ZQo+IEBAIC0xOSwxMSArMTksMTMgQEAgY3Zl
LTIwMTYtMTAwNDQgY3ZlLTIwMTYtMTAwNDQKPiAgY3ZlLTIwMTctMjYxOCBjdmUtMjAxNy0yNjE4
Cj4gIGN2ZS0yMDE3LTI2MzYgcHR5MDUKPiAgY3ZlLTIwMTctMjY3MSBjdmUtMjAxNy0yNjcxCj4g
K2N2ZS0yMDE3LTU2Njkgc2htYXQwMwo+CgpUaGlzIG9uZSBsb29rcyBsaWtlIGJlaW5nIGRyb3Bw
ZWQgZnJvbSB0aGUgQ1ZFIGxpc3QgcHVycG9zZWx5LAphY2NvcmRpbmcgdG86Cgpjb21taXQgMjU4
OGRhZmQ0NjUxNzA2ZWQ3YWUzNGFlM2I3NDRiMGVlOGNkNjM4NApBdXRob3I6IEN5cmlsIEhydWJp
cyA8Y2hydWJpc0BzdXNlLmN6PgpEYXRlOiAgIFdlZCBBdWcgMTQgMTQ6MTM6MjggMjAxOSArMDIw
MAoKICAgIHN5c2NhbGxzL3NobWF0MDM6IFJlbW92ZSBpdCBmcm9tIHJ1bnRlc3QvY3ZlCgogICAg
VGhlIG9yaWdpbmFsIFBPQ1sxXSBhbmQgQ1ZFLTIwMTctNTY2OSBhcmUgbm90IHRlc3RlZCBieSB0
aGlzIHRlc3QKICAgIGFueW1vcmUgYXMgaXQgdHVybmVkIG91dCB0aGF0IHRoZSBDVkUgd2FzIGJv
Z3VzLiBTZWU6CgogICAgaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbW0mbT0xNTI1MTA5Nzgx
MjM3NTUmdz0yCgogICAgQW5kIHRoZSB0ZXN0IGJlY2FtZSByZWdyZXNzaW9uIHRlc3QgZm9yOgoK
ICAgIGNvbW1pdCA4Zjg5YzAwN2I2ZGVjMTZhMTc5M2NiODhkZTg4ZmNjMDIxMTdiYmJjCiAgICBB
dXRob3I6IERhdmlkbG9ociBCdWVzbyA8ZGF2ZUBzdGdvbGFicy5uZXQ+CiAgICBEYXRlOiAgIEZy
aSBNYXkgMjUgMTQ6NDc6MzAgMjAxOCAtMDcwMAoKICAgICAgICBpcGMvc2htOiBmaXggc2htYXQo
KSBuaWwgYWRkcmVzcyBhZnRlciByb3VuZC1kb3duIHdoZW4gcmVtYXBwaW5nCgogICAgSGVuY2Ug
d2Ugd2lsbCBrZWVwIHRoZSB0ZXN0IGJ1dCByZW1vdmUgaXQgZnJvbSB0aGUgQ1ZFIHJ1bnRlc3Qg
ZmlsZSBhbmQKYWRqdXN0CiAgICB0aGUgdG9wIGxldmVsIGNvbW1lbnQgaW4gdGhlIHRlc3QgY29k
ZS4KCiAgICBbMV0gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL2F0dGFjaG1lbnQuY2dpP2lk
PTI1MjUxMQogICAgICAgIGZyb20gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0xOTI5MzEKCiBjdmUtMjAxNy01NzU0IG1lbHRkb3duCj4gIGN2ZS0yMDE3LTY5NTEg
cmVxdWVzdF9rZXkwNQo+ICBjdmUtMjAxNy03MzA4IHNldHNvY2tvcHQwMgo+ICBjdmUtMjAxNy03
NDcyIGtleWN0bDA0Cj4gIGN2ZS0yMDE3LTc2MTYgc2V0X21lbXBvbGljeTA1Cj4gK2N2ZS0yMDE3
LTg4OTAgYWNjZXB0MDIKPiAgY3ZlLTIwMTctMTA2NjEgdGltZXJmZF9zZXR0aW1lMDIKPiAgY3Zl
LTIwMTctMTIxOTIga2V5Y3RsMDcKPiAgY3ZlLTIwMTctMTIxOTMgYWRkX2tleTA0Cj4gQEAgLTQx
LDE2ICs0MywxOSBAQCBjdmUtMjAxNy0xNzgwNSBhZl9hbGcwMgo+ICBjdmUtMjAxNy0xNzgwNiBh
Zl9hbGcwMQo+ICBjdmUtMjAxNy0xNzgwNyByZXF1ZXN0X2tleTA0Cj4gIGN2ZS0yMDE3LTE4MDc1
IHBjcnlwdF9hZWFkMDEKPiArY3ZlLTIwMTctMTgzNDQgdGltZXJfY3JlYXRlMDMKPiAgY3ZlLTIw
MTctMTAwMDExMSBzZXRzb2Nrb3B0MDcKPiAgY3ZlLTIwMTctMTAwMDExMiBzZXRzb2Nrb3B0MDUK
PiAgY3ZlLTIwMTctMTAwMDM2NCBzdGFja19jbGFzaAo+ICBjdmUtMjAxNy0xMDAwMzgwIHNuZF90
aW1lcjAxCj4gIGN2ZS0yMDE3LTEwMDA0MDUgdGhwMDQKPiAgY3ZlLTIwMTgtNTgwMyBzY3RwX2Jp
Z19jaHVuawo+ICtjdmUtMjAxOC02OTI3IGZ1dGV4X2NtcF9yZXF1ZXVlMDIKPiAgY3ZlLTIwMTgt
NzU2NiBzbmRfc2VxMDEKPiAgY3ZlLTIwMTgtODg5NyBwdHJhY2UwOQo+ICBjdmUtMjAxOC05NTY4
IGNvbm5lY3QwMgo+ICBjdmUtMjAxOC0xMDEyNCBraWxsMTMKPiArY3ZlLTIwMTgtMTE1MDggYWRq
dGltZXgwMwo+ICBjdmUtMjAxOC0xMjg5NiB0aW1lcl9zZXR0aW1lMDMKPiAgY3ZlLTIwMTgtMTM0
MDUgY3JlYXQwOQo+ICBjdmUtMjAxOC0xODQ0NSBicGZfcHJvZzA0Cj4gQEAgLTY2LDE1ICs3MSwy
MyBAQCBjdmUtMjAyMC0xNDM4NiBzZW5kdG8wMwo+ICBjdmUtMjAyMC0xNDQxNiBwdHkwMwo+ICBj
dmUtMjAyMC0yNTcwNSBpY21wX3JhdGVfbGltaXQwMQo+ICBjdmUtMjAyMC0yOTM3MyBpb191cmlu
ZzAyCj4gK2N2ZS0yMDIwLTM2NTU3IHB0eTA2Cj4gIGN2ZS0yMDIxLTM0NDQgYnBmX3Byb2cwNQo+
ICBjdmUtMjAyMS0zNjA5IGNhbl9iY20wMQo+ICtjdmUtMjAyMS0zNjUzIGt2bV9zdm0wMQo+ICtj
dmUtMjAyMS0zNjU2IGt2bV9zdm0wMgo+ICBjdmUtMjAyMS00MDM0IGV4ZWN2ZTA2Cj4gK2N2ZS0y
MDIxLTQxOTdfMSBjZ3JvdXBfY29yZTAxCj4gK2N2ZS0yMDIxLTQxOTdfMiBjZ3JvdXBfY29yZTAy
Cj4gK2N2ZS0yMDIxLTQyMDQgYnBmX3Byb2cwNgo+ICBjdmUtMjAyMS0yMjU1NSBzZXRzb2Nrb3B0
MDggLWkgMTAwCj4gIGN2ZS0yMDIxLTI2NzA4IHZzb2NrMDEKPiAgY3ZlLTIwMjEtMjI2MDAgc2V0
c29ja29wdDA5Cj4gK2N2ZS0yMDIxLTM4MTk4IGt2bV9wYWdlZmF1bHQwMQo+ICBjdmUtMjAyMS0z
ODYwNCBtcV9ub3RpZnkwMwo+ICBjdmUtMjAyMi0wODQ3IGRpcnR5cGlwZQo+ICBjdmUtMjAyMi0y
NTkwIGRpcnR5YzB3X3NobWVtCj4gK2N2ZS0yMDIyLTIzMjIyIGJwZl9wcm9nMDcKPiAgIyBUZXN0
cyBiZWxvdyBtYXkgY2F1c2Uga2VybmVsIG1lbW9yeSBsZWFrCj4gIGN2ZS0yMDIwLTI1NzA0IHBl
cmZfZXZlbnRfb3BlbjAzCj4gIGN2ZS0yMDIyLTAxODUgZnNjb25maWcwMwo+IC0tCj4gMi4zMS4x
Cj4KClRoZSByZXN0IHBhcnQgbG9va3MgZ29vZC4KLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
