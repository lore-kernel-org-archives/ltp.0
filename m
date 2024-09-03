Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C81CD3435
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 13:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725370969; h=to : date :
 message-id : references : in-reply-to : content-id : mime-version :
 subject : list-id : list-unsubscribe : list-archive : list-post :
 list-help : list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fV2iKuIiMX7uK9jlr9cAQatoboIIYL5/SvI70LjWGQo=;
 b=hFf6P9OVF1wA13jEREFaDPE/AVnmbTbQ3xplLnc4Qhn+o1nLJ3V0MPXp4/t3EqnmqKZ+Z
 Ff78hPCyfNhvO+TtkqPRa22bUAwMYzIJwec6J/1abJlqO+dB3jZxMsDQVtNKnFDRcQekNJB
 fpTeMCBN9fZedR3gtlXiM2yN9aHC9Q4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA09C3C4F8A
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 15:42:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B7A43C2F65
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 15:42:27 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=oracle.com (client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=chuck.lever@oracle.com;
 receiver=lists.linux.it)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE41B60111F
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 15:42:25 +0200 (CEST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4837fTw3007210;
 Tue, 3 Sep 2024 13:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=corp-2023-11-20; bh=gf/PFY7/vJwqcu0/xyAGV8PY+72JY36WqXf/txBQz
 iA=; b=CgD935aHKTkfe6da+7CZ1FPSjNE2DlRnof8tr5LJei+VvkY3wqBuMaOY5
 EEd05bk+nY1USy4Lms9IlOSkCqcu/ti7/2l8RuRMnxLqJ8Jp704iEZwXNEzZc7IH
 nNOO1mdb0zoBrDmImcGV4xIiwE8+PNANOhvrlZdkQHADuIE+nosMCcUjGrNzqybj
 TW0O/h3b0SptiPNbyTYpVhucvtDlkQ8jzdIexZXaHx8j52m/u/Owp67S9vKbdpLz
 egabEs3baamluqBghDqnBlyhLpUkJxnVqpNCT0Y832O1aNKTYEK9xprub7BtkOSD
 CuY1JohIkS1U26hHJa5Oi3qdNCncQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dk84hm0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2024 13:42:24 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 483CrXUX023589; Tue, 3 Sep 2024 13:42:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41bsm87g4b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2024 13:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M3SfoUBog/UqF6PjdliJG6EbOyM4pDoU/gRQTMvKcOZ8D/SIn+sdgIw12L77RRdFOj07m7mwgnpsfanj3NumNfft/z2nXWXZJQZglHttce6y7gdl1hzoa2msRgBXd9fddkmWXUyQNOpJO4Aj+bZmdrzomC+TQU3O+XwttB6tfbSiVyTdrvRpo52pvlaRP4Xw9QzhQv4LbjKTWffAh+K6q6t88R7ioYd9YOR/IL61cLeqKX7F1aERPWhFjoZCIRnyTHvaOXOOJscm9ZUHnF2Lo4Uo+1udaPZXFo1ViOnhAcpANW+3MqWZ45d1zai7CpJAWae/1CSIs1vlfYB+aFHZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf/PFY7/vJwqcu0/xyAGV8PY+72JY36WqXf/txBQziA=;
 b=ygicOBVUidi+Ge268RnMM3S9lofIP0Er51Sl77U/NeAg9ev91t0tStDqN1HF9HfAX4S0M7Ljnn+XsrK+KO+TKya+oXogPHHUrFTezbo30P4YCK3xhIaoMLWJDwC/jdAeCjmavMrE93+9PZZeKjnoLUo/Bk6JbdHC/t95e1y/K036l2Xw+XwuoGhGamM7b33zjqYA8QJA+Dr5USOfIvYnEVZn1t47fpzehfzqFvsy6pihi9ValjbNTc5rTMJGxb7Qv0LfVGHvTxp5viDbBrNgSLaVReCt8LOpPUt0ZHy8xT/56nrapr8JSuMgZyz4haIu2HWNNM8x2gud2g0EAHRwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf/PFY7/vJwqcu0/xyAGV8PY+72JY36WqXf/txBQziA=;
 b=E10AoTvihMkySrzZh1dNZoA4ylB+n6/egF+LKAhap2WEiTIskIgmqPnncv9FiG0PYbMhGr5k0a+CcW/eKBh6Se5EPn81UEmavsYnfXrH6QGG83kyAqww0zY2xOQK+kDwMbw5tInVC6FhJrDaWVNAOoh6I+92sJck8RkUjdV26II=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Tue, 3 Sep
 2024 13:42:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.007; Tue, 3 Sep 2024
 13:42:20 +0000
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] ltp build broken on Fedora 40?
Thread-Index: AQHa+YT+UV889xyYd0y15QMuZDk25rI9RdsAgAFnDACAAAoegIAACV0AgAbxL4CAAGmLAA==
Date: Tue, 3 Sep 2024 13:42:20 +0000
Message-ID: <205036CB-71EC-4199-91BB-24D60EE87998@oracle.com>
References: <5295D578-7B15-4613-A1FA-41A425E992FA@oracle.com>
 <20240828224850.GA1773775@pevik>
 <51DBF795-A185-4E38-993F-E3CAEC37EC83@oracle.com>
 <20240829205007.GA29837@pevik>
 <F46C0EE3-EA5C-45F6-BDE3-C53BFAF65276@oracle.com>
 <20240903072425.GA718469@pevik>
