Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56254C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 11:14:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D7AD3C0F83
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 12:14:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B7563C012D
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 12:14:33 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 000891A01450
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 12:14:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1646910872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6z2J1RzK/aKPLAVnKYSAMOvU/9v2KGGiemUkXPFthMw=;
 b=SyyUYxtuR0Gxzc/YcP3xo1thM8aVnj/kaNYF+oHeCYg6RHZdgkCsoASLe+z+4ssCodMu9+
 DguArhH5En6B+8xLzV/vczNOc1kfOIxvoqo/2XaXaGZS8HgJ1x+yzThlHx1CXa7YHFEOH8
 4MW20sHu1ygy2t9pxkmEduA+r2K/o9g=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-pENn9LoSM6mNi471JlI0UA-1; Thu, 10 Mar 2022 12:14:31 +0100
X-MC-Unique: pENn9LoSM6mNi471JlI0UA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxg/7ez0Gz6eu7Po6CPUS/UcLZ/IXxlJSNtvrC78dWcBCiIq6WkhJYKQBCBQtamCsAmwKRsgEHWMU/BuJeBl377h5ktLq+GuLgKi9v23AUpzDQYnK5g+OxSv2WFmdn73f5Wg1pA+EKoF3hJISLSDuTF/b82eIbAy+vmn6kMRjmz/nVWYmZeEA5sYZOywoSHzqR8htkAeuadqv02rH08HdJz+h662NFPg4srZ40SNDSOHGwe3d3iEBR72dncEwz2jB+j6Qor/nSH25MR0JKyGNuN5JAzUR/+vIXlzY5BQrKhT53hhUced1AQYMLJRp64Z7W+SsTx8UQRl0fJlujtRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z2J1RzK/aKPLAVnKYSAMOvU/9v2KGGiemUkXPFthMw=;
 b=BuzbzECz0CWlxf5Q/WJeBCxhVZ3ct+fwBtiSwc8Uz6BVae2Zp7ANkc5mzNSj9zsDMXgeHqoZMFl+iZZpiEXMgldwerpUK1i3sTJRzJUwlcFfwhihETQJom3a20BOF2TNxCdAYll9N2VL/vVWSsHCgkk42iX+Iefnpkodm2WZ4T7ByKzSlsOF0MD5UDtsqRq10jkJH1LHx/5med8IUxOg5hDfwepJ8hhasgEf10XmV4YW+8BfLZrXm0LWa0+CZ96QIDtgfzVjqTWI4B4lPzyeqC9z0VdZ+ESX4XHdorDtfoNhURlzuENAvC+Mk9x3/8av7p/GqLpdEYiDUrpIhLgE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM0PR04MB5428.eurprd04.prod.outlook.com (2603:10a6:208:113::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 11:14:30 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::416d:72a9:694f:f1b3%7]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 11:14:30 +0000
