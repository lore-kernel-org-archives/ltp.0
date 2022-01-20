Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A808C433F5
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 12:30:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 408783C96B2
	for <ltp@archiver.kernel.org>; Thu, 20 Jan 2022 13:30:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 016C83C21D9
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:30:21 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3419B1400FA5
 for <ltp@lists.linux.it>; Thu, 20 Jan 2022 13:30:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642681820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ADuMF0eHBkPiJajtgfEy/b6OwjTIvGpQPp1AV2nyVe8=;
 b=CT4OS7hTeOCe1DEHKZ7qQDoWpz2erKEqOCl/C/GNh3hKgEdXYmIpuoB7JraMvD3budZcqs
 nlk22e1Vmp2i40KvV6nBlLS2B7wTDMgwcHUfMa15QwZ0F0C36TBqfta/H5Fv/VlMybypCK
 6NldB4WdOJwsaaFipId+M7/lciK6GxM=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-KgbTkLATNXuI0DXa77foPw-1; Thu, 20 Jan 2022 13:30:18 +0100
X-MC-Unique: KgbTkLATNXuI0DXa77foPw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHT/BgKbKDJ2wnl83cqkIVQFxPA+3WLOW3qy22JG9sPNMnUPh7CmsPZ0CJkxrJ6iK2Qo84/awphzC3lcEzggjlBZOtqSQ2mrkJS9rFqC8DFK3zYXd48zceKKv1qzhbbMaI+z303P9sW28RXnD5U9Ec95m2Kwk5REgN4T0Ss0EWnDhqBn/70EhJkpsfa4RAC7mSh/qFZ/X7GWK9bjOfvIAiCLUAZmqD/nN7uLAqCscLeyxi6k4LA/5MeQHVuoKZT9oXRUEatyvu9EyINeaUq5BVmGLGxJHT87OeV++pHTvHabi9Pw3sln9LTt941jJMObkUMkx+ZQBUDOgsgljxsL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADuMF0eHBkPiJajtgfEy/b6OwjTIvGpQPp1AV2nyVe8=;
 b=JEjloFbB7pYWzA48ZqJq5EZYLG5G8sOFKvFOUU9GgfHOHQY/Ihjp4ZOe6fywNZ09o1EfHBWezDtzDQfpirMEUaAPs9ptwM2OCOfg2oXwHjMuERGf6ubCsOeIdsi3KMKvbDTAygP+cLn250fkcNpknR2MScxqXNOFV9nQsGmxrUTpCGZjClWylCF+AoRWkt928HFGlGH0vpAofPkSC/M6ESjtkLwtpuhvpY22SJ1Hf+SaOxzfGDyv7MygGA+hCCucQHllFwUj0HCCKqGpQEtT2Z7J8MkeW1hdFdQtguhMakeov+iSVJaiv2qg23GGPDvna/VLxvU6Qfh+VNAzyxcCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM8PR04MB7460.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 12:30:16 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5881:fa38:8459:b97d]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::5881:fa38:8459:b97d%3]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 12:30:16 +0000
Message-ID: <4ab9da33-ba2d-953b-515e-8b44a12dea6b@suse.com>
Date: Thu, 20 Jan 2022 13:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20220119152732.21189-1-andrea.cervesato@suse.de>
 <YelSqq5cG6JHFtyh@pevik>
