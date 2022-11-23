Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87961C4332F
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 10:43:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 107003CCA0E
	for <ltp@archiver.kernel.org>; Wed, 23 Nov 2022 11:43:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29F503C03AE
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 11:42:50 +0100 (CET)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CA34214002C6
 for <ltp@lists.linux.it>; Wed, 23 Nov 2022 11:42:46 +0100 (CET)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2ANAWtHO021943; Wed, 23 Nov 2022 02:42:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=jKUnOOmZ7tiXlWPQSo/RUvTKsL8cVK5K5hjOPxbsXws=;
 b=c6q5xnIZzTpx1y0uawB8+7Gpr/HwV6Vf31tE4pszQNmKB0sHTX/7PguJwJrVXJG69V2s
 Yxk+yncx03+D7MWsQGuKlTm6r42xTyEdUGFKf3m49QbMZ6uFh9+I6U0kua+9W0kyMZ0X
 zpXqg4jOhsesy64hENQFESmfau3XV2XlZ7yvJg3dywHJnKRh/RXgpcpvuTQucGIvuFmp
 6FZetEutFlPzF5A1jWQRg4b2NSxBMhMu5xPJ9RyrNNtYTuQ5WKtmt7MDvjuo1Hsi1RTb
 zCf6/e7JN682VzEigz2bf9qfY2jtf1ul3dMujmE37/GJed3nZpEGoUo/vYEYj2b9KeDT RQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxua6b7j7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Nov 2022 02:42:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTw08Onb0ke5EhJWk8EFBD4ZtayyS86M7GOo19xYJ/Cz0/2oyNbolciga95xII+R7ONOn34aqocUAyUKRsCNmAcCZmrnvlf7S/JdrMp+3UfKNvRA7zk27uQsv6XJFL3/i7ugmSTMwW0gnEpvgtZME1XXELsE1j0XrK1BN0vobLgPpdA+VAJ8a9hk07MNuo0UQoH0dmEHjdc9UZKVU1sSOhv/A1+AMtZIVeybufkk8fW5JuZ8/lEhtBCb2qZjOctLvTSIXf4AEJ9qUrn5sEsdRF/7BE4EBfoss4+yWqHwRc+8Kt1nXxEG2oZbnh4DGh1KsYJQcxHIlij2jO3jUO4W1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKUnOOmZ7tiXlWPQSo/RUvTKsL8cVK5K5hjOPxbsXws=;
 b=ZEYzh92pwfySd0fRdqKxnLSMHTn+XKntRs842qPDp5lMqZdES/ATm1Qs17ZLotOfmiZ166EoUfXaE84D07nydCB4wNtwP6AoA03IbzkIEk8cyxC+JqiKo/RITRSYQZsEebovwwfD3NSxwzC5aZexK+yLtFOMUQVjRNWcHFU0Oloy70WbJFABCIn05yfOre/Br89NRunreFuYLeS6XxxLZX0YaTv4KinJh93jmSDhM+Q0IDB2tYifIk4MwDLd5Zp95KZcLTzJw2Fu+GXHxIAlQH0Bpfr9Xzq7VggLimcImWAaaRxcq1aSETFJkWrNVYV/A84nK+iMgIhj+ekzJjhDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MWHPR11MB1358.namprd11.prod.outlook.com (2603:10b6:300:23::8)
 by MW4PR11MB7032.namprd11.prod.outlook.com (2603:10b6:303:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 10:42:39 +0000
Received: from MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df]) by MWHPR11MB1358.namprd11.prod.outlook.com
 ([fe80::fca6:eedf:ad46:d1df%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 10:42:39 +0000
Message-ID: <1e8d5914-ccf9-e309-27e2-e9644b58f4b5@windriver.com>
Date: Wed, 23 Nov 2022 18:42:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
References: <20221122081142.2433326-1-zhe.he@windriver.com>
 <9ab63923-591d-f6ac-ffc1-d70ed179415a@fujitsu.com>
 <564adcee-1f16-00ce-02e6-f8d64688d869@fujitsu.com>
From: He Zhe <zhe.he@windriver.com>
In-Reply-To: <564adcee-1f16-00ce-02e6-f8d64688d869@fujitsu.com>
X-ClientProxiedBy: SL2P216CA0132.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::11) To MWHPR11MB1358.namprd11.prod.outlook.com
 (2603:10b6:300:23::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR11MB1358:EE_|MW4PR11MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: bd807c56-7034-4869-2a12-08dacd3f702a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3MP/91lvUo4VPDLmsePtuoHCV7xfTe5a0H6a3ELdnuPf+GPsf5UJCj2VRLzmeyYA0kDo0treIBzxrfPcKviCARZTnGvAPv1dmiz5RuepSJKXqirxnu2gZtEm+WzUOd3iTyRv2M7CEM6/S1eiJPPFAd4rjgTtlBhgVG03nnEkjCEo6GkZeHECGiQJfrWwqjgLz8NuQj2xJlcd1k115AEjOAwo+OCk2H0kmNwE45zTgDUPpS1l9xhm3n8Q5pgur0GraARtaEiAu9FmaYaeWjA5EcsFGt9C0e9n2mm8plHnC31dBqAwm3QjRUcZSHhm2k0OOVNMVKxzX1QKp5mGvZUyX5eNH7haxaE6/vwFTHlNKj7YLqFpf8OzLtrqtckrgP2sGrS0iw/aDIIlfVLpcPAB8pAkRpANKpP+fUINk01yxMRtkQ0CKWV1n9b7i6Ev93UuvCFWRTqGLeA4RGikBa48i5sQ7SYKSktpLtTeNODOoS1qTg2lPM32oSUsTKQWrBnlru9jHV76ONlXU6J9SCVEZFeYKa2+2aCL2vqQz79wZqObCP2mBW1PdmB0o2PSQP8JBXmPnOjDnNJtyDVrnvrMmoOwfB5uNYwjhm5HrSMnQeurMPvGpxiKl3lkjJzUxvNFM1sI0E/QSiJ/VBOgg8g0kJv08OyT1l89AtUNC+HnZlvpzhm/CEp5ibV6CiPJCTfVCguuBdmsFEacwYUVsgPlhxrYiIhNzb8+sPC3YjyatBwOwLL7sK+iHwIrHjJnjH7R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1358.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39850400004)(451199015)(31686004)(8676002)(41300700001)(966005)(8936002)(316002)(66946007)(5660300002)(66476007)(66556008)(36756003)(86362001)(31696002)(6506007)(478600001)(83380400001)(6666004)(6486002)(26005)(110136005)(2906002)(2616005)(186003)(6512007)(53546011)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWxWOXBxOHhxNXZMc0FLVXVqd3paK3ZablJlc0Z6enRRY2hlUlF4b2FmZC81?=
 =?utf-8?B?ZXVKdzdyZ0Z4R3BmNFBWUXJZdTdTUUk0a0p3TjZtemM3b0d2UGNYNU44M0pJ?=
 =?utf-8?B?bnJ4eGVQNUh2OWFTNXdRU2U2cmphb2JWMUVPY3JLeXVOMFV3UlBEeHdLZ1VQ?=
 =?utf-8?B?Wis5Y1Z4Q2J4VmdxQlZTSjFEUFJXTmd5ZDVIVWpzTG1oUitUZ3NPbkR1anND?=
 =?utf-8?B?dmdaY1VRc2lCdjFuMS9IY25jRHV2ZEdPd3dEeGdQVG9HSFhXRU1wSXNrcXVq?=
 =?utf-8?B?SllYSDZlOEg3ZFhmeDEyeWRQUkhESWVUVHVFOHFyaEhtZTlxRC9rNkljS0hh?=
 =?utf-8?B?ZzU0ZFdwdXhreHBQeE1lU0loTjE1Mi9zZDI1b0JmRTFIZk1zd0syTHJ1L0d0?=
 =?utf-8?B?bGJhc3ZnenZ3Nm1OeVFlZHJHK2Nzdk0zUy9xRG9jcFQveFVYL0tZNkRjcGFu?=
 =?utf-8?B?YmFTM3UrMkIrTHFDUVIzdlM1K0ZwSWNZL3lCZG9aZGpvV00wOHJjVkkrYXNt?=
 =?utf-8?B?WnQ0YlBhRnpwRWNxNHpSTXFVN2g4Mk5oVzdidnZnalhVRDdwUnZWWXExRGRk?=
 =?utf-8?B?ZzJjbFhVV3VqaTlveEQ0cE5hb2IzL1hWdEkwY0hkeCs0eFZzRjZLdTJJUkhE?=
 =?utf-8?B?RmlaU3hyVHF4WklUVE11bVFDQnlaUGJxTjFvcVNDbnlxdFVnU2x5RjA4cE9Z?=
 =?utf-8?B?Z2d4ZlhBK1VBVFkxYWVldXRGU21XYkc1NE0wMDZ6dU5aOUkwUEQ3SkExSFNO?=
 =?utf-8?B?ZU1iejNiQ2R3UmErN3h1ajJycjZjbXllUE5MU0E1MVdqSnJUbjlENllIZ0Jw?=
 =?utf-8?B?U0FHZkhVa1NUL1IvcE1sUTh6cWp3U0Q0ZWlObmJWSVI1V29kNGRiRHBVeDE0?=
 =?utf-8?B?K3VHbDFlM1p1YUhaalBFdmZCTWlGNmdvUVlianRBM0JRNlFoUElZU0QxVFJs?=
 =?utf-8?B?bTY5a0lseWYzdVk1QzhMZmVlOEY3a0RKOU1sYXhJemhBNnpJWEJDellISFZ4?=
 =?utf-8?B?WnVvTi8ySE5MY3B1YWlaRWlmMHRIZXhxdWJZUEF3eExaUDBOZWZNRHJiOHVu?=
 =?utf-8?B?dXdVNEloZytCbWV1eGh4N1VwUDkrbXV0QWdEUmk5RTlPamF2NXFoNVZ2SnJC?=
 =?utf-8?B?OU9SS0tQOCtueFM2RUNONnZlam9YdVFLaEoxTHFlc2x0bis5MHpwd1FkS0U3?=
 =?utf-8?B?S2hpZmpnK1RUNXFtNWErSHRQV3IwZ2orb0tKcThJbzQwNUJVa2dXNlg1ZXZ0?=
 =?utf-8?B?Z2pXVm1mUko4TVh2bHJiQnZYbEV6dkxnaG5OeVFFQjlTd2tldzE4Rmc4cjVI?=
 =?utf-8?B?Y3lSY3ljQVRzTExmMjRaZnhLVW1tN3RabVN3VlpsMDF1U1FaUWFkeUJwV0hq?=
 =?utf-8?B?Sy9FUURZcnZpZFpKQlJnLzZhcnFmRUExTzB2N0RITzk0akFsUW4xaGlWZXNu?=
 =?utf-8?B?U0MzVUVxM2V5dWRwNnFtSHRzdmVEUjF5MFltM1FRaWZMbXBWcURXeDdMNjVR?=
 =?utf-8?B?eDduQlBhT3VKN2pLeXpQOU4xZEpORGVqMDkzRlFkdnFQK1Q1NEI4cEprRUdF?=
 =?utf-8?B?di85UE56ell1cHppM3k3S3EyVmk3d3lITHJFTE9Oc2lMT2dodEVxdTV3RFZ2?=
 =?utf-8?B?WVl6Yy9mQVlORTBtMW5Cc1Bud0ZKcWpwOFpNQXJ3ZmlNemhQc2UzMEtCaXpE?=
 =?utf-8?B?TFo1NmpSenUzRmFvOU9JcjRPNDBOUkNnOEl6N1NoWmRqa1A2dTFZVVRlUXNq?=
 =?utf-8?B?Umg4aXFxTk10ZmpaTjl3UUpmTDRGdHhJNnpRWVFhR1M1SWdQYlQ0Tk51d04v?=
 =?utf-8?B?K1NsZHVtWDF1K2ZxdkRBS01FK3dQay9wOU1VKytUZDZub3pnZHZJcmFRU25j?=
 =?utf-8?B?WksyL1FISFRTd3VvNVI5bDVmcmdickhEMnlIZzFWQUkya01rd2ZrT3U1dWFL?=
 =?utf-8?B?OUZ6NlRFWHloL3ZHcURra24zN1g4N1lpNGp4WEtXbndlV2JFNHhONmpIVmd3?=
 =?utf-8?B?L2dCQ0hFOGpUMFNvKzRZVWJhSXlBckhmUGVacTFFS2d6cG1OdU9pQUpzeXBV?=
 =?utf-8?B?UXByK0txOWVRSXJGTGYzd2JOUlhCUFd4dCs4NGN5WDR3RncwdWpaWGRRZERM?=
 =?utf-8?Q?5/oz8ixDacVO0Mh6z8Jz+Rqce?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd807c56-7034-4869-2a12-08dacd3f702a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1358.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 10:42:39.0259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JoDtOFUwLJ8JwT4bGM5gyf67pUn1TF5iYq4NFaDVFsyl9SpvLH+sVD9veMRD2S1jMNxSFDShL6f09PPGXh6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7032
X-Proofpoint-ORIG-GUID: dOtrj0pMqLku4z-COWm6TkB0QkXW5qmv
X-Proofpoint-GUID: dOtrj0pMqLku4z-COWm6TkB0QkXW5qmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_05,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211230080
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/prctl04: Fix false positive report
 when SECCOMP_MODE_FILTER is not supported
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



On 11/23/22 14:17, xuyang2018.jy@fujitsu.com wrote:
> Hi he
>> Hi He
>>
>>> The child process really should not receive the expected siganl, SIGSYS, when
>>> kernel doesn't support SECCOMP_MODE_FILTER.
>> I still feel confused, so which subtestcase has problem since we have do
>> check whether support SECCOMP_MODE_FILTER in check_filter_mode.
>
> It seems kernel without CONFIG_SECCOMP doesn't report errror when set 
> filter, so the previous check doesn't work.

kernel does report EINVAL as we can see 4 lines of "doesn't support",
corresponding to 4 filter cases, in the commit log. But later verify_prctl
doesn't realize it's not supported and gives a FAIL for not receiving the
related signal. So we add mode_filter_not_supported to inform it.

>
>>> This patch tests if SECCOMP_MODE_FILTER is supported in setup and adds a
>>> variable to record it.
>>>
>>> Before this patch:
>>> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
>>> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>>> ---- snip ----
>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>> prctl04.c:204: TFAIL: SECCOMP_MODE_FILTER permits exit() unexpectedly
>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>>
>>> After this patch:
>>> root@xilinx-zynq:~# /opt/ltp/testcases/bin/prctl04
>>> tst_test.c:1431: TINFO: Timeout per run is 0h 05m 00s
>>> ---- snip ----
>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>> prctl04.c:154: TCONF: kernel doesn't support SECCOMP_MODE_FILTER
>>
>> The line 154 and 204 is refer to origin case[1], so do you use the
>> lastest ltp?
>>
>> [1]
>> https://github.com/linux-test-project/ltp/commit/3ddc217d7b466f16782c257e29e18b251969edec#diff-6ae2f0e9ae152457424103cc20b7885e242f33f58b2e543b7941671f418d9485R154
>>
>> Best Regards
>> Yang Xu
>>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>>> ---
>>> v2: Add a variable to record the support status instead of exit(1)
>>> v3: Move mode_filter_not_supported check a bit upper to save a prctl call
>>>
>>>    testcases/kernel/syscalls/prctl/prctl04.c | 30 +++++++++++++++++------
>>>    1 file changed, 22 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/prctl/prctl04.c b/testcases/kernel/syscalls/prctl/prctl04.c
>>> index b9f4c2a10..d3de4b0d6 100644
>>> --- a/testcases/kernel/syscalls/prctl/prctl04.c
>>> +++ b/testcases/kernel/syscalls/prctl/prctl04.c
>>> @@ -93,6 +93,9 @@ static struct tcase {
>>>    	"SECCOMP_MODE_FILTER doesn't permit exit()"}
>>>    };
>>>    
>>> +
>>> +static int mode_filter_not_supported;
>>> +
>>>    static void check_filter_mode_inherit(void)
>>>    {
>>>    	int childpid;
>>> @@ -154,16 +157,17 @@ static void check_filter_mode(int val)
>>>    {
>>>    	int fd;
>>>    
>>> +	if (mode_filter_not_supported == 1) {
>>> +		tst_res(TCONF, "kernel doesn't support SECCOMP_MODE_FILTER");
>>> +		return;
>>> +	}
>>> +
>>>    	fd = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0666);
>>>    
>>>    	TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &strict));
>>>    	if (TST_RET == -1) {
>>> -		if (TST_ERR == EINVAL)
>>> -			tst_res(TCONF,
>>> -				"kernel doesn't support SECCOMP_MODE_FILTER");
>>> -		else
>>> -			tst_res(TFAIL | TERRNO,
>>> -				"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
>>> +		tst_res(TFAIL | TERRNO,
>>> +			"prctl(PR_SET_SECCOMP) sets SECCOMP_MODE_FILTER failed");
>>>    		return;
>>>    	}
>>>    
>>> @@ -208,7 +212,7 @@ static void verify_prctl(unsigned int n)
>>>    			return;
>>>    		}
>>>    
>>> -		if (tc->pass_flag == 2)
>>> +		if (mode_filter_not_supported == 0 && tc->pass_flag == 2)
> I prefer to use "tc->pass_flag == 2 && mode_filter_not_supported == 
> 0"because only one case's pass_flag value is 2, so we don't need to run 
> the latter to many times when kernel without CONFIG_SECCOMP_FILTER.