Message-ID: <aae6f8f7-7566-31c7-a726-38c17acb0912@suse.com>
Date: Thu, 10 Mar 2022 12:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20220211092646.23748-1-andrea.cervesato@suse.de>
In-Reply-To: <20220211092646.23748-1-andrea.cervesato@suse.de>
X-ClientProxiedBy: AM6PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::14) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67ef62b3-80e1-4d28-3602-08da02872573
X-MS-TrafficTypeDiagnostic: AM0PR04MB5428:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB5428E301FB5B7E795AD30E99F80B9@AM0PR04MB5428.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M2PVM04E7Sv6nbqHETa67VSr9rviMj2x77BIxh4nXMx+JPve6Lrjbz2Hw3KijjEC3Ip95Z96R07tziFQxfrf8FmBenlfZqnw1bh/cW58NwG4e33hEhRm6GeJBZNmcWsfLN3cANsvX/6+Q6H2s8BO9FRwkAFVHnRG02UhBym7gKJMVpR0lhp9lq+1+CniZHjZGa3auvK0zS72Z2jAorEwcJm5IkohOP7wWQSedTBybjPUw6fSNU4oHRS5zRCvI8xiIL3TTclONuY/g47JoN8chB+HOMQIIMx9r4uvqSUUUAl7wbgIv6ZxYjbnZ0PmfEQeOnZiQfmXI3WlO6bLWE91Bsu8MWYjKQeEsh/tOiO+ex0yblC7KRgDT2MJJu5WnCqCC7s0Mskr1VDeYX/hBOEPFxxVjUPTHLEu8OaLs6n55+lksHf90B3KA0UIeA+CwWTKbHrfWkpbb/dSc2WjfTL9USINs6r4ftKV8PmIaEDyjX80/yFmbDk2jgl/diH34wJ07l3GtVE71c3HbQjJVbVJ3rsvKr7YTg7vzSs9uFe+1xaEfiD2E9LfOxE6cuzsUYCr3rYaIeVYRNps2GMK0egx+0FNHbKGiIzuYQVpdtI1FtJAurN967QCTtcUj4HoYPDmyE91CF72pwcni7LYX1kzk9VGzK4CkxsT7NjefqY9n8U13pM7Z5itFGhTkaFudRjt/nQMxD4pqYKg03wzfyI+YF3r5Du7MJafr6j29umyuOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(44832011)(2906002)(31696002)(8936002)(5660300002)(6506007)(31686004)(8676002)(26005)(33964004)(186003)(2616005)(86362001)(508600001)(53546011)(6486002)(66476007)(66556008)(66946007)(83380400001)(36756003)(38100700002)(6512007)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkJHS25US3RaV243YXVwUTQ5SUpBSDBCVkxPZFJDSlVLTWthY1ZiK3ZNLzFn?=
 =?utf-8?B?Rnczd1dWMUp6Q2VSZk9tSi9aUEFlYWZSOVlIeFdwbkRIWUFtUVNVcU1IWVlL?=
 =?utf-8?B?Y01oRnRFZTRGM0EwcnZVTkpFNVhqZitKMGJCNGROS2I3Y0Nxck9MemlvOXBt?=
 =?utf-8?B?R1FMVDNVNTZqMW5UZWkzSVZJSmROSmsrYkpLTUpUQTQrMVdvUXd1OEwreFU0?=
 =?utf-8?B?b0p6MU5maGg4Q2w2T2Z0Yy93aHRKQnVOWlZEVEJtZXpQZFNrTmFNOWV0Qll3?=
 =?utf-8?B?c0JrS2xxOURRdlI4SVlXSjRFTjFpRXBLelNwYXl4WmVSZWZZYUhmeHhUbzJy?=
 =?utf-8?B?dnVoczVuUW1rVXRTUlAyeEZVZWZvcVJRcnRWRGg3YTQxUmZwNUF4ci9OUzFq?=
 =?utf-8?B?QXNiOFlYQ1IrY2hXbXZvTzI3MUVUeTlQbVdQZ1ErekhpeEVRY1ZGcHdDeUQ1?=
 =?utf-8?B?ZytWc24yTTZIOEJMcGdWUkVGOUpSait5OC9RaWlDMUxVbFRjOHdBam9Tekxt?=
 =?utf-8?B?YlZER3dTU3dwOHVWK3IxNGJ0eUJyQjhRT1VRSWxRVmxnM1I0ZTIwdTRxUjRy?=
 =?utf-8?B?Zmk5MGwvdnBHaHNPd0dlUmFCSVd3MjAyTHhNMGduRmVrT0M5Y2VlRWEvamVi?=
 =?utf-8?B?bWlxSVg3K0psb2dXdExRbTZSWForM2NKRmdRRzE2NEMvYlJEZEdNYlg5cjcv?=
 =?utf-8?B?NFFhQ0VqZ2ZrWEJ0Y2xFS1hNaUxpMENCV0p4bGxnUU5IeUp2QmI4eCs5UzBU?=
 =?utf-8?B?ZmV6SXhLZVhBWEtlMUFYRmZaMXRXNmFOeG0xUGhBTGVwNWJYam1QSm5EQXFH?=
 =?utf-8?B?RnFMTmoxRTVQRkY2SWRaNkJIT0ZiU3VWQ2UrL2l6ODFvcmpwR2dHTWxneEpE?=
 =?utf-8?B?WTZDWHkwTFY4TjY3UkxXaUd0OU5nbGl4MjNGa010djJJZTZNNU1ESXhMZUhk?=
 =?utf-8?B?SVM2Zmxkc2ZobTRka0JQdEdod2Ntb1dlOTl4NTlCR0JJeHFYbk5BMmQ2OFRW?=
 =?utf-8?B?KzA4M3lSZTgyL1YzbUZSVDg5Y2xZNHZZejdob0kxMG9zV1RMVC9kR0I3anda?=
 =?utf-8?B?ZFRSejVzSzZWQ2NXU244Mk51YStWdUt5QUxBRGRnZmhnUExnaFl6Q1NEWlpk?=
 =?utf-8?B?c2o2VlJrTWxMMTZ2U1RzUEUwR0Rnemx0eXByRjJJcC9kcmR6bTIzYmdNMzkr?=
 =?utf-8?B?dUFrSXNESVlXVGNYU0dNOThwTjNiS0N3WCsreFgwZ25ydGJ6SzkwZmx3ckx4?=
 =?utf-8?B?d2pOQkFqWXJFcENRZDIvVWZGT0xGZFZEWVhRMGkzSGxqZklJMzRBbG50UGZH?=
 =?utf-8?B?MG5XSGxVQzJmVHpkT1JDakVyNUtPeFYyVlBWVHFKUVhhMHJtbVdzOFdGUDVi?=
 =?utf-8?B?VE5IVnlpcVpNdkdPTm5PZ0NaYTFvRXFBL1ZtUldVcTB5Um9VbEhpcE1nSlc0?=
 =?utf-8?B?QmgwUjF6Q1A3Nm45Ui9hTyt2YSs2UU1DZ2dmUWZzNCt0U2NDWGJlT1pKUFRo?=
 =?utf-8?B?TDE2S0l2VmpkU2Rob1ZkSjVBbWJNd01jajFCNzFsdUsyY1hnMDl1VGpIMFB5?=
 =?utf-8?B?WHdkaklHS2lWUDUzZHFFR3d0Q3d4L1JzOWYrVnZRbG9hLzMzVTVhakJOZWtU?=
 =?utf-8?B?aC8vd3VMZkVsY251U0NVVFRiek11RUtmMG5FaG9uU0JiN2gwZ3pqWkFJVVV3?=
 =?utf-8?B?ZkNwRjJDSU1HR1N0ajRMOFFOMUsreUFuSzhUVzk0M0pvQ0ZDdXduYmx2ZFdT?=
 =?utf-8?B?bVdpcUNXZmlCUmV6eGR6VjBYSUlkYXEyUWtkSDM1dnhLTHFJRDlqOGZoNWdm?=
 =?utf-8?B?RmdnOUdxdS9oUmJQMlRGcEtYNEExU1VXajMxbTF2VTJSREdYanB6Q1FQS25o?=
 =?utf-8?B?ZzRXZnJyMGxFZ0Z0VUUyN3cyemo5T3FkRWJwamdaUVhLeEhqcWJ0Szg5Zkpj?=
 =?utf-8?B?Sy9OeUZKU1EzdkVxUi8vamx4ZDJtMGxvOXFlOEkreklLM3JSUEtQRFkzRnMy?=
 =?utf-8?B?a2s2NkZxSUxnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ef62b3-80e1-4d28-3602-08da02872573
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 11:14:29.9744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQLWZrW3UWG9RAsCrIBjylfTSNG9wqfk5b9FmcYfpjaIz80yvwMm6UPKVo4RexCrN+jcWv1diVUqdrs1FhP6P1G0LTcKzdoklvTc0yi+zzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5428
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 0/8] Rewrite userns testing suite using new LTP
 API
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
Content-Type: multipart/mixed; boundary="===============0823847710=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0823847710==
Content-Type: multipart/alternative;
 boundary="------------Z0PUj93UrPwbqltdAJc2wibU"
