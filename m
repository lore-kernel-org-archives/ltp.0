Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FAEC433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 11:22:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D9713C9716
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 12:22:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02A763C2AE9
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 12:22:37 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.111.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 20DB61A00980
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 12:22:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1642764156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zib6nvROEyIf5UaN2MjP0IDJkd3Xcr7seE99fPH0JO0=;
 b=AYdtxLV1mR52Xpxzd1jODafijL91xlYWl0TbucdjYllqSNpntyhdSTimn3+8FGO3Qm4WO6
 /LMz8GTBn+DXnLio4ChEWxTjyvbtsl3QWsLaXENd7riKW5gHd/X6wNv9oTg5KeroM6S3Oj
 ZdKacdNdt62MXfILAEDRMy25kCE4iJk=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-XvVC7ovmPdSkHkp4YoTJCg-1; Fri, 21 Jan 2022 12:22:34 +0100
X-MC-Unique: XvVC7ovmPdSkHkp4YoTJCg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AobZxKI3GkKz60gtQsB0PqqExX2wUiCIDw7NwZs1d3T9N1ZZw8CvcxW5/kowLR/0WI/kz5Uvi+joqw0rPhdF+L0rgFZ8m5u4X7i+A4MiOGtV1GMR0EO1dTF4pMhRuQ2ZY998pA0qIaDsDT1Hb+1S/PRY8XmvWrfsI3qwP0md/3aj5na/i/o5YeYaU1bB6Y8f8u5qHk5JnWMjjhREPtoE3OYPbKD5PAl/ZKkH8xO4wKVefkXlDCYv/pfrKECHxTSnG4f9cb41P7TUM1Zks2mbmQsARXpYaq0R2UR8ypIxP4W2GW0NZR5ZbXp+pfVrvL7ypyW/WpKbNqFPLEqrLmMQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zib6nvROEyIf5UaN2MjP0IDJkd3Xcr7seE99fPH0JO0=;
 b=dKpHSjqXo9quKy1EZggj1kd4JG4wC/pOcdIaCo1eg4IjK6rruYFtlozsF9uh0JU4t4uiOhkjc91JULJ+lioZRfXH864Nrwp/QxehO5+8LgMypMtmshMm4tQqv4F6uuiQm4UjmcISvoxaRUKAYuAZD8Gt+5aKC2jn2ijclmPdFS3pqIIqrzZEGGNZYaaenLFuTCWiH0G8CSYtjQiPwSJRoRqrp1Fm+6aOY1FUG/ehNUwbDj4EWHxtAE8Df3fiZjrWHG3tFvC/MKzA6JWyjiOP7jGqeekZmiteJXEO3c/yM9trrxgsTs8cCLMb0lTtKDI/TesJcJ2RePjbheCSPzei3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com (2603:10a6:208:18e::20)
 by AM9PR04MB8538.eurprd04.prod.outlook.com (2603:10a6:20b:435::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 11:22:33 +0000
Received: from AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794]) by AM0PR04MB6788.eurprd04.prod.outlook.com
 ([fe80::1c48:b656:15bb:a794%7]) with mapi id 15.20.4909.012; Fri, 21 Jan 2022
 11:22:33 +0000
Message-ID: <fa1f5fc0-a439-c85f-6c93-a0f7feca9cdc@suse.com>
Date: Fri, 21 Jan 2022 12:22:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20220121100604.1072-1-pvorel@suse.cz> <YeqOFoxhwiZqfnID@yuki>
 <YeqOWdTJ+vNUHnzY@pevik>
