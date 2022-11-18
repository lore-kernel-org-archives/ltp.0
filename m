Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D75C433FE
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 07:41:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8C8F3CCE6C
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 08:41:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEE5A3C76CE
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 08:41:26 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8BE2012E5619
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 08:41:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/h48dxdElvJzTCj6BDrhtJhsUGv7O9wgqGy5cWRZWlkNGiu0GSwyhgjEySwMQYy7KRMgF6RVa7oDicovDuQSSSVKbx49VlHHjPKYdoWvouo59qr4w2ONsS8rPoQTtZd92/I5aGgT10zNR1qZ0H6e5RNhRbOlL0eGZjuJn7rZIRgtVzCpKoQLAnYVFSZLygJX9ZXShJEvjgxpUYCpl2WF2AIrbSQnC1HGTZ+LeHz097dtU/squXV+GjUmR+qZ2PNftxEWwH0CC+Si1kD8P2DOXFfzpEGyCGa5ftfmuoNNyEwF73WE2DEcU5OSRtmARjuNvuMc+2H1UlcZxedM+ZuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAP+GsqscufNNJwCxdInfG4tf7WaSQxM9OtD1xMnV2o=;
 b=OpigFTelvsT919pVG3bCVN2bmwaxlh2LlGXQlVlbvGD2m4azFrQL+S7x27SLL7RgvVY68/W6mW6T/9kVKCyukX4+6ODCJnd1/P7KYkBHg/ii6DY3+74U/xp3QpubX+oiIYF8gTLH9OVXHZivKDEBRxygtk29koJg2XKIl0J7wzBY7qYD3m9TA2qojbt7njX9wR7nIDo5J/895D+EN5+pRVISYFKEl1zJj1rwu6olOGcWpthP5K0MOoVg5J9tgCQNrKROzjEZu7ZCICi9qh6ZQrWIE8/bUcaJtgxhc/9bWj6nAoe7qRspO6lrV4KxN0ZssOuaAzw8Uk8WpPhhiZXrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAP+GsqscufNNJwCxdInfG4tf7WaSQxM9OtD1xMnV2o=;
 b=WuQdAz1RPNZNIykfpzfnxnj704yUZ6OTmBhWlqy5aTFknSIpKRpO3UgkY/C7iXdddm4YJjZ3Z8Ns3O0mj5b3GnAUx9makrXQIHSbhSqVy7KNkPM0QYV23H88MGTA6QupqKdTFGh4xPAYpzTOWO0tT5A8ueH/KMQeMJEv0ozks4YD7/xImRfZQrc9An8YBFhHVj5DfTAf+Z4pOYBzyceoFq0k7LOzsgHwqy990BuzXgtIWY1QpCvQSVYhVYWY6rpJP5rWyqZuixd7h83s+UDgk4OBs4dL3LAc7s8f6B2GeNNAqLWCzrON/NX6xEBim12GgrDJ9L3YZLPb4jvjSTg9Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 07:41:23 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::2cd1:e5df:c85c:7e2]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::2cd1:e5df:c85c:7e2%6]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 07:41:23 +0000
