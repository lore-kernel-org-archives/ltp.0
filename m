Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF85C433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:26:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58A3F3C55FE
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 14:26:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA4C23C5384
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:26:00 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EA95710006D2
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1638883559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Upt9FsMbXD+1Vs6VvqshY5aoG2184n8o8vIt4Z4SWXU=;
 b=eL2WLEeiordATZatn1OREguig9wQUKB1hTwvEXKet33ZyRlHgStJgtBDVWnz+wZ7E4NUJy
 HwcAJSCvW09ICrNwkUtdOOSEt2bK6e6H32IlKrfl8zdeyOu9mbFimLLFuesOTaGWGKYdOh
 pht9eUBcZRJZ6S1oyPzhXU2WwNTNz/w=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2107.outbound.protection.outlook.com [104.47.17.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-W-1ZxnmeMB-SlfOybpXxFQ-1; Tue, 07 Dec 2021 14:25:58 +0100
X-MC-Unique: W-1ZxnmeMB-SlfOybpXxFQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj5oD1ox/DXSwkTIVBoO4xMccMyH8+xsue+5b+JA7aTJxh+OtoYmp1rKX8ihAGaEDif3lHsrfyJIZ7pJfHFenBcaTWT/3inFMFzTr4fvK/Gprs/R+wQaTjQp+3bCn42bPUCwzREVPjs12UCKOsFtwrpm4HTJNsJyBEBpHLJ7kT4JSO1i9Dad98uTKm2sII9ENHd6DLFuXOBlrycK+zsfqYq7S5FtIYFjJlLlJ6jXW9pTzzCBH7qVQuSLR3UIAA3Khzc84GwpySzB4w4cnJfRfJNrLwKq/yp/IcTEVzQxSuEI+QFbivNiAviF6zSGygI7cyf/Gs2e+zAElC1oOKl9WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Upt9FsMbXD+1Vs6VvqshY5aoG2184n8o8vIt4Z4SWXU=;
 b=bpPUKu7RwXsv4kUGFAPP10HZnZ8p8XX+FyIloDyEDSD2HNDNItVZg46lVq/nIGjeSUfa1TiiBkp6cnB6GeUodTU4bK3gasPUeyrN7Y6ll4RrI/lI/rvPjmJHA8z09ilXop0AjUmE+mVZ9jqxTR/noTwrOMqOQmZDUyuRSxvosQ69VeBA7NM48E8JZhgditrxDWh9zvy0a6uxdO1AoEIxZklVSoNTw/dO+SBWYLQwuVYnFw0tAoEM2YSeG595Dys+4ACK7F/0x1GJ6gD8HSaiwlwuzDgUTjuaRCJwQzE5h6BP3sGsxJ6kx0+LQr5TMJywZbspnCeUVhHfDivuRvn0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM9PR04MB8666.eurprd04.prod.outlook.com (2603:10a6:20b:43d::21)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 13:25:57 +0000
Received: from AM9PR04MB8666.eurprd04.prod.outlook.com
 ([fe80::7dd3:352c:e8a5:1a8c]) by AM9PR04MB8666.eurprd04.prod.outlook.com
 ([fe80::7dd3:352c:e8a5:1a8c%9]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 13:25:57 +0000
Message-ID: <9b392e05-385e-e1ca-45d0-72ab7b90ea64@suse.com>
Date: Tue, 7 Dec 2021 14:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To: ltp@lists.linux.it
References: <20211207132416.10050-1-andrea.cervesato@suse.com>
In-Reply-To: <20211207132416.10050-1-andrea.cervesato@suse.com>
X-ClientProxiedBy: AM6P195CA0097.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:86::38) To AM9PR04MB8666.eurprd04.prod.outlook.com
 (2603:10a6:20b:43d::21)
MIME-Version: 1.0
Received: from [192.168.1.29] (151.81.118.44) by
 AM6P195CA0097.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:86::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20 via Frontend Transport; Tue, 7 Dec 2021 13:25:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11e7eddc-0a25-44e1-0646-08d9b9851a2e
X-MS-TrafficTypeDiagnostic: AM9PR04MB8857:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB8857F82F885BDE2002525275F86E9@AM9PR04MB8857.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WiRLiYKWovFr1EX4I7uhZzB2YTjIbgqiTm9iCYjIyFlb7MsoNf47Qw8eZqjROmP/jCM1uJxboWFirT1zPaN9UKWnKYCUgEIfPNTtG9ZYMn/uFug0mm04gb7cXgK5Lc1mrQh53fon6VYpE5w3G4X6nybov9HKZ3vLtqWyEe48vsvieycp76b4nxaRiI9DZwljzQFgOFFca4i+KitXYa1jCImqZhaDiK2T5wXlD6JLWG5thbMrrXWbJwefnfGYWII9DNmiRTN3+uvEm1NIHrbOGwCfrAhdVx5Iy9GapoVRjdUyzFLTSBO1uIBtjHsQTsbbYDLTIBXF3f6VVGVPR1Ysjawk1DpfAAVPdLP9NY3LqD64xwexab7ZmLYB6Dn2D8FvdsISKkAQPZMNv4pS3cPTrUy6Nuwm+PGcC6vKYI6HIEaBToYWqNS7DeQ8+FhWRi5ZXnspUr6n8ISGe/fEkLI9MAkRCZ8jBAPywoDBamBMoBe5EtF1FHMKtk/ycVD9nByypH+poa2wjJIdTlb3dF4dUqDHiNhAJlNr0SP5ET8GMycJN28qwmmMyG1LDkufdX9CILf6WGwdHNAfsBz+qFexVdlJ95FXbg4RCAFFO/ciW16vJQVAfFNaXZ35rGQYIvx4JqSKXzYr/CAQJTc+etd+OZMGoPG+c4NkIsV98/KJpDDkI9T6Mxn16+fRvnV9x0zsPL1hR1IVn+/MwtSjwWzF7nQWSIq+a6dM64YtRvu7MJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8666.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(33964004)(8676002)(36756003)(6486002)(316002)(8936002)(44832011)(31696002)(31686004)(86362001)(956004)(66946007)(66476007)(66556008)(186003)(53546011)(2616005)(26005)(38100700002)(83380400001)(6916009)(5660300002)(16576012)(2906002)(508600001)(30864003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEF4RkRaOHNrM0tZSGViTTJXNWVBb1V4T0ozcVNmRjJXamZBUGthRnAyc1lR?=
 =?utf-8?B?V3M2Znd3YUt2ZzN5ZXdWZURDUGpaZWpOamlHanY0Z2lLNXRNd2dZK09JNTVD?=
 =?utf-8?B?SjYzeHdOenhzZ3dTN2xnbG1FbENwNS8vdjNvYno1cnB3U0lFRHZhZ1MvU0dk?=
 =?utf-8?B?WmVwSm16L05NSTI1S1FZb3B3RVMzLzFCMGs1S1FSVDdIRlhSSGkybnpnYzFP?=
 =?utf-8?B?SEk0WFFjbGdvWko3aVhod1VaNGZsclY1UnVkdmRySFlwY3JlaGwyK0NEWXdK?=
 =?utf-8?B?amRNald4OUZSR0kwRU1vb3A5Rm1hNFZmS2RmUVRqUkVRbmRXY2hsbzkydjlG?=
 =?utf-8?B?ZTdIK2E0Ujc1R3c1QXhiVkVaeTJWTEtBSmRNUWZETm45S2ZDSUZ4WHd3M1Bl?=
 =?utf-8?B?R0xwZmUraFUvL1RkSFI5emxLNWNPakFDbHFVcDBUeG4zazJKZm5WTzVoZ3hD?=
 =?utf-8?B?c2hyeFdZM25kQ0gzMlBJaDBLYjAweXk5Q2I0cE92YnY4cFVuTnlqNVVuL0FH?=
 =?utf-8?B?Z294K3AxbGlMalUwTTRoVVVxcDdXdy96OTNwbWVCVHk1ckdycXl6d2tvQ0RY?=
 =?utf-8?B?aFozcHdrR0RBdGM0UkxMRHQxRWc4V2pSUExPVmlrR0dpeU5RS285blBxVyt3?=
 =?utf-8?B?UVQyZEJQTHAwUExKL1dhWlNiM1g2Ty9WczFxVm1DbHlUV01kem4zbUhMZTJN?=
 =?utf-8?B?OG00cUpiTHpYamo4RUlIYW9DL0NTLzN2VjY5bUVQNU1SS0h1RXkzVjIxckZu?=
 =?utf-8?B?S0NzemZhcDN2NitoR2xUWENRMFpZV2ZKRFkyRVo4VXpwVnUwbDNyaVlYWEg0?=
 =?utf-8?B?Yk9rTkZ0VXBlMW1BQkFzTUdvRTBhOFh3VUllQi9yS3d5dnJqK2VmRzh1NCtD?=
 =?utf-8?B?Y29iM0hKUHNrNnNsSHFNYW9MblIxb2dUMjZOT1g2b2F2TTVjQ0YxSUlwNmtr?=
 =?utf-8?B?LzRyU1A3QkVPUFVSUXJuMGZacFhPajJIZU9mU0hjT3lkVFRrWng4TjlUMUho?=
 =?utf-8?B?bEg2WVRsckY1Qm15SUNyYlRtWjF2RE41SGNaS3BDekEwYVNoVWFNYk9NWmt6?=
 =?utf-8?B?RkdQaWFQblY2OVRIdkxONEZ1aThIWFBaeFBRMkF5WEx0OVVVTEJSSzRvY1BX?=
 =?utf-8?B?Q1hlS0Vxei9nTkxoWVlCRytyRFpMWHZROWFrQ1lINGVCSG1wbmJLNHZobERL?=
 =?utf-8?B?d2xFLzViYlhsMWVWd1lCS1dPMXZBN0g0Ukx6a0gxenpiWGFtdjBIN2krMUc4?=
 =?utf-8?B?UGFaMDJzTG5TOXdsbERITmtBNndrV1VjbFBVakJwV3F1TUNmT0Z3ZWU0RkI1?=
 =?utf-8?B?aTBPUVB6QS9Uck1YZkYvd0xLWEZxbWZBMWtCL1QyeGtQNDlCTUYvOTJUbGpE?=
 =?utf-8?B?M0g4U3Q4eGZCQmFhWE4vWUhHc2VSRElJUXBvWHFqWkE0QkY2Qjk2VFdaL0s2?=
 =?utf-8?B?QlBHaDMzVEw0TzBjWDRFU1p4Z1pjMmw2dzBCMm9JQ0xiazgrYmJmeGNhanE5?=
 =?utf-8?B?eVh6dFJHdmw4UkVlVk5FV2wvS3hOY1lNbDBRZmxyaVA5ZythTXlocTd1SGxo?=
 =?utf-8?B?eTY2UWFLanZqVWk5Rm9BVG1TWnBBa2tUYWRUUFJNSWkwVHE2a1Z5UWdQRmxu?=
 =?utf-8?B?TjZwZ1RUVzU2Rnk3eDR1UC85TVJFZDRvQlNvV01JTmJDVXNVL0F4Q1lSY0xp?=
 =?utf-8?B?emR6Y0M4ZStWNXlQcmc3WG01MUFDQ2w0R2svVUVWdFRSMFkzSGNkalNGU3d3?=
 =?utf-8?B?bVRLS2lja0hlZGdhZHJWV2dqTHBpQ2pZZmwwalY5d3NlRWMzcGpMcVVZZk9a?=
 =?utf-8?B?eTBNQVZ6RFp2elQvWmVRNEhmeGhUT2lTMW0zcDVzYlc2SWNwMWlGdUpRMkth?=
 =?utf-8?B?cFlmdjc1T0JIYTBmZzJvTFV1TDJST3YxbkdKaHRpRzkwR0phQlkzVTZCVyta?=
 =?utf-8?B?THJkREVuOUNvbTBWWjRJUE9JUno5N2xBdWpvcDBqTDNKdWR0QUptTDhyZXgz?=
 =?utf-8?B?ajZlaG4yWFUyeGVNdWZJdFFwNE1UclNkYkI4ZE5qd2RCL3ljZzNjUzRBM21v?=
 =?utf-8?B?OXYrbVZ3WWRaNlJtbTQxVGR6UEFrcUVHbjJNdnFHWWZaU3ExK3NiMnJ5cjN1?=
 =?utf-8?B?SDNsRHNvdEJZTHZoVnJseTd6WnJJUlRndGlTQlZFanZzNC9tcnZ0SXQ0MHVF?=
 =?utf-8?B?Z3ZzRDVFVHNYRTBkcjBYWW9qT2JqaEZuREpvOTMzb3ROREFyOVkyc0w2RjRz?=
 =?utf-8?B?UUJFNW4zb2RTc3dZR21KT1duV21nPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e7eddc-0a25-44e1-0646-08d9b9851a2e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8666.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 13:25:57.1246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jeyiCE/powFMiCE0vrnfMGcktm9k4SEYofRXFXN7adtMKhbcd5iQt5auan6XvaoYVNJkNxIb/S8t6qnkprdgDiMRuuSNxqVRDQALg7Y0X0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add tst_parse_filesize functionality in LTP
 test API
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
Content-Type: multipart/mixed; boundary="===============1725157457=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1725157457==
Content-Type: multipart/alternative;
 boundary="------------E10ObqrXHV54bpfIwKpDcT8r"
Content-Language: en-US

--------------E10ObqrXHV54bpfIwKpDcT8r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, please don't take into account this patch.

On 12/7/21 14:24, Andrea Cervesato wrote:
> Signed-off-by: Andrea Cervesato<andrea.cervesato@suse.com>
> ---
>   include/tst_test.h               |   1 +
>   lib/newlib_tests/test_tst_test.c | 122 +++++++++++++++++++++++++++++++
>   lib/tst_test.c                   |  41 +++++++++++
>   3 files changed, 164 insertions(+)
>   create mode 100644 lib/newlib_tests/test_tst_test.c
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index c06a4729b..450ddf086 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -122,6 +122,7 @@ struct tst_option {
>   int tst_parse_int(const char *str, int *val, int min, int max);
>   int tst_parse_long(const char *str, long *val, long min, long max);
>   int tst_parse_float(const char *str, float *val, float min, float max);
> +int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
>   
>   struct tst_tag {
>   	const char *name;
> diff --git a/lib/newlib_tests/test_tst_test.c b/lib/newlib_tests/test_tst_test.c
> new file mode 100644
> index 000000000..8ee4e2932
> --- /dev/null
> +++ b/lib/newlib_tests/test_tst_test.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato<andrea.cervesato@suse.com>
> + */
> +
> +/*
> + * Tests for tst_parse_filesize.
> + */
> +
> +#include "tst_test.h"
> +
> +static void do_test(void)
> +{
> +    long long val = 0;
> +    int ret = 0;
> +
> +    if ((ret = tst_parse_filesize("1", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1);
> +    }
> +
> +    /* small letters */
> +    if ((ret = tst_parse_filesize("1k", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1024)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1024);
> +    }
> +
> +    if ((ret = tst_parse_filesize("1m", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1048576)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1048576);
> +    }
> +
> +    if ((ret = tst_parse_filesize("1g", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1073741824)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1073741824);
> +    }
> +
> +    /* big letters */
> +    if ((ret = tst_parse_filesize("1K", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1024)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1024);
> +    }
> +
> +    if ((ret = tst_parse_filesize("1M", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1048576)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1048576);
> +    }
> +
> +    if ((ret = tst_parse_filesize("1G", &val, LLONG_MIN, LLONG_MAX))) {
> +        tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        if (val == 1073741824)
> +            tst_res(TPASS, "value is %lli", val);
> +        else
> +            tst_res(TFAIL, "%lli != %lli", val, 1073741824);
> +    }
> +
> +    /* test errors */
> +    if ((ret = tst_parse_filesize("k", &val, LLONG_MIN, LLONG_MAX))) {
> +        if (ret == EINVAL)
> +            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
> +        else
> +            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        tst_res(TFAIL, "tst_parse_filesize should have failed");
> +    }
> +
> +    if ((ret = tst_parse_filesize("100", &val, LLONG_MIN, 10))) {
> +        if (ret == ERANGE)
> +            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
> +        else
> +            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        tst_res(TFAIL, "tst_parse_filesize should have failed");
> +    }
> +
> +    if ((ret = tst_parse_filesize("10", &val, 100, LLONG_MAX))) {
> +        if (ret == ERANGE)
> +            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
> +        else
> +            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        tst_res(TFAIL, "tst_parse_filesize should have failed");
> +    }
> +
> +    if ((ret = tst_parse_filesize("10garbage", &val, LLONG_MIN, LLONG_MAX))) {
> +        if (ret == EINVAL)
> +            tst_res(TPASS, "return code %d (%s)", ret, tst_strerrno(ret));
> +        else
> +            tst_res(TFAIL, "return code %d (%s)", ret, tst_strerrno(ret));
> +    } else {
> +        tst_res(TFAIL, "tst_parse_filesize should have failed");
> +    }
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +};
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index a79275722..78b107ed0 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -679,6 +679,47 @@ int tst_parse_float(const char *str, float *val, float min, float max)
>   	return 0;
>   }
>   
> +int tst_parse_filesize(const char *str, long long *val, long long min, long long max)
> +{
> +	long long rval;
> +	char *end;
> +
> +	if (!str)
> +		return 0;
> +
> +	errno = 0;
> +	rval = strtoll(str, &end, 0);
> +
> +	if (str == end || (strlen(end) != 0 && strlen(end) != 1))
> +		return EINVAL;
> +
> +	if (errno)
> +		return errno;
> +
> +	switch (*end) {
> +	case 'g':
> +	case 'G':
> +		rval *= (1024 * 1024 * 1024);
> +		break;
> +	case 'm':
> +	case 'M':
> +		rval *= (1024 * 1024);
> +		break;
> +	case 'k':
> +	case 'K':
> +		rval *= 1024;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (rval > max || rval < min)
> +		return ERANGE;
> +
> +	*val = rval;
> +	return 0;
> +}
> +
>   static void print_colored(const char *str)
>   {
>   	if (tst_color_enabled(STDOUT_FILENO))
--------------E10ObqrXHV54bpfIwKpDcT8r
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font size="4">Hi, please don't take into account this patch.</font></p>
    <div class="moz-cite-prefix">On 12/7/21 14:24, Andrea Cervesato
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211207132416.10050-1-andrea.cervesato@suse.com">
      <pre class="moz-quote-pre" wrap="">Signed-off-by: Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
---
 include/tst_test.h               |   1 +
 lib/newlib_tests/test_tst_test.c | 122 +++++++++++++++++++++++++++++++
 lib/tst_test.c                   |  41 +++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 lib/newlib_tests/test_tst_test.c

diff --git a/include/tst_test.h b/include/tst_test.h
index c06a4729b..450ddf086 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -122,6 +122,7 @@ struct tst_option {
 int tst_parse_int(const char *str, int *val, int min, int max);
 int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
+int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
 
 struct tst_tag {
 	const char *name;
diff --git a/lib/newlib_tests/test_tst_test.c b/lib/newlib_tests/test_tst_test.c
new file mode 100644
index 000000000..8ee4e2932
--- /dev/null
+++ b/lib/newlib_tests/test_tst_test.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
+ */
+
+/*
+ * Tests for tst_parse_filesize.
+ */
+
+#include &quot;tst_test.h&quot;
+
+static void do_test(void)
+{
+    long long val = 0;
+    int ret = 0;
+
+    if ((ret = tst_parse_filesize(&quot;1&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        if (val == 1)
+            tst_res(TPASS, &quot;value is %lli&quot;, val);
+        else
+            tst_res(TFAIL, &quot;%lli != %lli&quot;, val, 1);
+    }
+
+    /* small letters */
+    if ((ret = tst_parse_filesize(&quot;1k&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        if (val == 1024)
+            tst_res(TPASS, &quot;value is %lli&quot;, val);
+        else
+            tst_res(TFAIL, &quot;%lli != %lli&quot;, val, 1024);
+    }
+
+    if ((ret = tst_parse_filesize(&quot;1m&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        if (val == 1048576)
+            tst_res(TPASS, &quot;value is %lli&quot;, val);
+        else
+            tst_res(TFAIL, &quot;%lli != %lli&quot;, val, 1048576);
+    }
+
+    if ((ret = tst_parse_filesize(&quot;1g&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        if (val == 1073741824)
+            tst_res(TPASS, &quot;value is %lli&quot;, val);
+        else
+            tst_res(TFAIL, &quot;%lli != %lli&quot;, val, 1073741824);
+    }
+
+    /* big letters */
+    if ((ret = tst_parse_filesize(&quot;1K&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        if (val == 1024)
+            tst_res(TPASS, &quot;value is %lli&quot;, val);
+        else
+            tst_res(TFAIL, &quot;%lli != %lli&quot;, val, 1024);
+    }
+
+    if ((ret = tst_parse_filesize(&quot;1M&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        if (val == 1048576)
+            tst_res(TPASS, &quot;value is %lli&quot;, val);
+        else
+            tst_res(TFAIL, &quot;%lli != %lli&quot;, val, 1048576);
+    }
+
+    if ((ret = tst_parse_filesize(&quot;1G&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        if (val == 1073741824)
+            tst_res(TPASS, &quot;value is %lli&quot;, val);
+        else
+            tst_res(TFAIL, &quot;%lli != %lli&quot;, val, 1073741824);
+    }
+
+    /* test errors */
+    if ((ret = tst_parse_filesize(&quot;k&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        if (ret == EINVAL)
+            tst_res(TPASS, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+        else
+            tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        tst_res(TFAIL, &quot;tst_parse_filesize should have failed&quot;);
+    }
+
+    if ((ret = tst_parse_filesize(&quot;100&quot;, &amp;val, LLONG_MIN, 10))) {
+        if (ret == ERANGE)
+            tst_res(TPASS, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+        else
+            tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        tst_res(TFAIL, &quot;tst_parse_filesize should have failed&quot;);
+    }
+
+    if ((ret = tst_parse_filesize(&quot;10&quot;, &amp;val, 100, LLONG_MAX))) {
+        if (ret == ERANGE)
+            tst_res(TPASS, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+        else
+            tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        tst_res(TFAIL, &quot;tst_parse_filesize should have failed&quot;);
+    }
+
+    if ((ret = tst_parse_filesize(&quot;10garbage&quot;, &amp;val, LLONG_MIN, LLONG_MAX))) {
+        if (ret == EINVAL)
+            tst_res(TPASS, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+        else
+            tst_res(TFAIL, &quot;return code %d (%s)&quot;, ret, tst_strerrno(ret));
+    } else {
+        tst_res(TFAIL, &quot;tst_parse_filesize should have failed&quot;);
+    }
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index a79275722..78b107ed0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -679,6 +679,47 @@ int tst_parse_float(const char *str, float *val, float min, float max)
 	return 0;
 }
 
+int tst_parse_filesize(const char *str, long long *val, long long min, long long max)
+{
+	long long rval;
+	char *end;
+
+	if (!str)
+		return 0;
+
+	errno = 0;
+	rval = strtoll(str, &amp;end, 0);
+
+	if (str == end || (strlen(end) != 0 &amp;&amp; strlen(end) != 1))
+		return EINVAL;
+
+	if (errno)
+		return errno;
+
+	switch (*end) {
+	case 'g':
+	case 'G':
+		rval *= (1024 * 1024 * 1024);
+		break;
+	case 'm':
+	case 'M':
+		rval *= (1024 * 1024);
+		break;
+	case 'k':
+	case 'K':
+		rval *= 1024;
+		break;
+	default:
+		break;
+	}
+
+	if (rval &gt; max || rval &lt; min)
+		return ERANGE;
+
+	*val = rval;
+	return 0;
+}
+
 static void print_colored(const char *str)
 {
 	if (tst_color_enabled(STDOUT_FILENO))
</pre>
    </blockquote>
  </body>
</html>
--------------E10ObqrXHV54bpfIwKpDcT8r--


--===============1725157457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1725157457==--

