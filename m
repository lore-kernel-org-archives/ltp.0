Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5EECA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:47:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 482A33CE041
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:47:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2503CB2BC
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:47:23 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3F0AE6008ED
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:47:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+fheE9PUqjCHhUsrwIpn0yCZQfHe4JsYqAVdOuRJ29b3RpSJptBqcLUdss4eZMt/DrzRskAvdNgF7haMC8B+yg9GOlzHWEVVudal966He51cNEy4cd95fGh5ymiqSvVjSjq9gyJCsMNHPtb4G8BouXZEsK0hBlukGEW0jQY4VL/UCn4B3Hjs7nwzjtOpBE4YZtmmoMqxyvLWpKuqiHwL6wlEAuEhEINZUkhNc7stEOxvMT6Lg2dbjh+xX5tESSq7FCSh6SV28HH7CyqV6piGA5rcjiZrU3hZYBNDLj84Z3DsgmeaOYH//EgBE1/C2MM+ZqCGJEyHL/bZPkHCpKjIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/9/1IQB80TCTabw4yEAXAC+3haDksvITxHsGbYptgQ=;
 b=NU6g3NmnWW8YuiSUAJNhsh2YcNxuA/st4c4E6DOGp5CCJbQkCzpwzHSskZRzfNWn7xs1MPcnJVlBCm2IfffHHnYQtbe5VID1UQs1Wfwh9bX00hInatugmFjQu3wv3kGQY149FqWAM31CX9qNBllydAltPAiNV/2G8s2Tme1KvSOpsEXBBw5jJvtSUw/V+0RfRt6dR8RF/tn6W2IyBDGZoqXDjW5mk44bmWsGYvujQ0eVVBD2quav5aO5QgrTR6HugT+f+FYSXZOYghT0eA8D3x9tfxfadrtX7Mgp3k3Q9xfp7lUh1SaZBpA3j9CdpwtOkgG/vQ69kzeD0LbXLMeb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/9/1IQB80TCTabw4yEAXAC+3haDksvITxHsGbYptgQ=;
 b=ljYIH60JkWcOYUJ6OwFCBKNC6q1uA2V68RnsQ6rdAljHURTl8n7Zl2fQPCezfwm5dNTbMSTF+86sKlms3ngsT19B5D/TBwzMmlFfjXSA2x8xqJNMuDfedSo+TnezLirGmGlLARb7udvcG+KkEk0YgC6hQzXO7wrgQ5KQnKAut4HZB1Lv8jP084RuZafFFidgktrPfCoXWnwvmNfc8KTfg67cnf2O7YfeA1+vfwpKoscTRX40B2KfcfV0195FibT3dHaxvfzfMhOaG7AhXapdJeZv7XyIpDvGq1xXZjXZS63b6r9EaNq/wPZnGu3l3UG9AIN2GdOgHUyDrQs1H3lwsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB8720.eurprd04.prod.outlook.com (2603:10a6:102:21f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 12:47:20 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c33:be0b:88be:b96e%4]) with mapi id 15.20.6678.031; Fri, 1 Sep 2023
 12:47:20 +0000
Message-ID: <9f27bcdd-c4b2-4d01-abcc-2530c442f279@suse.com>
Date: Fri, 1 Sep 2023 14:47:16 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20230831104242.27156-1-andrea.cervesato@suse.de>
 <20230831104242.27156-2-andrea.cervesato@suse.de> <ZPCWWXXHG-oEB5qO@yuki>
 <80324acd-253b-4216-8a92-04e31905c648@suse.com> <ZPHXjXFIvbPIPwIH@yuki>
