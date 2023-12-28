Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E17C46CD2
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 02:53:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D50F3CEC2A
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 03:53:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5B693CC4B8
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 03:53:35 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 433276001F9
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 03:53:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXnA0pK25rZSdR0PDVsCNCfaPatczc3b4t5s9Rc+nMrFWVY7HfP99ZYVn3ADOhm4zwE467uUchMbM/lFQMsloOrGYGSswC0C2FjKt9u/Lu+AkcfuJkm1atbBwb2jAe4cNRZDfMCXuR4+b+YhZwPfhs9pWe113Oxxretg85SjczXJmSsNx26OzberJ4gukXDJbZmboa5LIrSegOe9CGeZFW/+BMgHT9aO09iYS3C1MNwI5UlUUv0gOfp5bb05X3qJ0IxvAGqZjLn6ovolLx/hiUm90pEghzIxOR2armyPzU7a7FqoeYmgHqI/5538ahyz3qja3KrmR+v20wkPmtruLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3wpqp48TxxNidQtwMSkxotFBl0YZ7yBIgy44/bFWP8=;
 b=R3BbI5q55LBfOUsb4GEXyqIYqqPnpLBYizMsKOKe1lIaaXot8S1QCRX1l3uY1dUnS0ttcw7IofLY5+zlNGkZ6tDw0Cnm6yACUHEVteh3p/KX4Z6j3RhMN9vwhsLDXxEwcofr3KBoCkmE2LMKOH0f4pMfQQjM0NYo9HRMaCPF15EldY5N3SfrtjeQQbPM6w4v8mkvZTdHGMI9djpT2R4ZizOeprj7rqtcjIHF8XtWeA7fGpvRmTBA1Rtts6pYKGWfAPXBM0nYjL5ajoaX2MrwayoOQR1FSVwYBr+LKi8G/IIFNLLP4V//xRxbYucG4jg09lOH/VWBRsfE3Y/afIa5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3wpqp48TxxNidQtwMSkxotFBl0YZ7yBIgy44/bFWP8=;
 b=oo4kWTU+lIivDzH1ZCA1DH7wxBCsqPjMi6Xa/wXtYdcksWMmbKo5HBjd8bR1l70OyCfrGk6GmJ+ueZHqX/aURB2b2E20o/mBUmDgzE5dLkn0s3MebAW3sc0LXogT4fzC19/AICVNwQR4M1AODoUCCso43P/j3euv0JJK4ZEm+g/RAgsTB0IIyLEJ7/qvZ8lY0yNACIb6L1ZrZr+/K1wjURQLklwiO9vJzQeimwnGYsJe6rNnPQyEEHv9AQzr4OkSY9L/ZB25Azm8OxQ15oZ8E6z9l2hsHnYSlVDolVTT+J1CCAz1G8uNRa8KZavDzKjYsjHcNiGvNTVYEJJBbdotZQ==
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::21)
 by PAXPR04MB8911.eurprd04.prod.outlook.com (2603:10a6:102:20e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 02:53:31 +0000
Received: from AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d]) by AS8PR04MB8199.eurprd04.prod.outlook.com
 ([fe80::9d39:5718:5401:764d%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 02:53:31 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH v2] move_mount03: check allow to mount beneath top
 mount
Thread-Index: AQHaOFhJPxsii5zSWEeVYODi9POdbLC9MIkAgADO3+A=
Date: Thu, 28 Dec 2023 02:53:31 +0000
Message-ID: <AS8PR04MB81998D2743B6235044B68670DE9EA@AS8PR04MB8199.eurprd04.prod.outlook.com>
References: <20230913101542.18550-1-wegao@suse.com>
 <20231227000430.30224-1-wegao@suse.com> <20231227142600.GA760315@pevik>
In-Reply-To: <20231227142600.GA760315@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8199:EE_|PAXPR04MB8911:EE_
x-ms-office365-filtering-correlation-id: 5f78f4ef-cd6d-4a07-7fb1-08dc07502d3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aBeWovZwJYzrNqGJrXl4BPjhUbYMJSMy35QzyRarttA0wY3wFBD3BC7quaptosYlExJ0pH4VGpMzV0fgiBqzVkuYt2OuMuWKe6xjSWLkwr/VYGhN4y4+kHEQDrudPubWDRV65IU4hq6Pw2gnDkUpIPTHZrCZ42+Qa+zHxMDHdpjH3O2oSveQNGZYxxUmNzzGTEPD/4XcliooMBmnc+Pyv9WFPmgPTteGqkseK81WbMa9bUeauTY7t9dP/6X6i3Rw2aggvUE9SGZrMN97BxF79EDvahYSLinRMiyce8pIIwrE2Tu3U0k7yFnCY+xyJ4vplNdUk/q9zQOkIjWPqpoqcjtzZarq+0h0svRVZdPLDEFpU/4A7geb7iUxuDXXLjT+vqPGgzPBTMcyduDnFaDUEugjMPTVjaRl4qVqCcgsB/TLGKRB0NxqA5y0n108haOEmprx0iLkOErFoO2rGElNuMNggcqKyAAVNbyet50MIQkmOEVzMm2rcBRI3VfMuVIVtXk2W7CauaBdShQnEEgWTEQ7elxkI2KtNqzy1o+3Ov4wGVxTI9wyzFbVi7V5vmJIxpqaEXz7czV99LCPPQzvzmTi+853vMP+EbIt6WIyP9Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8199.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(366004)(396003)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(33656002)(122000001)(41300700001)(38100700002)(38070700009)(55016003)(66556008)(76116006)(66946007)(66476007)(52536014)(8936002)(8676002)(66446008)(64756008)(6916009)(5660300002)(316002)(4326008)(86362001)(45080400002)(26005)(71200400001)(7696005)(478600001)(966005)(2906002)(9686003)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pDzgOJtJIl/TcpkQj4nDDh1Y5iV3GL04fjZAGWhYUj9ywMKndUuKUmjkUEKi?=
 =?us-ascii?Q?v+6bavk8FkC8tnm94hzuhJ51dyEL4OHZM3eXFuQw/0sf671hrSWYM3JyznU3?=
 =?us-ascii?Q?3SoNzJglNiquHZrsyCMnSZPkzlxhNzdWLbpPPrNKgy+w8tCccK4QFadvli2Z?=
 =?us-ascii?Q?/HjjU2LMnSGVQjVCNiz4N/9pk/qx89k0SDm7xeQK2LKTqD4n6EBEuH7msvIg?=
 =?us-ascii?Q?zAOerPKZVZh9z2syHvvuBI058FvRxZKiJtFBKOe5e/i21KdpAOgDZS82CHcz?=
 =?us-ascii?Q?1YDwMUL2pvD8g5vRHgnYT+4tAw7ZrkcZvgU5KYBEAIpDUieP+q2rDFJ6c/C9?=
 =?us-ascii?Q?Kb8F/z3J8f19/8jY5FIEJs/1PN7k43AVthta/hFsw3eASWTowcTuiRbeZyJf?=
 =?us-ascii?Q?yeJJqAx9+f1YovOmwGbgtj70i4yNguFxGXFc7E1cUgHPj/QkZ225UazndO0Q?=
 =?us-ascii?Q?KjPLGWocrpgejtOx1ionjrJaiZe59VYvYXkJ3XCvRtghLCgrKQRwst+uq0Oj?=
 =?us-ascii?Q?SjIHXLYr6IvIOOwsCXdalXMdLXg6mDs41ozJWBJsRmTUE/S8Nhx2ttTplNne?=
 =?us-ascii?Q?jnGfhcc6yM5o/+GJqqEPcHYPVSAjqfL+W10XSxbUs5xAxXT5gZKiym0rUXiZ?=
 =?us-ascii?Q?hiqc9Sn/mKsPiiOrTsrCN5xxRbnUpuzuXCbJP/Aw56wxaAtR0U29sifEqfye?=
 =?us-ascii?Q?zOJ6pWzqdB8R0pqHUUMojgJ5EzJpjsmgXJnZRPgKNXOYyPROM/HOkyQBzSn+?=
 =?us-ascii?Q?QHXwgFLMEU7rT/JiA2nhSleJ/eTm3EasKgjYhX6G44OIVyKgruh7+HToWuQG?=
 =?us-ascii?Q?nLcPhkrnTYZIFRFk8lJz8CWgxo/7VZhWPC0xzoimKNB0PbbtQyDw0rWvJlgy?=
 =?us-ascii?Q?wbHiKAQ/Bif0DOAivG/Q1Ze2kamAh8beZzShQlhUQJk5jCsTOzSEipcqbobl?=
 =?us-ascii?Q?6JNxvly6kodgQeD3gOcOo5elxRApSf0pjoNWriXWBlVhWrE/1fhQq66FlJN2?=
 =?us-ascii?Q?68TCGAq9N9hUA5xhy8MVnxdnNqwgbjoWwZBQmLYOWp+KQ8MY0Cc4O8jzOhQp?=
 =?us-ascii?Q?X+S1egGxNEIWQxOz6QxXxHD3Z3f1IFt3WfujJtpJGbGt0cUJZ+qSPORWIwI1?=
 =?us-ascii?Q?A4KCrdjhCY6yBoZp529Mvltf7jQo5pKckZGWHN3Us1xnmykpaCbfZKwOWHY9?=
 =?us-ascii?Q?/kOK4LABDTQBpINqk7OEj+hZsiTFfwIdn2EDB5e2OhQIKhIclTT45bM6GMqZ?=
 =?us-ascii?Q?68ExS+4zkrsbTGeTyWjaloZAixB8+owiiP3tNv6ObYqQweGWOXOprhmoIQ9j?=
 =?us-ascii?Q?3m16Z13ibVSfPyEoqmlBc89GTJER34DBKEmVVuNulyuSMfp9NoNbDEfqkPmL?=
 =?us-ascii?Q?/ZAPA2F5jVZ/0XUHqkUxZjjB89IBNx4x72qTDXsJdG5+67mFu9yx2Q7Vu7JG?=
 =?us-ascii?Q?pQCDjmO0MyPsqZ9/D00+k9PMnr0cIKzTdR1bqKIy94IsoPU1wBzsk2UgrbKm?=
 =?us-ascii?Q?vMotvmZCytbLugGzn6mbtzFOnjCppDMyLI4QoJqmnbIqmlenfieFza/zBZZr?=
 =?us-ascii?Q?g9MCtwD2h0a/vek6QF0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8199.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f78f4ef-cd6d-4a07-7fb1-08dc07502d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 02:53:31.7102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HNyDQPuJh4u8A+JqxJVvS6asvVJk06jT0tiHd8B7sMN1CFw+Fg5aGG76C9KezrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8911
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] move_mount03: check allow to mount beneath top
 mount
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr
Very strange I have not found this email in my mutt, so I have to reply it in my outlook, sorry for inconvenience.
Regards
Gao Wei

