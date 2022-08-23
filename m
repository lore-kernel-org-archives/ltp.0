Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34319C32772
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 14:58:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E3C73C9882
	for <ltp@archiver.kernel.org>; Tue, 23 Aug 2022 16:58:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C82373C9882
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 16:58:19 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B81A2009A9
 for <ltp@lists.linux.it>; Tue, 23 Aug 2022 16:58:18 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=bzv3hRU/0acm/tLNw8TAc+zaCfOziNIzLq8Bm7j0LMWO5XttpVCRsyfGUePkrWYJQR6Aa6f30Tfk7zFBTJgieCCX0QfLG0P0A01Zy2J+OSou621YbK8HgKqXfOhFQtMvLyxnWkd+85wT/utMb8vvTP6SwGpeFBQkfBUBKoWISYvQWX66lMoikWh/R9ghE33zeFgefjsM5Clib/8WTxZYMt3gNwEKFRaIdaHQdxwuP82GZj1R0Udm0cb8b79/o+GrKw4Lzx3AjqMEXtCkNdi33xpWnkYArkVvi7y25yaZ40Q5bDU/lonGhrw3BNs+MRSHDfECe7hK6GDzSU7eTYGLRg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dc71YkojdL2tEyRipI2k2v5br8HzNHolM7EI6Lt3jA=;
 b=SXB0q3RIW4xeE4BJmeSf9Q6bW1zI8DrJqgiKIMWIE+l/xYGMVXOeS3JvG5nvLGPXqqDC6Je1S8150ctsg1+niX22ljYK8rgSbVWxp4zP4yU7QFfDqrg7EHDHG5f2n1pUpzGDvJn4p2izu+T4myu8OkaIX9AZ8URv06KvVlqHWcfp25j74NqBeQdaTF1qzswUwSfsU65zjSddnvCRMDLaTdOz4OYVr9EXc+qxGVADOJFPKd975MbTuZ/m8nKBlQx9oDgjMFAJSzdSQlkZ8L4vqnvaKQY2bObFTm15rCJ70AVrVR7FfHQhXzp7zxmbvydVBSj7aPeIezQkXu1tE+38eg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.linux.it smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dc71YkojdL2tEyRipI2k2v5br8HzNHolM7EI6Lt3jA=;
 b=bPv3iKlOA2DGrw016Kog2am872mGhow2oyulcwguolrEW+8Nirvm2ZqcfUmcsK1obxajH8G7KR2HHnvhTdM6sKoSPteitby4pr31toQsi97yc1Ek8FCcq/To10moBSqp41lpYvZq+9Kepn2EgSVilOZKy1dNbSSi9e5JzVQ1mow=