In-Reply-To: <20240903072425.GA718469@pevik>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4833:EE_
x-ms-office365-filtering-correlation-id: 63ad950e-6341-4129-6bb0-08dccc1e3bc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y0dFeUVOZWsyUDJjSXZSSms1ODNPUnkxYldjUytnb2V0a2IzYm13Ujh0VkRO?=
 =?utf-8?B?K1dYczMrMFhaYkgxblVuellRQmU3QTI0MnBSK1FMQS9EQ1AxdUlmT0x3WnE2?=
 =?utf-8?B?SFhNTVUwaVNEOTBqSTVldmgrWXdSM25nNS9xNkRqMXgxeW9PakpHRWdmc2tF?=
 =?utf-8?B?SjBuYnVkeC9mYkhJNjZXSkxQYmttbDBBRDcyZHAra3FReStKcVlhOHBoLy9j?=
 =?utf-8?B?TXVwZG9ZSXJ1MVNsb1JUbUYxNHM1YW5rNFl5RktITFl0dlc1ZHBKdllFZnA3?=
 =?utf-8?B?VkhuQkt6eHlMbVI1SWFUOGRYT2xtWWovRWdiTWZpK0hJcUZUZ1hyVTJteUN4?=
 =?utf-8?B?Rk03bFVsaWN6NXFNN3d5V2xsblZSSDByVVBWYzRFQW1DK2NIdnVQTkhBSXg4?=
 =?utf-8?B?c3QxNVZ2K0djU1NCTW1NWEcwQjZXTFZFZkt1UUpZY0JJTG4vUllINkFsazZp?=
 =?utf-8?B?SkVLaFFsV0ZHYi81T0hwYTdQeGFVNHBiM1ZUYURCc1FPS0g1Z3ZTbGVkdFZV?=
 =?utf-8?B?YUNldlFhVTY0UGgwMDVaaXIwTkVacE9UVm1kZ2RFSlRDdXVlYU9HbzNRRlN5?=
 =?utf-8?B?QmdLRnVVVVYrVHhvUGZxWGdIZ0t5MGc4c3BFWXg3eWN2SE5lbVorSFJHd2lu?=
 =?utf-8?B?OFpob0lQSDFUNWRZTHhpV25DOXozdjdkc1VLWE1Da1dMVExHZkM1OW00cnJ5?=
 =?utf-8?B?VWNZMGFRV1hYMHhyNTJtajN3WmFSekZtODdkV1pVcEtjVFU2dlFiS3dNZmYx?=
 =?utf-8?B?VEhibHpwSnM5TytvZ2NtU3pBazR6dWx2SGFacTZ3R24yY2Q5cnlKdVQ1Y01T?=
 =?utf-8?B?U2c1eFpWVGorUDAyTTFUS084S05xOHl3Mm12Zy9yRWVrTjJmOFUxTmNqRlV4?=
 =?utf-8?B?UTloajRpUzhHVk90OUZaenNEOFJaS0NJVnBQdFBsVkhONllGYnVwZW9VaUpo?=
 =?utf-8?B?OG53d2xPamZVdCtjRTVPYklXME9oR3hwcWkvZW5jYTI5b0ZrWHJQOFZwZTZn?=
 =?utf-8?B?aVRpK3gvczVYeDRUaXJkK0N2ZXlOL3RibHJXRE5KOWhHZUxHaS9WekhOYU1h?=
 =?utf-8?B?QldjZklidmZ5aDFwRW9BWXpZcjdXa0N6RW95bkREN2ppS3NSTnBVRmNWeHly?=
 =?utf-8?B?KzRnSGFHZFJEZktSUjYwcXpZRU9uU0puNjFHcTd3Q2tESkpEQ2daYTVKTmNo?=
 =?utf-8?B?OHg4VVdQWGJKTXhua2Q0ZmZRTlV3dzVhRFlVdVh0eW5nQmh1S1dpcUd2dzVa?=
 =?utf-8?B?Tkp2NUhBWVk5T0d5bWJuWEFtZ25lMGVMN3FXNHZuODBTeW9JN2J5ajB6cXNl?=
 =?utf-8?B?cmJVdEd6MHF3NXlUSm9ucUUwS2VTUWM3Y1hIRFMrd042dVhzOU0za0cwaE5h?=
 =?utf-8?B?eHRDRkxXSzd2bGtwNzJlS0o5c1UwT2RXZGlYZlFRUk1wZTROMmxCOVBkN25J?=
 =?utf-8?B?V2dNeEsvTllRS0cycnVUa1lwcVdSQnhpamg5MU8zei85eW4xRGw2RjRKYUhy?=
 =?utf-8?B?Z1Y0ZUdSMG1WUmxsbkVrZUYrREJSVVBhQXNpT3hEVVh6eUhMYWpxZEVhN0VV?=
 =?utf-8?B?REVDbXlFUzFaeXFRV1gwTlRMQS9wTlZ4R2N3NmdjQnJZZGtsVS8zNUZtOGhn?=
 =?utf-8?B?eEV6R0FEV2hxU0Evc2d6WnBSZXF4NXRwR21xRDlCKytJQVpiS25oUnArVDJh?=
 =?utf-8?B?MDRPNTVTNmh3Z29iK1pta29IOHNhL21MYitpK1NwU2RnbkdIVSt1eHFpMHJS?=
 =?utf-8?B?b3J3Y3lpMEZ1MnovRXJTSWZWVUk5VEJCRlJ4WXZCdXZDNTdFOUhIVy8ySWhC?=
 =?utf-8?Q?xYnwg1NE61WNCqaFTbgTc7wn3HstLHx30zysg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFZGeUtvcnZyZDhQcHl3MnArUnZGdFNQUGhPQW9KMlg0RzhVclE2ZEppYVFT?=
 =?utf-8?B?QmNNV0tZMTdYM0dZQUZidktiSEt6Tk8vOUswSjRKWE5vcFIvTXZOeW1IRVJr?=
 =?utf-8?B?ZWNtMmZBT2dPUnVQSnpEcHpiQjRQZGZGVDN0aXdndzF5QkhmVTV5K1RtZlkw?=
 =?utf-8?B?ZDN3RFN6ZU1DTmp6aTFhNytPSS93VnBJV2RlMnBlWW01VU5jcmVIVTlzdWVw?=
 =?utf-8?B?WS93R21UN09Gb0RnaVRtdEczaXZoN1BhNm45OFg1ZTVoYWJNYzlyUnc0M3Za?=
 =?utf-8?B?b1NFdHp1b0xqT3NUaVV1RjNqYnRpWTFjQ2xZZVpZTWhPS0pkNE9vQ3F4dTVZ?=
 =?utf-8?B?UWo0RVkwNG1RMDBmQ01YQUNHNFpxMURmNjNUK1RDUG01TUNNd2NPajhtOWpl?=
 =?utf-8?B?WDZKaVJFM3N0aFFqNTh4czFFRFBhTnpJbCtENERGVUsvU1pFTCtXcFprMTBR?=
 =?utf-8?B?RjBQeDRVd0VUb1dGVFJIeXBVekZpSkJ6RGRvZXc4NXYvT0NJRkszdkhKYTBG?=
 =?utf-8?B?bXdMMnVseWlhdzVQT0lTd1Q1bWNmWFNGY2xBREQvUVNSandHaTFONXRIVjZ1?=
 =?utf-8?B?Rk1QNDBLNWhKZlVvNTljVlkvdGJzdnFHemlkV1lSVnU5YjRzR0FUY1ZZT1pZ?=
 =?utf-8?B?T0FkWnZiYmdMWExFOXZacWFoNU1wMkRpSU01ckZjVFNjRFNzZTVuK21WOExm?=
 =?utf-8?B?Um9LaktsWDdPTXZabUJwTzFDL0oyUmg5NU5vT0VZRzFWdG5PYWI2MWVxQ24y?=
 =?utf-8?B?ckczdHZrdUQvaGZRazV4R0phT1l3ZVVnWGdVTmZVMWRrK1ZPWUIrczVFcGFv?=
 =?utf-8?B?akNXWlFSRW5kc09YS0RGUlFUSEsxNkFyMTBoMktmc29nbWVwWVNUMHRWVXRP?=
 =?utf-8?B?eWEva203L1diRC9NMm1JV3prT25MRHVpZmgrZlBoOXpUVHUvS1NSaVZuaFY2?=
 =?utf-8?B?S0lMV1dkZHlrWmZqdHVyOHN0ZU83TEZzRHNJRXpVcm1ETGkxc1d1NGRtb1BU?=
 =?utf-8?B?R2tUN0dMY1pram5ydXUvdlRRU2s0ZTd6bTdPL3NXOE5BdndCK0dtNm5tRFdG?=
 =?utf-8?B?T24wZzNMbmZBNEhScUxDR2dZcmt2TWwvQ25ONGNqL2cxaituS0hOK2JLbU1F?=
 =?utf-8?B?Ui9vNXZlZVU5Ly9wQnBCQjJNMHQ5TmFVSlN0QU5ZRjNTUm5xeG8xWjgrSjR3?=
 =?utf-8?B?ZHg1MXFFZGx5UFlWOWVsQTdHNlA2bFJUUk90NzBadkxWTG10azdyT2NQYnJn?=
 =?utf-8?B?NGJ2ckRFUmVxcm9hYytPdDRiM0JzSGc1R1BzeThqLzR4Mzltd3pDNW5iNEhF?=
 =?utf-8?B?T2xhaXQ2ZFF5cVFwK0FCYmp1QW9oNnlQcXJRd2REd3pLamk2alQ1UVRvdkJR?=
 =?utf-8?B?L2JVR0kyRFdxcGV4dkl2eGdKUFN6dUpOMzJkc09mRjJBc1QxeDlkZkhaQjBs?=
 =?utf-8?B?SjJNUGRKUCtDZktweWR1Q0xaYnJoM3VBOEFuWHNhRzFDbVRtMEtHVTFMU3VI?=
 =?utf-8?B?aTQ1aGdEZjFpK1BIY0FOTThhR1UxRnkyQzc2MTdLN0lmSFZwUjZ0ZEp3MUtt?=
 =?utf-8?B?cGVnOXpVS25vc3FkcHRRc0ZFMDdhcXdDRkxXalpnOENYQU1qUzVaSFhpKzJ1?=
 =?utf-8?B?S2VCVU9QOGNUSk9mS1lhQUQzTDFmU1ZFTUxJcGJtd0U1VUVrNy9QT2lKWGtT?=
 =?utf-8?B?S3drRlluWlpJbWVja3ZBckduRUhmKzFkZFZpa3NSQ1VwT042b0NaMjl3VUty?=
 =?utf-8?B?clpzemxRam4veGNOeWFvRVVwaW81dWx5NU5FWnAzU2dUNFRVWkxHbEN2bTNE?=
 =?utf-8?B?Nm82V3hZc3hJeXV5Qlh6eTBkWmh0YWlBKzhPVFY0MVhvK2NJSjdIamtQdWhI?=
 =?utf-8?B?anRNem9PNGdZMTdIOW44K0VhVFUzS205V3VJRmZFYUQ0cU1FeTdodk0vaUdY?=
 =?utf-8?B?eEhpbW00T3I4dEtjSzdhbHVYS1B3ZnV4R0tPaDlIQzhRNW9ENEl6eGZjRmZ2?=
 =?utf-8?B?QTcvYnQ4Tjgzb0dvczlKcTVpeG5XSk5qUnhxU2R3S1ZoaE9wajBPOUVQQmlk?=
 =?utf-8?B?bWx2d0ROOE4zQ2lJcmtFL2NVWm8vYWI3Sml2WDlWUDlaTFN5cjVXdVdhVER3?=
 =?utf-8?B?MjIzc21XWXR1Y2RiTVlJUExGWkdIWnBCVXJNaWtzUHdPUkY4aTVxSndMWVdh?=
 =?utf-8?B?aHc9PQ==?=
