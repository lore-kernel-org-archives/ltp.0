Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF49EC00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 12:07:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 183CC3C9456
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 14:07:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 224103C1B37
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:07:23 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr140055.outbound.protection.outlook.com [40.107.14.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0E82C1A00616
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:07:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1WgSe6R3WMNdDLgjNvFSMv57Fv1omjzcDhJKn5TBYZ/gnaZaF+1x0oAfy1MKIrBBB0e6UJ0kRydhj9hgpdmu/1S/oa0zruGTtGDzbBud11kHBakkZ07FUkFfmqJIgOInUO6kBMZY3Wo94uPtJPaHNjGOMA6JaLU3U6TjdsoyeWCiKSOf5AgQEriLWUT0wWE3cfJy72TXFyoeaaN3R4djRsABZpoGSPpxKMBY1hRw/W7oMVirpX7VUaxLQzj52DR1x0E8zYKhJ8sWFhPEXQmtg8noEYZWJYIHeHxnhJf57DwvWEzhet1kNH9UWDMDlb3/m5oWyAoxf8KqNcqJWThtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18P/hfeXvXSO8mXJ5vQjyVW15+2eVF/chsx/UwqXA9s=;
 b=FHLM1I2qE1a+x4VIbS0mJm/GYEVpd4gGBkYzF6W3p39lGGPgr561U66PpJgDTDm8LQhNp2ePdgUGfU/97GnTH05gjak/hOqxcX4iVLJSsMz5YdorLemu9FMB81MmGDRh89U82cWYwZ9YFH8/1DelSy3U0/xGlInakuZegdwm84qc+JmN3G9w2ZqTJv0MNV9IM8PvoYJZoWeFXReMSddH8jljoW4Oe9kr8JmKl9M/WyCgx15YAtfHZgJQHrtO5GmLiYEf20dBk+FuP5RhMOOgtTqAwMZycIYUMF1inRh8FrPhSdG7jLMzioIoPUP3kQ+c8X/94wTZfUT/rYQd11A0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18P/hfeXvXSO8mXJ5vQjyVW15+2eVF/chsx/UwqXA9s=;
 b=zhl7GJL+dYJ0R5MfcGCs6b3yRCEf12ufiH3dxg+ua7qz2DBsi+c1PWZuO3obom3NZOGJYd7b1Kyo7A8HJDDwL5e2lsBo8w0McDtv7+aWIR6n9CeW+ttYkWYr3pifAXFNoCywKUH0NP6E3yjbuLJZWfdXibxM6M4QjcTKdiBUi4X7VtA/NYxOGp4P1ZTk2ms2p/d/Dh4V0zbWjRnIr/DIMjSMPj3G3A9h9ou8JEIPDK/5qTJaMoh1Nr3q/aUVjdCcdObzFNPbHvZOK8FB4LO4lNJpVXlUgIsNOlwRTCAafX7vr1xmPyrFPA0Sllp43Bb+EgyZKDfRVNDxLSHiRUm7tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM6PR04MB4806.eurprd04.prod.outlook.com (2603:10a6:20b:7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.19; Mon, 8 Aug
 2022 12:07:20 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::c3:d917:fe7a:451b%6]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 12:07:20 +0000
Message-ID: <34d988af-30ae-162b-aff7-89a2bf9a2fc6@suse.com>
Date: Mon, 8 Aug 2022 14:06:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: "Chen, Zion" <zion.chen01@sap.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <VI1PR02MB61896EFAC4D92D36C0723295EA639@VI1PR02MB6189.eurprd02.prod.outlook.com>
 <8c2298c3-0838-de6a-e76a-927e554d6035@suse.com>
 <VI1PR02MB6189D65184F2713C2E1AB409EA639@VI1PR02MB6189.eurprd02.prod.outlook.com>
In-Reply-To: <VI1PR02MB6189D65184F2713C2E1AB409EA639@VI1PR02MB6189.eurprd02.prod.outlook.com>
X-ClientProxiedBy: AS9PR06CA0211.eurprd06.prod.outlook.com
 (2603:10a6:20b:45e::15) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd58807-5891-46f5-7899-08da79368b38
X-MS-TrafficTypeDiagnostic: AM6PR04MB4806:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDQ3tZlT3It3/CdTrlKLr+t2j6YgnansUokxxfT7GwRYCGnmDSWOSgsPxSd9Tfn31T7gnxnXNaruItwAD6bWttNm6qX9E+Euiv1uzwTyw6Uc0dBJ76+yt131Rl1a4cLjd6tco0hGvg3sKQU3xpNpCZXfyXJ1cfjUrKeeJJphHhSWDSdAQ4AUuXdLYvgT8avbY2njSiGHIRFoJwnf5J0JCn2tcE87N33iWUhHfPszKdS6th1z92YnufHg0rHymJW2vaSjHeZjjK5SqvZiF2hj2ScXkFNIT9jcPAHI8t4ICjNTNiQk0hsSfV774gFGMOr1Dlr71lrn/hwfV2EwxsH5Y/6mYKQ9P5VGzvAMeT0g7vLnkKwezueqZWZdruUXMT1CsZlOzEsxnCnd4iLecULyX/E3wk3aRg4Q812Y10beFmOkvPZpGJPzlTkidYF6WDBkZFvS9SWm9XzURHpTj6kX4FJL00qsUoAdreE/a5B+LFeQ+ChGXd8sGWVfMtjunuXRrzsncrC/3KGCCFwlUHnocHx6hxbOQEFNnfDTv9qqQhXQM4f7F+Sx8ERJ6+bKgVGwk/sISx1HoeqHZ4ajyrP9bnk++li2/0rAP7aSmljWEBipNWwEhO9IcZ/ZQRHpAmXewweWxG6kyjMZfd21SB4HZUlbqZcF+isxsbR7t6uNC8bjfk+wcg07J9TDAzlfiAwP+C5FmZsVbySCp+xiMuOu4P2hpF6l+5KT/gZ9pLVZfRsV529IpmVKFLeP2HCgRNIiBEnxGLmwcmdQtB35vtXgr7MkrYsyyobBG88Aq8Q/CD1lCs/+Rch/z/2w0Fq01ZJcnBaB5Piuv/4dpNqmUH7Yt4jNHUu7xqP7674iTFofjEKcY4jv9LP/iYDwt6ac3x4htgdumwiT3y6ej2IsYzMz3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(396003)(136003)(346002)(376002)(366004)(39860400002)(6506007)(41300700001)(36756003)(31686004)(6666004)(2616005)(33964004)(186003)(2906002)(26005)(53546011)(6512007)(83380400001)(966005)(478600001)(4326008)(45080400002)(44832011)(166002)(38100700002)(110136005)(8936002)(316002)(5660300002)(86362001)(66556008)(8676002)(66946007)(66476007)(31696002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFUzOGkvSDhnK2FJbnNlaXJTM3M1MXJGeWZ5ZkZMaHdDSUxpVFZSS0M5YVg2?=
 =?utf-8?B?Ylh4ZTg3aTh2TUhxNldrL0V1NDNBNVExVExFSGhrUElXdVFwVXBQb3JBQ2pT?=
 =?utf-8?B?R2s4M0NaRzV6aGdSQlhyZU1jcW16NjRRU2FxNjJ5REZlb2VVL0p0cENVRmg4?=
 =?utf-8?B?bi9UbWYwUmduWlk0cHhHWUlCazc1VnVDRzhsZC94U3RhZlp4SVhIeS8wTjVD?=
 =?utf-8?B?cjlIVDNaM3JUTXh1OVJma1oyaFRRUTUvenlwQUVWc3VVanRwSlNONzVRT1NE?=
 =?utf-8?B?bGQ2ZnNEMDByUXlZREhzSXg3RWYvNnpzdFQ1cVI4cTNtU1RjeXBSdkI0VWNL?=
 =?utf-8?B?YS9kdGpuRjduZzRwOHJkUW5vQlU2Q21MRXdZRXlrMTlpdnNqZW5wdVpycEp4?=
 =?utf-8?B?TXJGTmJiMWVVTlVVcllBS2lSU3FqRlZrcUt1cFZnYVU5dGVoNUFSNHdkc3Ay?=
 =?utf-8?B?YUlKU3JzMjE2YTVWQTlqVmxDckNLNGZPaGJhQXpGSVN6N0VkSHduMjVwaVdn?=
 =?utf-8?B?OGxPQ3dWTHh2ZEVQNHRFMFIvR3QrMXhHQldSODF2MG1zMFJPQ2NaU05ydlc2?=
 =?utf-8?B?RHpIc1VEMlhWYUttdFpkbVBENmlRY3cxb0xUUEtlKytsbENsVy91eWFYS0c2?=
 =?utf-8?B?RHhsUDBpZ2EwWXFRV1NFQXYvbW01MUtvZlRqd2M3SGFDOFpNSktRU1hCRlhv?=
 =?utf-8?B?OUZ5aTNBMjNiTHhTTnpqQkd6b0RkUkhaUkIxeGp5WHg2aWc2NURaU1dsS3pt?=
 =?utf-8?B?TjJ1ZGdTL3pJaXFLUUxlN0Q1TkR0cWFIVWNpNmNyODgxQlBhS2NObmxpZUZo?=
 =?utf-8?B?akRXTEh2ZE1XSEhNMFVLdmNWTU5SeEc4cEpCMkRBS1AzSFQ5NElYWGV6b3d1?=
 =?utf-8?B?NHBZdzU0YktWQW5Vek96eWF1YUNraURtcHM0aFBvdjU2bm5PeFUydTBRWUty?=
 =?utf-8?B?WXlDaGs3T0xMbzRpMnJBazVqN09DYXZxR3cxVHFCUml6bHdWa2ZOSGJ0OTcw?=
 =?utf-8?B?RlhRUEdhMTV2bFk2TTlYOUIwMnhTc0tRZGFBRjJYbmNDTEd0cE4vWTN3Y1NQ?=
 =?utf-8?B?V3ZyMk9Gd3lndzZoYjJ0VkwxbTJzSGdIZHNvOWRpUmJ2OWpQMzVIQ0JOTDRp?=
 =?utf-8?B?K0Z5R1kvZVNSeExzWm1LRnZFRVFxQnZKbTRzWWl2YjJZV3NNUGN1SWt6TU1E?=
 =?utf-8?B?MXNCZWF4T1J1S2U1ZUlLRlU1SlR6M0I4a1BHMzdBMHFsQUd5QmFoRU9oVGl2?=
 =?utf-8?B?cE1icDFjNnhzT1dneXovZ0xhaFp3WEZLUGkybUUyY0pPT1pZWDFNbEZjQXhK?=
 =?utf-8?B?a2kxUExuNjFhcWpGNmJxZHRrVDBjanBkeVY4T1dKMTRNNHEzMml6WENDVnc2?=
 =?utf-8?B?WkpxMlJwT2FWd1ZKZlB6UVBwcVpjVjR6OXRrWFFBQU11a2ZNZU8wTGRPdWUr?=
 =?utf-8?B?SUxnei8ySkEvY1A5Tkwvb1BMQzJxcVMyMlArZVY3bitiSmErZ3czMUxlbTNr?=
 =?utf-8?B?TnhsZ0ZpS3BSSi9jVEhvRjJNMlorQTV3cUVUTHd6UXg5d0VTMUJoOTdqNjJl?=
 =?utf-8?B?eG91TEhiMEc4OENHcnVzVVJZc1BrbGREMzNBNkdRNUp1N1hmeG1XWHZZSVF0?=
 =?utf-8?B?eDNzNjZIRkJ5ZXZORWJlWlk3WkpJZ3ZOWHA5a2JiYjhkRXJRQVRIQVNIQlFW?=
 =?utf-8?B?SHRINE1ZbkVaZGx2Umwzc1BaT2VYTG41SnNsR1hVUHVNMlkvMGNiYmZ4dnZz?=
 =?utf-8?B?SVlNOVNteHU3czFEYWN5V3Q4NHBHZDd5WnRFbTFRQWErZEZCbjVaOGYxbHRw?=
 =?utf-8?B?bTNiUXVSZEVwY2RpTEppWSs3VEpUTG5QQlN6amJmNzRYTXFCUkZsTE1WYURQ?=
 =?utf-8?B?MlFIK0hSc0FvUWhLeDN6Q2NvcCtPdnFPNDlveEx6bk9tczdHMCtUOGo4Z3U1?=
 =?utf-8?B?MHFZZVRZSDNIT1NPZzNoekk2eExNNTRjdlRWVTlzcW1YZEk0YmZtOS9uL0JF?=
 =?utf-8?B?WjgzTFF0U1dURHFvdVBucXN6RXJ2QXltY1ZjOTM0QkdDT0ZXWUpWaWJRMGR5?=
 =?utf-8?B?ZlRJZHkwUldYWDVUamMyWlZvbnJxdU8rYWRLNkRTSklLZ29meU9obUFCN3dG?=
 =?utf-8?B?Vyt3WXNoTExLU014NHhWcnltQXh5YTAzVDNpRTZRS1krMTVtSVJKdUkvQ3Q1?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd58807-5891-46f5-7899-08da79368b38
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 12:07:19.8850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2pkgRCJjP3+Jd2KAdASVy1w3zbpFbkrJS0ghm08vWoLqflzuH+3+hf/cDEUUphxrJkXKOFULII7oC9Xa7lnX5wahte0ayWyYuwnE3mh6Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4806
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Duration run time of each benchmark
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
Cc: DL CSI Cloud Virtualization DevOps
 <DL_6093EC116D5E46027E42596D@global.corp.sap>
Content-Type: multipart/mixed; boundary="===============1516114897=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1516114897==
Content-Type: multipart/alternative;
 boundary="------------9E0a7lIcp8ZlBSrHe29pFfVr"
Content-Language: en-US

--------------9E0a7lIcp8ZlBSrHe29pFfVr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Probably the easiest way is to parse stdout and check for TPASS/TFAIL 
message here (adding a timer somewhere):
https://github.com/acerv/runltp-ng/blob/401f366ccd4bae00a2b247397aae21286594eb5a/ltp/ui.py#L307

Beware that resulting time is an approximation, since python is running 
through syscalls and buffering. Also, not all
tests are implemented with latest LTP API, so TPASS/TFAIL messages might 
not always appear after sub-tests.

Andrea


On 8/8/22 12:44, Chen, Zion wrote:
>
> Hello Andera,
>
> Thanks for your answer, but we need a duration time of a specific 
> TPASS/TFAIL. Do you have something like this?
>
> If not, can you point me to which line in “runltp” I can add “time” 
> linux command to get the duration time of it?
>
> Thanks,
>
> Zion
>
> *From:*Andrea Cervesato <andrea.cervesato@suse.com>
> *Sent:* Monday, 8 August 2022 12:02
> *To:* Chen, Zion <zion.chen01@sap.com>; ltp@lists.linux.it
> *Subject:* Re: [LTP] Duration run time of each benchmark
>
>
> 	
>
> You don't often get email from andrea.cervesato@suse.com. Learn why 
> this is important <https://aka.ms/LearnAboutSenderIdentification>
>
> 	
>
> Hi!
>
> We are currently working on a new LTP runner which is the future 
> replacement of the runltp script written in bash: 
> https://github.com/acerv/runltp-ng 
> <https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Facerv%2Frunltp-ng&data=05%7C01%7Czion.chen01%40sap.com%7Cc9db0750bd484703a7d208da791cc4a6%7C42f7676cf455423c82f6dc2d99791af7%7C0%7C0%7C637955462366946140%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sdata=LZ1%2FvGgfDW0vME8ymCXHTkzVXlNjKnP%2BpRxuj%2FszxYo%3D&reserved=0>
>
> The new runner is written in python 3.7+ and it supports duration time 
> between tests. At the moment, it considers execution time of a single 
> test binary,
>
> not the duration time of specific TPASS/TFAIL results as you might 
> expect, also because the old format is still supported and it doesn't 
> give this possibility.
>
> If you don't need to have duration time of specific TPASS/TFAIL , 
> runltp-ng might be the #1 choice for you, since it also implements a 
> JSON report file which
>
> can be parsed easily to obtain the results.
>
> The runltp-ng source code is open and available to everyone, so feel 
> free to help and give any feedback if needed!
>
> Regards,
>
> Andrea
>
> On 8/8/22 10:17, Chen, Zion via ltp wrote:
>
>     Hello Linux Test Project
>
>     We are in SAP using your ltp benchmark in our linux machine. We
>     are looking in the results file after the run is finish and we
>     want to know the duration time of each sub-test.
>
>     Can you point me how to do it? How to find the duration time of
>     each sub-test?
>
>     Regards,
>
>     Zion
>
>
>

--------------9E0a7lIcp8ZlBSrHe29pFfVr
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">Probably the easiest way is to parse
      stdout and check for TPASS/TFAIL message here (adding a timer
      somewhere):</div>
    <div class="moz-cite-prefix"><a class="moz-txt-link-freetext" href="https://github.com/acerv/runltp-ng/blob/401f366ccd4bae00a2b247397aae21286594eb5a/ltp/ui.py#L307">https://github.com/acerv/runltp-ng/blob/401f366ccd4bae00a2b247397aae21286594eb5a/ltp/ui.py#L307</a></div>
    <p>Beware that resulting time is an approximation, since python is
      running through syscalls and buffering. Also, not all<br>
      tests are implemented with latest LTP API, so TPASS/TFAIL messages
      might not always appear after sub-tests.</p>
    <p>Andrea<br>
    </p>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 8/8/22 12:44, Chen, Zion wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:VI1PR02MB6189D65184F2713C2E1AB409EA639@VI1PR02MB6189.eurprd02.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;
	mso-fareast-language:EN-US;}span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span lang="EN-US">Hello Andera,<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Thanks for your answer,
            but we need a duration time of a specific TPASS/TFAIL. Do
            you have something like this?
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">If not, can you point me
            to which line in “runltp” I can add “time” linux command to
            get the duration time of it?<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Thanks,<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US">Zion<o:p></o:p></span></p>
        <p class="MsoNormal"><span lang="EN-US"><o:p>&nbsp;</o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0cm 0cm 0cm">
            <p class="MsoNormal"><b><span style="mso-fareast-language:#2000" lang="EN-US">From:</span></b><span style="mso-fareast-language:#2000" lang="EN-US"> Andrea
                Cervesato <a class="moz-txt-link-rfc2396E" href="mailto:andrea.cervesato@suse.com">&lt;andrea.cervesato@suse.com&gt;</a>
                <br>
                <b>Sent:</b> Monday, 8 August 2022 12:02<br>
                <b>To:</b> Chen, Zion <a class="moz-txt-link-rfc2396E" href="mailto:zion.chen01@sap.com">&lt;zion.chen01@sap.com&gt;</a>;
                <a class="moz-txt-link-abbreviated" href="mailto:ltp@lists.linux.it">ltp@lists.linux.it</a><br>
                <b>Subject:</b> Re: [LTP] Duration run time of each
                benchmark<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <table class="MsoNormalTable" style="width:100.0%" width="100%" cellspacing="0" cellpadding="0" border="0" align="left">
          <tbody>
            <tr>
              <td style="background:#A6A6A6;padding:5.25pt 1.5pt 5.25pt
                1.5pt"><br>
              </td>
              <td style="width:100.0%;background:#EAEAEA;padding:5.25pt
                3.75pt 5.25pt 11.25pt" width="100%">
                <div>
                  <p class="MsoNormal" style="mso-element:frame;mso-element-frame-hspace:2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-element-anchor-horizontal:column;mso-height-rule:exactly"><span style="font-size:9.0pt;font-family:&quot;Segoe
                      UI&quot;,sans-serif;color:#212121">You don't often
                      get email from
                      <a href="mailto:andrea.cervesato@suse.com" moz-do-not-send="true" class="moz-txt-link-freetext">andrea.cervesato@suse.com</a>.
                      <a href="https://aka.ms/LearnAboutSenderIdentification" moz-do-not-send="true">
                        Learn why this is important</a><o:p></o:p></span></p>
                </div>
              </td>
              <td style="width:56.25pt;background:#EAEAEA;padding:5.25pt
                3.75pt 5.25pt 3.75pt;align:left" width="75">
                <br>
              </td>
            </tr>
          </tbody>
        </table>
        <div>
          <div>
            <div>
              <p class="MsoNormal">Hi!<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
            <div>
              <p class="MsoNormal">We are currently working on a new LTP
                runner which is the future replacement of the runltp
                script written in bash:
                <a href="https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Facerv%2Frunltp-ng&amp;data=05%7C01%7Czion.chen01%40sap.com%7Cc9db0750bd484703a7d208da791cc4a6%7C42f7676cf455423c82f6dc2d99791af7%7C0%7C0%7C637955462366946140%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&amp;sdata=LZ1%2FvGgfDW0vME8ymCXHTkzVXlNjKnP%2BpRxuj%2FszxYo%3D&amp;reserved=0" moz-do-not-send="true">
                  https://github.com/acerv/runltp-ng</a><o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal">The new runner is written in python
                3.7+ and it supports duration time between tests. At the
                moment, it considers execution time of a single test
                binary,<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal">not the duration time of specific
                TPASS/TFAIL results as you might expect, also because
                the old format is still supported and it doesn't give
                this possibility.<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
            <div>
              <p class="MsoNormal">If you don't need to have duration
                time of specific TPASS/TFAIL , runltp-ng might be the #1
                choice for you, since it also implements a JSON report
                file which<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal">can be parsed easily to obtain the
                results.<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
            <div>
              <p class="MsoNormal">The runltp-ng source code is open and
                available to everyone, so feel free to help and give any
                feedback if needed!<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
            <div>
              <p class="MsoNormal">Regards,<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal">Andrea<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            </div>
          </div>
          <div>
            <p class="MsoNormal">On 8/8/22 10:17, Chen, Zion via ltp
              wrote:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span lang="EN-US">Hello Linux Test
                Project</span><o:p></o:p></p>
            <p class="MsoNormal"><span lang="EN-US">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span lang="EN-US">We are in SAP using
                your ltp benchmark in our linux machine. We are looking
                in the results file after the run is finish and we want
                to know the duration time of each sub-test.</span><o:p></o:p></p>
            <p class="MsoNormal"><span lang="EN-US">Can you point me how
                to do it? How to find the duration time of each
                sub-test?</span><o:p></o:p></p>
            <p class="MsoNormal"><span lang="EN-US">&nbsp;</span><o:p></o:p></p>
            <p class="MsoNormal"><span lang="EN-US">Regards,</span><o:p></o:p></p>
            <p class="MsoNormal"><span lang="EN-US">Zion </span><o:p></o:p></p>
            <p class="MsoNormal"><span style="mso-fareast-language:#2000"><br>
                <br>
                <o:p></o:p></span></p>
            <pre><o:p>&nbsp;</o:p></pre>
          </blockquote>
          <p><o:p>&nbsp;</o:p></p>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------9E0a7lIcp8ZlBSrHe29pFfVr--

--===============1516114897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1516114897==--
