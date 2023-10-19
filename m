Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61233CDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 11:03:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A5C73CEEFF
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 13:03:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F2DF3C8494
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 13:03:27 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::60f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DB4F9100B798
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 13:03:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc61p2DrEqYYwf7dx0g0rroyMwAKzIYsNcIvHxUH6nrQ5O1fCWpKK5hB+jaEgVYWTgIt30JLeETYFoH9Czf3kCzb3wBOll0+4Cy7+//dE53O1OyUB1v7Zo0XYm+/ENgjWG4YVEw/b2h1EbPdxLYEb/1pWeOrFDT4D88bC35zTmuCd0cPghzeMG8bKBKPf/+m9bhHvYpC6OgeXmGCtgFJ3jawn5nt2CtE8hOgUxoyXAvVyz02EptlTgdOXxXpcA21oLxWvaDX5ejOtWYoHBYYTO5qsmHetSRPUfo6hePLK7y8xKH9jQb9Q6zf39xK4zKmGvvSE0P9j2rZFTdskinvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ore+KI5b0Zmft6pOxaZMu/eJXpDQKpnL3WMOTysggFo=;
 b=PuGWmWnv5VFBLai8YKeq5T+5r9XBkbvoqyJudA7lz5bt9rb0sxoRcbKtFf73/1MU3wYZQ0WH4D9c5xeQcmoLgNJYumdk/X1vbbvATGr3r1S8QbAiP/rifSgxOgnaGYxpYM6PICO5TM++eT4sl6ZDhhmAPhsqXTFlU9zFXw1+/iHSm2u1Qbcaa4FKCOTIRNQECow7QfNgQrYJhnEL2+21RgsumGMqjnBHwdOkJmxksEkSisfFW0lg8U18uhT1Q08Nq48uJn0xSTlJUdHWMZVlztZrSE2g33LCF9ip7PMqTBY4s2EibHDg/xDnJ+LaxnYNavO33JS/QMtRxIzeCHCSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ore+KI5b0Zmft6pOxaZMu/eJXpDQKpnL3WMOTysggFo=;
 b=wMwJbDAPuRtkKmYY+aT8owEu5qe7EGOrDRjknjWyEzxlj53D6FsQSiNvpSo8V1g8cySvNP8FxQR8R19kT3isvmM6Cmd47Le4foRQfbsbb1dl9xnXxsPZyANn3gd8UJlS+ZCeoUdSQRN7N6uXxpTK/O1s3526ZF8cORml8QHjILLkd06XuC7ypngrWUWQnnQn4l3SkzrSFrdXq1KEWDjwOkJtFdUN4W7N18rBCrnWBsK8PQBzvuT1pEGmu42K/2i9KIrh/7QUJPqfh8bmYuiJxPdCOCz39bp9UFqGYxKfRULCjXQSUIObgJ9XGF55Yo91puuntMw8ENtyEfrPTdAHEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AS5PR04MB9998.eurprd04.prod.outlook.com (2603:10a6:20b:67e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 11:03:25 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::4f58:e0be:dd19:58ed%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 11:03:24 +0000
Message-ID: <73fc4664-fcec-43eb-b95b-c029f1218e71@suse.com>
Date: Thu, 19 Oct 2023 13:03:22 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <875y33vsks.fsf@suse.de>
In-Reply-To: <875y33vsks.fsf@suse.de>
X-ClientProxiedBy: FR0P281CA0241.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::19) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AS5PR04MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d934f42-a31d-4b77-6139-08dbd093038d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKEGu3nYNMwMXwvCCwY4fyczXTImgW63dd8tj9qRAnAUQFTNr9Evr+57mY8lWiznYdDFAoLR3rcHsPsrDVJlTE6l38hdauoljj3t84vfnHdCM3Oz+1kyt4Tw+zRE+GRJuEr1isvmL310WlzPcUdeKQ8Ed1JSsRxc7fp63yejieC4EQ3+vMQ0gL4I2suCX7t0ravUU8LajFjfjzZTg910uA86EDMwrUNj86u8jMY+LHsQL/qMk6FxaYFbZ7bCmGsAkFKArattKyHDAT7ukoq7QaXtle09zVB6yon+Y3FkxVCpunJW1T2Y7bBgCKE800AWNOaXprJqs0lXzLPsPOBtnaB9sM9wlTT4LxJO3oA7TbSR5b4VugGbmHfwO19cl4FKEqAfIgosih5QGtYWCoHeNTRhSEBa475uhqQqPGFRRoAmfGWqA5mGFL+j4S50sXu5vTlVNxluvX4lYBls6nHZEOyJ+URJOxIpglGTmfPtqknqy+twyKqs6fsUd68tivyTGwJcpWihTZmF0Ubg0AM3jz7RS1UYd/XXXo+F7xgAz9g60LjBd6GLv6SyJYljrDa3sFUIHKTPycvFcHCk006CBduF6kAzcvQfKkQFmwzVl55EepdQfxMQWPfWMmTrJOUNk1T+tH1QD2d90tTkP5RkeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(66899024)(8936002)(36756003)(316002)(6916009)(66946007)(66476007)(66556008)(478600001)(6486002)(44832011)(5660300002)(41300700001)(8676002)(2906002)(31696002)(86362001)(38100700002)(53546011)(6506007)(2616005)(26005)(6512007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9OdHRoODBpdVNMZHZqcVB2VWZFck5jZmlvRnpxZ3RWTW4rZklOTnB2aS9M?=
 =?utf-8?B?Wmt5ZmMvWW1YVzZQbkdEdUU2eDdPNEhPeEh5UnhiM3hHbGZCRjNPZ1dhL3lD?=
 =?utf-8?B?Z1hKdmRyMThzaC83eW5ibEtrNXorUytCRDVUSVF0WW04R1hwWlJiSThtWjVY?=
 =?utf-8?B?VlNOU0IwVUF4ZTNLZUFjcUcvK3lXczh1TGplMVF5MU1sNFpmZmRKY0pOTHpS?=
 =?utf-8?B?OWsyS0U4VUYrQ0ZXeEpycytCcG9EM2FyYU9CUTNrMFRnOVBUUWpqbFFuTGVD?=
 =?utf-8?B?bytYTlVIS05CUmhsYXZiU3lTWXlQK1pPdmhNMUx1YlNVMy83WFE4cDBhWnU2?=
 =?utf-8?B?eTVocEhWcWlabjhjelpIcGd0VEFKZlE4RHNDQ3g3dmZPc0NHZXZVMDQ1ZEJn?=
 =?utf-8?B?N2ZuQ3dKWlFYWlVlK2cyTnY2TkQrNGt0V1UzUnFPSjB3RlJJTXZVLzF0RFNT?=
 =?utf-8?B?cWJrMkRhSVBhMXdzREJTQ1JxTTYzeXFJSEphNDBpZVNDQWpES28wUTdoSldL?=
 =?utf-8?B?cFN3KzFaUlpSVXl5c1ZPUkErLzVMU3htVS9FWUtscVM5RGd0NjBQS1Y1eGxy?=
 =?utf-8?B?SFkzaGhoMkpsR1VUalkzQVowNjMrZENpdGVvamkxYmhieThUbUdnMFgrSGNR?=
 =?utf-8?B?cXdZMjAyTk0ybUt0eFJFYmtMVWhUby9UTldTZnRpY3BpYk9Hc2JqcURBN2tI?=
 =?utf-8?B?d2o4VVRiS2pLWjdvcjNUR2NXdUl0NFFyQmNzTkRwZkRtM3dtR3lpMDJLZlc2?=
 =?utf-8?B?bGlmNEJ2YzN6Wk1jMXR2N1pTamV2bDFOdGR3NE9nQWxlQ1JkUjN0blZtUExH?=
 =?utf-8?B?SXBNeHRMTjZlb2xmRDZyNFNWblJFdTJ2Ui9EVzVZMFpjRkcrODdRYnNsSWcr?=
 =?utf-8?B?TTU2S29TYjNXTktaODEveUFUWEhqRlhNV2swRFlEek5IVW5uY2hpcUx1a0RU?=
 =?utf-8?B?YlE1M3ZOZzhtTXhxSklTVnlWR3M0MHE2WHNBQkVYbmZwdFoxTFJ0NmtkOXVu?=
 =?utf-8?B?bzlZL2dtVUxDekd6ZnRXelBTV3dUOGRQWGsxZE1RZkRnOWM3bDZnZFRjYjdi?=
 =?utf-8?B?OHFkT1B5SE5ZZDI2K0wyOVY2bTlZa05MbWlPRDEvTG02cVdMdmlsSWxIWFl4?=
 =?utf-8?B?alhIWXluL2NDaWFOZ1JxUkFxekhvWXJmRTBhWHM1dWYyYmhhc2RwMFErVVpJ?=
 =?utf-8?B?QnI5OFQxU0FjR2d1WGRWd1NZS2QzY2QyMk5wRlAyYitoTURJdllvUGUvdWI2?=
 =?utf-8?B?OTJJRGdiWnlYWndzYnlSOSt4WDZTbjk5aE13dnVYK0RKV2V0eVkrZHdWRnZE?=
 =?utf-8?B?WkpxM2pFUi92STRaWmNTd0FGNzBqaUl5R0s5UHpSZjhCMUk0NGdzMDV5Ui9D?=
 =?utf-8?B?WS9xSU9Wc2R4ZjlGN3B4Z1d5MmRZZmYxQ3lYclAxMGF1OW5RQXRkenFWVDE1?=
 =?utf-8?B?OHVFNkRBcGgxbUFOdVhOcHhzdmdaK015Mjdzektnck1BWFJQMGtUNHFUa1VZ?=
 =?utf-8?B?bDdCd2E1S2FMVFQ1Uk5RYitXOW14MURHNVRrc3gwTkU4UTZtc21veEtDSXJx?=
 =?utf-8?B?Y3Z4ZDZGZEw0U3NiY0xUVFlIVmlseGJWbVVuRWYvem9DaEZKU2xSTlA3UXRG?=
 =?utf-8?B?b1RLbHJHVjQwQVRDUXFaZCs1SXRHTnY1WkU5TVg3S3lvT3lEeVNZLzI5YnBK?=
 =?utf-8?B?Y29PVmZDditkSVVBWE5aOUNTa3VxZWpHcEF3VWJIU3ZlMmprUE93b1FDeTdT?=
 =?utf-8?B?djkwQTdWbVlPQk1DQzQzTXlKdFRLOWJJOCtuQ0U5RzdxS0ZJWWFVOHRiVFRj?=
 =?utf-8?B?TjBGQ0U3Nk5JQjdiUWxsd1J2QTFEQUJuZTA0dHFHWE5keGxKZkJnQkZhd0x1?=
 =?utf-8?B?YWM5K1FBNHZiMHFwdE9jM0xDSm83ZTlsUkFGOWpES3AvRytLTThaa1I0aTdW?=
 =?utf-8?B?dEIyVWRhaWhzeHBlUFV1UHIzbFpvV1RpeHRWdEFnZ2RKQjJ6Qm1naTNZK0NW?=
 =?utf-8?B?WjBDWGhrUzhodzJrZDg0YXM3Wk5iRTIzRi9KOGlHZWIxYWUvS0lrMTljbllR?=
 =?utf-8?B?R3p0RVBBR2ZldnU4RlFlaGQzaWpaenF5RVlGNDlNckxPc3BvZmNHWTZrNWRE?=
 =?utf-8?B?cmlqakZCMmF4NnM3dDhQSE5QNXpxV0VCU0N2S3JjWE95cXQ0anZxZlBCaXBi?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d934f42-a31d-4b77-6139-08dbd093038d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:03:24.4965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bw6YhRbt3YOOJP3mw0xzDW85KTVNoV7C86SFdRV5wCdzzz9eCH30i7/OjR0NK5EoDV99VrtK/O6ty0nRh5yRsqcdJ4h1wCYLlcTcRKK0WSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9998
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] LTP open monthly meeting
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

Hi!

I'm looking forward to participate this meeting. For me, any Monday or 
Wednesday would
be the best, possibly not between 22:00 and 9:00 as Richard suggested.

Thanks,
Andrea Cervesato

On 10/19/23 11:31, Richard Palethorpe wrote:
> Hello,
>
> I propose a meeting once a month to discuss non-technical things such as
> patch review policy, overall direction and bike shed discussions. Anyone
> is welcome who is interested in that.
>
> Originally I thought just to include myself and some SUSE colleagues in
> an ad-hoc meeting to deal with Reviewed-by tag delegation. However I
> think the real problem is we have no LTP meeting in which to discuss
> these things and chat. The ML is not adequate for this IMO.
>
> For me any time and day would be fine excluding 22:00 to 09:00
> UTC/GMT. Probably Monday to Friday would be best for most.
>
> The agenda for the first meeting would be to discuss how to deal with
> the situation where someone reviews the V1 of a patch, but does not add
> their Reviewed-by tag in subsequent versions.
>
> After that just introductions, questions and anything someone would like
> to bring up.
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
