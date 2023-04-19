Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1D0C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 09:59:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 394413CC01D
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 11:59:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3F0F3C010A
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 11:59:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76C3A2009F9
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 11:59:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1847D1FD8A;
 Wed, 19 Apr 2023 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681898375;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmBSdnOzFQkgNSpJNDkWjY2yksB0WXjzyBSjeB63kIU=;
 b=zPPLBWcvUMKHOlhs3EHRJDtuV+wXfM5RWdvnuS0qxE3omIehF4Z+Lrwi6woqIpSBl0H2yX
 Z+qRsIhHISzsTVuJX6Q7lvxsp2hL+FacfvSGNDAtd28gjj1svMB/8TVKQTIff+I7N047R7
 9iKCZLcWI/Vs9ym5EXXIXr1mzGdoHyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681898375;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SmBSdnOzFQkgNSpJNDkWjY2yksB0WXjzyBSjeB63kIU=;
 b=vqP90CKrnHbIdamB7Htdsvb/otGM1j9F7OMXDlVJOzF6r768ltCk08rqtz0OG1zDlx7msX
 klDaw+6gGtdyBwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0F6713580;
 Wed, 19 Apr 2023 09:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oBEKMIa7P2TAHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Apr 2023 09:59:34 +0000
Date: Wed, 19 Apr 2023 11:59:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230419095939.GA2577418@pevik>
References: <20230413111434.2103422-1-pvorel@suse.cz>
 <CAEemH2fZU=b60mSD8PoZoQiJ7WQ+rhWiOqPO4XGyhS9aB2QDcA@mail.gmail.com>
 <CAEemH2eu2LCyM3g+2BcD2ZFaGSZ2R+V7-zbYc3Kg4kb=vqtiDA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eu2LCyM3g+2BcD2ZFaGSZ2R+V7-zbYc3Kg4kb=vqtiDA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Remove possible double/trailing
 slashes from TMPDIR
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgo+IE9uIFdlZCwgQXByIDE5LCAyMDIzIGF0IDI6NDfigK9QTSBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cgo+ID4gSGkgUGV0ciwKCj4gPiBPbiBUaHUsIEFwciAxMywg
MjAyMyBhdCA3OjE04oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiA+
PiBTaW1pbGFybHkgdG8gcHJldmlvdXMgY29tbWl0LCB3aGljaCBub3JtYWxpemVkIFRNUERJUiBm
b3Igc2hlbGwgQVBJLAo+ID4+IGRvIHRoZSBzYW1lIGZvciBDIEFQSS4KCj4gPj4gVW5saWtlIGZv
ciBzaGVsbCBBUEksIGhlcmUgd2UgbW9kaWZ5ICRUTVBESVIgZGlyZWN0bHksIGJlY2F1c2UKPiA+
PiB0c3RfZ2V0X3RtcGRpcl9yb290KCkgaXMgdXNlZCBvIG1vcmUgcGxhY2VzLgoKPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiA+PiAtLS0KPiA+PiBGb2xs
b3cgdXAgb2YgdGhlIHNhbWUgY2hhbmdlIGluIHNoZWxsIEFQSToKPiA+PiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sdHAvMjAyMzA0MTIwNzM5NTMuMTk4Mzg1Ny0xLXB2b3JlbEBzdXNlLmN6LwoK
PiA+PiBLaW5kIHJlZ2FyZHMsCj4gPj4gUGV0cgoKPiA+PiAgbGliL3RzdF90bXBkaXIuYyB8IDE2
ICsrKysrKysrKysrKysrLS0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgo+ID4+IGRpZmYgLS1naXQgYS9saWIvdHN0X3RtcGRpci5jIGIvbGli
L3RzdF90bXBkaXIuYwo+ID4+IGluZGV4IGI3M2I1YzY2Zi4uOGRiNWM0N2U4IDEwMDY0NAo+ID4+
IC0tLSBhL2xpYi90c3RfdG1wZGlyLmMKPiA+PiArKysgYi9saWIvdHN0X3RtcGRpci5jCj4gPj4g
QEAgLTEyNCwxNiArMTI0LDI4IEBAIGNoYXIgKnRzdF9nZXRfdG1wZGlyKHZvaWQpCgo+ID4+ICBj
b25zdCBjaGFyICp0c3RfZ2V0X3RtcGRpcl9yb290KHZvaWQpCj4gPj4gIHsKPiA+PiAtICAgICAg
IGNvbnN0IGNoYXIgKmVudl90bXBkaXIgPSBnZXRlbnYoIlRNUERJUiIpOwo+ID4+ICsgICAgICAg
Y2hhciAqZW52X3RtcGRpciA9IGdldGVudigiVE1QRElSIik7CgoKPiA+IEl0IHNlZW1zIHRoYXQg
bW9kaWZ5aW5nIHRoZSBlbnZpcm9ubWVudCB2YXJpYWJsZXMgaXMgZ2VuZXJhbGx5Cj4gPiBub3Qg
YSBnb29kIHByYWN0aWNlLgoKPiA+IFRoZSBnZXRlbnYoKSBmdW5jdGlvbiByZXR1cm5zIGEgcG9p
bnRlciB0byB0aGUgdmFsdWUgb2YgYW4KPiA+IGVudmlyb25tZW50IHZhcmlhYmxlLCB3aGljaCBp
cyBzdG9yZWQgaW4gdGhlIG1lbW9yeSBtYW5hZ2VkCj4gPiBieSB0aGUgc3lzdGVtLiBBbnkgYXR0
ZW1wdCB0byBtb2RpZnkgdGhpcyBtZW1vcnkgZGlyZWN0bHkgY2FuCj4gPiBjYXVzZSB1bmV4cGVj
dGVkIGJlaGF2aW9yIG9yIGV2ZW4gY3Jhc2ggdGhlIHByb2dyYW0uCgo+ID4gSW5zdGVhZCBvZiBt
b2RpZnlpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBnZXRlbnYoKSwgaXQgaXMgcmVjb21tZW5kZWQK
PiA+IHRvIGNyZWF0ZSBhIGNvcHkgb2YgdGhlIHZhbHVlIGFuZCBtb2RpZnkgdGhlIGNvcHkgaW5z
dGVhZC4KCkRvIHlvdSBtZWFuIHRvIHVzZSBzdHJkdXAoKT8KCkFsc28gbWFuIGdldGVudigzKSBz
YXlzOgoKICAgICAgIEFzIHR5cGljYWxseSBpbXBsZW1lbnRlZCwgZ2V0ZW52KCkgcmV0dXJucyBh
IHBvaW50ZXIgdG8gYSBzdHJpbmcKICAgICAgIHdpdGhpbiB0aGUgZW52aXJvbm1lbnQgbGlzdC4g
IFRoZSBjYWxsZXIgbXVzdCB0YWtlIGNhcmUgbm90IHRvCiAgICAgICBtb2RpZnkgdGhpcyBzdHJp
bmcsIHNpbmNlIHRoYXQgd291bGQgY2hhbmdlIHRoZSBlbnZpcm9ubWVudCBvZgogICAgICAgdGhl
IHByb2Nlc3MuCgo9PiBJIHdvdWxkIG5vdCBtaW5kICRUTVBESVIgZ290IHVwZGF0ZWQgaW4gdGhl
IGVudmlyb25tZW50LgoKPiBCdHcsIHRoZSB3aXNlIG1ldGhvZCBpcyB0byB1c2Ugc2V0ZW52KCkg
ZnVuY3Rpb24gdG8gcmVzZXQKPiBlbnZpcm9ubWVudCB2YXJpYWJsZXMgaWYgcmVhbGx5IG5lZWRl
ZC4KCldlbGwsIEkgZG9uJ3Qga25vdyBhbnkgQyB0ZXN0IHdoaWNoIG5lZWRzIGl0IChvbmx5IE5G
UyB0ZXN0cyB3aGljaCBhcmUgc2hlbGwKdGVzdHMpLiBCdXQgSSB3YW50ZWQgdG8gaGF2ZSB0aGUg
c2FtZSBiZWhhdmlvciBpbiBib3RoIEFQSXMuCgo+IFRoaXMgaXMgYSBkaWZmZXJlbnQgcGFydCBv
ZiBzaGVsbCBBUEkgSSBoYXZlIHRvIHNheS4KClllcywgdGhlIGJlaGF2aW9yIGlzIHNsaWdodGx5
IGRpZmZlcmVudCBmcm9tIHNoZWxsIEFQSSBbMV0sCndoZXJlIGl0IG1vZGlmaWVzICRUU1RfVE1Q
RElSIChrZWVwICRUTVBESVIgdW50b3VjaGVkKS4KCgo+ID4gT3IsIHRoZSBzaW1wbGVzdCB3YXkg
SSBndWVzcyBpcyBqdXN0IFRCUk9LIGFuZCB0ZWxsIHVzZXJzIHdoeQo+ID4gdGhpcyBUTVBESVIg
aXMgdW51c2FibGUuCgpJZiB5b3UgcHJlZmVyIGl0J3MgYmV0dGVyIHRvIFRCUk9LIG9uOgoqIGRv
dWJsZSBzbGFzaGVzCiogdHJhaWxpbmcgc2xhc2gKCkkgY2FuIGRvIHRoYXQuIEJ1dCBhdCBsZWFz
dCBvbiB0cmFpbGluZyBzbGFzaCBsb29rcyB0byBtZSBxdWl0ZSBzdHJpY3QuCgpXaGF0ZXZlciBw
YXRoIHdlIGNob29zZSwgSSdkIG5lZWQgYWxzbyB0byB1cGRhdGUgZG9jcy4gQlRXIHRoZSBuZWVk
CnRvIGFic29sdXRlIHBhdGggZm9yIFRNUERJUiBpcyBvbmx5IGluIEMgLSBzaGVsbCBoYXBwaWx5
IHRha2VzIHJlbGF0aXZlIHBhdGgKYW5kIElNSE8gaXQncyBub3QgZG9jdW1lbnRlZC4KCktpbmQg
cmVnYXJkcywKUGV0cgoKWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9s
dHAvcGF0Y2gvMjAyMzA0MTIwNzM5NTMuMTk4Mzg1Ny0xLXB2b3JlbEBzdXNlLmN6LwoKPiA+PiAt
ICAgICAgIGlmICghZW52X3RtcGRpcikKPiA+PiArICAgICAgIGlmIChlbnZfdG1wZGlyKSB7Cj4g
Pj4gKyAgICAgICAgICAgICAgIC8qIHJlbW92ZSBkdXBsaWNhdGUgc2xhc2hlcyAqLwo+ID4+ICsg
ICAgICAgICAgICAgICBmb3IgKGNoYXIgKnAgPSBlbnZfdG1wZGlyLCAqcSA9IGVudl90bXBkaXI7
ICpxOykgewo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICgqKytxICE9ICcvJyB8fCAq
cCAhPSAnLycpCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqKytwID0gKnE7
Cj4gPj4gKyAgICAgICAgICAgICAgIH0KPiA+PiArICAgICAgICAgICAgICAgLyogUmVtb3ZlIHNs
YXNoIG9uIHRoZSBsYXN0IHBsYWNlICAqLwo+ID4+ICsgICAgICAgICAgICAgICBzaXplX3QgbGFz
dCA9IHN0cmxlbihlbnZfdG1wZGlyKS0xOwo+ID4+ICsgICAgICAgICAgICAgICBpZiAoZW52X3Rt
cGRpcltsYXN0XSA9PSAnLycpCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZW52X3RtcGRp
cltsYXN0XSA9ICdcMCc7Cj4gPj4gKyAgICAgICB9IGVsc2Ugewo+ID4+ICAgICAgICAgICAgICAg
ICBlbnZfdG1wZGlyID0gVEVNUERJUjsKPiA+PiArICAgICAgIH0KCj4gPj4gICAgICAgICBpZiAo
ZW52X3RtcGRpclswXSAhPSAnLycpIHsKPiA+PiAgICAgICAgICAgICAgICAgdHN0X2Jya20oVEJS
T0ssIE5VTEwsICJZb3UgbXVzdCBzcGVjaWZ5IGFuIGFic29sdXRlICIKPiA+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICJwYXRobmFtZSBmb3IgZW52aXJvbm1lbnQgdmFyaWFibGUK
PiA+PiBUTVBESVIiKTsKPiA+PiAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4gPj4gICAg
ICAgICB9Cj4gPj4gKwo+ID4+ICAgICAgICAgcmV0dXJuIGVudl90bXBkaXI7Cj4gPj4gIH0KCj4g
Pj4gLS0KPiA+PiAyLjQwLjAKCgoKPiA+IC0tCj4gPiBSZWdhcmRzLAo+ID4gTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
