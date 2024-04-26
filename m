Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC068C4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 09:42:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B0023D035D
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 11:42:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A91953CFED3
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 11:42:29 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=15.184.82.18; helo=smtpbg156.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B7FE7600074
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 11:42:25 +0200 (CEST)
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-FEAT: w1YG9MRGEBJkEBWN5ZFxjL4JvPJnsBvzr+3CdRnf2YK3GYBGevzRjqQMuPJEd
 U3yAxOtYjjEnRxSZ9RjEaIC46axKGiuy8+lVLmqhw0Ba6ZsFZubZCktgcDGgHUMlNiIJBHd
 WPMlz/ZBaUCJD5ceCZeZbOWHK1D7c/+DMSbpJ1/pTvP9aKNmuw1y6Ov2aP6746UAbWW8kTC
 8cspJ7HBI2qPpplYstdCpZcQlJSpexOnTeol1u2yKnUCSP74/LqdoPerT24OjL+XfwmBYMx
 Dh1nVOapQq/gtg4ebPNc+1mStdwhWRYTqpiLzBAbu20prRG7BgV4eJO6hQzmLDrV6P65Eje
 DpeC0Rd8lpprD1MbiOID3aDg+zKr1TvDyRggDbbQ8YaUxXLBy9DZ8wxowUUltPXdJ1ZEZ49
 NTd/vc5IbJk/FK7W7VxNGX2SfcLQI7zX
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: FpK3mFou9gePOTcKt6p/BNtckzAKTOodOVPWUOqZchE=
X-Originating-IP: 125.76.39.228
X-QQ-STYLE: 
X-QQ-mid: t5gz6a-3t1714124539t889914
From: "=?utf-8?B?6Lev5paQ?=" <lufei@uniontech.com>
To: "=?utf-8?B?Q3lyaWwgSHJ1Ymlz?=" <chrubis@suse.cz>
Mime-Version: 1.0
Date: Fri, 26 Apr 2024 09:42:18 +0000
X-Priority: 3
Message-ID: <tencent_42AB1A7801A243DA5A5D51C0@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240419070717.2506101-1-lufei@uniontech.com>
 <20240421071539.2547355-1-lufei@uniontech.com>
 <Zitniv9NFio-HOGo@yuki>
In-Reply-To: <Zitniv9NFio-HOGo@yuki>
X-QQ-ReplyHash: 1635227228
X-BIZMAIL-ID: 17168814619808614649
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Fri, 26 Apr 2024 17:42:21 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-1
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] (no subject)
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
Cc: =?utf-8?B?bHRw?= <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SSB0cmllZCB1c2luZyBOVUxMLCBidXQgbWV0IGBUQlJPSzogVGVzdCBraWxsZWQgYnkgU0lHU0VH
ViFgLiZuYnNwOw0KDQoNCkFuZCB0aGUgbGFzdCB0aW1lIHlvdSBtZW50aW9uZWQgaW4gcmVzcG9u
c2UgdG8gdXNpbmcgYHN1cHBvcnRlZF9hcmNoc2AsIHRoaXMgc2VlbXMgbm90IHdvcmsgcHJvcGVy
bHkgYnkgbm93LCB0aGUgbHRwIGRvY3VtZW50KHNlY3Rpb24gb2Ygd3JpdGluZ190ZXN0cykgc2F5
cyAibm90IGFwcGxpY2FibGUiLg0KJm5ic3A7DQoNCg0KDQoNCg0KDQog6Lev5paQIEZlaS5MdQ0K
5bmz5Y+w5rWL6K+V6YOowqDpq5jnuqfmtYvor5XlvIDlj5Hlt6XnqIvluIgNCue7n+S/oei9r+S7
tg0K5LyB5Lia5a6Y572R77yad3d3LnVuaW9udGVjaC5jb20NCuiBlOezu+aWueW8j++8mjE4NTAx
MDEyMzUyDQrlip7lhazlnLDlnYDvvJropb/lronluILpm4HloZTljLrkupHmsLTkuIDot6/kuI7l
pKnosLflhavot6/lj6Pova/ku7bmlrDln47kuozmnJ9DMi0yMOWxgg0KDQoNCg0KICANCg0KJm5i
c3A7DQombmJzcDsNCiZuYnNwOw0KLS0tLS0tLS0tLS0tLS0tLS0tJm5ic3A7T3JpZ2luYWwmbmJz
cDstLS0tLS0tLS0tLS0tLS0tLS0NCkZyb206ICJDeXJpbCZuYnNwO0hydWJpcyI7IA0KRGF0ZTog
MjAyNOW5tDTmnIgyNuaXpSjmmJ/mnJ/kupQpIOS4iuWNiDg6MzcNClRvOiAibHVmZWkiOyANCkNj
OiAibHRwIjsgDQpTdWJqZWN0OiBSZToNCg0KJm5ic3A7DQpIaSENCiZndDsgU29tZSBvZiB5b3Vy
IHBvaW50IGhhcyBiZWVuIGZpeGVkLiBTb21lIGFyZSBub3Q6DQomZ3Q7IDEuIEknbSB1c2luZyBn
Y2MgKEdDQykgMTEuNC4xIDIwMjMwNjA1LCBgYWRkcmAgd2l0aG91dCBpbml0aWFsaXphdGlvbiB3
b3VsZCBvdXRwdXQgc29tZSB3YXJuaW5ncy4NCiZndDsgMi4gSSByZWFkIHRoZSBtYW5wYWdlIG9m
IGFyY2hfcHJjdGwsIHRoZSBBUkNIX0dFVF9DUFVJRCBzZWVtcyByZXR1cm4gdGhlIGZsYWcsIGlu
c3RlYWQgb2Ygc3RvcmluZyBgYWRkcmA6DQomZ3Q7IGBgYA0KJmd0OyBBUkNIX0dFVF9DUFVJRCAo
c2luY2UgTGludXggNC4xMikNCiZndDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgUmV0dXJu
IHRoZSBzZXR0aW5nIG9mIHRoZSBmbGFnIG1hbmlwdWxhdGVkIGJ5IEFSQ0hfU0VUX0NQVUlEIGFz
IHRoZSByZXN1bHQgb2YgdGhlIHN5c3RlbSBjYWxsICgxJm5ic3A7IGZvciZuYnNwOyBlbmFibGVk
LCZuYnNwOyAwJm5ic3A7IGZvcg0KJmd0OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyBkaXNh
YmxlZCkuJm5ic3A7IGFkZHIgaXMgaWdub3JlZC4NCiZndDsgYGBgDQoNCkFoIHJpZ2h0LCBpZiBh
ZGRyIGlzIGlnbm9yZWQganVzdCBwYXNzIE5VTEwgdGhlcmUgaW5zdGVhZC4NCg0KLS0gDQpDeXJp
bCBIcnViaXMNCmNocnViaXNAc3VzZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
