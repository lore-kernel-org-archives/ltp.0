Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C8C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 00:36:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C88C61041
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 00:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C88C61041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vpitech.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 564113C8E92
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 02:36:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1E3F3C2201
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 02:35:53 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 59A8B1A0153D
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 02:35:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLrREgy9BBdwBa7qbD3/Ye4mUrbjfCfIovbWws2LPNQ82Rzp7H9t6WiW1MLxpKprBiUYlp7EPtgX8voKt/Wl/4H/FyCEu7Od8v4qHqX4jXlWokJ6GG7exsika5/IUjDhQ14hZynX38CZ80EnNtNFOFgDjVu3TpE6czLRCAy1zmoaEET+BEeRtX39XUPWuDyCQYCCOBlOtqnHoPHtfyhiU6l+ibvGeDnsg8lrwYtuZ5NE0RRdpLakW3h4oRpVzcfoZTii6lMV5x+I/UlgPbQvXPIrubn/77cvX2VSKLNxC2XhFl8N+HVSD0U0Msf/zYJ0YWc8lk2lOzYYs+OenTaCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=8erqxLy5oPyAASstS4aMQcCUlwxJ5nTSsQ3kzzYkyQw=;
 b=gVOMFbEKe4q8nibmwNTQlFoAk3MyuvfK5cqspoM9QeS7Sjs5HBwaQK95lO5vGGqxEuAw48UktOEh4eqVjk4oULm++VIH/B84OOrJOW7nKQm6SxpH+h091d4WOmMpFhu++PmGg1FTUkyLXLpdsWgQr8gXk3n/PI7Hv4bIUAoA+PjOx+w3wXo5flOGYi33ot64HBPZQ4hLdZF6OUJaga48+iKPZqqdtW1PC6QglgCSO6VF9/qauiQdlJByj9/M9FfwBeSp3pSfXLTXDHVRn3YkbnqfchHqPF0k5aWUEjsvFby7s+WzWflaI1a4VTyhc2h1KBcFJ8s+KeLe82LH5cDY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8erqxLy5oPyAASstS4aMQcCUlwxJ5nTSsQ3kzzYkyQw=;
 b=h7WasodcERRyoVjPPiPd177xMavg/3k8Xt8GisATsqrB/EVqYXsybhr55DJELv8fd3+seSYJ9PXHNSUjtAvsahhSgaiwcxa1qhNyqG73cP8FXnMsLks2n6SetA3CnL0HlPBnn6IEr0p+aSEj2aUAWECVeNJSblLOltTaR0ETWxo=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MWHPR07MB3024.namprd07.prod.outlook.com (2603:10b6:300:e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Fri, 10 Sep
 2021 00:35:47 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4478.026; Fri, 10 Sep 2021
 00:35:47 +0000
Date: Thu, 9 Sep 2021 18:35:45 -0600
From: Alex Henrie <alexh@vpitech.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20210909183545.a33cb2c25f13eb2a1d7b64ac@vpitech.com>
In-Reply-To: <YTpswsqlDS5tI7NC@pevik>
References: <20210909165111.51038-1-alexh@vpitech.com>
 <20210909165111.51038-2-alexh@vpitech.com> <YTpswsqlDS5tI7NC@pevik>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
X-ClientProxiedBy: MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::27) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter (66.60.105.30) by
 MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 00:35:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46b32df9-2f1a-4c4e-88db-08d973f2ee68
