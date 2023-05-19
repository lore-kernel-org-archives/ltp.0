Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B60C77B7A
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 06:45:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF68D3CB263
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 08:45:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5D313C0433
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:45:11 +0200 (CEST)
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com
 [68.232.159.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13CFA6008AE
 for <ltp@lists.linux.it>; Fri, 19 May 2023 08:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1684478711; x=1716014711;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=a8bIT4hbXaHNQHbx9+amYb37fIhcY3gp6jDbxYGE7ow=;
 b=zTxoLdwFfUfDI2TNtma1iKosTqcsA6dKGuWOj6vkaBAGJZFsw+ADASpL
 hZDeh7zabqFTyA81sbkg0rUuWsmiDZ4Eofaw5Mx1I5cvKRGTXBeQ3Lz4e
 RUy+4VWBFO5EmXDcmsYsiBZFWZXXYOMnv3iEcm2vga4rvOsIbKhHt7evP
 NOxDHc1eLGO2Yoz7BvvF6XJJItAUXwrifNoLdUODX8h3H/Me4Bcynqqsa
 XRxZ4RAKOwfZ6dAa/zIEM3pgPjE1Y+22G/hyiK8vS8jVppvVoa2ciJ6dS
 N9F4XPF8chgfFcpWfYg+UtgY3QdF4VzZTW0iJS6GhRYzDXutkdqWIyDI0 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="84845824"
X-IronPort-AV: E=Sophos;i="6.00,175,1681138800"; d="scan'208";a="84845824"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 15:45:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJI1Gp0RjuCHhGOIjHQzxktdw/sBZp68yWEaF2Dnr41JFkxp78CxqmDZV1zoppv4sv1Pm/STcilSPfZhEVdN3rRVgX8lUu/Gp+pqqDIWVfrRj/TnULwI8eOrlHG7QzVzaL5+Ch96IZm66zFg2nprcf9M3uzhqc6zSB2d/spOZzJNQ0LwtREPWiXchqPWVnJPNuTulEJsw8QfWaPIHkiBLtYF3bRN7OubcxEeeyfM1K5SqAMi2cykTU1clT9eaX7x7zUmISVw6XqsyUolXE4A24bbXDMdNKWEoFqyXxPt+12b/t5ANltUX1OwvBvWoSifEozRWn32Jv8GP4tMTKdGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8bIT4hbXaHNQHbx9+amYb37fIhcY3gp6jDbxYGE7ow=;
 b=TY1uwITODxaqTLoyfrDN1B1He2cy4vKSwi0G0NoLRc1Wt0TiZ4dV6Htb+tPajKTun6wmaZT2k92ImmrKL3rVpflwI7WDJLiFopV2X2xgEe/sqjnxt4WdRB7JS9Ss+DqsCKnLsV0GuNZmbo7I+wwDcqolz22aHWzNX6S5va4P/Rq4MnDorzOFG4uzwpn90NrrzkKdzBTPSmi7mmDLqIwKVpl8bklWbyxAruL2Ghb6A5kSvMx4URaL2UljBYHMtU+o6LpDdxhPd2ziqTanh+jh4azVsFyRkFJMvxr6lXqKDyY4qlAWSLrQD2MnPX2Kh/+x//+Z8alGeYZeslw0apUkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com (2603:1096:400:2a5::7)
 by OS3PR01MB9979.jpnprd01.prod.outlook.com (2603:1096:604:1e6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Fri, 19 May
 2023 06:45:06 +0000
Received: from TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1]) by TYWPR01MB10725.jpnprd01.prod.outlook.com
 ([fe80::1eae:326d:abf5:e4e1%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 06:45:06 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: "Xiao Yang (Fujitsu)" <yangx.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v6 5/6] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
Thread-Index: AQHZhvyBOwJTyWuE7EqU9oZv4Qe6NK9hJyAAgAAFyQA=
Date: Fri, 19 May 2023 06:45:06 +0000
Message-ID: <f5e7d861-e0e5-a860-39a3-57b1f7b21d46@fujitsu.com>
References: <1684134680-6190-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1684134680-6190-5-git-send-email-xuyang2018.jy@fujitsu.com>
 <1cb91734-ae60-dd3e-d99d-d8dceb91a583@fujitsu.com>
In-Reply-To: <1cb91734-ae60-dd3e-d99d-d8dceb91a583@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB10725:EE_|OS3PR01MB9979:EE_
x-ms-office365-filtering-correlation-id: b1d12ef9-4ca6-4312-3aaf-08db583494d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCzUuHCjJGwreYHchiFmXRdAlHQCNEzdqo55S4eV/YiRjrdMpvQvoki+I4DPG62wSgbYzib4RnQrynse14No0MqaOyU68hwRSOAHcdE8vAEliQ00ip8eagKqvW/MdL5/pnolloSIPAonJWWcznWniFHRdYxDKuSVsuzCDSVP1zE/+TlcEh8VjJQ58uqaFP8BME17Y/DHTDw6hjfCYw3CJRG01NMrQUjbNzuAQogO92ZaFvm6pGAFqJ1SVqhAgHVn7QGRWmkmTm6/gqr3AKmnzM0Pk5XRlRoOmRV+3XKdB9wcTpJvO84GepCoHr60zhhX6OyiGxNTsPlOpRgw1O5S1AKJxtC6HfnOYx2RHJ/9Cf1aN5BWzpgNay3h/OFdFJMfsK7PK17zD/8eZ7LMW8Scj0kzMQn3WjHKsH7aAHyV3AAfWbUgufA3CXk+DXXPqgvNwRttd5IRwhlMzjZQZFNAPIudzsqyJUw3sDP9qLZeHEBKZ2bvSpIxPdHeF50j2o4McY8Sm42Z6OaU01wH4umVQuo71Zw60ZuqKkJdQQrerajol+AQIU8yXXZ2MiAYpftTUyKaf7UvOEjaSETlAVQGz5I5giOHd1zOw6IVf8xoH1vAcM2m9K0k/1RzyODoFYcX20kUUl4pbIowFFog0lgfanxNlRwjpBmmgDClc+nXXZptKZ+jUcDTca1+vOgPXl00
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYWPR01MB10725.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(1590799018)(6506007)(26005)(53546011)(36756003)(83380400001)(85182001)(2616005)(38100700002)(31696002)(122000001)(86362001)(38070700005)(186003)(6512007)(82960400001)(478600001)(66556008)(110136005)(2906002)(8676002)(66446008)(5660300002)(31686004)(91956017)(66476007)(64756008)(8936002)(76116006)(66946007)(316002)(71200400001)(1580799015)(41300700001)(6486002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE5rbkVzY1ZqV0dBQ1pKRXdNZWt4TWxYbS9LcmgvcC81S2V6N1NMajIzQVlt?=
 =?utf-8?B?aVNXTHk4b1JPdW9ic3p6U2JkNzlUaWhtQTRLcUxQWlpHSzhWeW4rRFl5cTRS?=
 =?utf-8?B?bXpsSlI0TCtQWWo1SUFYblpGZ0lXQWxCUWlzODVpMVh6dGt1N1ZQNWtwRVpM?=
 =?utf-8?B?Zzd1NHpFRkIvdHNlMVhldEtBajJWZzlzMThISWNRZkpWZkJ1TEVLSlFKMEMy?=
 =?utf-8?B?elVub0Y4NThxQUhwT2I5RTRMVU5CclVoMDZHV1UxREljVXNqNzhnR0QyVGFM?=
 =?utf-8?B?ZkwrZXpMb3lUdUZ5V2p0R0VhTmxFTW1uWmtjU0VGZ1BrYnk5VUtxZlhDbEQ1?=
 =?utf-8?B?RmRKRXcyOW5XakN0aXkxQzh2RVZNb1pmS0ZkUXRvL1Q5amVwU3YvVVljNWh4?=
 =?utf-8?B?K1NJbGR6N0VIYVBGcm9lN0c3a2dXc0M3b3BIUE95bnU0S2drYURCMGE1R1dG?=
 =?utf-8?B?d0dxUjZ6dG5PN2UxVkJyNEpyK21BLzJuRlRxSmp3Vk5wMHRzdGJreTZlUWxt?=
 =?utf-8?B?eGZreXlCaGZLR251WXhmVU9mZzNhSitHV2g2aHB0Qll6VVR5Z1JrTWFVand1?=
 =?utf-8?B?SnpGaFIzMWcxcmNydXRNSy9ia0JVRjJ3aEh3eWQ3aDBKazNrb01PeEd3Rjla?=
 =?utf-8?B?UmsrcWpUcEcrajZ4R0FQbWY5WnR3c1BJVDkrS1MzcUhvb3I1RVNPcTdDVjJM?=
 =?utf-8?B?UEpwZHUrYmdMdDFuRVdQT081TWVSbUFTWDhGT21xZG1mVDNBRHI1bU9rSm1K?=
 =?utf-8?B?VXcvKytCODZQS3p4ajZNR1QvR0ZmRzV3dVhhRUVjWVc5QXJ5NkNSSWpFemFQ?=
 =?utf-8?B?akJRTFFBWXRudEFHZW1yWXNBdlZma0JoQ2NOVkhyTDhwT29nWlFhUXRzMkhy?=
 =?utf-8?B?UnU4TXBDRHFxT0QxazNvSklNMnU1blVQY3RONGF2Z1U4cVN0YlY5bUlIL2dz?=
 =?utf-8?B?VjVKMzVwUGdkd1Z1cTFRbUdrb1ZCUFFkNGlOQkxsVzdQU3o2WE1xK21FVkhU?=
 =?utf-8?B?ZER0SDVNNWdjWU02QUdmUGtiQkZZY1lqNTJtUU5BcDNmcDJXaUUvZytORWxr?=
 =?utf-8?B?UTFZQjI2YmhFbldTbitnWTJ5VFpSQU9VcVErekt2MElsM05SZExrc1hpeTJx?=
 =?utf-8?B?ME9LbCtqWXpMa01VaWJCa2pwOGJzMEU4RlM5V2VWZVgrNXhmR3Iycy9md0Fy?=
 =?utf-8?B?cWk0dktpeUIrQzNpR2J2WmdjaFgzVWtKZGtlNi9TRC94Z0RZOVltVjg1M1Za?=
 =?utf-8?B?d0ozT05JQ0t2TXRsQU83cktkdVpSYVJTam9rbmRLZG9IdEhGODJtMTlmRHow?=
 =?utf-8?B?TXpaa01CaGRKMWpGc0puZjM4UEtDdHlOR2p5UFFlL3pwalZNaC9qTFA0aFE2?=
 =?utf-8?B?Wkh5UzJiSlI4L2xPSE5YY2xvR3Rvc3haeFN4elRSQVFTZ1piOWRNdHhNWmtr?=
 =?utf-8?B?ay9LRG1lYzdCMEwxM3NhRXYxVVhDNE9oQUJDQjJhYnZLbWljZWRHaExjaTVM?=
 =?utf-8?B?Z2dDYTJkMkpSR0dKVmdBMVZTbkxHY09HTWt3dWx2Y1ljL0JwbEdpMkpuNHQr?=
 =?utf-8?B?VXJoZzhhN21aVExFM0x6SXd2RkRLZGxWdyt2NGZkMkYzOEpxWENGN3dqM0NY?=
 =?utf-8?B?c0pHMENTQm9pVXRvRHNGR21oL0h0d1ZZNXlsQm40OGhzcXh6ZzJOcnBIbitj?=
 =?utf-8?B?blJvaGhFRGU1OUxOeHlNYkJPdHFYZXAzT3RlbFRNdmRiNy9vQlZJT1Y1Q1lJ?=
 =?utf-8?B?Q05XazM2bXNoaWpKcFh4TW11ZTRWdnBOSk8yZFphUEpIKzJXdWkrTlQ1NWhI?=
 =?utf-8?B?VEwvQzNqTVc2UUhLWFBsSFVpVVpLWjhWa0QrUyt1bFozekZGa1RjSjhldGND?=
 =?utf-8?B?V05yWmU5Ryszd05PQ1lpSjc1QW1QY2pnNkQyckYrWWczc0tIYzJBaEEyNzBT?=
 =?utf-8?B?Y084TVpwSDBERGltZnU2V2VHeC8vdE1nSkllUmZERkMyN2VQNWxEa0l2NVRv?=
 =?utf-8?B?SXQ2V21xRUh0QndoQVZPejNWNjBTOUo3Tlg0VTN2QUtOcHl0bThEL0hvWVZD?=
 =?utf-8?B?SmRFWWhRbDJRVnYrdlYvV1pRR1MzZkp4TzBhZjZocktOOG1xbnZYR05GdzZM?=
 =?utf-8?B?WFBqTDh5TVorY1Z2a05JSER1eVNvNy9OWElnV0dKd2xKb1dDSWRONkdvWDkw?=
 =?utf-8?B?b2c9PQ==?=
Content-ID: <1796765D83A00640BDA781AB2EB34AB1@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oSP9w7WUOVlxOkdlX9SHyR/BXr5h9jDLR+b7cc9+lLS4kfGcpA9bddxqVd+CYZRqlMcxMlaX9ghJvhQE+P3nfehoMSIYyFY+s6Vdw6lxB+UQSWjDduSU6gKCAkT8yGuZTXuJSz1NzFgbz94cNkgjheySSvjxx18TdD25S/TXeHyeIOFsSRMnkadlvJoqEpAGDjXJ+MKEifXaz3lidCSNDrHCO066eZb5X52wUHKeuKJDTwQu8UX/Wmp/Cm+OKAaDbyslVg3VP+DC0l9iN4hcNXDWA84eDZm9fstorbTwlow5wgsoUnLD7Gm1o+jq+a1DmUyAJno/q7/+voVNp0WAuW/RW0zIgo+C1tKpCEKZboCDqSzWyi5/MF3N2Noj+JyULBtvbcvhjxTY2swaGNQXqZNZp+fu4Bhs/JsqufrNs9I12iEjsXD4EGoMcdOJN7Qa+U7Dg75L8TCyLm4MGEuJ+gk4Kht0vn8JnshTF7swep3XEP2i/wes4+xwkYFEBE/Wi2/CN2thHW0XgGiLBu6dhaQ6Q5xQmDe2k3/Pud0rf585geKUymtRrG3AFgmMP3lXFT1sxyE5Eu/OnVYJ4o8r1Cz2fwdKbd/fQTJjMnlpmFzY9hFkjsJrrYnDbLQ+l6kRXRcrdqgVfDGCWBq5CP3LaN79Ydwkrh+mzOeSEFC3DmJqECijoF3CWpmo0PPCKgJphPWbkF//1jJJaSC5mJpbEAQBmX68InMO0wSN/KlIW/+o7wDspAE0RHa0hOVEkXmmj01BQWakGR8YFu4gR0ZCLg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB10725.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d12ef9-4ca6-4312-3aaf-08db583494d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2023 06:45:06.0984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cK3tSSObtKa1xYfVuBwF/LBwcQfj7Zz8GJ0t1xIgUUgSWQuKEyqb4px+Twc6ex43BAUE39WXCskk0kiteDSS9I4QXoK8hONsnixXOjd6Nww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9979
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 5/6] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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

DQoNCm9uIDIwMjMvMDUvMTkgMTQ6MjQsIFlhbmcsIFhpYW8v5p2oIOaZkyB3cm90ZToNCj4gT24g
MjAyMy81LzE1IDE1OjExLCBZYW5nIFh1IHdyb3RlOg0KPj4gU1RBVFhfRElPQUxJR04gaXMgdXNl
ZCB0byBnZXQgc3R4X2Rpb19tZW1fYWxpZ24gYW5kIHN0eF9kaW9fb2Zmc2V0X2FsaWduDQo+PiBm
b3IgZmlsZXMgb24gZnMgdGhhdCBzdXBwb3J0IGRpcmVjdCBpby4gV2UganVzdCBjaGVjayB3aGV0
aGVyIHRoZXNlDQo+PiB2YWx1ZSBhcmUgbm9uemVybyBvbiBleHQ0IGFuZCB4ZnMuDQo+Pg0KPj4g
T24gZXh0NCwgZmlsZXMgdGhhdCB1c2UgY2VydGFpbiBmaWxlc3lzdGVtIGZlYXR1cmVzIChkYXRh
IGpvdXJuYWxsaW5nLA0KPj4gZW5jcnlwdGlvbiwgYW5kIHZlcml0eSkgZmFsbCBiYWNrIHRvIGJ1
ZmZlcmVkIEkvTy4gQnV0IGx0cCBjcmVhdGVzIG93bg0KPj4gZmlsZXN5c3RlbSBieSBlbmFibGlu
ZyBtb3VudF9kZXZpY2UgaW4gdHN0X3Rlc3Qgc3RydWN0LiBJZiB3ZSBzZXQgYmxvY2sNCj4+IGRl
dmljZSB0byBMVFBfREVWIGVudmlyb25tZW50LCB3ZSB1c2UgdGhpcyBibG9jayBkZXZpY2UgdG8g
bW91bnQgYnkgdXNpbmcNCj4+IGRlZmF1bHQgbW91bnQgb3B0aW9uLiBPdGhlcndpc2UsIHVzZSBs
b29wIGRldmljZSB0byBzaW11YXRlIGl0LiBTbyBpdCBjYW4NCj4+IGF2b2lkIHRoZXNlIGFib3Zl
IHNpdHVhdGlvbnMgYW5kIGRvbid0IGZhbGwgYmFjayB0byBidWZmZXJlZCBJL08uDQo+Pg0KPj4g
Rm9yIHN0cnVjdCBzdGF0eCBtZW1iZXIgY2hlY2ssIHdlIG9ubHkgY2hlY2sgc3R4X2Rpb19tZW1f
YWxpZ24gYmVjYXVzZQ0KPj4gdGhlc2UgdHdvIG1lbWJlciBpcyBpbnRyb2R1Y2VkIHRvZ2V0aGVy
IGluIHNlcGFyYXRlIGNvbW1pdCBpbiBrZXJuZWwsIHNvIGl0DQo+PiBpcyBzYWZlLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAt
LS0NCj4+ICAgIGNvbmZpZ3VyZS5hYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAy
ICstDQo+PiAgICBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MSArDQo+PiAgICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4Ly5naXRpZ25vcmUgfCAg
MSArDQo+PiAgICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4L3N0YXR4MTAuYyAgfCA5
MyArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgICA0IGZpbGVzIGNoYW5nZWQsIDk2IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4L3N0YXR4MTAuYw0KPj4NCj4+IGRpZmYgLS1naXQgYS9j
b25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMNCj4+IGluZGV4IDRjODc2MzM3Ni4uNTQ4Mjg4MzEw
IDEwMDY0NA0KPj4gLS0tIGEvY29uZmlndXJlLmFjDQo+PiArKysgYi9jb25maWd1cmUuYWMNCj4+
IEBAIC0xNTgsNyArMTU4LDcgQEAgQUNfQ0hFQ0tfRlVOQ1MobWtkdGVtcCxbXSxBQ19NU0dfRVJS
T1IobWtkdGVtcCgpIG5vdCBmb3VuZCEpKQ0KPj4gICAgQUNfQ0hFQ0tfTUVNQkVSUyhbc3RydWN0
IGZhbm90aWZ5X2V2ZW50X2luZm9fZmlkLmZzaWQuX192YWxdLCwsWyNpbmNsdWRlIDxzeXMvZmFu
b3RpZnkuaD5dKQ0KPj4gICAgQUNfQ0hFQ0tfTUVNQkVSUyhbc3RydWN0IHBlcmZfZXZlbnRfbW1h
cF9wYWdlLmF1eF9oZWFkXSwsLFsjaW5jbHVkZSA8bGludXgvcGVyZl9ldmVudC5oPl0pDQo+PiAg
ICBBQ19DSEVDS19NRU1CRVJTKFtzdHJ1Y3Qgc2lnYWN0aW9uLnNhX3NpZ2FjdGlvbl0sW10sW10s
WyNpbmNsdWRlIDxzaWduYWwuaD5dKQ0KPj4gLUFDX0NIRUNLX01FTUJFUlMoW3N0cnVjdCBzdGF0
eC5zdHhfbW50X2lkXSwsLFsNCj4+ICtBQ19DSEVDS19NRU1CRVJTKFtzdHJ1Y3Qgc3RhdHguc3R4
X21udF9pZCwgc3RydWN0IHN0YXR4LnN0eF9kaW9fbWVtX2FsaWduXSwsLFsNCj4+ICAgICNkZWZp
bmUgX0dOVV9TT1VSQ0UNCj4+ICAgICNpbmNsdWRlIDxzeXMvc3RhdC5oPg0KPj4gICAgXSkNCj4+
IGRpZmYgLS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscw0KPj4gaW5k
ZXggOWMyM2E0MjQ4Li5lMjU0OGRhZTUgMTAwNjQ0DQo+PiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxz
DQo+PiArKysgYi9ydW50ZXN0L3N5c2NhbGxzDQo+PiBAQCAtMTc2NSw2ICsxNzY1LDcgQEAgc3Rh
dHgwNiBzdGF0eDA2DQo+PiAgICBzdGF0eDA3IHN0YXR4MDcNCj4+ICAgIHN0YXR4MDggc3RhdHgw
OA0KPj4gICAgc3RhdHgwOSBzdGF0eDA5DQo+PiArc3RhdHgxMCBzdGF0eDEwDQo+PiAgICANCj4+
ICAgIG1lbWJhcnJpZXIwMSBtZW1iYXJyaWVyMDENCj4+ICAgIA0KPj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHgvLmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc3RhdHgvLmdpdGlnbm9yZQ0KPj4gaW5kZXggMWNlYTQzYzBkLi42NzM0MWZm
MmQgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4Ly5naXRp
Z25vcmUNCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHgvLmdpdGlnbm9y
ZQ0KPj4gQEAgLTcsMyArNyw0IEBADQo+PiAgICAvc3RhdHgwNw0KPj4gICAgL3N0YXR4MDgNCj4+
ICAgIC9zdGF0eDA5DQo+PiArL3N0YXR4MTANCj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3N0YXR4L3N0YXR4MTAuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
c3RhdHgvc3RhdHgxMC5jDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MDAwLi41MTNhOGMyNjINCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc3RhdHgvc3RhdHgxMC5jDQo+PiBAQCAtMCwwICsxLDkzIEBADQo+PiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+ICsvKg0KPj4gKyAq
IENvcHlyaWdodCAoYykgMjAyMyBGVUpJVFNVIExJTUlURUQuIEFsbCByaWdodHMgcmVzZXJ2ZWQu
DQo+PiArICogQXV0aG9yOiBZYW5nIFh1IDx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4g
KyAqLw0KPj4gKw0KPj4gKy8qXA0KPj4gKyAqIFtEZXNjcmlwdGlvbl0NCj4+ICsgKg0KPj4gKyAq
IEl0IGlzIGEgYmFzaWMgdGVzdCBmb3IgU1RBVFhfRElPQUxJR04gbWFzayBvbiBleHQ0IGFuZCB4
ZnMgZmlsZXN5c3RlbS4NCj4+ICsgKg0KPj4gKyAqIC0gU1RBVFhfRElPQUxJR04gICBXYW50IHN0
eF9kaW9fbWVtX2FsaWduIGFuZCBzdHhfZGlvX29mZnNldF9hbGlnbiB2YWx1ZQ0KPj4gKyAqDQo+
PiArICogQ2hlY2sgdGhlc2UgdHdvIHZhbHVlcyBhcmUgbm9uemVybyB1bmRlciBkaW8gc2l0dWF0
aW9uIHdoZW4gU1RBVFhfRElPQUxJR04NCj4+ICsgKiBpbiB0aGUgcmVxdWVzdCBtYXNrLg0KPj4g
KyAqDQo+PiArICogT24gZXh0NCwgZmlsZXMgdGhhdCB1c2UgY2VydGFpbiBmaWxlc3lzdGVtIGZl
YXR1cmVzIChkYXRhIGpvdXJuYWxpbmcsDQo+PiArICogZW5jcnlwdGlvbiwgYW5kIHZlcml0eSkg
ZmFsbCBiYWNrIHRvIGJ1ZmZlcmVkIEkvTy4gQnV0IGx0cCBjcmVhdGVzIG93bg0KPj4gKyAqIGZp
bGVzeXN0ZW0gYnkgZW5hYmxpbmcgbW91bnRfZGV2aWNlIGluIHRzdF90ZXN0IHN0cnVjdC4gSWYg
d2Ugc2V0IGJsb2NrDQo+PiArICogZGV2aWNlIHRvIExUUF9ERVYgZW52aXJvbm1lbnQsIHdlIHVz
ZSB0aGlzIGJsb2NrIGRldmljZSB0byBtb3VudCBieSB1c2luZw0KPj4gKyAqIGRlZmF1bHQgbW91
bnQgb3B0aW9uLiBPdGhlcndpc2UsIHVzZSBsb29wIGRldmljZSB0byBzaW11YXRlIGl0LiBTbyBp
dCBjYW4NCj4+ICsgKiBhdm9pZCB0aGVzZSBhYm92ZSBzaXR1YXRpb25zIGFuZCBkb24ndCBmYWxs
IGJhY2sgdG8gYnVmZmVyZWQgSS9PLg0KPj4gKyAqDQo+PiArICogTWluaW11bSBMaW51eCB2ZXJz
aW9uIHJlcXVpcmVkIGlzIHY2LjEuDQo+PiArICovDQo+PiArDQo+PiArI2RlZmluZSBfR05VX1NP
VVJDRQ0KPj4gKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4NCj4+ICsjaW5jbHVkZSA8dW5pc3RkLmg+
DQo+PiArI2luY2x1ZGUgPHN0ZGxpYi5oPg0KPj4gKyNpbmNsdWRlIDxzdGRib29sLmg+DQo+PiAr
I2luY2x1ZGUgInRzdF90ZXN0LmgiDQo+PiArI2luY2x1ZGUgImxhcGkvc3RhdC5oIg0KPj4gKyNp
bmNsdWRlICJsYXBpL2ZjbnRsLmgiDQo+PiArDQo+PiArI2RlZmluZSBNTlRQT0lOVCAibW50X3Bv
aW50Ig0KPj4gKyNkZWZpbmUgVEVTVEZJTEUgInRlc3RmaWxlIg0KPiBIaSBYdSwNCj4gDQo+IEkg
dGhpbmsgeW91IHNob3VsZCB1c2UgI2RlZmluZSBURVNURklMRSBNTlRQT0lOVCIvdGVzdGZpbGUi
IGluc3RlYWQuDQoNClllcywgZ29vZCBjYXRjaC4NCj4gDQo+PiArDQo+PiArc3RhdGljIHZvaWQg
dmVyaWZ5X3N0YXR4KHZvaWQpDQo+PiArew0KPj4gKwlzdHJ1Y3Qgc3RhdHggYnVmOw0KPj4gKw0K
Pj4gKwlUU1RfRVhQX1BBU1NfU0lMRU5UKHN0YXR4KEFUX0ZEQ1dELCBURVNURklMRSwgMCwgU1RB
VFhfRElPQUxJR04sICZidWYpLA0KPj4gKwkJInN0YXR4KEFUX0ZEQ1dELCAlcywgMCwgU1RBVFhf
RElPQUxJR04sICZidWYpIiwgVEVTVEZJTEUpOw0KPj4gKw0KPj4gKwlpZiAoIShidWYuc3R4X21h
c2sgJiBTVEFUWF9ESU9BTElHTikpIHsNCj4+ICsJCXRzdF9yZXMoVENPTkYsICJGaWxlc3lzdGVt
IGRvZXMgbm90IHN1cHBvcnQgU1RBVFhfRElPQUxJR04iKTsNCj4+ICsJCXJldHVybjsNCj4+ICsJ
fQ0KPj4gKw0KPj4gKyNpZmRlZiBIQVZFX1NUUlVDVF9TVEFUWF9TVFhfRElPX01FTV9BTElHTg0K
Pj4gKwlpZiAoYnVmLnN0eF9kaW9fbWVtX2FsaWduICE9IDApDQo+PiArCQl0c3RfcmVzKFRQQVNT
LCAic3R4X2Rpb19tZW1fYWxpZ246JXUiLCBidWYuc3R4X2Rpb19tZW1fYWxpZ24pOw0KPj4gKwll
bHNlDQo+PiArCQl0c3RfcmVzKFRGQUlMLCAic3R4X2Rpb19tZW1fYWxpZ24gd2FzIDAsIGJ1dCBE
SU8gc2hvdWxkIGJlIHN1cHBvcnRlZCIpOw0KPj4gKw0KPj4gKwlpZiAoYnVmLnN0eF9kaW9fb2Zm
c2V0X2FsaWduICE9IDApDQo+PiArCQl0c3RfcmVzKFRQQVNTLCAic3R4X2Rpb19vZmZzZXRfYWxp
Z246JXUiLCBidWYuc3R4X2Rpb19vZmZzZXRfYWxpZ24pOw0KPj4gKwllbHNlDQo+PiArCQl0c3Rf
cmVzKFRGQUlMLCAic3R4X2Rpb19vZmZzZXRfYWxpZ24gd2FzIDAsIGJ1dCBESU8gc2hvdWxkIGJl
IHN1cHBvcnRlZCIpOw0KPj4gKyNlbHNlDQo+PiArCXRzdF9yZXMoVENPTkYsICJnbGliYyBzdGF0
eCBzdHJ1Y3QgbWlzcyBzdHhfZGlvX21lbV9hbGlnbiBmaWVsZCIpOw0KPj4gKyNlbmRpZg0KPj4g
K30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQ0KPj4gK3sNCj4+ICsJaW50IGZk
ID0gLTE7DQo+PiArDQo+PiArCWlmIChzdHJjbXAodHN0X2RldmljZS0+ZnNfdHlwZSwgInhmcyIp
ICYmIHN0cmNtcCh0c3RfZGV2aWNlLT5mc190eXBlLCAiZXh0NCIpKQ0KPj4gKwkJdHN0X2JyayhU
Q09ORiwgIlRoaXMgdGVzdCBvbmx5IHN1cHBvcnRzIGV4dDQgYW5kIHhmcyIpOw0KPj4gKw0KPj4g
KwlTQUZFX0ZJTEVfUFJJTlRGKFRFU1RGSUxFLCAiQUFBQSIpOw0KPj4gKwlmZCA9IG9wZW4oVEVT
VEZJTEUsIE9fUkRXUiB8IE9fRElSRUNUKTsNCj4+ICsJaWYgKGZkID09IC0xKSB7DQo+PiArCQlp
ZiAoZXJybm8gPT0gRUlOVkFMKQ0KPj4gKwkJCXRzdF9icmsoVENPTkYsDQo+PiArCQkJCSJUaGUg
cmVndWxhciBmaWxlIGlzIG5vdCBvbiBhIGZpbGVzeXN0ZW0gdGhhdCBzdXBwb3J0IERJTyIpOw0K
Pj4gKwkJZWxzZQ0KPj4gKwkJCXRzdF9icmsoVEJST0sgfCBURVJSTk8sDQo+PiArCQkJCSJUaGUg
cmVndWxhciBmaWxlIGlzIG9wZW4gd2l0aCBPX1JEV1IgfCBPX0RJUkVDVCBmYWlsZWQiKTsNCj4+
ICsJfQ0KPj4gKwlTQUZFX0NMT1NFKGZkKTsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHN0cnVj
dCB0c3RfdGVzdCB0ZXN0ID0gew0KPj4gKwkudGVzdF9hbGwgPSB2ZXJpZnlfc3RhdHgsDQo+PiAr
CS5zZXR1cCA9IHNldHVwLA0KPj4gKwkubmVlZHNfcm9vdCA9IDEsDQo+PiArCS5tbnRwb2ludCA9
IE1OVFBPSU5ULA0KPj4gKwkubW91bnRfZGV2aWNlID0gMSwNCj4+ICsJLmFsbF9maWxlc3lzdGVt
cyA9IDEsDQo+PiArfTsNCj4gSXMgaXQgbmVjZXNzYXJ5IHRvIHVzZSBhbGxfZmlsZXN5c3RlbXM/
IGJlY2F1c2UgdGhpcyB0ZXN0IGNhbiBiZSBydW4gb24NCj4gb25seSBleHQ0IGFuZCB4ZnMgZmls
ZXN5c3RlbS4gSXQncyBPSyBmb3IgbWUgaWYgd2UgZG9uJ3QgaGF2ZSBhbnkgYmV0dGVyDQo+IHdh
eS4NCg0KQUZBSUssIHdlIG9ubHkgaGF2ZSBhIGJsYWNrbGlzdCBmb3Igc2tpcF9maWxlc3lzdGVt
IGFuZCBtYXliZSBJIGNhbiANCmludHJvZHVjZSBhIHdoaXRlbGlzdCBmb3IgdGhpcyBzaXR1YXRp
b24uDQoNCkJlc3QgUmVnYXJkcw0KWWFuZyBYdQ0KPiANCj4gT3RoZXIgdGhhbiB0aGF0IGxvb2tz
IGdvb2QgdG8gbWUuDQo+IFJldmlld2VkLWJ5OiBYaWFvIFlhbmcgPHlhbmd4Lmp5QGZ1aml0c3Uu
Y29tPg0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBYaWFvIFlhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
