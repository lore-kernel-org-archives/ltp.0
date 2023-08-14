Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C516EB64DD
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 11:19:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77A653CD48C
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 13:18:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A8E8C3C65F4
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 13:18:47 +0200 (CEST)
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com
 [216.71.156.125])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 86D8F60028E
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 13:18:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1692011927; x=1723547927;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=xajJcDXuepexp4RZ8AIZDd8mSq04kMd/X9IaFWgLXRQ=;
 b=meqNOF5dohjUMz8tC6E/HFS8ADPiRoQYUHj1+gLNL1OmmQfU9oQ8cNRY
 hgZhCmExenqqj8G6NoOecicxWrzRs46EAL9ey30jF9ECbTW3jnNiPPBoz
 axjQ2SblwNyO1I4/wKiHBkVaAsCwgrL1qZd5E6jZcA9LFcnuo9TwWlFBW
 wbWmapE77IdKgHJq+1ltnkO+NIdhm9LbUKjgcO6i5Szfsn3+N7f+xOgwl
 9LRAweOYZoLYQt4sSpQFI16G3VFvM2ZdiBxqpHDWX72gwq+FFjlRroYXz
 ldS+1Fz5bGu2zW93pKH/bmwruTI44XgRHQOUAPo3ZRRkweHxpiG8mfFpz w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="92395869"
