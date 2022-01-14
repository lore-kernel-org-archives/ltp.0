Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8350EC433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 21:29:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B6EE3C9551
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 22:29:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 670E53C13E0
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 22:29:18 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2130.outbound.protection.outlook.com [40.107.22.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 02AEC1400984
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 22:29:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9ZcUntklsaeCjfgYtA2dqwhemWXEi+YOqKgvR0bSwEwVpXz6kmZ/KAAkhIziGMCLTDkyZFyFO01VPd7lPyQM4Gef3hBKkfjkJKvox7vLNFPU7np/KejntFmrbs2FH59NYv9mwl/fzOzpj72zDvPG5uKrce8Zd/LIU91japy7t3zjjsOuDS6JcQF3xPPei2OuP3fJ5YTBI+njcnJpGhuv8kR0OMhiXDhkneVMfqlJCmfQqMOtehgCtJRksG01M5WrWSLv1J2Zy/f97a7pNZOHpqOx5yIzYG7VLflq9DOXi2kg4tYDGxnxweU2PwMUtntridgLyWNY6BB10EYCdTMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLFe/TqZ7wYWZhK5Xn2pjTCW3ijwnU+b0PWeX8kA9zA=;
 b=kHnG0tyHBbNBl85+wBH6PJRWMitXqnAseNFuNtMc6Rd8uTQKQhhuS52Aak/AB1qAxCJ2SMG81GH/xVYm57b3OjwKnc8NVIMsrRDe7TVskI9/XiUUvMvEvalj+I6MKJ4se73rXqHqGfLeqcRbQ++jgNqp08VX8gs9hr8L+yTbvvq4qqDTLaAZ+RUxbw3kQuITiWdWR5p7QUVodnmofe8pgPMoFk+kYPDHfDj7K7J6Evjxqx1MFsOkKaYnxRZxRFGPKck1soYg4UO/6r95fjoy4TTd8tGNi16PnvXZyYM0thJhpPF/OpkZPXuEBRD2fmR8k4PXwztZfmHMDn8BtdM0pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLFe/TqZ7wYWZhK5Xn2pjTCW3ijwnU+b0PWeX8kA9zA=;
 b=cw84TF/GndFTahVeRuXhMJ29jSWJbM8NhjPcgGKPpPgJmitMc96zwY98Eu/A9J/5cM/7jcLuJIYcJsOHFOxaRg8yyrnWQVdq2aqSvWLpWlTuU+Tw5+ceaySo+xw6pQHI6E20yKQzdk0QopuhtxipKO+vLe3yR/HU5cRzhAFq6iw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by DB7PR08MB3212.eurprd08.prod.outlook.com (2603:10a6:5:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 14 Jan
 2022 21:29:16 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::3c60:bb4b:b0eb:669d%3]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 21:29:16 +0000
Message-ID: <bac72bb9-07d4-a529-ae87-54e77d74ea47@virtuozzo.com>
Date: Sat, 15 Jan 2022 00:29:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
 <20220112161942.4065665-2-nikita.yushchenko@virtuozzo.com>
 <YeBKRoYuuZFVBmHf@pevik> <590378ee-71af-deb6-6c03-1d2af459ed63@virtuozzo.com>
 <YeHbzANFrkQguAXh@pevik>
In-Reply-To: <YeHbzANFrkQguAXh@pevik>
X-ClientProxiedBy: AS9PR06CA0296.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::16) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b96f2e1b-fbb1-4ff3-1e92-08d9d7a4ea8f
X-MS-TrafficTypeDiagnostic: DB7PR08MB3212:EE_
X-Microsoft-Antispam-PRVS: <DB7PR08MB3212F4570EB171C91FBFF97AF4549@DB7PR08MB3212.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jtXGj7wi1NkhXeqBjZgRQJYgGI9r8OfkyUVG7r3UPXHhZLmstpZLRlXcZKHXYPNVRkcb2kjmkQSwv1qkTo6A9qYD0XHHFvLw/nbLane6KkHXYFFrBE+rsjWrVg/MX/0fwyaeTHmzQx779VpyvfINCmg1vZXB1QL9xpoKAYxX5xduKE/moOjnKg9Y5PwYw2X3u04EM2KuEuBdReZwWpMycMbXKN3qyeF0goM2/ET3ugpcnNKUHXZ/d3RXinOe8Dg+pqtf002/8ZIDp9/xpNUhpxku+yX8WGC3nYWMgv//Xjr/9JAftqmIyCqYjBpT//fiD3q81JuLlpS1x4sYy1OdLMrgSpm/5H20ucGItQPmynEJg27EDAE5MXMMfzCYjd4qeZkZRJLgxaIZ/T2RaVZwzk/uVi4uyBDl4CFZBO5rNPDfJDW09Npq0r3geAQA/Gw7xskwbEUQtuH+dHk1/3DNjOyEQNfmeGJK+x+p/BjhGQgkcB+uv43pZ+8S/9LDFedzNBHz2m6VBkbBIWx8qRE66aA3nlwuoEZCvBxKhcebMDc8f+eAO0Iu8yr25IIzptWAnOZa05T/OlXBLY98ayq3KTz2dx4l8Hztx0VXERFH0wHKQqHF8y03oKaHTYvb4WAdwhTJ7j5cOiBtR7XF+lURx8vJry7KZHfJpt/6cN+C0SZDM+C9yIYzNPdth11b9Yy6Xk664TNEueBIbcUQgE+B0Wz5cXzf/+Xppu/TmlnJZmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR08MB5630.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(66946007)(2906002)(31686004)(4326008)(186003)(26005)(4744005)(6666004)(66476007)(6916009)(44832011)(2616005)(86362001)(6486002)(66556008)(6506007)(36756003)(83380400001)(38100700002)(5660300002)(6512007)(316002)(31696002)(508600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dUM3RPSGY1QVhPalFKKytSTkN1VDVmT0tvay9KbGttMVFsOXFFWkFWYWZs?=
 =?utf-8?B?TjVldVE0b1FtWUppNmxmTThlWmFFc2hqcVMzblNSd1E3clBNK3NUbkhzcmNm?=
 =?utf-8?B?L0tBWmNDeW5DbHBRUEkrODhQSzBJcFd3c0NRTThHa3l0T1J3aDgwK1N2SHd3?=
 =?utf-8?B?My92Y3BHdlFDYVdmMEhoLzZSb1pINGxIbFFkQkZhUDg2NXQzSWhtM2NqemM0?=
 =?utf-8?B?OGZoNEI3elV2ajJIZmt4WDRIcGhGZGxmMmJySzBtSjFZR0dZY1YyNmZ0UFd2?=
 =?utf-8?B?a0I2SnVlY2R0aFl4ZEVSNGZyYXJYOWw3d2MyanR2RXRPNTU0SW56UTRFK0c0?=
 =?utf-8?B?cjNDaldZRFp5SE9RUmowSUh4ZFpCU01rUWdNc3djcDQyYnZIZjVtclpHSXVS?=
 =?utf-8?B?dEdlVWw4dk9aaWtHS1ZjV0ZLbld0OHkwT0laYkRDVmsvUE1kV3NnMHlFdHVJ?=
 =?utf-8?B?WlBSTkJVWGhlZUdxQUl2VGdjRGwweThjRDRTNFhrSDVLRG5jT3h0QTNmUnBz?=
 =?utf-8?B?OTE4eERKc0lUVzJENDNTRkZMWmcyWERSWHpSVEJyUUpMRDBkV2NBVEFYZEhB?=
 =?utf-8?B?dXNGdyttTXllZkhIT1l0T3lKV0pSNFRueFI4WTNlcUFpQkxjdEVHbWQyMEtk?=
 =?utf-8?B?T1BNSy9Xc0I4WWZyOFVUYVljVVZwWnBWclZrWGJpR2FWZERLOEs1Lzg5S3hQ?=
 =?utf-8?B?VlY4Z0s1LzBjS01SV0tOYVJLcVhTZFE0YlVabjRKVGR4djh6Ry9ZamNPekp5?=
 =?utf-8?B?SEFGSlRSa3YxMjVueFN1T1NVYnpUVWNVQTZqWUpPYitSOXpVemVlMlNhakU3?=
 =?utf-8?B?UEdDMmdLVGZ4djg5d0Z6cHFla2VXc3VLY1N5NkZ1eTU3dnlxaUJpc3BZNTFh?=
 =?utf-8?B?VGd1ZHJDWjVoNzRPSStwbXYxVjVjcVk5RjRLeGc5R3VleFdRbUtVVWI4R0xF?=
 =?utf-8?B?UkpMOVdmZk8yYWZKRmIrS2c2T0V0YytiTEViWkhMZUVtYm1WNUlqNW9YZXNz?=
 =?utf-8?B?dTlDV2h6bmVkMURlR08xcW1oYzhJYlRYK0U5WGZVMDYyZDlvdmdaVlo5OVZh?=
 =?utf-8?B?NVhXQUQxc1VMRnNyUWJ0b2YzTHF0czk1c2kydGZLYVNDQkIwWGtuRmhrNllv?=
 =?utf-8?B?TEYyZUpSdGdWMCtoZXlsS2tqZWNPamVJWDdmU0U2TlZLRXYxdGlHQUUzeHdR?=
 =?utf-8?B?WGN1dnlYb0dJbUhHR2dpUHd6ZHdWaW9NM2ZrMWdkSHg4dTZoRTdLT2NZbXJu?=
 =?utf-8?B?SDhOa0h2eWgyS0V5RTZDUEloS1lGLzM1RlQrTTVGdXMzeUswdHhoVTIxbzBs?=
 =?utf-8?B?Mjh5SFRZSTZUUHlCTGdhT3FwaE1yWlNaVXhoby9IdlMzdTA3Qi92MHJiNjV2?=
 =?utf-8?B?VTRzRGtQVUpPMy9xN1NyM21ORGd3dzhqR3F6QW00UCtRbGl1TDVFcnIzRVZQ?=
 =?utf-8?B?ZmJXa0FxaHJHK0Z2VDlSalVpS1NtcktqditIbEVET3BueTd5SXVDaG93b256?=
 =?utf-8?B?WGkvK2ZmU2I5TVdPVVdmWVpiSzkzR05zRnlEc0pyQzJRWU1OdlRFSkN6cHRw?=
 =?utf-8?B?bmhhMlk5Z01uT0FWbVR6Y0Z6ZUZYY1d2eVNTWHZjWlNPcDhQckhNYXFvNFZ5?=
 =?utf-8?B?S0lvdktQUkxqMzB5eVZFM2RUTVcrbE9saTBHUGxJa3pCUnpJLzhoMVVzd1U2?=
 =?utf-8?B?Qkl4b1AyRmFmMDZkK1RxSlJSQ0IxRm5TdTVMZFluczRqVkJxSVhQcklzbWlI?=
 =?utf-8?B?dCswSGVOSVF1c3VKdlJVenQwcTlHSlVwM3FaOWVHc09TUmh4SFhUNWl3dHRJ?=
 =?utf-8?B?alNPN3hpMUgvMmVKdk1PWDFDeS9FVDVhNVJDeVlqWHcwM09BS0YxVzNwNWY4?=
 =?utf-8?B?eFBiUjdpMTFxM1U5S2g0MHU5eTFtOXQ0cjJrSWdTbjUvMURDSEtPc00vZWhi?=
 =?utf-8?B?b1llZHdZcURjRmJOTmprYTJlZ2tYd1NYU2Rnb2toc1llNk9lZXJoYmVhbGlU?=
 =?utf-8?B?NHJSdFc3ZEdJRVcrdXlDekdBL3NVWXAxMiswNThOZTY5WEFCN1gvWEVFWTdr?=
 =?utf-8?B?ME5qcFdDYTh0aDJmd0Z5UkdGSWZCUUNZTkhsT1lTcGhOTkwwTlZxRkVQZWF2?=
 =?utf-8?B?cndWZFlnRk5tWlk2d1orQTM3aE9VZTU0WUtBWWcwcmM4aWVhUWRkRDM4dHFv?=
 =?utf-8?B?WUl5c2hiSHZhcDlOQ04yRGJQc0x1dWlndEVRSnFjYThxanRpdkNwMFlKT1Js?=
 =?utf-8?B?UHFCbDMrREdRb0dON3BFeDdjcEVnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f2e1b-fbb1-4ff3-1e92-08d9d7a4ea8f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 21:29:16.2449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vugtVklRnxmpocNRRCQ/kWaiB/Ov6ZYJy/iz11By1gdoPnKTZd4I/RMcICECEHn/OFsz+ByMYpKg5vQN0DnyzM0kOxsBHIrJnDRv7Ns+DpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3212
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_lib.sh: run exportfs at "server side" in
 LTP_NETNS case
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
From: Nikita Yushchenko via ltp <ltp@lists.linux.it>
Reply-To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> +1. FYI I get errno ENOLCK for NFSv3 on both unpatched and patched nfs_lib.sh.

Same here.

AFAIU, to make it work, need to unshare filesystem containing rpcbind's AF_UNIX socket from ltpns. Then, 
ltpns instance of kernel lockd server will no longer overwrite ports set by host's instance, and kernel 
lockd client for ltpns will be able to contact host's lockd server.

Nikita

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
