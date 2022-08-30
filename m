Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66870ECAAD4
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 12:39:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B6DB3CA6E5
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 14:39:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1562B3CA683
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:38:53 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 727651400337
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 14:38:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9hWtj8fPJe8kvbQFTGUOspFo56ZAW6Jt571ULZrRptQ6XjT67HRIUpSm9viidL3OjZLkqbrNmZmTecYbYZgxD2f5sXLyuN3ls4V8IVT1+6qNcQReK+MFNEe+P5CK7glyM6h9KdR5JJFh1pcz4eKu5Dw+Ssu/4iq+2i7pQhz0MjixN34xAQ3G6cceM6cSxzDXlWdsHNs2CLPxAWkRTQxGA+PPwIJj0Fxhj8DkkNJkzuWxWebJb3Tzd/AJUhBGzOdxxlmft1arnYc70NaFy7LAC289cSl3MN1lLSCfFKSUWdD1t82bzFX7arZyztJ1jjsGOcm1txgrYlyKbBUAy0xmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIzeBOZY2clnsYbCq2n18fZhFLz8sXyfJCPB4sG/A6A=;
 b=DP03uRpIxK44H610H/68neA4IRWTrTBd3hm9Y6V1/KJpNowPQtBLdUI5e8rqedH19UurQcIQrsJjeR9Q2jmSfsN76fKDGFj+2CcBG5X+MfqHKMmYPluLGQ8aWquWeBdOV3bcrp+oxJqq/S/D5jzuRi4DkJJcig7EZNMWymLGEo7tqTt1doxJxb3pxgTmzx3aNuSX8DiF/HZatfuqeHpqhhP3sxRKUX91UTl5UNkLmBTA/2+6dBfxbyjoqN+32zeTuCU4jXhO4fN69i7+uuYZc5YpjWh1S4KZxn1hY4TVrLLp1H7FhdZnk1HNAj1WjyoxGwDqV2Ned29GCQcyJ6Hyrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIzeBOZY2clnsYbCq2n18fZhFLz8sXyfJCPB4sG/A6A=;
 b=KOOaeM7r6xcgdJnS1JtJbqzG2+/Dn7ZJOYGM45/5DQgOd1C1rlm21kvIOGYxW+PywocZavt+AtA7pKJ+mhHGBZm7itIIMeLHXHPWuilb9lYB+hUtkejtMri7m8ZHRIo7ddlpqy6YUB5GCTBEN3zuViD4BBLekD+LUizQNs221ZkXGmKKt3X8hP7QmyYICQmwsp2Zkw8GdGh9GoYrpAsf1ea0tK4J8a1I9K/Kv4MvAPiH8PwGMXxM7RrKjiXhN86t+ikJyBBVZHO53LCHXE1Iq8jjhAeFjIhSeQ0VIsGMzUQyf4R1kyZx/Z6IG0lAfKlWrrUw3sx9d7ckedblSYHrRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by HE1PR04MB2972.eurprd04.prod.outlook.com (2603:10a6:7:1e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 12:38:50 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 12:38:50 +0000
Message-ID: <5ee4f395-e561-244c-3fde-fcb7cd1e5419@suse.com>
Date: Tue, 30 Aug 2022 14:37:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: ltp@lists.linux.it
References: <20220830123542.1912-1-andrea.cervesato@suse.com>
In-Reply-To: <20220830123542.1912-1-andrea.cervesato@suse.com>
X-ClientProxiedBy: AS9PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::16) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 443f069f-e348-40c2-e0c1-08da8a849705
X-MS-TrafficTypeDiagnostic: HE1PR04MB2972:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xill8Qxzx5IiN+h+2wf+eGOQ6jmWgUqzCa3vcCdFDZNVtg7KTRd69bxDsR2DUdogdtV1+ewns6XSRsaGlmovIak+ktJG7pEa9/D+VjmekupaZK0JIHSSZxTKMv2vAwN+j4sHP8JqL9tJaFz/S/NmfDxx52wkwoGg02t5lc+eXKmAnEeTElhsUbh6VYxieya4X8OgHXzfLh+U0pp3yJpSczOMxoJj0IQ04gWZeqvt+g0yQU3HOkgEnj5UJ0T8U1lrxEWqdsDulyEXXrlXIWjKPiC10g8ox3nzdvGbIDW4WhRTgQ4hK9Y+rr5TOSnswJigyzbZsAhYBCvf7uoidOQowJ63i9ZiyGjEuEQXB6PWVhnE2ormTVxy2btBpgFqzhd9oJCmI+3zkkN1Nsc3tvlW0NwTFzn2CzKWMH90NaiBb+Pa59904kDjTikEZQNuVWTS1WnRAmTL9SSX1sL/eqEJPqdcPHDK+aSoQAERxnfUgJohaobZu2l1lUu6iifA/aHtgeHkIbp7qYiQRpvv0DcTtSdAgu806/ERhy+UYotZvYuxp6gafKigVZ48Dlti89XN6FJP1oEX4FCHpBy0w0ehe+Y9dTRGKzJ4hO7veYetyuAfxH1oYHmeqfuz836gyGDjgzzFOR41diIBE6QxnUdBzs1I9lHk0y6ruY5hoHR4uOFkCumvtEDYlwTFbNxV2eRSD47NcNUxpXp3Z3y5opFZRvi6XW3pEaX9bBpR15hUq198TG7jEv3d+8y4lml5ZvdRbxqIem9snUTpgsPvdXxfJojRlj/wH/bX+Kxnakno3D2b/Gs7HK+tkLX3SB1xpMs0AThzB6G8nkqr0N1nXbyauQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(86362001)(31696002)(66556008)(8676002)(66476007)(5660300002)(41300700001)(6486002)(66946007)(8936002)(38100700002)(6916009)(316002)(2616005)(6506007)(2906002)(44832011)(83380400001)(6512007)(36756003)(4744005)(26005)(186003)(53546011)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anlDdHJTTUR5OTJZbE1USyt2K1NrYThTV3ZVNjg4RTBpSWhrZlVEak5uaUdL?=
 =?utf-8?B?S3hWN0xJbDhvbjZBbndLOVVIdk1QVGxxeUN6OFc4RE4zbVdtcWl3TEdaWUl4?=
 =?utf-8?B?K0Q0ZC95U0UxMVdrQWdJQ1JGWnRMWlpPU3R1UHoveFN6R1gvZ3ZKeThZWVlD?=
 =?utf-8?B?bGp3M0NaMXBnZkxiNE84NThZTGVPeDhxeHNFNlVmYzI4T0NzQTJJWWtFeGY1?=
 =?utf-8?B?SlI3aVhIeXR5ZVBMdE9LYVU4NjU4aDdkTWRUeURZSlJuOUNzZ1ZoMFBRMGZK?=
 =?utf-8?B?R1pxU0RHUnFpOG5HYjYvRDNjSUo4b0JkZERKNUR3Z2hianZxTlNKdFlTQmpo?=
 =?utf-8?B?WklDN1I4SkdWelFxZjJaeHJaZUU5SjUvbnVTK0ZjRG14QVlYVWk2ZVp1RlV3?=
 =?utf-8?B?Q0hrU2EvbmVTR1Y2U0xicFUrSEJNTlliekpQaHBISG9qN2wrUEdQdDFOUXBC?=
 =?utf-8?B?ZDRONHNZVlNoem9ZUFRsQVFLQ2NrazdZTVJwREQxREozbnY0d3BzaUxjOTJU?=
 =?utf-8?B?bVFhZ3J2V0crZGZITUx6K051aldBM2kybXNpa2hPM3k4QUtncGtOUjUySmQ3?=
 =?utf-8?B?ZHk3NmdkOE83L2lncWNxWXJnNmFyV1JFa0xsaUcrL3R5c0N1blNTK2hjMXpW?=
 =?utf-8?B?ZldSM0YwT2haQVZZdkErVHAvREVXdHMyOW1UeEVJdWJuQmcvMHdOSWEwQnln?=
 =?utf-8?B?d1dEUDRsTU5xN3JiNXBrdDVBR0ZVcFFOWkpCeEh3NDEyUmliaTlGSHM0VHli?=
 =?utf-8?B?TERJWFpzVngwM1FPOW44RnBJQnV6WTRiSkVPcVRrenBjanJXK2N1TWU5cUVY?=
 =?utf-8?B?TWdrTFUrSTJmMkhmZ2JmSkxKK2FtM2lyVTlIaXBYcCtyWmNKNlFHV1F0V2Jy?=
 =?utf-8?B?aWVRSFdueGVucnpKOEZnZGw2dTNrUEViQjE2TkRQSHpweXpVQ09uVnZaeFJU?=
 =?utf-8?B?MnV5TlFHR3VXQW1va25KQnQxYXlnNE1xQ1JJS090QWJ1a2FYTUhGanBvcHZy?=
 =?utf-8?B?STZkOGo5Y2doZkc4OFA0SHNESnFnU2Z3YjhlZld6K1hLVGliSFdPSE1ZSEE1?=
 =?utf-8?B?MUIwV0pyOUtWRkhJNWZHUnBIdzVkZGNtVFRFSTZDdk5YWU5VU09zNzN2enhO?=
 =?utf-8?B?WkNQd1Z3eFFTd2dEdi83K0RJaWxvaXQzZ1p3TkdqWTJ2UTJGZ3JYaU5ZWlhi?=
 =?utf-8?B?U0RhMGRMenhNSnZiYjdMTGZCVEtBaVVxMDFtc2xld1k5QmNwVVFicjNqYzJJ?=
 =?utf-8?B?SElBSzF0a2g4UHIvNHAwMEhWUkpCc3FVenpmN1k1TlEzb2VqNGtmRUV5bGVy?=
 =?utf-8?B?SFdGQWUyazRiaitXSG16bUN2Yit4QWlTRDF6am9CaENQM2l5Szl6YVhmcEhP?=
 =?utf-8?B?NFZKVU9xU20rZUl6aGFFU3l6dGMzMUh3Sk1UVmFnbVB0c3FaOXkydlF2b0o2?=
 =?utf-8?B?TExPQmZEVVlWRUhqcHJZdnhWLy9VdTM4eHhiV0JYMGp1N0Z5N3k0d0RZS3NY?=
 =?utf-8?B?WTJwcjRJQTBUUDRhTnB3ZVlwTkI3RTl2MFBQR1QycjFMbUJZMXFHN0s5bmJq?=
 =?utf-8?B?RXZNUEsrUXhMQ0Fyb2t2K0Nxcll2TlFnUzFadERIQjZlM1VEZmh6VEdIbmw4?=
 =?utf-8?B?VWxLTDFjd1VvTlBtV2pGT0RyWnpvMmJjSTJRdkhnZ1V1QVRuUEo3S2lYakZa?=
 =?utf-8?B?dTZLNklicGw2TUdUNDZHQ0h3MCtEWlhQb1NWQVhmejBJR3R4TjhCaS9ORGdO?=
 =?utf-8?B?cmp2WU9MMFgvVVE5RzBqKzdFNk1tblJzS25SYWtNRXFLZW9wQnZIMFZnRjN5?=
 =?utf-8?B?MUZmTVBUeVNiVnZhaFlyNlhJRlVrREhpcHN5emdxT2s1YjlxdktiaCs4ejdM?=
 =?utf-8?B?UGkrdlRTZHBrT3lyYno1N2ZGV0JNT2hlV1NtRmVPVzg4OTY2MnJVbjhVTDBm?=
 =?utf-8?B?S0cvU2Y0RkR4b2g3R24vd2NNRXMwcjg2MlNiamdvRlRrVUd2a0tTdVR6OS9C?=
 =?utf-8?B?eE5XaVJDZ0ZxdmdNRmF2NXRGWnM3aEloOS8wQ0hPWGdWOFdVeTdOb0tqSzdi?=
 =?utf-8?B?VXdtbHdRSUwwaEtoTHE4MkpvZXM1RXQzci9XYkN1N2FNVTd3ZDMra2lKdUFZ?=
 =?utf-8?B?ZmRKUUl4bFlwbUJlTzhPdWlRRUF3ZGxFS3V5bm1TMkVCc09pb2s2K1g2TVI4?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443f069f-e348-40c2-e0c1-08da8a849705
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 12:38:50.1657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aQK2hroAjWynIRTolHkUb+UhmXYP0fVV54oRdMY4CbCWiUBeGdKG+6vViceTRCF3WDRIJx6iIG3T3J3kuHYVDrcr1jjcnHUMQYWBZOAvQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB2972
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Improve safe_setxattr error message on ENOTSUP
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, please consider v2 and not this one.
Thanks
On 8/30/22 14:35, Andrea Cervesato wrote:
> According with setxattr manual, ENOTSUP is related also with an
> invalid namespace/name format.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   lib/safe_macros.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index a5b6bc504..5671f66fb 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -1011,7 +1011,7 @@ int safe_setxattr(const char *file, const int lineno, const char *path,
>   	if (rval == -1) {
>   		if (errno == ENOTSUP) {
>   			tst_brkm_(file, lineno, TCONF, NULL,
> -				"no xattr support in fs or mounted without user_xattr option");
> +				"no xattr support in fs, mounted without user_xattr option or bad name format");
>   			return rval;
>   		}
>   



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