X-IronPort-AV: E=Sophos;i="6.01,172,1684767600"; d="scan'208,217";a="92395869"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2023 20:18:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjwffwONNrwmzv3CGBqCtRtkwZGyA30uCPUUieaE4zfjflw04wGX+6FCa+juyBK562ShAa4TlFNmVFZbIHu/Ed1Wb4rGyd3eLIOuQtMO0JL/Dj1FOuD6kws1vl68BE7N+JawuculaoLhHcQ1Wz7RXkUuSh5XJoBQf3iHKXUDtommdT2B9r5E/pQms0KeWnSDl46VNJt8l9hLODGwwda8EHLBeLlw2ujRt5E6V1eDfn22bxhmKaIM1FxZjFF8Cnz2O564+ZemGTW98UaHcjvAIDpUHuYheMtBOh8gsPhCWs2VpwafWadttUrwRlazPo1vhWsIhq2E+EW/7QJ7UWQ6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xajJcDXuepexp4RZ8AIZDd8mSq04kMd/X9IaFWgLXRQ=;
 b=XjtmU1D9QAPKf0mjoaZyLb/nWnWLV1j0KIvU1b0BRzF0dZOixBW1HntFx1UDxIzWflmas+VFYLXigpdPH8O82cZZGBeLFp3bxqeFpPqDJ01WGjSe9RwSdmokJvpScAMKIiUMd4ZmPRCjfFkkbcgxNqmqMnsriuawkczglMYEU+cfxd/f0cJMqA9Luau4mByN0dG4YlXpFaCNnRGYOMDF0hURXB90fTX6c6JZojAhI4F2HWvSt6LlAnFVx1q4C3Q5T1/+ku/CLI9QDhVdckVhli1VP5dKVASAB+T9Q2lnrRfHdf6PGhlLhppPqpUCbW/9NB2+AepAMXxlQY6+nBsBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com (2603:1096:400:294::9)
 by TYCPR01MB10431.jpnprd01.prod.outlook.com (2603:1096:400:247::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:18:39 +0000
Received: from TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::e570:69b5:dbd6:58f0]) by TYCPR01MB10712.jpnprd01.prod.outlook.com
 ([fe80::e570:69b5:dbd6:58f0%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:18:39 +0000
From: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH v2 2/3] syscalls/setgroups02: Convert to new API
Thread-Index: AQHZxGhld9AwxbpQM0uSogcgnyx0nq/e2RcAgArgPIA=
Date: Mon, 14 Aug 2023 11:18:39 +0000
Message-ID: <df83618f-717d-36c8-745d-824e7768f9dd@fujitsu.com>
References: <1690888046-18662-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1690888046-18662-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <ZNDt-PogUzCebHSl@yuki>
In-Reply-To: <ZNDt-PogUzCebHSl@yuki>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB10712:EE_|TYCPR01MB10431:EE_
x-ms-office365-filtering-correlation-id: 880ec216-3a24-4bf3-2e9f-08db9cb835d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ahxmnw7N07xr5vv7Cb3327eDW7TOCwLeRgoUue91Mhbstw7DVEX8LemcbsQcdOb2Ouflpt+eiEgTi8A6oitZ8DBpfwQqBoLfEjXdAv+zX8acgOEAoZ90sCArSsuKVLRgbR9a0QJfuZ+m7QytPnHDj4Krji1gHyNAmw5Be0CPDtayaUDADyWk8uhkWgSQcsW0IefyZZUIu/3NSCxV1LMnbxOWFCX62I3VVzXZ8tijoWHdDGAubBZ5bq/rudBxvkJbysjbE7DH1x0jkqMQApAskWdnI+9SAqVWuQOx+n13QeeGqlVQ1XbVtn6UUcK1K0c8gYG1N6ozlf+B1d9c3Eb5GgiqMOeozHxJOmvstNKAJthjH4Ra/rr7WXb/YnCQYq78pw5egtbE/inqQ0/chioIrBBXVnHQEhOG5nm0/vdAayJYPaHF+fAHB08BnWXqiiCwvlLp6vkfFRZcxzxpwFahzNi4kyuGyGG+b9wh3ztECqXzy+MS1fbCXClKb/Y+lzfD7wGQVqXKiwf1vCCqQHnUgXDqtlMND2++xmVAKroVN+ZjN4VHPc2Xdie895J3+3Htz7LhI2VzaSTtyzbpn/vQTTspFPH5IStdEZvuL80OMWP0ZnqYDaV182M8IePJzlZ5j6sbJ1kg8frFk42mRsCcQPPTFxhSh4gmAL0+d9Vz0th591jxfJLiPT+Qx2kxO7dp5QwKtVuf329KQo6InQ2OoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB10712.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(1590799018)(1800799006)(186006)(6486002)(71200400001)(6512007)(6506007)(478600001)(2616005)(26005)(2906002)(83380400001)(64756008)(41300700001)(6916009)(91956017)(316002)(66446008)(66556008)(76116006)(66476007)(8936002)(66946007)(4326008)(8676002)(5660300002)(31696002)(38100700002)(82960400001)(38070700005)(85182001)(36756003)(86362001)(122000001)(1580799015)(31686004)(45980500001)(579004)(266184004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTBFazJmeTZlQU54UXIrMkZOVUR5bHJVaHNTU2FQMS83bGp6dTZRU29WcjNN?=
 =?utf-8?B?NGNYUzNyRG5OK2lQaW0ya213cnVVL1FWeWt6Q1BVNDdVM3A1bjVKU0I1cTk0?=
 =?utf-8?B?cFgrMjZhRUtSOC80L3ZCUjJnci9DYVZuNWpHQW9PZXF5SlFqYVg3Mkx6VDRl?=
 =?utf-8?B?ME1qdHFrVGhNbXhONkpuejdlUzkyZVkwTzZMZlA0NW5WSWxSTzQxQW9zeEt4?=
 =?utf-8?B?bjM4Q09BQnNlM2lGZi9MRXhxdU9NNFBqemxFWGZMRHc0bUdGclpqamlWbW03?=
 =?utf-8?B?eGppem1yOWNPYnIwSXRqaFErMTZWYlg0ajl4d3l5YnpGdS82aFZTYVp3dXJ5?=
 =?utf-8?B?QzVFM3RGeXZEdEthcmZmQ21ZNHU0ZmViV29XODJzZlMrdzVadHhpeWpPVllu?=
 =?utf-8?B?R21yUk9kOHdkOUFMSU9URmJpV24rRlpleTZPaWlwd3lZRlVJSWNSb3hTa1VZ?=
 =?utf-8?B?S0JlNjQ1SHVFa2xFcnIzRW5kaktGS0F1cGcvcERLT09vY08rd1htRkFxaUZN?=
 =?utf-8?B?R0V1Q0NWb3pFNnRlb2I3YUJYazhjcDZsdlFXdThxQkZqTkN1WG1BT3NXL0lU?=
 =?utf-8?B?NkdtekNNUVc1WHlnVVhXMnlIQkRLMVhaVTkyZk5UUFpBRjNkRzdOTmFDakNB?=
 =?utf-8?B?VWYyVDJOdXRqMjZpbGNqQWRWaU0wNE5nNDYyajJwZWxHaFJoRDhHRHMxeTd3?=
 =?utf-8?B?RnFTMktIeEwwYWgvM0tPZ0JiUnRDMzNNcjE5KzNHWjJ6OWVaVS9yUTgxRGli?=
 =?utf-8?B?VEhBYjd6eWZySVNJWUtTK01tRjBMT2xLeUFrRXRuWks2NEhia1ZYSUdRVVVm?=
 =?utf-8?B?eGFtQW5mUlR6bzY0dk05SERPUy83eHVOVlpLS2krTmhMRzJka3F2MVk2ZEVG?=
 =?utf-8?B?MGRjcytuR2JHNjQzYWZwUWgvMmhhYzZKdHVhRVRiVlRsN3RXNy9xYjd0T0xX?=
 =?utf-8?B?M00rVUc5NkQ3d2kvanBIYkJCSlhYK2ZGMXdmeENoaWpJNkF6Z1NMOGRZOGY1?=
 =?utf-8?B?QkxETnI3RGg5NXJVRW0vaFlwU3JldGlrcEozK2RwUU44YjdSdm5RVVY3SWow?=
 =?utf-8?B?SzQrRUpFcDRFc1RBWG1TZEVPQkFMajU0R0w1RmU0VkNmek9ZZ1lKSlNrTVJy?=
 =?utf-8?B?UzFNSlNEVW1qay8vVFRmQTRVVWM1Uzd3bnYrbEV4bE9saGIvRHdlRFlYQ3NF?=
 =?utf-8?B?em1YYlJMS2lkNkFpeXI3S0dibksyM1grWXNFL3VaZFdES1FzaVlKU1RlNHhL?=
 =?utf-8?B?NlF6SVJ0cURJNUVOOWJlUzdvNmtLTG9zYTErZlpsRWVabnR4T0oxY0xjYXFF?=
 =?utf-8?B?SG5oTGFUWll2Rzk1cXBlcjN4cXBqSVlnQk0zWTE1TEJVbUZvaEk4MThqZE9J?=
 =?utf-8?B?MHBnL1pudTl0TGdwZk1UMk02N0pkeHdZbDBaQXYxdTlNZE5LOEcvVnhYeHUx?=
 =?utf-8?B?TnEvZWRjTzBLcmhub2J1aVRKc1pRaWJSUkpvQURoSWRVeHp3YTlhNmVtWEVN?=
 =?utf-8?B?d1g1bU1uVjQ2WVR0S3NUNG8xYVdIdWJ0cWdSS0VZM1VtSHlyTnlueUJXRXRI?=
 =?utf-8?B?aEs3RlB6TjMrNjNwMm4ybXoyd2NRNmp0NzRSSitmYXRXaGRJZEFEdVlKV2pn?=
 =?utf-8?B?VU4xM1VIaEpsSHlGdFJESUl1ZGJCSDVacWVEMk95blNUUWp1L0JFK1B6T2tL?=
 =?utf-8?B?MlJFT3ZHRDdJTDNKY2EyWk9CU0FkOXZ2OXp4UytzODVMTGRQSEd2TVR6QlFF?=
 =?utf-8?B?amlsYkR1U1FuRUFXYzZjbjRIV3RGR3paa1BZKys3WENaTU5jM0FxbjhSYzhR?=
 =?utf-8?B?VU43R29pWWVLNFNHN2hKWjAvYXNDM3BqT2w0S3ZjdmZzL0dtdVFLdi9lSGxN?=
 =?utf-8?B?WE55enRQanN5TU9pandyMTB3VzFBNlFrSENUU2tyNE1mWnRuOEtPR2ZSRjRQ?=
 =?utf-8?B?V2dHMXB2N2NuTDkrRC91Mi9vbE96Nlp0MnNjQTF5KzFoV1BESEl5V1hZNVln?=
 =?utf-8?B?eG5VQVdoN3RYcmJnekdENkRCY1FRL2tEbjkwUkd1RXZJQjU0UWtRUTNQL1d5?=
 =?utf-8?B?RWRXY2tSaXZjRTRlR0JHRVpHaHY5MG9WWVVlWWpWd0oxdDZjNVRONEwwSmJi?=
 =?utf-8?B?VG1BUlZ6VFl3UUhMT0ttcVVYUXNJdThlMnU5L1dmOGVhVlNES2htNjhRK1ox?=
 =?utf-8?B?cXc9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ktoqXtqYuB/6Wr9GcfwAOeYtzxpr038ZvQi2ZIxJTCiyEOemlRVgH+EuBNXuEwYj3Q+tgh4tIBvg2zIEUNgLIAF4+WoQEwKNB+epQOI3fIVanr02zqtGcafVC8TdngUyMh6U2mVnPjB4lkByRNlApLjsRiN7zgIn05wd0VugvSD4+0U4mcKPiPMOfJanpcIFRkV+GSHBR6PcEoSg0HY3K+23kx/R4NHvo8+DG/PqTVY1QoYL6NVjkNCKg87IWbnz9uHxWIytilMG9L7xYQ0LU6WUADEwah+hy0UOle/QNsTuUOPcjUSUItzE6LLDKbAJI03lHCYlwJ5iEJNtbNcnCN9Qoha1kExJLM0MP+oA5n8gQBIw0PRdaY0F9YPgcfc/zJ62wsboQrar95map9SA1xm9FW6HL1FzxZRCax38gxZQuW3Yz8l00BL5UKaO21ywhKTlD/ronSzwMecnoaxCTfecV0VLcBhGhdUTYwTjvIjyoFPTeHD8zGYuHeDUFeT23VOnub5nU8LrXmEdeyWEyGRhxVu68M3PAzQjXu2SsX/ZSsofCV9S6Y4vccxy24wAHwNFvyg2IzCkIAo17A87+TZvzvPYuaoupiYabL9epIgK/HJOHbOUWtGveFnJC7FAPDKJ9ZXmmB5Ak+wbLqlvySkImueiCyWiQZOLRfW+Tt++FmltRwQDViwsuHRbardy8g0AWnh9FvtSCoNCJL7bq2VxUKhUxImTQI/muyqdZbmWBy2ggbJSkAszOV+l+XXx1tGNTg/ECQRujyq4Rw0800BF/2M2ZNrUQpkq0m5+Pfg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10712.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ec216-3a24-4bf3-2e9f-08db9cb835d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 11:18:39.3352 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: df8g+sxmNdOjUP+EaaKoQh3NPJ8TJJbAV+BzX15gZBR8rCDi1YLHqyatU6mT2AyM+wqiFJwxTdS98qclUS8yjvmYzBVv06l6Cc/pxbwXBmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10431
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/3] syscalls/setgroups02: Convert to new API
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

Hi Cyril

Hi!


+static GID_T groups_get[NGROUPS];
+static GID_T groups_set[NGROUPS];



Since you are using the guarded buffers these two has to be just
pointers, i.e.

static GID_T *groups_get;


ok

-/*
- * setup() - performs all ONE TIME setup for this test.
- *
- *  Make sure the test process uid is root.
- *  Get the supplimentrary group id of test user from /etc/passwd file.
- */
-void setup(void)
+static void verify_setgroups(void)
 {
+       int gidsetsize = 1;



There is no point in passing the value via variable, we can as well pass
1 directly to the getgroups/setgroups calls.


Agree

-       tst_require_root();
-
-       tst_sig(NOFORK, DEF_HANDLER, cleanup);
+       groups_set[0] = 42;



We have to clear the groups_get[0] here as well, in the case that we are
looping with the -i parameter, i.e.

        groups_get[0] = 0;


I forgot this, I'll update it

-       TEST_PAUSE;
+       TST_EXP_PASS(SETGROUPS(gidsetsize, groups_set));

-       /* Get the group id info. of TESTUSER from /etc/passwd */
-       if ((user_info = getpwnam(TESTUSER)) == NULL) {
-               tst_brkm(TFAIL, cleanup, "getpwnam(2) of %s Failed", TESTUSER);
-       }
+       TST_EXP_VAL(GETGROUPS(gidsetsize, groups_get), 1);

-       if (!GID_SIZE_CHECK(user_info->pw_gid)) {
-               tst_brkm(TBROK,
-                        cleanup,
-                        "gid returned from getpwnam is too large for testing setgroups16");
-       }
-
-       groups_list[0] = user_info->pw_gid;
+       TST_EXP_EQ_LI(groups_get[0], groups_set[0]);
 }

-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *            completion or premature exit.
- */
-void cleanup(void)
-{
-
-}
+static struct tst_test test = {
+       .test_all = verify_setgroups,
+       .bufs = (struct tst_buffers []) {
+               {&groups_get, .size = sizeof(groups_get)},
+               {&groups_set, .size = sizeof(groups_set)},


                                          ^
                                          Since we are using arrays of
                                          size 1 with elements of a size
                                          GID_T this should be just
                                          sizeof(GID_T)

If it was array of size 2 it would have been 2 * sizeof(GID_T) etc.


The rest of the changes looks good.

ok, I'll update it




Best Regards

Yang Xu




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
