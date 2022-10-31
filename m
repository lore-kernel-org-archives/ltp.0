Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0826EECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 15:36:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DB433C08E6
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 16:36:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9C9C3CA9C1
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 16:36:14 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B669220032F
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 16:36:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3TgWhq2cANOTVQWpZ2vDMlcUdcJ+Hc4jEUkNcuKSud/3mbt0h7U78yM7wJff3Ffhu2MhO1b9w8Ap7xZda9WNPnqqh9veglmhv19DCELxhRA8c97yF7FWAvdYmP/v5Jyz1pj5Y23ARfdDyVnWwbK5Agoa3abIc3XUxC3uWOfIcJVtnxW2A1XGtm30oDc8YgRe+m/2fEG4ejjF1E4+UyGQNqHccqT0zsaGV/bKmTAh3V2cUD48WEtlLovtEgP9yqmQrmz856ubxlS4L1nyJpGnislq2XqAksMbCUbzDyDWl7+i06uSyNzlqq4pz4aqQOmANc9qYKvZLn7DXoVbClszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iriVLaFFkqScnSkJ3HqWFyxQ1UMXhNZ5IYoFwAlS6ZQ=;
 b=C4fdyZ7gCRjHiCDCb7D42oTqxV80KuQHZc0KUlMfK/vsyNTWAdOg2zW4F5qWrqtA5cchQkdvrrK5Rl7NjnWkgS0TD9++4q7Vh87Q7iXu3gcT9ZTzGLHhjSHLPk2yyJN+1xCb59gmhLzt9qr+p1+GBQzwVVCoN2oLi0NzecIo7wS/lU+01sAlYG/axTEp0J9oorOdumSsjhDlqkqRaZngXv+T1TVIJWoCGkH7QzpGXdns58sZgyGwaR8EA8ZPR/6kexBMXKBkuwT6BwIzv8GlokhbOpnLXy4/2bFeputpVr43Q8rkzyhlGUaVt84GW9z/90KbYzd5PSHuTwZ+aCgNjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iriVLaFFkqScnSkJ3HqWFyxQ1UMXhNZ5IYoFwAlS6ZQ=;
 b=ZO1ZyDClEP50GIBpJHsPJTDhwNtJ4v/mfln5FLOiAN1ONr3Xe3UQUQo/mnIJvpQR2lzkUPefbRARHChQj441aBd0UQbQfIqZFRR3j4WJmj8y0u3IKl5jkUNZungO29/1BOfy8iQwaykjPFziVonoamNR3zUoCnWXTK3dAm74EpDOc0sdRyRNvjXTDH0uvjsXYASFAhSJWuYNlcNSxbbRkq2tQ5lc4aWe3s6Wtwgadv9SV5t1pGeYQ1V2v+EpQBmDO/ShM038/qyqYgk5PAXUtNgzB7c/suKP/lKLekvPv3nNT5swv61KwSnqwYdpC2LFVlWFU/xXqZ8T4SBhzGHvXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by DB9PR04MB9308.eurprd04.prod.outlook.com (2603:10a6:10:36c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 15:36:11 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 15:36:11 +0000
Message-ID: <416608e6-10ac-c943-1fc8-a3944286f193@suse.com>
Date: Mon, 31 Oct 2022 16:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 automated-testing@lists.yoctoproject.org
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|DB9PR04MB9308:EE_
X-MS-Office365-Filtering-Correlation-Id: fa18587c-b270-4d67-d201-08dabb55a320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MTVM4O4wDAFgU1iVCandF8t01O+04VcApjlnoBm224GfFveIQKPbp3rFGymSroN+AqlozPj/7SIE+s9CMul8hV0tZ4y5JiedvdodPSO0Bl1KVcLbkRBr761+5yI9Gsnf1pJJ17FrLg8ZAQztgriD9quZEKdg86tcjcQ7BXEUp+uYiJ5JUAA/B3gZn4SvIfVN2g/qYyzn+xOXfLVeYbeg8Yr30/lrdhdLOJu2qPDJ1XDlIVzBE0h++SrxdqhAoWLN/BAHlb2OuWfhjlS5hy1fQaqPeKcIf1xSTcRmR/b/9wgHwFDNhWuTcdXC7q4TtXoLa8bC/lZ16MA3oNWOmJW3pgFS1BWObr2UkVwZONuIYQI+HNhCrRuKmaO77V4l1PiIesP8qKnb3zbFXtc388cpcJ7Y3MOfMzzPiwe/XOhqzOemwB5P8Zqi1d5S3kYIn7LgXFdsBa/3+wF1U6xoFe7z16TNxKhgXhoFq1I9pyhbtFFgi3dgJ72X613sJ3NClS0qoWA5WmRPFXIoaP0eNIfWeLK89iRoxWmGP8OXDqZpPMUacg1Jyx7XiCJQopRhO/Pf5/5X80G7euI7PEvob0pwriWuNvRnwykFVulIJ/CaF9vp0wNulXUCdYtl3O7kyhRyz5Ooxfov+26l33Qnnrt1+gNCH49YXuIDWg9TeuWhR4cLCmWEPXUqmQyc9v6ohsEvs4J8vgOc65a/qE4mSeOpcFXW4opwZQ8rA8igiHXsP8QiDc5FYsOl/DN7Qn111A4S2RAG6whEgu3+xMN+5yrDdST6i0XsGoez+Ca7Bkjln07tkAe5HlZ3ii9Ge2rPKUqLICMU5xz66mfwIg1UeLX+84SoHsUvMSgynlDyYHinhE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(316002)(478600001)(66946007)(66556008)(6666004)(6486002)(966005)(66476007)(6506007)(8676002)(31686004)(41300700001)(38100700002)(36756003)(26005)(186003)(5660300002)(8936002)(44832011)(31696002)(86362001)(2906002)(2616005)(83380400001)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anRveldEVktTdDB5b0QwaXZkZTVCb1ZSdVRKOWE1WUE5ZnJXcWJrTVJRWXFO?=
 =?utf-8?B?YS9NSDZaSFdIeEdhRFdRMXdlSFA4Rk1ZaTJmc2taZXdyUzIwVzJ0QWZNZVNw?=
 =?utf-8?B?NnpYRjFDWGxSd21CRW9IbWpVZSt6VTkvMy84T09GMnJRTXQyc1RJcngvUEw2?=
 =?utf-8?B?VnFMMklRL3lKRXRtaSt1OU55Vzc0Y2Z0Qi96Y25wd1d3VFoxRVd0SURQZ0cr?=
 =?utf-8?B?WGlwRUdGRERBM2wyRVRHN3dFV3llUkRUWmNhWVVsZWNJQUZucll2T3Qwek0r?=
 =?utf-8?B?UFhOMWd5UUlacU9qK3J1dUtxR21IV2JHK2xFbmwwd1FETlh6UmUrRVZnVmZ1?=
 =?utf-8?B?MTBDU2Vrem9DNVQxYXFzWm1xL1ZpQUZ4Z2d4UjRRcXpTUzlxTFdFUzNaYlpL?=
 =?utf-8?B?ZHljbnBUNUI1dlRkMkxuOHRhR1hkdFlyNHNteHVZL2lpQjd1QTRwcTIvZ1hx?=
 =?utf-8?B?cDkyRFY5VVZ4NnZmQkZuSnBQZ01mR1BLQW4wRlVaVzAwMEpXck05QjBEd2JB?=
 =?utf-8?B?NllENEJDWkJHOFdLOE9CWXQ5K3pjRGttbXNxS3ZuVU1JWXpNaS9oOVl6UEYr?=
 =?utf-8?B?TFR1UlA3d2luYnhqcE8yVzBDaEpydGRMZjJObXJ5SDVFZlhFVEtad25yZ3Rp?=
 =?utf-8?B?eTI1MWx0QzZ1WGJobUtGSmN0b1hqdWhDOGtQclVsNCt3MkprdzRCNVNSa2Iy?=
 =?utf-8?B?b3ZWbWdIbHFEVkxUVkcza2ZIUVJMNGRmQUgvTlhWOGNtUWQ2QncwVWFwMzVR?=
 =?utf-8?B?VGluZzZQWWRHVnlDR3VHTFlZSkVaWVJuYm9ZOE5lZlVNOUpaNjk4ZzZ3UG1v?=
 =?utf-8?B?ZXNoSWxlajlucGxmcWovTHgzaHVJUGNHQWRnclhmU2QzTWVJUFFPdFFTTm9J?=
 =?utf-8?B?eWx2S3lTVXB3Q0J4emdXM041UndhaXpyckhPT3VQdnR2YVJ3VTFXMlpHUGFE?=
 =?utf-8?B?RDdqMTZtazBxSW9GRzlZS2VuSmZWU0dteU9meUcxOU44Ly96OHJlMEpnTVpx?=
 =?utf-8?B?cVBXSjZ0ZW03OFliZEltZXdSaTlYK3ZXUkxjVmZQbmxuZWVybWg2T2RFVHM4?=
 =?utf-8?B?M1l5NjBId1ppWjVib1FqdUhzU3NXSmxCMDMxSThFN0VqYUpKdmxpcElBMkFZ?=
 =?utf-8?B?TytRQ0NPM1VhV2Z0eWFnNDM4UjRHcFlaRUJsK0hURU9KNXg5ZFZiRHRPUG5x?=
 =?utf-8?B?T2s4UlVoNy9mTVIyV0IzZ254dnBCSFNPbEc5QVdLUTc5QmJlT0RxbERKU0ZL?=
 =?utf-8?B?ckVCaGx5YUZJRE52cVpYSGZ4eEN6L3dCWXEyN1BaVm5lMEpQQ0tRL0J0VWc3?=
 =?utf-8?B?eit6MmlKM3RGWkNacCtKK3d6Q0NMWEd2U0tHQ0FBZmhZd2lxTzhTT29OcGRV?=
 =?utf-8?B?UkhvNU9jV0dUWmNRUlMrb3NrVm9OYkpORFh6dUJaRVErem9tdDlldCs2OVRZ?=
 =?utf-8?B?NXVLOHpTdis5QUFwb2VFaDJ3L0V5WVhnOFhLd2g2ME5uUmJCTktkTTJxeGph?=
 =?utf-8?B?TUI0aW9xZGVIOGRaSVExSmx0YWQ2RGdkc2krdllSZVpNbFNIQTNEY2pkU3B5?=
 =?utf-8?B?UlU5Z1IzOEp4MjV1V2hyYWtpTTNLZVlMc0hIU0NqNUFTamQxM29aVU5ETnVF?=
 =?utf-8?B?dHloUG9MbGpBaHJIZXpiVHVYR0ZBOXpVNVV2WUZJeWRxbW1OR1FHb0owKzRk?=
 =?utf-8?B?UDdpWTZYNGVySGVZTzFzUlg4cmNtVXdmVEpvTTlCMC82TUpQNGpSWitybjlX?=
 =?utf-8?B?dmo1WjdlSUJFdXhNa3A5TGh3M1Y0YjZ1RHc5L0JSN09UU1VmUWkvNEhCMzZU?=
 =?utf-8?B?b0s3RXNPRlo3cDNEalk4cHFqNXVsY1NoWHNWWnJDQTZDcVViZTdGVHFGQmFr?=
 =?utf-8?B?Zk9TdE5yZXd4ZE8yUkY1dkJwdDdoRzc0OEQ5OTNwQkU3WGtOSGRnc0tSZStU?=
 =?utf-8?B?ZEY1aElKU3VnNlRNbE9BZ3R6U3BwRUtoemdnTE41UWVvYjlobSs1aW9qYUR1?=
 =?utf-8?B?anNIZzNrMGdELzVqK3lxN1IrS0prblVxdHR2MWJ6cWJ4M2JwWFFid3ovOTdh?=
 =?utf-8?B?d1BRUU5XYloxcUhsWnFVZTJJSXhJTkxKMFpIeHpkR2J6UmhFTTl1MGxRVVZC?=
 =?utf-8?B?aE5nN2tKd1lsVVBsRjRIdHZsSEUva1Y0b0llWE9aUWZmdVBXSWkzSW9YZmdj?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa18587c-b270-4d67-d201-08dabb55a320
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 15:36:11.0578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6KngldHn/VOC5lF5KF6toqk69FCFoA1jCR0rBIhcQm+XH1cg3NDl72e9eszHZaAzDRgbUzkTQfdoAjY0e5N08hx3n+ErE+6POG8q5un35k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9308
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] Include runltp-ng (runltp successor) into LTP git
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgphcyB5b3UgbWF5IGtub3csIHJ1bmx0cCBoYXMgYmVlbiB1bmRlciBidWcgZml4aW5nIGZv
ciB5ZWFycyB3aXRob3V0IApwcm92aWRpbmcgYW55IG5ldyBmZWF0dXJlLiBGb3IgdGhpcyByZWFz
b24gdGhlIFBlcmwgcnVubHRwLW5nIAooaHR0cHM6Ly9naXRodWIuY29tL21ldGFuLXVjdy9ydW5s
dHAtbmcpIHdhcyBkZXZlbG9wZWQsIHByb3ZpZGluZyBhbiAKYWx0ZXJuYXRpdmUgc29sdXRpb24g
dGhhdCB3YXNuJ3QgY29tcGxldGVseSBhY2NlcHRlZCBieSBMVFAgY29tbXVuaXR5IApkdWUgdG8g
dGhlIGNob2ljZSBvZiB1c2luZyBQZXJsIGFzIHRoZSBtYWluIGxhbmd1YWdlLgoKRm9yIHRoaXMg
cmVhc29uLCBhIG5ldyBQeXRob24gcnVubHRwLW5nIGhhcyBiZWVuIGRldmVsb3BlZCBkdXJpbmcg
dGhpcyAKeWVhciwgd2l0aCB0aGUgdGFyZ2V0IHRvIHJlcGxhY2UgUGVybCB2ZXJzaW9uIGFuZCB0
aGUgY3VycmVudCBydW5sdHAgaW4gCnRoZSBuZXh0IGZ1dHVyZS4gSXRzIGNvZGUgY2FuIGJlIGZv
dW5kIGhlcmU6IApodHRwczovL2dpdGh1Yi5jb20vYWNlcnYvcnVubHRwLW5nCgpydW5sdHAtbmcg
UHl0aG9uIHZlcnNpb24gcHJvdmlkZXMgdGhlIGZvbGxvd2luZyBmZWF0dXJlczoKIMKgwqDCoCAt
IGNsYXNzIGJhc2VkIGFyY2hpdGVjdHVyZSBpbiBQeXRob24gMy42KwogwqDCoMKgIC0gaG9zdCB0
ZXN0cyBleGVjdXRpb24KIMKgwqDCoCAtIFFlbXUgc3VwcG9ydCB0byBleGVjdXRlIHRlc3Qgc3Vp
dGVzIG9uIHZpcnR1YWxpemVkIHN5c3RlbXMKIMKgwqDCoCAtIFNTSCBzdXBwb3J0IHRvIGV4ZWN1
dGUgdGVzdCBzdWl0ZXMgb24gcmVtb3RlIHN5c3RlbXMgKGluc2lkZSAKJ3NzaCcgYnJhbmNoIGZv
ciBub3cpCiDCoMKgwqAgLSBrZXJuZWwgcGFuaWMsIG9vcHMgYW5kIHN5c3RlbSBjcmFzaCByZWNv
Z25pdGlvbiBkdXJpbmcgdGVzdCAKc3VpdGVzIGV4ZWN1dGlvbiBvbiByZW1vdGUgc3lzdGVtcwog
wqDCoMKgIC0gSlNPTiByZXBvcnQKCk5vIGV4dGVybmFsIGRlcGVuZGVuY2llcyBhcmUgbmVlZGVk
LCBiZXNpZGUgU1NIIHN1cHBvcnQgd2hpY2ggcmVxdWlyZXMgCnBhcmFtaWtvIGFuZCBzY3AgcGFj
a2FnZXMgKG9ubHkgaWYgU1NIIHN1cHBvcnQgbmVlZHMgdG8gYmUgdXNlZCkuCgpXZSBhbHNvIGhh
dmUgYSB0YWxrIGluIHRoZSBTVVNFIExhYnMgQ29uZmVyZW5jZSAyMDIyLCB3aGVyZSB3ZSBkaXNj
dXNzZWQgCnJ1bmx0cC1uZyBkZXZlbG9wbWVudCBhbmQgdXNhZ2UuIEl0IGNhbiBiZSBmb3VuZCBo
ZXJlOiAKaHR0cHM6Ly93d3cueW91dHViZS5jb20vd2F0Y2g/dj1KTWVKQnQzUzdCMAoKClRoZSBp
ZGVhIGlzIHRvIG1vdmUgbmV3IHJ1bmx0cC1uZyBQeXRob24gdmVyc2lvbiBpbiB0aGUgTFRQIGdp
dCAKdXBzdHJlYW0sIHNvIHdlIGNhbiBwcm92aWRlIGEgc3RhcnQgZm9yIHJ1bmx0cCByZXBsYWNl
bWVudCBpbiB0aGUgbmV4dCAKZnV0dXJlLiBJZiB5b3UgaGF2ZSBxdWVzdGlvbnMgb3IgaWRlYXMs
IHBsZWFzZSBmZWVsIGZyZWUgdG8gc2hhcmUgdGhlbSAKd2l0aCBMVFAgY29tbXVuaXR5IGJ5IHJl
cGx5aW5nIHRvIHRoaXMgZW1haWwuIFRoYW5rcyEKCgpLaW5kIHJlZ2FyZHMsCkFuZHJlYSBDZXJ2
ZXNhdG8KClFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlv
bnMKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
