Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F12AC4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 09:34:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 090C03CC1F3
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 10:34:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A11913C8121
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 10:34:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B101C1A07C99
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 10:34:09 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1C98E21B5B;
 Mon,  5 Dec 2022 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670232849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHAYVIn7dBInOMTg8XcPlGc2qF9sp92bpWBIVbh9wGg=;
 b=e+dBxLkDJSRAnHVPQvTvSlUuYKlYCWSSvsO6/HJrn985s1f0Nly5qVrHJY8Ew8Y0Ju9K/T
 8mFb8105Bsh5pVvSaSgTx1AJMrsxGxB3cs738sRcU44hrNAPKBXQFYh/T2GQWN9QY/8S/d
 RJDe8Pr0vnIH95g8REMSsf7xzqvrXIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670232849;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHAYVIn7dBInOMTg8XcPlGc2qF9sp92bpWBIVbh9wGg=;
 b=IAQb60KMrFypvBYOiXeKv2FmerYQaoC2l3GWB9Q95+xwlS3jIUq+j7IXp46FLHsQHdzIUu
 VCt9izu8xvXSwnBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 749452C141;
 Mon,  5 Dec 2022 09:34:08 +0000 (UTC)
References: <2jtq51qy5gn-2jttyv77ay0@nsmail7.0.0--kylin--1>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: =?utf-8?B?5pu+57qi546y?= <zenghongling@kylinos.cn>
Date: Mon, 05 Dec 2022 09:31:08 +0000
Organization: Linux Private Site
In-reply-to: <2jtq51qy5gn-2jttyv77ay0@nsmail7.0.0--kylin--1>
Message-ID: <878rjmurcf.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 
 =?utf-8?b?5Zue5aSNOiBSZTogIFtQQVRDSF0gbWtmczogcmVsYXggc2l6?=
 =?utf-8?q?e_check?=
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpQbGVhc2UgY29uZmlndXJlIHlvdXIgZS1tYWlsIGNsaWVudCB0byBzZW5kIHBsYWlu
IHRleHQgZS1tYWlscyAobm90CkhUTUwpLgoKWW91ciBIVE1MIGUtbWFpbHMgYXJlIGJlaW5nIGln
bm9yZWQgYnkgc29tZSB0b29saW5nLgoK5pu+57qi546yIDx6ZW5naG9uZ2xpbmdAa3lsaW5vcy5j
bj4gd3JpdGVzOgoKPiBIaToKPgo+ICAgVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciByZXBs
eSxJIHdpbGwgdGVzdCBpdCBieSB2MS40Ni41IG9mIGUyZnNwcm9ncy4KPgo+IC0tLS0KPgo+IOS4
u+OAgOmimO+8mlJlOiBbTFRQXSBbUEFUQ0hdIG1rZnM6IHJlbGF4IHNpemUgY2hlY2sgCj4g5pel
44CA5pyf77yaMjAyMi0xMS0zMCAxNjowNiAKPiDlj5Hku7bkurrvvJpwdm9yZWwgCj4g5pS25Lu2
5Lq677ya5pu+57qi546yO2x0cDsKPgo+IEhpIGFsbCwKPgo+PiBIaSB6ZW5naG9uZ2xpbmcsCj4K
Pj4gPiBOdW1iZXIgb2YgdG90YWwgZGF0YSBibG9ja3MgaW4gZmlsZXN5c3RlbSByZXBvcnRlZCBi
eSBzdGF0ZnMKPj4gPiBtYXkgYmUgbGVzcyB0aGFuIGN1cnJlbnQgZm9ybXVsYSBvZiA5MCUuIEZv
ciBleGFtcGxlIGV4dDQgd2lsbAo+PiA+IHN1YnRyYWN0ICJzX2ZpcnN0X2RhdGFfYmxvY2sgcGx1
cyBpbnRlcm5hbCBqb3VybmFsIGJsb2NrcyIuCj4KPj4gPiBXaXRoIHJlY2VudCBjaGFuZ2UgdG8g
ZTJmc3Byb2dzLCBvdmVyaGVhZCBjYWxjdWxhdGVkIGluIHVzZXItc3BhY2UgaW5jcmVhc2VkCj4+
IERvIHlvdSBrbm93IGluIHdoaWNoIHZlcnNpb24gaXQgZ290IGNoYW5nZWQ/Cj4KPiBGb3IgYSBy
ZWNvcmQsIHplbmdob25nbGluZyBzZW5kIGh0bWwgbWFpbAo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2x0cC8yb2MxZGVocm9idi0yb2M1Nzd5MHR0OEBuc21haWw3LjAuMC0ta3lsaW4tLTEvVC8j
dQo+Cj4gdGh1cyByZXBlYXQgaXQgaGVyZTogdGhlIGFmZmVjdGVkIGNvbW1pdCBpcyBoZXJlOgo+
IGh0dHBzOi8vZ2l0aHViLmNvbS90eXRzby9lMmZzcHJvZ3MvY29tbWl0LzU5MDM3YzUzNTdkMzlj
NmQwZjE0YTBhZmY3MGU2N2RjMTNlYWZjODQKPiB3aGljaCBpcyBmcm9tIHYxLjQ2LjAuCj4KPiBJ
J20gdGVzdGluZyBpdCBvbiBvcGVuU1VTRSB3aXRoIDEuNDYuNSBhbmQgaXQgZG9lcyBub3QgaGF2
ZSBwcm9ibGVtLgo+IE1heWJlIHRoZXJlIGlzIHNvbWUgcHJvYmxlbSBvbiB0aGUgc3lzdGVtIHlv
dSB0ZXN0IGFuZCBsb3dlciB0aGUgYmFycmllciB5b3UKPiBqdXN0IGhpZGUgaXQuIE1heWJlIG90
aGVycyBzZWUgaXQgZGlmZmVyZW50bHkuCj4KPj4gTWF5YmUgaXQnZCBiZSB3b3J0aCB0byBtZW50
aW9uIHRoYXQgdG8gZXh0NCBtYWludGFpbmVycywKPj4ganVzdCB0byBiZSBzdXJlIGl0J3Mgbm90
IGEgcmVncmVzc2lvbi4KPgo+PiA+IHNsaWdodGx5IGFuZCBMVFAgdGVzdCBzdGFydGVkIGZhaWxp
bmc6IHR5dHNvL2UyZnNwcm9ncwo+PiBBIGJpdCBjcnlwdGljIGRlc2NyaXB0aW9uIDooLiBZb3Ug
bWVhbiBwcm9iYWJseSBodHRwczovL2dpdGh1Yi5jb20vdHl0c28vZTJmc3Byb2dzCj4+IHdoaWNo
IGlzIGFsc28gb24KPj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2ZzL2V4dDIvZTJm
c3Byb2dzLmdpdC8KPgo+IEB6ZW5naG9uZ2xpbmcgYmFzaWMgbWFpbGluZyBsaXN0IHJ1bGVzCj4g
MSkgc2VudCB0ZXh0L3BsYWluIChub3QgdGV4dC9odG1sKSwgb3RoZXJ3aXNlIG1haWwgaXMgbm90
IHJlYWRhYmxlCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzJvYzFkZWhyb2J2LTJvYzU3
N3kwdHQ4QG5zbWFpbDcuMC4wLS1reWxpbi0tMS9ULyN1Cj4gYW5kIG5vdCBldmVuIGluIHBhdGNo
d29yazoKPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL3BhdGNoLzE2
Njk2OTE4MzEtMjM0NTYtMS1naXQtc2VuZC1lbWFpbC16ZW5naG9uZ2xpbmdAa3lsaW5vcy5jbi8K
Pgo+IENvbXBhcmUgd2l0aCBteSBtYWlsOgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC9Z
NFhkNGpkJTJGWDV6c21vcUhAcGV2aWsvVC8jbTc2ZDRhZTNmMzk2YTZhZTYzMzgyY2I1NjljMzNk
OGM3NDZjZTA5NzQKPgo+IE1vcmUgaW5zdHJ1Y3Rpb25zIGFyZToKPiBodHRwczovL3d3dy5rZXJu
ZWwub3JnL2RvYy9odG1sL2xhdGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI25v
LW1pbWUtbm8tbGlua3Mtbm8tY29tcHJlc3Npb24tbm8tYXR0YWNobWVudHMtanVzdC1wbGFpbi10
ZXh0Cj4KPiAyKSByZXBseSB0byBtYWlsIHRocmVhZCBzbyB0aGF0IG1haWwgaXMgY29ubmVjdGVk
IHRvIHRoZSB0aHJlYWQKPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9w
cm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2V4cGxpY2l0LWluLXJlcGx5LXRvLWhlYWRl
cnMKPgo+IEFjdHVhbGx5IG1vc3Qgb2YgdGhlIHJlYWRpbmcgZm9yIGtlcm5lbCBhcHBsaWVzIHRv
IExUUCBhcyB3ZWxsCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJv
Y2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbAo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKCgot
LSAKVGhhbmsgeW91LApSaWNoYXJkLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
