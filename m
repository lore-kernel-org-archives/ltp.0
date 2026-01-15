Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F44D4115A
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 10:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768471780; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AkBsRJMp3scW3NMeoyfkfTKEZdhRxgWiYNrXlxCpd9g=;
 b=WWGJeRo0BB4fvyxTgldRQ1eLzAbH9hL3wdBxlF1NCokYLO9NPaeB/dS0nMn7jLhRhxqNZ
 lfpi2Eh33eU1x3sxh+9ulZ8DbWFSScIEsfBpjjWSyvTSl4fV2eiKxmhkxmLCxv7innyc4pR
 B4/W+MrCInJ6tcGp19490FdkX+CeR6Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A481B3C9E80
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 11:09:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 638333C9A5F
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:09:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6C56B600839
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 11:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768471749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwjuQSeecfm1P+D7T4Wu8RsKjHbvQPa9HtqtDmZEIYk=;
 b=U2RE35Q/O9UowJbBUYG9mhGQWQWM/c4sH3JFHntd5KiLHAIb29Vli/z2MPV+J3RxDJfCs4
 d7aZULfIku+OV+0FcAXcHCSKPH6y+ROqgfJ/6s8VQAud+3tvlEwYm9Ck1ktzzloRqQ0cvj
 JKE5w2KS22wmxHK73o6q1FzAIhYq8Ig=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-qaOQq7vZNoa3f12QTkFF9g-1; Thu, 15 Jan 2026 05:09:07 -0500
X-MC-Unique: qaOQq7vZNoa3f12QTkFF9g-1
X-Mimecast-MFC-AGG-ID: qaOQq7vZNoa3f12QTkFF9g_1768471747
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b048fc1656so2684853eec.1
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 02:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768471747; x=1769076547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hwjuQSeecfm1P+D7T4Wu8RsKjHbvQPa9HtqtDmZEIYk=;
 b=AmjZfVEvmXwOjqRD7S74Xwyh4SzAQMfCeeDkHL0DQEzYgLQrau7i9DtmuE04AAYBN5
 EQfkcLc8Ipbt2owe4cIOmbrZKAZ0N70I4QuALCsl0aWu8rZxMONcpUrV35lIOWz+5MuC
 JU1kyYAGA3uv8XmCUl03u2rXU8WhG+pp5xDsgW8Gys0oTQtP7eBW4hHiFx7Y2SBEuByD
 j/D2LdNRRXFak+M8k4CIshVgzCd7lLTAllBc82rJSh37rEa6Jp0+TKvuGbxVHHD77Z0q
 Fbk7meT2VuzDhRS2DfFArQU1Q3S/bDTf+L0wCEWVznasVrQol0w+ft497fOKfnteT1Xs
 S/QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVprBanTnYNpIUEam4joKyx+GNb4cNHgGy1qj/vPAoNJBlhz27kT2NbLaBBjcj+RSI3UUk=@lists.linux.it
X-Gm-Message-State: AOJu0Yw+E3f/hEzcRFoyy+RqAIayOK7YDhRv23EFOn+7SA884Zh0HzQ/
 pe3U4G7/pHbOkQ/bWA5C1n32Bv+eMRd3hHlbSHXU4E9yeCa1Mr3tTM3A8W97+ryGr4a8hCZQdfk
 dvl1qZHXDlcamCZbnw6eGYP01hewYiWGIzGzsJd9BIWNVlsaQWHY76iWmdV8fPojLTfvXEedzDQ
 7Fa1YuYXG4ubVPwQmM3LkT2oi+7nU=
X-Gm-Gg: AY/fxX7AtvraiEyLfDjv572oanUOreqE/i5Guh5G+Gj1HVhGClWFiY2M4RQHI+Z7buX
 JersVcC8x/aDigmU6g+b5OwBf43h+aCD+XWMMkIA4pBaWG6ly0Uf6xvRgBJMAPVNcHmXOTEea83
 8iofo613l44O8/YCJz17JLUE9QirQtY5nH6AZ+TxXuqtxrB4anqRJM1n5V90GwPzrZSV0=
X-Received: by 2002:a05:7300:cb81:b0:2a4:3593:9697 with SMTP id
 5a478bee46e88-2b486f6865emr7786423eec.20.1768471746735; 
 Thu, 15 Jan 2026 02:09:06 -0800 (PST)
X-Received: by 2002:a05:7300:cb81:b0:2a4:3593:9697 with SMTP id
 5a478bee46e88-2b486f6865emr7786395eec.20.1768471746337; Thu, 15 Jan 2026
 02:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
 <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
 <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
 <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
 <20260115100357.GA445534@pevik>
