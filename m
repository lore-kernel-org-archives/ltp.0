Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEA8C25B06
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 07:01:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4132B3C958E
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 09:01:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E2C53C920B
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 09:01:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 569881400758
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 09:01:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiSSRcodzD4JHIH7lQAUTECRyMlKc/vSojd+FMR2DrFbmYbaC10VltrbwYGD8TXySIxREFU6Z3kDahBxTvRDzP3YiO14qExksjTazpKtTgrlSMvLqlsJ1DNXvxt3qLBMy+t1vOGDi+LWieW8ZzUlJHP2o4Fuzhdm64ZY/idcPWbhApMKRnsluo5LXH1wnHSpuPbINessvFYdJJM5Va5AjLT08MCeTIslnK07UNctDMz+mW/Ks/5Xum1aLnhCja12jN24r3XlIV7CufkUg5eopw0lGyoDPswtzsVvhvwNfF7sd0+7a/ZOIkyT0yV2kLXs1c2Ghuao8i+G4GcrkPFsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIrnL5cMjqRUVbcKkipGVnMIK4s1FgM2cm/ji+rRb10=;
 b=b9YEFhZra+UBAKUVpiuYKNQ87eHSDiDqT9xkILXAt7AzBgqSMytf+VasUZGZkN2MCiS8RS9uzabSPjq79sjtxiDpbpQ9XufIiewAlromT8wgiStwBrObIH+F5Foux/Ylvqm5WPa8xtWN5upvqDTbrv2ih8d46Fw5pBoiprDXJ52j7q83VOjkqWuBvjBYKzknlEmrpD9PA+g64SVwA27EUfPURVx3wg6nq1wOB01la8aIbVf2LIJEFDfAceEzbWnBoKHW79sbB9mzytKn5rf+MGxcQWJVrm0NuGQTrwt1g7/Pl2th9W5iXcuhVdzRfusjDXHSZbZA9kx/GlFj58MHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIrnL5cMjqRUVbcKkipGVnMIK4s1FgM2cm/ji+rRb10=;
 b=TXH6aM/on4PBukvQMKrF3fJmMq+9LK93rwCBBtjOtMxapT5LnWVdLTp9OTI+yYTQN0qZea0p8vylGTS9suOQzuAacjYmqhQaFlRPl+tTV+dOm5N6YzZEojVyF/+qNH53oxW+rTlTIGjCYnbUUhG52bj7g4YrlPvKiyNXZCTKl6SnqGz108rBS9cuipJ3G3qKuuWSMjZzg3foo9W6WUySkWQ8W/P5IwDAAOGhhd30GjrBhh+bA+aSsCOvA0sSwUv8QY5Que/gxysEgt9fDTbFMWy3ST3QKMmHTkZtK9Z+78he8rQt0Ac0mFxNaWithmYyLULL3ipKIU4M2bB+CyhnYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by VI1PR04MB3984.eurprd04.prod.outlook.com (2603:10a6:803:4e::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Wed, 10 Aug
 2022 07:01:09 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%6]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 07:01:08 +0000
Message-ID: <cd21e1b4-a3ef-4066-70df-576260a5cb7a@suse.com>
Date: Wed, 10 Aug 2022 09:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
References: <20220803120905.3107-1-andrea.cervesato@suse.com>
 <Yuz5pIv+98cFmgBg@yuki> <YvNW0OQYwUhDjIOC@pevik>