X-MS-TrafficTypeDiagnostic: MWHPR07MB3024:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3024894BFA9C3EE28A6E6950B8D69@MWHPR07MB3024.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmlOF0gMQwkHfZ4g1MIm5V8rHtzAy3MMhdUQbNV5gI2ED8utjC3HQSPmkjKx1TNXvkJdPq+GOtZgnSRuMEJJNcbamBJ5L+mpFWapalWpkhHkEbxGDgeHIVN9jL6VJ3+f8W8CnXcpn7H5lx2iEqQuSnRWxGO58qAL3jLLWiDMy01yyVkB1gufg2mhwoPwY/3f2WJd1Ui/nzuhjiy/dU5KorHmjc5qf8uTPsXXRh7Vmaj5Hsx6Ejg7Cit4b7q0hAiaca2AHSCNI6I3QjWtgKjvR9XjmZjsUCk/sYzrvNMwrvAZuaTUF5eiU9wi+/su3vtUlulLPyZITBy2AtmxJ1LjFnRAC48YucPR8MaLATVMn7/N3vWqTYBXIzz59VUMytrSzKxVixZoGgwdN+Qt6S82UNSPc+ljEuvGKGHfAFMNGBFjQuRNATWS8HDtUhegsCQBtKB/uw92C8lBd+mdObj0DrAV4PV2rllQwvsaN/Ro4iFDGBvWVg0WoMb5Pd33KQ7JuLBgS2D6pBieAM/iRrTVluH4t4rKeyO7unpOM4Tzh+HlBXe33lke/7XpSv0AVRbx9GZ3oT1mI5vqmYa3v01/ZswJc8ZE4GvK6zyORA8KTs/F0PURsDlbaxlGZ3pQUBwgl2LF1xDExISebuxeNl92AA+7ep9al5hIINLSX3UZU0XSbcPkV4jlmSettC8dJqbadKdsgA7rTBY5/pW8JzKLEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR07MB3980.namprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39840400004)(136003)(346002)(366004)(376002)(396003)(6916009)(8676002)(26005)(66946007)(83380400001)(186003)(66556008)(6486002)(1076003)(4326008)(508600001)(86362001)(52116002)(5660300002)(6496006)(8936002)(2616005)(38100700002)(956004)(2906002)(66476007)(38350700002)(316002)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sfqF4uGDX3d4n9dqg4drCFB8elObYlVRmu8n/4kzv1EWqB/SIAF2bpZ6fTcB?=
 =?us-ascii?Q?FKWAIzt8KwLN+o/QP6XPLi+P9KZ5qMOvaOkcWXlI7f6G2hbSIrvH9WmtpfF2?=
 =?us-ascii?Q?yONIxSvX88f8wpDJI3KJQbu5XqkLyB4D9O7FTs/gfraVyAidz7UWXMPSoX25?=
 =?us-ascii?Q?ac1uF4GSSIUaQ0yWjS+R30vN9DdhfhL+OA2LppU5gaoASYOGK7XrB9oGFi87?=
 =?us-ascii?Q?NSlTIJ9sVf/uFluxhpKKoFUg/6R0v3+x7jCW9L+wSgAZB595dgOB2ET1drYI?=
 =?us-ascii?Q?cqS9nc6rJuzQt29FbXJCdpTgLSHrKtukcBn4yKt05l8qkWobbzvkX6pN4vNe?=
 =?us-ascii?Q?DEJcZdJtccfOkigjj3gBCAn6M9BAMZwcuNn9GPKP20r0OhyWF4AR1ie1l75E?=
 =?us-ascii?Q?3GJDYKKm5u/4dqcSgYqXYeZ1EBNSW6HV1c1fj0JzyuLYLISJvVmLnbAdnWYF?=
 =?us-ascii?Q?v008d5w5MsH77M0V2vT1oZDGFvCr2rFPJ2vANN0TINCG351VKKbj0e2sUI1p?=
 =?us-ascii?Q?qacmB/Vu5xvZrt1h41vAvX5l5vGnDDdKJNNaosW8OGnOuAmWGnbdv/2U9k8L?=
 =?us-ascii?Q?gc73uXsEmdpWOqX7lOWZJlu3TfW+0TknWzeUiVzEnI9lmwjSo0b7VGTuHgyI?=
 =?us-ascii?Q?+IsMkvpMyYIGqhfOfqtfnfQhR0ClwDJdgLkkv7WAaZIs0qkRolvbgCXRiDPs?=
 =?us-ascii?Q?n03q+tGZwJ9vSJthDk8SCAahIiRPFazkY+8fGJE6bT7j/f3OjKMDgkvPPxUa?=
 =?us-ascii?Q?3hcYrvd2JSkg1h85PEw6AhNuqia9DM84WeDZJPVYyqgq2SzoG5SVVDMqauEu?=
 =?us-ascii?Q?o/fAiisbJ0E+yvPA+RhgY53JttoAodkcQqZi6Npn22KtwkoMeIcySYl4uAXA?=
 =?us-ascii?Q?B3cnb22EpuU9ozH+E19pa1kF0R0VkWR8Sb774+eHOLdfb8gVeR53ikOwt9sy?=
 =?us-ascii?Q?wpudoewYhdvd+AwIqwQfOH/g74qspv3VU4hbTPTODgFlMflng3NZ+2zNAK5g?=
 =?us-ascii?Q?1x9XS8Um0UXe02pC9wgRlZZOnqhSoICsj1/Bc72Rxlm4lzBmfnmQx0n0Z6/E?=
 =?us-ascii?Q?em46lbj4D0X4YLS/lV7SdqfCpPuGpWqvh8QbhgbCu+Q/TZR1bXXRS8HtqEAc?=
 =?us-ascii?Q?F0uM2sihuC/5SevzcWXNZcl3cphYWPXm7uMbTiPMt2jWZTmBWtUt9fEaL94w?=
 =?us-ascii?Q?uLUcjdIJgWSuJn0NgpAxJAGRX1EYhnYLNbx45lp+3W2C6v8kQz9MUFbz7zVL?=
 =?us-ascii?Q?DEJ22rI6rzaU9XhVwHKzls3k6ietu5pzqAbSjARTHuQipl9OqK8zMLx2G8Ai?=
 =?us-ascii?Q?U5etar/2Dw27iUHdCE4sJpBb?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b32df9-2f1a-4c4e-88db-08d973f2ee68
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 00:35:47.2591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBfuvZawak54hfq5OJW4S571mGogx3ITrj4p7W/Xw3nEbsHWRJbmDQucPWu4KkbMSek5155oJChBEa6kIXb+fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3024
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp] IMA: Add tests for uid, gid, fowner,
 and fgroup options
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210910003545.QHEsVUFWbFdnyknQWWztNJ7HDct3IgzrICFuaxfgJLk@z>

