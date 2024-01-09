Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E14AC3DA6E
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 00:53:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2AB83CFE38
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 01:53:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D8903C0645
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 01:52:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=216.71.158.65;
 helo=esa20.fujitsucc.c3s2.iphmx.com; envelope-from=lizhijian@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com
 [216.71.158.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8216C6012D8
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 01:52:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1704761571; x=1736297571;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=jJDKlk8ptkgMSOuJUTaft+HC5u0em0ppyIk7VSmQB6c=;
 b=KE6Hop1nH1yHrmaRuwTGEMkZP7Zm+ubTdYGPV4bh6Jzk7x9KjEiAlEFE
 sVc7jpg4jQhQI5s7zRLDxRouEpxWAVaheg87hBjyJ8yjCADOwWbaY9DyU
 1DCnaZzllrskHiEnfCf7O5vbmGw9isuD+kxZ9JG2VDTTypgnk0/3jgDcY
 G/LqIWEtLQG96RMYp1wgWQyTifTD7oy0rYlCwIPFmZGOXi2AwN22O1Eyy
 FR3+jtB4OUhzD4MRsNyvb7PW5Y/2RbHXojJKxptUwI3lAEwKW8/OPyVa3
 jw6UQ7WgEqKkxe3whjWqPi5A2vThsnqYhUWjBtMFBMdWaJxRl/iuEHvlY w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="107425249"
X-IronPort-AV: E=Sophos;i="6.04,181,1695654000"; d="scan'208";a="107425249"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 09:52:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7sZTXWNa4NLhDUYjQu6PYbjB6IKR1eDs3OtfGJnfWtULKXPPTA3TBt/zlp64cZdND87+iYPD11Nt5DBKEkN28W5RFZJszP1T3O+L41YOVTJ1uX4/xEy6g9zJXONeYuNkoga172hQbXeCq/x0N+iIyre06OcatM89mgO/m8orIvPMvyG94VoI28FNP5YrA8oDTogYGtAKOwt9+70iQP+xkACwjkjl7NVk1SgfI+nNboErTA+RQnNAkvDicY6anaHDkWszjxe6KKIAyPTh8GJTgjHkTCoe5hK295/e1fzGRH+mBYRAtmFeOJB1RcmtyUIQHhIHnpYoxxsDXIlNCcm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJDKlk8ptkgMSOuJUTaft+HC5u0em0ppyIk7VSmQB6c=;
 b=DF31WF+ihCMcY0ll74MvmlRWYQ0WV2NRw4KR/bkHrr2yjRJOB0G0kygH36wVRvlZ00Mf3yeCZZ1g4Rlu2tmmLjLp979+//UNB9xFPJAIZ0PSYMmw8UawBeRG3ZVnMR4Z5mVuKUtS/+dV9deHSTG4XvZUfOlaKq0XRGmYwSAELgbGmnuqNAFKTre0+qQxFFYFRrwxlnHGL51QcvUM6odn6ibUmgyQbt7w20YsrwJFK0ODX1h/r7G9UE7uJIOGOnQmq1/xW1M6NRQu1NskejJ1Bldv8wQKvqAV1dGfgn7M/ipSZmunE2xnoGmKphF8CuBaWt8TBToLDN/1nAdwk1ZBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYVPR01MB10655.jpnprd01.prod.outlook.com (2603:1096:400:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.15; Tue, 9 Jan
 2024 00:52:45 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::c96f:52b0:dd4e:8d50%6]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 00:52:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 1/2] syscalls: setgroups: Add missing gitignore
Thread-Index: AQHaP6jo5lyhHc2qOE+as7f+xycgN7DPt1SAgAD1qQA=
Date: Tue, 9 Jan 2024 00:52:45 +0000
Message-ID: <60e29925-b50c-4e6b-a198-7bbb8ccd0457@fujitsu.com>
References: <20240105072843.2098332-1-lizhijian@fujitsu.com>
 <20240108101329.GA1565258@pevik>
