Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30C2C43217
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 13:36:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56E213CAD99
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 14:36:43 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB9873C0166
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 14:36:31 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EA6021400125
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 14:36:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aD3X/H0hAaGdxmgEcE7/H/CPwp00G3CfoE3JFsxgty592g4/r8Edp9fn50j5cNg1iIDLK1LtX/MeUTXcXXgHpum6zWNVgXUp9/yVnPHkgjQFbxul+n0xixmZcNF4b9ksqGbnAvXWcI9k5QQC0XSjTazyLcVV/bOCzvDHM29cwbyOjwokvL+p/kD3Rb20TNRwfVPjUMiC5YdQztue4xMhI6aZvBR++ywnIHzCkjtAy28+6uC+l3yVWpC+V7wiSNbCC0A5a/HzKCTEtcCsIwPRmbWlbh+BlCVIFDtxtOmkUEPT21mV78oSGRIZsTC+4RI731HVzvPrs0C0d05hVIFfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWDXY6QUi/EsfBMARgKix+inPqncYD7uofuGXb/ujcs=;
 b=j8oalfoYOyRLUVrcyWmH2kuu9KP6CiJwxDTGthoyLA7Ilmgwfk3S+XaET5u6iKqNZUJfTKhBmPDDfQx9tvc6FA2VF7YlTLNgP891H5kHfUD9xyemjTr5XoszWcc+poVsUpXdQ7uXm8VS8QhOtX7tBFedYjjpmbqotj72zkmCXB7Ig915PdnSDUCWlBNdpTsDoVKEZPRU5kwf2PeFyhDQLDNsJ5zQmcN7FRbitiP+LF66wefdqBITvyp/0SOuoNBVkgF0NZ4bI5GT+OPN3V48H0UJ3F+bGTX+KafIcbUNlUxhKHSW/tZQdz2jcwXO+kYPovyAGtqRNyakV6aOeW1wfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWDXY6QUi/EsfBMARgKix+inPqncYD7uofuGXb/ujcs=;
 b=j2mhPLyxgmblv1MBADxTfUYT33zS5n7dtbmKQI+vayPkU40v8UjrTobAM37zpwL6tzlLky89t32adRpzz76WQaH7jvmDv7hoJ4PODbZWdG37Ivl2WiAxzEyN1m2ctLB8GhfWdO9yNKLQGML3S9z7LY+8mAcTfOWpQgrvf1klHArGWQcfCyvihtLK0y6KMQXxGomxlOGj0fqkAtC1f6ZAu767kFgDB41f8DeGtMzWped0GNesRITjUOhrWz3lRMIVjpvPvUcsrSrYrWppP/UqF2Sz6XrI2JMM+C9EAdh9kIhFYj6wGeN6Jl/JaUCWj7mxb/d/e9WT5uaT8asqFFtS+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB8319.eurprd04.prod.outlook.com (2603:10a6:102:1c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Thu, 3 Nov
 2022 13:36:28 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::252e:5914:3caf:6257%5]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 13:36:28 +0000
Message-ID: <1af8a502-c736-c31a-8794-c847788c8766@suse.com>
Date: Thu, 3 Nov 2022 14:35:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20221102145935.24738-1-andrea.cervesato@suse.com>
 <61b788f9-3b62-d0dd-2679-e21cef89bffe@suse.cz>
