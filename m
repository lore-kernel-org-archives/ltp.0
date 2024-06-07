Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEA4C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 16:29:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 386A53D0AA7
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 18:29:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB9523C23B7
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 18:28:53 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=sony.com (client-ip=185.183.30.70;
 helo=mx08-001d1705.pphosted.com; envelope-from=tim.bird@sony.com;
 receiver=lists.linux.it)
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com
 [185.183.30.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 291B710009E0
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 18:28:52 +0200 (CEST)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457FbKf0024549;
 Fri, 7 Jun 2024 16:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :mime-version:content-type:content-transfer-encoding; s=S1; bh=w
 zWlKBGHxRVEHR6UUbr4S8VXZfSxI5kxDVwt3vEzAGI=; b=SYCWlqsb1LOK9TFqX
 md9UbHrYGT8zrRrCUMOTQ7YaSabruTeekICeZnXEwF55c/7vFTKSeqWdxBDvcOqF
 IFZ8afdpZgjAzXix3GBpUGuvW2480O5F2MicYGF3AooJb/7VRkkfSFrBpTGvYNvt
 YS7mCnBoXgYfSn9Ph81ctekHZr8/qsF+GueK0Q+cQqnzOAUVQInACcDG4Mu0Jgo0
 qESHVNifME5wE+5KmE19sngMYGf1dc5sVhcspgaT3cNmrlH44Rktud7ifASvEyuY
 hiYQlxFtDR3xeHvIhNxszBi01Af/8whPi3f4nJ+be+UuoJjDtqnJ8VcGnLrXKkg1
 l7bKA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3yfw7rp58r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Jun 2024 16:28:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC0FoYmmtysMtYbDrBj19kijFeCLwGwj0T8jH+4twkQW8JtfCdMmbg+3u2v27nrcZUSTjJwbPAnEZJvHP9BYfU9ICGOlH+E0Ih4FJWvWO02qMymcw3ksu96dPHqbZseoTzuPNBa4bNipvxZhexT/iseF967SyH6z5KxDi0juDnfU0rV3BEihDyiY35z2hYJ3uj3ABgoS0VZkswGRXEx/kX24CUYLA8bXzU62KyKwTCp/JVrSJ4gIUh0RDk1hvpr1jm2dAoSHYenvHfzBkXHwk25/3ecbT0wwO+mDxKCD720CYO5seqcgGg6EMBspB9e0JWiPKf42QHjDZpeqzSXYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzWlKBGHxRVEHR6UUbr4S8VXZfSxI5kxDVwt3vEzAGI=;
 b=K5VBcnNdQY9bVESyucT/U5RCIWorSO2bO9CVzjXlXsOUeYl5x+e1SyXFe/Kq9fmEXMBDccU1Iahh4zVUyKKZM7lmiwH1L/S7KB3R99RpBj9QSVPbYdcLTmPQNF4qqL4zCIKePMH+63htILrIBgPcY4bPUhzOu5uwu+5KIADtFyZwoB+xXUjLThgGACWiMjO5B0e5KWoB91Tl9nf/46dLaqcO9S95Iyucluwe/cq1WwxskceaTvgPfWl2xkpH0QBInskzTgS3tMfVJI/AZRSqM/vdm3y0a5z4hKr7BywJHWINwNGOvN1QnrKcfs4FShvE2T2+3raybNTrMkbiqK1TLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by DM6PR13MB3900.namprd13.prod.outlook.com (2603:10b6:5:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21; Fri, 7 Jun
 2024 16:28:43 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::2dee:b93e:d9f:d7b6%5]) with mapi id 15.20.7656.019; Fri, 7 Jun 2024
 16:28:43 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Cyril Hrubis
 <chrubis@suse.cz>