Content-ID: <33777F9D85B02D4890B59DC1A0E17CC2@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KRDxqRG9cNMIPDnLO3Pv0/HKRpHb2pENcDsNxi95akgI6EPT4lSybQlZTFp6e0Ae9kuDFonEGjwHar/a8ojQk+k8X1wf/sLHY+a95Xi8qWYpHdRS7b3SLJ1L6/T3xGYTUaYpbehUTQA9eo4eVl/a8Dt9pF2ooD376E74sV13QhboYyOv04sdXqypnTPQpCKmvGRvV02MmG5Iqge2tS/NrQqWvnRpGf5b/Ku00KRiaSYQx0cualO7LwDDwQ5RsuR30yls8p7SsdUJxq1O7yq+9wO/0TNV3i/6HFwgMHyc9S99FfXC0qyTfVqQTBjUvv8FTdPotKHmOiRKY9pWdLm41sjKf9JwXeMI6u7i75RHOZC+bA4OfLcwe0W0rN2oldjeLb+IsovxD2pGoxFMlbZQf0SFKTCqW8/LUR98FWhgyoFbmzLdkUMl1wy37luL1Mxpt+T8Yme08Vqt3B9KCow/p+AlrnIkCT4+SHxpAJAo3cZTn4YI9zWxfXYemvdEyjS26dy4KgRIST36VrVcZoY3do1YZgTNWafVs5M3S824Dw+0xsuUCiPl9wOdIGdZl7LC55GWYF61/W+AxwSxlDnmnDXT/pbsE67IiqN0CMmyiAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ad950e-6341-4129-6bb0-08dccc1e3bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 13:42:20.3575 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUKWGoSP9m/4FNazSJRWRMtJrn9QDakSb4XcRQmK3yV7a2KiVfnmh5hYljUMAfV0p6TNMgLELtLuBBrjX4PPIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_01,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030110
X-Proofpoint-GUID: 8EVHhl2n1NbMLUNHCLaNqMbu_c8Kr9EA
X-Proofpoint-ORIG-GUID: 8EVHhl2n1NbMLUNHCLaNqMbu_c8Kr9EA
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ltp build broken on Fedora 40?
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