In-Reply-To: <YeqOWdTJ+vNUHnzY@pevik>
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To AM0PR04MB6788.eurprd04.prod.outlook.com
 (2603:10a6:208:18e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1eee2b-f838-45a1-8149-08d9dcd05203
X-MS-TrafficTypeDiagnostic: AM9PR04MB8538:EE_
X-Microsoft-Antispam-PRVS: <AM9PR04MB85384FE48F0C2257A312A4D6F85B9@AM9PR04MB8538.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wkS0pI5huNB2AAitftMashh3Ay7UframaUqh/kVw3/a86SzJT/sVGwNjUtE6PSlPdc0/+NgHwr1ygyCgA7ZjBVY5NojeS8Te7MJz9Na2K7721WF52UuFyt4v5/IccfqEh7qhriBmUCF6glV1ObhnNREMLC6arxVpUisXcxVUZBeAx5Uc2+b+ItzMy+Y4i9gRLrpjfJwvhwrmMDGwrPbHw71lcFiCyhmS7Eb5SzMjDKX+PyyixekaAn/JhklFZ1aM3QL+fAo5Ok+4V40OsrfgCffNtGXd+/pJM/M17YeG551xCK3Z6aMHECx8jb9PA+PwjxOQ1S0R1ywMs2kBNDsk9qRh00PZ3fEW9rzIcdfJcd4c15vmQBLZNS0hfWF4jOzAJsq3M58Tb5Lw4aCAANsfAXNQfp9uEFm618UpPtcxeo0RZGV0lsGxtHuXjtXMq0TuQFXxtbODRaLI5HPArA0hO/54SN66bkoK8viA3QNb5pqPUAfcQABieBotOGkNpbA/6NoYbTQ4VikNc39IkIm8lpTVd9rgBK1+pYDLSYi+xf6Ph7wOi+DNxLk4S/r2+hJivSEP7jHfuk8YezbtXrgNLdPh21gcfx+JLld9CKMVyO990kiBLjuGZu6Bi/vJ2j19q0f4sWo9yXbzL/Cl+sAJNoijyB/Ffurqre2ZzG3z7lAvUd/safvEx7ScmkuP3KfAPDHR3kkvEqfR8JuGsR3+NleUtAyjsfSoUt8n8RXPpWpnAtrWNXBRKMfOlA6ZtdlW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6788.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6666004)(186003)(508600001)(5660300002)(2906002)(31686004)(44832011)(4744005)(36756003)(2616005)(4326008)(8936002)(53546011)(26005)(6506007)(86362001)(6512007)(66556008)(8676002)(66476007)(31696002)(316002)(54906003)(110136005)(6486002)(38100700002)(66946007)(17423001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWZ6NEIySHN5Q0R4ZGdKYVBBcm9xQldWbEF5ekNMNUJWTWlnZnFnUU5QVW9Q?=
 =?utf-8?B?N29lc2JiVzRuQ2xSVzlUc3Q3RFpkTDEzcWRHTUpJNzVZNkJDQXhzM3F4VEdS?=
 =?utf-8?B?OGxDYklSZkxZRjZSMHRUMDlmb3hId0ZSSVg5VmU5dFluMGZDMytHWTZlR0ZF?=
 =?utf-8?B?OGJ0aldSQlZqZzBWRVBjcXI3dmxNb0k2dDVjQUNFWERoUTFjc3czUVdxbFpa?=
 =?utf-8?B?c1pmZ1JWTG5Dc2ZVOGg2SXdTQ1UvZ0Zwek5Jem54RWdzcmxlcmNVenBoK0pn?=
 =?utf-8?B?Ull1RjBqSFZDcHJnZ0VaaUR1RXZGM24wMzRnUWZ2Ykc5VW4vUklBdnF0dmpU?=
 =?utf-8?B?bWZiRk43bDc2TlVKb2pUREJkM1lDaHZmWE94KzAxR2tpVTRSYlppOUp0eHBG?=
 =?utf-8?B?KzJXVzAzejh2N3dwaWxPVWN0U3dDSFpYZUUwQ1JDZCtFVUVQTmdaM05lZE9Y?=
 =?utf-8?B?UXppSlJhU3pwbGZXN2d4NUxPYlNYTllRK1AzZEE0cURsZmVramxqbUMxOHlI?=
 =?utf-8?B?YnNYL1liMVVHdjR2NVFGOWdiZUxxL2Z5ZXY5WTZmQXNPY2V1bnFxL0hUbFBr?=
 =?utf-8?B?elFwVlpVSUZsZVd2LytVbGt0U0JWSnp4enBiR25YeXAxUTVpMEFRdnh2QWtP?=
 =?utf-8?B?T2lBN0Q2ZXM5SitxR1lwdzhiMHFpYktJWjdLTmdBSmpJYnVwWktsSDAzUEZW?=
 =?utf-8?B?K0RaNGZ0b0NLNTZmUVpFNWFBaWY4WTY0K2lsbkJkSjNmRldmYTFBNi9FK0Zp?=
 =?utf-8?B?L2RZdmVzRmlCTkZleE9ZQVJuMmpUYTFUdGRBUXA3RVhhNVJNeEZOdkwxcmR4?=
 =?utf-8?B?VU1WeWlmZ3ExajVTWlJyYVMyNlp6WmJDS1NCVkFoV3ozL1l4aGgwc1NtL2Ev?=
 =?utf-8?B?Q2VBd1FGdjloelpqSlNTWCszS1Z0ekFyUFFUb2pXSjY2QXAyTnN3THpQLzA1?=
 =?utf-8?B?ekpFeVNaM3hnR0h1aWhZenhzNkpHUndOd0hQbllUbzNVdHgxSnd4cklySDhR?=
 =?utf-8?B?WnY2R05MV25RZWVST0FpVlMrNi9sbk5uR2VTYWQ1R2U3eUNsWnY1UFB0QktG?=
 =?utf-8?B?UTg1eU1DQlQ4Z3o1QXR6RWFwRnFPMkh6ci82UENmUEZxZmtwaDVtWS9vSGph?=
 =?utf-8?B?L3RRTjIxeWdrWUxjc09ENnZidENCVjZVays2dTczcXpjWU1sdjBEbnpPbDhl?=
 =?utf-8?B?QWpqajNyd0x4eXJnMHlGU1NCNWZMenB1L3V4OFlZZUQwZ0FnT0FRcEZkOUw1?=
 =?utf-8?B?eFFEMG9FSHp5bzNhNFRuY1ZPMXR5OHQ3T2ZpWHBzY01TQ3ZGRUVtVm1mYlZ0?=
 =?utf-8?B?aEtMVDhQUnFuQXBIcnpyVW5PWlY0OVB3amVrWTRRN01aYnF6V1dxMzZWbFk0?=
 =?utf-8?B?R2RlV3FIQUhaazJ3Z3BhSmFLTUJPNDNDblVyUm9yZGRFWDlZelpSNlZCQkVo?=
 =?utf-8?B?TklLSm90S2o5MTNINlAxVmZ0NmVicTBVajZiUm9GVWNjWld5YzZUaWEweG14?=
 =?utf-8?B?TkpEWWhwdnZWYmZVRTVaRDQ4N2RwM2NwZHhCVTJMc3ZsTTJFc01RYVJWdkJE?=
 =?utf-8?B?bWQ0Y2FJZHR5UTkxeFVydTY3azYyMUMvazdzN1JVZ05rMzYyQW80MTMzY0NE?=
 =?utf-8?B?UUsxaDlPdmRoVm8zSk1JRDM2M3N2Q3JUd2VmVmduTWJJQ2h0ZjkzV3JCd1FW?=
 =?utf-8?B?bmJXZ2hHeERmSW5CdEVtMU9zL0toWWpFSkV5alZybHE1OVo2TFJSL1E3WUZV?=
 =?utf-8?B?anJzWGd4ZTM2V3g5WjB3Q0pUYms2Y2R5Qm9uV25zd3FjYkZmL2xpeVRtbkZC?=
 =?utf-8?B?QjBBRG1FT1UreTVDc3M5Q2Y1Zm5IVjMxWGFDOGdvbmgzeWhNS2ZPMFdpTzYx?=
 =?utf-8?B?eVNPcHhGNE1xOWZpOEFrL050Lzh2UnpYU3NaM1M4WGVJYy95SnJYb29UWHlw?=
 =?utf-8?B?bzlPRVZPTnV4aS8ydWFzK2NOYXY1bVpycHA4aUROcUp1RitQMVRzaUFNUWtV?=
 =?utf-8?B?YTdlQm5OalJXWHcxbGVUVTl3RW0ycFFpZm9RcmZsTXVFV2xWZDI4eS9JSlJS?=
 =?utf-8?B?c3VlSVlqZldJc1dNZVVHRFFpU0l6Q2k1YW10K2RnT0dIRW9Mb0JtMjVydVdD?=
 =?utf-8?B?RmVxR09lZEZTMUtPV2Y3UC9SMG5lOVVQOUtGQ1JpbWdncDJBL3VESUdNVWpI?=
 =?utf-8?B?OERRMWc2emxXK1dXV24xQWlNZ2wzRTN1WHV2WDk1d0RhQThaakU0U0Uzc3lm?=
 =?utf-8?B?U3BFN0FzMHBCTjQrZkd5a09XazV3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1eee2b-f838-45a1-8149-08d9dcd05203
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6788.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:22:33.8311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UNNCHhNcCdhO3dMrrx77yEgPDW2St9NGbKS99GmVBqjgWZMJmLyjJcjBcgBIEUSAnFKha3AGvVMPApqGaehF560mCfSxEzBgPUEb6vULaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8538
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiodio: Skip tests on tmpfs
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

It makes sense to avoid running tests using O_DIRECT on tmpfs, so patch 
looks good to me.

On 1/21/22 11:43, Petr Vorel wrote:
>> Hi!
>> Looks good to me, but since we are right before release I would be more
>> happier if this gets more than one review before it gets pushed.
> Definitely. Li, Andrea, Martin, could you please have a look?
>
> Kind regards,
> Petr
>
>> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Kind regards,

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
