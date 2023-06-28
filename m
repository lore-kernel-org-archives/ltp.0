Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4D0EB64D7
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 06:06:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33A5B3CC78D
	for <ltp@archiver.kernel.org>; Wed, 28 Jun 2023 08:06:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 323BA3C999D
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 08:05:57 +0200 (CEST)
Received: from MW2PR02CU002.outbound.protection.outlook.com
 (mail-westus2azon11013012.outbound.protection.outlook.com [52.101.49.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EC46A1400262
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 08:05:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbhqcpccoyrgY2h9Y1lJ0MWyYyNjWtQshyvpfIp2sGOTcOFqeq2zY+Ij7GqIJmOzLBzbgAIne0NHxZJpAZo2oDtgx7//XGnUf/XLQrT76YWRKquFG8fjJW6zQDhWcaeGg7jL8HhwFxx03NuO5PS4uVckSNXYPsG419lmebyHF9aaKzwjfdx6NuDFxCDvJfKDRs2jQoxUfGsxWHnoc74x+E45tjeD/SKfmc5lCPm4xx96zHsiENRI9ZWi9ncJNBamO6SkCHRDIJITHvnqrytscTs/tPeHZrK+blkU6RBkkZwHAIjtxuYaiYUAokXiEZFTOVaD+yYl47DE/2tB0HI4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye4pmUvm8VgcrpkuaUf7elgrpGfaaAmy1K42E1F9ZgI=;
 b=NUlALPp3ojikx3iMXewagRn0zxGDCXiOWUzskqsOQrMJpQeW25vxe7jZ160C0s7Kt0PIRcmSC+RXFMA9+FDwRrnqQw4fsqtXesoXz8A0DE8kCF19eCiuzk+cO8naWjW6uAedpKf/4Vl9DT10H4v7UdWtbWYMZ39pUDyojvistBZPWG3DV+tOSx5rnrlJoKEhz14JMeN17p/Ej6GEPUnNoFPvSAPON8DCJKYUNG7Pvo4Q/Req9cz/0N9lNS+R80kXLZ223rfC4L3FagJd74c4M3/qc89xqMeD8U8Nia5m/OvfZ/v7jFgUlezR+OG53EHSRY5mmo5BuSRHVZ0XevnJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye4pmUvm8VgcrpkuaUf7elgrpGfaaAmy1K42E1F9ZgI=;
 b=tBdMRo/80mYNyeJIk5ex/q76/pPDPaf6soKWu64k52h5Njxkx9bMsjWYdaLryj4qP045BQn7i1+1qdGcSW+nWGRQqxgH6PG99QXc+E1C7NS2zEwy/ng9hepSJEvjbli20/A/9UD047mW9YPN6V9Zv4znDVNV0VkWtvCIaux+C7U=
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by BY3PR05MB8097.namprd05.prod.outlook.com (2603:10b6:a03:369::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 06:05:37 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 06:05:37 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [PATCH v2] sctp_big_chunk: Do not use md5 hmac algo if fips is
 enabled
Thread-Index: AQHZpRjshbyzmGts9kytuDOqGFhoJ6+epAmAgAEe4QA=
Date: Wed, 28 Jun 2023 06:05:37 +0000
Message-ID: <457D0308-BECF-4247-9936-E167E64AE4B1@vmware.com>
References: <1687445437-2453-1-git-send-email-kashwindayan@vmware.com>
 <20230627125849.GA36960@pevik>
In-Reply-To: <20230627125849.GA36960@pevik>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5409:EE_|BY3PR05MB8097:EE_
x-ms-office365-filtering-correlation-id: 0c9c565a-b8fc-4cc5-d10f-08db779db160
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D7ku9v0XsR4zs0dbITlOZCw+/7haH3RCbWZYVHgnk232+MJ8E2GqNX1J9okGulsjlSPqa8YyVEYSFv9NYO0WSFTt72Hkfd8snaYaxtVjfaoNxK12uRVMocQ1TRbNOLWhhY1lJcWMskJwhYXB2uxPCbAsNZTYUWJ2rc+M8tBEl/S2/vLeT8y6IVWJoqmzfrBCVYU4YRBQIpE0TPidrLrupLXpvNNjP6EWhTudn6spLbhJdAzYPY8aHBWyc+3bAsGW1hM9wteBqZTPHOR9foP5jfJG5yPpuMuIIgjjDXaO/bRPvQNDWMu02dfA++xo+xLRbVdYnCvXg+5wSabuRKTkD83CNGmmYC2P0J6aHEFt+sAa7vZr8Vrnt55TUjzsqyBlQKeJjNhCMxWLyTym3nwx80/ptJbTYbuNNWKnFT0cIL21+8CzI7kjgYVXJfGRV/ULeenp3MiYHy+BkYW6teV3GR214+JRDTQK81YibIydYQVAnUUvzuBPy7tyY2mwEBvG5Ll7HLOTpIv/0b5SAlJ77FD7jCd9ta3m/MUdLAF/SKLrOdBBmgMIt7U+HB/oGyB5VPRsZOnuBKrrLJkRAUBI2R+dwqi88IFSqhv7SknibA4NkkupXgKs4NnlxagYWRNdUzETJrpFl3tbyJwA45bq+aI2PjorSTQxAAJxSw3U97/aFrRqimTcLXe7rMY7Q7HtHMelMzCsbpqmUXrWBo9IAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR05MB5409.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(66446008)(53546011)(36756003)(33656002)(64756008)(5660300002)(86362001)(91956017)(8936002)(8676002)(66556008)(6916009)(41300700001)(66476007)(122000001)(38100700002)(316002)(76116006)(4326008)(38070700005)(66946007)(2906002)(26005)(186003)(478600001)(6506007)(4744005)(2616005)(6512007)(6486002)(71200400001)(54906003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q9HY/prSlaZQcSd7npiPPlh6WsSPgQP0NDkSLe9VTkWAF7tpTOhnpbAAcSp+?=
 =?us-ascii?Q?xOC8TpSNBspe36UL5VWfFyUz2KWLZidMlsO54KEXZ2YznGlch3OqMDxMU1DY?=
 =?us-ascii?Q?0PDoveTa588j6awcKOuzMe6VNiEot7jnENcFDgt96A+qJo1FWt4GY3Kmqg3a?=
 =?us-ascii?Q?oxV6+6jrivJKo53/a/9e1X6zPQ17OBtDV+1EajQQ4xn5D+jKwdovNiZYCjNh?=
 =?us-ascii?Q?4Ty2JwoBvNzZkzLi7fxsa/N1A31F8/mS55+ibh/xiG0WIRKZfrzM2JpFoKfc?=
 =?us-ascii?Q?S0NE3LC7G+67Y1xuel6lyx+2o8ib4Jw+PCgOlUjHBncglVe5nxCrZ0w/zfHv?=
 =?us-ascii?Q?0JtJR8OhwTZii7kqULsnJtHz3DqkUxV2m6ay3ncek6XRJjm19Hcl0iMhRAho?=
 =?us-ascii?Q?b5R1NJxxxfdLcGO6g6LeeW2IbSeq6jZJqfSjdy3w7iyLXosMUev6ciSisPXT?=
 =?us-ascii?Q?IGQSbe6iyzE5ObbfXdeodBTwI+X62dP20LvZUwoWvIvRUbuwRwRyK+4Un+El?=
 =?us-ascii?Q?xE1japUrvdD8zDs6cCBV6e/zIWMSWJRxqhCe7GzePbQ9TfgmYQ2Zg9GkZ6Hz?=
 =?us-ascii?Q?loVeKuQYN5y65E61b2S5tJUroJb6WrANBydOm845FfezuNP9m6QHxeP2KSaZ?=
 =?us-ascii?Q?P2ZRA9m1jRo7t970JL+T5LWg6DgAe0/DE1prPU5kwUgFo5sr6N8LCXJee5Le?=
 =?us-ascii?Q?i5XNJwqH7I/Mg74e45UVNvxL9zmVj5GJyag01Gbdf8i3NM33F+6F4le+HnwA?=
 =?us-ascii?Q?Z43FmsbwbYDxWdqOX2c6mMzeeJ9SgvOV4zWl1+xS1DyQfC83KpQj3UyVNloN?=
 =?us-ascii?Q?z+XVG++G+7qRjQ/I7Ku0siSCgwp5RTLb6RUpNowrCNfDbYSh8l7ovH8GY06D?=
 =?us-ascii?Q?guniIw+6VxSjHNnLe6Ig8TWNrtngOQ8UHD5xgQ11JQ0wLcZdnBOJ2LpXSP+V?=
 =?us-ascii?Q?B+KBqxAjwTN7bQcUFvwyrCrIuVfDG0/aNECbhCNEy3RVWWCN82nj+3mzlRV7?=
 =?us-ascii?Q?cDO6fSJrpRk44COuYJLU7BeT7zVknajyk+Wwx41U1ky73maGv77rvtREOFfi?=
 =?us-ascii?Q?7f9OACB1/+9DXmtxlaTZKyi7GowQEnSZTkU6+gaRNcaqLVWDpolHN7+qZVCQ?=
 =?us-ascii?Q?MHpBF4y8b5EgIYSKjziutEGv2SxZOvE5tLn5SYDcYjEn7QtmF4Enco9LHrNT?=
 =?us-ascii?Q?oObGyzBrRGRt1xopWlBgwhoFzQLjm2X0OgOdG3P8S+NdFZIQp7+VJ11O/Dnj?=
 =?us-ascii?Q?aXpz53hRK1o3+y2g7z+xXBPB97r/j+pJAw07tj5Sd3bFvqv7+ug6YHODA1mE?=
 =?us-ascii?Q?22IuCaK/0bVfXJO+q8TMo1k+ywAumfvdjTuzbZqrUmZ1/tU8dYH45LuYSPJx?=
 =?us-ascii?Q?llB3nk6DLBrrZIa9AE7gy9Ax/Rxn+yyIhv1lVgPSogMJsn8XuL5SfSRuU2rR?=
 =?us-ascii?Q?zGLxEYH0EPEHkHGz4hn3fEBk3VEBuOthGQY7QoHqmfuAcdrP1jIo3+w3yBcy?=
 =?us-ascii?Q?NIYscyGWgbZl6mDiLDqW2xaZC1ADJiP8aSDKw7rMoivlJR0CSKximMwmSocL?=
 =?us-ascii?Q?sXNI3rulEmnusEFvs6FDbZcNqdZ8hnXKQBm9hmp6QDylL8Q6Ub/YIdDbd6n/?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-ID: <88E3EB2F0D09EE4DA36C6CF63EA2D86E@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9c565a-b8fc-4cc5-d10f-08db779db160
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 06:05:37.2312 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbckfsaVHLKqNTFqE4FuAaeq0zY4G80YnqNAm++FfTfWYAjTXTpXSGlJRxp10bPmOxizqhFJFTRnh5SKN4sv6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8097
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sctp_big_chunk: Do not use md5 hmac algo if
 fips is enabled
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
From: Ashwin Dayanand Kamat via ltp <ltp@lists.linux.it>
Reply-To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Cc: Tapas Kundu <tkundu@vmware.com>, Ajay Kaher <akaher@vmware.com>,
 Vasavi Sirnapalli <vsirnapalli@vmware.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> On 27-Jun-2023, at 6:28 PM, Petr Vorel <pvorel@suse.cz> wrote:
> 
> !! External Email
> 
> Hi Ashwin,
> 
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> LGTM, but as I wrote, I'd prefer so load with SAFE_SOCKET().
> Will you please send v3?
> 
Hi Petr,
Thanks for your inputs. I have sent the v3 patch and have made changes as suggested by you.

Thanks,
Ashwin
> Kind regards,
> Petr
> 
> !! External Email: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
