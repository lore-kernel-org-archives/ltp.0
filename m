Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB2C4332F
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 08:16:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBDD93CAEE8
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 10:16:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FA903CAD00
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 10:15:53 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D9E571000A1B
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 10:15:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj5+p82MDePZWL3n0y5ww7vMyDSniFFATLRbI/Kph3OGw8wY+0g+vVAt6Wb/L0DKa9X26Bpw9cM98TCyZ+cTtewJ6kCLknA9MWUdjmDzX96vANcTtOtDxXWlsuwPGH7RkbpFM2OOXQpRL29OzPXcFTYG1COANVSbOht0Ah2MgpPcHUGHixLSG6jMtZxjX8UaSsjWTW0sk6RPJ1YXCxe1ZsvEL2Jd5P25Pio/dpwncKxu1UxQQWXPc6dth1b94TGDrP1v9pQr5XSFetmoB6rkMFf7ETo0QCtX1K16bMmSDSKL3LW/EO+0dAy/mA+BhlOwmp95P1FpCGcm65cijmP/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkJ/heqLRYFFGGCxxnDyV7uq+VSmhPuZl8+Aumndk4o=;
 b=S6Nn9JCFlRJE47ZiaKfZUrf7oHjaCJ0ybcnkSZ6tHmznQbdqqw8QRrJp6RZ5z9/+UV/Zi5HbKLiWLE2xNsdadNpj5hdxgjQFt2dzrY/lsWGt1mU49mjGfukFK2UXByGURq6VMsywoD2wiJvy+6iM7acAXU88/+iodTpER9fRr3G0FS7VA2k5bVCz9+WQwFovI46izGP+x/oqhvSbtJz4ybFgTlDv9QVj4H17L9+JGW0geItB+z1L6iHFj9EPozwyWKtS66LYtPvCcl3daDQO02Oeh08bPGjZTlP5+VqB5fVF9DfW8ZdlvdqVB7KwYledMOyL4gi1Q72zgxrB2yO9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkJ/heqLRYFFGGCxxnDyV7uq+VSmhPuZl8+Aumndk4o=;
 b=Tf7aTEgJX1lE/oNOPYHhovHogt0cWM/xwVJpBPXX38p+Y3huKKjH6mJ6a5CKY5iEYvk92qW4BGhY+t63nhG+4WofXz0QKg6w6YTOenPOkzGmcKcuEVA6ysbTWrHZNAt1QXOrmRMpqYTW6yIbUpdJ76rgTHAXu/XSezxrX5W5TcODJ7Qc5fUs3V/gjmy0hrOj+pwp4OxvjbyzDXABCsceoFrIHR/NMGsQwk9mXPs1ivwgkDdbM8tH6MBp40HnOtSM0J3nW9Aioar7/9tP6dxP6xAZrSaHGj6l5imbtQm6e5bEufJfleJlbJDMGuLtN9/fMrm1jN7o3RPBmvJun/PULg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM8PR04MB7922.eurprd04.prod.outlook.com (2603:10a6:20b:249::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Thu, 13 Oct
 2022 08:15:51 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::70f1:c68e:b73f:d399%6]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 08:15:51 +0000
Message-ID: <79bf7590-6459-3653-54d1-60125e6b6b30@suse.com>
Date: Thu, 13 Oct 2022 10:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220617085914.22034-1-andrea.cervesato@suse.com>
 <Yz/ukhT0a+CDb/UB@pevik>