Received: from DB6PR0601CA0011.eurprd06.prod.outlook.com (2603:10a6:4:7b::21)
 by DBBPR08MB4662.eurprd08.prod.outlook.com (2603:10a6:10:f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Tue, 23 Aug
 2022 14:58:07 +0000
Received: from DBAEUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::ce) by DB6PR0601CA0011.outlook.office365.com
 (2603:10a6:4:7b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Tue, 23 Aug 2022 14:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT004.mail.protection.outlook.com (100.127.142.103) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 14:58:07 +0000
Received: ("Tessian outbound c883b5ba7b70:v123");
 Tue, 23 Aug 2022 14:58:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 677ab3462ac8f1a9
X-CR-MTA-TID: 64aa7808
Received: from 74c21f39202e.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 3FF3177C-6FD2-4CC4-AB18-F05F427E6353.1; 
 Tue, 23 Aug 2022 14:58:00 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 74c21f39202e.1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
 Tue, 23 Aug 2022 14:58:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiEsy3iDcxGzwyEDd18gDceQyTqwdJPnSnCeHf3bSysP5pj0M6V64c91+ulc2o1HZr5jPbDv/ncpA6Nha4nopx5W/lvmSC1x3d8byy3+B+7JTM+tBk7EoFcy1hVcWjikHNXzKYivQ3HpWIMgIzMRfXXxswBqaHAGw8EWK91i8DWlxxTc+mrQVe1jxIQGsxKwJS2XCApnse+BOcN2bfAoiV2/EQ4IDUoJRuh4WnNe/8mSvIxSnNMXvqA937CaTO2fGO8z6TBNn49bdz3cKbxDH+3cAuva3jGId33IKs59KbESiroWmSoEKJ9XeV0VW7JM32NT/VgLq263kQWcW0HZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dc71YkojdL2tEyRipI2k2v5br8HzNHolM7EI6Lt3jA=;
 b=DZVEDiQME+hDrn1QLYxHy/7L4Wu/gjvvi/id2a8YDqF/7KR/toNexU21anodVZTk3u+RlZebvjeS4Q3G3ThN+9FYrjiZhKyBoX/zBVeT6wJ2wI/ncmXF/K7VnsR0Sayhzy+8UKfiX4I/VlW4R0zUX0uy3lhrRRcTf9AMzX1yEe/C3Q2kTpsNMwkse7+OKABjWn8i682WqDwZAHTQz55Zmqoqwj5SreQG2L3yeoOX1JNHkf3+XWBys4+gOLfhMYWCHUA2+iHouPxxPaEFMy0+UNZJU1OxHa5v4KsPNXoNKpchflgdvB9ujqJdqYrX2WtpRhy9aeXrRmL7PKc91l48NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com; 
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dc71YkojdL2tEyRipI2k2v5br8HzNHolM7EI6Lt3jA=;
 b=bPv3iKlOA2DGrw016Kog2am872mGhow2oyulcwguolrEW+8Nirvm2ZqcfUmcsK1obxajH8G7KR2HHnvhTdM6sKoSPteitby4pr31toQsi97yc1Ek8FCcq/To10moBSqp41lpYvZq+9Kepn2EgSVilOZKy1dNbSSi9e5JzVQ1mow=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com (2603:10a6:5:21::26) by
 AM9PR08MB6129.eurprd08.prod.outlook.com (2603:10a6:20b:284::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Tue, 23 Aug 2022 14:57:57 +0000
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::f943:249e:3d34:9ea9]) by DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::f943:249e:3d34:9ea9%4]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 14:57:57 +0000
Message-ID: <ac9beefc-f2a9-1333-aba2-54a11d2f0689@arm.com>
Date: Tue, 23 Aug 2022 15:59:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20220822113919.196953-1-tudor.cretu@arm.com>
 <20220822113919.196953-4-tudor.cretu@arm.com> <YwSg3BbsVwGcjlsx@pevik>
From: Tudor Cretu <tudor.cretu@arm.com>
In-Reply-To: <YwSg3BbsVwGcjlsx@pevik>
X-ClientProxiedBy: LO4P123CA0485.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::22) To DB7PR08MB3276.eurprd08.prod.outlook.com
 (2603:10a6:5:21::26)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2a4b5af2-e6c5-40de-64a6-08da8517e392