In-Reply-To: <YvNW0OQYwUhDjIOC@pevik>
X-ClientProxiedBy: AS9PR0301CA0028.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::19) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf806c50-4f76-42b6-19fc-08da7a9e1a05
X-MS-TrafficTypeDiagnostic: VI1PR04MB3984:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDhl8ynQ4H5jMKBQlI/jfS5p7DKGbT+51zN6e38gLJs4CNHGRfP1KcGfJU3hTVdF368FxGTrTkB6BZsuXpuIVNJBoutHetp0keebaopoq9C7Pno14jeZBpGQwn89fx6R6lrY4xtYyqrEUUfDa1qMOGNcmuBKsaRbn+bWbFGX3y0+zZP/+I71JD8W7MasF/saidMtUydTnfZg50Z7ZilUovpCUdbr4Yv+QWHxApapa+dec3QUS2j8VCtpvjQIo97tgrUlu9tLeXiCnNBrppWeILNvuO9wsNl0SgAeikYPOPquQQeoMxJ5u5l0L20wjhV76eSRHz1BGkzzZRR4hGIOAUd4qQLepiFGRh+rTmfrBlZrueh06J5fnJnaCIKJNika+p7oTKsZyqewY+mtWbd3wcbXxUVCRRXWXPijvGCmwvSIIm/F7QD0LTh0d4uitm670rlgXfQElTAi1S70M1XPoJLHXyTmBXpgSfAQb4YInPslGhCYVxotq+E4Lg7VD1F/95XjeqyJKYbAWy1aeopEnErF1WAdNWfnMHH3h31Vevbn9MRaSYtr0kmRPwH0DObUlSLNiYiXB78wczFPaZzqKbWXEcXHSGNbmeeK2lNMBXPAzIyj7GB31a5BBWTvLPVQwOMLn0BOnogy3mkwJ/uzUGChCJ7VKG2taU185GYCUFD1wGtn1nY6XhyMq0jYHgxEyZFpMUt2SHw8veHtsPxGVmk2sOjlzs/nZZxqrnBD/P7S4WwX/PGZqPZ+sYE0Xidmvhk3kgDb22eiFGI7dqG+rwwJfpB0uGQ5z8FM/qFzjU7GVh/D0U7bs4y2l32H9LTS2aH3eLlBtV22Ic62tF9rFdjJWf7eh9Y4cj+LE8waaMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(136003)(346002)(376002)(39860400002)(366004)(396003)(31686004)(83380400001)(110136005)(31696002)(316002)(36756003)(66556008)(66946007)(8676002)(4326008)(6486002)(86362001)(966005)(478600001)(8936002)(5660300002)(66476007)(44832011)(2616005)(41300700001)(2906002)(38100700002)(6506007)(6666004)(53546011)(4744005)(6512007)(186003)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2p3clM2WlVvck1nS0k5a3k0OWJMcjZlYXF1aStDdVE3dkNIVlMwMjVIQ3VR?=
 =?utf-8?B?bVlyclJpdVE5WnN5RmlVQ2w0VlNCMG9kTFFIam1HZXVzeVlBZitidGtIdUUv?=
 =?utf-8?B?a2E3b3BJZFpIM3lxYjRJQlZxUXZTVUt6VmU0dGI1R2JULzdza2dKRlRUSjlq?=
 =?utf-8?B?NGNERWV3MmVkdmJLb2cwVFBZaHROOXlGSlVXS28yT1hYM3NPMnBKQ3RhODNV?=
 =?utf-8?B?bTBZNVJReFM0N2t4ZHpsRll1bVRQd01EYlRYTmF0YkNzaHlDVVZEeDlCY05x?=
 =?utf-8?B?WjlqMVF4NHh5d1NwRHMwNFJVK0N0OXZrRW5hREx5bGhxMFdjLzk1eE1oYldL?=
 =?utf-8?B?TXRaY21ucmFLSWM2U0w2cXpoV09lSjVvUktyL0NnTjRlTUlnWWljUHliS09l?=
 =?utf-8?B?alNBUVpNUlhPYWtTWUJ4UGJ5ekhGY3YxdlVySWdQN05rcWZrZ2RLb0RMM3Bz?=
 =?utf-8?B?bFA2cnAzWjRjekJ4Q1ZPQzlTWFpTNmpQNUhocWRpcXUvUVp6MGVYOVVQTllW?=
 =?utf-8?B?M0FVZmpyOXpqYlVzWTlBbXg5YzV1QmVvU05jR3FxeTBna21yVUdnN3BmK3Ft?=
 =?utf-8?B?US9nUXUwTlhQOFlVS3lDRW12UzJZZ1FaWFFNWmlHT1FEWXpjRDN2eEZBUWtj?=
 =?utf-8?B?OXR1S2wvb1hGRE5XU1ozT3pobnlVYWVSdEg3UUJQWU9tRXFpNWJvMlRhd2lE?=
 =?utf-8?B?NjU1T2JQSDhuSXAyb2FTaDF2T1NVRkF1bzR0TkNqWi9lSkphUEdwbTFYQ2NB?=
 =?utf-8?B?MG1HL25lRlRjdHpSbGx0SlAvQnA2VHkyNnJvZDRmc3hKdVpQUDYzUkhtQmdE?=
 =?utf-8?B?REw5cEExN1VDR0RCZ28zL2hXdXpUUEhncFBIZGNNRTNHMC9ITzFmc0Jzb2JO?=
 =?utf-8?B?amFWUW1sUE56VVZia3hmQmhpQXJkRDFZbUtzUTZtR3hteUVFMFk4VW8vS1Vi?=
 =?utf-8?B?NW04WFRhL2RVNlhuTThhYTZXaVUrNjh4TE5SN0FpY20zbWN2ZHAvbDl2bU81?=
 =?utf-8?B?SmpEUUl6N1FLRjAvS2haU2szZXVKMmVWcGVTQitNU2RKMGdsNFowV3p5K203?=
 =?utf-8?B?empJbnlNampCaXpOaDg5WmhCdXZ5Vm5pV2tjZXpzclhmdG8rY0RweGsvRFl1?=
 =?utf-8?B?MDMzSVhiZkRoUXpGakRZNGRkTEJ4U1lydzUyd0t3b01BOHJTVnVlYzFGZUg3?=
 =?utf-8?B?c2V5NWd6N0RkM1N2MVBRUC90cUE0bHo2Q3NRSG01aXl2Ylo4SkJhVzJWM2lt?=
 =?utf-8?B?Tkx0anhFb1Y0QUhJditIRmo3YUVJWDdtVzhSWldGcE8wSmZrbDRoVE8wNy9q?=
 =?utf-8?B?NUcwN2l1YXB4U0gxSElQRW1EVjhBMkxVTEMrbjg3TnI1SmFEQzBaYmVxR09S?=
 =?utf-8?B?WkU4MGlUUzdtM3drREx2YkRQQndHRWE2dDlqUCtDcFp4VWJzN2cwZFJjdFNO?=
 =?utf-8?B?UklPK2dnVURpd3cwSjMzV1NNNzlMZXBVMGYxZGFEQUdobkhhSHRPSmkranZM?=
 =?utf-8?B?amVDaDRPVVBsTUFJaENzOVVld3VYSUlVakNhNmtBTm9jWVJ6NDhrajlodmNm?=
 =?utf-8?B?NjI4a3Z6bGlLa1hiZGxmM0xzZVhBZzM0d0o2RGRFYkpFQW9zdFBHNVRiZFY2?=
 =?utf-8?B?T2F3VGoxM29hMURvN3lUY0xhMkZQSmVIaE1nOFMvUzh4WW1VOFE5dDN2bHM4?=
 =?utf-8?B?eGNyWGhEUmFPd1hOdGFFSjdSek5sY1Z2ajN1L1ozZlFldmtTTlBZMFVHeUxl?=
 =?utf-8?B?R0R6TUg3by93eWtPTXlkUlZCTXQzL2FoSjFpSGE1aGY2c3ByTDNtUXNIUitS?=
 =?utf-8?B?TEhQTUhjR1NXU2tlTnlQU3RRQ1RjaUJOU2trTFpBbW9mOUJqN2dnSVZaWTJ4?=
 =?utf-8?B?TWxNV1RTeXNkbWZ3ZmJaSzdVcWNnNlhCdGlVTnJsdHNuR3V1NUZVZnZxNFpl?=
 =?utf-8?B?N0QyOEpHR0NjZTczekc5amdZYVpUZEdaR1FYS00vQm4yN09GZFc4ckJhSm5o?=
 =?utf-8?B?dE5NeEcvdFNrNGgzNHZkcjV4TjlGNnd5SUpyK3JmdWQ1d1NpQUs5TUk2Y1k2?=
 =?utf-8?B?V3RZTHhhdk94ZktxZWdzcG1uQllobmFLZXBQekZBR3FycW40RUt5RE9TRDY1?=
 =?utf-8?B?M21TUWc4TGRjdFQvWXhLQkdyM3ZBdFpEYmZDYkRuOEZMQkNjcHJkNEFpbHdR?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf806c50-4f76-42b6-19fc-08da7a9e1a05
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 07:01:08.7415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqjvbHeFGFfi5FehEjgzHvj7NVO0WbExuRBjAeclJbgTEkpgxJQ8Lb8sN1AlsxphQufmHx6eobUMJkvIvMGKMfZwdWLAjG12d9b5SkDZNtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3984
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Refactor aiocp using new LTP API
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

Hi!

Today I send the new patch. Thanks for the review

ndrea

On 8/10/22 08:57, Petr Vorel wrote:
> Hi Andrea, Cyril,
>
>> Hi!
>> The code looks good now, but still needs a runtime treatement similar to
>> the one done in 3ab0b3cb24198a0a833e4450b8bc9cee8b70baf6.
> OK, new version is needed. When you're in it, could you please consider things
> Cyril asked in v1? [1]
>
> * rename functions
> 	I guess that it would be cleaner to rename the functions to something as
> 	put_iocb() and get_iocb() since they do not allcate anything but they
> 	have to stay.
>
> * I suppose later you implement ioctl() BLKSZGET
> 	> -static int dev_block_size_by_path(const char *path)
>
> 	Just FYI this is actually the only correct way how to get the O_DIRECT
> 	block size, we have to get the device and then call the BLKSZGET
> 	ioctl(). This code has to be put into the test library and reused in all
> 	O_DIRECT tests in a followup patch.
>
> Kind regards,
> Petr
>
> [1] https://patchwork.ozlabs.org/comment/2917667/



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