In-Reply-To: <YelSqq5cG6JHFtyh@pevik>
X-ClientProxiedBy: AS8PR05CA0007.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::12) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3357ea81-b0ae-4cc1-7673-08d9dc109d2a
X-MS-TrafficTypeDiagnostic: AM8PR04MB7460:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB74601F9A4749104E4295A088F85A9@AM8PR04MB7460.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjvDE5SUU516mqYNxiCLq5UdUYtQVtFSW2JMOW6CjSa6vXqzne98SA9uBDFSQB/qdESSbeKUw/3hRc3bvstxXswrfOv2RQ23kQmtw2PFa7EcH6iyg3/0lz+7R0qF5iiX1fSROvJd0QC2l9qHbRQvNNxBUDOjicGnixxr7ZsRQK3SIFKGVhTUuhIecggllw3iI2MimFf4igrz+Gmry+PbO8B+964fRB3uOILTHMnzV3rmFlwKJbL05+8TAWhhWLdqCLIl8V6rPllPEX0KHHGdmas5+tNT5yCZZjkcLvLbFrO+NOMjznoZawh+gxmODhlecBBCCBuwfKayxxesxwjPhE4oSUi9qXjxD+hdZsyluHR/b0yZGHL3LxuF37TQ3QgHaAsCgZUfmKAU8f8aMMdygrxVo1VdNHoWEfv7OylUtmwW7Asa5XVlDCbHIyrgS5n/9qoYgJZhDmCRKCJkzMnzDBSh0gBCfHqZUvdP/30/J01wiKfhzHycWQwRbUAaxR4+qoXCOLIdbtzghjl12CPyrzKhVFAZ9cT8wbkhKWBJEEzYOmwGK9f4Wp1W8Qgg0XhM1dwk4sFnVQOTGDmEtl/zCcuiPg4S1oO0WUokS6eg4tNuXj2Bc8cK4G6GxTDaVbrLdsAOWRa8s2L3nrNncKPIvo/dH9VaFFg0EaKunRfJRDvEhmmflUCSER1B5g+Tc4opQDtKiKYpL0cHBcNhhrbsxjrZ2xM711s4zdHVDv9mK+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66476007)(66556008)(36756003)(66946007)(316002)(110136005)(6512007)(26005)(2616005)(4326008)(2906002)(38100700002)(8936002)(53546011)(6486002)(6506007)(31686004)(508600001)(33964004)(44832011)(31696002)(5660300002)(86362001)(186003)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjc4TnhoeFN0MW5BRFRGZ0tsbDBEcXFEZmJ4QWZhamo2c1VBamcvZzBIdHlK?=
 =?utf-8?B?UFg2MTRZRmZwVlBucnlRUk83dmtqN1d5K3hmTG54UXE5Qkw2Nm8rdUFIaXRH?=
 =?utf-8?B?eHY2bWFpdVZIWHNYeCtBQTYzVFgzNU5kUSthWE5YOHVxWHlXblBubzdWY2NP?=
 =?utf-8?B?NGkvYWRQU1MvVmd2elRJZjV6WWVZRm0wbU5PZG5QTTg3UE9NY0dZOFVWK1Nw?=
 =?utf-8?B?bXBuQmdPWkk2bEtEZjlrUHpFQ2N1dG94NGlvSFIxZzZZR0NObjlyOVFuWmcr?=
 =?utf-8?B?NVRPSzI1SE8rakdsdlNudHlxRllFZDhqclc4OVVwOU9ybWtyWm1PNVp1Tml4?=
 =?utf-8?B?Rk1NN0VUa0dodExEMDA0Vnk3QUtuVU91VllaZkZqcjE3MTZaWEMxZDRzWmRt?=
 =?utf-8?B?MkRyek9XWmsrcTZLcVozdUw4anFPNGVjMldtMnA4WFptTG9NN3R1alRlU0kw?=
 =?utf-8?B?WnlodHhMQ1RCNTZpZ3h5WGhFazAzeG9DQUdrR0VYUTNQYmJFRzdrVFRiOXdB?=
 =?utf-8?B?dEYwMEs2WHdicGlYLzgwRDJkS3ZZYjRlWWFhcmduMXJNNWtDR2MzOXk3ZWRm?=
 =?utf-8?B?aHJpS3U5MjJUQ2NybENSdzV2Zk9uTCtFQzUvQXdUVStPZFNjcjRYK2FwOHhB?=
 =?utf-8?B?S0hvNFF2blRyK1dJUmlzY3hudmVMaFd3ZHJPMEtsbVh0cE1HTHhhQXdxRHYx?=
 =?utf-8?B?UlNiYWpNVmJKQ3pMdld0RE5TcUp2REg4TGNNNnBBOElFTTZjUFU3TEdxS2Rp?=
 =?utf-8?B?eEo5eFhRem1IZmhLTEtTVXVPRWFHekVwM1FvVUtQeURoWEhzYWo5T3p6a2ds?=
 =?utf-8?B?aEk2MGJnNDNTaWNlem80UU5GZGVWOTgzblB1eVUrOSsxakYrNXluN3R0MlpQ?=
 =?utf-8?B?Vi9xM2UvcTFuWFFpN2NEcW9OeW5EL2s1bUlzRGkvOHJsd1VwT3dBSTgzWjlw?=
 =?utf-8?B?bkJOaUdGNDU1a1RiTDBxQWh0M3VVUjdISnBqR0FTdVI1ZzdsK3habHpZK3JE?=
 =?utf-8?B?SUJ1ZEg4V3d3S3hBdTBINnIybzBqUENoZTVjRDB3aVpEZ2hCbW0ySC9OZXVP?=
 =?utf-8?B?cTV6SnNRMklyM29uQkRzSWVybnZrb2xCdjIrNU1SOFVnTjJSMldOa2d2aTJM?=
 =?utf-8?B?ZGlJeExwMjk4N0xJVk1oTHErdFhHbEJuMDBKcnpvWnhtajU2VWpoUVdNWk92?=
 =?utf-8?B?USswVjZkSG5sZUJ2a0ZUbUY5UkdkZVJpNVZEb1M2M0tJUnFSakdIdCtCbTNw?=
 =?utf-8?B?TStUVzhZajM0byt3L21hZU9GdnZEZEpTWGF4a0RTZUdVSFhRRE0weWdPd2FQ?=
 =?utf-8?B?L0x0WElvdUhOSTVPdE5yeG1nTm93WXF1d1kzYVhHZGdqd2owV0w4REd5OVVn?=
 =?utf-8?B?dW1zbk9LRmU3TnVISFlWYkl3UGl4U05yM3V1Y1NsNzA1Qi9ReXR2SVhHaERP?=
 =?utf-8?B?Q1pmN2dYYmhJYm1xU050d1B4WmRrVzBFUEsySmU2NXlZYU53MEhnZHhiLy9n?=
 =?utf-8?B?V3pxajhDQk0rdkc4STJmRzZDYlRxQUZHK3dNUG83RUF0bVdmaFlJaGttRlRu?=
 =?utf-8?B?UGVncnlKK3pVUFRiQUF5TFJUR1l3THJsbHdJSEd0OUlUcFpmNSt4YXJVckFW?=
 =?utf-8?B?enpzbndSZ3JtVCs0S0RZRDAzU3pnOS9leHNNR1lrZzNZNmhmZ3lUaWF6MUx6?=
 =?utf-8?B?dk9KdzIrQkF2bjVySUpuYVlMTEhVKys1TU43REx5RldQRkdRNXNLS09MR2k2?=
 =?utf-8?B?K2d3SFNEc3VTcVF4aU5GUEswNzB1Y0F5WFhtbmovK0NkcURobUlZNnZpVUJp?=
 =?utf-8?B?d25hT0N3VWRwbnk1dHVhMnpIdnhoWHdaU0ozbThBSHRmOHBER0FReTJsMWxh?=
 =?utf-8?B?VU0vaDEwOHFRM1l3akxEYnNwNGxuMklTOEdmSGxsb1lMemdXK2FMWElEYmtj?=
 =?utf-8?B?Y2U1cDlxbFdHRzVOTmRhck12RnBvcGlYSGg5Ti80UnBmOGpQR0hGQ1JTNHdB?=
 =?utf-8?B?Z2tQdVNOMEgveEVMRElDQ1Q0VTkxNGFvSGhlTGhqUWV6SDhmeS95YkQ0TUlL?=
 =?utf-8?B?ZHBRRlgvbkl6K3dBSTM4UmJVLzZtbmpZc3BUTVQ3QXJGU2sxVnVMQVdIeE1u?=
 =?utf-8?B?V1lmTWw1dndEMVBZL1oxNHhsazg4Sy93Yjk4RUhRYlpwVlRBYUtmZTRkRlVv?=
 =?utf-8?B?bDJUM1NNdzRwSDFQUkdkOCsxbUZzZGFIWkxpdzcvS3k5ckd3RzVvUDZoZ2lp?=
 =?utf-8?B?L0VzSUE3K1JXOXNQNTlFVE04a0ZBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3357ea81-b0ae-4cc1-7673-08d9dc109d2a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 12:30:16.5903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wL+Xz26FhTdUiJmn4pr5kyybav4V459b6IaIwJtr90tiNPQsWdas4fFH2okz98M9psgSyP4dH0rx/Agn/kvYUi4qNZTCXl3KaqhzAFR/HGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7460
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Replace ltp_syscall with tst_syscall
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
Content-Type: multipart/mixed; boundary="===============0678427667=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0678427667==
Content-Type: multipart/alternative;
 boundary="------------YtLWgM0YD0uuCduptLwzblIi"