Message-ID: <36b3b725-81bc-6d6e-7538-0963b940d81a@suse.com>
Date: Fri, 18 Nov 2022 08:39:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To: "Bird, Tim" <Tim.Bird@sony.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
References: <416608e6-10ac-c943-1fc8-a3944286f193@suse.com>
 <BYAPR13MB25032674327E22B588074DE0FD069@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB25032674327E22B588074DE0FD069@BYAPR13MB2503.namprd13.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::7) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5213cb-3992-4bf9-a657-08dac9384a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ixg9z+N3ORiy0tKdoFypOw7DJMkHA4LZWR1DLvetmJWgC7hpxYwzdFQ6DXfAhXRjwLqHFrLQDE80VNeRwf2pGaKXkLWC3ZOuBG7n9nLVlAEDFEZWyqYHBCchvFzwGMWyBPPC3BPy9yLJjsOf+bDl3SrhcAnanSiDZJmZUH961xIK2GJgFDXtAmYhkzERBZOqnc2Cww7pec944pD3H5kObgxh+15pUocGrlTzu/o/cTFHtftfDE0sVK6AYtILJrrJrJ9fY3uAVUmoIKKMfr/K+JYXr98/iXsqkqJJAungRQeB9fZjRygJucJzhKrQFBpXjzXwoEnT2KbI8FBrC9Grvwb10ZXrEmatzz0u3irquOm/vPEU54gcFUgcoV+/KIsTKtgel28/YOylQEjGP92WDeiG3q8rtfZsaSlsKtCEpGL5lLiUAncZFw474ni4tP1CeDcV/4Rq+txDIvPerCA3ADQ53qU2a9pcvev7Yt2Ss+lRBU85xP7+neKaqqK29BBiK/VhO4ZqmtVLu1B0iLbfLCfmS0PCxje3I6fFalA3nqlvToVZB4nsbo3Nya4lUswFwQb/sZQyEfavxgjeasbCGEZWi8DRUM/NOhUXCh5XBwdTnSYGNMg60WGNOJOxqgUhU88PIH2Y0oqwJOwo4ri80b6ekZ9kV3sA7vSYEVpuzSrN11l0fPr4RTps8M170BYK5HYB592JJBZNY6AilUuwdV93ZgELJuQh2tbfMcrYxa1qtpCJCKnJF4OhUGpEyRRjbpghs9fdLc5x8+RAkbCVyVUyvn2iMNvKdKVXtgxHf6g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(6666004)(966005)(478600001)(6486002)(31686004)(6506007)(53546011)(8676002)(110136005)(5660300002)(316002)(8936002)(186003)(6512007)(26005)(66556008)(66946007)(41300700001)(66476007)(36756003)(2616005)(86362001)(2906002)(38100700002)(44832011)(31696002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFc4dUZMOCtqOS9POVFnUG03aUM0QjRpV0J4U05YUmk4UjlLUXlmVEg2VGFo?=
 =?utf-8?B?WHNvVkpYZWVpTUNvSG8zS0pWQzFCRFdKRG00cWpkV0k0aDNFTS82R3JNNmVJ?=
 =?utf-8?B?UWlBVVJWNzBJU1dwQzk0b2pVR2NGQnJrcUlxK2NDRTRFeFNRYm1VdWVPZ0J6?=
 =?utf-8?B?NnV4L3g4cHZ6bFVYRnB4a3o0TGFQYXJZOU41aWxZQm9GZXY0enF1ek9OT2tC?=
 =?utf-8?B?WThNS2dKTnF0WktkZXJrYkFlNThPTkhtQWFNaWMzNTF5aTMxVE5jcHlNOG9D?=
 =?utf-8?B?Wk4zWlhZYVhOQmJZb2ptcVM1SDIvdjJ2bE1SOHVSOTRvcXNFeUxXMXZ6M3Y3?=
 =?utf-8?B?VXlIRHRVR3RHTlhxMDBJYVJreFJpRGhkNnc4LzVXVUVvcHFHQmU3R1ZwZjVI?=
 =?utf-8?B?UjZaWHV2b0tEQm1LbFpXM1RyVW9pczdVU2JkUU5NQldldzRZMmlLK0JCZnNW?=
 =?utf-8?B?SUZKUjYzTHZ3L3YrdCtnUmRyZTlYQlQ4dVg2WFdmVVhEU0k4TnVUK1dBZ1VK?=
 =?utf-8?B?dlVHK2VnTVkrTlI3bWlrL2RKdmZLYXFxaUdkR0JlWlZ5a3UrcUxsek5BU2xG?=
 =?utf-8?B?V1lGa0VBNTBzQmk1VFBvWWxvRzJOeHEvRDBYTjdsMmlJODNPT2NXMU9ZMHBz?=
 =?utf-8?B?VWJzWE5VUmtKQ1NrZWl2QTZ4TmpRYzdnVUFXVUpLRGViNkpLWVZObEFka2Vq?=
 =?utf-8?B?anBtblVERFQyUnBFQy9hL2pZdGNPS3FmVTRmYWpuQ3psZjNOcUN4Wk9hb2R0?=
 =?utf-8?B?WG1xeFdvM0JHazl4YkFYejJVUnBKRy85M0VMRVBWNVJjRThlZ1lOQU8rT1dz?=
 =?utf-8?B?VWs1Ti9oS2kra2FlYlNqVWFUaFRSSzd4ay9NQzQ1OE5iblBhaFRpS1RYRmxC?=
 =?utf-8?B?OWI4NGZqYkc0bWJKSjc5US9sbU1YRnVERU1sMURvMlo0cGZqRGlOd1YwTDEy?=
 =?utf-8?B?SDZVdE1PSzh3M2VFZmN0TVZ1MndIUnJBSDladm1YSzVZd3YvUVExZDJuMk52?=
 =?utf-8?B?RHFBWkNSOE9JMmpzWXJhTWZ0QzUyYjkwZWlpU1Eyb3dkcWF3bW5IUmNpY2xm?=
 =?utf-8?B?Z1VXV1JtN1N0dFF1MnhXVzlWSDJBSUZXM2V3bGZUUUpTN04vY3RSZElMb3cy?=
 =?utf-8?B?V2dEQnZVMnVWTnorUHdhT3g2T0ZkQTlnb3UzRWdUWm43Q2lsOC9zazVqcUN4?=
 =?utf-8?B?SE5JZjVFTGpub2JTdlFWSG1DQnRCTTNqTTBDMlR1b2QyNW45Z2FLbThDWG1m?=
 =?utf-8?B?L1NiNW9ubW4yVUdqa0dmYyt3a2o5NzlQbVJiQ0ZUYThmLzBVcldVL2NHME1H?=
 =?utf-8?B?VEcySjlENFUrcGo1NHFwV1MrdmI4dFczQVFjaTczRkk5NWFXMFk1cTR0MWIz?=
 =?utf-8?B?S2s1K0FhZUphbE1zYXpiQ3U0cVJFd0RjR2tHNFpaVVRFc2VFamlGamxYMHdu?=
 =?utf-8?B?Wm1wanppYnlDTE1hcFJuT24rWlNUV2F6QVA4VTdHYXBzckhTckFNY3VlV3py?=
 =?utf-8?B?dWl0RUlYMzBmMGVOL3BVOTYwTDlCRzNUa25xMTV0YkpmTGJJMmgvM1dyYTV4?=
 =?utf-8?B?ZVhIT3VHVC9ENUEyalJZWGF0R3RUVE9xdThCOHdJYkdNVHdqeVgvYWRKZklh?=
 =?utf-8?B?ejBrS2pvaGZmOGt3Wk5xMk1zYWxCVjJwUUhSSjVQRGhLNzIzUEhKaWFDcXZa?=
 =?utf-8?B?bEZ2RzhtMkh0a3NFbStHb1p0NU5ZRVpNcnY2ZUdyeW1vSFJSeERnVjlISGJK?=
 =?utf-8?B?c3IyMEtwSjFFRjA0azVPZTg5K0hUNDdiTVJON0x4WWV2ek9aamVQUEpMaisx?=
 =?utf-8?B?Zm9DcDdBRTlmUEYzemYyQXZwR3FtTmd1WXV2STNSVjJnUHpCaDRjRFlzT0E3?=
 =?utf-8?B?NFQvdHlvSFN5YUVNbXFKbllBcTFtbHA2SFk0VUVhQ3ozbkVvWmpZeTRnRjgv?=
 =?utf-8?B?bWNDM2hnYnZVd2JlejA2WUpqby9XWHc2RnpOTTdTRWdNaytXc3FSNUFJdTlO?=
 =?utf-8?B?R2JXWUhxaS9KM2xwcTd6aTVpRFl0eUh0Mm1kYTM1ek5FdUVZYmdBc3laRTJu?=
 =?utf-8?B?YytleWMvc0FROTRGVlkybjFTdGZvejFWdGFxWXE1bGF1ZVNWZWo2Wm1nMktq?=
 =?utf-8?B?RE5TcnN6U2xsMnIxYXVad2FUaS8yZE5OUFltSGtTMnNiQlR3YVpKaDNtRWFR?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5213cb-3992-4bf9-a657-08dac9384a15
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 07:41:22.8692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DV8u7wN8PDySdnfuxbcv3WzIxDBAPZjaaeZIax+dTc4UX4yZpGXoEWGHOQ13ye8afXZv+li2G7q04oDwgUeBcnJGxE/aH0rGZL46HqjFK5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC] Include runltp-ng (runltp
 successor) into LTP git
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

