Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878A0C0218C
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737537385; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=uqUWSYQRc5KR/IZbIpyU9ruuMs+AF/yj6AjO+ZP5R0Y=;
 b=JOIiHjcqL10TsNqwU8BgkQC/4q0/czCDkGxFwsmqU4QKM4uuiXugWV4W4wW6TbP8fSUJi
 BPJyBJt1yVJYD8QP6xDA0WtK7zvCxLiX17MHARr37PbFf64/EIIF5w/J1X4WYwUrIbRa4Wj
 4m6dXHcP7HDWkCrAzZsAWWUXu+Mj7cQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E13873C2EB2
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 10:16:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 151653C2D8D
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:16:03 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.36.225;
 helo=esa10.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com
 [139.138.36.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 261C01BC7677
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 10:16:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737537363; x=1769073363;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=V9rEerKpSIQIn49rtaU7MFrNSSL6DWeZDuUAcwIqFAI=;
 b=jJJxzDLDgHluVXL5p1Db+h76SLykyAeCfv0fip63T7RwFKVFa3Sj5qP5
 HaHsGmN2UwLou+zDih+u/EhwSDSrW3X4ExgEFJMzh4wLXhJ+oNP/Rfr0o
 gyw6fssZgxNPr/ut8E20QvWyMwTED23QTXgmHNZPeADTsG8SlvQ/td6y9
 LL22wpziWsQ4ptJWO9nViw7FIgTbgI5BipS5IajaOYB+E2r8AtUUH9Cq1
 whkCTnn5pUdz04KNDiw1RBqDMw07Ih0EurnJs/sGObvNJrg8d+rusEul9
 XTP/VOkx3HzyegXqdjPgbjyDdwopjUC8lR4Dm9FmeTnU1IR75NG0sMitT w==;
X-CSE-ConnectionGUID: 8/GLt6SqQgKM4OkPJG8fpg==
X-CSE-MsgGUID: 7ODqLGRVSmyjRmYPWpyvBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="174719488"
X-IronPort-AV: E=Sophos;i="6.13,224,1732546800"; d="scan'208";a="174719488"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 18:16:00 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 72D5DDBB89
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:15:58 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4D838BDC93
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:15:58 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C6AAA20050194
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 18:15:57 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 35D8C1A000B;
 Wed, 22 Jan 2025 17:15:57 +0800 (CST)
Message-ID: <f4acd3b1-0ab9-4b08-b1b2-35b47f8f80d1@fujitsu.com>
Date: Wed, 22 Jan 2025 17:15:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it,
 pvorel@suse.cz
References: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
 <42ef31cf-df74-44fb-83ee-bdbdd32cf7c4@fujitsu.com>
 <79084e14-26f8-4855-a6b3-9a7e9589e881@suse.com>
In-Reply-To: <79084e14-26f8-4855-a6b3-9a7e9589e881@suse.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28938.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28938.006
X-TMASE-Result: 10--17.646400-10.000000
X-TMASE-MatchedRID: vewQ6k4XI8WPvrMjLFD6eHchRkqzj/bEC/ExpXrHizxrWjTeSKKkEV8l
 LUQqq3VylkBoqwBqtMEb5Jor2KH7d6/Elphzpf1LPKN38CLPK0HhKQh1LCmGBhHfiujuTbedPf4
 Utpl5n+6D4phMA3BWnQnSzRYua45AHrdU8b54DYPX3j/lf1V8LGvaomg0i4KNLEzDQUyQGVmmJ5
 jCyUYfidDaNZpK9gNYUH8P2WYi8rUB90FcL1q4MBF4zyLyne+A81hDEI6KFM3jyNl1mysLDjibE
 SY8R8hiQMOJEqjTDACHzK4exfm8m04GO5MhEQotqug9vIA2WODTAe9FsgbYxxd+xtxH8FsxqCfe
 IlEscU69o2p3dj0RfG3+xeYw69R9lFKRvEp4lziEw/pD35FZyEi8rgutezVpnKRrn2xogKiiifM
 nl53xwGWdS71W+uwVvAcVJ5UuETpH6+lhuE4fWl2FnJp+A+KrH4pppXAAbjckt9BigJAcVpifAG
 v6/5D2nUY+WM9pU6r0cbScM0m9+Rccs8336rx5i95/KnWCU3SvOXyw2JYKUpsoi2XrUn/Jsuf7R
 WbvUtz7H+hZKy6/KwtuKBGekqUpIG4YlbCDECvS3Rxy14J4N98AvNIvE423x1Fwmpm9Mga8eJf0
 K+UMNCy+3/CJJkWX66XHIc5w+gc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] fchownat01: Convert to new API
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
From: Shiyang Ruan via ltp <ltp@lists.linux.it>
Reply-To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgrlnKggMjAyNS8xLzIyIDE3OjA4LCBBbmRyZWEgQ2VydmVzYXRvIOWGmemBkzoKPiBIaSBTaGl5
YW5nLAo+IAo+IHdlIGFyZSBub3cgZmFjaW5nIExUUCBjb2RlIGZyZWV6ZSBmb3IgdGhlIG5leHQg
cmVsZWFzZSwgc28gd2UgYXJlIHByZXR0eSAKPiBidXN5LgoKR290IGl0LiAgU29ycnkgZm9yIGJv
dGhlcmluZy4KCj4gSSB3aWxsIHJldmlldyBpdCBhbmQgbWVyZ2UgaXQgYWZ0ZXIgdGhlIHJlbGVh
c2UuCgpUaGFua3MhCgoKLS0KUnVhbi4KCj4gCj4gS2luZCByZWdhcmRzLAo+IEFuZHJlYQo+IAo+
IE9uIDEvMjIvMjUgMDY6NTEsIFNoaXlhbmcgUnVhbiB3cm90ZToKPj4gcGluZ34KPj4KPj4g5Zyo
IDIwMjUvMS8xNiAxNjo0MCwgU2hpeWFuZyBSdWFuIOWGmemBkzoKPj4+IDEuIGNvbnZlcnQgdG8g
bmV3IEFQSQo+Pj4gMi4gbW92ZSBlcnJvciB0ZXN0cyB0byBmY2hvd25hdDAzCj4+PiAzLiBjaGVj
ayBpZiB1aWQvZ2lkIGlzIGNvcnJlY3RseSBzZXQKPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGl5
YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPgo+Pj4KPj4+IC0tLQo+Pj4gVjI6IAo+
Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjUwMTE1MDkxMjE4LjI2MzA4OTEtMS1y
dWFuc3kuZm5zdEBmdWppdHN1LmNvbS8KPj4+Cj4+PiBDaGFuZ2VzOgo+Pj4gwqAgKiBJbml0aWFs
aXplIGZkIHRvIC0xLCBhbmQgY2hlY2sgZmQgIT0gLTEgd2hlbiBjbGVhbnVwCj4+PiDCoCAqIERv
IG5vdCB1c2UgVFNUXypfU0lMRU5UKCkKPj4+IMKgICogZmNob3duYXQwMTogZGVzY3JpYmUgd2hh
dCB0aGlzIGNhc2UgZG9lcyBpbiBERVNDUklQVElPTgo+Pj4gwqAgKiBmY2hvd25hdDAxOiB1c2Ug
VFNUX0VYUF9FUV9MSSgpOyBkbyBub3QgdXNlIHRlc3QgY2FzZSBzdHJ1Y3QKPj4+IMKgICogZmNo
b3duYXQwMjogdXNlIFRTVF9FWFBfRVhQUigpCj4+PiDCoCAqIGZjaG93bmF0MDM6IHdyaXRlIGEg
cHJvcGVyIGNvbW1pdCBtZXNzYWdlLCBhZGQgbW9yZSBlcnJub3MgdG8gdGVzdAo+Pj4KPj4+IC0t
LQo+Pj4gwqAgLi4uL2tlcm5lbC9zeXNjYWxscy9mY2hvd25hdC9mY2hvd25hdDAxLmPCoMKgwqDC
oCB8IDE1MyArKysrKy0tLS0tLS0tLS0tLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA0MiBpbnNl
cnRpb25zKCspLCAxMTEgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZmNob3duYXQvZmNob3duYXQwMS5jIAo+Pj4gYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2ZjaG93bmF0L2ZjaG93bmF0MDEuYwo+Pj4gaW5kZXggNzc3MWMxMTFh
Li5mZWRjYjhhYjIgMTAwNjQ0Cj4+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zj
aG93bmF0L2ZjaG93bmF0MDEuYwo+Pj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
Y2hvd25hdC9mY2hvd25hdDAxLmMKPj4+IEBAIC0xLDEzMyArMSw2NCBAQAo+Pj4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4+PiDCoCAvKgo+Pj4gLSAqwqDC
oCBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXPCoCBDb3JwLiwg
MjAwNgo+Pj4gLSAqwqDCoCBBVVRIT1I6IFlpIFlhbmcgPHl5YW5nY2RsQGNuLmlibS5jb20+Cj4+
PiAtICoKPj4+IC0gKsKgwqAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7wqAgeW91IGNh
biByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIAo+Pj4gbW9kaWZ5Cj4+PiAtICrCoMKgIGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgCj4+PiBwdWJs
aXNoZWQgYnkKPj4+IC0gKsKgwqAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVy
IHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKPj4+IC0gKsKgwqAgKGF0IHlvdXIgb3B0aW9u
KSBhbnkgbGF0ZXIgdmVyc2lvbi4KPj4+IC0gKgo+Pj4gLSAqwqDCoCBUaGlzIHByb2dyYW0gaXMg
ZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwKPj4+IC0gKsKg
wqAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZO8KgIHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW50eSBvZgo+Pj4gLSAqwqDCoCBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuwqAgU2VlCj4+PiAtICrCoMKgIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgo+Pj4gLSAqCj4+PiAtICrCoMKgIFlvdSBzaG91
bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
Cj4+PiAtICrCoMKgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtO8KgIGlmIG5vdCwgd3JpdGUgdG8g
dGhlIEZyZWUgU29mdHdhcmUgCj4+PiBGb3VuZGF0aW9uLAo+Pj4gLSAqwqDCoCBJbmMuLCA1MSBG
cmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEgVVNBCj4+
PiArICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzwqAgQ29y
cC4sIDIwMDYKPj4+ICsgKiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAwNy0y
MDI1Cj4+PiDCoMKgICovCj4+PiAtLyoKPj4+IC0gKiBERVNDUklQVElPTgo+Pj4gLSAqwqDCoMKg
IFRoaXMgdGVzdCBjYXNlIHdpbGwgdmVyaWZ5IGJhc2ljIGZ1bmN0aW9uIG9mIGZjaG93bmF0Cj4+
PiAtICrCoMKgwqAgYWRkZWQgYnkga2VybmVsIDIuNi4xNiBvciB1cC4KPj4+ICsKPj4+ICsvKlwK
Pj4+ICsgKiBbRGVzY3JpcHRpb25dCj4+PiArICoKPj4+ICsgKiBWZXJpZnkgdGhhdCBmY2hvd25h
dCgpIHN1Y2NlZWRzIHRvIGNoYW5nZSBmaWxlJ3Mgb3duZXJzaGlwIGlmIHRoZSAKPj4+IGZpbGUK
Pj4+ICsgKiBkZXNjcmlwdG9yIGlzIEFUX0ZEQ1dEIG9yIHNldCBieSBvcGVuaW5nIGEgZGlyZWN0
b3J5Lgo+Pj4gwqDCoCAqLwo+Pj4gwqAgwqAgI2RlZmluZSBfR05VX1NPVVJDRQo+Pj4gKyNpbmNs
dWRlICJ0c3RfdGVzdC5oIgo+Pj4gwqAgLSNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KPj4+IC0jaW5j
bHVkZSA8c3lzL3N0YXQuaD4KPj4+IC0jaW5jbHVkZSA8dW5pc3RkLmg+Cj4+PiAtI2luY2x1ZGUg
PHN0ZGxpYi5oPgo+Pj4gLSNpbmNsdWRlIDxlcnJuby5oPgo+Pj4gLSNpbmNsdWRlIDxzdHJpbmcu
aD4KPj4+IC0jaW5jbHVkZSA8c2lnbmFsLmg+Cj4+PiAtCj4+PiAtI2luY2x1ZGUgInRlc3QuaCIK
Pj4+IC0jaW5jbHVkZSAic2FmZV9tYWNyb3MuaCIKPj4+IC0jaW5jbHVkZSAibGFwaS9mY250bC5o
Igo+Pj4gKyNkZWZpbmUgVEVTVEZJTEUxwqDCoMKgICJ0ZXN0ZmlsZTEiCj4+PiArI2RlZmluZSBU
RVNURklMRTLCoMKgwqAgInRlc3RmaWxlMiIKPj4+IMKgIC0jZGVmaW5lIFRFU1RGSUxFwqDCoMKg
ICJ0ZXN0ZmlsZSIKPj4+ICtzdGF0aWMgdWlkX3Qgc2V0X3VpZCA9IDEwMDA7Cj4+PiArc3RhdGlj
IGdpZF90IHNldF9naWQgPSAxMDAwOwo+Pj4gK3N0YXRpYyBpbnQgZGlyX2ZkID0gLTE7Cj4+PiDC
oCAtc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7Cj4+PiAtc3RhdGljIHZvaWQgY2xlYW51cCh2b2lk
KTsKPj4+IC0KPj4+IC1zdGF0aWMgaW50IGRpcl9mZDsKPj4+IC1zdGF0aWMgaW50IGZkOwo+Pj4g
LXN0YXRpYyBpbnQgbm9fZmQgPSAtMTsKPj4+IC1zdGF0aWMgaW50IGN1X2ZkID0gQVRfRkRDV0Q7
Cj4+PiAtCj4+PiAtc3RhdGljIHN0cnVjdCB0ZXN0X2Nhc2VfdCB7Cj4+PiAtwqDCoMKgIGludCBl
eHBfcmV0Owo+Pj4gLcKgwqDCoCBpbnQgZXhwX2Vycm5vOwo+Pj4gLcKgwqDCoCBpbnQgZmxhZzsK
Pj4+IC3CoMKgwqAgaW50ICpmZHM7Cj4+PiAtwqDCoMKgIGNoYXIgKmZpbGVuYW1lczsKPj4+IC19
IHRlc3RfY2FzZXNbXSA9IHsKPj4+IC3CoMKgwqAgezAsIDAsIDAsICZkaXJfZmQsIFRFU1RGSUxF
fSwKPj4+IC3CoMKgwqAgey0xLCBFTk9URElSLCAwLCAmZmQsIFRFU1RGSUxFfSwKPj4+IC3CoMKg
wqAgey0xLCBFQkFERiwgMCwgJm5vX2ZkLCBURVNURklMRX0sCj4+PiAtwqDCoMKgIHstMSwgRUlO
VkFMLCA5OTk5LCAmZGlyX2ZkLCBURVNURklMRX0sCj4+PiAtwqDCoMKgIHswLCAwLCAwLCAmY3Vf
ZmQsIFRFU1RGSUxFfSwKPj4+IC19Owo+Pj4gLQo+Pj4gLWNoYXIgKlRDSUQgPSAiZmNob3duYXQw
MSI7Cj4+PiAtaW50IFRTVF9UT1RBTCA9IEFSUkFZX1NJWkUodGVzdF9jYXNlcyk7Cj4+PiAtc3Rh
dGljIHZvaWQgZmNob3duYXRfdmVyaWZ5KGNvbnN0IHN0cnVjdCB0ZXN0X2Nhc2VfdCAqKTsKPj4+
IC0KPj4+IC1pbnQgbWFpbihpbnQgYWMsIGNoYXIgKiphdikKPj4+ICtzdGF0aWMgdm9pZCBmY2hv
d25hdF92ZXJpZnkodm9pZCkKPj4+IMKgIHsKPj4+IC3CoMKgwqAgaW50IGxjOwo+Pj4gLcKgwqDC
oCBpbnQgaTsKPj4+ICvCoMKgwqAgc3RydWN0IHN0YXQgc3RhdF9idWY7Cj4+PiDCoCAtwqDCoMKg
IHRzdF9wYXJzZV9vcHRzKGFjLCBhdiwgTlVMTCwgTlVMTCk7Cj4+PiArwqDCoMKgIFRTVF9FWFBf
UEFTUyhmY2hvd25hdChBVF9GRENXRCwgVEVTVEZJTEUxLCBzZXRfdWlkLCBzZXRfZ2lkLCAwKSwK
Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImZjaG93bmF0KCVkLCAlcywgJWQsICVkLCAw
KSIsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFUX0ZEQ1dELCBURVNURklMRTEsIHNl
dF91aWQsIHNldF9naWQpOwo+Pj4gwqAgLcKgwqDCoCBzZXR1cCgpOwo+Pj4gK8KgwqDCoCBTQUZF
X1NUQVQoVEVTVEZJTEUxLCAmc3RhdF9idWYpOwo+Pj4gK8KgwqDCoCBUU1RfRVhQX0VRX0xJKHN0
YXRfYnVmLnN0X3VpZCwgc2V0X3VpZCk7Cj4+PiArwqDCoMKgIFRTVF9FWFBfRVFfTEkoc3RhdF9i
dWYuc3RfZ2lkLCBzZXRfZ2lkKTsKPj4+IMKgIC3CoMKgwqAgZm9yIChsYyA9IDA7IFRFU1RfTE9P
UElORyhsYyk7IGxjKyspIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCB0c3RfY291bnQgPSAwOwo+Pj4g
LcKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBUU1RfVE9UQUw7IGkrKykKPj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZjaG93bmF0X3ZlcmlmeSgmdGVzdF9jYXNlc1tpXSk7Cj4+PiAt
wqDCoMKgIH0KPj4+ICvCoMKgwqAgVFNUX0VYUF9QQVNTKGZjaG93bmF0KGRpcl9mZCwgVEVTVEZJ
TEUyLCBzZXRfdWlkLCBzZXRfZ2lkLCAwKSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ImZjaG93bmF0KCVkLCAlcywgJWQsICVkLCAwKSIsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGRpcl9mZCwgVEVTVEZJTEUyLCBzZXRfdWlkLCBzZXRfZ2lkKTsKPj4+IMKgIC3CoMKgwqAg
Y2xlYW51cCgpOwo+Pj4gLcKgwqDCoCB0c3RfZXhpdCgpOwo+Pj4gK8KgwqDCoCBTQUZFX1NUQVQo
VEVTVEZJTEUyLCAmc3RhdF9idWYpOwo+Pj4gK8KgwqDCoCBUU1RfRVhQX0VRX0xJKHN0YXRfYnVm
LnN0X3VpZCwgc2V0X3VpZCk7Cj4+PiArwqDCoMKgIFRTVF9FWFBfRVFfTEkoc3RhdF9idWYuc3Rf
Z2lkLCBzZXRfZ2lkKTsKPj4+IMKgIH0KPj4+IMKgIMKgIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQp
Cj4+PiDCoCB7Cj4+PiAtwqDCoMKgIHRzdF9zaWcoTk9GT1JLLCBERUZfSEFORExFUiwgY2xlYW51
cCk7Cj4+PiAtCj4+PiAtwqDCoMKgIFRFU1RfUEFVU0U7Cj4+PiAtCj4+PiAtwqDCoMKgIHRzdF90
bXBkaXIoKTsKPj4+IC0KPj4+IC3CoMKgwqAgZGlyX2ZkID0gU0FGRV9PUEVOKGNsZWFudXAsICIu
LyIsIE9fRElSRUNUT1JZKTsKPj4+IC0KPj4+IC3CoMKgwqAgU0FGRV9UT1VDSChjbGVhbnVwLCBU
RVNURklMRSwgMDYwMCwgTlVMTCk7Cj4+PiAtCj4+PiAtwqDCoMKgIGZkID0gU0FGRV9PUEVOKGNs
ZWFudXAsICJ0ZXN0ZmlsZTIiLCBPX0NSRUFUIHwgT19SRFdSLCAwNjAwKTsKPj4+IC19Cj4+PiAt
Cj4+PiAtc3RhdGljIHZvaWQgZmNob3duYXRfdmVyaWZ5KGNvbnN0IHN0cnVjdCB0ZXN0X2Nhc2Vf
dCAqdGVzdCkKPj4+IC17Cj4+PiAtwqDCoMKgIFRFU1QoZmNob3duYXQoKih0ZXN0LT5mZHMpLCB0
ZXN0LT5maWxlbmFtZXMsIGdldGV1aWQoKSwKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBnZXRlZ2lkKCksIHRlc3QtPmZsYWcpKTsKPj4+IC0KPj4+IC3CoMKgwqAgaWYgKFRFU1RfUkVU
VVJOICE9IHRlc3QtPmV4cF9yZXQpIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCB0c3RfcmVzbShURkFJ
TCB8IFRURVJSTk8sCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJmY2hvd25hdCgpIHJl
dHVybmVkICVsZCwgZXhwZWN0ZWQgJWQsIGVycm5vPSVkIiwKPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgVEVTVF9SRVRVUk4sIHRlc3QtPmV4cF9yZXQsIHRlc3QtPmV4cF9lcnJubyk7Cj4+
PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4gLcKgwqDCoCB9Cj4+PiAtCj4+PiAtwqDCoMKg
IGlmIChURVNUX0VSUk5PID09IHRlc3QtPmV4cF9lcnJubykgewo+Pj4gLcKgwqDCoMKgwqDCoMKg
IHRzdF9yZXNtKFRQQVNTIHwgVFRFUlJOTywKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ImZjaG93bmF0KCkgcmV0dXJuZWQgdGhlIGV4cGVjdGVkIGVycm5vICVkOiAlcyIsCj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRlc3QtPmV4cF9yZXQsIHN0cmVycm9yKHRlc3QtPmV4cF9l
cnJubykpOwo+Pj4gLcKgwqDCoCB9IGVsc2Ugewo+Pj4gLcKgwqDCoMKgwqDCoMKgIHRzdF9yZXNt
KFRGQUlMIHwgVFRFUlJOTywKPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgImZjaG93bmF0
KCkgZmFpbGVkIHVuZXhwZWN0ZWRseTsgZXhwZWN0ZWQ6ICVkIC0gJXMiLAo+Pj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB0ZXN0LT5leHBfZXJybm8sIHN0cmVycm9yKHRlc3QtPmV4cF9lcnJu
bykpOwo+Pj4gLcKgwqDCoCB9Cj4+PiArwqDCoMKgIGRpcl9mZCA9IFNBRkVfT1BFTigiLi8iLCBP
X0RJUkVDVE9SWSk7Cj4+PiArwqDCoMKgIFNBRkVfVE9VQ0goVEVTVEZJTEUxLCAwNjAwLCBOVUxM
KTsKPj4+ICvCoMKgwqAgU0FGRV9UT1VDSChURVNURklMRTIsIDA2MDAsIE5VTEwpOwo+Pj4gwqAg
fQo+Pj4gwqAgwqAgc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+Pj4gwqAgewo+Pj4gLcKgwqDC
oCBpZiAoZmQgPiAwKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGNsb3NlKGZkKTsKPj4+IC0KPj4+IC3C
oMKgwqAgaWYgKGRpcl9mZCA+IDApCj4+PiAtwqDCoMKgwqDCoMKgwqAgY2xvc2UoZGlyX2ZkKTsK
Pj4+IC0KPj4+IC3CoMKgwqAgdHN0X3JtZGlyKCk7Cj4+PiArwqDCoMKgIGlmIChkaXJfZmQgIT0g
LTEpCj4+PiArwqDCoMKgwqDCoMKgwqAgU0FGRV9DTE9TRShkaXJfZmQpOwo+Pj4gwqAgfQo+Pj4g
Kwo+Pj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPj4+ICvCoMKgwqAgLm5lZWRz
X3RtcGRpciA9IDEsCj4+PiArwqDCoMKgIC5uZWVkc19yb290ID0gMSwKPj4+ICvCoMKgwqAgLnRl
c3RfYWxsID0gZmNob3duYXRfdmVyaWZ5LAo+Pj4gK8KgwqDCoCAuc2V0dXAgPSBzZXR1cCwKPj4+
ICvCoMKgwqAgLmNsZWFudXAgPSBjbGVhbnVwLAo+Pj4gK307CgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