DQoNCj4gT24gU2VwIDMsIDIwMjQsIGF0IDM6MjTigK9BTSwgUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOg0KPiANCj4gSWYga2Rldm9wcyBzdXBwb3J0cyBlYXNpbHkgbXVsdGkgbWFj
aGluZSB0ZXN0aW5nLCB5b3UgY2FuIHNldHVwIHR3byBob3N0DQo+IGNvbmZpZ3VyYXRpb24gZm9y
IExUUCBbM10gKGJ5IGRlZmF1bHQgaXMgbmV0d29yayBuYW1lc3BhY2VzLg0KDQpBd2Vzb21lISBJ
IHdpbGwgbG9vayBpbnRvIHRoYXQsIGJlY2F1c2UgbXVsdGktaG9zdCBpcyBob3cNCmtkZXZvcHMg
d29ya2Zsb3dzIGhhbmRsZSBORlMgKGV4Y2VwdCBmb3IgdGhlIHB5bmZzIHdvcmtmbG93KS4NCg0K
QWxzbywgSSd2ZSBiZWVuIGFkZGluZyBzdXBwb3J0IGZvciB0ZXN0aW5nIHBORlMgYmxvY2svaVND
U0kNCmxheW91dHMgdG8ga2Rldm9wcy4gQWRkaW5nIHRoYXQgdG8gdGhlIGx0cCB3b3JrZmxvdyB3
aWxsIGJlDQpnb29kLg0KDQoNCj4+IFNvLCBjb3JyZWN0LCBJIGFtIHVzaW5nIGl0IGZvciB1cHN0
cmVhbSBORlMgdGVzdGluZywgYnV0IHRoZQ0KPj4ga2Rldm9wcyB3b3JrZmxvdyBJIGJ1aWx0IGlz
IHN1cHBvc2VkIHRvIGJlIG1vcmUgZ2VuZXJpY2FsbHkNCj4+IHVzZWZ1bC4NCj4gDQo+PiBJbnB1
dCBpcyB3ZWxjb21lIGhlcmU7IHRoZSBsdHAgd29ya2Zsb3cgaXMgcHJldHR5IGZyZXNoLCBzbw0K
Pj4gbm90IGV2ZXJ5dGhpbmcgaXMgd29ya2luZyAxMDAlIHNtb290aGx5IHlldC4gSXQgd291bGQg
YmUNCj4+IHByZXR0eSBlYXN5IHRvIGFkZCBtb3JlIHRlc3QgZ3JvdXBzIGlmIHlvdSB0aGluayBh
DQo+PiBwYXJ0aWN1bGFyIHRlc3QgbWlnaHQgYmUgdmFsdWFibGUgZm9yIHRoZSBMaW51eCBmaWxl
IHN5c3RlbQ0KPj4gY29tbXVuaXR5LCBmb3IgZXhhbXBsZS4NCj4gDQo+IEZZSSAoeW91IHByb2Jh
Ymx5IG5vdGljZWQpIExUUCBpdHNlbGYgYWxsb3dzIHRvIHRlc3Qgb24gbW9yZSBmaWxlc3lzdGVt
cyAodmlhDQo+IGZvcm1hdHRpbmcgbG9vcCBkZXZpY2UsIEMgQVBJOiAuYWxsX2ZpbGVzeXN0ZW1z
ID0gMSBbNF0sIHNoZWxsIEFQSToNCj4gVFNUX0FMTF9GSUxFU1lTVEVNUz0xIFs1XSwgd2hpY2gg
aXMgdXNlZCBpbiBORlMgdGVzdHMgdG8gdGVzdCBidHJmcywgZXh0NCwgeGZzKS4NCg0KVmVyeSB1
c2VmdWwsIHRoYW5rIHlvdSENCg0KDQo+IFsxXSBodHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRj
aD92PTlQWWpSWWJjLU1zDQo+IFsyXSBodHRwczovL2dpdGh1Yi5jb20vcmFwaWRvLWxpbnV4L3Jh
cGlkby8NCj4gWzNdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL3Ry
ZWUvbWFzdGVyL3Rlc3RjYXNlcy9uZXR3b3JrI3R3by1ob3N0LWNvbmZpZ3VyYXRpb24NCj4gWzRd
IGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL2Rv
Yy9vbGQvQy1UZXN0LUFQSS5hc2NpaWRvYw0KPiBbNl0gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4
LXRlc3QtcHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIvZG9jL29sZC9TaGVsbC1UZXN0LUFQSS5hc2Np
aWRvYw0KDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
