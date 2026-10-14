Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6DACC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 18:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792002762; h=mime-version :
 date : message-id : references : in-reply-to : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Xrm8pvptnFAWINFdjddclSdvTQWpBmsJT8Xeg97Ligc=;
 b=bt0WJVlkkOGhVvRdkjwJUrr7HoLo/A2EV+v5d459R+G8YRkLYm9Du+qhKXPx3Cp2api+q
 eDQnl/YwQKHAru2VNLn1ggYmXOPBHVMJc6ZVfRcVX0DN2ZTDr7HfewKFrolXLULXoMHOH5h
 xlWm5jFMuE9NkcvWB2aSL73kM98vhv4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACF653EA7AA
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 20:32:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 497AF3E2DB0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 20:32:22 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 301CA600F91
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 20:32:22 +0200 (CEST)
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso58502425e9.0
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792002741; x=1792607541; darn=lists.linux.it;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:content-type:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vtEYTF84wNcDtXF+kiufIsx/1cATtK8BPqJDgOkBo3M=;
 b=NC+GV0/E6WNuBYMpUnvaWPWEvc6EAYbHsNvIDCfa5dS6jNCQ49T4SKLRV3erkDfZeQ
 jWyi9mWnhedSElPiMeZHvmz3f9TOYxXJZKAbOXxr2/EK2JyMIPKaxgQwlkGQVfFnIaka
 4WuKUUvZlpiA3Xs9xXdAaQtITB9zfTukT/sTNplA0xnbxiiVlWwZJ1wtpzbL/BGELoOS
 XbELdRnltX6b5+C87Xmj3at28r/N6X3UVfgG0b7DGd4RDZFqculZm3OgIFTrw+09N9oj
 daee1kffBf8Ltg/JVnTxgm25IXQ/xj0r5CuCS+vG5070FC2ns64rHxFzFUFejaTupI+S
 PSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002741; x=1792607541;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vtEYTF84wNcDtXF+kiufIsx/1cATtK8BPqJDgOkBo3M=;
 b=SKfc8nYN7wAs9qVKnp3WIV7yhdZvGCU3wqmt9xvqWyHXIEmkGaaMhUjT+fMYeVu3TH
 9+0twMoB1nRVDUPrOz2zMSIRiB2MaVERGnpZqJ95u7qfx4RmllhP2RQBYKrTlFQhj2Z0
 AVEAOQHoMcJd9a67MfBT/6LyO4oxbiExcGavkbbQ6MUnVk2BFw87eTjMOKHAQwUMl4rf
 cr/XAQolgtyydDh9q/mQoT/YzUq8O68SGqjy62UNn72gLG2RKwEd9xLA011AA4yIGRlL
 CI//XyEnMhTFlmvnu2lC2uh5JMZJm7B3NHrP6ZWIhwF2IO1TMNv6WHB05xFbx7R9yC5J
 e86Q==
X-Gm-Message-State: AFq9FYKql3ump4P2Yc/j8oDN4hmoXwsNaAgaI9J/zwCEzKRmvXs4272J
 vIuhFIqP73+TqYo26xR70wd9FLKJ0NcQWeUPD+jnAp5yQpdnDmjGTddrIf8sv+PNTuE=
X-Gm-Gg: AYBFou2ZTgsfoKHbakpv/ZQ/hVmaDhEZ6z9DO6YhZO3ivmyA1xW1nhMCflax0P/W5qa
 q4InLqxWXUuEPO75swWKK+w0aoblrLf8irHtBKI+VZPRu/hxShQyr36Crg5se/YMHGY+Mkhn7cr
 uUh/bZOZz3XCN58Vva0WIz1qIvv0ydiUev5GqUuPVNkkB5lv+2C0vlKTo89Wxqhv9+WWdXklAcg
 c9F/JOJ6OihY9RnBqpMTOOCh3GucW5S6CI7Ay9ol3niMUZ1ESuPe0Q0P831pgHm/JJdM1RbJuOP
 wrSfiNmDE7ydOJsoySjLp++oVKXul29NeRv+AddMuZ8Vq8WiOk5QG1M7Br5rF/eKor2yXHbxslN
 I3JH2aXYY8nGtyek+GJcXhDvomIN+qCOT6Bs0mET2cLRvAPE5Y2yndv0QQwqfnquTs3E0wMKhkv
 WAJB2ba1Nh/etpq7syIol7a8Bgqxi6/3OhRkyJa1KmwPEa7i5E0fITbQ2ScEAHH9okYEP5GypVi
 oAogGGP9HvfWtq9X49PCy71kwAuYA3gTtKXvoon3e6A+dc6Tcru8CT8Uw==
X-Received: by 2002:a05:600c:2e94:b0:4a1:9ec4:d939 with SMTP id
 5b1f17b1804b1-4a19ec4da04mr165759125e9.17.1792002741380; 
 Wed, 14 Oct 2026 11:32:21 -0700 (PDT)
