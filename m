Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0207E80AA1
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 07:36:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F1C33CDC44
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 09:36:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 943053C88C8
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 09:36:28 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 445071001F4E
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 09:36:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3RMLfQs/dVOy7u8amuqZ5IKSPXrZHUMJ934wzOv2i9O2K7ygn68V0ec4OXGLC6HVG1B0BSluMw8tlP5X6i/YLdd6JnTZWzY/pDAMH/4xcP4oOdy8Chg+yrwg/s0AiyJnAsCSVleoEKtRAO+RdU7jxAPrQkzAR91gk9BJffgJv7lRun4mz2QK46ybUfbUgijCwMkZs4E/43voAc4XLk457+Y1Jcx83K86FD9kavcfOFPvmBOEQOMYD0NPz2Y9QpoAfLTgrvuQ154RMZl28BUmlRYTC3qpekCZVyP81rhdLwsadqlnCNrRm22MJGn4NFG10k4WWj1YOVqlXzxBqpPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY883HFH3SKjQ17XhalTW4XCfVEbHr6Ny7iQ1siFCDc=;
 b=SxeC3WIhYAluBBImaQWO7EC/+tOLSfyv27HS9nJzXzJIaixj2+dRiBu3kq8di1EqA17zBYAUkUNPcs/lpy/wrld47FVZxayPmIFGOrRLCCesJ98qbhcHxcEoQ3U6cKV8WzjRBquclJSz5BqOThK7pJWuRIE+DouzklqStCicwXiB2IfNeZal46B462K2iYlKIlZZQWoj168iCeEYoSIB0ibU8E/9x7Bvs3d3oZg7is9KC1nvDBdJsdW1Pzkh6Aws1I7yP2X8qL3oq/16M+BPyIDiZvkwgFYwuniorRgCu3uUcWai35Z97amrrT6L5/0E0ex0h7ixo5X/LYxZFtVhAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY883HFH3SKjQ17XhalTW4XCfVEbHr6Ny7iQ1siFCDc=;
 b=jp+w1erjR+nKfbtfjoX40NJruQ6+F463giM/J/CMXkIrwSazw1OMRDVukY2zO/AWJOoxVy6zszrLkcZ2PgRTU80JqwmK9Y2O2sMqtfttWPg2oqFScFhtcqtwXTFoJZI1ZeqM6jc8lFI2txiu5sls97+jikBHZO97s2ujg3/gT3kby20S8TBMfTUsaMEDbmkMkBD7oEM0iwa4ixicckuWMUPcpmbmjiCby8QvSVVhXfMs69PMwECNmmWSvNrYTu3eMh9yEn20XIBeWxMoyTW6aPuakwsZ9tm8J+Rp04v9PXAb51we3lgdU4M7WFrgwdni++ggP9DPBDWe+zsqQSXLew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by DB8PR04MB7002.eurprd04.prod.outlook.com (2603:10a6:10:119::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 07:36:25 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::41dd:e42:e86b:c92f%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 07:36:25 +0000
Date: Wed, 27 Sep 2023 03:36:19 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZRPbcz78VPxO0p9L@wegao>
References: <20230925144206.16895-1-mkittler@suse.de>
 <20230925151728.GE60471@pevik> <ZRKEQKHgkpVURMFs@wegao>
 <20230927055221.GE205174@pevik>
Content-Disposition: inline
In-Reply-To: <20230927055221.GE205174@pevik>
X-ClientProxiedBy: FR4P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::13) To AS8PR04MB8199.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8199:EE_|DB8PR04MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1a7466-76ab-4c7b-7077-08dbbf2c7443
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9R0TJNUWwEaTKXtuE99O/SHitCmrHYgjdDuOGgLj698bnuLatXAsQDWL6nrc99aLvt+Uhl2HFlCcevBqOqsbrmHh8DR2NueMw8YDnwjnpTRFyMQ6uYG2Q6r0B55L/e/hQeTOuX3h+MbWgXhs+K0Cc+8//xNNprhlDCvkSmJU8l/yKbd2UKU2QRdxtera/a8ECIehGUbIH5qHVCq7UtPLAPCjEY+p0zRm2VUG7obPyMel6s85mtbkEGO/Erhc2weB6Go/6u2/MttcX9Ro1wNcHrVQfyTFhLDwxMbae8ypr6+otYjyMFZReionxw1NlhLr0lZeZzyycaZfCLJ6Xz7fGD4Ypyfw28UZQV3i5WqiKBMtzhADAEU5sFSM7kFj0zgI+aVcB69uJLwnQc1XHLfwt9jsj8W6DI/Po+Eint22OGFHWH8yasfZUqsoLuKzNrV+6111WSeH/iqFVRMmKFRMZguKo9m80TjudOEbpUPjUMFRbsjrR+ohKZMadVADlpMTTlmgjjZKFZo89XPkERezMlrknOSO5hU63cfCU+1wMps3OeSFmRMkstZTLBZPMG1sm5BIdrjASMHr6PQ0p09EYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(54906003)(66946007)(5660300002)(6916009)(316002)(4744005)(41300700001)(2906002)(8936002)(6506007)(4326008)(8676002)(66556008)(86362001)(478600001)(33716001)(6486002)(26005)(9686003)(6666004)(6512007)(83380400001)(38100700002)(66476007)(81973001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GiPIVVnEoFSEeqTqAwikpnLyZtUrdB5hSIrGMxFA+r269NXJnTYrMQM+KQ4D?=
 =?us-ascii?Q?QKBLvOMXiZN7km5SF3aecuRiialwK3nlFSJMHvf5p2qc1VpvwCZ0nAbl6oi9?=
 =?us-ascii?Q?y/zmaUrKs354kQBmNPhixZuHcRd8OoX/2uD+WpDE9qGwrZiBCku1x9gUrwCB?=
 =?us-ascii?Q?LiZFgJj8P/G6z55GBoSdCLDzajFUQ0plkjCPeyoA565NjIHfcnr//lsDLU9j?=
 =?us-ascii?Q?X9xKRdUS5ouI+360XZ+5rDlqzkE+wclQoSh6ovFDzXROnTShUoRwubigmyr9?=
 =?us-ascii?Q?DGvZoucjKwldqsL8e8xI0oILVnzeqcdg6MjOQ+cb8ixc1OMJf9XsRHBFiGac?=
 =?us-ascii?Q?PVyyvTt59ypZmSaemy59IplUJU/4kKGtB6OUkWl9VY6WS0crrj0F3wFdWC+z?=
 =?us-ascii?Q?x9SvkRr8PPCOCxoGBsMriA82Qw4KLgeM0mJdRVZh9oZFtGvkoewRqsFljdpI?=
 =?us-ascii?Q?4P3T0qX5jaLKymjLTj7B90aOCGayUJb7JVlvYN5M0jd42nU7fNtq3igd256E?=
 =?us-ascii?Q?jqqleqenQzlPcReOs7rGKcIpBWMDjtIwODtWJ1OSZrmjP2OhBzczHuoqCbJp?=
 =?us-ascii?Q?/R1gUC8iKox+O4uf6aBJOJAdPZTofdjklpCueA62gHIdP8jOtcCDG+uKS5tU?=
 =?us-ascii?Q?zio6Fan3xleL1XfEurVFfsOZoavX/LFBl8PFgaRz90w1huvvVT+lK2PEEaCS?=
 =?us-ascii?Q?68aZP+5BHSQy+3QBTt/J0LFAJDyDUTnI3SIH0ABj5zBi1Cr36F5FiudaBnxl?=
 =?us-ascii?Q?zvkkH/V5RuEfFL8zwI2rLkp1pvVHaKXQsrzXRBhJ4Y7M6G3NdcZtM3lP01lh?=
 =?us-ascii?Q?p17vBbNewS4w/eoslamcr10qRuCj72JqFxyDsW12g+MX1xelzIlxMtAefhPW?=
 =?us-ascii?Q?0Gcp+e2g81PYhME+Z4MPCausymtQ3qRnAcT0ugP+mQYiNjakCFynUTydXOZW?=
 =?us-ascii?Q?sD4DWu9gbJW8MUcwbZJOTJMKhKX0neFLGU/OsCOVDSpU3RYDb2FgP2el40gz?=
 =?us-ascii?Q?mEP2n89+LYhJ0GCl2EL+HGzkaqaRPNxUvVDhzKB/04xsRlRXM5+yuQTHjoiO?=
 =?us-ascii?Q?Ss8n0RGg0t3PWwt6NOuQu9Yaq8A4sPYrhpVflpYuj+CZ03ogaEHFG3U3eK6J?=
 =?us-ascii?Q?n5sl16F0OHrNIZWWbJHv93zp+4uNaiufzLtUQ8efoPPQpzY6AHn9BrTtupZI?=
 =?us-ascii?Q?HN2/YB0sPKHNwmWUR5AbOezmQnc/Mr/jbLjW+pkNO9RV0ZjKvKPCMhQT/Qp3?=
 =?us-ascii?Q?lnMrMQNqyyCRBJwMems0sNAUU9BuP5dhOM36l9Zbtto5Ow45D2qURXvIgMqT?=
 =?us-ascii?Q?hX2YD8W94eGPRESBYGtggPJC8qGTyGuPRpEr5LwNVZnU5w16V0JHruoLurdY?=
 =?us-ascii?Q?GvggCTT5o/c2ECfysORlUzpa+3AyYK57V/nqZ51bNzV4xV420Jr3Eb4SO66Q?=
 =?us-ascii?Q?p572WeOPF1Nb3XwNykB0qsvqw0/ilh7u+RBOmnOpopb1dCgSYELpEuMtMafk?=
 =?us-ascii?Q?5l+Sza9eH3RRva5cdhWo+sQ4SgnAWHLxBy4jp6FJhliRX7EyplptcDzXRUpZ?=
 =?us-ascii?Q?b6qnakfVhQdSQYa1UA8WbvtQD5PB780hli2aMKYV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1a7466-76ab-4c7b-7077-08dbbf2c7443
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 07:36:25.4148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l508R5HIpRpk7Bbzux4MzXtg/SoV78iwmZaowat+zz9qJxR3ZcQoK63TnNXh2WmC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7002
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Skip cgroup-related tests if `/sys/fs/cgroup`
 readonly
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Sep 27, 2023 at 07:52:21AM +0200, Petr Vorel wrote:
> Hi,
> 
> ...
> > > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >   Tested-by: Wei Gao <wegao@suse.com>
>     ^
> 	Unwanted whitespace before the tag.
> 
> Wei, please don't put this whitespace space next time.
> 
> Not only this is wrong, but it breaks automatic adding of your tag.
> Patchwork (https://patchwork.ozlabs.org/project/ltp/list/) which we use for
> downloading patches automatically adds all tags associated with the patch,
> unless there is whitespace before the tag.
Got it. Thanks for correcting the error.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
