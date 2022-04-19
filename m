Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2F8C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 07:36:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39D0F3CA669
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 09:36:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9FC23C0058
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 09:36:19 +0200 (CEST)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1CA9D1000371
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 09:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1650353778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+/5QKpObR7tD22zMDfdjO/EuGLg6euzs8O0HbdVGnI=;
 b=nWAVP7EpZ7Kan3MJ+DQTTEwGhFAE3i9Qtv4MSOFrm9xgOP+kKWOv79kz470dqyYffW8p/0
 kP8S54Wu/hK8fQegIa2vRUcS/ZQYoYgtLWw0CddKGT+kLVVptnHhx3aYtqb1gfKdcTPYEP
 RO6pDSkifdeBeE4Id39ItZ/j8NM1Qno=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-zqvY-ywCPDm4QUAUJjGzUw-1; Tue, 19 Apr 2022 09:36:16 +0200
X-MC-Unique: zqvY-ywCPDm4QUAUJjGzUw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4GYo35Z5ReZj6jC8310ybCBE0Jo9yVudxV6MBoU0geGyelXCUmkDZ8OkE/wkkq3lkJ17UmhEqTggO3xEeKJRTuMhwlaWfDsIJex2q+amSHkDfGv2u+V5EXze0/p9dS1lFYAWBns/Y5x0bUeT1BP6A9O5OpvpLAF0cgadPOp+vveb3+0L+cHTwQAUXzTc+1RC0lV3zDP1qn0KYW25NB0M8MbXlHUMIiMCgRjKhJ8S07fR1iW8cMhqGmTNCvZ9OfurIc0MtU57TtRw2sZkAWMlQ2vXzFX1hiGCWQYV/DqB5Ce3QyHoaoptMD5x9GrwGs7+9BDPl51LLZljU43hZBjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+/5QKpObR7tD22zMDfdjO/EuGLg6euzs8O0HbdVGnI=;
 b=iC1hLmsUL0mf8ZasUgz6dsgHMQV8SYLy6jKIILbQ9MS2U71RBjj575NSVKu9Yz+UB5dJKLcR65HRVGOtLECdOQ7xD3ejLTJBVN3wkjDuueN0oMsTGqmxCG1IU91OR1TjaDH4RF96DA1wk8VkfRNMpCIntxXGPBkvQDCv0lJ7uj9N9L7/OkNPQu3FsPh3j8sdMTv4KlmdEgXfUIneXjttx6pUcr7aLnRX2hFCFPkGH46bbfajNTk+5sk/Ta1aHwJ5pEPv4v/Qsnd5xZ1eMLICxWf5rJLh/zmaRrJe6/wPxHTWeBEL7JJwwqAT23/BgLLWwJRbRtQqdg+0WwuK3EcGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB6147.eurprd04.prod.outlook.com (2603:10a6:208:13f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 07:36:15 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::f5ca:e1cd:3a9e:5fd4]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::f5ca:e1cd:3a9e:5fd4%2]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 07:36:15 +0000
Message-ID: <f1ef4946-7640-07fa-44be-fd3ac13a9695@suse.com>
Date: Tue, 19 Apr 2022 09:36:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220401050804.1286-1-andrea.cervesato@suse.de>
 <YkrJfb0vZq6WSZmX@pevik> <348d5c14-97e2-7c23-9666-92ba77354417@suse.com>
 <YkrqzV+W2qYKJuIw@pevik> <Yl5jM+a7yGtVpaIG@pevik>