X-MS-TrafficTypeDiagnostic: AM9PR08MB6129:EE_|DBAEUR03FT004:EE_|DBBPR08MB4662:EE_
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hnFs2/57i0/YL0kt+yOKmLBByaJl5kXF6XwVKH/N/yw/mvnhFZLCxEN7lSqMxQQhUTB55cTYIDlkGoMjTlnFiWJ0VDpplEdDz/3PhSBqtQnFVEMqPC+TGcXCwaWxqz32oU3JKy10FXHVrHTwN10xUnMMak6K69RBhiUTcvrx8UxpLbi5exBoKA1ToH6TXRAhJye6HczdOkdwZvcxji0NmbZ8u5Pe20pZY0XX2mtrlaCjdV5cb19Y1QVToF0AvKq7elXOcV7gVLVKwMKMMH6FAbUZFTbtGfArgkdTkjadmQVW6sF5NgARt3qsVWu7m42SWTipvXcCvAhGYQNxBsS/ngZrErJErkOT/zagJU/lmHw7g4n+WpYJd6npvj2T7yWVOcVwHZbw8w+8p8MsVedJDl3cvVRhe/PGR8x/3plQTk3LEvuui/1H6ozNwiwVWmE/j8xT8QHdfVK7PEJXilC9woL6sBtCP9SNoLRTFD4KmrosuBq0Q5px2WBdFh5vmlLIu4r+CyXS447IUS3tFITrV0GcuhQgPzloKeEgEtAsPAUh3lnOrcHndcOLpHaoxEgZ/1zcLnSKOFFeRlPtT2AZl/b/KRJlzgnnL9DP7gVNYZ3PZZZguSCgxIi16g/ASUu7DYO8pTxiAmSgDlGwb8D4hDV3fFHKz5FV8y0snkM8udfRppM0lRukVLwvDpq4pL0yYiyNtSlkwxtxgN1VG6PYH3P74Day6stYRbxm8LNHEQQr4d7Vi+1RWfCj0sfKYCanPo9sNglBM0+s0dcxcc8+kEHgYQSnobe1LKKaZlb4hji+GI9lTbn7+5H+YXzdtpHM
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB7PR08MB3276.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(31696002)(2616005)(186003)(86362001)(38100700002)(83380400001)(8936002)(44832011)(5660300002)(6506007)(31686004)(4326008)(8676002)(66946007)(66556008)(66476007)(36756003)(2906002)(6486002)(478600001)(966005)(41300700001)(6666004)(6916009)(6512007)(316002)(53546011)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6129
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2fede69c-57f1-40fd-a280-08da8517dda4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ArXfbF6NEfRDlBQL5Z2xabelR9/qr085kuci/arMm/Uv+60LOJZGH9pkSVaN6OelvOQpFm2uZ1g2ikg1hd67mjFyKMeAoS16WP197QGz+S6PSeduLLjShJcVfbWj5+4tELWarf++FDXB3ctl8E+G/cEJKTI43V7fJ7WXFtclUPAcH1hmKeooqg5haHzSpIBrCPRLHFfUNQvsQ4LryAn8nmhkkU4bj1qcoFx+gxP/oBuAx70JDUb9E9hi/M7TU5ft3Az/nyPeaEkKKrYkA915Wvz+EUoqgnTQRK3/FirzHkbS4uoOgS/aJeDYFHJRUyMV6V+0oYkuUqKoiVGVYz2oErAXSgHdZUAanYU4f+r+lkXAv3gf7JEsHziHJa1I9mL77m2R9B2iftQsrWGhVsqFuGfj9DqJTBjVGUdJgXvbgUTpik5u9S2y6J2rG6IK1HOojcYAM0heqg8uzZB1JHMzHN3EcQLsvRAWoEdYVBvLqumEd++Tn617+16xOVr5Mr4So++lIqo7Odp9YBxYNjEFHLtT9vBn3S2TWT0rWTZ6pJ7ITdcV3dE5AuD64LBLMGUnTLsrsYqxYg1l4zV1xYkKjwHT0pz73ixcjtaX0/xjcanLoUtJOt2kH/om4yr4q2Wmw+gODwOdd8h18zN1/WgOWn1Ac+Z8HC3J+sVyy3ax9CVSk9clm5WsToNE1ZLOdBA9aQ7eHgXr0dkka2I+qitE0v2/FJyIcKo64mAi+hJkjr6FBen74wI6rg2EZXrOe4QEqAuMFuXpyBy0i/9zB2IHJjM1DsR8lNBge/9NGU2d9rGv0bcBlTB7cKna7Epclc44Gvx/pVw6O87Z2JeQD1dg+w==
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(6666004)(44832011)(70206006)(8676002)(4326008)(316002)(83380400001)(82310400005)(70586007)(86362001)(40480700001)(40460700003)(31696002)(36756003)(6862004)(8936002)(5660300002)(2906002)(356005)(82740400003)(81166007)(6512007)(41300700001)(31686004)(36860700001)(26005)(478600001)(966005)(2616005)(336012)(107886003)(53546011)(6506007)(6486002)(186003)(47076005)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 14:58:07.5110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4b5af2-e6c5-40de-64a6-08da8517e392
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4662
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] syscalls/prctl04: Allow rt_sigprocmask in
 the syscall filter
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
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On 23-08-2022 10:41, Petr Vorel wrote:
> Hi Tudor,
>
>> Some libcs (e.g. Musl) call rt_sigprocmask as part of their fork
>> implementation. To successfully call fork, rt_sigprocmask must be allowed
>> as well in the filter.
>
> When tested on lastest update Alpine with 1.2.3 it in both cases fails:
>
> prctl04.c:205: TPASS: SECCOMP_MODE_FILTER doesn't permit exit()
> prctl04.c:207: TFAIL: SECCOMP_MODE_FILTER doesn't permit exit()

Sorry, I am not sure I understand. Which are the both cases in which the
test fails? I am also using Musl 1.2.3 and the test passes for me on
BusyBox (both x86_64 and AArch64). I don't have an Alpine environment,
and I am having issues with docker and seccomp, so I am not able to test
on Alpine yet.

Kind regards,
Tudor

>
> What can be wrong?
>
> @Yang Xu: Also this test (written in new API) should use tst_reinit()
> https://lore.kernel.org/ltp/70476626-2c7a-fcd6-4cf4-de7cbd572f99@fujitsu.com/T/#mb3e34713dd15f2050ec2dc01615fefb7ee66c880
>
> Kind regards,
> Petr
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
