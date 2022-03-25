Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C008BC433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 09:18:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB8863C8C9C
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:18:28 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B80253C067B
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:18:17 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 29B241A01497
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 10:18:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1648199896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M36x4OnNMuorPweKtmADD5FTMIuM8jE1h1SiiXAJK48=;
 b=FkpwKTeg+JSd7x0fzGC1WuRaQa8SWQRDgzcdHTPJHrxtJrNxIGUpRqmI8Yhh15wR26qmLn
 OSpQhJw3sH76sr7BcoTqNteYmZwddYe2toidW35y95ST33lwO5uz+MSQOP6s1jDPHd8pl2
 EvrG1f4b3mOot0ZhXAdh74K9Lv0PVec=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-5UV7Ey8fPDyC9YTbNU6_Jw-1; Fri, 25 Mar 2022 10:18:14 +0100
X-MC-Unique: 5UV7Ey8fPDyC9YTbNU6_Jw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j17SnQrTzZXkYPWVmRwfywdnjKfv/2Ght/BwA1VmlxiB012aJcIHii0ZdTSD/Impm+grsi9yjKiuS8ngj/Ls6OGnp5VtpQGqGnjTn7Y/hD2WXxS5KNzk+otZAcIVk+CHtH0WDsRKQ2q9fnyng6UcRi+m9uzLbcnR2DNPaUXcvtkIpE8LlTXO+ll+oO7jhV+aANPbSaZzkf/2+hd2O8uagQG8WYCG88w6oQT9GEaFljEbC90hjzUxvb9O0CgayiVuydmMpQHvDgq2HOMJXv2HxZNx5mIVkVffLpKr+F1bT98oZUOxD681TCIpprrTE9OnF7durUqjlXeZa5GHIW0UkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M36x4OnNMuorPweKtmADD5FTMIuM8jE1h1SiiXAJK48=;
 b=FwPXk2O1yUsf0GeC1pjMLG2zxKHO0pFyXpEeSiwu4gcDZVhsBPHCxsJNrN7/nGRQJLESy0KRj+hfrNBYSMTrCYY90H4CGYNGz2snQIvlLMh+a0DIN/YojzK4uFYOkG94Db1mWtAmvIDb6mCYxWu2rEEp/BFzLvEH0fnptVwgM6IwCjd4JcekFNClkJd8RyDx/a1BfSx/npCsClHzQ5c7CCPxPE+5L4Y7iuZdsbY+aqmZWj6G3UxX25fsNMzmX4LOQ2BuUs4erBx4m6pybykieeX6sKbxbAbIiN9w2mLrYS0AboKks5enNFzGKhW25HsuOAghP2RmLX/Q4z1uLeeUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by PAXPR04MB8512.eurprd04.prod.outlook.com (2603:10a6:102:213::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 09:18:13 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3%9]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 09:18:13 +0000
Message-ID: <dcc9e9e9-b729-dc6d-7319-45761ee4efe0@suse.com>
Date: Fri, 25 Mar 2022 10:18:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220315122351.8556-1-andrea.cervesato@suse.de>
 <20220315122351.8556-2-andrea.cervesato@suse.de> <YjzZnkrugQyEuWLe@pevik>
