Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48816C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:28:34 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC96261AD2
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BC96261AD2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 975363C87FE
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 09:28:30 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AFBD3C320C
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 09:28:19 +0100 (CET)
Received: from mail1.bemta25.messagelabs.com (mail1.bemta25.messagelabs.com
 [195.245.230.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EBBFE6013EA
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 09:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1637310497; i=@fujitsu.com;
 bh=3zN04v7sbbyqfPQAAY+/XEfN0v15M2Up5s8lOI4kg0g=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 b=sBWGCHdicVsQeuzHKsiEyLxR7+sAFr96Qr+2ItePu18f3us48t+kYPqBwr9aZDbYF
 QyyBpfUBUFeTTj/w0TIRaYVavvQIOaoKN/k9nXD0tCtYnkWkvabFSaOBOrCboP44Jh
 qFTvsfYlQR9iaUJWyOvFtCnrQJP41ERLHdUTTjll3cKNqxOPtitjNim48rTSsHYlJT
 Cq+nJhMvzfbQRqUODIU98un0LM9yQL7+rlPncHKtWm+YaPh9Vzoz+vCT7hv6b9oMj2
 E+EurminVd9uo37cIZHf8CCdJDpH+8iXkCG+NgCxq/pee92rZErvPXIvYcYpxwP3bn
 0n2+bsEOHEGxw==
Received: from [100.112.196.154] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-1.bemta.az-b.eu-west-1.aws.symcld.net id C2/A1-01873-12067916;
 Fri, 19 Nov 2021 08:28:17 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRWlGSWpSXmKPExsViZ8ORqKuYMD3
 R4O5ZHosV33cwOjB67Pu9jjWAMYo1My8pvyKBNePL11lsBdf4Kya+W8nUwHict4uRi0NI4Cyj
 xIEPpxkhnJ1MEpuaGpkhnD2MEr+WvmbvYuTkYBPQlHjWuYAZxBYRkJDoaHgLFmcWUJdYPukXU
 xcjB4ewgK/EiWtgYRYBVYlHKy+D2bwCnhJHbs4Ea5UQUJCY8vA9M0RcUOLkzCcsEGM0JVq3/4
 YaKS/RvHU2VL2ixKWOb4wQdoXErFltTBC2msTVc5uYJzAKzEIyahaSUbOQjFrAyLyK0SKpKDM
 9oyQ3MTNH19DAQNfQ0EjX0NJC19DCTC+xSjdJL7VUtzy1uETXUC+xvFivuDI3OSdFLy+1ZBMj
 MIBTCo7t2sH49vUHvUOMkhxMSqK8amHTE4X4kvJTKjMSizPii0pzUosPMcpwcChJ8NrFAuUEi
 1LTUyvSMnOA0QSTluDgURLh/Q2S5i0uSMwtzkyHSJ1iVJQS5zWJB0oIgCQySvPg2mARfIlRVk
 qYl5GBgUGIpyC1KDezBFX+FaM4B6OSMMQUnsy8Erjpr4AWMwEtlr08GWRxSSJCSqqB6fCqNqf
 f7fa7u9v7L50508lk8lIoa0b+79RI8+P9TExqNVnLHN8ktXF/Udj6YMpqLp/lDq/uqy4uMDU1
 i7MX/rPb8cSWXbYzP/7aeT46uvEnQ5TU9JM/1wjL31aTbfdPrLA0v3aw1JaXwyQoYcvX+U13P
 s6orSj+unzt9aZdkflHEgu5b0dNLHhoKL7fVLrOPj6L9U1yTG/0rguzS0Oe79DQ6NmZwdpvOm
 Nll/Xp19WvbmqfPKwpIDU1+/O5KfcithzO3dt8Kf/fTrWN12ODPrOZtRnInYs7dofvhryrjLw
 zw9VzazSOvvw2Za/DB/+syUdZvMO0hKQWvtF81/1oxe9Mu9uLGK5xe+pfv69vo8RSnJFoqMVc
 VJwIAOTI33VbAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-291.messagelabs.com!1637310496!189092!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1921 invoked from network); 19 Nov 2021 08:28:17 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-21.tower-291.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 19 Nov 2021 08:28:17 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id AFD5C100242
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:28:16 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A2546100232
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:28:16 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Fri, 19 Nov 2021 08:28:06 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Fri, 19 Nov 2021 16:28:41 +0800
Message-ID: <1637310522-19620-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] syscalls/statx01: Fix compiler warning because of
 PRIu64
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