In-Reply-To: <20240108101329.GA1565258@pevik>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYVPR01MB10655:EE_
x-ms-office365-filtering-correlation-id: f5e14e4d-015c-42e6-7b95-08dc10ad4b36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7Qjx1wbp1APZwhjODAziLBxHmIeG5+DVczelQHAhLmuDacvwwG4aEdPxKdyA7Nigny3bCGmOWPhTZfQ9p/9pxO0uu9l5waJ/echAiRDA0dIUQBbV2HRwi+CcKtuMFo4nDvWlDY4xbPvjwqaLLQYyiI5Jgio2eX6GZ3nwdv0VG6C2NDVK8kv5E2aCJy6u0QjAWtBonAGEKVaUcHqsE/upu2qDcDf60pBU080u3M0vFHWf6XdXatEIhkIEBu54qC7iIwE6Z0OPXEb6dGRn9NRqOwxmUSgYt2yGj+6gTcm83Nlabk9sQdYVG0Uztlfj/AaiJ7ssi5fSH9tV9wNzewP7SF1CP0/kr0hM7Ty1HHTSQok/iFNrkd1iw5KYayl+8TRI2wHxLe1bYpidQHfbimwdOrWW80sGobbgG2ppZGvUB00r88xAx+9RBKyoBLoAibLhjIYeZ+z9H6VrYnXl9EPlUPmRo0mcSkynPlPhrJQfiV2sx5xdzmYYDfhg8r4CaNCCq9exszFj/5zEgQecLE9yd5zRZ6ycRNd1lt9PL+rENQntfm/DmSlqOXIIH3AQxvHD9+lmkFCJicvEk/iisgPbDXgEU0rvlBlFHPbQv4VB1cOOvAGOo6y5TYDcL4aUsri8zRz0yEKKaFMp3AXGPVj07msMbGawH/KFeEOe4x9wcneMvb8bi5YvZ1H5+Al+PBP0XM+yZi9MUXLURPIpV2nYA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(1590799021)(451199024)(26005)(2616005)(83380400001)(38100700002)(1580799018)(82960400001)(41300700001)(86362001)(31696002)(122000001)(31686004)(478600001)(36756003)(5660300002)(316002)(2906002)(71200400001)(4326008)(85182001)(4744005)(76116006)(66556008)(66476007)(64756008)(66946007)(66446008)(91956017)(6486002)(6916009)(53546011)(6506007)(6512007)(38070700009)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUoxVW9iZXVsdHQwS1RNR1RpOFBDNy9KMTFLWndGVjRRaHZrVlVZemlnZE43?=
 =?utf-8?B?Z0lKYTJDVGJlbHA2elM4TDFTMlptTW9yV3g5WE1kNCtiWTM5a3hYdnJKRlJs?=
 =?utf-8?B?N0hIWlZra2YyRjkrRHhUVkJOSVY2a0JqTkxTRTIyWVFXN0s4dTlQdCtqcjZH?=
 =?utf-8?B?SlFrUFIrSW04RUNmcytBazRWRGlqbXgvaHM0bE9tWG9pZjZGeEJhL2FFQ2ts?=
 =?utf-8?B?b3R0VlQvUVBxRThkMlpEYXRPaHlUVU9lemViN1FBOUxNU3VrTnAwdkZOdDlx?=
 =?utf-8?B?N2RvQ2pjS09neUlMUUlyT3Y5MlVVbGxoZUtmcjlFUWZsNCtMY0lMSEIxYk92?=
 =?utf-8?B?ZkZwMzdESWRpd21KczBleDF5ZktUQlJSNVRxbDczV2p0MStyQjl1di9vazBR?=
 =?utf-8?B?bjlmTktMdmJaVG5DS3ZuanZjQzdRUklwbzEybXF3WHU2Vkp4bTkvYmJ0M2w0?=
 =?utf-8?B?QUozbG1sajhxL1NxcmlQdnZlZHZrcWsyRG9MTlpodUFaM01Fbnl5cDgrSms4?=
 =?utf-8?B?ekdvUnI2NVpnN21iYmZST2ZLY292WVhqZVVoZzIvZ2haQkFnRTh0LzlBMWdT?=
 =?utf-8?B?OGt5a3ZrZzd0Nlg5ZFlkU3A3L1lpQXh0d1Q4U0NPWFdLcUpmOXA0R2U4RlZt?=
 =?utf-8?B?WnI0RVNWN250ZnZoV2pEb3hPTlE2ZGJvaW1WcHYzclV4bGJYRmtMNHVWS1pS?=
 =?utf-8?B?N2F3RHc4VURldytIRFhYM0JZVlJ3RnhxNWxvaXJTNnA2YUVCbkVTMzBiQ2Ir?=
 =?utf-8?B?M1JCWmpVUHNTUzhmdjRVVnRnYnB1VE1ITnpCQnpqNVNCcXI4TnNIUStaRWRG?=
 =?utf-8?B?NDdheFFQR3NuczcweWxoeGVKcVJvdEpKeC9vT3JaaHIycFNvTjdWOXV3Zzh1?=
 =?utf-8?B?cmowVjJMY09tVVNTdlFoNGM3cEFnQmphdEFvaHBQdWVUVDhUa0hWbnpHb1JD?=
 =?utf-8?B?S05maHppQWhBNS92alJXQWxZMDJmdTNrK05PcGhoUHpJS00vY0swQUsvOHZP?=
 =?utf-8?B?elRRdy9pN2kxVDd1WEJIaWVKSlZRWDE1Rld0NW5zNHFHU25zVjl6QzNST2lJ?=
 =?utf-8?B?S3N0M3RyMS92NXdValNDNUdNZ2NhS244V3lLdng5NHZiTnFwemlhREw4STJs?=
 =?utf-8?B?ZjZWSU5xRzhSTWtORHlsaEpYdWVGOHdBZjI5SmJZSGdsSUNEckppQWFSVXZS?=
 =?utf-8?B?RjNSeUN0T09TN2w0UkQrV0JMN3RvU2hLRmVoUWhCM2hiNFR2MFVQd044VXBy?=
 =?utf-8?B?WTF6dFNRMFI2SmVCdWFuV2VYR2tTdGtWU2pwVlBKVk5XZ3d4UFUxSGxKdHc0?=
 =?utf-8?B?Ym1QMFBHTmZGTlNXdWxZUTJ2REJDbWJQRURNS3ZydVJPcnhhejN4ak0ra1Y2?=
 =?utf-8?B?bFNHNEJIYW5PQm5JWCtIU085NlNsMDRKR3B2amdmWGZaUVVMVC94c09oVVNs?=
 =?utf-8?B?T1FnYk82SkFFL2FvQkcySTExYS9LWGgydHkyTWpOSHZMZytVSklRdFNWdkoz?=
 =?utf-8?B?enZSNmY5UFNaTHBGbFNnUklKQ01iZ1JMQno3MGc2UERSUVY0VXVUU3lvV0JU?=
 =?utf-8?B?bGRWd2w5U252cE43aXlFbGxpMWc5eXNHM0Rya2VvSHl6S2lUWG96ekwyNGpI?=
 =?utf-8?B?WE9qd0ZmeS9yUE1sQXdSZStMSHpnQ1Y1OWdjaSttVkxzdGxmaHNWNEJFbnJl?=
 =?utf-8?B?ZksvRUczOUZVTXFKeHJrZzN4U08xaDJzcUlZYk9RM0svY2RwZXU5OGFaYUlU?=
 =?utf-8?B?a0JFTzR5enBWSDdZSkNFSzgxcnhtMnRUbXIrckxzS2pMMFdsUDJSeHNOZXp0?=
 =?utf-8?B?MXlzRTY4VUM2MG43Q0kzeEpMcU82anBWME16NmxzMXFwMmxEenBkWmxFbG9s?=
 =?utf-8?B?WXRrbWpqSEN3azRtQW5RM3lQbzNDOFc0eDl5QnRtRzJvd0JROGpXeUUxa091?=
 =?utf-8?B?Tzh1QmZYazV0MkEzVXRKcUR1U1RQQnVkWklNNjU1czdTbjMvM3JTSDNyb1Zp?=
 =?utf-8?B?ZFBkK0tYU1p2OGFtdDNaYkJUMDhlc0k1dlpMUzdSd3U1N0tiTjlXWGJNNnNB?=
 =?utf-8?B?cSsyKzVGcUVnRFdCRDQ3NUxVTXNZeE1CbTNsYkd4WHpWTm9hVTFBTi9xMi9M?=
 =?utf-8?B?OXoyMGtSbGdjaUsyMVdCWE5SUGcxZDNHNFZBOFU0QVBtNVl6SWRXZzhvTzdO?=
 =?utf-8?B?NkE9PQ==?=