In-Reply-To: <YjzZnkrugQyEuWLe@pevik>
X-ClientProxiedBy: AM6P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::24) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e8f1a09-f93b-4493-62d5-08da0e40634c
X-MS-TrafficTypeDiagnostic: PAXPR04MB8512:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB8512207EFDA81B2816A9DD50F81A9@PAXPR04MB8512.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkub56qC6XBUMcbrCGmmei7OYKFmBD6TcHsO32wRBcTNHiXfz2gH5iZc614B3QyUtuDAqDgULbR9mdH5nwm5okG3/+tbXSZINpaSiA4BBXmoZCoi+qUG4CoyQV/iCfFy/49yZA0oZGXFGeAqWS18WAXFy6fT4SwFUPQxRs7T3BEtUCjw1MzE/rexkV1t50ba6Bgc4VEDp3iqAaezbMNPQUiSkpwTPqxEomxM5Tg+eoGueo5WHzvbB2FF2VSNhxW1aazEyr96RCfQJwf/ZFnclpUB3u8wfL/wa/n8nkYX3S50Uw3Wf/+AEoapemgGe7hgsgnMpvvuwMgywUJclTSnur/iCmERU1siF/yLsfNrUxoabSWh+BkiXSsO69tbk5VielhMTD4/htkn0TEW1HYQS/BNOUl7iatcUiNlLOB3rq3A1M75iHAQij7weKdrqcdjfWbse2sCiAknAPjg7HpUI2EWBM22r9UWeFF0BSt4G2XZ4GMWecoz+tjrSla29hk+4jweuubLcBji9FWEaz6Vo/tth1/A+fs61Z/z1RtjXP2BBXAs7Yrhi6TsGQyaeJ3R60K9aqRnM+cGqO/9KFFDhZ86hakURwSR2bVmz1bPLxsuli4kOldiWQIAQ9gj1+PB4d9mAIqER9OURgqjoeAl9BD5HvIinz3DvZW5xTqTItouIyMiq/2351Bs/JMpETgXGzA9WT8639tVB0tim4HT8VMqV31Wq8Yg+rwtWP8V1pk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2906002)(38100700002)(86362001)(186003)(83380400001)(31696002)(26005)(2616005)(110136005)(8676002)(4326008)(31686004)(66476007)(66556008)(316002)(44832011)(33964004)(53546011)(6512007)(5660300002)(66946007)(6506007)(6486002)(508600001)(8936002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpSTHVPSzIxdHBXZkt3RllkVllBeEhWaXozYzFYUFBXTDZ2OUJjd0szcVhB?=
 =?utf-8?B?MnIxUzlBSTBXTkJMZ2Zma1gvMkdzaUZoNUlaUmpUb0hSM1NDRnJrdW42T09u?=
 =?utf-8?B?Qm1NbHBPNUdSaDFLZnNRekFCWkRRbHNOZEtOMWs0d1BqQ2JSNlIwTFpHc1Jn?=
 =?utf-8?B?OFNwb2o3cEk3SUVrditWYktELzZBaDdSMXcybGFHK0p1THZEai9uOVFyYytL?=
 =?utf-8?B?NTEwRFZLMlVPWjV2djV0aGhFTE9DWUczV3NXK0xFTUVYRGlJSm1Ob3JDSXVM?=
 =?utf-8?B?b2hvUTJYRi9RWnVhS25wRVV3ZmtnK2xCVkFjeURCNDUxY2tyNHRRcVFrRWt6?=
 =?utf-8?B?cEpXdG5OT3Y0cHNIUVRpekNKQXpwSFJ6TmcrYWx3ZlY2R3NCS1BDR210dVpH?=
 =?utf-8?B?aExNQlhHWXVidEMrMFRDL2xibzhIcnVYRHZLZ0lxM0NUMmF2eFBURzZFb2xX?=
 =?utf-8?B?aERUaUw4dGV6NXV2UVBCNkYrbVRocm1uNkh3N3k0NzhOcDFFZWwzajBDTTVQ?=
 =?utf-8?B?Mkh4eU16bkc3ZXFOOG9qWk1ZcjM5Y1FMMXJmTGRkTVQ0OE9WR2t6Q3hTT3pM?=
 =?utf-8?B?NFVnYkU0VGhqeDQ0eDR1cE1LZThxTEd5RDdsYlpwVmRHMzk1ODRFWXlzOXI0?=
 =?utf-8?B?TE5XekpLUHZsMmZUeHk5cS9pRmQ1Z3pUMm1BVUZ1Y3l3UnVnbUtGb2dNc2tF?=
 =?utf-8?B?ZklLYTVKbzFDUHY2cENnU0lkVzNZdVI2L3ZLYjZQK2IzbnpLSG8xMGdpTjJ4?=
 =?utf-8?B?aTRRWVpvdkd1dTlZZ2EvZDN3R2VPdGc2aEl3R3ZQTitORDlXR0QvNjNqN0ZO?=
 =?utf-8?B?c2p5cytwVHB1Mi8yeWdHZ3o4WHBOeHB0SW1mZXNwcDF1aG00ejhHK3gxbFVD?=
 =?utf-8?B?VzFYT3doVVNIS0c2SkZmdnZZeEJ1UGFCcHhKNFZieU05TCtZazN6TERpcmNW?=
 =?utf-8?B?Z3VJK21wa1JsVWo1bVlzaWUrVHV4bVVnclBBK1lxMUY3ZUtJTmJLaENBc2t5?=
 =?utf-8?B?WlJjZEY3MWxBVkFrU1hVTk1iQkZ6ZWcrREJnNmorRGJWNE9MaDV2VnBZMTFq?=
 =?utf-8?B?NUdUK2FxV0haUnVSRXVDcXB2UFpvVW5XdXQ1Z0ZMcXNwRHBZTk1nb2tUeWxt?=
 =?utf-8?B?OFVjR2VrWS9OSkRtUkVXamUrb0tDS0lTZzZzVVM0djZuR1dmVTdlOTg2SkQ2?=
 =?utf-8?B?aGt6WXc1YUNlNE05bUM5c091N0NRUmRYSEppTlVVOUJoL0ZPaXpaUWJUWElQ?=
 =?utf-8?B?QnVVNmdIbmVaa0JxK0U4Mk1MbGdLVGxSZFd5YXg1a3duNWQwaTk4THdvLzln?=
 =?utf-8?B?YVV5NGVsMm5xUGhxN2lySmdhcUhqbjZob2VoVmx2WEw1T29MdkJLdVNncnF1?=
 =?utf-8?B?a0N4Si9mK1ljSjdvQVdGWHhyeVBFNmwwclYzMHBMNGFnUHIzM2F4ZUgyVkM2?=
 =?utf-8?B?S1Y5SDVuQTk0bWZsSDNCdFJrK0h5bjdRZDEzSDZpSEpheW5vb3hFZWVNNWkv?=
 =?utf-8?B?UEtCY3BIOVhPVUlHZFBmT0VCNW52OTlMN0ZOMVV2eVp1Lzh6dDVCRzZFVFhF?=
 =?utf-8?B?Mlh4UGl3TUZadS83cHRKbzMrNnZSSWR4TGRWTGRZK095VDd0OFErK0puck5D?=
 =?utf-8?B?N29IZnVhVUU4RUpGUkg0MzJzbVcrRjZNZTg1WFNvQzRWVHM1UDNIdDhmNlVx?=
 =?utf-8?B?enYzLyt5ckJlTXR6Y0hJYVp4TkxJZnF1NDMwcUZwWVBaenhGSHRSV3lqRG93?=
 =?utf-8?B?NzVqbzVnV25MWFM5cGM4UGNKUkVIcUtaMWhRM2d2bjZnRTlpOXZZRW0yRFpk?=
 =?utf-8?B?cXU1d2doV1lXZ3lHb0Y4VGFqWGZ0MEVFUkxTZUtGQVB6dHYyYWczZG4ydFAy?=
 =?utf-8?B?K1M4YkY2cWc0WGlIT29panJlY2I1UXdKWXdnRnc3US9WNEJ3Ky9VMmp0VXB1?=
 =?utf-8?B?UTRIeGY1QzE1NStXQUVQZkJvd1BVQlpuMEJkMmVqMHN3OU5ycjBGSTBicGZk?=
 =?utf-8?B?WVoxZEk4SG45cnVmL2hJZTI4OEVuYUNkQjB2ZkY5Q2VzbmkvT0M3cVkwSHNQ?=
 =?utf-8?B?dkxQcURwdENmVC8xMzJhRXNzUFY5RnNBazFPZVc1QllnMFJjdmNEeU90T1pi?=
 =?utf-8?B?RDdFbHVYYTVRbEUvcDNOUVFYTi9BbzJaOFlIL2Q0WmdneHpvWG11R1hoZnJ4?=
 =?utf-8?B?U0M3VGRvdVlUN3JhNFpCR1VLQ1lyc3RUYXZMOWx5ZisweCt2ZXY1SnIvL29h?=
 =?utf-8?B?aVFiU1dqM0RWTUFVVXRtRGVmbW5ldjhZakt4eEJCL0JKTE94QzF0YUdMT3Jl?=
 =?utf-8?B?QXYxUnBpZFN0TE1kVGtlbnUwODdqRXIwNXZOUGI5ZmE3RllMd3BRaGVqL1B3?=
 =?utf-8?Q?N6YVlVIplBAmTias=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8f1a09-f93b-4493-62d5-08da0e40634c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 09:18:13.4399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mmkpx+nPRgTwQcTD9szqakDzsM4T/+hnqN6L10cOgMHJzpMXBF+t6IXf2e/sjwd1erbi/S7o0Xf77kM3S1ASyhnoMG2II6SLfVHWvppPo04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8512
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/8] Rewrite userns01.c using new LTP API
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
Content-Type: multipart/mixed; boundary="===============1445253243=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1445253243==
Content-Type: multipart/alternative;
 boundary="------------sO2dL60PwQ4Cp3WLQ9LbU8GK"