Content-Language: en-US

--------------Z0PUj93UrPwbqltdAJc2wibU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

Please don't review this patch-set since they break bisect build.

On 2/11/22 10:26, Andrea Cervesato wrote:
> Removed TST_CHECKPOINT_INIT from tests and replaced libclone usage with the
> internal LTP API clone API.
>
> Andrea Cervesato (8):
>    Rewrite userns01.c test using new LTP API
>    Rewrite userns02.c test using new LTP API
>    Rewrite userns03.c test using new LTP API
>    Rewrite userns04.c using new LTP API
>    Rewrite userns05.c test using new LTP API
>    Rewrite userns06.c test using new LTP API
>    Rewrite userns07.c using new LTP API
>    Rewrite userns08.c using new LTP API
>
>   testcases/kernel/containers/userns/Makefile   |  23 +-
>   testcases/kernel/containers/userns/common.h   |  58 +++++
>   testcases/kernel/containers/userns/userns01.c | 111 ++++-----
>   testcases/kernel/containers/userns/userns02.c | 132 +++++-----
>   testcases/kernel/containers/userns/userns03.c | 235 +++++++++---------
>   testcases/kernel/containers/userns/userns04.c | 129 ++++------
>   testcases/kernel/containers/userns/userns05.c | 148 +++++------
>   testcases/kernel/containers/userns/userns06.c | 175 ++++++-------
>   .../containers/userns/userns06_capcheck.c     |  75 +++---
>   testcases/kernel/containers/userns/userns07.c | 126 ++++------
>   testcases/kernel/containers/userns/userns08.c |  49 ++--
>   .../kernel/containers/userns/userns_helper.h  |  62 -----
>   12 files changed, 598 insertions(+), 725 deletions(-)
>   create mode 100644 testcases/kernel/containers/userns/common.h
>   delete mode 100644 testcases/kernel/containers/userns/userns_helper.h
>
--------------Z0PUj93UrPwbqltdAJc2wibU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi!</font></p>
    <p><font size="4">Please don't review this patch-set since they
        break bisect build.</font><br>
    </p>
    <div class="moz-cite-prefix">On 2/11/22 10:26, Andrea Cervesato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20220211092646.23748-1-andrea.cervesato@suse.de">
      <pre class="moz-quote-pre" wrap="">Removed TST_CHECKPOINT_INIT from tests and replaced libclone usage with the
