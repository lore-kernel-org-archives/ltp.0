Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860F6EED615
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 15:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726156235; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+uWkildbXoDdMpyx0zViogQ/7cilrv67pNBMLyCiHOU=;
 b=EAgg9ktlzC4Cd/cEk8b8WmsTGa5/FIrC5ix7Phl4OoVxelJBhcg1H2x6YjWZVCper3ChZ
 73Cdu5K3Njw72xLdAakEdxNyCcXf/BcamV1cy/pTwiz7Z3XvWdag7xU0ojvIzqyU877rvAj
 hNHw9MPZbqDbaTSmbKyJbeXFNjuBrfI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6F8F3C26F1
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 17:50:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB48E3C0F3F
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 17:50:14 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.165.32;
 helo=mx0a-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 46A0010060B6
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 17:50:12 +0200 (CEST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CDtZuR021627
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 15:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=corp-2023-11-20; bh=xW4efh47Yyjdo/04cx8VlDuXOqFQsqbjqoi34FV1M
 PY=; b=B2YuG5sqXLkNLup+Bu4n1BgqiVbzzARX+dqHtNFg61TkTSntDICIdD6Mp
 G0avmycZ2itktUtDalGtFqMlo4x/1rNk35yb5DrNX98TnUEpj/KnQ/s8KWoh2l+O
 iuGqZjb4/2Wptm2Uml8WqGUrnbM36qMTecnJvSigOyoGKkPba+09bsgPf+LWHSU1
 EtvJu95rhica77kJPvI/0tQNTBGDxzMnpS+ycJKBCVXR9ndMelOPRtGspdnZ1Djr
 TVOD9Q9FyC3lc92OSxvqsq74Y1vIfYffFndxDh+fC+G0uWlxmNnqCCygTQDsn8gG
 pXb6ent/wsukYti5H/0iNnbAaOF1Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfctk8x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 15:50:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48CEj9DI019770
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 15:50:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41gd9j0r6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 15:50:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBIJA1DvpedUkAXE1cYjX7Mp7MZFA7E/0XXI8XRk9qtMZ1IF7udTo/c13cO0liXSV1Scxk2UbuZwkc9cNg7qe4zwKxGA2sYzHb/T8X5SxGw40gSQDC8H2U1hmFLIrFvAj4oMFyHedFqjZXk+geIrVA90P5ZAtUQHjZ14vTUrdKgUZ8jq6GwLfeCL+tXvqIKr0SASh2UvQmxQhzZnuj3LepzfRAFaQgyYXbM2FFE1vSZCiTAYx8lAAHoR+bhXLAi6pCbROwZmlofDAIjm8ZWD38eh0VuqZjjF8VejYett2SSccyRpt/kxWAxJi4d2BvCcSGgD0kPvmTDY9bEgg8JeRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW4efh47Yyjdo/04cx8VlDuXOqFQsqbjqoi34FV1MPY=;
 b=mf9cA6ysIbq5mWWESnD6AdezXp+4K6SP17K83mCSPUWD+pYpVs7hxi9Sjm6z1oHnTBeHnqSmLwuijR50wqx0vp/QF4AQDNGIUqPBkHNY/03czF+LmH9Anl25JpvgwQasOc3biBJiHAdHuwDHw4hRAxQIUD3rx2pBFt//fQcdvfMoFVrqVO7Sa7twSz3WqYWFh5pTif9Pnj076Q45qGkEVyqnVQg6iNNCylGbBguH0KBWisc9kufXg2GTn24RqIyuXhf2xhb1qFxeLp2EZqNI4sN00kSVrJrIoIUkc6vn3H4M0cyD13UjnjVH5PJNYgLEsiYqqrLi4OaG5cIJmG/tIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW4efh47Yyjdo/04cx8VlDuXOqFQsqbjqoi34FV1MPY=;
 b=l1LMd8ZmWXM7h/rkCEp3YxqFX6QGdMWhq32BCtLlJwpT7UyeEqOKQzgStcuT/RjQGyqnLrx/3bx5x8EenqBFtpO9M/17e74m6/OELfi/MoNSYREYElDFLntkiZltn5BfQFqHxl8dwxadKSz+OJpLSJMajgwckSLXbca9q5uMIVI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4862.namprd10.prod.outlook.com (2603:10b6:5:38c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.8; Thu, 12 Sep
 2024 15:50:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.003; Thu, 12 Sep 2024
 15:50:06 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: TI-RPC test failures; network configuration related?
Thread-Index: AQHa+kqUd5GqyOUrQEOhJTzAS7dpNrJUYj2A
Date: Thu, 12 Sep 2024 15:50:06 +0000
Message-ID: <FB5CBAAE-D2A4-42A2-93D3-FE2C893871AD@oracle.com>
References: <662B8BF1-099A-4CD0-94AB-267BE738130F@oracle.com>
In-Reply-To: <662B8BF1-099A-4CD0-94AB-267BE738130F@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB4862:EE_
x-ms-office365-filtering-correlation-id: ec87ab43-a96e-4257-4d08-08dcd34292b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RWZpd0h6cUlOUG9hTDZQc2RuQ3hKVmRZRFRaWnRvRTViSmdxb2tHR2VmY0tp?=
 =?utf-8?B?ZU0veHVYdnRMYjFFcVFtdStxMXpSbTBmVjJCY2hJaDRQd3RRWkVZQnJvbExq?=
 =?utf-8?B?Q25ZMjhHYVRid3NFZVFqV0J2N1VwUjd3L29VVDI4aTRKazZuTDZtQ1pvMS9p?=
 =?utf-8?B?anZXam1WUHpYOEZGRzNFdmdjSkVKMGlwSVRzdjVMOEZFTlNtRDNKQlFmdDZK?=
 =?utf-8?B?bC9BbHR2SE9adUY1VlJVMnQvOGRaTk13dnMvVGpqbERGd1JtUnpTTUp2bjVq?=
 =?utf-8?B?Ym5mcnhKdFFESEpxQTl4RWpkdGdiQzNuRjBldXhGY2gvZHdBazVEbE8zQlc0?=
 =?utf-8?B?S01YeEw0V09vSG8zeWh2UUZPek9lZ3VoUGpJNThKVjhMN3MzQWZwTDR4amVS?=
 =?utf-8?B?eGNVanNycXg0b25qM1YyT1kxOXZyeWpLb0JFN1dyamJST3VKTnFjaG9JY0Vt?=
 =?utf-8?B?UDNqc2dwWTc0eWZRa2lvbFVCMGt1eE81WTNYNmx3NnpTUFdGRWNQdUZRcitl?=
 =?utf-8?B?d2tZZ0EyQWFpQmdWemR0TkxYd3B3dGdPMGxQSGZiUlREQ0NLL1NKUUFzVlZ6?=
 =?utf-8?B?SU1EYXRrZjJpNzV4ck9DOUdwbEdSaUFzN0p5VUFkaGpKakpTeXg4TkVTSm9v?=
 =?utf-8?B?NXlYK1c1cnQ5ZitmSDFvNEdjUkdCUThvSmpCa04yYUJMT3NLeUlaVll0aWIv?=
 =?utf-8?B?UC9CbCt4RndwSStVOGdWMnF6cG53ZnhpdlFrWU9UbkdnTFArRFpueXA2SWR4?=
 =?utf-8?B?ckpUeFJKVm1jQlRHMjdoRjFQQlFONzBPRGxOUWZMWVFmc2ZoOXFsMTFHcisr?=
 =?utf-8?B?TXdTc0EvTFNvUG9ZOEcwdFQ5cWhDQUlRNUhINkVzZy9IRExwT1VGZFZNc1Z2?=
 =?utf-8?B?b1Q2ZkU4V0tWRUNPQ3pDaEF6WmkrQW8rR1YxK2wwTEdPT2Fuci9xVXFqRVB4?=
 =?utf-8?B?YUVmdzVPeE5HbStVQWpqb0ZjQXdiMTB6REdrWi9La2dCTFUwMmNBV3pudURo?=
 =?utf-8?B?SHFEN2U5YjExT2w1S0tvMzQzbkVCQnVTQi91ZFlIWVhCU0IxYURRYWczbGVs?=
 =?utf-8?B?OHltL3FsVExpWjZUL3NjMEU4ZmRxcTFLZm5YZWh3SFU2U1FVbGUvV0VOR1FP?=
 =?utf-8?B?QzExbnZGaFJ4Ymo1TG1LQ3ZjeUJXZmgxSk1ESnBGOXdVSE9Md0hldy9ORm1u?=
 =?utf-8?B?YjRtSUxIeXZMWDZWTHFLcDRQSzhSWmF0bmozbWU0SHFLR2tRWnBROHBoSFBp?=
 =?utf-8?B?cUJmSWdaWWRHblVOLzRkNDdZMGdSVEpaVWl1ZjExcittN2JKckN0TlBHZHVs?=
 =?utf-8?B?Sy9yR1lMKzdGRmh5TENab1owODBmYi9HY3hyQ3U3QjJrZXNYcE1jZC9KMVNw?=
 =?utf-8?B?RW1BUFVIVGwvejh2ZFBLc2VZRHp2Zjc0T3dEckRnNGZIN3RUVnRCaGdXenR5?=
 =?utf-8?B?WThtTlYrckw0TTU4RjFiSUZFczM4d2NncmdQdnRYMEs3SWczVjRzTzVMZTVt?=
 =?utf-8?B?YzhVNFlwVCtDYXNkaG9qSmtCYTRwT0dEMEtHODBxanYweTRqaVBOODNUQXh5?=
 =?utf-8?B?MW9YWVg5OCtmdGdicWRuUWhaODJQR1owYlF3QU0zWXVlc0o5UDhwa1NqWUhn?=
 =?utf-8?B?b1llSFR0WVREMGdEMk91bWJoVUkwT3ZXRHhGdmUwRXNHbXl5bFl5N1FULyt6?=
 =?utf-8?B?ckFvSnI0MDZCTDFwaXovMXZoS3I2L2hiYTk4MHRyS1ZYQjJVekNTVzZJamtG?=
 =?utf-8?B?NjJ0OCtGMnRob3haUmwzZWQ2ZnBsSWw5TWRzU1UzbUljNStTMll6Z1VJL2hF?=
 =?utf-8?B?LzJjYlBEcWFwRHdSVlhqckp5dHlVNHpycTNjTkg3N2pTREgwbCtldTR3YVM4?=
 =?utf-8?B?OGt3dSs4dzFIVDh6VUR6eW5TQ25SK2x1Z3YvWUpQZ25VeWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVRwNDMrV3pOeENKWXJhTGd2MTF0S296c0hqcWMzdy9QTjFLUlRFVllsaUNH?=
 =?utf-8?B?NG1Lc3NOT2ZDZllpZU5laUZvRWRTdDhRb29mUG5aZEs3UGtJamhhYjBrTkNj?=
 =?utf-8?B?a29DVHgvZzZMeS9IZmhqQXI4NXVORDhyZ0ExWGxVaHlFblRSNWFzSVlGQVJq?=
 =?utf-8?B?TXE3amM2ay9EbU1xVUxveTdjRWlTS2pkWU5ubHhvZ0EwbjVaSldHOHRMVnhi?=
 =?utf-8?B?THJUWVhyRWxzL2dpd1JlWnRHaXNWVFE4VmJNajdvaXp0bVcwOFZFWXEwbGV4?=
 =?utf-8?B?T24rMGM1cVhPV0RVUllBS3RsZjd3THZETFUzTVZBUVBDQzVLWkY1dUJiWlVm?=
 =?utf-8?B?VUVuWk51NVZKaXVnS0lZN21DdHRQMzJ0TEZ3UURQNVhqMCtxaXZCMEVsbnQ4?=
 =?utf-8?B?K0orZW9YemY3ek92RkZlNXZQamQra1paaU9BZ25rTU5oakxrbmFtcHkxcTRC?=
 =?utf-8?B?V0F1bi9rMHVaeldIMWFvRDYrYVR1TEo1ZVFIZGZFejIrYmJMb1FSOW9YL3E4?=
 =?utf-8?B?alJLOVpyRFhUZThOY1RvanJCWGJIbEt0N2gvREVTTVpJSCtMWTh2bXZkS2Jj?=
 =?utf-8?B?aEh2SFJCZkhJZjBlNkR3eTBzWnM3S2hjbEdHUW5rWitscGdRMk9mQVoyN0FC?=
 =?utf-8?B?cTJEZ0dVR0p2dnFBWDNiTWZidlY1aTNCakkwa3ZrRkUwa0RrZXJuWHl6MkR3?=
 =?utf-8?B?TG5EaVh6L3M5UTFVVEZFK1VmeTZ5ZU0zVlgyb1pJSzk0QVh1Yi82dWhIeDhw?=
 =?utf-8?B?YlNDU1ZVQSsyOUliajYzZTJmRk44b2JrMjk3bHo3SEdBTDYzc2gyQkdXNXgr?=
 =?utf-8?B?MDc0VUwycXhCSVVsYlFaVmI2S1JGa0sxR1NRc1RuN040NWNlSmxJbWVOZGx1?=
 =?utf-8?B?MENjTS9YMENRS1ExMHNhTEk1UDgwdi9YbnRiMVIyK0E5d3p6VmdGMG1LUk8z?=
 =?utf-8?B?eDUxenZ5a1dtdFFsOUdhcnA3NmRXMlNrTzhUTUdBMVQrak5aZFBobHBITmMx?=
 =?utf-8?B?NzdmQmh2NXdtaGQ5clYzNXhmbjdtck9sYWg3ZGwvbGJnVGk3SGtoWmNYWFFs?=
 =?utf-8?B?L0Y5ZmhzSTUyQWwvTFNzOThPekhCM2JBNlRoRm8vK05kSE1PanVBZFY4bkFa?=
 =?utf-8?B?YjBxa0VWZ3JiaWVzTERiUkZldzhabVp2enlHa0JnanJQTDJDd2phRlh6dFpy?=
 =?utf-8?B?TGQ3Q2ZqNVdVVEJQYlBpcUZPMXdCMnZybUhPdHNjMCt5TEt0S3ZaVVJKempY?=
 =?utf-8?B?N2k5YkdFUllwZGZNNkxpdXlqN2cxWE5IOHRPSS9iYk1IM2FHL01LMHFOakRy?=
 =?utf-8?B?aFRFMjIxWEdTU2RCeGFOZm13Q09iMENaTVpOSGVxOStpd25RdmpHdzl5Qm9P?=
 =?utf-8?B?SkdVTkdqNHF2a1dwbUZjbU8wYnFFTlhqOUVXRFJRTzI4T1BwbTIzcDRqRG4v?=
 =?utf-8?B?VllldUlzRURySDVwcmxKbjJxS0ZVai9FbHdESnJjL0pKdnUwY0QzVTlaTkdh?=
 =?utf-8?B?OWJCYkZORDNGcDBQZ0FSUklnakQyR20va0x5MXNoY2U3WjVCdFc3TDJTUm1a?=
 =?utf-8?B?cUpkSHFqeXV6YXhuT21wVkJtOGp2VkQ3eUtReGltZTdiNUVDY1BZRWs3UW8v?=
 =?utf-8?B?YmtiYVFrVDZRR0w1Vk5WajlFZzMySU1VaHBWTGtKaGtpSTBOVGdCV1ZueWdC?=
 =?utf-8?B?QnlnSmRTaVh2OHE1aWdJRWJvZWFUcGUyNnlLVTE2V2VRL2xYN0lpZ280bTRv?=
 =?utf-8?B?R29kYzdwNFBuZXVMR2IzbEhZdjMrRkFIRGVpaSt4aFVkVGJSSFFxOGxwNUtR?=
 =?utf-8?B?RURJYVBGTkg3K21zNzFWSFludWY5UldPZEFZdm9COXZjYVpoY3BMT0taVGdw?=
 =?utf-8?B?UDd2Tnp5UGVVQW0vVWIyNWVVV1NsU09RbER0Z2UwWmE0dmJEMGltU29Qc3Vp?=
 =?utf-8?B?bDJ0UmErK3lleDlqbzNZSlBQQndWNnR6bmtJQU9yR2VyS2RIMCtnR2dqdmJs?=
 =?utf-8?B?ZU9qZWc5Y2l6cU9pZkoyQW1IV2EwbUdnQjB4L2NiTG1DOHNLSUtsdFdvT3pU?=
 =?utf-8?B?NWNoUFdhZnc5MkVBcU0yc2dUeVl6Z1RjSUFRajJ6ZEwyR202aWl6aW5Uci9m?=
 =?utf-8?B?TnMwMHRnaHBtT09rTGF0V3pvQ3RpNmYyb1loME9UUkhwcHE4bjE3SzVrNXcr?=
 =?utf-8?B?c2c9PQ==?=
Content-ID: <8B455B3109DC9C4EA330F9CFED3FF4CE@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HFuLsem5E/AI2P3hupCd05GJo3CiDF1I10rXEEd5AxEMsi/ehQuR6/jyFVGWTZKqosPTvjCwkXRccRC4pjSbfWQUr/j1WrynSImKlkkYjf+3/uCVxY2K64mrOWgb3O87ez3z7tIk35zE3DEEmKa5O4rNoMRXinbXW2Xb1IhE8pB4vfa0qYVJN8nKhF7s0i9jkiEZgObzJBUgeqMmg7cx+kT7myKc4bosQckV1P3eNm4CY/jkaJ+aVg3Fwgxhudv1qk7mBSJWN0safJJTmwTkzO9thQCmyb0r9+jqPK2bNvj6DqJR0U+OO4510ml5boSPtgw9aaPw3VOHZ3sD79jjCyvT8Fg9uZgbpaBHRAC+Tc8xy4yzu3gSd9Kwfx1acIf9w3T2urdSSSKLdVHpZzZSHMb/Khli6dRzuazZLEdwyRai6kRPlIuKkFs01TumEOhTXSsP8bBaFHSpwdIm76YNQ5pJpKAHwZAyI+eGPDoJCMWh5n5iOKQCyv01ZlX0x3C1rKkQJAjia9nJt0569qv8JYxxJToDYVkY5F9mDGueV91a+GUkFUwWTr+7JWjlxzICBzav79PNJuMlgTGkKckdPMdqm9SkKB8f6EDDL/gxGlc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec87ab43-a96e-4257-4d08-08dcd34292b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 15:50:06.1563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InZzWpcNNsxf3l4ucGPSkuBrn3s7IWCvPUfaQKhomN5qAXT9zJ4bn02cbrVMqwsJvcyTfxJJ70OSZEiJ6ISo3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_05,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409120116
X-Proofpoint-GUID: bg8PtN2MKpWyZdfVPsMjmJ-e9ykkPGuG
X-Proofpoint-ORIG-GUID: bg8PtN2MKpWyZdfVPsMjmJ-e9ykkPGuG
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] TI-RPC test failures; network configuration related?
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
From: Chuck Lever III via ltp <ltp@lists.linux.it>
Reply-To: Chuck Lever III <chuck.lever@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gT24gQXVnIDI5LCAyMDI0LCBhdCAzOjM14oCvUE0sIENodWNrIExldmVyIElJSSA8Y2h1
Y2subGV2ZXJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiBGb3IgYSB3aGlsZSBub3cgbXkgbmln
aHRseSAicnVubHRwIC1mIG5ldC50aXJwY190ZXN0cyIgaGF2ZQ0KPiB0aHJvd24gYSBidW5jaCBv
ZiBmYWlsdXJlcyBidXQgSSBoYXZlbid0IGhhZCB0aW1lIHRvIGxvb2sNCj4gaW50byBpdCB1bnRp
bCBub3cuIFdpdGhvdXQgbW9kaWZpY2F0aW9uLCBhYm91dCBoYWxmIG9mIHRoZQ0KPiBjbGllbnQg
dGVzdCBwcm9ncmFtcyBzZWdmYXVsdC4NCj4gDQo+IEhlcmUncyBhIHNhbXBsZSB0ZXN0IGZhaWx1
cmUuIEkgaW5zdHJ1bWVudGVkIHRoZQ0KPiB0aXJwY19jbG50X2Rlc3Ryb3kgdGVzdCBjYXNlIGFu
ZCB0aGUgcnBjX3Rlc3RzLnNoIHNjcmlwdCBhcw0KPiBzaG93biBiZWxvdywgYnV0IEkgc3RpbGwg
ZG9uJ3QgdW5kZXJzdGFuZCB3aHkgY2xudF9jcmVhdGUoM3QpDQo+IGlzIGZhaWxpbmcuDQo+IA0K
PiBTZWVtcyB0byBvY2N1ciBvbiBhbGwgcmVjZW50IHZlcnNpb25zIG9mIEZlZG9yYSB3aXRoIHN0
b2NrDQo+IGtlcm5lbHMgb3IgY3VzdG9tLWJ1aWx0IGtlcm5lbHMuDQo+IA0KPiANCj4gW3Jvb3RA
Y2VsLXRpcnBjIGx0cF0jIHRlc3RjYXNlcy9iaW4vcnBjX3Rlc3Quc2ggLXMgdGlycGNfc3ZjXzIg
LWMgdGlycGNfY2xudF9kZXN0cm95DQo+IHJwY190ZXN0IDEgVElORk86IFJ1bm5pbmc6IHJwY190
ZXN0LnNoIC1zIHRpcnBjX3N2Y18yIC1jIHRpcnBjX2NsbnRfZGVzdHJveQ0KPiBycGNfdGVzdCAx
IFRJTkZPOiBpbml0aWFsaXplICdsaG9zdCcgJ2x0cF9uc192ZXRoMicgaW50ZXJmYWNlDQo+IHJw
Y190ZXN0IDEgVElORk86IGFkZCBsb2NhbCBhZGRyIDEwLjAuMC4yLzI0DQo+IHJwY190ZXN0IDEg
VElORk86IGFkZCBsb2NhbCBhZGRyIGZkMDA6MToxOjE6OjIvNjQNCj4gcnBjX3Rlc3QgMSBUSU5G
TzogaW5pdGlhbGl6ZSAncmhvc3QnICdsdHBfbnNfdmV0aDEnIGludGVyZmFjZQ0KPiBycGNfdGVz
dCAxIFRJTkZPOiBhZGQgcmVtb3RlIGFkZHIgMTAuMC4wLjEvMjQNCj4gcnBjX3Rlc3QgMSBUSU5G
TzogYWRkIHJlbW90ZSBhZGRyIGZkMDA6MToxOjE6OjEvNjQNCj4gcnBjX3Rlc3QgMSBUSU5GTzog
TmV0d29yayBjb25maWcgKGxvY2FsIC0tIHJlbW90ZSk6DQo+IHJwY190ZXN0IDEgVElORk86IGx0
cF9uc192ZXRoMiAtLSBsdHBfbnNfdmV0aDENCj4gcnBjX3Rlc3QgMSBUSU5GTzogMTAuMC4wLjIv
MjQgLS0gMTAuMC4wLjEvMjQNCj4gcnBjX3Rlc3QgMSBUSU5GTzogZmQwMDoxOjE6MTo6Mi82NCAt
LSBmZDAwOjE6MToxOjoxLzY0DQo+IHJwY190ZXN0IDEgVElORk86IHRpbWVvdXQgcGVyIHJ1biBp
cyAwaCA1bSAwcw0KPiBycGNfdGVzdCAxIFRJTkZPOiBjaGVjayByZWdpc3RlcmVkIFJQQyB3aXRo
IHJwY2luZm8NCj4gcnBjX3Rlc3QgMSBUSU5GTzogcmVnaXN0ZXJlZCBSUEM6DQo+ICAgcHJvZ3Jh
bSB2ZXJzIHByb3RvICAgcG9ydCAgc2VydmljZQ0KPiAgICAxMDAwMDAgICAgNCAgIHRjcCAgICAx
MTEgIHBvcnRtYXBwZXINCj4gICAgMTAwMDAwICAgIDMgICB0Y3AgICAgMTExICBwb3J0bWFwcGVy
DQo+ICAgIDEwMDAwMCAgICAyICAgdGNwICAgIDExMSAgcG9ydG1hcHBlcg0KPiAgICAxMDAwMDAg
ICAgNCAgIHVkcCAgICAxMTEgIHBvcnRtYXBwZXINCj4gICAgMTAwMDAwICAgIDMgICB1ZHAgICAg
MTExICBwb3J0bWFwcGVyDQo+ICAgIDEwMDAwMCAgICAyICAgdWRwICAgIDExMSAgcG9ydG1hcHBl
cg0KPiAgICAxMDAwMjQgICAgMSAgIHVkcCAgNDY5MjUgIHN0YXR1cw0KPiAgICAxMDAwMjQgICAg
MSAgIHRjcCAgNjAxOTUgIHN0YXR1cw0KPiAgICAxMDAwMDUgICAgMSAgIHVkcCAgMjAwNDggIG1v
dW50ZA0KPiAgICAxMDAwMDUgICAgMSAgIHRjcCAgMjAwNDggIG1vdW50ZA0KPiAgICAxMDAwMDUg
ICAgMiAgIHVkcCAgMjAwNDggIG1vdW50ZA0KPiAgICAxMDAwMDUgICAgMiAgIHRjcCAgMjAwNDgg
IG1vdW50ZA0KPiAgICAxMDAwMDUgICAgMyAgIHVkcCAgMjAwNDggIG1vdW50ZA0KPiAgICAxMDAw
MDUgICAgMyAgIHRjcCAgMjAwNDggIG1vdW50ZA0KPiAgICAxMDAwMDMgICAgMyAgIHRjcCAgIDIw
NDkgIG5mcw0KPiAgICAxMDAwMDMgICAgNCAgIHRjcCAgIDIwNDkgIG5mcw0KPiAgICAxMDAyMjcg
ICAgMyAgIHRjcCAgIDIwNDkgIG5mc19hY2wNCj4gICAgMTAwMDAzICAgIDMgICB1ZHAgICAyMDQ5
ICBuZnMNCj4gICAgMTAwMjI3ICAgIDMgICB1ZHAgICAyMDQ5ICBuZnNfYWNsDQo+ICAgIDEwMDAy
MSAgICAxICAgdWRwICAzMzMwNCAgbmxvY2ttZ3INCj4gICAgMTAwMDIxICAgIDMgICB1ZHAgIDMz
MzA0ICBubG9ja21ncg0KPiAgICAxMDAwMjEgICAgNCAgIHVkcCAgMzMzMDQgIG5sb2NrbWdyDQo+
ICAgIDEwMDAyMSAgICAxICAgdGNwICA0Mjg5NSAgbmxvY2ttZ3INCj4gICAgMTAwMDIxICAgIDMg
ICB0Y3AgIDQyODk1ICBubG9ja21ncg0KPiAgICAxMDAwMjEgICAgNCAgIHRjcCAgNDI4OTUgIG5s
b2NrbWdyDQo+ICAgICAgICAxMCAgICAxICAgdWRwICA1OTc1MQ0KPiANCj4gIyBOb3RlIGFib3Zl
OiB0aGUgdGVzdCBSUEMgcHJvZ3JhbSAoNTM2ODc1MDAwKSBkb2VzIG5vdA0KPiAjIGFwcGVhciBp
biB0aGUgcnBjaW5mbyBvdXRwdXQuIFRoYXQgbWFrZXMgbWUgc3VzcGVjdA0KPiAjIHRoZSBuZXR3
b3JrIG5hbWVzcGFjZSBjb25maWd1cmF0aW9uIG9uIHRoaXMgZ3Vlc3QgaXMNCj4gIyBzb21laG93
IGluY29ycmVjdC4NCg0KVGhpcyBpcyBhIHJlZCBoZXJyaW5nLg0KDQoNCj4gcnBjX3Rlc3QgMSBU
SU5GTzogdXNpbmcgbGlidGlycGM6IHllcw0KPiB0cmFjZXJvdXRlIHRvIDEwLjAuMC4yICgxMC4w
LjAuMiksIDMwIGhvcHMgbWF4LCA2MCBieXRlIHBhY2tldHMNCj4gMSAgY2VsLXRpcnBjICgxMC4w
LjAuMikgIDAuNTAxIG1zICAwLjQzOCBtcyAgMC4zOTIgbXMNCj4gS2VybmVsIElQIHJvdXRpbmcg
dGFibGUNCj4gRGVzdGluYXRpb24gICAgIEdhdGV3YXkgICAgICAgICBHZW5tYXNrICAgICAgICAg
RmxhZ3MgICBNU1MgV2luZG93ICBpcnR0IElmYWNlDQo+IDAuMC4wLjAgICAgICAgICAxOTIuMTY4
LjEyMi4xICAgMC4wLjAuMCAgICAgICAgIFVHICAgICAgICAwIDAgICAgICAgICAgMCBlbnAxczAN
Cj4gMTAuMC4wLjAgICAgICAgIDAuMC4wLjAgICAgICAgICAyNTUuMjU1LjI1NS4wICAgVSAgICAg
ICAgIDAgMCAgICAgICAgICAwIGx0cF9uc192ZXRoMg0KPiAxOTIuMTY4LjEyMi4wICAgMC4wLjAu
MCAgICAgICAgIDI1NS4yNTUuMjU1LjAgICBVICAgICAgICAgMCAwICAgICAgICAgIDAgZW5wMXMw
DQoNCk9yLCB1c2luZyAiaXAgYSIgaW5zdGVhZCBvZiB0cmFjZXJvdXRlOg0KDQoxOiBsbzogPExP
T1BCQUNLLFVQLExPV0VSX1VQPiBtdHUgNjU1MzYgcWRpc2Mgbm9xdWV1ZSBzdGF0ZSBVTktOT1dO
IGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwDQogICAgbGluay9sb29wYmFjayAwMDowMDowMDowMDow
MDowMCBicmQgMDA6MDA6MDA6MDA6MDA6MDANCiAgICBpbmV0IDEyNy4wLjAuMS84IHNjb3BlIGhv
c3QgbG8NCiAgICAgICB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXINCiAg
ICBpbmV0NiA6OjEvMTI4IHNjb3BlIGhvc3Qgbm9wcmVmaXhyb3V0ZSAgICAgICAgIHZhbGlkX2xm
dCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KMjogZW5wMXMwOiA8QlJPQURDQVNULE1V
TFRJQ0FTVCxVUCxMT1dFUl9VUD4gbXR1IDE1MDAgcWRpc2MgZnFfY29kZWwgc3RhdGUgVVAgZ3Jv
dXAgZGVmYXVsdCBxbGVuIDEwMDANCiAgICBsaW5rL2V0aGVyIDUyOjU0OjAwOjE2OjY1OmFjIGJy
ZCBmZjpmZjpmZjpmZjpmZjpmZg0KICAgIGluZXQgMTkyLjE2OC4xMjIuNjcvMjQgYnJkIDE5Mi4x
NjguMTIyLjI1NSBzY29wZSBnbG9iYWwgZHluYW1pYyBub3ByZWZpeHJvdXRlIGVucDFzMA0KICAg
ICAgIHZhbGlkX2xmdCAzMDIwc2VjIHByZWZlcnJlZF9sZnQgMzAyMHNlYw0KICAgIGluZXQ2IGZl
ODA6OjFhMmE6YWI4ZjphYzA2OjM5YWEvNjQgc2NvcGUgbGluayBub3ByZWZpeHJvdXRlICAgICAg
ICAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyDQozOiBsdHBfbnNfdmV0
aDJAaWY0OiA8QlJPQURDQVNULE1VTFRJQ0FTVCxVUCxMT1dFUl9VUD4gbXR1IDE1MDAgcWRpc2Mg
bm9xdWV1ZSBzdGF0ZSBVUCBncm91cCBkZWZhdWx0IHFsZW4gMTAwMA0KICAgIGxpbmsvZXRoZXIg
ZjI6OTE6YWQ6ZWQ6MmE6YWYgYnJkIGZmOmZmOmZmOmZmOmZmOmZmIGxpbmstbmV0bnMgbHRwX25z
DQogICAgaW5ldCAxMC4wLjAuMi8yNCBzY29wZSBnbG9iYWwgbHRwX25zX3ZldGgyDQogICAgICAg
dmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3JldmVyDQogICAgaW5ldDYgZmQwMDox
OjE6MTo6Mi82NCBzY29wZSBnbG9iYWwgbm9kYWQgICAgICAgICB2YWxpZF9sZnQgZm9yZXZlciBw
cmVmZXJyZWRfbGZ0IGZvcmV2ZXINCiAgICBpbmV0NiBmZTgwOjpmMDkxOmFkZmY6ZmVlZDoyYWFm
LzY0IHNjb3BlIGxpbmsgcHJvdG8ga2VybmVsX2xsICAgICAgICAgdmFsaWRfbGZ0IGZvcmV2ZXIg
cHJlZmVycmVkX2xmdCBmb3JldmVyDQoNCkkgc2VlIGx0cF9uc192ZXRoMiwgYnV0IG5vdCBsdHBf
bnNfdmV0aDEuIFNob3VsZG4ndCBib3RoIGFwcGVhcj8NCg0KSSd2ZSBuZXZlciBkZWFsdCB3aXRo
IHZldGggYmVmb3JlLCBzbyBJJ20gc3dpbW1pbmcgaW4gdGhlIGRlZXAgZW5kLg0KDQoNCj4gcnBj
X3Rlc3QgMSBURkFJTDogdGlycGNfY2xudF9kZXN0cm95IDEwLjAuMC4yIDUzNjg3NTAwMCBmYWls
ZWQgdW5leHBlY3RlZGx5DQo+IA0KPiAjIEkgY2hhbmdlZCB0aXJwY19jbG50X2Rlc3Ryb3kgdG8g
ZGlzcGxheSB0aGUgZm9sbG93aW5nDQo+ICMgaW5mb3JtYXRpb24gaW5zdGVhZCBvZiBzZWdmYXVs
dGluZy4gY2xudF9jcmVhdGUoKQ0KPiAjIHJldHVybnMgTlVMTCBhbmQgc2V0cyB0aGUgbGlicmFy
eSdzIHJwY19jcmVhdGVlcnIuDQo+IA0KPiBycGNfY3JlYXRlZXJyLmNmX3N0YXQ9MTINCj4gZXJy
b3I6IE5vIHJvdXRlIHRvIGhvc3QNCj4gMg0KPiBycGNfdGVzdCAyIFRJTkZPOiBTRUxpbnV4IGVu
YWJsZWQgaW4gZW5mb3JjaW5nIG1vZGUsIHRoaXMgbWF5IGFmZmVjdCB0ZXN0IHJlc3VsdHMNCj4g
cnBjX3Rlc3QgMiBUSU5GTzogaXQgY2FuIGJlIGRpc2FibGVkIHdpdGggVFNUX0RJU0FCTEVfU0VM
SU5VWD0xIChyZXF1aXJlcyBzdXBlci9yb290KQ0KPiBycGNfdGVzdCAyIFRJTkZPOiBpbnN0YWxs
IHNlaW5mbyB0byBmaW5kIHVzZWQgU0VMaW51eCBwcm9maWxlcw0KPiBycGNfdGVzdCAyIFRJTkZP
OiBsb2FkZWQgU0VMaW51eCBwcm9maWxlczogbm9uZQ0KPiANCj4gU3VtbWFyeToNCj4gcGFzc2Vk
ICAgMA0KPiBmYWlsZWQgICAxDQo+IGJyb2tlbiAgIDANCj4gc2tpcHBlZCAgMA0KPiB3YXJuaW5n
cyAwDQo+IA0KPiAtLQ0KPiBDaHVjayBMZXZlcg0KPiANCj4gDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