Content-Language: en-US

--------------sO2dL60PwQ4Cp3WLQ9LbU8GK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr,

On 3/24/22 21:50, Petr Vorel wrote:
> Hi Andrea,
>
> ...
>> +static inline void updatemap(int cpid, bool type, int idnum, int parentmappid)
> nit: This header should #include <stdbool.h>, not all tests (they use UID_MAP,
> thus they don't need it).
I think this will be replaced with integer, according also with the 
if/else statement which is below and use switch to check its value as well.
> Kind regards,
> Petr
>
>> +{
>> +	char path[BUFSIZ];
>> +	char content[BUFSIZ];
>> +	int fd;
>> +
>> +	if (type == UID_MAP)
>> +		sprintf(path, "/proc/%d/uid_map", cpid);
>> +	else if (type == GID_MAP)
>> +		sprintf(path, "/proc/%d/gid_map", cpid);
>> +	else
>> +		tst_brk(TBROK, "invalid type parameter");
>> +
>> +	sprintf(content, "%d %d 1", idnum, parentmappid);
>> +
>> +	fd = SAFE_OPEN(path, O_WRONLY, 0644);
>> +	SAFE_WRITE(1, fd, content, strlen(content));
>> +	SAFE_CLOSE(fd);
>> +}
--------------sO2dL60PwQ4Cp3WLQ9LbU8GK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr,</font><br>
    </p>
    <div class="moz-cite-prefix">On 3/24/22 21:50, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YjzZnkrugQyEuWLe@pevik">
      <pre class="moz-quote-pre" wrap="">Hi Andrea,