Content-Language: en-US
In-Reply-To: <61b788f9-3b62-d0dd-2679-e21cef89bffe@suse.cz>
X-ClientProxiedBy: FR0P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::23) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 03fd6005-ba74-4474-079c-08dabda068e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FI96anHqF60vhmidPYj10skQxQtepA8Mk7abs+8kOvtQ7Kd3+TeXhOm7G46m/+NowXXYDZBAMa0o2xXpLrlj40/IXKvdP5lIp3p/OZZUFGBoAm904adIgJXDZhLBgCYXke9/yALxH45Lc0U8+l/hIMIWdtYnJjn/oaX50UdNB0520RpL1t9GU9AfTCTotJ1UPuTeZYs26JamFwsVsl/weCmvSGVQrz/f4HjC5E3gEYfBMNgeIBM1v4zP03eFANNunX5SuXwggOazKk7liv1pUTb/29/4y4RoVamtGKdyc0j2BuDGDHqegHMbpiVKSi698sHOMMb8PivyPCbvZxrKOJfEZqi6Ct/nleWJqBpnkU5JgrpXhFXfa+AXC9QjMvKdQvlzCaBo3DQEf9XZHvpIEnu469DC/No45wBDEO/FNRqomCitgNJFEzFkLtVhFRFYu5k3ZrgC5rqA3/JUay8N/8yrcIGvBYJooVjK6Edol4UjkL1W5/4qfZpAmIl0KxcnNSfx9HZKeDSDnPYsqWixaScOYt3nCVwEOqYPMxoY+HQ+sWiRfMu7TyOnKXIjsnQCJQ+BYY84GB7xW86Wl3ROErq6Z+pZiVgKCZiz2Q50oFuxu634gbbJH2efC/4Dowyf4Uj1i9nlR02/UT7593DP10QQPRl9qeSgW/y/Bb7mIEYkygLleRiIvMugjV7NloRvTBq0WbzM+qFIPyOx9CLKjhK3RnPtPFaSbFDxJ5bOQ4OGMpiJh81H4GUSV6EZDBfUdSSrvIrE7ktSxt9RegBT0LOm+PLmWCzazEkgfxoC/hc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199015)(478600001)(41300700001)(8936002)(31696002)(2616005)(5660300002)(86362001)(26005)(38100700002)(66556008)(44832011)(66476007)(316002)(66946007)(8676002)(6512007)(186003)(6506007)(2906002)(53546011)(83380400001)(6486002)(6666004)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFUzczRDeHNldHE1V1lHTTBGSWoybFZMUTFnSVk0VXBGYUlIbUVTU2pTei9z?=
 =?utf-8?B?eGx1bFFyRHN5bnhIQnhrVG5US3NFdFlEMEJVbFUzUnl3WDJPeW52NldWWlRx?=
 =?utf-8?B?c1dZRFR3dVFEQ3hNSGRDcFV3c3BNcUxkWG1WWGp3blZUL1FhMThmTVNMU2lt?=
 =?utf-8?B?STRoZEMwY0FCdjJVN0hhWUk3aGdZdVhOaFhkQVVyMndIekZlR1FlWVZQNnYr?=
 =?utf-8?B?SytmV24yUWhES2xpOHEyREZ4N2lzOHZCTEZhbk0yTTAzV3VDSlhZcEI2NW5W?=
 =?utf-8?B?RW1ucTIrN0hXd0NPd0ZDNkUwZjV4RTdCS24yaVhyZzBvcFI3RnBzTi85eVZx?=
 =?utf-8?B?NGRVdDk3d3lZUWh2QURqRXVHazdRQ1NjMjlsVmUrYVAxSXdLMGhXTGFkU1cv?=
 =?utf-8?B?cUFIYXUwNTlXWHVyc0E1NjdId1A5WjhZczRoaW1FQkE5a1gxTWNkMFZtU3hU?=
 =?utf-8?B?LzgvdzdxREpwbkMvY3VxTFRBRjA2MXIyZmdQamNwMzJ5cFVHem4rUEQza09U?=
 =?utf-8?B?VERTQytUY1dyTWxxN25uM0ZNT2s4b2prWVBCZjB4VU9qSmovMlUyR2hzak9Y?=
 =?utf-8?B?bzhZa2VtT1BYUFBGRTMwdVh6dXFoQXhTVGVodmUxR0JBRGZzUlBBWk9lSzYr?=
 =?utf-8?B?UHFMRlJyeUhZb3UzeDJhSktWVkE4WjhhdXZ4M2liSzNmQWd0Q1cyMjh6Ulpi?=
 =?utf-8?B?UFczZ0d2c1NadWZDS1VUeFpHV2hsek9McmNwb3owdENoejFUbVllU1RZdE5a?=
 =?utf-8?B?b0tUUGt5OWpycGlRREhjQjB6eVNpam9IZ1FVRkQ4NnNvTnN6S0VhSllBemMy?=
 =?utf-8?B?VENUSWhNSmxlcEszSm01aUZaWXBtcWFPVmJ3SmxsNnQ5QU5UUkhYNk1jZVFU?=
 =?utf-8?B?USthSzJhM1JWZ3pUNHltNXlxVkhVYkZNcGZJUWpLV2lyZnlDZEkrMnZubmw4?=
 =?utf-8?B?eHlpMzlONmZNTUE1SS9qc0EvalJwQWN6dkI0N1VldE5oNm5vOVRnM0N5UVRS?=
 =?utf-8?B?WTFIQ1pteUY2M0lFY29BTjljUExrTGRSOTgxdkNISG9Fd3BEL0U2M0RTbGFh?=
 =?utf-8?B?OXQ5TDdiZUZ0dFdLZW9vdVlvWWxLTVZ2QU5BVWE1aEZZaGl5eEhBdEY1UW1z?=
 =?utf-8?B?NlJzUG5ybDJtL2xadlZNa1Z4ZmtUVGZvc09lRkh4MkRIN2dQS0dVMmtZYzdz?=
 =?utf-8?B?djl1OWphWUc3ZXF2R3ZxaXpUTVdUbG1JSzlmVUJ1SmVFdjVkK0NRUzFTbXF4?=
 =?utf-8?B?TG5WUHJBeUtCQ3R5MFd6WHVrcG4ya0VwdWtZNTlQUDNlQzMwTDlUM1lodW96?=
 =?utf-8?B?V1YyTWVzMDRFN1hWYUJSVlozZUtCTHlSN0FXRGNoWU1HeEF1bG1GUVR4a0Zy?=
 =?utf-8?B?QlE4M1dLV3lFZTh6bVBsYXJuMWtpOFJqTzJxNXRnYjNyRGMvQkJjRzBmcGNx?=
 =?utf-8?B?STI1Z0V6NlVULzlKcHlVMUZvaE9aWXU5MVBrblYzN3AvczJwUHZnczFQSlpz?=
 =?utf-8?B?VWFOWC9aTmtRZVFtODc5MDZteTE3VGhnRHgvTVNKTXNwajU2ZTZremkrdzkx?=
 =?utf-8?B?UnFyeTRjZkZyM2Zic3ZnNlF5WjBXQW1VTzlrWGFGaHZpK3pvTGNyM3RUMHla?=
 =?utf-8?B?aEM3a0JxbDVneG5LWmZmb3NNNXYyckVMM3ZmMHpCdS82Y1hTUXNHMlZvMCtD?=
 =?utf-8?B?TEtabVJpWGZEdmZqcVhUT3phb0VjSWYzYTR4ZjA3WGZTZVVEWkpyTUJaTFZ2?=
 =?utf-8?B?MXk5clpESzdQUUxuZkhvK2k2Q3NYWVdzVjNUMzJqQlY2V25CU3Rwa3MwRGhq?=
 =?utf-8?B?TW01di8xcWt6MCtnb2kyMm1YMWd6MzVGZHpFeDVTbGNncm4yZFJOd2ZMdnd0?=
 =?utf-8?B?c0ZsQXE2VnNOZTFROFNkVzF4dWdPdDJiaU5pbk1FMld0ZUhTSnNlN3lWclZq?=
 =?utf-8?B?RU5wb2ZJZm5iMzVGNmwrZm85OVl3MS8rWjIvWDFZWlcyRTlENTMzQXQvWjgr?=
 =?utf-8?B?RVFtZE9JeFY3VXh3U3NjcWtuM2FEVERxVHZWd3p3Y0k1NGxGemM3a3g1TXZS?=
 =?utf-8?B?WlByVUc0YlJwVHZXSnFSMzBvT211SVpzUGlUV3lDcHh2ckV4R3dQYjRzK0xw?=
 =?utf-8?B?aXVKSHFmRC9vcW9SSVBIczBLOUxpczJHb1RXcXhKWHRjTFZMMlRwQm5Kc2h6?=
 =?utf-8?B?dkE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03fd6005-ba74-4474-079c-08dabda068e3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 13:36:28.2378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oqFu2xMUEQH9i6wJHySehwBJkC9RVF1n9p6A+hvOKPB5yaUg0JcJrAZdcx53ide1KNl6phdDbCHsLBhYhtO6Te3zOnjHQXn1hIDjb7gu5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8319
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Correctly check setitimer params in setitimer01
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

