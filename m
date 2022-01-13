Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41F3C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 02:03:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 434B63C94E0
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 03:02:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54AFC3C0F6A
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 03:02:47 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 025C86006D4
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 03:02:45 +0100 (CET)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JZ73F2QZhzccV2
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 10:02:01 +0800 (CST)
Received: from kwepemm000018.china.huawei.com (7.193.23.4) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 10:02:40 +0800
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemm000018.china.huawei.com (7.193.23.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 10:02:40 +0800
Received: from kwepemm600017.china.huawei.com ([7.193.23.234]) by
 kwepemm600017.china.huawei.com ([7.193.23.234]) with mapi id 15.01.2308.020;
 Thu, 13 Jan 2022 10:02:40 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2] add several hash algorithms for
 crypto/crypto_user02.c
Thread-Index: AQHYB5qgE/erVlb7VkaCUcBLHcVRBqxgM3Kw
Date: Thu, 13 Jan 2022 02:02:40 +0000
Message-ID: <b82be648650f4747b8b99612dc2daaa4@huawei.com>
References: <1641886599-246423-1-git-send-email-wenyehai@huawei.com>
 <Yd6mD+GY7dmS1iTH@yuki>
In-Reply-To: <Yd6mD+GY7dmS1iTH@yuki>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.108.250]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSCB2Ml0gYWRkIHNldmVyYWwgaGFz?=
 =?gb2312?b?aCBhbGdvcml0aG1zIGZvciBjcnlwdG8vY3J5cHRvX3VzZXIwMi5j?=
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
From: wenyehai via ltp <ltp@lists.linux.it>
Reply-To: wenyehai <wenyehai@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksIEN5cmlsIEhydWJpczoNCg0KVGhhbmtzLg0KDQoNCkJlc3QgUmVnYXJkcw0KWWVoYWkgV2Vu
DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBDeXJpbCBIcnViaXMgW21haWx0bzpjaHJ1
YmlzQHN1c2UuY3pdIA0Kt6LLzcqxvOQ6IDIwMjLE6jHUwjEyyNUgMTc6NTgNCsrVvP7Iyzogd2Vu
eWVoYWkgPHdlbnllaGFpQGh1YXdlaS5jb20+DQqzrcvNOiBsdHBAbGlzdHMubGludXguaXQNCtb3
zOI6IFJlOiBbTFRQXSBbUEFUQ0ggdjJdIGFkZCBzZXZlcmFsIGhhc2ggYWxnb3JpdGhtcyBmb3Ig
Y3J5cHRvL2NyeXB0b191c2VyMDIuYw0KDQpIaSENCkFwcGxpZWQsIHRoYW5rcy4NCg0KLS0gDQpD
eXJpbCBIcnViaXMNCmNocnViaXNAc3VzZS5jeg0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