On Thu, 9 Sep 2021 22:21:22 +0200
Petr Vorel <pvorel@suse.cz> wrote:

> > Requires "ima: add gid support".
> I haven't test the patch yet, but LTP supports (unlike kselftest) various kernel
> versions. Thus there should be some check to prevent old kernels failing.
> You could certainly wrap new things with if tst_kvcmp. If there is a chance new
> functionality can be detected, we prefer it because various features are
> sometimes backported to enterprise distros' kernels.
> 
> Also, adding new test ima_measurements02.sh with TST_MIN_KVER would also work,
> although for IMA tests I usually kept everything in a single file.

I'll add a tst_kvcmp check under the assumption that this feature will
be added before Linux 5.15.

> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> > @@ -8,6 +8,7 @@
> 
> >  TST_NEEDS_CMDS="awk cut sed"
> You should add sudo:
> 
> TST_NEEDS_CMDS="awk cut sed sudo"

Will do.

> >  TST_SETUP="setup"
> > +TST_CLEANUP="cleanup"
> >  TST_CNT=3
> >  TST_NEEDS_DEVICE=1
> 
> > @@ -20,6 +21,13 @@ setup()
> >  	TEST_FILE="$PWD/test.txt"
> >  	POLICY="$IMA_DIR/policy"
> >  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
> > +
> > +	cat $IMA_POLICY > policy-original
> This might not work if CONFIG_IMA_READ_POLICY is not set. There is
> check_policy_readable() helper in ima_setup.sh. Is it really needed anyway?

It looks like CONFIG_IMA_WRITE_POLICY only makes it possible to add new
rules at runtime, not remove them, so the cleanup code didn't actually
work. I'll remove it.

> > +}
> > +
> > +cleanup()
> > +{
> > +	cat policy-original > $IMA_POLICY
> Again, this will not work if CONFIG_IMA_WRITE_POLICY not set.
> And this is very likely not to be set.

The new tests require the policy to be writable. I'll move the
check_policy_writable function from ima_policy.sh to ima_setup.sh and
use it in ima_measurements.sh as well.

Thanks for the feedback,

-Alex

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