Content-ID: <1EEAE93B14BB97419D3F8A0DB2F283E8@jpnprd01.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3j6dOHWODyU8bYXUcC2+6Ds410VHl1AqLQNjEtX0HhcZxI+xfVHpcurRF5d0HeL4dYWTWRuZnLdU+bYgLonaDI9PAItbst34MksMsqN1yol8nCglws/9o6BA/xHgmnAFl//ZbXONHqeN7eT1HrqlKXYDOBF+0qgiCXTJn3cpH2f+wmnDSU15HwSzyn0kJ88Jyq0Xk41czKYKbLJw5V3RJ6XQGObSdy6n8EOy3biXdCb40SjrCDFXqOIODDtjh4khj0iQo2IA9r3QArMlHfMjX1eM0AraFYVvX+x8pVDr10OPiq9LLJGdIeOxhnBQy0niwYpzxqGVLB25G0XgHbbMzeRAFQSDiQZvVoHoZ0BBNmaVqryNoq0xP67byTMOaufxp9D7waEefOq0Asr0r7kWoDZUao1tUtP+JE4GHp+qxSK+A+XZqOtJu9/ZvzvQL4OxDZbv/CFSQVJUxQyRcd9QI+2tdmpKx4zvBR/F2d1ymOv3mAmhs2sALUPNinEHbbSny3IoFsHR/dhI0LdxLr+DUpaX49WPyW/u0esp/x8QFZJ8t7cZTGc5q1AH1tDqQwTyJ4aXrL837Hiquiig+fzPw3V8vghi1ADezAYiQFm44rFEzIThgpzuMrXWc6U07G4n
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e14e4d-015c-42e6-7b95-08dc10ad4b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 00:52:45.6436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZHUbKCeu3rpPNyVf6x7Agf6/tL6J2qrM1uhBKUCOVM3v0Gl58JUm5Mmd6Rth40ZEOIZ/32NLmznMUYBo8YxqMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10655
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls: setgroups: Add missing gitignore
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


Sorry and thanks again.

i had not subscribed this mailing list before sending this patch set.
So i got "Post by non-member to a members-only list" at that time.

2 days later, i successfully subscribed it, and i'm not sure if this patch
set has reached the mailing list. So i resent it again with "RESEND" prefix...

Why it takes 2 days...., i didn't see the confirmation mail until i
checked my "JUNK" box on Monday.


On 08/01/2024 18:13, Petr Vorel wrote:
> Hi Li,
> 
> I see you resend this.  Please next time just ping in the original patch.
> We are sorry that it takes time to go over the patches in the queue.



> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