SGksCgpPbiAxMS8yLzIyIDE2OjM5LCBNYXJ0aW4gRG91Y2hhIHdyb3RlOgo+IEhpLAo+IG9uZSBz
bWFsbCBuaXQgYmVsb3csIG90aGVyd2lzZToKPgo+IFJldmlld2VkLWJ5OiBNYXJ0aW4gRG91Y2hh
IDxtZG91Y2hhQHN1c2UuY3o+Cj4KPiBPbiAwMi4gMTEuIDIyIDE1OjU5LCBBbmRyZWEgQ2VydmVz
YXRvIHZpYSBsdHAgd3JvdGU6Cj4+IExhc3QgdGVzdCByZXdyaXRlIGRpZG4ndCBjb25zaWRlciB0
aGUgcmlnaHQgZXhwZWN0ZWQgYm91bmRhcmllcyB3aGVuCj4+IHNldGl0aW1lciBzeXNjYWxsIHdh
cyB0ZXN0ZWQuIFdlIGFsc28gaW50cm9kdWNlZCBjb3VudGVyIHRpbWVzIGFzCj4+IG11bHRpcGxl
IG9mIGNsb2NrIHJlc29sdXRpb24sIHRvIGF2b2lkIGtlcm5lbCByb3VuZGluZyBkdXJpbmcgc2V0
aXRpbWVyCj4+IGNvdW50ZXIgaW5jcmVhc2UuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBD
ZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4+IC0tLQo+PiDCoCAuLi4va2Vy
bmVsL3N5c2NhbGxzL3NldGl0aW1lci9zZXRpdGltZXIwMS5jwqDCoCB8IDQyICsrKysrKysrKysr
KysrLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDEwIGRlbGV0
aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRp
dGltZXIvc2V0aXRpbWVyMDEuYyAKPj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldGl0
aW1lci9zZXRpdGltZXIwMS5jCj4+IGluZGV4IGYwNGNiNWE2OS4uM2ZiOTI1MGUyIDEwMDY0NAo+
PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldGl0aW1lci9zZXRpdGltZXIwMS5j
Cj4+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0aXRpbWVyL3NldGl0aW1lcjAx
LmMKPj4gQEAgLTgsMjAgKzgsMjEgQEAKPj4gwqAgLypcCj4+IMKgwqAgKiBbRGVzY3JpcHRpb25d
Cj4+IMKgwqAgKgo+PiAtICogQ2hlY2sgdGhhdCBhIHNldGl0aW1lcigpIGNhbGwgcGFzcyB3aXRo
IHRpbWVyIHNldGluZy4KPj4gLSAqIENoZWNrIGlmIHNpZ25hbCBpcyBnZW5lcmF0ZWQgY29ycmVj
dGx5IHdoZW4gdGltZXIgZXhwaXJhdGlvbi4KPj4gKyAqIFNwYXcgYSBjaGlsZCBhbmQgdmVyaWZ5
IHRoYXQgc2V0aXRpbWVyKCkgc3lzY2FsbCBwYXNzZXMgYW5kIGl0IAo+PiBlbmRzIHVwCj4+ICsg
KiBjb3VudGluZyBpbnNpZGUgZXhwZWN0ZWQgYm91bmRhcmllcy4gVGhlbiB2ZXJpZnkgZnJvbSBw
YXJlbnQgdGhhdCAKPj4gb3VyIHN5c2NhbGwKPj4gKyAqIHNlbnQgdGhlIGNvcnJlY3Qgc2lnbmFs
IHRvIHRoZSBjaGlsZC4KPj4gwqDCoCAqLwo+PiDCoCArI2luY2x1ZGUgPHRpbWUuaD4KPj4gwqAg
I2luY2x1ZGUgPGVycm5vLmg+Cj4+IMKgICNpbmNsdWRlIDxzeXMvdGltZS5oPgo+PiDCoCAjaW5j
bHVkZSA8c3RkbGliLmg+Cj4+IMKgICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+PiDCoCAjaW5jbHVk
ZSAibGFwaS9zeXNjYWxscy5oIgo+PiAtCj4+IC0jZGVmaW5lIFVTRUMxwqDCoMKgIDEwMDAwCj4+
IC0jZGVmaW5lIFVTRUMywqDCoMKgIDIwMDAwCj4+ICsjaW5jbHVkZSAidHN0X3NhZmVfY2xvY2tz
LmgiCj4+IMKgIMKgIHN0YXRpYyBzdHJ1Y3QgaXRpbWVydmFsICp2YWx1ZSwgKm92YWx1ZTsKPj4g
K3N0YXRpYyB1bnNpZ25lZCBsb25nIHRpbWVfc3RlcDsKPj4gwqAgwqAgc3RhdGljIHN0cnVjdCB0
Y2FzZSB7Cj4+IMKgwqDCoMKgwqAgaW50IHdoaWNoOwo+PiBAQCAtNTUsNiArNTYsNyBAQCBzdGF0
aWMgdm9pZCB2ZXJpZnlfc2V0aXRpbWVyKHVuc2lnbmVkIGludCBpKQo+PiDCoCB7Cj4+IMKgwqDC
oMKgwqAgcGlkX3QgcGlkOwo+PiDCoMKgwqDCoMKgIGludCBzdGF0dXM7Cj4+ICvCoMKgwqAgaW50
IHVzZWMgPSAzICogdGltZV9zdGVwOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCB0Y2FzZSAqdGMgPSAm
dGNhc2VzW2ldOwo+PiDCoCDCoMKgwqDCoMKgIHBpZCA9IFNBRkVfRk9SSygpOwo+PiBAQCAtNjQs
MTQgKzY2LDE4IEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9zZXRpdGltZXIodW5zaWduZWQgaW50IGkp
Cj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCB0c3Rfbm9fY29yZWZpbGUoMCk7Cj4+IMKgIC3CoMKg
wqDCoMKgwqDCoCBzZXRfc2V0aXRpbWVyX3ZhbHVlKFVTRUMxLCAwKTsKPj4gLcKgwqDCoMKgwqDC
oMKgIFRTVF9FWFBfUEFTUyhzeXNfc2V0aXRpbWVyKHRjLT53aGljaCwgdmFsdWUsIE5VTEwpKTsK
Pj4gK8KgwqDCoMKgwqDCoMKgIHNldF9zZXRpdGltZXJfdmFsdWUodXNlYywgMCk7Cj4+ICvCoMKg
wqDCoMKgwqDCoCBUU1RfRVhQX1BBU1Moc3lzX3NldGl0aW1lcih0Yy0+d2hpY2gsIHZhbHVlLCAw
KSk7Cj4KPiBXaHkgY2hhbmdlIHRoZSB0aGlyZCBhcmd1bWVudCBmcm9tIE5VTEwgdG8gMD8KPgpJ
dCdzIGEgbWlzdGFrZS4gSSBzZW50IHBhdGNoIHdpdGggMCBiZWNhdXNlIEkgd2FzIHR3ZWFraW5n
IHdpdGggdmFsdWVzIApkdXJpbmcgdGVzdHMuCj4+IMKgIC3CoMKgwqDCoMKgwqDCoCBzZXRfc2V0
aXRpbWVyX3ZhbHVlKFVTRUMyLCBVU0VDMik7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzZXRfc2V0aXRp
bWVyX3ZhbHVlKDUgKiB0aW1lX3N0ZXAsIDcgKiB0aW1lX3N0ZXApOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgVFNUX0VYUF9QQVNTKHN5c19zZXRpdGltZXIodGMtPndoaWNoLCB2YWx1ZSwgb3ZhbHVl
KSk7Cj4+IMKgIC3CoMKgwqDCoMKgwqDCoCBpZiAob3ZhbHVlLT5pdF92YWx1ZS50dl9zZWMgIT0g
MCB8fCAKPj4gb3ZhbHVlLT5pdF92YWx1ZS50dl91c2VjID49IFVTRUMyKQo+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0c3RfYnJrKFRGQUlMLCAib2xkIHRpbWVyIHZhbHVlIGlzIG5vdCB3aXRo
aW4gdGhlIAo+PiBleHBlY3RlZCByYW5nZSIpOwo+PiArwqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhU
SU5GTywgInR2X3NlYz0lbGQsIHR2X3VzZWM9JWxkIiwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgb3ZhbHVlLT5pdF92YWx1ZS50dl9zZWMsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG92
YWx1ZS0+aXRfdmFsdWUudHZfdXNlYyk7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChvdmFs
dWUtPml0X3ZhbHVlLnR2X3NlYyAhPSAwIHx8IG92YWx1ZS0+aXRfdmFsdWUudHZfdXNlYyAKPj4g
PiB1c2VjKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0c3RfcmVzKFRGQUlMLCAiRW5kaW5n
IGNvdW50ZXJzIGFyZSBvdXQgb2YgcmFuZ2UiKTsKPj4gwqAgwqDCoMKgwqDCoMKgwqDCoMKgIGZv
ciAoOzspCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDsKPj4gQEAgLTg1LDEwICs5MSwy
NiBAQCBzdGF0aWMgdm9pZCB2ZXJpZnlfc2V0aXRpbWVyKHVuc2lnbmVkIGludCBpKQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgdHN0X3JlcyhURkFJTCwgIkNoaWxkOiAlcyIsIHRzdF9zdHJzdGF0dXMo
c3RhdHVzKSk7Cj4+IMKgIH0KPj4gwqAgK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4+ICt7Cj4+
ICvCoMKgwqAgc3RydWN0IHRpbWVzcGVjIHJlczsKPj4gKwo+PiArwqDCoMKgIFNBRkVfQ0xPQ0tf
R0VUUkVTKENMT0NLX01PTk9UT05JQywgJnJlcyk7Cj4+ICsKPj4gK8KgwqDCoCB0aW1lX3N0ZXAg
PSByZXMudHZfbnNlYyAvIDEwMDA7Cj4+ICvCoMKgwqAgaWYgKHRpbWVfc3RlcCA8IDEwMDAwKQo+
PiArwqDCoMKgwqDCoMKgwqAgdGltZV9zdGVwID0gMTAwMDA7Cj4+ICsKPj4gK8KgwqDCoCB0c3Rf
cmVzKFRJTkZPLCAiY2xvY2sgcmVzb2x1dGlvbjogJWx1bnMsIHRpbWUgc3RlcDogJWx1dXMiLAo+
PiArwqDCoMKgwqDCoMKgwqAgcmVzLnR2X25zZWMsCj4+ICvCoMKgwqDCoMKgwqDCoCB0aW1lX3N0
ZXApOwo+PiArfQo+PiArCj4+IMKgIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPj4g
wqDCoMKgwqDCoCAudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwKPj4gwqDCoMKgwqDCoCAuZm9y
a3NfY2hpbGQgPSAxLAo+PiDCoMKgwqDCoMKgIC50ZXN0ID0gdmVyaWZ5X3NldGl0aW1lciwKPj4g
K8KgwqDCoCAuc2V0dXAgPSBzZXR1cCwKPj4gwqDCoMKgwqDCoCAuYnVmcyA9IChzdHJ1Y3QgdHN0
X2J1ZmZlcnNbXSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgeyZ2YWx1ZSzCoCAuc2l6ZSA9IHNp
emVvZihzdHJ1Y3QgaXRpbWVydmFsKX0sCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB7Jm92YWx1ZSwg
LnNpemUgPSBzaXplb2Yoc3RydWN0IGl0aW1lcnZhbCl9LAo+CkFuZHJlYQoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