I'm OK with this.

>
>
> with commit message fix and this fix,

What does "commit message fix" mean please?


Regards,
Zhe

>
> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>
>
> ps:BTW, I think split this case into two cases by checking strict mode 
> and filter_mode is more clear ie prctl04_1.c prctl04_2.c, so we can add 
> these kernel checks by using tst_test struct's need_kconfig member.
>
> Best Regards
> Yang Xu
>>>    			tst_res(TFAIL,
>>>    				"SECCOMP_MODE_FILTER permits exit() unexpectedly");
>>>    	}
>>> @@ -218,7 +222,17 @@ static void setup(void)
>>>    {
>>>    	TEST(prctl(PR_GET_SECCOMP));
>>>    	if (TST_RET == 0) {
>>> -		tst_res(TINFO, "kernel support PR_GET/SET_SECCOMP");
>>> +		tst_res(TINFO, "kernel supports PR_GET/SET_SECCOMP");
>>> +
>>> +		TEST(prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, NULL));
>>> +		if (TST_RET == -1)
>>> +			if (TST_ERR == EINVAL) {
>>> +				mode_filter_not_supported = 1;
>>> +				return;
>>> +			}
>>> +
>>> +		tst_res(TINFO, "kernel supports SECCOMP_MODE_FILTER");
>>> +
>>>    		return;
>>>    	}
>>>    


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