In-Reply-To: <ZPHXjXFIvbPIPwIH@yuki>
X-ClientProxiedBy: FR2P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::20) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|PAXPR04MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: e6201601-598c-4ec5-e5e4-08dbaae994e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RsX7yzsvgr2jMI6FS4UuaInVn70GMOLXLwthVY0KBrYRPmCtW+4ljbGUUkaU1Zm2i3G2z+yFsq2Gzf0X9YlECBU1B7KD+wdQvtPBlfWtQ6/gWKc845e3iwHubkxxJ377UsoJewAktXhaiJ9eUa6wiT/JQcQHRMy6MaNKd1i4R2RfMYNe5dFOnm+8gET+3D7NLgQWvnn4XP51psYY0WqjdsplfkFNcBIYYxRVWxz1PzpSiUN1z2YArNOir82XxtUGQ7i7uBuc2GpeVVqZKaTftKJwgl/pFZtJ0t5Ql0FQ7wepWpCtzi1GfkzlUF2aLqR9c+P86CWIs0RfyHzRLSW45YflhUxkk41cK84/Ao+IW5aywlHLUVAQ//V51Okm5A9LyL/CNLOznJKnmxxbGSQjTdNjfRYa7tHz1MHTVcRT/oZgs3Dr9fGKWh4woqTn/X4yGz7QndiOMUbi1QHRwwlBYVMzj+0dkJvgMnucDAn/6SsUWZt5pSogRsVffteoV/C7KOcR5xzj7ORopghg66s4nmzmTZUBqLGAfcMGeszr6ZuYOcRUI2LVMsKqqAY6G5hkUY9rHobn7pFm9Z351mXIbr6ny0cMs0RTqT11GEhjrffm9OrSSGEb3udDZKldJQmkrMzEihh1dMl92ZiguPmhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(1800799009)(186009)(451199024)(66946007)(31686004)(6666004)(6512007)(6506007)(6486002)(36756003)(86362001)(38100700002)(31696002)(2616005)(2906002)(4744005)(26005)(53546011)(83380400001)(478600001)(8936002)(8676002)(4326008)(66476007)(44832011)(5660300002)(66556008)(6916009)(41300700001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjBNVTdEZVZya0RHNXdqckR1K1A3QkNMaElUdjhiVjlVVUZrc29UK1BaVUd6?=
 =?utf-8?B?eWpnc3VaTkRlMGV3SWxMamJjVkw2OUJMN25NVVN3N2hRcEt5TzZmQmFwd0dq?=
 =?utf-8?B?RGtLbUZKZjhCOG1CUTNJOGg5dmZXQW1nWHVyamNoWFBxVzN6SW1ZWTBub1pY?=
 =?utf-8?B?bUwrUWY1dFJ4bGNXdFFQZEtPZ2lybXdiNDFXaEhLTVVBc29Wb1R5cjUyRWh5?=
 =?utf-8?B?cnZ0NFB1YUtqYjVTTzdwSC8vNlhrVHdpRnFzMm0zbHdOWVpHSlVIWjdEeGJN?=
 =?utf-8?B?aGlma0VjaWc1VTlqNVZjbGlxV3RIZC9DLzdEU0U1M210K1Vpb3MrN04ybjVJ?=
 =?utf-8?B?cU5ldWhaa2pxSU1qM3lrSFRWTWhyL1JkZ0Z6MUEzTW4wL2g3aEpHNW9ubndZ?=
 =?utf-8?B?Nm9wWWQydjRWVTY5YjU1NDFsNmFQVjdOeE9OWjNFZU1nUUJJOW9jNTRGRXUw?=
 =?utf-8?B?UUpGYkdnZ1VuQkVvdWExZ1VnZThxcTNnN3lkeDhNNjc3cDlhaWZLSVpkVUlu?=
 =?utf-8?B?RFh4aG1yMFhPRGNlaWpoNXRxK0ZFaHlIMDNRRlZjaHFvVDhyazdUYlh1TjU5?=
 =?utf-8?B?cE1tcDRhVzN6ZlVDRXJFcU9lb2hRNXpYWUZmeVdvYThMWXNhK0JFYWV6NHpG?=
 =?utf-8?B?bTdVdHVMdis3Y013bnlZWUtQK29hQXZmR092V2gxQnNNMCtJN0gyTVJJRVlN?=
 =?utf-8?B?Qkl1ZFFpdjY2aTZLd1ZPZVVRYTVaOVVkUVNQZ245OERXdGRmKzJuakMrdFBT?=
 =?utf-8?B?bEF3WXloK0FsekhKbWJpSGFTY3c2bG5VYWxzMmpTcmJWWXJWV0ovR1RtTXBO?=
 =?utf-8?B?ZktiYUlIcXJtZzhNWVlHbW9FQUwzMk1zZnNaVW9zV0phYVErZmxxa0VjVDhq?=
 =?utf-8?B?VkpDeW05NVJwakJjZHo5NHJ0SCtLWERLRFBEVUdjNHFoRUV1ckNUcGZzRnFj?=
 =?utf-8?B?aDhmZCtVVTIvYmdvb1NhMjFXTGZyRTgwZ0VaU1V5dEVOQTNUZEhuY2F2Q3Jj?=
 =?utf-8?B?U2xwWDZ6THA5RWU0T2pLbXo5aUpWb2Rockw4NGFsWGVsSEZMazl5Wk1od2NF?=
 =?utf-8?B?Z2h0WTZWdCt5MTNCeXUyVnEvRUpNZmdSZDVTVXpGQ2dYQUlmb3Q5akRGVVNk?=
 =?utf-8?B?YTJab3BYeGJqLzMzaXBkeG10STN6cjNXaEFpbVpWRURBVFZSSk40WHUzRG00?=
 =?utf-8?B?SFZUdnE5OTRmdXJFTDE0OHUwbVhJTkw0UEN6OXRCdmdLUk9UMGRwRjdGejZG?=
 =?utf-8?B?QU1CWXhxR0hKeXpZODJkUmpOT05IQTljc1QrQUdkNWRKNnZBZXJacjVtd1Bi?=
 =?utf-8?B?S3BieDFzdjlhYnAyVWRRSUlSVzZLWHpqMGZ4UFc0M094clBGZzYvSmJUdERG?=
 =?utf-8?B?UTVKSTFHcTZIblA1WXpxUEVReVl2dFVFZ2NERTh1Z3JoaVdvc0xLZytNVGQ1?=
 =?utf-8?B?bE1kK3ljKzNNaG9GSGJIWEloa0tHdXM4OE9qNGdybkhjNnpUNGNFK2Y3WXRQ?=
 =?utf-8?B?c2oxQ1laY29QQ3VzL2t5WXZ4L2x6enkwdzVzbXpDYW9ZNmxCUzZPdEh5ZStZ?=
 =?utf-8?B?NmIzbTQ3WWNXUnZRQ0U2UldQbDg4OTlWTEFTRHJrSGV0TGcyd0hIa2tMVmpt?=
 =?utf-8?B?Vkp5QWpDNnVXTG1ka2dNVDlIQzRMWk5DQ3VGam50V3dMSlhaNlV0QS85OE9J?=
 =?utf-8?B?S0trQUhiYVRYTjhqeFJ5Nktwb05YcE04R3MxdlBmNzQ5KzhRdUtKdDE5dnZI?=
 =?utf-8?B?dHdhNEZpQW92MmltZnhPeEo3SVJROGNZbEc1Y0R2cnpUeTJQOEdCRVFpS2pC?=
 =?utf-8?B?Tms3eldpZFNYSlBoTE95MktNckJRQXlKc3RuWXN2OHpPSVkreHFmVjVYejJG?=
 =?utf-8?B?OVZkZnJ6cUlrMFVxQ1lzQjEwcTM3M3daTVYreE5FaFk0YU94NUd3cGNxWDRM?=
 =?utf-8?B?a3FobVdhRUxkVmZjZkhISDRqNVJjc3M2cGsxUG00QXRjbFRoV3F6V01CY0Iy?=
 =?utf-8?B?b0NPZEN1TDR6a0p0cWhhcURLMk5kKzVGSGkyQWtQMWh4anZCYm5mZmhLMXhO?=
 =?utf-8?B?Q3JPNDBoemlOQVBiVTJ2RzZocFdicmxzU1NlU1FMcnJjdGUyZ2ZZSEhtWGVG?=
 =?utf-8?B?ZTBNa1dZZVVmKzFxeWJaZWFaeUFqSEdxYTZtblhKVDNyTlRLRGhoNDhSQW9Y?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6201601-598c-4ec5-e5e4-08dbaae994e0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 12:47:20.6965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7l/dj8BS8Md/G+fMHUPVljoAQsv3b2bMc4ElJm07RKw4ie+WKK0AVR/l+4r11G9F56tvAGyOLLty5jWySMae8hibUDVGqhjC5qDTKGjfR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8720
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] Refactor getegid01 using new LTP API
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 9/1/23 14:22, Cyril Hrubis wrote:
> Hi!
>>>> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "Gid: %d %d", &st_gid, &st_egid);
>>> Hint: You can use assignment suppresion '*' in order to get rid of the
>>>         dummy st_gid variable.
>> Also, unfortunately this is not working.
> SAFE_FILE_LINES_SCANF("/proc/self/status", "Gid: %*d %d", &st_egid); works for me.
>
Ok, that perfectly works now.

Waiting for getegid02 review, then I will modify code and send it with 
the patch set.

Thanks,
Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