...
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static inline void updatemap(int cpid, bool type, int idnum, int parentmappid)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">nit: This header should #include &lt;stdbool.h&gt;, not all tests (they use UID_MAP,
thus they don't need it).
</pre>
    </blockquote>
    I think this will be replaced with integer, according also with the
    if/else statement which is below and use switch to check its value
    as well.<br>
    <blockquote type="cite" cite="mid:YjzZnkrugQyEuWLe@pevik">
      <pre class="moz-quote-pre" wrap="">
Kind regards,
Petr

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+{
+	char path[BUFSIZ];
+	char content[BUFSIZ];
+	int fd;
+
+	if (type == UID_MAP)
+		sprintf(path, &quot;/proc/%d/uid_map&quot;, cpid);
+	else if (type == GID_MAP)
+		sprintf(path, &quot;/proc/%d/gid_map&quot;, cpid);
+	else
+		tst_brk(TBROK, &quot;invalid type parameter&quot;);
+
+	sprintf(content, &quot;%d %d 1&quot;, idnum, parentmappid);
+
+	fd = SAFE_OPEN(path, O_WRONLY, 0644);
+	SAFE_WRITE(1, fd, content, strlen(content));
+	SAFE_CLOSE(fd);
+}
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
  </body>
</html>

--------------sO2dL60PwQ4Cp3WLQ9LbU8GK--


--===============1445253243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1445253243==--