In-Reply-To: <Yl5jM+a7yGtVpaIG@pevik>
X-ClientProxiedBy: ZR0P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::17) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343c77dc-c729-4ede-04c3-08da21d748bf
X-MS-TrafficTypeDiagnostic: AM0PR04MB6147:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB61475F4E2FC897875BAE04F5F8F29@AM0PR04MB6147.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnzhJUD12mUMnw6oWHBkWZgLXFlkxslFU6L5/oV7dikq6cyYH6VGqYMoK9BDk6eK0m6vO4yPpHRMCSL3ptZwKdt6UnP3uDTzUmi8+SuNm1AgY0ENYQpBxadq1SNZbPuyIorQioeJx/XqOKrqZSqj6+kmYYH6aS2bQA7JUdZq5ye1URgr92W/cx0pWEl2b9iavrjR6PtasCmhxtZ791yAs0QRm6Kw4snAXlAG6lLeIpRtOd71kzMXqy5/Jsnp4i7ywOPsGpOGiAfN9figDQ+BBK34/AFcEay/hWNIEB4Gb/u8oKaUwEDDtaNY95JFBNEy9HFK/5Uaat7+js10Dn9P0UiQSyex9R4zsNS/VgkDGDtreYuGIzP04mTrJ64oe37JFEQm7s3cuD44j5MlkfNUwX4yxGvs2iYEu8FK2fAv/gmx+XRobbzj6zb9hU9fgI7A0lzawG2i/mQ07fWp1YP5Fk1Mfbhp61kouUpAGfZmhPYSDORIA8ZcvEHKhSvr1MjcdbS3X2FxiKdrDGuSrQm2XbW8YEbieOibRD8LvakxXWbMlkv2aCui500Ho3ptWBgwrvausX7CBZNa3/dz31XtmovC/VOlC1rP+VBo3RQt6lYx1G7BE/1Bf2uKZCZQVD5D+etVjFa3QHzX3xoB4TRyljId5xQqx0+XGr4QKKfdQyn/pkZ9cztvex4yqVasl8J567O8oxIJBih/S79E0VLY8PxDP5ezFEQO2jgWG7LTeBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6512007)(26005)(31696002)(6666004)(6486002)(86362001)(2906002)(8676002)(66556008)(66946007)(44832011)(31686004)(8936002)(36756003)(66476007)(5660300002)(33964004)(6506007)(53546011)(316002)(508600001)(186003)(2616005)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3M1aFhmbEdVSEJWT3h0WGZEY2NRd3ptZzRNOVluajFqdGw2YW5ucXQ2R0M3?=
 =?utf-8?B?a2pjS09DTlc3T1ZHMGpnTUdqbHBTaFpxblZEeW9jbDVINGp0VitNS1ZZcFc0?=
 =?utf-8?B?TThIVnZUd0ExNllQdksrUW5tQkNCZ25HNzhGWnVvOGp4REptdWJhWUhNY3hY?=
 =?utf-8?B?bDVGbXZDazhITnpUNDJQUUpQemN5VlltKy9EVlltUDl6R3pBbHU4RWlEMm1p?=
 =?utf-8?B?eHR5QVNnK01oNHNYblNJaVI4ZUM0L212NGFLNWR2cEhKT3dYYXdqdDZUeEFT?=
 =?utf-8?B?S2ErRXZWZGxtYlM0SVBmbVF0U3ZXS3BwYVlSaGptQlhGYnc1bjhpZjBJOVhp?=
 =?utf-8?B?R3EwWEpBVE5ZYXM4QTkwZElJOWNBdkUvZWJKS1lYaXkrc3VyWmlxRWZYd0pR?=
 =?utf-8?B?K1IwQUFtKzlUVWRQT1g0QlJXempZczlka2wybjVialRQWktDMi9DL2tuYjFw?=
 =?utf-8?B?K1ZHb3R4RVdMMXloNHM1NXpFbis0cnZEbzFLVzkvUGswbHYvRktFUk9LRFdt?=
 =?utf-8?B?blhLcnVsT3lRRHF5UC9pZXZuWDNjRW9VNnRGdFdrL1BaMzRUS3Rpd1NIUzFk?=
 =?utf-8?B?L2E3a3NpV0lEWXpPcTV3Y28yYTQ5UHVXSXlsdnQ3VmtKeW1EYXRNYUdLRy9T?=
 =?utf-8?B?UXB4bDJ4bTgxeStxcUg0WkZZaXhkbmxwK09ETHY1bXlVYmdjc0ZRRTJjTHc0?=
 =?utf-8?B?Y1FqcW8ySi9ZNEI2UkRidW9LWi90bzJtcjh0UGFZWlRPVVZ5cndOUWJNLzRO?=
 =?utf-8?B?MTR1NEpsclhnOEpxUFhhZkM0Z2ZzNE1nUWhJQVRmUXQrM0FXeFNMZS9FY25F?=
 =?utf-8?B?WW9kT0xHN0h3aUdMRXhpYWhwZ2hzU2xlbTV3SDJpWWtrSzBtT0t0YWR5Ym0y?=
 =?utf-8?B?Q20rMkJIZ0g2b2JGMklINm1lRHFhSkhmRnRjNi8yVGFXTXRSbmgyUUUydDFa?=
 =?utf-8?B?KzlFSzBJMUIzcTNSWEZxYjV6QzluVHh5ODBML0JOckZUM0ZNTXJieHNQNGxU?=
 =?utf-8?B?Sk8yNnBxS0x3WFZuWlQvMUFhOEpzZnZPTWtQV2QvdHBlR0h0WS9WZzJZeDVn?=
 =?utf-8?B?VVBIeWVVZFMweUlqVFNkTUlyeFgvbkJrV1NFa3JBODV0WE1GQW9OT1kzUEhX?=
 =?utf-8?B?OGxQTURzZ1NyVEhiN0xFeWJJVUQvTm0rUTJzUFlBNW9qY241aHZuUzZOOVJm?=
 =?utf-8?B?UzFycHFBbXpEem5ZK2NSSDRwbGlKOVF6Zkd2QjlBNHc4WlkzVW0yWTRPSDVI?=
 =?utf-8?B?Y3d5OTlBQUZLNHdTMzdZTTBXNUlxcEgrNXhHVFh2ZlphbmthTzQ0L3FZSE9M?=
 =?utf-8?B?WFpwV1daMUdjSUpmMG43dzkrWWxmRm1WaHhFQXZnL0wvR1E1NmtIeG1NTUlV?=
 =?utf-8?B?MUdTRlNOUTNYVTZRVXpxamxzN1NXNUV1aE1MNnd4ckhyTGF1cS9tM1M3MWJq?=
 =?utf-8?B?eXFjeDdkdWxTcnZkNXVXay8rRHkveCtmeXV6MXU0Q0F1UzNrK1NlNW1WQ3Qw?=
 =?utf-8?B?czBHbG00dE8xc0IzU1kyNENNbnlrVXMrWFVMTFFJV0UzOXFpeC90R05TR0Nv?=
 =?utf-8?B?OTJNQ25aVEwybFBDdDBCRUluaHY4cHhwS3g0c0MwMzlCM2xOd2QxbXQ0TEFz?=
 =?utf-8?B?MWNOYUlkTmQvejVreTBRMEx4ZENaNysya0FuSUkvQThYNHBRUXJyR1RSKzc0?=
 =?utf-8?B?R3dUaHk2NkVpcjg2SGpHeC9tYlJzeU5vZWVoSWFPS2lGNUZIQ2NEODlFbThL?=
 =?utf-8?B?TTMvLzFUZmJjakMvU3hjNmVHZ3kvZ1YzUlRDVGplWEx5N2g4RnNMaGIyOE1H?=
 =?utf-8?B?K21vcGRSSjRlMVNyZG5idGtSRnlUeThQcnBwL1VMVUVrNmZRTDBteTB4QklU?=
 =?utf-8?B?N0pFU0lZZXNCak5NUGFocEY4aWpSeW5OQmxDZURrQldEb0xmNlhiVVZ6UDFR?=
 =?utf-8?B?R292dTZNN2dVdW5UZDRNOTdyUlRkYTFFai9wb0lMcUNFRlk1YmdUS3JRL2wy?=
 =?utf-8?B?ZnVqSFpCTFdoR1dxMVYybUo0dTFTeG5XNWE5Nml2SFMvc2I4b01tekhYMHJp?=
 =?utf-8?B?MXg5blVWM3dlRm81ZkhYZXdsVDZraGVQZnlJdFEvWXdXOXFCaHRrOEo2NzB0?=
 =?utf-8?B?QWhPdWZ5SGVQZDVZcHBnVHBPYUJxMUI3aVRyTXdjNitlSk5GcXNrYW1DOFRo?=
 =?utf-8?B?L3ovRHpydUlkMVIzQ2JNeEt2STlMZjlXamxaZnRtVkUrZUdjVUR1c1lwdWxy?=
 =?utf-8?B?eDNvU0RQUlh5SVk5UDU3UTJLdGdYT2FHeEt2cmhzeUZKOUZOd2NtUkQzTUhI?=
 =?utf-8?B?NkcxQjcyQjFMdEFUWk9rUjhFV09sRlhEYjI5ZHRLU0hQNGh1VWVXdk1oblp1?=
 =?utf-8?Q?cgw1xX1uL2EKe7lQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343c77dc-c729-4ede-04c3-08da21d748bf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 07:36:14.9447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnUOUW+1LkuSeiLaeYyhWdoXf2fxSpiKXTrbYu8MsB9+CJWP0xB5sSFRYlJsVv22mcS9K48lMyNZNUv7iD2XyQkOK+lE+xKZ861o1gP167c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6147
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Rewrite userns06.c using new LTP API
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
Content-Type: multipart/mixed; boundary="===============1668634657=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1668634657==
Content-Type: multipart/alternative;
 boundary="------------Lp7TTsAjJawB06IWz5F0z0QT"