d2FybmluZzogZm9ybWF0IOKAmCVsdeKAmSBleHBlY3RzIGFyZ3VtZW50IG9mIHR5cGUg4oCYbG9u
ZyB1bnNpZ25lZCBpbnTigJksCmJ1dCBhcmd1bWVudCA1IGhhcyB0eXBlIOKAmF9fdTY04oCZIHth
a2Eg4oCYbG9uZyBsb25nIHVuc2lnbmVkIGludOKAmX0KClNpZ25lZC1vZmYtYnk6IFlhbmcgWHUg
PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9zdGF0eC9zdGF0eDAxLmMgfCA4ICsrKystLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N0YXR4L3N0YXR4MDIuYyB8IDQgKystLQogMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9zdGF0eC9zdGF0eDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4L3N0YXR4
MDEuYwppbmRleCAyMzU4ZGQ3YmMuLjEyODkzNjZiOSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0eDAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zdGF0eC9zdGF0eDAxLmMKQEAgLTc5LDExICs3OSwxMSBAQCBzdGF0aWMgdm9pZCB0ZXN0
X25vcm1hbF9maWxlKHZvaWQpCiAKIAlpZiAoYnVmZi5zdHhfc2l6ZSA9PSBTSVpFKQogCQl0c3Rf
cmVzKFRQQVNTLAotCQkJInN0eF9zaXplKCUiUFJJdTY0IikgaXMgY29ycmVjdCIsIGJ1ZmYuc3R4
X3NpemUpOworCQkJInN0eF9zaXplKCUiUFJJdTY0IikgaXMgY29ycmVjdCIsICh1aW50NjRfdCli
dWZmLnN0eF9zaXplKTsKIAllbHNlCiAJCXRzdF9yZXMoVEZBSUwsCiAJCQkic3R4X3NpemUoJSJQ
Ukl1NjQiKSBpcyBkaWZmZXJlbnQgZnJvbSBleHBlY3RlZCgldSkiLAotCQkJYnVmZi5zdHhfc2l6
ZSwgU0laRSk7CisJCQkodWludDY0X3QpYnVmZi5zdHhfc2l6ZSwgU0laRSk7CiAKIAlpZiAoKGJ1
ZmYuc3R4X21vZGUgJiB+KFNfSUZNVCkpID09IE1PREUpCiAJCXRzdF9yZXMoVFBBU1MsICJzdHhf
bW9kZSgldSkgaXMgY29ycmVjdCIsIGJ1ZmYuc3R4X21vZGUpOwpAQCAtOTQsMTAgKzk0LDEwIEBA
IHN0YXRpYyB2b2lkIHRlc3Rfbm9ybWFsX2ZpbGUodm9pZCkKIAogCWlmIChidWZmLnN0eF9ibG9j
a3MgPD0gYnVmZi5zdHhfYmxrc2l6ZS81MTIgKiAyKQogCQl0c3RfcmVzKFRQQVNTLCAic3R4X2Js
b2NrcyglIlBSSXU2NCIpIGlzIHZhbGlkIiwKLQkJCWJ1ZmYuc3R4X2Jsb2Nrcyk7CisJCQkodWlu
dDY0X3QpYnVmZi5zdHhfYmxvY2tzKTsKIAllbHNlCiAJCXRzdF9yZXMoVEZBSUwsICJzdHhfYmxv
Y2tzKCUiUFJJdTY0IikgaXMgaW52YWxpZCIsCi0JCQlidWZmLnN0eF9ibG9ja3MpOworCQkJKHVp
bnQ2NF90KWJ1ZmYuc3R4X2Jsb2Nrcyk7CiAKIH0KIApkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0eDAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N0YXR4L3N0YXR4MDIuYwppbmRleCAwOGVhOTQwY2IuLjYzMTMzYTNiNyAxMDA2NDQKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0eDAyLmMKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0eDAyLmMKQEAgLTUwLDExICs1MCwxMSBAQCBzdGF0
aWMgdm9pZCB0ZXN0X2VtcHR5X3BhdGgodm9pZCkKIAogCWlmIChidWYuc3R4X3NpemUgPT0gU0la
RSkKIAkJdHN0X3JlcyhUUEFTUywKLQkJCSJzdHhfc2l6ZSglIlBSSXU2NCIpIGlzIGNvcnJlY3Qi
LCBidWYuc3R4X3NpemUpOworCQkJInN0eF9zaXplKCUiUFJJdTY0IikgaXMgY29ycmVjdCIsICh1
aW50NjRfdClidWYuc3R4X3NpemUpOwogCWVsc2UKIAkJdHN0X3JlcyhURkFJTCwKIAkJCSJzdHhf
c2l6ZSglIlBSSXU2NCIpIGlzIG5vdCBzYW1lIGFzIGV4cGVjdGVkKCV1KSIsCi0JCQlidWYuc3R4
X3NpemUsIFNJWkUpOworCQkJKHVpbnQ2NF90KWJ1Zi5zdHhfc2l6ZSwgU0laRSk7CiAKIH0KIAot
LSAKMi4yMy4wCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