In-Reply-To: <Yz/ukhT0a+CDb/UB@pevik>
X-ClientProxiedBy: AS9PR07CA0037.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::12) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM8PR04MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f7fc42a-3d12-4f88-5ff9-08daacf32433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YzqAnxJkFBE6i4Cqr6PliDDflNFNENuMvyrpPdGlgBLV9JVEkEcLw//NfYYeomE3Apz4rbIkvQn1IM8zhnxK6OsEOSML8qvklcP79JII0RoxF2/wgjQ9Crl2acipfDIwuwh3gxsO7Kc4Xroltgebjuw39p+oetOXmCqpcX6/x3ZoOm3mBM91Zz+gDEvRmqm1WCdksYt9wVYQERJK+e7dRiU6w5M+rbCxWo08RHrtUgejGDrKPFrwydLEyOxr19nkd0FjLEZzaTSOsHhe55qjmYbCaR6GgZDl8tAHSwq1qvN9PlBOJOw03UxDD8zw0IlNzP1kxhlABpc83dfLQrGOIpXkFBFs2xYhxxgcadtDwdeJucQ8H3/TuasbAWeno1Nru3QekHb02Kba0OQCwDMRn04qls5bvCYVE4TdgY3RlchtSuhb/PGKX/KKF/9iHDbScXVLHDydkPPFmwC3faL47t0X0zVs/tB4V8BgnI4CMUMsLlfcG1F4lgeaJVmy35arpWY8cmObsJW4W29ipJDZ+Z+95YD2gPyOm+St/Abo88X2v8u/fxrY11+EXQUERuYLnpvVdVIebXS47dcnLUKQjqEhN2HimPpKy4PREOD78sSk8Bl+ifQeuV+Kr9kJMCOlu9x+Ql+kAfhEknDkd6ZLp+h0OlEAJNzzNgjmsH5p2s3/orXjjFtNqBhARdvEwnHctg4K55+nD40dr9Zrb0TD2EKhvqTEo/xgoNSk9Osmj16grsf0XLABfi1mWe26mVhFtSPq2K+7UmqTnzuKPRbL7OFjb/OLytKXR6JmDkHXSZs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199015)(26005)(6506007)(53546011)(31686004)(38100700002)(66946007)(8676002)(4326008)(316002)(66476007)(66556008)(2616005)(36756003)(31696002)(6486002)(6512007)(83380400001)(6666004)(478600001)(6916009)(44832011)(41300700001)(86362001)(8936002)(2906002)(186003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldxK2ppS201QTlxd0puZDlMWWwrNkVvL0pXY0lNM2g2cGVTTVk4UUZPbU8x?=
 =?utf-8?B?ekRndUViK0hKdlNlOEdVTnBhUmYrMzJyRUJIOFB1NmxmZnFVdkR4VzJaYjhZ?=
 =?utf-8?B?eGFVZEs3U05QQ2EwNUE4aE40QmFQM1VTTk15aURGd00yTk43MmRsNnpzWW9n?=
 =?utf-8?B?RUUrTktYOTJtYWdxQnFFK2FTaEtsTFlBVXJjMFM4QjVNTzRXcUsxOThIRjJq?=
 =?utf-8?B?YTIvOGZaSjJZQldEZ2p2dy81bnhXQU1yZTYyamRYbzh4dytWOTkrK3V6Y3Z1?=
 =?utf-8?B?VWFLMVhtSVNEMnJlUzJHbGdJNk1FYWNtK0JoWFBCZmpZYTErNktacC81QWFC?=
 =?utf-8?B?WDRoa2RNcHJSVUFSSmZmTUJ1MXFHK25iaU5STzAvREdYSWRWc0hwTDFYQ2p6?=
 =?utf-8?B?TmFTNlJlZVJISldOOEZLK2ROWHFQK0VtaTVqZTFoQXZvcCsycUJFT0s0M0E4?=
 =?utf-8?B?TGJrSEN2RHBnakNmMzBsZW9XSk5odll4cmZQenA3dkJzdkZ2MGtYS2ZGTmZY?=
 =?utf-8?B?QTZwUnUycEdoWE5kbklYR2ZOZXZFSUs5NWZmcSsvS0t4eFdNbnNHZVR3Z0Iz?=
 =?utf-8?B?VHIydlI1eFJGTEs3TGtwbEtyZXVkZzR2Z2l1Tmh0UVAwbE4yUEtLTS91K1N6?=
 =?utf-8?B?SHRmRXpWeDlaSWhVcno5czVHcUNESFY2cVUwSiszL2FxSWordWQxelArWkV3?=
 =?utf-8?B?VXBSRmpKK2hZcG9WRm5CQzJ1bkRXQnVtNlFLdEVUaGRtbmhqMW41Vm14Z1dI?=
 =?utf-8?B?RDd2bWpBTndCMWpFUHZjWUlkb1BIQk4xWElCcFhaRmJyVVdvMDFySnVodk5I?=
 =?utf-8?B?OGwzSDJObVhzSkhlMEV3SzFuSmRXNi9wZFc5VXp3RkFxRWRUMklIc3VsNVor?=
 =?utf-8?B?cHBueEtEQWw5TFFNU2hISFdybXVOYWpIV0lDcjVESi9nNUd0bjUzTUJNblds?=
 =?utf-8?B?ZmpXcWhJUkZEMktQL0JNUGhMT1VGaFNKbGVkc1VwdDRlaEE5bGNDL1luK1k1?=
 =?utf-8?B?M2ZXRld0YmNtRFRxL3VOcmc5aEpSRm9TV0tBUVEyVUhBZU1mcS9qZGJ1OHRP?=
 =?utf-8?B?bk43MFc2cGYrRklLcXBsY3J4ZlFDWE9mTXVYS0o2STZMWFJYUEtpWEFRU0k0?=
 =?utf-8?B?cDRPejBKdHV4R0RTQ2wraDVvWjBQUkxwYytCOEJnYUYrc3ZpN3BZVyt6eTRC?=
 =?utf-8?B?cjY3eHFFaWNjMjZGQUpGZUxicVhvd3RhcWVxL1FDNXVFUU1zQXZJejVRdnZJ?=
 =?utf-8?B?Zkd3NllhbWdRSlAvcTNtRnYybFVXMjRKZnhuRzNYR3dKdFcvNjBhNmk1LzJY?=
 =?utf-8?B?UEZwcnlDck53S3dXdTU3d01tOVUwMzk0YW5SYitKYmhtMnhLcTBqOGlENzkr?=
 =?utf-8?B?aE1jOEpraVFJSC9FaFJpY0VTZGZzWFpJbExHNlVyQU9XZ3crSlRlc3JQUHpO?=
 =?utf-8?B?RHY1RUt5UnRXVzZiUHU3TFVqeTdhblU0RkdtVWgvTjFzZjgyc3hYbHVJUmda?=
 =?utf-8?B?QU8wY1dOWlJtZzc3MXp6eXlPQzVoVWg3cU0zRzI5cjBzYzJUU1NPSWNwZ2ZX?=
 =?utf-8?B?TER2d0tZNDgvVEhzdCtneWdUNjFVUzNnVWg5ZEczNG5yYU5QblN5SzFiV1hw?=
 =?utf-8?B?cElLcmJZWVN2SVJKeEJ5WU9kaWFLT3FtaUFIRUxjY2J3Y29Oc3pTTkR2QkxL?=
 =?utf-8?B?V3I2QWFKaTB0RnZQTjN1emQwZWhlMzNzQjRKOGRXbk5uN28rQVNVWmNIUVNy?=
 =?utf-8?B?NFZ2VUZTMUVrNHNGaXEyOU82QWc2QU9xcGFRMitVTCtvZmJmTWFjbzlVOTc3?=
 =?utf-8?B?djBnaFpFV3laWjEra3l3dVpENUJBeWczY0tWM1NxdmlHZVEvNVExM3dRZVdk?=
 =?utf-8?B?WS9wZGNNZ0ZTRzVpWVJsSkNGVEx1T3NCSTdBTFBFTFV6NUpXRjA4RjViQ2NG?=
 =?utf-8?B?MW81OVhFT2RPOFNQcFhEVUdrNmhETUFNTWlUUEh4WUFxZHVabWFPcHQ4Q0NR?=
 =?utf-8?B?ZjBFZTZwYmY1NjFIdFFQMiszNDRNNlV1WVZBd1drbER0QWlybVVac1BhV1NJ?=
 =?utf-8?B?UGowZTdINndWRC9ZYkZPWU1kaXc1T0hMRDlMOGczaThvczltNk51Q2hFS1RH?=
 =?utf-8?B?b3pGdm1uTW8yMyt3MG9qa25vdzFVZEhnQmVEMVdPLzhKY1RnUkovdm9rdWN1?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7fc42a-3d12-4f88-5ff9-08daacf32433
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 08:15:51.2587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVKoGILJ7TCOfElHJ3r7Jc0X1+TK3dExA1B7MmzC/bpNSCCJEr22I4vWu6ChyogzEIuHTQGjkurmfsgHdasZ05gI/AXbhWp4e9Xcp/1do9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7922
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] Rewrite aio-stress test using LTP API
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