Content-Language: en-US

--------------YtLWgM0YD0uuCduptLwzblIi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr!

 From my point of view, it would be nice if lapi code would only contain 
fallback code, without LTP API that requires tst_test.h or test.h. So it 
would be easy to split fallback code from "utilities" headers containing 
the most common functionalities to break the test if fallback functions 
are failing. This is the case of lapi/syscalls.h where tst_syscall is 
defined, but IMHO it should be defined out, somewhere in a "utils" 
header imported by tst_test.h or by tests which requires specific 
functionalities.

This is possible only if all the tests are already in the new LTP API 
version tho, since old tests require to be refactored first.

Kind regards,

Andrea

On 1/20/22 13:16, Petr Vorel wrote:
> Hi Andrea,
>
>> This modification is a first step into the old LTP API replacement and
>> it has been completed with the following procedure:
>> - removed ltp_syscall
>> - replaced ltp_syscall with tst_syscall inside all tests
>> - reshuffled headers inside tests to import tst_test.h before
>>    lapi/syscalls.h
> So far we've done cleanup as whole test one by one.
> Sure, why not solving one issue once.
>
> Generally LGTM. I'd just appreciate if tst_test.h didn't have to be loaded at
> first, but that's a minor issue.
>
> also with these whole tree patches it's a problem that it either breaks some of
> other patches (they will not be applicable) or this patch will not be applicable
> (if not applied soon after the release).
>
> Kind regards,
> Petr
>
--------------YtLWgM0YD0uuCduptLwzblIi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr!</font></p>
    <p><font size="4">From my point of view, it would be nice if lapi
        code would only </font><font size="4"><font size="4">contain </font>fallback
        code, without LTP API that requires tst_test.h or test.h. So it
        would be easy to split fallback code from &quot;utilities&quot; headers
        containing the most common functionalities to break the test if
        fallback functions are failing. This is the case of
        lapi/syscalls.h where tst_syscall is defined, but IMHO it should
        be defined out, somewhere in a &quot;utils&quot; header imported by
        tst_test.h or by tests which requires specific functionalities.<br>
      </font></p>
    <p><font size="4">This is possible only if all the tests are already
        in the new LTP API version tho, since old tests require to be
        refactored first.<br>
      </font></p>
    <p><font size="4">Kind regards,</font></p>
    <p><font size="4">Andrea<br>
      </font></p>
    <div class="moz-cite-prefix">On 1/20/22 13:16, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:YelSqq5cG6JHFtyh@pevik">
      <pre class="moz-quote-pre" wrap="">Hi Andrea,

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This modification is a first step into the old LTP API replacement and
it has been completed with the following procedure:
- removed ltp_syscall
- replaced ltp_syscall with tst_syscall inside all tests
- reshuffled headers inside tests to import tst_test.h before
  lapi/syscalls.h
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">So far we've done cleanup as whole test one by one.
Sure, why not solving one issue once.

Generally LGTM. I'd just appreciate if tst_test.h didn't have to be loaded at
first, but that's a minor issue.

also with these whole tree patches it's a problem that it either breaks some of
other patches (they will not be applicable) or this patch will not be applicable
(if not applied soon after the release).

Kind regards,
Petr

</pre>
    </blockquote>
  </body>
</html>

--------------YtLWgM0YD0uuCduptLwzblIi--


--===============0678427667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0678427667==--

