Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71C6CA6004
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 02:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791425441; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wnfcmADKfMlgqOiKbRJn+/EvZONBekdO8wP/7PxwA1g=;
 b=MufOtA8YZHHF9DLWEoy1KKeSCB1xFe1nKYNlcn3S5SMVipusSYdISJw1v/TamEMxOmmH7
 LdXSKUd9vt1bB1HTbybNwnygcLyYe2sFFPo0m+gYoex5E+6Z5PZ2cGZexEYeBmsu8WgmhUC
 RzICRGn3JGrtkvKdH4lwcK5+AFd/98Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 817FD3E9CCD
	for <ltp@archiver.kernel.org>; Thu,  8 Oct 2026 04:10:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F2503C0FA2
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 04:10:21 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 61A141A005EC
 for <ltp@lists.linux.it>; Thu,  8 Oct 2026 04:10:20 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso1679729f8f.0
 for <ltp@lists.linux.it>; Wed, 07 Oct 2026 19:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791425420; x=1792030220; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ysHMY4xvAz6bYzaFsPm/4wgUEX5TltMPZJ1+xwgQn1w=;
 b=caeYn1yENBylCrXxv8zdqpB4KcYpwWrc5+hZnVwASlG7P/84j+luk0BmixLJwRcYwt
 9pDHpbagB8zXSEetoIoXokxTnvvYhLZ30YkeZxaayCgUGScSKqKmt29sSdKridjlRWss
 ZiJ+dQX3t2XzutyrAdBYLxXUGuldoz9cSzl4u0WDY2t9gr5oDyfN7hmxV8lQARRgXV0Q
 CAQV1Gyxj+z2fjYq/nf6t1GBh7QqDJ21lSt0RD7aSbJm8uoAuQGmFMGoU2tN17cSqx43
 YhIJyr3sm9CX3PpEfqWJSItRcBNOadnKJpbLNitQL/Am21LgCX9+iKsbwE1hkrE6ObDz
 VmFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791425420; x=1792030220;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ysHMY4xvAz6bYzaFsPm/4wgUEX5TltMPZJ1+xwgQn1w=;
 b=alN/QvfzMX+CTWlFHXghA+bpRKVLM06fWSld32XeUGEhqS7hObeB8gphYWKGsy1ELE
 lTzqlTvPqBdKk/RgioujhAzvIQu7fOJkBAChxUTtyME/enPLVTg4+RpY1b9ADvtqQR1b
 cu4RRkrLkZf4wHZEMnBJXjJDWPOdOlZN8LDSsg0Vq0tNilwVrH6LEmMHGMbK3jV4lTkP
 7MyCI5rD9YnLlEoPuiAfxbGh1hdLzKWOcXu/sWP0Gzc7zYy5hdMxI2+HcBYGCePyGu34
 q4IDS0b/yIbMrepAqqzc5Oo96qIOcdv/jfw2lMs3QP/JzZA2hgDVSOr/XRVUiqzTqajQ
 2MGg==
X-Gm-Message-State: AFq9FYKmq9d6a5QMdZwPf3u42ufq3CqDJ36iKNrF0ocBSkeMnBSapEtt
 HatFC2IkOK/1rvXOQe39yz8PTkFymFCRMrzb4WEo0QTHe5pIfMQIobslLNUD12bdlA==
X-Gm-Gg: AYBFou0hkRVPv/WkroAxmOLW9dZxxjUFbJASsvU+UES4zH75pxAyz7nceJEVnSDMq6+
 plR48c+Jy0vceh0qMVQFvs3797PVQzJR6VZkFJ5+ue/0Fl6II7qjOnV57Gv7wCZdH1WWqinBmWf
 E8oXidCN2DJHz8alviy2yHPSCzXOnsFbX5vhVTzw86dsWADDLAwPryxkfNRTfBp/0iAyfYeQ/pR
 KfymR3BCc69pDqrupkeaE5dEOSMNDp9zE85GUlD7sXamltcXvSGKwGTBrWPXjSSGnSHokrrL8TB
 vM6S4q/shvIwMDCvKd+RAj40I3SuBbCDePk/A4gq7RvAajyMB33OEjaLtKz6rpUEFuRiIpfoFA3
 c3muxeqtn1PMSTTftmBQNfcoP+YgRxD6b+oJ47bRBynjYsNH4paoGSILfoJn9tSDVgTPL6d2E0S
 rkD3ORHGrGt8zqypBqWScGtklnA3qm0+zeYDygN+J+8wEi6cWORsH8QLF/muqMghSL5x6sEPNzK
 8wRaOA43Knf1sidDdNzUfbo+WXMW+XY2/0XngIpS0YEnz2OKHPfjaYuBPXkmFqnjGtSqUtT
