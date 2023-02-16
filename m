Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7903C636CC
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 10:35:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE1DD3CBEEB
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 11:35:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C6E83CB10B
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:35:21 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe13::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2D4F5600972
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 11:35:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1XtA17WobVdGo/oPft1wxqic1Keyy2oOu46C/GAxauQMzlk4eftIjShveXjHlfeoxUy0ejBwa4Gd6Xn+I8vA7BfffM4V0HBfgUDJdixtmSWIndfYlAwMKkdn29ak1t5561qTTXK6SanbCsHPUyZC1ZUNQOltwtHexBfwO4M2NXAaI4+fHKSoMa7TSQibav/lLHboV8Ea/3CjEWW2ABwy4eYpF1c8u3F7HNPnnRVUJHlYYWCa8HRTY+EzdQghKXQ0VZIpNrX4edaw1mmGHvFm0Ht2njHALoClWqt+6scI03h+AyPqkq8+vBL34+gYD9RRN+hSdeXKIjavTdPtTT2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXORImPsUQJEhI9Ehd+kFLudveUPVDcbR5o2nho56js=;
 b=nmcH/KtEnbth3OTHtUKulhCXmV7O8xCyuAe7vuzV8QkdCoZ6XA0kDqzJvJf/oIiOPu9f6EUCJgD2yMf2874D3vTAIxC2Pqb3b2pF/J5l7agdior3gfFeHQL1I0OqmascIExiEvSelP4ldyu6WfMt8qKKV1qYzUnZti/sJLZTsKKirOfQelcOvFJs2h6u1CreeJK9bS2x2PDAMWyRHgRt4zYRCBYMjB6U0CnBZr6sAjuauZ08YGQ4b3phpDLW2zp6lhs4gP5wblyfdW9w1CzjMBQ60wz0MNlZmmUjIjEjAzjlcwGlMDhwvahEskppYJixQy8sfdssV8wQzPMG7G3/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXORImPsUQJEhI9Ehd+kFLudveUPVDcbR5o2nho56js=;
 b=xN0TJF86YzIoZjDzRWlVIE9eOFwloDwOAXxh45lFRtL5/FXP2x6/d9d1JOuJCBQFkKjWydxqBJ4R4z3sIuvXUsEgiZxFjXM8ZUEngZNQ2sNJVmBtWcVhDEHESnWojTM7R3hBGXFt/5OTdRvQ+nJH5t665D7rEuDtsAc76sOGsvvAAzkWhQ7E7VoLUolniLfH3Y3bgrMGKL1sYW124wob6UCgWhjEL4p7MsgpgnWOgH7uOz7DmL2iob/2L3Nqsan9/xEhitekrgnslZ5g4nB1W10wcPjVXbhYOHvNAvDG6GpErMTxSxhuc5FmNqpW3y/hLN39jmkPelX+dl40E8zoFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13)
 by AM8PR04MB7332.eurprd04.prod.outlook.com (2603:10a6:20b:1db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.12; Thu, 16 Feb
 2023 10:35:18 +0000
Received: from VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca]) by VI1PR04MB6797.eurprd04.prod.outlook.com
 ([fe80::e6db:281a:b03d:39ca%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 10:35:18 +0000
Message-ID: <553906af-fee1-1fec-b8d8-9281a2afa7f4@suse.com>
Date: Thu, 16 Feb 2023 11:33:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: ltp@lists.linux.it
References: <20230216102942.11859-1-andrea.cervesato@suse.com>
In-Reply-To: <20230216102942.11859-1-andrea.cervesato@suse.com>
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To VI1PR04MB6797.eurprd04.prod.outlook.com
 (2603:10a6:803:13e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6797:EE_|AM8PR04MB7332:EE_
X-MS-Office365-Filtering-Correlation-Id: 71fb6e2c-797a-4896-4e4f-08db10097f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrhE/CG+BWoyEMBImdQxX+4zlh7L1at9z6d39FHfrMwSvhkjfKir+iUpEcBNG3WNiol3XKKQJiLbyW/mRHWr2Mjxh9DARW3Qhe8EtsZZJO5H8L9T0EGQeeKkVkRu9N7U6re470LUnQERB1vtDesnDFF1RY/X9wli6R3HfCmuIc45vkSqzfVmqLYgAHq2U8j0xBRkPvZO0114R32NpF3+yndPzYL7W2IZxkKBps4tRi/3PassyiZDctSkDOJA98050lFfdi6+HS0WTAPno0t/6mT8e9UiCpbuhawdxhmc/0Rq9t+uSKIJGL4A+Rp1R3LWReU1BEyV53iRI8tKA/o3L+tz3hlY5U2M86tIlxsPnpcxDq1aMwPyRBn0+HUMw5Z1NbB5Sejq2Qu5EqjFQ2ziEaiWDwc3SGXpI2U/Kqt+6CmDvM6YY5iInOHzs2NKBlt5F3/JlOHGOBU++5s7QupHhLAkfz+aIpGVszdjhEqcltzaiDPh1ycqttBWreEF/MW/UM/aEKY+ONO5t7c2EtdwxIHNrts5mwChoYzSSVU2qQ/GfxkNUFzRhbV68zEIrIhSK//s4IqTIkr3hpgk1LwZa0xnxyJvcVcThrhqzr/xJ6SYULgx1Zrzy2CWLdtZQ9FrxucUq0pVWfwrzZbdBkCyAbJghZt59iNQ/W71sNvw5s1hwcscmkbAI3q9dPukjK7TA2Ls9HENt2sPZXDaKxqhQjxSqgxO07jE9zh8j8cCFz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB6797.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199018)(2906002)(31686004)(83380400001)(5660300002)(44832011)(36756003)(41300700001)(31696002)(86362001)(8936002)(66946007)(6916009)(66476007)(8676002)(316002)(38100700002)(66556008)(6506007)(6486002)(2616005)(6512007)(186003)(6666004)(478600001)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2lXaDUwbTAyUkF1VS83UklOV05WbTRPai9INldtWmJiMFVjVy9ybENUaFo2?=
 =?utf-8?B?Y0hXcEJoWGJuS2JyaW5VR1pWQmlKTkZ3OUZjVGcwa1ZKM3FMY09hQmJjK1Fk?=
 =?utf-8?B?Y0JISk1XQ1JLVDlUREtQdUQxd3RBWWNMemszRjMwTGVOL05NVFVMaCtUbTBI?=
 =?utf-8?B?b21lMmRlbjBKWEQ4NjVXRWpKMWdMRUJSbHJQeHJsd0RVcmpFMm51UVRZczNt?=
 =?utf-8?B?VUtpZFZ5bkpieDN3ZnZMY2YyY2NhTHdISFpiUUFTTjFIai9hTGdOR1p0Z095?=
 =?utf-8?B?ZlJvSk1tSHdIbXFlTVE3K3pBSTFzSWU0bG0wMS9mbzQ4MmdmeEJFeENaMjk1?=
 =?utf-8?B?QjBtaW5majQrM3grYmJDLzZDMGZKQTVTcWV3eGVSb1NnNExDV2RLcURJNDhR?=
 =?utf-8?B?VmFOR3RBb0tPakhwZEhMSlZFWG8xcUZtY2U3Y1ZkTWdVbS92K2VUVWlnTjcw?=
 =?utf-8?B?eVdYaVZib093L05xMTFVZFJZWFp0Lzl4OEVwU0N3R0tHbCtNd1V6TzRkcTUw?=
 =?utf-8?B?Sk9qbzY2YThreXh0MGdVa1JzZzFPY2FiaUlReURPU0tPZVVVN2JrTDRDVHNM?=
 =?utf-8?B?R0IyelI0TG84ZzVaaEk5TFF4emE3eGQvN0RJRW9pT2grMTVKcTlvL1l2Ympl?=
 =?utf-8?B?aEo3NXE0SU8yRGMyYk1TdHZVK3luRWpWd2duczJJSnYwOGw3RE10ZStuYUk0?=
 =?utf-8?B?WGRGdTJ6bWR1YXVZY1VneEVIOUlLTko0SlczS2ZRSzQ0NnhmWGZsWGltbTVy?=
 =?utf-8?B?V1I5ZEdFQWswT21VZXkvQ0lIL2hrY081N1c4dVVSNUo1NzlzRlFLMVp2T2dk?=
 =?utf-8?B?bUR1THFOaHh3Y3BYZVlOVTZEdy9GTUFGT21YeGJKSVZJdEhsSG9xR3dWM0tx?=
 =?utf-8?B?L0RQaGxDSG1OMldTNUdvRXYxRnZBR0U4VFJCenpsN0p2WEFKdEthKzE5STg1?=
 =?utf-8?B?MVVmdGh4cVdUOXBNbGV5bVpVRU9NNDBQSHo4ZWVIeGpGY2F1T21LNGFmUEFD?=
 =?utf-8?B?Y1dWZmVOZzRlZmxNU2Z6dmpURFVXcnlrNTU5ZjJvME5MMXlsMTVxNm1CUXNC?=
 =?utf-8?B?aDRETUdiZUJ6ZElMV05LTHhDYmRUMXV2TTVTbjVxTzNhd2hVMHBoMGF4RkU0?=
 =?utf-8?B?Wit1Zld5c3NoUWhrbFpLek1MMjNZSFFIcXR3QUZuRm1WTTk0V2t0aTRGZSsz?=
 =?utf-8?B?SElrYVQrVGdsZUlPUFZ2Qk9wRnFwcldFejR4ZW9NVXZlTkpXNkxhU0daaUdx?=
 =?utf-8?B?LzViWGJPUzVIN2xUcHJvd1RRUDNGdnVLNlF1YVlNaUxKb0F3ZENzZmdITDZV?=
 =?utf-8?B?M09MaytDN1czMXplVThRNTAzMXcwbWFvM3ZlTHF6SXJiMDFDMTF5RmZ6d1BG?=
 =?utf-8?B?YW1HK0cvbFF4MllVV1NWa0lkWklwaUI4RGZjbVFvbUZrZ1pyV2FhRktLSmJ2?=
 =?utf-8?B?UldLRjBMQUREcEZVWnM1VlY0UmVqWEIzK0RvN3RJMHZ3OFZWM1RxMmRqbFhp?=
 =?utf-8?B?cU5IV0ZRRGFmOVFXQzhqN2JuVzFwUW9tT0ljN2NuZlpDMzNhNVVRdXlPNyt2?=
 =?utf-8?B?QS96OW9RMk1tbTB4WUVleVJzeGowRmtHbmFvWXhoRVc4eGNIaHptcUk0SkRM?=
 =?utf-8?B?QXY5WjIrNGJOTWdNTmU3aHVndDhXMW9Cc0ViMXdxK3NReUNMSDBiVE5DeW90?=
 =?utf-8?B?T3Vud0VDT2RDdzRQWkRhVkRMRVF4NTNtRnVmWk1tSkVndGJtd3NWYjdSWlpM?=
 =?utf-8?B?NTc2RXhzZ05YWG1LMEpPb1B1dGVJOENuM3crTnRxbFl0WVJvbUNjS1lOem1Q?=
 =?utf-8?B?TlZKY0g4dGhoUnFxSjlnR3BOTzY3ZVFZaWdOdDhjNDJyV2xYMGNTcWtKU0JX?=
 =?utf-8?B?Mk9qVmg0ZC9NN0tIOW15VDNtTlJKRFpjdjVYNFozRnBWSlB5Nk1pWE5VOHV2?=
 =?utf-8?B?Yk53bGNFQ2hRcDBRMDJhNENuaSs4T3RNbmdwOTIzMUJRMDRFZGNCSXM3WnBz?=
 =?utf-8?B?TUNqUmVRQjBPbFVkeVFCb0JqV0lSSTROcmt1T0xKK3l3Tjd2bno4SUNkbkxt?=
 =?utf-8?B?STFndEhBWnhOSmgzSytncStJNnRQM2wyQzFPeUE1TU5HMXdTTWlOMnpUYkRB?=
 =?utf-8?B?eW5jMW1WalU4VG9QYWVNL1VMS3luMjcveXk4MThxNzdPSVg4YmxNR1M4RGhi?=
 =?utf-8?B?WVZIR1IrSDJnMzZtK2E4YlZnVVk3SnoxRDdmSXlqc0lOaElSb1JXdnVTVGk4?=
 =?utf-8?B?S0hUSWVtbGxQZ2V2aktwZG44UWpnPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fb6e2c-797a-4896-4e4f-08db10097f2b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 10:35:17.9538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1+JUa+XSwRx4vsTzUv5AhhBZr8tu2QMCAm4Ep+q0sEJ4h64MMyGh0eImotnX4esjxZ5vapaRFJwPJNeba9YFFz99j7m/Vt8dW0fJ3sejb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7332
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Remove ltp_quick_clone from mountns testing
 suite
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

Hi,

beware that in the patch name and description ltp_quick_clone is 
ltp_clone_quick.

On 2/16/23 11:29, Andrea Cervesato wrote:
> ltp_quick_clone has been replaced by SAFE_CLONE in the mountns testing
> suite that now is independed from libclone and legacy API.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   testcases/kernel/containers/mountns/mountns.h  | 18 ------------------
>   .../kernel/containers/mountns/mountns01.c      | 16 ++++++++--------
>   .../kernel/containers/mountns/mountns02.c      | 16 ++++++++--------
>   .../kernel/containers/mountns/mountns03.c      | 16 ++++++++--------
>   .../kernel/containers/mountns/mountns04.c      |  2 +-
>   5 files changed, 25 insertions(+), 43 deletions(-)
>
> diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
> index 615f1a058..9bb854659 100644
> --- a/testcases/kernel/containers/mountns/mountns.h
> +++ b/testcases/kernel/containers/mountns/mountns.h
> @@ -8,28 +8,10 @@
>   #define COMMON_H
>   
>   #include "tst_test.h"
> -#include "lapi/sched.h"
>   
>   #define DIRA "LTP_DIR_A"
>   #define DIRB "LTP_DIR_B"
>   
> -static int dummy_child(void *v)
> -{
> -	(void)v;
> -	return 0;
> -}
> -
> -static void check_newns(void)
> -{
> -	int pid, status;
> -
> -	pid = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, dummy_child, NULL);
> -	if (pid < 0)
> -		tst_brk(TCONF, "CLONE_NEWNS not supported");
> -
> -	SAFE_WAIT(&status);
> -}
> -
>   static void umount_folders(void)
>   {
>   	if (tst_is_mounted(DIRA))
> diff --git a/testcases/kernel/containers/mountns/mountns01.c b/testcases/kernel/containers/mountns/mountns01.c
> index e8f176920..c5b6077f1 100644
> --- a/testcases/kernel/containers/mountns/mountns01.c
> +++ b/testcases/kernel/containers/mountns/mountns01.c
> @@ -33,8 +33,9 @@
>   #include <sys/mount.h>
>   #include "mountns.h"
>   #include "tst_test.h"
> +#include "lapi/sched.h"
>   
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>   {
>   	TST_CHECKPOINT_WAIT(0);
>   
> @@ -51,13 +52,11 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>   	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>   
>   	SAFE_UMOUNT(DIRA);
> -
> -	return 0;
>   }
>   
>   static void run(void)
>   {
> -	int ret;
> +	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
>   
>   	SAFE_UNSHARE(CLONE_NEWNS);
>   
> @@ -67,9 +66,10 @@ static void run(void)
>   	SAFE_MOUNT(DIRA, DIRA, "none", MS_BIND, NULL);
>   	SAFE_MOUNT("none", DIRA, "none", MS_SHARED, NULL);
>   
> -	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
> -	if (ret < 0)
> -		tst_brk(TBROK, "clone failed");
> +	if (!SAFE_CLONE(&args)) {
> +		child_func();
> +		return;
> +	}
>   
>   	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
>   
> @@ -93,7 +93,6 @@ static void run(void)
>   
>   static void setup(void)
>   {
> -	check_newns();
>   	create_folders();
>   }
>   
> @@ -107,5 +106,6 @@ static struct tst_test test = {
>   	.cleanup = cleanup,
>   	.test_all = run,
>   	.needs_root = 1,
> +	.forks_child = 1,
>   	.needs_checkpoints = 1,
>   };
> diff --git a/testcases/kernel/containers/mountns/mountns02.c b/testcases/kernel/containers/mountns/mountns02.c
> index 4b85fa79b..c2260961e 100644
> --- a/testcases/kernel/containers/mountns/mountns02.c
> +++ b/testcases/kernel/containers/mountns/mountns02.c
> @@ -34,8 +34,9 @@
>   #include <sys/mount.h>
>   #include "mountns.h"
>   #include "tst_test.h"
> +#include "lapi/sched.h"
>   
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>   {
>   	TST_CHECKPOINT_WAIT(0);
>   
> @@ -51,13 +52,11 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>   	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>   
>   	SAFE_UMOUNT(DIRA);
> -
> -	return 0;
>   }
>   
>   static void run(void)
>   {
> -	int ret;
> +	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
>   
>   	SAFE_UNSHARE(CLONE_NEWNS);
>   
> @@ -68,9 +67,10 @@ static void run(void)
>   
>   	SAFE_MOUNT("none", DIRA, "none", MS_PRIVATE, NULL);
>   
> -	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
> -	if (ret < 0)
> -		tst_brk(TBROK, "clone failed");
> +	if (!SAFE_CLONE(&args)) {
> +		child_func();
> +		return;
> +	}
>   
>   	SAFE_MOUNT(DIRB, DIRA, "none", MS_BIND, NULL);
>   
> @@ -94,7 +94,6 @@ static void run(void)
>   
>   static void setup(void)
>   {
> -	check_newns();
>   	create_folders();
>   }
>   
> @@ -108,5 +107,6 @@ static struct tst_test test = {
>   	.cleanup = cleanup,
>   	.test_all = run,
>   	.needs_root = 1,
> +	.forks_child = 1,
>   	.needs_checkpoints = 1,
>   };
> diff --git a/testcases/kernel/containers/mountns/mountns03.c b/testcases/kernel/containers/mountns/mountns03.c
> index 1d26a25d8..357a4f30b 100644
> --- a/testcases/kernel/containers/mountns/mountns03.c
> +++ b/testcases/kernel/containers/mountns/mountns03.c
> @@ -36,8 +36,9 @@
>   #include <sys/mount.h>
>   #include "mountns.h"
>   #include "tst_test.h"
> +#include "lapi/sched.h"
>   
> -static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
> +static void child_func(void)
>   {
>   	/*
>   	 * makes mount DIRA a slave of DIRA (all slave mounts have
> @@ -59,13 +60,11 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>   	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>   
>   	SAFE_UMOUNT(DIRA);
> -
> -	return 0;
>   }
>   
>   static void run(void)
>   {
> -	int ret;
> +	const struct tst_clone_args args = { CLONE_NEWNS, SIGCHLD };
>   
>   	SAFE_UNSHARE(CLONE_NEWNS);
>   
> @@ -76,9 +75,10 @@ static void run(void)
>   
>   	SAFE_MOUNT("none", DIRA, "none", MS_SHARED, NULL);
>   
> -	ret = ltp_clone_quick(CLONE_NEWNS | SIGCHLD, child_func, NULL);
> -	if (ret < 0)
> -		tst_brk(TBROK, "clone failed");
> +	if (!SAFE_CLONE(&args)) {
> +		child_func();
> +		return;
> +	}
>   
>   	TST_CHECKPOINT_WAIT(0);
>   
> @@ -104,7 +104,6 @@ static void run(void)
>   
>   static void setup(void)
>   {
> -	check_newns();
>   	create_folders();
>   }
>   
> @@ -118,5 +117,6 @@ static struct tst_test test = {
>   	.cleanup = cleanup,
>   	.test_all = run,
>   	.needs_root = 1,
> +	.forks_child = 1,
>   	.needs_checkpoints = 1,
>   };
> diff --git a/testcases/kernel/containers/mountns/mountns04.c b/testcases/kernel/containers/mountns/mountns04.c
> index fc392f1a7..6a64c2443 100644
> --- a/testcases/kernel/containers/mountns/mountns04.c
> +++ b/testcases/kernel/containers/mountns/mountns04.c
> @@ -22,6 +22,7 @@
>   #include <sys/mount.h>
>   #include "mountns.h"
>   #include "tst_test.h"
> +#include "lapi/sched.h"
>   
>   static void run(void)
>   {
> @@ -46,7 +47,6 @@ static void run(void)
>   
>   static void setup(void)
>   {
> -	check_newns();
>   	create_folders();
>   }
>   



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
