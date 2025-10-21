Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9F4CCD184
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 03:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761018188; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AfAMURgTvx53JX1VLc3u/X28mpppeZwHNPvGM5fVchA=;
 b=ROqOkl+kpS2JQ5NczKNM9v2L2HTC+gt7991Z5qi2brbgrUddsypWbalQwQXZRu+DBO+KK
 Jpue4YzOZzI97219/lbMtRj97hsFyI0CLau3BHIcpuZhUaZPcy6go3Z8lecFGY3hEwhNB+H
 6N0bOdXiK2txhDmEV+kkpUtpwaBkD44=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEFD83CEA16
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 05:43:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52C8F3CEA16
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 05:42:47 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5AE66600474
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 05:42:46 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-426edfffc66so3734865f8f.1
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761018166; x=1761622966; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7RDBzVo54z4T64VENhwANBlECS3M4ITuULUeU3dF7tA=;
 b=T44c9Uymvf6MMZbWNieoStalwSqaTHUz/QO9CkdNNcvtedZl8YPzeqCmItxTypnTcB
 es3O8NNRg7YbGyzxY17aKaMeC4d1Mw5vAxa0wMpsASuRESR5paEoyR0R0BXfvXyPnbjq
 GmuCQd3KD03al4vvbExBEqi9wHO5FQGDMYOXXkMFn0JYT75fO5uh9BaqDCr9qGe85n0u
 oNJIipVZyYIH5J4p0xxqq/eOF9tHmKwHQOlpH6/LBsfMBXMCuPbC3mN7dTMjVPt/+YIr
 L9gtj4wGYVrSTTLn3EbphZHNFlxZ0ypbvPbDiWbNaS/TvnDZSnknYrmi5L4nXXhtfI48
 DaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761018166; x=1761622966;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7RDBzVo54z4T64VENhwANBlECS3M4ITuULUeU3dF7tA=;
 b=b9qwfBpuKoLbo7NJ3wv0VaJluP6XpI4OMbExySAfpIvrfxdKGT2vX4scdzCGsIPJII
 dgDxJXqn2WcPRtEaQCMNyhMzlCv150uIKriTWvsvMAR6NiGl6DX+AZp09Rl1pGeJFGOq
 RZzjQCNrVjmFLvLS1kdWUtrhJ+AMLrgQbnA5AKDv15WF9yNbUZ/nrFJPsyQlO+m1jJzb
 mTXQQLZxYZ0SZGkVrfWnV4xFhNUCVlGtTV8aqub2r3sBbsdKbW1f+cO2aNgnMTf/wwtB
 JZwz1tSA8Bm/1jgKCy+uqtdT9Nvyg3r5VS8SWqKqjyoF2uYSxte9+zCuPIt1Gq7WoLlh
 ZDRg==
X-Gm-Message-State: AOJu0YxEsBKAXsWbutfr9axQbTUR49lS9QnQ9vSzyd1A7J0ILMvgI2Ht
 nXzm2m3ve+r+ZB/YBZfVbt17C9OtKpH+Hy2EOwkJM8IFsKSSYFIBGobHeS+6T8BG/w==
X-Gm-Gg: ASbGncuDkwlhoJOiQ6zx/9Zj+G27Q8h8dtLQCr9gQUFZNN72HRN/W19LjGuqun8mJ9F
 tHNOWTylAAoH3vPHshVq6oyew6+zBUUjWm4BoIkDUUqOWTqkAAS8iO6jFQ0B/BFPGBk4tE9hgA+
 kqfZFoSzpdw0k+B8FHkQ/qk199xJ8FE+MLykbyDF85oHVJlueH+7d64bC/A1YGKOARQ7S+dGzEX
 NCmcvtxUL9QGIf6c0ci6+fEQz8EQt+/rLylGIR6kZLXi5aun6rsOuA6Hv4dfsaGmbtAvfloZ9bU
 /D5kNCitVqzVEBcDatO2WusbfZ4BBIMxYrEv+h9jkZhuTYakHgK1poGBR5dSb3vcBBTiCtHWIUR
 pe5DKYC0k0ZPCYEldb39faHvjnHYArgmgNXcn9cpcy5O78irfhJRRgumf9BbcKzQOWnb7QY9On6
 M=