X-Received: by 2002:a05:6000:470a:b0:487:463:92d3 with SMTP id
 ffacd0b85a97d-48c7275ae8amr7700993f8f.20.1791425419656; 
 Wed, 07 Oct 2026 19:10:19 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d2fba1sm7944007f8f.48.2026.10.07.19.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 19:10:19 -0700 (PDT)
Date: Thu, 8 Oct 2026 02:10:17 +0000
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Message-ID: <asb7iTU4FBh4b0UT@autotest-wegao.qe.prg2.suse.org>
References: <20261004143332.25978-1-wegao@suse.com>
 <20261004143332.25978-3-wegao@suse.com>
 <asPB9JgbOowPDAgX@blackbook2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <asPB9JgbOowPDAgX@blackbook2>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] memcontrol03,
 memcontrol04: Set protection on parent cgroups to prevent kswapd
 over-reclaim
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

T24gTW9uLCBPY3QgMDUsIDIwMjYgYXQgMDU6Mzc6NDZQTSArMDIwMCwgTWljaGFsIEtvdXRuw70g
d3JvdGU6Cj4gSGVsbG8gV2VpLgo+IAo+IE9uIFN1biwgT2N0IDA0LCAyMDI2IGF0IDAyOjMzOjI3
UE0gKzAwMDAsIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPiB3cm90ZToKPiA+IE9uIE5VTUEgc3lz
dGVtcyAob2JzZXJ2ZWQgb24gUG93ZXJQQyksIGFsbG9jYXRpbmcgbWVtb3J5IGNhbiB0cmlnZ2Vy
Cj4gPiBub2RlLWxldmVsIG1lbW9yeSBwcmVzc3VyZSwgd2FraW5nIHVwIGtzd2FwZCB3aGVuIGZy
ZWUgcGFnZXMgZmFsbCBiZWxvdwo+ID4gdGhlIGxvdyB3YXRlcm1hcmsgb24gYSBub2RlLgo+ID4g
Cj4gPiBJbiBjZ3JvdXAgdjIsIGJvdGggaGFyZCBwcm90ZWN0aW9uIChtZW1vcnkubWluKSBhbmQg
YmVzdC1lZmZvcnQgcHJvdGVjdGlvbgo+ID4gKG1lbW9yeS5sb3cpIGFyZSBoaWVyYXJjaGljYWwg
YW5kIGNhbGN1bGF0ZWQgdG9wLWRvd246IGVmZmVjdGl2ZQo+ID4gcHJvdGVjdGlvbiBvZiBkZXNj
ZW5kYW50IGNncm91cHMgaXMgYm91bmRlZCBieSB0aGVpciBhbmNlc3RvcnMnIHByb3RlY3Rpb24K
PiA+IHZhbHVlcy4gV2hlbiBMVFAgcnVucyBpbnNpZGUgYW4gZXhpc3RpbmcgY2dyb3VwIGhpZXJh
cmNoeSwgYW5jZXN0b3IgY2dyb3Vwcwo+ID4gYWJvdmUgdGhlIHRlc3Qgcm9vdCBoYXZlIG1lbW9y
eS5taW4gYW5kIG1lbW9yeS5sb3cgc2V0IHRvIDAuCj4gCj4gTm90ZSB0aGF0IHRoaXMgaXMgZXhw
ZWN0ZWQgYmVoYXZpb3Igb2YgcHJvdGVjdGlvbiBhbmQgdGhlIHRlc3QgaXMgbWVhbnQKPiB0byB3
b3JrICJyZWxhdGl2ZWx5IiB3aXRoIGl0cyBvd24gcHJlc3N1cmUgc291cmNlIGFuZCB0YXJnZXQg
WzFdLgo+IAo+IAo+ID4gQXMgYSByZXN1bHQsIHdoZW4ga3N3YXBkIHBlcmZvcm1zIG5vZGUtbGV2
ZWwgYmFja2dyb3VuZCByZWNsYWltIGZyb20gdGhlCj4gPiByb290IGNncm91cCBkb3dud2FyZHMs
IGFuY2VzdG9yIGNncm91cHMgd2l0aG91dCBwcm90ZWN0aW9uIHByb3ZpZGUgbm8KPiA+IHByb3Rl
Y3Rpb24gYm91bmRhcnkuIGtzd2FwZCByZWNsYWltcyBwYWdlcyBmcm9tIGRlc2NlbmRhbnQgbGVh
ZiBjZ3JvdXBzCj4gPiByZWdhcmRsZXNzIG9mIHRoZWlyIGxvY2FsIG1lbW9yeS5taW4gLyBtZW1v
cnkubG93IHNldHRpbmdzLCBjYXVzaW5nCj4gPiBtZW1jb250cm9sMDMgYW5kIG1lbWNvbnRyb2ww
NCB0byBmYWlsIHdpdGggb3Zlci1yZWNsYWltOgo+IAo+IEdlbmVyYWxseSwgdGhpcyBpcyBub3Qg
c3BlY2lmaWMgdG8gdGhpcyB0ZXN0IC0tIGl0IGlzIGJlY2F1c2UgaXQgdGhlCj4gd2hvbGUgaG9z
dCBpcyBvdmVyY29tbWl0dGVkIChlZGl0OiBhcyBJIHNlZSB0aGUgTlVNQSBpbmZvIGJlbG93IGl0
IGNvdWxkCj4gYmUgcGVyaGFwcyB0aGF0IG9ubHkgaW5kaXZpZHVhbCBub2RlcyBhcmUgdG9vIHNt
YWxsKS4KPiAKPiBTbyBJIHdvbmRlciBjb3VsZCB0aGlzIGJlIGVuc3VyZWQgYXQgaGlnaGVyIGxl
dmVsIC0tIHNvbWV0aGluZyB0aGF0IHNldHMKPiB1cCB0aGUgZW52aXJvbm1lbnQgb2YgdGhlIGlu
ZGl2aWR1YWwgcnVubmVycyAoZS5nLiByZWR1Y2UgcGFyYWxsZWxpc20sCj4gcGFydGl0aW9uIHRo
ZSBzeXN0ZW0gd2l0aCBtZW1vcnkgbGltaXRzIG9yIGFzIGEgdmFyaWFudCBjb25maWd1cmUKPiBn
ZW5lcmljIG1lbW9yeSBwcm90ZWN0aW9uKT8KPiAKPiBXRFlUPwoKUHJvdGVjdGluZyB0aGlzIHNv
bGVseSBmcm9tIHRoZSBleHRlcm5hbCBydW5uZXIgaXMgdHJpY2t5IHNpbmNlIExUUCBidWlsZHMK
YSAzLWxldmVsIGNncm91cCBoaWVyYXJjaHk6Ci0gL3N5cy9mcy9jZ3JvdXAvbHRwIChMZXZlbCAx
KQotIHRzdF9jZyAoL3N5cy9mcy9jZ3JvdXAvbHRwL2x0cC10ZXN0eHh4eCwgTGV2ZWwgMiDigJQg
dHJ1bmtfQSdzIHBhcmVudCkKLSB0cnVua19jZ1tBXSAoTGV2ZWwgMyDigJQgdHJ1bmtfQidzIHBh
cmVudCkKRXZlcnkgbGV2ZWwgaW4gdGhpcyBjaGFpbiBuZWVkcyBtZW1vcnkubG93ID0gNTBNLiBF
dmVuIGlmIGFuIGV4dGVybmFsIHJ1bm5lciAKc2V0cyBpdCBhdCAvc3lzL2ZzL2Nncm91cC9sdHAs
IHRzdF9jZyBvciB0cnVua19BIHdpbGwgYnJlYWsgdGhlIHByb3RlY3Rpb24gY2hhaW4uCgpBbm90
aGVyIG9wdGlvbiBpcyBtYWtlIHN1cmUgZW5vdWdoIG1lbW9yeSB0byB0aGUgdGVzdCBlbnZpcm9u
bWVudCBzbyBrc3dhcGQgCmRvZXNuJ3QgZ2V0IHRyaWdnZXJlZCBhdCBhbGwuIEkgZ3Vlc3Mgd2Ug
Y2FuIGRvIHRoaXMgdG8gYXZvaWQgaXNzdWU/Cgo+IE1pY2hhbAo+IAo+IAo+IFsxXSBodHRwczov
L3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9hZG1pbi1ndWlkZS9jZ3JvdXAtdjIuaHRt
bCNyZWNsYWltLXByb3RlY3Rpb24KCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