On 10/7/22 11:17, Petr Vorel wrote:
> Hi Andrea,
>
> below are just minor comments about options and doc/help.
>
>> diff --git a/runtest/ltp-aio-stress.part1 b/runtest/ltp-aio-stress.part1
> ...
>> -# aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]
>> -#                 [-i num] [-t num] [-c num] [-C size] [-nxhlvOS ]
>> -#                 file1 [file2 ...]
>> -#       -a size in KB at which to align buffers
>> -#       -b max number of iocbs to give io_submit at once
>> -#       -c number of io contexts per file
>> -#       -C offset between contexts, default 2MB
>> -#       -s size in MB of the test file(s), default 1024MB
>> -#       -r record size in KB used for each io, default 64KB
>> -#       -d number of pending aio requests for each file, default 64
>> -#       -i number of ios per file sent before switching
>> -#          to the next file, default 8
>> -#       -O Use O_DIRECT (not available in 2.4 kernels),
>> -#       -S Use O_SYNC for writes
>> -#       -o add an operation to the list: write=0, read=1,
>> -#          random write=2, random read=3.
>> -#          repeat -o to specify multiple ops: -o 0 -o 1 etc.
>> -#       -m shm use ipc shared memory for io buffers instead of malloc
>> -#       -m shmfs mmap a file in /dev/shm for io buffers
>> -#       -n no fsyncs between write stage and read stage
>> -#       -l print io_submit latencies after each stage
>> -#       -t number of threads to run
>> -#       -v verification of bytes written
>> -#       -x turn off thread stonewalling
>> -#       -h this message
>> +# -f       Number of files to generate
>> +# -b       Max number of iocbs to give io_submit at once
>> +# -c       Number of io contexts per file
>> +# -g       Offset between contexts (default 2M)
>> +# -s       Size in MB of the test file(s) (default 1024M)
>> +# -r       Record size in KB used for each io (default 64K)
>> +# -d       Number of pending aio requests for each file (default 64)
>> +# -e       Number of I/O per file sent before switching to the next file (default 8)
>> +# -a       Total number of ayncs I/O the program will run, default is run until Cntl-C
> Could we have -a500 as the default value (and thus remove it from runtest
> file)? IMHO it's better that run indefinitely, because it dies with TBROK after 30 sec on timeout.
>
> also could have aio-stress -h sorted output? (easier to read on so many
> options).
>
>> +# -O       Use O_DIRECT (not available in 2.4 kernels)
>> +# -o       Add an operation to the list: write=0, read=1, random write=2, random read=3
>> +# -m       SHM use ipc shared memory for io buffers instead of malloc
>> +# -n       No fsyncs between write stage and read stage
>> +# -l       Print io_submit latencies after each stage
>> +# -L       Print io completion latencies after each stage
>> +# -t       Number of threads to run
>> +# -u       Unlink files after completion
>> +# -v       Verification of bytes written
>> +# -x       Turn off thread stonewalling
> nit: I'd remove these, IMHO it's not worth to sync this with aio-stress.c.
> One can find getopts string in aio-stress.c.
>
> ...
>> -ADS1050 aio-stress -I500  -o1 -O -r256  -t2   $TMPDIR/junkfile $TMPDIR/file2
>> +ADS1000 aio-stress -a500  -o2 -r4 -f1
>> +ADS1001 aio-stress -a500  -o2 -r8 -f1
>> +ADS1002 aio-stress -a500  -o2 -r16 -f1
> nit: s/[ ]+/ /g
> (remove duplicate space)
>
>> +++ b/runtest/ltp-aio-stress.part2
> Both applies to this runtest level as well.
Apparently we don't need part2 anymore, because we replaced $TMPDIR with 
.needs_tmpdir functionality and now some tests are duplicated. I add the 
remaining part2 tests which are not yet in part1 and rename the file 
from ltp-aio-stress.part1 in ltp-aio-stress.
>
>> --- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
>> +++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
>> @@ -1,51 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.0
> I wonder if we can relicense to GPL-2.0-or-later if this is SUSE copyright.
> I suppose we can't.
>>   /*
>>    * Copyright (c) 2004 SuSE, Inc.  All Rights Reserved.
>> + *               Written by: Chris Mason <mason@suse.com>
>> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * [Description]
> ...
>> - * io buffers are aligned in case you want to do raw io
>> + * aio is done in a rotating loop. First file1.bin gets 8 requests, then
> nit: s/io/IO/g s/aio/AIO/g
>
> Kind regards,
> Petr



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
