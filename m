Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DF0C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 01:17:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0454A3C9285
	for <ltp@archiver.kernel.org>; Thu, 23 Dec 2021 02:17:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDACF3C8110
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 02:17:30 +0100 (CET)
Received: from esa5.fujitsucc.c3s2.iphmx.com (esa5.fujitsucc.c3s2.iphmx.com
 [68.232.159.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 778D41400BE5
 for <ltp@lists.linux.it>; Thu, 23 Dec 2021 02:17:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1640222250; x=1671758250;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eqkknRLI2IwmF10hvBlchjbigvGtxqksg5fgoKBUW9Y=;
 b=mpuKdqIVcfoZ5pW1gTNdt0HaaZXjtRvagon/jzmBQwmkEurevrs7uyll
 d7euODVsFMQBiABEddOcjEAQLXF2I9aa8AKIDps7s1KQrePWkpJ0n1Hsw
 LsWsydNzfjcN8dVr1nL4u3eZy+oFm81tz/nm/LzSDNErMHEJWHzod7dP3
 BR9fXe1kcI5/m+o5sAvfBGs12dKUzunxjyoZvlVdKfi/w4mJCkQh7knXi
 fNqcqm8NFNSzVE02nDdmyjKDMqnq1VCaSx+zcQUU0t6naGT0pvaM/XPJx
 WVOVKPedeoHtwr9Ork6p4FwD/82ch8R5BiWvhQkTjLzANjJfr/f1ZGkFk A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="46527253"
X-IronPort-AV: E=Sophos;i="5.88,228,1635174000"; d="scan'208";a="46527253"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 10:17:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IepuzqUm7lKh8zBlYLczvdqL6LGVQc1zy7LWMMz7dLv2x4iFEwD2h9AvtAZhNiKZWQRq+NE1D5CYcvrC8oPEEusO212wROmKZP+MdBzh7Yp9iWPf7IzgH19mUZldiwRjmpMOA+kuU2vVCHZwm/9AdwFM7aMB+tjEgrqHbtzz5FeJRMXIenrxVcJU3yQhQMlHEUU8JN0jrhTtvIIpjvnoEXDo7DuXMX5KMrToBYdnGX6ZikhafYJfc1jqbs57QZPSOloTJecwPzA73FZYcndxv0dn4n/f4jSqB3aHZk6oyF81du8zGUgNW1OGK22jQlZqbjYS/t2hPomcEE/f1bQOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqkknRLI2IwmF10hvBlchjbigvGtxqksg5fgoKBUW9Y=;
 b=YQAem6oIzmT9zUTnNzYoQyw/TttrYn+4B+RzppI4Ybmr4eDn2z7BQyu6M2Ybzz7qJ74h34RigXRQZRKUmg9GU5c6dzVa2pyyeBufyloiZkuHnbjHHj6BQLugC3Vq2KsYvve3D9AC0tiUMuas1qztoNCjhrEN32xpbkRZOBhmQPu0Z/mJ2Tw+A8zT49X96JueFQXQ3NzHXsrCMM8Sw8OhqMNyk7mV2V2q6hqIuHsgg5NWPqhPDIYSPh3SOb4V9BgH4+drh1Il832D4WTA+vK6cHuBOTQTew5BZ9Um0z9oQ3ulJJ6HQC1z1YZMkvt9sLPhRuNvzbNg1rz9MsfvcRKZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqkknRLI2IwmF10hvBlchjbigvGtxqksg5fgoKBUW9Y=;
 b=X8zB+MJjPZCxxfykwf3HWNT3ifIvoXn1V9Kds863oC3kYu2Nw5F5zbBTvKAnpF/5iqW0TM+kkeR7kwrQcKbSNCX6iWtyhgwn7Y8titXRitcqcelrln+0jFgstaDQMUtJ0yDmB4NFbv8WlVKgoIVRbkJP4Iv/aa/hrvuFP7pn594=
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com (2603:1096:604:100::7)
 by OSAPR01MB2355.jpnprd01.prod.outlook.com (2603:1096:604:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Thu, 23 Dec
 2021 01:17:24 +0000
Received: from OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::bc41:b2e4:2c49:8be3]) by OS3PR01MB6535.jpnprd01.prod.outlook.com
 ([fe80::bc41:b2e4:2c49:8be3%8]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 01:17:24 +0000
From: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2] lib: Do not fail a test if oom score cannot be
 adjusted.
Thread-Index: AQHX9zzMgXFrmuCy7kKjalS108cS/Kw/R0aA
Date: Thu, 23 Dec 2021 01:17:24 +0000
Message-ID: <61C3CE33.5010105@fujitsu.com>
References: <20211222135234.30025-1-chrubis@suse.cz> <YcMwRIZcQNH94xhe@pevik>
In-Reply-To: <YcMwRIZcQNH94xhe@pevik>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8b096d6-9fdb-432f-7423-08d9c5b1f9d7
x-ms-traffictypediagnostic: OSAPR01MB2355:EE_
x-microsoft-antispam-prvs: <OSAPR01MB235524D86589AE06A4AC27FAFD7E9@OSAPR01MB2355.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tqJrsNGWzk5IEo3sEGpbX4H0817GXSFezcT9+vg6ITF2iO17L7Q0amE1yEQFSfXivlMjZLUq/2atTrgbbeelzwKifiYKR+dWO/eDJLZLMe1hjR5xG4DU5PsAzfKzP+CRG0SWLcauISJTTn7OFskV2M0Z5cN75FxXwmwt2qKwuviu/X470K9cTe0rBSz4wWaDsZaAMg6cr+qzTtRkjqZh366BRSXjxXv4b5gsJ4+7UoGK88Yrza1nPjL+ZwgfV5onBSOeio8yHYO+pO/DAdSD1vMqr1bm9dJKcNj4VTjG6HzbRq05sY06epXKg1g1oHaCVg88MJwePv7hXRYk65XWh+IYLUXSQvW81/L/TUqExPYr41+C+FCI/2jNPy2OXXxSzbdw18gJuVwL1PmoIGZOaXrpjb0ReoYaCXWE5jWYLInusptqpxj3rW6itOzRBOc0l+KH4DSIp40U1k/iKn12wBFQu52bshjnebiS9G17nxqZWB5poPEdV8RHS0kSnlIybjxJEuMDVPoliGrqnRrsH3OSng+T7EBLs4HMQQ3p9uzeAZpbkX2za4WlemBDKUb7QzzS0noC3lyvDBjghKBNK0oWSI2PlBg1MdDv+tZmdbzxG5YFmEIzgWSYHUssbmWTVAtlPMA4arrmk5yIDyO29B8kUC1nbwwCGvNiJB1eBYHmfHrb/d8Dvuwehke8n+zqMPCzebridY0I3pu5DQClx6SOBgX4CXyPvgHZHfO1tzFZ1qQrte2cNf9NDoFazvMW8QIg7qvwtCnCDPgE/2w2K2fHyRdHXovmiCClWI7EYXE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB6535.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(85182001)(71200400001)(4326008)(6916009)(86362001)(83380400001)(316002)(2906002)(6486002)(66946007)(87266011)(2616005)(91956017)(508600001)(76116006)(8676002)(6512007)(64756008)(82960400001)(66446008)(66476007)(66556008)(36756003)(54906003)(6506007)(26005)(5660300002)(122000001)(186003)(38100700002)(38070700005)(8936002)(33656002)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?djBBcWJKZ3M4YjBqREQ1MDlVVE1SV3VSUWVhaG8wQWFwVUhWTjg0algxYW1D?=
 =?gb2312?B?N3hyUlN5UGtEemtETEw5MHRWTzdUNVZFeHdRNkUrYzlBa3RXTWFvT3JCcWdG?=
 =?gb2312?B?dGs2OHdROStlekZGODIrakR1d3ArWmFPUzNUV1FweVcvRVhOb1ZzMGZTdWRv?=
 =?gb2312?B?bU11bi9ibktJZWdZOWxOWGpSVGdQTEJ5Sml3M0hZNkJ6cUhPMEFXTWlaRkFM?=
 =?gb2312?B?ai9Fb3RZVUdYMEZjUW03YVJFUHlkNEc5eWxHbjIyQ1QyM0lEODlEaWdSV2U2?=
 =?gb2312?B?MHFVRlFPM0thOXVCZCtHdGpWK3BXVVJ6SjJoczcrU3JkV0JEVVBVemJObnRw?=
 =?gb2312?B?b1NTL2llZWZIQm92b01WcyttMnR4ZG9Kb2hXUmI1UDM3Z1E5V1JCN0N5RUJ2?=
 =?gb2312?B?QWxIUDluTVk3RmtQN01UR3FIb3Azd09GZW9TeHpSTk9QQUtuZWMwR0dkNDVF?=
 =?gb2312?B?OUZTTHI0VzNQM0RNQktwOWtLK2xDUU9NK2l4N0Vja05Ccyt5TEJHaEVKb2o2?=
 =?gb2312?B?bTBpTlV4THU5blJVZWxwTFJHMjhQRXU4TmhuZDNnZmRzOEdNanJRQkJqbXZs?=
 =?gb2312?B?czMxZHdBWm12NlFjblR5RW9ucWlWTEhJbytZWXZWYTdZZEtWbjlzOTJIMWQw?=
 =?gb2312?B?SGJrOERLSWpSYWwvN3V5NW1IOUhrWUxYZGVKaEoyZHk1L0c2cDMyUVpTc00z?=
 =?gb2312?B?aXdYM0pQZVliUStlM2Z6a3hIWm1vT3hYbi9qRVZxVUtjL2FUdVlUcFJnVTFj?=
 =?gb2312?B?L1h5VlAzQkN4WkFyOGhCU2hiWVFpNDBDRE9YMC90cHRaOURadm96MDIyNGpq?=
 =?gb2312?B?cWdYbEphYXF3UThuZVVpUisxb1E4UHFrUk9RbnlacXJ0ZnJRR1FEeXRpTVA3?=
 =?gb2312?B?V3VhTUtTeUcxaHVXbW83Sld5UnhmU1kveFlnZ0NLRzVWTzNPWTlyQ2Q5Z0Jm?=
 =?gb2312?B?dUx6ay9abktPUnhoMnhYd09pNXpTRit3YjZxMUhCVTNvaGo4SEtKR2Jpb2pa?=
 =?gb2312?B?NVM3VVA2RDloN0NwUm1yN1ozZWYraGhhREVyYVNlQTg2d0ROcTk2MTZUd3NQ?=
 =?gb2312?B?anJtaFNGMGdDdlJKdjE0Tk4ySkhXUFh1Z0I1RTlJZmZLaUJHdmJxY1loWmZB?=
 =?gb2312?B?RXVZSkhsMWxWd29wakFSWldCcXhFRExKVlpLNXpjR3lGWVhwTkN2WjNVR1Mr?=
 =?gb2312?B?WncrLytNdEZIN0Irc3o1VUdyekZCcmpJNHoyak51NE9nUnpLdXdzSEJnMzMz?=
 =?gb2312?B?V3RnUm44MWhkKzN6N2FaVWgweG1XNU9LV0xxQndFL1NPcXVEM0UvT1EvNjdL?=
 =?gb2312?B?Z3FNbzg3SklVOXVCTUZEaUp1YldocG8zMjh0SHk1eXMzb3N1UUFIR1oybmRG?=
 =?gb2312?B?QWlQSjQzUTVERzdqK3NrL2g1K1BDbTJXWVI3ZUYweGozUWI3OXQzeXJ0V3Jj?=
 =?gb2312?B?Mm9wMEtyb2I1bTNOYTZBcGViNnhnTWJBYjd5d2JlSXJkeXRBckt1bW1TMjBz?=
 =?gb2312?B?RzRWY1cwNVRFNlVXd2ZUYVpQLzRqbTh6M3pHRE1GWDFTbXFnVTU2VUlMNm8z?=
 =?gb2312?B?eWJzODhHTW0wT3BTS0NPSGhEdDR2V1VTR2pEd1lMZEx4ZkRobkZ6bUdjYmJz?=
 =?gb2312?B?UEd0K3laZ1JGM3Q3OW91Y290Q3JCcGJkcVoxY0JtM0ZuZTZPT25WNHlMQm9T?=
 =?gb2312?B?a2RzWFlOalRWNFBWZVJqQUxRTy9xMWg5eTFFNXdtRSs5T1Y0YmJnV01VeUds?=
 =?gb2312?B?OEN2QzB5K3NZQS9HV0ZnelBtZTc3TE5pK2JsOUFsL3VkVHppSlU2Y2o1UXR1?=
 =?gb2312?B?ekRlam9ZMHA1NGc1YlgvZVAxeFVlN0Qwd3FWQW9TamRSOENHYVEvUUNTRFd2?=
 =?gb2312?B?d0dPdDV5RnVURGxjdDhrTWRvenhhamFPNDljTlpOWVBkRDdia05vZEg4WjJP?=
 =?gb2312?B?b1h2MFZSSU83d2JjQmhOSS9lQndJUDJ5bEswTDlXdWlWWW13eUNCT2tvNTZw?=
 =?gb2312?B?bUNzL0E3ZWFUTnRnMGJpM2hpYVJNc1VuRlNCaWlSeVAzZnlTWkc2QnpadmV5?=
 =?gb2312?B?am5USGRBYkNMK21RMnpURU9WM0tVU082cUw2aFQ0dTQ0RFBqZFNTb1B6Z2tk?=
 =?gb2312?B?dnBpYnJVR2lvcnlRN0UxK3RsOUxudm92VnRYTDl1NmVsOUVFU25WdlhVRHBU?=
 =?gb2312?B?ZUdYU3Q1NlBra2xVSXlkZEhDYVV4Z2ZtVkdtNEhSYm1hVjdxTDhPWU0ycDNu?=
 =?gb2312?Q?cKS9y2L2cSHSb3UixgpF6I8Lhamyxs+HVV2VguC6Vg=3D?=
Content-ID: <E77F1B26A19336439276793554EB1D35@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6535.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b096d6-9fdb-432f-7423-08d9c5b1f9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 01:17:24.0384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C8Q7ZeXvTPwTL8NJ4ypWqxddGDxG7TZ7zzC7cIyozwnzNu6gv4rKZ7Vp+N6/omoLpPlCeuEolxpm+yDAmvG9YR7V+3/fm5hVGHOt5Q2tV70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2355
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Do not fail a test if oom score cannot be
 adjusted.
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, All
> Hi Cyril, all,
>
>> From: Petr Vorel<pvorel@suse.cz>
>
>> Setting value<  0 in /proc/*/oom_score_adj requires CAP_SYS_RESOURCE or
>> CAP_SYS_ADMIN.
Here will mislead user.
Since the default oom_score_adj value is 0, so we can not set a value < 0.

The value of /proc/<pid>/oom_score_adj may be reduced no lower than the 
last value set by a CAP_SYS_RESOURCE process. To reduce the value any 
lower requires CAP_SYS_RESOURCE.

Also looks man 7 capabilities, CAP_SYS_ADMIN doesn't have this cap and I 
have do a test to verify this

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <errno.h>
#include "tst_test.h"
#include "tst_capability.h"

static void run(void)
{
         FILE *f;

         f = fopen("/proc/self/oom_score_adj", "w");
         if (!f)
                 tst_res(TFAIL, "non-exist");

         if (fprintf(f, "%d", -200) <= 0)
                 tst_res(TFAIL, "write failed");

         if (fclose(f))
                 tst_res(TFAIL, "close %d",errno);

         tst_res(TPASS, "write pass");
}

static struct tst_test test = {
         .test_all = run,
         .caps = (struct tst_cap []) {
                 TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
                 TST_CAP(TST_CAP_DROP, CAP_SYS_RESOURCE),
                 {}
         },
};

It still fails if we only have CAP_SYS_ADMIN.

Best Regards
Yang Xu

  However setting the library process score is a best
>> effort operation, so let's skip it silently when the user is not
>> privileged to do so.
> +1
>
> LGTM, thanks for this version, I'm for merging it.
>
> Also tested locally and on CI, working as expected.
> https://github.com/pevik/ltp/runs/4607602484?check_suite_focus=true
>
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