internal LTP API clone API.

Andrea Cervesato (8):
  Rewrite userns01.c test using new LTP API
  Rewrite userns02.c test using new LTP API
  Rewrite userns03.c test using new LTP API
  Rewrite userns04.c using new LTP API
  Rewrite userns05.c test using new LTP API
  Rewrite userns06.c test using new LTP API
  Rewrite userns07.c using new LTP API
  Rewrite userns08.c using new LTP API

 testcases/kernel/containers/userns/Makefile   |  23 +-
 testcases/kernel/containers/userns/common.h   |  58 +++++
 testcases/kernel/containers/userns/userns01.c | 111 ++++-----
 testcases/kernel/containers/userns/userns02.c | 132 +++++-----
 testcases/kernel/containers/userns/userns03.c | 235 +++++++++---------
 testcases/kernel/containers/userns/userns04.c | 129 ++++------
 testcases/kernel/containers/userns/userns05.c | 148 +++++------
 testcases/kernel/containers/userns/userns06.c | 175 ++++++-------
 .../containers/userns/userns06_capcheck.c     |  75 +++---
 testcases/kernel/containers/userns/userns07.c | 126 ++++------
 testcases/kernel/containers/userns/userns08.c |  49 ++--
 .../kernel/containers/userns/userns_helper.h  |  62 -----
 12 files changed, 598 insertions(+), 725 deletions(-)
 create mode 100644 testcases/kernel/containers/userns/common.h
 delete mode 100644 testcases/kernel/containers/userns/userns_helper.h

</pre>
    </blockquote>
  </body>
</html>

--------------Z0PUj93UrPwbqltdAJc2wibU--


--===============0823847710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0823847710==--