In-Reply-To: <20260115100357.GA445534@pevik>
Date: Thu, 15 Jan 2026 18:08:54 +0800
X-Gm-Features: AZwV_Qj66sddmxi_c2QAtWkmnAM8iWMyiejFLDZbNAzuoanaP2FPXp9qDC8VJis
Message-ID: <CAEemH2dNPJm3diWTkt-tbi6qTbq=tT6R9qEZeV9r8JgfcBP_nA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jWs-YnSfJlT6G3HqXn5pCtwgZTk-ju2sSsmux-p1fXQ_1768471747
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] kirk: Update to v3.2
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

T24gVGh1LCBKYW4gMTUsIDIwMjYgYXQgNjowNOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIExpLAo+Cj4gPiA+ID4gPT09PT0gTG9nID09PT09Cj4gPiA+ID4g
IyAuL2tpcmsgLS1lbnYgTFRQUk9PVD0vcm9vdC9sdHAtaW5zdGFsbC8gIC0tcnVuLXN1aXRlIHNj
aGVkIC12Cj4gPiA+ID4gLS1qc29uLXJlcG9ydCBzY2hlZC5qc29uCj4gPiA+ID4gSG9zdCBpbmZv
cm1hdGlvbgo+Cj4gPiA+ID4gSG9zdG5hbWU6ICAgZGVsbC1wZXI0MzAtMDkuZ3NzbGFiLnBlazIu
cmVkaGF0LmNvbQo+ID4gPiA+IFB5dGhvbjogICAgIDMuMTIuMTIgKG1haW4sIEphbiAgNiAyMDI2
LCAwMDowMDowMCkgW0dDQyAxNC4zLjEgMjAyNTA2MTcKPiA+ID4gPiAoUmVkIEhhdCAxNC4zLjEt
MildCj4gPiA+ID4gRGlyZWN0b3J5OiAgL3RtcC9raXJrLnJvb3QvdG1wMWEwNjJxa3QKPgo+ID4g
PiA+IENvbm5lY3RpbmcgdG8gU1VUOiBkZWZhdWx0Cj4gPiA+ID4gRXJyb3I6IExUUCBmb2xkZXIg
ZG9lc24ndCBleGlzdDogL29wdC9sdHAKPgo+ID4gPiA+IERpc2Nvbm5lY3RpbmcgZnJvbSBTVVQ6
IGRlZmF1bHQKPiA+ID4gPiBTZXNzaW9uIHN0b3BwZWQKPgo+ID4gPiA+ID09PT09PT09PT09PT09
Cj4KPgo+ID4gPiBUaGlzIGlzIHN0cmFuZ2UuIFRoZSAtLWVudiBmZWF0dXJlIGlzIHRha2luZyBp
bmZvIGZyb20gc2hlbGwgYW5kCj4gPiA+IHVwZGF0aW5nIGl0cyBkaWN0aW9uYXJ5IGlmIGl0IGhh
cyBiZWVuIGRlZmluZWQuCj4KPiA+ID4gVGhpcyBpcyBleGFjdGx5IHdoeSB0aGlzIHRpY2tldCBo
YXMgYmVlbiBvcGVuLiBUb28gbXVjaCBjb25mdXNpb24KPiA+ID4gYmV0d2VlbiBzaGVsbCB2YXJp
YWJsZXMgYW5kIC0tZW52IHBhcmFtZXRlci4gV2UgY2FuJ3QgaGF2ZSAyIGRpZmZlcmVudAo+ID4g
PiB3YXlzIHRvIHNldCBpbnRlcm5hbCB2YXJpYWJsZXMuCj4KPiA+ID4gaHR0cHM6Ly9naXRodWIu
Y29tL2xpbnV4LXRlc3QtcHJvamVjdC9raXJrL2lzc3Vlcy83Mgo+Cj4gPiBBZnRlciBwbGF5aW5n
IHdpdGggdGhlIGx0cC5weSBmb3IgYSB3aGlsZSBhbmQgYXNzaXN0ZWQgYnkgR1BUNSwKPiA+IEkg
ZHJhZnRlZCBhIHNpbXBsZSBwYXRjaCBsaWtlIGJlbG93LCBpdCB3b3JrcyBmcm9tIG15IHRlc3Qs
IGNhbgo+ID4gRG8geW91IHRoaW5rIGl0J3Mgd29ydGggb3BlbmluZyBhIFBSIHRvIEtpcms/Cj4K
PiA+IC0tLSBhL2xpYmtpcmsvbHRwLnB5Cj4gPiArKysgYi9saWJraXJrL2x0cC5weQo+ID4gQEAg
LTUwLDcgKzUwLDcgQEAgY2xhc3MgTFRQRnJhbWV3b3JrKEZyYW1ld29yayk6Cj4gPiAgICAgICAg
ICBzZWxmLAo+ID4gICAgICAgICAgbWF4X3J1bnRpbWU6IGZsb2F0ID0gMC4wLAo+ID4gICAgICAg
ICAgdGltZW91dDogZmxvYXQgPSAzMC4wLAo+ID4gLSAgICAgICAgZW52OiBkaWN0ID0ge30sCj4g
PiArICAgICAgICBlbnY6IE9wdGlvbmFsW2RpY3RdID0gTm9uZSwKPiA+ICAgICAgKSAtPiBOb25l
Ogo+ID4gICAgICAgICAgIiIiCj4gPiAgICAgICAgICA6cGFyYW0gbWF4X3J1bnRpbWU6IGZpbHRl
ciBvdXQgYWxsIHRlc3RzIGFib3ZlIHRoaXMgdGltZSB2YWx1ZQo+ID4gQEAgLTYzLDcgKzYzLDgg
QEAgY2xhc3MgTFRQRnJhbWV3b3JrKEZyYW1ld29yayk6Cj4gPiAgICAgICAgICBzZWxmLl9sb2dn
ZXIgPSBsb2dnaW5nLmdldExvZ2dlcigibGlia2lyay5sdHAiKQo+ID4gICAgICAgICAgc2VsZi5f
Y21kX21hdGNoZXIgPSByZS5jb21waWxlKHInKD86IlteIl0qInxcJ1teXCddKlwnfFxTKyknKQo+
ID4gICAgICAgICAgc2VsZi5fbWF4X3J1bnRpbWUgPSBtYXhfcnVudGltZQo+ID4gLSAgICAgICAg
c2VsZi5fcm9vdCA9IG9zLmVudmlyb24uZ2V0KCJMVFBST09UIiwgIi9vcHQvbHRwIikKPiA+ICsg
ICAgICAgIGVudiA9IGVudiBvciB7fQo+ID4gKyAgICAgICAgc2VsZi5fcm9vdCA9IGVudi5nZXQo
IkxUUFJPT1QiKSBvciBvcy5lbnZpcm9uLmdldCgiTFRQUk9PVCIpCj4KPiBEbyBJIHVuZGVyc3Rh
bmQgeW91IHdhbnQgdG8gZ2V0IGJhY2sgLS1lbnY/IFdvdWxkIGl0IGJlIHRvbyBoYXJkIGZvciB5
b3UgdG8gdXNlCj4gc2hlbGwgZW52aXJvbm1lbnQgdmFyaWFibGU/IFRoZSBwdXJwb3NlIHdhcyB0
byBzaW1wbGlmeSB0aGUgY29kZSAoQW5kcmVhJ3MKPiBjb25jZXJuLCB3aGljaCBJIGRvbid0IG9i
amVjdCBiZWNhdXNlIGhlIGRvZXMgYWxsIHRoZSBraXJrIHdvcmspLgoKTm8sIEkgZG9uJ3Qgd2Fu
dCB0byBnZXQgYmFjayAtLWVudiwgc2luY2UgYmVmb3JlIEFuZHJlYSByZXBsaWVkIHRvIG1lCkkn
dmUgYmVlbmRlYnVnZ2luZyBhIHdoaWxlIGFuZCBmb3VuZCBhIHdheSB0byBtYWtlIC0tZW52IHdv
cmsuCgpTbyBqdXN0IGxldCBoaW0ga25vdyBpdCdzIG5vdCB0b28gY29tcGxpY2F0ZWQgdG8gc3Vw
cG9ydCBib3RoIHdheSwKSSB3b3VsZCBsZWF2ZSB0byBoaW0gdG8gbWFrZSB0aGUgZmluYWwgZGVj
aXNpb24gOikuCgo+IEFsc28sIEknbSBzb3JyeSB0byBtZXJnZSB1cGRhdGUgd2l0aG91dCB5b3Vy
IGFjaywgbmV4dCB0aW1lIEknbGwgd2FpdCBmb3IgdGhlCj4gdGVzdGluZy4KCk5vIHByb2JsZW0s
IHdlJ3JlIHN0aWxsIHVzaW5nIHRoZSBzdGFibGUgTFRQIHZlcnNpb24sIHNvIHRvZGF5IEknbSBq
dXN0IHRlc3RpbmcKS2lyay0zLjIgdG8gc2VlIGlmIGFuIHVwZ3JhZGUgaXMgcG9zc2libGUuCgot
LSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