SGkgVGltIQoKT24gMTEvMTcvMjIgMjA6MjYsIEJpcmQsIFRpbSB3cm90ZToKPiBKdXN0IG9uZSBx
dWljayBiaXQgb2YgZmVlZGJhY2suLi4KPgo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+
PiBGcm9tOiBhdXRvbWF0ZWQtdGVzdGluZ0BsaXN0cy55b2N0b3Byb2plY3Qub3JnIDxhdXRvbWF0
ZWQtdGVzdGluZ0BsaXN0cy55b2N0b3Byb2plY3Qub3JnPiBPbiBCZWhhbGYgT2YgQW5kcmVhIENl
cnZlc2F0byB2aWEKPj4gbGlzdHMueW9jdG9wcm9qZWN0Lm9yZwo+Pgo+PiBIaSwKPj4KPj4gYXMg
eW91IG1heSBrbm93LCBydW5sdHAgaGFzIGJlZW4gdW5kZXIgYnVnIGZpeGluZyBmb3IgeWVhcnMg
d2l0aG91dAo+PiBwcm92aWRpbmcgYW55IG5ldyBmZWF0dXJlLiBGb3IgdGhpcyByZWFzb24gdGhl
IFBlcmwgcnVubHRwLW5nCj4+IChodHRwczovL2dpdGh1Yi5jb20vbWV0YW4tdWN3L3J1bmx0cC1u
Zykgd2FzIGRldmVsb3BlZCwgcHJvdmlkaW5nIGFuCj4+IGFsdGVybmF0aXZlIHNvbHV0aW9uIHRo
YXQgd2Fzbid0IGNvbXBsZXRlbHkgYWNjZXB0ZWQgYnkgTFRQIGNvbW11bml0eQo+PiBkdWUgdG8g
dGhlIGNob2ljZSBvZiB1c2luZyBQZXJsIGFzIHRoZSBtYWluIGxhbmd1YWdlLgo+Pgo+PiBGb3Ig
dGhpcyByZWFzb24sIGEgbmV3IFB5dGhvbiBydW5sdHAtbmcgaGFzIGJlZW4gZGV2ZWxvcGVkIGR1
cmluZyB0aGlzCj4+IHllYXIsIHdpdGggdGhlIHRhcmdldCB0byByZXBsYWNlIFBlcmwgdmVyc2lv
biBhbmQgdGhlIGN1cnJlbnQgcnVubHRwIGluCj4+IHRoZSBuZXh0IGZ1dHVyZS4gSXRzIGNvZGUg
Y2FuIGJlIGZvdW5kIGhlcmU6Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9hY2Vydi9ydW5sdHAtbmcK
PiBJIHRoaW5rIHRoaXMgc291bmRzIGxpa2UgYSBncmVhdCBwcm9qZWN0LCBhbmQgSSBsb29rIGZv
cndhcmQgdG8gdHJ5aW5nIGl0IG91dC4KPgo+PiBydW5sdHAtbmcgUHl0aG9uIHZlcnNpb24gcHJv
dmlkZXMgdGhlIGZvbGxvd2luZyBmZWF0dXJlczoKPj4gICDCoMKgwqAgLSBjbGFzcyBiYXNlZCBh
cmNoaXRlY3R1cmUgaW4gUHl0aG9uIDMuNisKPiBXaHkgcHl0aG9uIDMuNis/ICBGdWVnbyB1c2Vz
IGEgZG9ja2VyIGNvbnRhaW5lciB3aXRoIGFuIG9sZGVyCj4gdmVyc2lvbiBvZiBEZWJpYW4sIHRo
YXQgZGVmYXVsdHMgdG8gUHl0aG9uIHZlcnNpb24gMy41LjMuClNob3J0IGFuc3dlcjogdGhlIDMu
NSB2ZXJzaW9uIHJlYWNoZWQgZW5kLW9mLWxpZmUgdGhlIDV0aCBvZiBTZXB0ZW1iZXIgCjIwMjAg
KGh0dHBzOi8vd3d3LnB5dGhvbi5vcmcvZG93bmxvYWRzL3JlbGVhc2UvcHl0aG9uLTM1MTAvKS4g
U2luY2UgCnJ1bmx0cC1uZyBpcyBhIG5ldyB0b29sLCBJIHRob3VnaHQgdGhhdCBpdCB3YXMgYSBn
b29kIGlkZWEgdG8gc3RhcnQgd2l0aCAKbWFpbnRhaW5lZCBweXRob24gdmVyc2lvbnMuIEJ1dCB3
ZSBjYW4gZGlzY3VzcyBhYm91dCBpdCBvZiBjb3Vyc2UuCj4gSXMgdGhlcmUgc29tZXRoaW5nIHNw
ZWNpZmljYWxseSBpbiBQeXRob24gMy42IHRoYXQgaXMgcmVxdWlyZWQgZm9yIHJ1bmx0cC1uZz8K
PiBDb3VsZCBpdCBiZSBhdm9pZGVkIHNvIHRoYXQgcnVubHRwLW5nIGNvdWxkIGJlIGJhY2t3YXJk
IGNvbXBhdGlibGUgd2l0aAo+IG9sZGVyIGludGVycHJldGVycz8KPgo+IChTb3JyeSwgYnV0IHRo
aXMgaXMgb25lIG9mIG15IHBldCBwZWV2ZXMgYWJvdXQgdGhlIHdob2xlIFB5dGhvbiBlY29zeXN0
ZW0gLSB0aGUgbGFjayBvZgo+IGJhY2t3YXJkIGNvbXBhdGliaWxpdHksIGFuZCB0aGUgY29uc3Rh
bnQgbmVlZCB0byBiZSBjcmVhdGluZyB2aXJ0dWFsIGVudmlyb25tZW50cwo+IGZvciBiYXNpYyB0
b29scyBhbmQgYXBwcy4pCj4gICAtLSBUaW0KPgpBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