Content-Language: en-US

--------------Lp7TTsAjJawB06IWz5F0z0QT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr,

sure you can merge. Thanks!

Andrea

On 4/19/22 09:22, Petr Vorel wrote:
> Hi Andrea,
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> 2 small things:
>
> Actually adding one more #ifdef HAVE_LIBCAP
> might be better than calling tst_brk() manually (this is better than my previous
> suggestion):
>
> #include "config.h"
>
> #ifdef HAVE_LIBCAP
> # define TST_NO_DEFAULT_MAIN
> #endif
>
> #include "tst_test.h"
>
> #ifdef HAVE_LIBCAP
>
> #include <string.h>
> #include <sys/wait.h>
> #include <sys/capability.h>
>
> int main(int argc, char *argv[])
> {
> ...
> }
>
> #else
> TST_TEST_TCONF("System is missing libcap");
> #endif
>
> But if you prefer to original version (define main), then TCONF should be used.
>
> Also #define _GNU_SOURCE is not needed, it should be dropped.
>
> If you agree, I can merge it with proposed changes.
>
> Kind regards,
> Petr
>
--------------Lp7TTsAjJawB06IWz5F0z0QT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi Petr,</font></p>
    <p><font size="4">sure you can merge. Thanks!</font></p>
    <p><font size="4">Andrea</font><br>
    </p>
    <div class="moz-cite-prefix">On 4/19/22 09:22, Petr Vorel wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:Yl5jM+a7yGtVpaIG@pevik">
      <pre class="moz-quote-pre" wrap="">Hi Andrea,

Reviewed-by: Petr Vorel <a class="moz-txt-link-rfc2396E" href="mailto:pvorel@suse.cz">&lt;pvorel@suse.cz&gt;</a>

2 small things:

Actually adding one more #ifdef HAVE_LIBCAP
might be better than calling tst_brk() manually (this is better than my previous
suggestion):

#include &quot;config.h&quot;

#ifdef HAVE_LIBCAP
# define TST_NO_DEFAULT_MAIN
#endif

#include &quot;tst_test.h&quot;

#ifdef HAVE_LIBCAP

#include &lt;string.h&gt;
#include &lt;sys/wait.h&gt;
#include &lt;sys/capability.h&gt;

int main(int argc, char *argv[])
{
...
}

#else
TST_TEST_TCONF(&quot;System is missing libcap&quot;);
#endif

But if you prefer to original version (define main), then TCONF should be used.

Also #define _GNU_SOURCE is not needed, it should be dropped.

If you agree, I can merge it with proposed changes.

Kind regards,
Petr

</pre>
    </blockquote>
  </body>
</html>

--------------Lp7TTsAjJawB06IWz5F0z0QT--


--===============1668634657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1668634657==--