Received: from smtpclient.apple (78-213-160-74.subs.proxad.net.
 [78.213.160.74]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc506asm13997204f8f.47.2026.10.14.11.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:32:21 -0700 (PDT)
Mime-Version: 1.0 (1.0)
Date: Wed, 14 Oct 2026 20:32:09 +0200
Message-Id: <27AE9564-6115-491B-AE80-D9016EA7CDB5@suse.com>
References: <as9x2R-9IQb7vjn7@toolbx>
In-Reply-To: <as9x2R-9IQb7vjn7@toolbx>
To: Martin Cermak <mcermak@redhat.com>
X-Mailer: iPhone Mail (24A446)
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Suggested fix for the mremap03 syscall testcase
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFydGluLAoKeW91IGFyZSByaWdodC4gVGhhdOKAmXMgYSBidWcgd2UgZGlkbuKAmXQgc3Bv
dCBkdXJpbmcgdGhlIHRlc3QgcmV3cml0ZS4gVGhhbmtzLgoKUmV2aWV3ZWQtYnk6IEFuZHJlYSBD
ZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cgo+IE9uIDE0LiBPY3QgMjAyNiwg
YXQgMTQ6MjAsIE1hcnRpbiBDZXJtYWsgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90
ZToKPiAKPiDvu79IZWxsbyBmb2xrcywKPiAKPiBJIHN1c3BlY3QgdGhhdCBMVFAgY29tbWl0IDg4
Y2ZkZTVmYmMxNGIyM2Y2NzNiODE4NTUxMjc0NDhhNTE5Njc5YzAKPiBpbnRyb2R1Y2VkIGEgcmVn
cmVzc2lvbiBpdCB0aGUgbXJlbWFwMDMgdGVzdGNhc2UuICBJJ3ZlIG9yaWdpbmFsbHkKPiByZXBv
cnRlZCBpdCBhcyBhIFZhbGdyaW5kIGJ1ZzoKPiAKPiBodHRwczovL2J1Z3Mua2RlLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9NTI2OTc0Cj4gCj4gQnV0IG5vdyBJIHRoaW5rIGl0J3MgYW4gTFRQIGJ1Zy4g
IFByb3Bvc2VkIGZpeDoKPiAKPiAkIGNhdCAwMDAxLUZpeC10aGUtbXJlbWFwMDMtc3lzY2FsbC10
ZXN0Y2FzZS5wYXRjaAo+IEZyb20gM2RkY2ZhOGMzMDNmZWViODY4MTYzMmU0NThkNzEwMDFmYmZi
ODI1YyBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEKPiBGcm9tOiBNYXJ0aW4gQ2VybWFrIDxtY2Vy
bWFrQHJlZGhhdC5jb20+Cj4gRGF0ZTogV2VkLCAxNCBPY3QgMjAyNiAxNDowNzo0NSArMDIwMAo+
IFN1YmplY3Q6IFtQQVRDSF0gRml4IHRoZSBtcmVtYXAwMyBzeXNjYWxsIHRlc3RjYXNlCj4gCj4g
Q29tbWl0IDg4Y2ZkZTVmYmMxNGIyM2Y2NzNiODE4NTUxMjc0NDhhNTE5Njc5YzAgaW50cm9kdWNl
ZCBhIHJlZ3Jlc3Npb24KPiBpbiB0aGUgc2V0dXAoKSBmdW5jdGlvbiBvZiB0aGUgbXJlbWFwMDMg
dGVzdGNhc2UuICBUaGUgZ29hbCBpcyB0byBwYXNzCj4gYSBiYWRfYWRkciB0byB0aGUgbXJlbWFw
KCkgc3lzY2FsbC4KPiAKPiBUaGUgb3JpZ2luYWwgdmVyc2lvbiBvZiB0aGUgc2V0dXAoKSBmdW5j
dGlvbiBkaWQgZ2VuZXJhdGUgdGhlIGJhZF9hZGRyCj4gdXNpbmcgdHN0X2dldF9iYWRfYWRkcigp
LiAgVGhpcyBnaXZlcyBhIG1hcHBlZCBhZGRyZXNzIHdoaWNoIGlzIG5vdAo+IGFjY2Vzc2libGUg
KFBST1RfTk9ORSkuICBUaGUgbmV3IHZlcnNpb24gb2YgdGhlIHRlc3QgZG9lcyB0aGUgc2FtZSwg
YnV0Cj4gdW5tYXBzIHRoYXQgYWRkcmVzcyByaWdodCBhZnRlciB0aGF0LiAgVmFsZ3JpbmQgZmxh
Z3MgdGhhdCBhcyBhbiBlcnJvci4KPiAKPiBUaGlzIHBhdGNoIHJlc3RvcmVzIHRoZSBvcmlnaW5h
bCBiZWhhdmlvciBvZiB0aGUgc2V0dXAoKSBmdW5jcmlvbi4KPiAtLS0KPiB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL21yZW1hcC9tcmVtYXAwMy5jIHwgMSAtCj4gMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9t
cmVtYXAvbXJlbWFwMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXJlbWFwL21yZW1h
cDAzLmMKPiBpbmRleCA0ZTY0N2NkY2EuLjYwMDM2NTdkNCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL21yZW1hcC9tcmVtYXAwMy5jCj4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tcmVtYXAvbXJlbWFwMDMuYwo+IEBAIC0zNSw3ICszNSw2IEBAIHN0YXRp
YyB2b2lkIHNldHVwKHZvaWQpCj4gICAgbmV3c2l6ZSA9IDIgKiBtZW1zaXplOwo+IAo+ICAgIGJh
ZF9hZGRyID0gdHN0X2dldF9iYWRfYWRkcihOVUxMKTsKPiAtICAgIFNBRkVfTVVOTUFQKGJhZF9h
ZGRyLCBwYWdlX3NpemUpOwo+IH0KPiAKPiBzdGF0aWMgdm9pZCBydW4odm9pZCkKPiAtLQo+IDIu
NTUuMAo+IAo+ICQKPiAKPiBUaGFua3MsCj4gTWFydGluCj4gPDAwMDEtRml4LXRoZS1tcmVtYXAw
My1zeXNjYWxsLXRlc3RjYXNlLnBhdGNoPgo+IAo+IC0tIAo+IE1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