Thread-Topic: [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate, add info
 about kirk
Thread-Index: AQHauOZtg6jLCnSkL020MsAFSFbsVLG8YjUAgAAPWQCAAAZtAIAAA09w
Date: Fri, 7 Jun 2024 16:28:43 +0000
Message-ID: <SA3PR13MB6372C183B9989156CF692F5CFDFB2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240607142423.116285-1-pvorel@suse.cz>
 <20240607142423.116285-2-pvorel@suse.cz>
 <8043628a6eed94e788f9fedbf6c8b264ebfbae15.camel@linuxfoundation.org>
 <ZmMrBnkIXKfrF8Xv@yuki>
 <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
In-Reply-To: <c8d4ee181809c4bbf5e21bf355c241eeb540e9a5.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|DM6PR13MB3900:EE_
x-ms-office365-filtering-correlation-id: 7b7fb93a-5a17-4325-6ab1-08dc870ee60a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?TGpCOXpoNzVhMGZ4Vy9LUWJuR1JZMlBaSThxbDdFNXpGMldVOFJxcmxNV0JJ?=
 =?utf-8?B?V05OQWdGQ25uSFpmMHpqY28yL3VtK0Y2SEExdk1JNUxpaXdzbncySllOKzRX?=
 =?utf-8?B?S1BXR2E2V09SRGJIeVc2b1FtekpEbXIyank4K080b2NvK0FYWXN6c3VNSkdl?=
 =?utf-8?B?WmI4L2pBcGtabkVISXcyVTZZMUJDdzdxaWxwTFNGVzkrSFFpbXF6L0JGTzNq?=
 =?utf-8?B?R2JVbzBVZXBsQWJ1U2UrRnF0bFU4R1JmZGxielpWaXkxeW1ydXF5ODcwaW5K?=
 =?utf-8?B?RlRmN0J0akkyUDhpaWhCeDN2aXhJMEZxUDVSYXVPSHVKQ1g2M2lQcGJsS3h3?=
 =?utf-8?B?L2xiRlBLZVIvUEpIc09Ddy9lRTRHbDhWeExOWUdzY29CVEZISVV5YXhtaEd3?=
 =?utf-8?B?ODFhZWdHKzZScWFFTXFJRlllc3g1WVE4K213anB2SmRYTHkzOFdHZ1pIRzV3?=
 =?utf-8?B?cnhvc09HMG9nQlEwWTVrMllZMXdVNkdWNk1BOVkrYW9FMkZ1VmtJUWVWSUpF?=
 =?utf-8?B?eXF2cUJyZUk5T1JyNXQ2cWhCbmZySU8veEJBT3NYTHc2ekFCTHRjUCt0b2hv?=
 =?utf-8?B?cmNzM0pyR2NFTncybEFwNFhLSjJQZ1FnTEl6TmE2ZExnamViZGhyTDVJNUJp?=
 =?utf-8?B?WTVkbHg5S2hVYkNhcDFuaXRaYlRaWHNmOTJxS0RRUWlsTjhaNldSVE5oQkJZ?=
 =?utf-8?B?M1JyVmFFbUV5b1RyL21qVHllSVJzajQrTHMyZjdpem9vWmsyQlNReGxFU253?=
 =?utf-8?B?TGpDSU5HeU90dWNEN0FXeW0xK1gzSE1QcnVEUGtkM2Q4c0IzMGhic093MGdt?=
 =?utf-8?B?dFZhb3RteVRUN2FOVTlGL1NGeTZvcHBTQlhvVmxBK05Ua0t3M3NFcThwQ2RD?=
 =?utf-8?B?UjlPRXYxWXE5cGVpYkl5ZWtpaytzeWZaUTJpVEVDU3NvbVRURWxSRGgyNFBP?=
 =?utf-8?B?cTM4b0JQWnd2d1ErbFpmemhrcDZuSlZPVk1rWXpMQ1BPc2lvS21HdjNOaS9a?=
 =?utf-8?B?dGNyYnVmNVk4bEhDa2ZITW14NFc2RUVUSTBVSTBEaUhLZ0tmMmZBVUpWOU1V?=
 =?utf-8?B?YkQ3OWdtMlE3ck1RYU5sRGQ1QjhqcHpRbHozN2pEVW1CMEZqTml5ZmJ6b290?=
 =?utf-8?B?cmh5VGViUlg2NVlTcHlCRU9LMDFFY2R4cnJUNGFWd3NqRnUzMzhDVStzVXBJ?=
 =?utf-8?B?SnVObWwyQVdNS1N1cU1LZnhuQ3VNaU12RS8wei9uUFZtVmluUWhTZjRNcnFN?=
 =?utf-8?B?QTZndjEvVVkvQ2NTYUF6eE94MUhkNUZNUEo0YmpUcjQ0QXhwcG0vcU8wWmtF?=
 =?utf-8?B?Y1h0bktDQkRwd2g1dmpXWXVhZU5ra1B5cTB5akZDMVBJMzNTbjdsY0txT1p4?=
 =?utf-8?B?c0V3bm02dVpYcHNzbklsaE5Ud0tDQ1VBN0pLalQ0b3luQmx6MEgzWDhmZDdN?=
 =?utf-8?B?WE9XcWlBalZBWHhrTUFJMHdMWDVjQTdmSytoNy9mMGRTdWcxLytJRyt4OUUx?=
 =?utf-8?B?ZTdmMWJiUExXT2U0d0tLVllxcnU0M0ZGc1lOTEhqK2Jpa2plRWVOYVpTRXg0?=
 =?utf-8?B?dWZqT3ZWOVRINkc0YUtGUXdrNXgzMEo3VmRtUU9UQzRya1IrbEdNNTJBdmdE?=
 =?utf-8?B?R3NHd2xNM05aN1dqMzZwa2FJWS9nYkVmeEIyNkQ0NFRtUElSeDFROS9YOFlp?=
 =?utf-8?B?cE56YzZncmVKeHUrV2dtWG9NQ0hPQXdwWEN0SkRUeEw2Ylp2L0xuUDdKRUdp?=
 =?utf-8?B?bE1GU0VRbjltU2hQUzVqRVBuNkFiWnh3SE5lS1l3LzlnZWozSk01WnF0QWM4?=
 =?utf-8?Q?pZ4R0/3hEOb0z/WELRsfrC0E+NWBCK2OvThAU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR13MB6372.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHh4WXVsNEI2a1FIRXdocmZsTkJRWmRnOGduTTVMQ2x0MTdONVZHTEtvUk5t?=
 =?utf-8?B?V0xsbGJJVVRLMzh0Mm9EUWZ1SG1yV1JFckxvMmd0K2FhTmJieFpweFUvUnRR?=
 =?utf-8?B?UzhDdThsckp1OGVDRlBNdFl0MXdjbGRKNzN4TUtSRTdOTFNJSzhUelZQdkd1?=
 =?utf-8?B?NVl2SCs2djl1VnY5STBxcVBFcDVpaHZ4QmhTdWU2MUMyWjg3TnRTR0tIc0Q4?=
 =?utf-8?B?UGw2Mml4bnhEdUdkTlg5S3QzTmc0MFo3eWwraHZTUTQxaDJOMjl4VmRjZUhs?=
 =?utf-8?B?MCsyUW1pSkpzNGZ4T1QvRVV4NDZTazd3U0xLZXlHTmp3M3FnQkhFaFdDUjc0?=
 =?utf-8?B?VG4ralpoNTI0WGhRODZnaWVnRWVMSzJ4aERSRlFyZE9peWZUZDl6cXZPekp4?=
 =?utf-8?B?cjYxbkNESVpXcStGbWxkemdkVGw3NkNBMkZGdmxVbjZueUFJQW9FenNwSlBt?=
 =?utf-8?B?bDVUQkFHT2hnVzFiOWxmd2p5dk55RlZMaDhCUk85Q2o5L2lJS3BvaFRPVHd1?=
 =?utf-8?B?R1MyZStaajBHOFFqQ1J6dEFIMjY3SEpKNVJWNms5SElTVVp0alF5eDVKSWQw?=
 =?utf-8?B?ZkMrWDNpbGZoWWt0bC9iVmFwRURjTUFHZEVhaUVLcm1LdjJFOVcyMjkzcHlR?=
 =?utf-8?B?b0k5TU0zaHRDOTQvTEloUE1NMXFTUk9jRk9aeFZ2ZCtTSXlWVkhtZG51OUlp?=
 =?utf-8?B?RWRVVUhYY202bFh2RE9VK2pmNHRrdW5YaE5rdTV0cEREbGQvdXQwRFJMS05Y?=
 =?utf-8?B?SThiYTlTMWxpaytaL21hS3BQMjNxTG5FNkJWZWRNNHVIZnJqQ01Xelg3U0oz?=
 =?utf-8?B?Qm9lKzNBbVdQNUNCKzJCRkJFSkFFb3ZHbTlJclpjaTBTeHJDNnFtR2VHRFph?=
 =?utf-8?B?bWtKM3FMSXV0QUFScEdtSmpSSWJHS0J3cFc3b2M1QzlsMXhqME1uUmc2bWhO?=
 =?utf-8?B?anZoWkIrQXM0dy9iWElDRUQ5dEFKR0QzaEp1YlE1ZE1GQ0RNa05VUkZOTDhp?=
 =?utf-8?B?TmlCeWlPMkllTU5hSElIWEs5d3RuRjROaGpTK1JhQmFCck9NVTF3Q1pwTGln?=
 =?utf-8?B?WVRUbVhybTBGTCtxcmZSeXppK3FaLzNpWW50dWJvelFsVUJpYWpYOHNrK1Vj?=
 =?utf-8?B?WG12VDZVbnhUbVJwTnZHaFpDNUhNdmlKRmdVMHpVRkNNMDdlOW4wcFJDSVgy?=
 =?utf-8?B?bjBGeXdiSkc1QzZmYzQ0WVlDUUVrTTh0aUEyVjlSK1JkN2RWZ0pFWUx5MWtq?=
 =?utf-8?B?dEZ6WnF3WlFPbkIxekFheGhsYkJCNmkzeWQzN1dOMUwrOXNhZjdnMDE5VWF4?=
 =?utf-8?B?RlpjbXlySGVxNFQ4SUNoY1NoV2UrMjhPUnFuRkUxWVhMeWw0Z2d1S2prb3p3?=
 =?utf-8?B?WjRMWWt0SHAzRjh4cGJUdk1rb0pGN1UrdzZvWXZOcTZjaVlMUTFLYndQSmJp?=
 =?utf-8?B?K1FDak5BUHZYdnJncEZxQUU2VjJvSGkxRE5HVzJzK2RBL3pXWnBrTExZL092?=
 =?utf-8?B?V29uNGRhbktXaDdPcUpDWUZaNUNwSW9SZ2t1YzN0ZjNZRWIxaHRVd1dsWjFa?=
 =?utf-8?B?RGVNSWJKMytVc2ZRcDN0Y05DQmQ5MlVnVnNGVFBtTlVVOUgxSDczWGVhMkNY?=
 =?utf-8?B?eG9yYVZzNm9SOWNmTjZWOVowb0YwVjFpVk1oL2xWdXFzZTlqS2F6aEhjQzE1?=
 =?utf-8?B?VDJEeUpWUjEzZDh6V2FIRnNCMlpQR1BkbnE4UTZ4UlphVWRHT25vMVNiTk1X?=
 =?utf-8?B?dTR0NFMrR2tDVktEL1lid0dTMGhBeUdueFhJVmZ5ckUyMFQ4cGZlSXk1YzBu?=
 =?utf-8?B?d01HWDhpcWNVdWh4aHpCQjBFZmJ5N1pGK0srUmtXWVA5TG9SZ0xXTnNFRzBQ?=
 =?utf-8?B?Z2pMS1VwelRMUlRiNnI4SFlpTDk2eDEwV2pxb2s4M2pVSmpBaW53bjJGNU5I?=
 =?utf-8?B?ODRvM3d1VmF5RGM3WGlHcjVLRUxReGFLQmlPcVZVSXZnVm5Pa2oySVdXU01V?=
 =?utf-8?B?Sm1scXQxYmtReXpWNFVXUlM1d011U0Z3d0h4d2VwNlk2TTJTeExOK1cwWTlu?=
 =?utf-8?B?T2Q3TWk1T1pKSTBYbitRWjhsVkFySVRNb09VQWxCT3p5dWVQRCtyQmdVbjQ5?=
 =?utf-8?Q?N5fs=3D?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pPvdF2lOrxg5uFiKF/G24b08P1x6UyyMhkwhL6M+ApMEePb01JPUof4IqCTWMNAiBX7uRPW+ruZyk38TSGsQm7uwzFaSBQ6bQlmvzUpPglk2lw9aGfVB60aM7CpHh6UYA9n793dyzi+3iVeHgTYtCSTkItrDzd8LIPQk7OVi3dwDi5BVy6zjtprABnIhIBwJH6LsWT0uWHmn1/1yIiRRPdzINq5yttlalGTbXqmuqEzYlRLfYho9fKqanF52W2wk4Nv9HeKZ8HYtjoSICF9qapKyXsdoqPVMQcFrxP/wnntLI5ilcah/VGHOelx2dWCsc0/LRru8OKn6RvKib8FSCh+fegqoVvkk7HIjhiXH/Q2za9l3NXmaidsJjK4oWGNQ3CtvpU8Y+PB3k9wsOpC4lDfqrj83tyR5b+mC4lvuPn0HyQyOkHp/MSClaO4ACZifIEjqixu4nYC6oNSHWPDw3BSkkElprOYB//Ec8PPRUvM+9ccD3faK1r6h7wY3sLsX1O27AVttha7Nb9eBE1Um6+QUnbNxCKdPtQ4rqeJ/TFHp/9fsJrjKcTC3w90gvbMgAKW7g1VgdGkwKBVsBmeCm0v9021GUFK++BjbeL9O6lmp4bLv7D9HLHS+JyLty1fw
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7fb93a-5a17-4325-6ab1-08dc870ee60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 16:28:43.7968 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q1ConkfBjNmTSxFlYN9Rx3YtOs0aPGpzk/IzSfgF32Kmci8gsfe3h57MYm0cs/YWpeYmFSw9io/VMIAwfo2e9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3900
X-Proofpoint-ORIG-GUID: EHTkimVsrdgDVyY5WxxySs8TLtu9yagv
X-Proofpoint-GUID: EHTkimVsrdgDVyY5WxxySs8TLtu9yagv
X-Sony-Outbound-GUID: EHTkimVsrdgDVyY5WxxySs8TLtu9yagv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_10,2024-06-06_02,2024-05-17_01
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/3] runltp: Deprecate,
 add info about kirk
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> -----Original Message-----
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
> On Fri, 2024-06-07 at 17:45 +0200, Cyril Hrubis wrote:
> > Hi!
> > > > kirk is not perfect but already much better than old runltp script.
> > > > Let's deprecate runltp and propagate kirk.
> > > >
> > > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > > ---
> > > >  runltp | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > >
> > > I'd note that Yocto Project's CI is still using runltp and we have no
> > > recipe for kirk, or any experience of using it.
> >
> > That's why runltp isn't going to disappear without a deprecation period,
> > the idea is to add the deprecation and wait a few releases before the
> > final removal, that in practical terms means at least a year, possibly
> > two for users to explore the replacement and give us feedback.
> 
> It helps to know that, it wasn't clear how quickly you planed to remove
> runltp!
> 
> > > This does therefore worry me a little bit, there appears to be a lot
> > > of complexity in kirk we don't need.
> >
> > I would say that there is a complexity that you do not think that you
> > need but in reality you do. First of all the assumption that you can
> > have the test runner that keeps the results and overall state on the
> > same machine that runs the tests is the most flawed of them all. So
> > running the tests over some kind of connection is the basis design
> > principle of kirk. That allows us to easily and safely detect when we
> > crash kernels with our tests, which tend to happen more often than most
> > people think. And I can go about all the things that are there because
> > of a good reasons for hours.
> 
> I think you misunderstand my point. Yocto project already has code to
> handle setting up qemu instances, connecting to them, collecting data
> from them etc. and we use that with ltp in the same way we use it for
> lots of other tests. So yes, I agree with you that you need a
> connection but we already have a solution for that.
> 
> We probably don't want some tests doing this with kirk and everything
> else doing it differently. I suspect we wouldn't want to switch
> everything we're doing over to kirk either as that wouldn't work for us
> or the kirk maintainers due to differing needs and expectations.
> 
> > That being said, the current kirk implementation ended up more complex
> > than I would like it, and that is something to improve over the
> > deprecation period. The general idea is to allow users to experiment
> > with kirk, even when it's not perfect to get feedback and ideally make
> > it usable for most usecases before we get rid of runltp for good.
> 
> It sounds like we need to switch to kirk and use it simply as a direct
> run host driver, but we are going to have a lot of complexity in there
> we aren't in need of.

I'm in the same position as Richard here.  Fuego uses runltp on the target (device under test),
and has it's own mechanisms for detecting timeouts or kernel crashes, gathering test output,
restarting targets, etc. from a test host.  These same mechanisms are used for other tests.
Fuego also has mechanisms for running individual LTP tests on the device (by installing the
individual test, executing it, gathering results remotely, and removing the test and test artifacts).
This is used in cases where the overhead of installing and running runltp is too big.  I haven't
investigated kirk yet (but it was on my list of things to do).

Will kirk and/or LTP provide a simple mechanism for quick install and execution of
individual tests or small sets of tests (and itself)?  Fuego's model of testing is geared towards
testing of production devices, where no test artifacts are pre-installed on the target,
and full cleanup (removal of tests and test artifacts) is done between tests.

 -- Tim



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
