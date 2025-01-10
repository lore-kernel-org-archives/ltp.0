Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42285E77188
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736498380; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=Km5qvuYgCWBcszcYF/m74PDwczgVbKBTQ8YWFgdyAGc=;
 b=Re6nlAhHT2xZk/CNllzzlCp0TM8X0PPJmeHes/CnF/cW23Ry9Vn7V6wsntfFL9u1Z8sOH
 u6WRJXWMnGuZnxlkbKEKxSpWsFWfVwdcQ/rsFM4jGxdE9+eqJ+6EicqAWDl0DbcVdE84n5G
 K6mEY5hclFP3wWfCGzHBVjn04UQ8HCg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 158F43C2EF0
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 09:39:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB0A33C0DE8
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 09:39:19 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0BF161BD98DF
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 09:39:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1736498359; x=1768034359;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gnIpxTyWLypX7SXXwqPCX2t0HTHkvQwVyVQGSY6ydKA=;
 b=Oh0pe1bV94guOM8mtkzR35es1lP4JCMMqE6+wSbbPpEG3FevVXSkpb5u
 zR6TDB7FVIoO6wLvbnpPAKhB2S8ilBaetK1Pnb1wGfL6IF4Myan9VBNlh
 dWyZY/dtCwfQPzAc3bLNRFXLbc+X4gawsaKfDcTbM2qhMjVKoCeXjSFOE
 3n3Hb8B/CqgmB7KmPXiZ16Cx1HX0ma29P8TyEGkJqdFrqCuDkr4/xvO0d
 flV2bXpUB9YWG9s71K0jO4WbXcXRc5HJxy8USHVI0ncOOi8le4mMlvPEm
 mHUluaR90W8AlAZbgI8AgycUsPfQFURw0SoXHaH3z57lVipgPslDG9UHr A==;
X-CSE-ConnectionGUID: iPP8hWvTQ+CV3z+vvw+D+A==
X-CSE-MsgGUID: c+fU1gINT0Kjd/5DWpAI4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="165651540"
X-IronPort-AV: E=Sophos;i="6.12,303,1728918000"; d="scan'208";a="165651540"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2025 17:39:16 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 29675DBBCB
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 17:39:14 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id F39ADA909D
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 17:39:13 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7CE632007C3C1
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 17:39:13 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id F23F61A006C
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 16:39:12 +0800 (CST)
To: ltp@lists.linux.it
Date: Fri, 10 Jan 2025 16:39:00 +0800
Message-ID: <20250110083915.538855-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28914.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28914.006
X-TMASE-Result: 10-0.402100-10.000000
X-TMASE-MatchedRID: TWQD+6s80gPNOu6IXpEO6eMobH1h01ziTSz0JdEAJbQ/SH/a0TmRSRYU
 vvDR01qiAd0cn1fMeA41uvwLrMEkQLBAQLqGlKivJmbrB1j4Xwr0swHSFcVJ6GLgK1DfkGckhEz
 I3+mkzif4XJPAGTaiPIb2XPUJmitUv1l2Uvx6idqWlioo2ZbGwdmzcdRxL+xwKrauXd3MZDXPfX
 hUMXbUxjU8ibTFQOA+Mz/ST0XpDTeNcf0yC5w57/4xhx3lV78sNV1pKYtndre8/RKvNu024qnok
 xx9zanKhpH81s3E707/qLSym/QbitxLVf2GmgMytJqDFmM6lOAbZvZHKAMSQgbtvX+OP8cG
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [issue] cve-2015-3290: fail to compile
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKV2hlbiBJIGNvbXBpbGUgbHRwIG9uIENlbnRvczEwLCBpdCBmYWlsZWQgYXQgY3Zl
LTIwMTUtMzI5MC5jLgpJZiBhbnlvbmUgY291bGQgcHJvdmlkZSBzb21lIGFkdmljZSwgSSB3b3Vs
ZCBncmVhdGx5IGFwcHJlY2lhdGUgaXQuCgpFcnJvciBpbmZvOgpjdmUtMjAxNS0zMjkwLmM6IElu
IGZ1bmN0aW9uIOKAmGNoaWxkX3RocmVhZOKAmToKY3ZlLTIwMTUtMzI5MC5jOjQzNzoxOiBlcnJv
cjogYnAgY2Fubm90IGJlIHVzZWQgaW4g4oCYYXNt4oCZIGhlcmUKICA0MzcgfCB9CiAgICAgIHwg
XgptYWtlWzJdOiAqKiogWy4uLy4uL2luY2x1ZGUvbWsvcnVsZXMubWs6NDU6IGN2ZS0yMDE1LTMy
OTBdIEVycm9yIDEKbWFrZVsxXTogKioqIFsuLi9pbmNsdWRlL21rL2dlbmVyaWNfdHJ1bmtfdGFy
Z2V0LmluYzoxMDg6IGFsbF0gRXJyb3IgMgptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL3Jv
b3QvbHRwL3Rlc3RjYXNlcycKbWFrZTogKioqIFtNYWtlZmlsZTo4NTogdGVzdGNhc2VzLWFsbF0g
RXJyb3IgMgoKRW52aXJvbm1lbnQgaW5mbzoKICAgIE9TOiBDZW50b3MgMTAgc3RyZWFtCiAgICBB
cmNoaXRlY3R1cmU6IHg4Nl82NAogICAgS2VybmVsIFZlcnNpb246IGtlcm5lbC02LjEyLjAtMzUu
ZWwxMC54ODZfNjQucnBtCiAgICBHQ0MgVmVyc2lvbjogZ2NjLTE0LjIuMS02LmVsMTAueDg2XzY0
CgpTdGVwIHRvIFJlcHJvZHVjZToKIyBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4
LXRlc3QtcHJvamVjdC9sdHAuZ2l0CiMgY2QgbHRwCiMgbWFrZSBhdXRvdG9vbHMKIyAuL2NvbmZp
Z3VyZQojIG1ha2UKCkJlc3QgcmVnYXJkcwpNYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