I suppose there was no v1, right?
[GW] V1:  https://patchwork.ozlabs.org/project/ltp/patch/20230913101542.18550-1-wegao@suse.com/

NOTE: you can speed up the review process, if you check list of common errors before sending patch to ML https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist#how-to-find-clear-errors
[GW]: patch v2 send with following check: make check, m32, run with -i3

I see false positive from checkpatch.pl, it would be interesting to check if it can be fixed.
[GW]: v1 has no this issue, I wrongly remove some change from v1.

> +static void run(void)
> +{
> +	int fda, fdb;
> +
> +	SAFE_MKDIR(DIRA, 0777);
> +	SAFE_MKDIR(DIRB, 0777);
> +	SAFE_MOUNT("none", DIRA, "tmpfs", 0, 0);
> +	SAFE_MOUNT("none", DIRB, "tmpfs", 0, 0);
> +	SAFE_TOUCH(DIRA "/A", 0, NULL);
> +	SAFE_TOUCH(DIRB "/B", 0, NULL);
Maybe whole code in above could be in setup() function, it can be created only once even we run test more times with -iN, right? Setup function is for test speedup (imagine somebody run test with -i10000, why to create files all the time?
[GW]: MKDIR should put into setup otherwise issue will happen, but mount & touch should keep within run function since move_mount will change mount point later and we need rebuild mount env again when it rerun.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