X-Google-Smtp-Source: AGHT+IEjcc9jdqFO8NUX9FFf0GA7naIpoiu2tYRlARFt4e/qgjtSp5fA8cp4+KXbHGYM1i4mkowkCA==
X-Received: by 2002:a5d:5c89:0:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-42704bee92dmr11535705f8f.21.1761018165678; 
 Mon, 20 Oct 2025 20:42:45 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3c56sm18400542f8f.18.2025.10.20.20.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 20:42:45 -0700 (PDT)
Date: Tue, 21 Oct 2025 03:42:43 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aPcBM49nqBep6ZjQ@localhost>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-2-wegao@suse.com>
 <20251017143524.GA339521@pevik> <aPWO0j120Kr0z6Pn@localhost>
 <20251020132140.GA398576@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251020132140.GA398576@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: Add support option for .needs_cmds
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

T24gTW9uLCBPY3QgMjAsIDIwMjUgYXQgMDM6MjE6NDBQTSArMDIwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiBIaSBXZWksCj4gCj4gPiA+ID4gLQljb25zdCBjaGFyICpjb25zdCAqbmVlZHNfY21kczsK
PiA+ID4gPiArCXN0cnVjdCB0c3RfY21kICpuZWVkc19jbWRzOwo+IAo+ID4gPiBBcyBJIHdyb3Rl
IGluIGFsbCBwcmV2aW91cyB2ZXJzaW9ucywgY2hhbmdpbmcgc3RydWN0IHVzZWQgaW4gc3RydWN0
IHRzdF90ZXN0Cj4gPiA+IGFsb25lIHdpdGhvdXQgY2hhbmdpbmcgd2lsbCBicmVhayB0aGlzIHBh
cnRpY3VsYXIgY29tbWl0Lgo+IAo+ID4gPiBTZWUgd2hlbiBJIGFwcGx5IGp1c3QgdGhpcyBjb21t
aXQuOgo+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vcGV2aWsvbHRwL2FjdGlvbnMvcnVucy8xODU5
NTg5MTU4Ngo+ID4gPiBodHRwczovL2dpdGh1Yi5jb20vcGV2aWsvbHRwL2NvbW1pdHMvcmVmcy9o
ZWFkcy93ZWkvbmVlZHNfY21kcy52NC5maXJzdC1jb21taXQtYnJva2VuLwo+IAo+ID4gPiBDQyBs
aWIvbmV3bGliX3Rlc3RzL3RzdF9leHBpcmF0aW9uX3RpbWVyCj4gPiA+IHRzdF9uZWVkc19jbWRz
MDEuYzoxNToyMzogZXJyb3I6IGluaXRpYWxpemF0aW9uIG9mIOKAmHN0cnVjdCB0c3RfY21kICri
gJkgZnJvbSBpbmNvbXBhdGlibGUgcG9pbnRlciB0eXBlIOKAmGNvbnN0IGNoYXIgKirigJkgWy1X
aW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCj4gPiA+ICAgIDE1IHwgICAgICAgICAubmVlZHNf
Y21kcyA9IChjb25zdCBjaGFyICpbXSkgewo+ID4gPiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICBeCj4gPiA+IHRzdF9uZWVkc19jbWRzMDEuYzoxNToyMzogbm90ZTogKG5lYXIgaW5pdGlh
bGl6YXRpb24gZm9yIOKAmHRlc3QubmVlZHNfY21kc+KAmSkKPiAKPiA+ID4gLi4uCj4gCj4gPiA+
IHF1b3RhY3RsMDEuYzoyMjY6MjM6IGVycm9yOiBpbml0aWFsaXphdGlvbiBvZiDigJhzdHJ1Y3Qg
dHN0X2NtZCAq4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSDigJhjb25zdCBjaGFy
ICogY29uc3Qq4oCZIFstV2luY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQo+ID4gPiAgIDIyNiB8
ICAgICAgICAgLm5lZWRzX2NtZHMgPSAoY29uc3QgY2hhciAqY29uc3QgW10pIHsKPiA+ID4gICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgXgo+IAo+ID4gPiBQbGVhc2UgeW91IG5lZWQgdG8g
aGF2ZSB0aGlzIGNvbW1pdCB0b2dldGhlciB3aXRoICJVcGRhdGUgdGVzdCBjYXNlcyB1c2UgbmV3
Cj4gPiA+IG5lZWRzX2NtZHMiIGNvbW1pdCBpbnRvIHNpbmdsZSBjb21taXQgKHNxdWFzaCB0aGVz
ZSB0d28gaW50byBhIHNpbmdsZSBjb21taXQpLgo+IAo+ID4gPiBPciBhbSBJIG1pc3Npbmcgc29t
ZXRoaW5nPwo+ID4gVGhhbmtzIGZvciB5b3VyIHRpbWUgZG8gdmVyaWZ5IHRlc3QgY2FuIHJldmll
dy4KPiB5dyA6KS4KPiAKPiA+IFRoZSByZWFzb24gaSBzcGxpdCB0aGlzIHBhdGNoIHRvIHNtYWxs
IGNvbW1pdHMgaXMgZWFzeSBmb3IgcmV2aWV3LCBpZiB5b3UKPiAKPiBZZXMsIGl0J3MgZGVzaXJl
ZCB0aGF0IGNoYW5nZXMgYXJlIHNwbGl0IGludG8gc21hbGxlciBsb2dpY2FsIHBhcnRzIGlmICpw
b3NzaWJsZSouCj4gWWVzLCB0aGlzIHJlYWxseSBoZWxwcyByZWFkYWJpbGl0eS4gQnV0IGlmIHBv
c3NpYmxlIG1lYW5zIGF0IGxlc3QgMSkgbm90Cj4gYnJlYWtpbmcgY29tcGlsYXRpb24gKHRoZSB3
b3JzdCBjYXNlKSAyKSBub3QgYnJlYWtpbmcgdGVzdCBmdW5jdGlvbmFsaXR5Lgo+IAo+IFRoZXJl
Zm9yZSBpdCdzIG11Y2ggZWFzaWVyIHRvIHNwbGl0IGludG8gbW9yZSBjb21taXRzIHNvbWUgbmV3
IGxpYnJhcnkKPiBmdW5jdGlvbmFsaXR5IChpLmUuIGFkZCBzb21lIGxpYnJhcnkgZnVuY3Rpb25h
bGl0eSBhbmQgZW5hYmxlIGl0IGluIHNlcGFyYXRlCj4gY29tbWl0cywgZW5hYmxlIHRlc3RzIGlu
IGEgc2VwYXJhdGUgY29tbWl0KQo+IAo+IEJ1dCBtb2RpZnlpbmcgdGhlIGZ1bmN0aW9uYWxpdHkg
bGlrZSB0aGlzICh3aGVuIGl0IGJyZWFrcyBjb21waWxhdGlvbikgaXMgd29yc2UKPiB0aGFuIGEg
Yml0IG1vcmUgY29tcGxleCBjb21taXQuIFRoaXMgaXMgdGhlIHJ1bGUgaW4gbWFueSBvcGVuIHNv
dXJjZSBwcm9qZWN0cy4KPiAKPiA+IG5lZWQgZXZlcnkgY29tbWl0cyBjYW4gcGFzcyBjb21waWxl
IHBoYXNlIHRoZW4gaSBoYXZlIHRvIGNvbWJpbmUgYWxsCj4gPiBjb21taXRzIGludG8gYSBzaW5n
bGUgYmlnIG9uZSwgaXMgdGhhdCB5b3VyIHJlcXVlc3Q/Cj4gCj4gTm8sIHRoYXQncyBvdGhlciBl
eHRyZW1lIDopLiBUaGVyZSBpcyBzb21ldGhpbmcgaW4gYmV0d2VlbiwgcmlnaHQ/Cj4gWW91IGRp
ZCBub3QgZ2V0IG1lIGNvcnJlY3QsIHRoZXJlZm9yZSBpbiB2NCB5b3Ugbm90IG9ubHkga2VwdCBi
cm9rZW4KPiBmdW5jdGlvbmFsaXR5LCBidXQgeW91IGFsc28gam9pbmVkIHRoZSBwYXJ0IHdoaWNo
IGNvdWxkIGJlIHNlcGFyYXRlZC4gIEF0IGxlYXN0Cj4gImlvY3RsX2xvb3AwMS5jOiBVcGRhdGUg
dG8gbmV3IC5uZWVkc19jbWRzIHN0cnVjdCIgZnJvbSB2MyBjb3VsZCBoYXZlIGJlZW4gYWRkZWQK
PiBhcyBhIHNlcGFyYXRlIGNvbW1pdCAoYWZ0ZXIgdGhlIG1haW4gY2hhbmdlLCBub3QgYmVmb3Jl
KS4gT3IgYW0gSSBtaXNzaW5nCj4gc29tZXRoaW5nPwo+IAo+IFVuZm9ydHVuYXRlbHkgImxpYjog
QWRkIHN1cHBvcnQgb3B0aW9uIGZvciAubmVlZHNfY21kcyIgYW5kICJVcGRhdGUgdGVzdCBjYXNl
cyB1c2UKPiBuZXcgbmVlZHNfY21kcyIgYW5kICJ0c3RfcnVuX3NoZWxsLmM6IEFkZCBuZXcgZnVu
Y3Rpb24gaGFuZGxlIG5ldwo+IG5lZWRzX2NtZHMiIG5lZWRzIHRvIGJlIGluIGEgc2luZ2xlIGNv
bW1pdCwgYnV0IG1heWJlIHlvdSBjb3VsZCBhZGQgZnVuY3Rpb25zCj4gd2hpY2ggaW1wbGVtZW50
IGl0IGluIGEgc2VwYXJhdGUgY29tbWl0cyAoZS5nLiBwcmVwYXJhdGlvbiBmb3IgYSBuZXcgY2hh
bmdlKSBhbmQKPiBkbyB0aGUgY2hhbmdlICh3aGVuIGl0J3MgYWN0dWFsbHkgdXNlZCkgaW4gdGhl
IGxhc3QgY29tbWl0KS4gIEknbSBub3Qgc3VyZSBpZgo+IGl0J3Mgd29ydGggb2YgYSBzZXBhcmF0
aW9uLCBtYXliZSBub3QgKGhvcGVmdWxseSB3ZSBnZXQgYSBmZWVkYmFjayBmcm9tIG90aGVycyku
Cj4gSWYgeWVzOgo+IAo+IDEpIGNvbW1pdCAobGliIHByZXBhcmF0aW9uKSB3b3VsZCBoYXZlOiBz
dHJ1Y3QgdHN0X2NtZCwgYm9vbAo+IHRzdF9jbWRfcHJlc2VudChjb25zdCBjaGFyICpjbWQpCj4g
Cj4gMikgY29tbWl0IChzaGVsbCBsb2FkZXIgcHJlcGFyYXRpb24pIHdvdWxkIGhhdmU6IGVudW0g
Y21kX2lkcywgc3RhdGljCj4gdWpzb25fb2JqX2F0dHIgY21kX2F0dHJzW10sIHN0YXRpYyB1anNv
bl9vYmogY21kX29iaiwgc3RhdGljIHN0cnVjdCB0c3RfY21kCj4gKnBhcnNlX2NtZHModWpzb25f
cmVhZGVyICpyZWFkZXIsIHVqc29uX3ZhbCAqdmFsKS4KPiAKPiAzKSBjb21taXQgKHVzZSBuZXcg
ZnVuY3Rpb25hbGl0eSkgd291bGQgaGF2ZTogZnJvbSAibGliOiBBZGQgc3VwcG9ydCBvcHRpb24g
Zm9yCj4gLm5lZWRzX2NtZHMiOgo+IAo+IC0JY29uc3QgY2hhciAqY29uc3QgKm5lZWRzX2NtZHM7
Cj4gKwlzdHJ1Y3QgdHN0X2NtZCAqbmVlZHNfY21kczsKPiAKPiBhbmQgdXNlIG9mIHRzdF9jaGVj
a19jbWQoKQo+IAo+IGZyb20gInRzdF9ydW5fc2hlbGwuYzogQWRkIG5ldyBmdW5jdGlvbiBoYW5k
bGUgbmV3IG5lZWRzX2NtZHMiCj4gLQkJCXRlc3QubmVlZHNfY21kcyA9IHBhcnNlX3N0cmFycigm
cmVhZGVyLCAmdmFsKTsKPiArCQkJdGVzdC5uZWVkc19jbWRzID0gcGFyc2VfY21kcygmcmVhZGVy
LCAmdmFsKTsKPiAKPiBhbGwgY29kZSBjaGFuZ2VzIGluICJVcGRhdGUgdGVzdCBjYXNlcyB1c2Ug
bmV3IG5lZWRzX2NtZHMiCj4gCj4gNCkgImlvY3RsX2xvb3AwMS5jOiBVcGRhdGUgdG8gbmV3IC5u
ZWVkc19jbWRzIHN0cnVjdCIgZnJvbSB2MyBjYW4gYmUgc2VwYXJhdGUsCj4gaXQganVzdCBoYXZl
IHRvIGJlIGFmdGVyIGxpYnJhcnkgZnVuY3Rpb24gY2hhbmdlZC4KPiAKPiA1KSBjb21taXQ6IG1v
ZGlmeSBzb21lIHRlc3QgdG8gYWN0dWFsbHkgdXNlIHNvbWUgb2YgbmV3IGZ1bmN0aW9uYWxpdHku
Cj4gCj4gSWYgd2UgYXJlIG9rIHRvIGRvIHRvbyBtYW55IHNlcGFyYXRlIGNvbW1pdHMsIHRoZW46
Cj4gCj4gMSkgY29tbWl0OiBldmVyeXRoaW5nIGZyb20gdGhpcyB2NCBpbiBhIHNpbmdsZSBjb21t
aXQsIGJ1dCBzZXBhcmF0ZSBhdCBsZWFzdAo+ICJpb2N0bF9sb29wMDEuYzogVXBkYXRlIHRvIG5l
dyAubmVlZHNfY21kcyBzdHJ1Y3QiIGZyb20gdjMuCj4gCj4gMikgImlvY3RsX2xvb3AwMS5jOiBV
cGRhdGUgdG8gbmV3IC5uZWVkc19jbWRzIHN0cnVjdCIgZnJvbSB2My4KPiAKPiAzKSBjb21taXQ6
IG1vZGlmeSBzb21lIHRlc3QgdG8gYWN0dWFsbHkgdXNlIHNvbWUgb2YgbmV3IGZ1bmN0aW9uYWxp
dHkuCgpUaGFua3MgZm9yIHN1Y2ggZGV0YWlsIGV4cGxhaW5hdGlvbiA6KQpMZXQncyB3YWl0IG9u
ZSBtb3JlIGRheSBmb3IgZmVlZGJhY2sgZnJvbSBvdGhlcnMsIGkgcHJlZmVyIHNlY29uZApzb2x1
dGlvbiBzcXVhc2ggY29yZSBjaGFuZ2VzIGludG8gb25lIGNvbW1pdCB3aXRob3V0IGJyZWFrIGZy
b20gZnVuY3Rpb24KbGV2ZWwuCgpCVFc6IEFic2VudCB0aW1lbHkgZmVlZGJhY2ssIEkgd2lsbCBh
dXRvbWF0aWNhbGx5IGJlZ2luIGNyZWF0aW5nIHRoZSBuZXh0IHBhdGNoIHdpdGgKdGhlIHNlY29u
ZCBzb2x1dGlvbi4KPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAo+ID4gPiBLaW5kIHJlZ2Fy
ZHMsCj4gPiA+IFBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
