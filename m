Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50247D6552C
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 10:09:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF3113D03B0
	for <ltp@archiver.kernel.org>; Wed, 17 Dec 2025 11:09:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 139963CDD9B
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 11:09:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 75BEB600852
 for <ltp@lists.linux.it>; Wed, 17 Dec 2025 11:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765966162; x=1797502162;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=Nsu3LtdHieqHZox5JOwGzmtBVjpMgF87eHXBXt8wysM=;
 b=WvhRga3vMYyJGXVSUIkIwWzURPdZ3ajcrbejETzZhv9wU5PzbbkPsenY
 z1gcKRT15u+VNIQsrj2JtO4mP5PjDlZSFDvBNTDirl3USMhphGWOEUT9z
 qdThwkSfFr6l26cgFZI0SvM2QYlM0LZFriq6VZX4rhxhF/yZkhOEYpRBH
 kjXPGB8MR4xUP6V2TucgCX74gCh9KtuZdFPXaQYB7sZ3GoH8e8E73Ro/K
 ULGmB39VKrslU6j88RzAGRvI5dabYHC0ZofK/IuGZy7XjnB9NZok5nDVj
 7TNErdTJWXVKXDNcSJoB6kjZTA1PziZOFIHtbnqDWxqj02KxCrhypfNAA w==;
X-CSE-ConnectionGUID: AZUzWYj8S7mSzz/0bbhmbg==
X-CSE-MsgGUID: znVs4tu6Qq6OfjH+9wwXyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="85489292"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="85489292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 02:09:20 -0800
X-CSE-ConnectionGUID: AZZrxj8YSPO4eec5NssCVw==
X-CSE-MsgGUID: ozM1FELYQn61SetxrWj7PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="202767997"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 02:09:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 02:09:18 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 02:09:18 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 02:09:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dK73bN+dCcReVQLP1tuBRel9i4+dWyRiES+MWpSq4b+Bhp6+r38ERxoxoUIwg+oysJNGGQcxSm5m9x5i7RZ8SsPBGaoVAQCtf6MrhOAQLRySdDshsIfU401P0PDzo3hK3agYbYKS9ec1SEPf1PLLv2klfSCG+1kC/qNwgUL2GqxRK4MOIh8Nq0gsFxO925oZMgPNhS4fhunhgcrozb2VSbIn9pcPp/po4NEwJVzoAaDd60g7obUpZjuVF2mp7UIvnnqIgjiPT1ohbNa47y5jRE0yCIipBjwjiKP+sVfmJ/lCJN681emACnEC9cPTlysmuuzhxrtgOgYcT3lF5orsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB61YfEBHQlbpVZpwRP8+dOZ+YGd67IA6NvIxwndOPg=;
 b=kYP3hHK0y7aWVqiJL6G4sv3VjfLTQsjaBCGUHvcXOOhPYIIJccjOZxoRvZ39npNbgCfkdUpr8QIwMCDTEqvAyY5iTTrt7iYi5Rsgt9rDFOevPK7e6wO+jm3TkuLo06AMHMdnCBae05D2dYkI2gWv7KVD+c9ZK05nuMbTYULlSaXW2f3VkNdU9U9givNtX4zEDR91229w2VuZX+XPI7SnLeIxcXQhjOpRgOk1J/osinAF9MZlFoxjri0EJJtynNzocXrVVt5Lhj48qwb/zLh8iOwH8+yEeS7E5ccaxjiFxDDDuZbG1bHXz8SkXW7pFW0PDCFc4J7xih8zinm8Ina77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 10:09:17 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::5ce1:7054:b24e:940a]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::5ce1:7054:b24e:940a%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 10:09:16 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v5] thermal: add new test group
Thread-Index: AQHcYHjk383uGuSy00yMXTW7IkJsxbUkWQsAgAFgaQA=
Date: Wed, 17 Dec 2025 10:09:16 +0000
Message-ID: <d32d1ca67e582feab1f31e1c6baddf00d35b2a30.camel@intel.com>
References: <20251128150815.294092-1-piotr.kubaj@intel.com>
 <DEZNXHGNC47J.JXP5ADB0V6DX@suse.com>
In-Reply-To: <DEZNXHGNC47J.JXP5ADB0V6DX@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|SA2PR11MB4859:EE_
x-ms-office365-filtering-correlation-id: 28022896-a7ab-4e95-f665-08de3d545666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?L0hDN1hZemRndVhGcDhaOUZwQmRlUVRiZTVYcEFOM2Vwa1ZvWEN2c1hwQS90?=
 =?utf-8?B?Lzc1UlhMRXI5aE43ME8xUUdFOU9selpNQnJERjdPY2tuSENWRFhFRXF6UUpF?=
 =?utf-8?B?MEpKMlZtMExJZjlwOHkyT2dBbTNGRWFiNTRxSTJxUXFLRWpyc0lPTFRhbit4?=
 =?utf-8?B?Yk44SzUwVXRNMWNZblNvdDlnSzhWSDNtQnJiK2QyNTIwUU1XdjE3RnZ5RUFo?=
 =?utf-8?B?UVF4RXl3cG1nZS8zNFNwR0ZOL0NFTTFqaithZ1JyWEtkYk13anJiaXpiUWZJ?=
 =?utf-8?B?d0hjTS9heEE0eXZFeXk4UUZqalFnQVJDcVBJcGlwNVZ4c0w1R3p4UGtJTHYx?=
 =?utf-8?B?NW1POHMyOExxV0FrN2RsSitNTFQra0hqQnZsZXYrcTRpTGM4VFp2ZWs1OW9N?=
 =?utf-8?B?d0ZhTHZuWC93bVlMVFFub2J2NGd4S2JHdGxKTk1BbnNPeXNKUTkzbmtyeWsv?=
 =?utf-8?B?SkpreE55UGtldWZRTk01ZEhNc3JNOWtBNHBMbTdqaGNWcGZOYkJqckVURk40?=
 =?utf-8?B?K2xoY3NHSktmbVQxMjVaWHNkRHl5ZXNmeFFHdUp0L245VmtvQTFEU01EY3pX?=
 =?utf-8?B?aVd1cGJCTzV2aVgyaUNhVmhNL3Z3dmFKdXJNanJIbnpBNDFOUVFucmJXMWFZ?=
 =?utf-8?B?WkNKN25DQTlEckhiSjh0UjYxMHNaUTFyMStoZnhuZ0p1MlM4VDJ3Uk9FaEsz?=
 =?utf-8?B?L3RXRk13NEpjWWpFTzBvRi82ekhtUXVNNmJzYURVMStDUnp6bUFoV2FiM0FS?=
 =?utf-8?B?eUU2dmZJYVZnM091WkpVZHJ4UWw3VXlmY2JRa01Sb3RRa1JOZGU2a1NoZjJx?=
 =?utf-8?B?RFNVODFGazkweUJoSVZBZmZncGxnRVdKTnkwMnVTemtXRlpnSnpkRkIyUHYz?=
 =?utf-8?B?cllLRWZtN2hteXJ0aHIreEp0ZjhlVmNLaEx5TzFKbCsxVXl1TVRmRmFGR21z?=
 =?utf-8?B?Q21ST05wSG9Jb1RxUE16aUVFczNsVUJSa3hwZ1pKWHNEV3FReklYUUZ4QnRw?=
 =?utf-8?B?UE5tN2kwSWFDbHZFTlpFQXhKNnh0NEtQbkxaQ1ppUXBOeFpjbmVuMGxDbHhx?=
 =?utf-8?B?UmJuV0YzeXY5VS9ZWmpYRkpyS1hQUTdOelF6alBPWE1QOEx4bXAxQ3BPOFJ6?=
 =?utf-8?B?QmhVY0ZWZSswNnN3UlNoNkFKbmdWVy9GenBVLzZXNEdZWnozOWpFQ29tS3M2?=
 =?utf-8?B?aGJRQkNORWVVZllqYWcwVzdwT3dSN05IK3pzZUt1YU1oNmZFQXcwak1TZXpU?=
 =?utf-8?B?QVduRGJuU3d4NndGZ3AxMmhPTXIraldvU1VLQW1ic3R3cHF1dDhsa1NWYXJH?=
 =?utf-8?B?SzBpbm1IeUwxd1FaWnkwa0pSdDFtMzhXejNmbDBaTDlVRlNpU0hXZU9kNk1W?=
 =?utf-8?B?QzFDTGxWOEJIQnRrdG5kQi8rWXBDakNLVEFweU16U3ovdE03S1RVcCtlalpo?=
 =?utf-8?B?dTVDanBybElMR0hVNStjSlhjdVlVdkF4WVhGdFo0ZVRMMTJMUnNLb3hQYjZF?=
 =?utf-8?B?V2ZUVi9ERG12c1U3c3VLblJMZGZHUTErQy9CcUlzbDlFK0hQU1F2SmJ1a1Rn?=
 =?utf-8?B?SGRiUmdOTWpjZE9uWFZ5SkRxRUVaek1ybldrZEZDb2IrNE5YZ0c4dy8zTmlu?=
 =?utf-8?B?aXIzVmM2MzM2dUtIMWFXaDdXSWhJL2Z4M3M1UXJWOUYwRG5BSklCK0Q0bjFS?=
 =?utf-8?B?U2lmWHViaHBYaXd0SEEzT0IwQXM4M0UwL2NBTmxjV0ordU1HQ0dYamxUaU1k?=
 =?utf-8?B?U0R2cS9UdTR4bGhlZldHY1JRdXVDK2VQZ25iaGo4d1ZwWjRxcXBGUUZTT05Z?=
 =?utf-8?B?T2hoemRNWWlGMENydklBcXFxRC93S3pheWdMNFZhVkZhcUVGTzZxNi91ZDli?=
 =?utf-8?B?TlR0cGdKeHNOTENzbWdnZUFkeSt1amhwUVQyQWJnRG5Ma25rVEFMTk5HUmJa?=
 =?utf-8?B?ckMxRWdxTmJXWHZvWWd3alh3dFB0THd5c3RmWkVkeFVrVjd2blJBakRzZktu?=
 =?utf-8?B?d09uUUZZbFpWTHVWODB6Y2RmZDl4d0dtY1V5UFV6M0djdW55Mm9ienhXbXRh?=
 =?utf-8?Q?O6TnZm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE9HTXFmd0JCdlJiNzRuSjkzU3lVS0VqMUtMOEF2UjFabXI1N1NyYnFsZHpa?=
 =?utf-8?B?VERkQXJoTGszUFBxQ3hOYkgzTlRWKzV6S3dvRDFFVG5YS0VEWDlRRG84QWhV?=
 =?utf-8?B?bjJmeVdsd0hsYm1tblBOdlpzSEQ2NGw4ZGR5R1hPbGFxMXNyVy8zUDRHWHhy?=
 =?utf-8?B?TGltSi9CU1gzL3VkM01JckJBb3h5M1ZFdEErcmRUSTcxRWJ2ZGtNajFBa3lQ?=
 =?utf-8?B?NWdKK3BweFBYNWdqNy9ld3ljM1RrOGpZa3FybnFIbHZRdlE0NEFFWjdkTWU1?=
 =?utf-8?B?WHA5dXNPNGNnalJjMEFoN3RPbXk3VXR5ay81aURremN4aHhreG9GYUttclFP?=
 =?utf-8?B?UkdNMnJVN2lFK05rNHpCblpDOEFIMHRTeWVNM2xaeE1KcnFURWExNElJNTRm?=
 =?utf-8?B?M2hOQjAybEhxOE1uaDYzaG5QSkNVb2I1dmtFa2JHd0tNaEhDaHBiMEF5U21P?=
 =?utf-8?B?QlVnYTVTZTFEQXl2QmU1N2I2MUpyOTE0aldOZUFDQ1lZbTdyNE1aU3VkQlhv?=
 =?utf-8?B?V25sTXZkeEJ1cWlXUVJDZC94QWxDb2Y0VGFpZWM0NXVtS2xJUUZ1bGtCaWVv?=
 =?utf-8?B?Yit4aXdoQnE3cWdMUHpBM0ZhWDRlTnZKVFg1TlpDQ1dJUk41VWhha0dMQk83?=
 =?utf-8?B?NWJwdFJRUTlBMm5EaGVWc0hnTkNlUmJoK0M5bkwwL0NTdHF0TmRlRGYzakow?=
 =?utf-8?B?Qk9zaENyRFhIRVNsT2cvVjlqYjFodzhnKzRYVVd3a1hMcVVSZDFteFpoeitZ?=
 =?utf-8?B?OUNTaXVFdkg4QXJIcGpsNitudS84d2g4NllCREcvL2RsYVNQNkEvVDNUNFJW?=
 =?utf-8?B?UXBwVlBRYW84TW1wWWJvZEdwUHBqRGVYK1IvcnVmajd2Q2grNjBNTFFqWFg5?=
 =?utf-8?B?RVg4TmtBN3NuN1ZQRkZOZXljTnpSOWFUS2Z4UTFNSmJxVVRJb3hJUHJhbmJa?=
 =?utf-8?B?eHVURnlYTWRyY21hcG1La2d3bmJCaUFNUm1pSEVhNmVxbGdaYWk3TjFFcUFC?=
 =?utf-8?B?Y0dDcTUwaEtUWm1EaVdpc09VcG9ycjlXNWJHdHZiVWU5UVdTUzMySXFIbXll?=
 =?utf-8?B?TENmbmc4cjZaL3BHV2dFRmo4RUk5alJQRXZBRXluYTVQa1F5bHFYYjVTbHFX?=
 =?utf-8?B?aDJZUnk4L2s0Y2RYdnhHZXpiOS9wcmFMcGM0bXZQcTBVblJrQW8vRU9hMm9S?=
 =?utf-8?B?TTYyb25NTWhUTVp4L1ZYK2toYzJGZmZSRVl6clU0VnI5MVpWQVJPTm9DYU9E?=
 =?utf-8?B?T0JHYkFlQU1keTllK2lRRFh3WnFBSUszY3E3WmxlMHVCck5DZVZDTFdRaVRQ?=
 =?utf-8?B?alhUaFFpYnV4WXV5ZE9lc1NBWU5qYm1ZYWl3YWxLM1UyeHVKWHN4TElwanNC?=
 =?utf-8?B?SXlXbFR2U0xBYks0MUxETEtLK3Z3QjQvZWh4dnAwYis5UitodnE2MjBYQVZs?=
 =?utf-8?B?NGxxY3BQZGxkV2tIVkhqUnQ1bWZkKzN2azNkdzV1RVdHcXFZbHEwS2tUU2w3?=
 =?utf-8?B?dTJ1UW1HeWxSOTJqSFg1WE1sY01NcXovMUpsTkZTVlFlRW1jVG1sbUY2d1o3?=
 =?utf-8?B?TlEzR1kyalp4Rkhua2VzRlJUQzVUNmtUWnFKYlMwemptMmZNeVBvYWdCUWxO?=
 =?utf-8?B?bURvODdlbGZNTHo2dEFYZ09SY3orc2dRdm9nUm1rVWwxZEJ2K3hxb2crM0Ur?=
 =?utf-8?B?VFlTV1p1azRUWTF5VGZ5ZFpPQlUxZ2FuMHo3c3lsUGtZVFhSelE2UDkxVm80?=
 =?utf-8?B?MUp2SEx4RFNlUkUzR0thNUcyZEZXdWNsb3c3dkFSaVRnR2dOOUYrdmJHZlRW?=
 =?utf-8?B?TjVCSEtGY1pCVXNCUStsRHdwTkhVMGdYZm9NdExJSzhaTGwwblRvcUNsMkQ0?=
 =?utf-8?B?NnJ2Q1NWRDVrNUlrd3RsTVF4WFlOUEdCcnFQOENCV2NPWm9pTmdUYXNONHdJ?=
 =?utf-8?B?ZHVtR2NrQmpBSjdVOW1NNFJoR005MVZxTXp0TkEvOUs3RzE1SjQzeHFFMVd2?=
 =?utf-8?B?ZnZtL2RaRmYzOFBMN2ZUMlZ1TTVTRFZzYmVsd3BXUkhlTGM3My9pRUtqUTVX?=
 =?utf-8?B?YTlDazl3T09qenVFVXdWekJTTkpUalk3ejd5L1JnNXhNN1FPNXl3M3BiVlNK?=
 =?utf-8?B?T3VnM1Y4R2NIcnI3SFFkQUk2Qmk0TFI1bmN2aUJUNEtFd3gvZ3hRaS9GMVgx?=
 =?utf-8?B?M2c9PQ==?=
Content-ID: <AAF4E1282A4128438B7359E7057B3517@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28022896-a7ab-4e95-f665-08de3d545666
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 10:09:16.8969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c66mYt5adt8ATWLhK0SZPf5gyCRibRRPu7BWhEJd429hEDzlu0C3jzeXsAbH0m13CInrc35C6XRk76JrQuV1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] thermal: add new test group
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
Cc: "Ossowski, Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Wysocki,
 Rafael J" <rafael.j.wysocki@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UGxlYXNlIHJlamVjdCB0aGlzIFBSLCB3ZSBoYXZlIEMgdmVyc2lvbiBpbiBvdXIgaW50ZXJuYWwg
cmV2aWV3LiBOZXh0DQp0ZXN0cyB3aWxsIG9ubHkgdXNlIEMgZnJvbSBub3cgb24uDQoNCjIwMjUt
MTItMTYgKOeBqykg44GuIDE0OjA3ICswMTAwIOOBqyBBbmRyZWEgQ2VydmVzYXRvIOOBleOCk+OB
r+abuOOBjeOBvuOBl+OBnzoNCj4gSGkgUGlvdHIsDQo+IA0KPiBJIGZvbGxvd2VkIHRoaXMgZGlz
Y3Vzc2lvbiBidXQgSSBkaWQndCBoYXZlIHRpbWUgdG8gcmVwbHkgeWV0LCBJDQo+IGFwb2xvZ2l6
ZSBmb3IgaXQuDQo+IA0KPiBIb25lc3RseSwgSSBoYXZlIG1peGVkIGZlZWxpbmdzIHRvd2FyZHMg
dGhpcyBwYXRjaCBiZWNhdXNlIHdlIGFscmVhZHkNCj4gaGF2ZSBgZ2VubG9hZGAgdG9vbCBpbiBM
VFAgYW5kIHRoZXJlJ3Mgbm8gcmVhc29uIHRvIHVzZSBzb21ldGhpbmcNCj4gZGlmZmVyZW50IGZv
ciBvbmUgdGVzdCBvbmx5Lg0KPiANCj4gSGFwcHkgdG8gc2VlIHRoZXJtYWwgaW50ZXJydXB0IGJl
aW5nIHRlc3RlZCwgYnV0LCBpbiB0aGUgb3RoZXIgaGFuZCwNCj4gd2Ugc2hvdWxkIG5vdCBtZXJn
ZSBzb21ldGhpbmcgdGhhdCBpcyB1c2luZyBleHRlcm5hbCB0b29scyB3aGljaA0KPiBhcmUgYWxy
ZWFkeSBpbXBsZW1lbnRlZCBpbiB0aGUgcHJvamVjdCBpdHNlbGYuDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KSW50
ZWwgVGVjaG5vbG9neSBQb2xhbmQgc3AuIHogby5vLgp1bC4gU2xvd2Fja2llZ28gMTczIHwgODAt
Mjk4IEdkYW5zayB8IFNhZCBSZWpvbm93eSBHZGFuc2sgUG9sbm9jIHwgVklJIFd5ZHppYWwgR29z
cG9kYXJjenkgS3Jham93ZWdvIFJlamVzdHJ1IFNhZG93ZWdvIC0gS1JTIDEwMTg4MiB8IE5JUCA5
NTctMDctNTItMzE2IHwgS2FwaXRhbCB6YWtsYWRvd3kgMjAwLjAwMCBQTE4uClNwb2xrYSBvc3dp
YWRjemEsIHplIHBvc2lhZGEgc3RhdHVzIGR1emVnbyBwcnplZHNpZWJpb3JjeSB3IHJvenVtaWVu
aXUgdXN0YXd5IHogZG5pYSA4IG1hcmNhIDIwMTMgci4gbyBwcnplY2l3ZHppYWxhbml1IG5hZG1p
ZXJueW0gb3Bvem5pZW5pb20gdyB0cmFuc2FrY2phY2ggaGFuZGxvd3ljaC4KClRhIHdpYWRvbW9z
YyB3cmF6IHogemFsYWN6bmlrYW1pIGplc3QgcHJ6ZXpuYWN6b25hIGRsYSBva3Jlc2xvbmVnbyBh
ZHJlc2F0YSBpIG1vemUgemF3aWVyYWMgaW5mb3JtYWNqZSBwb3VmbmUuIFcgcmF6aWUgcHJ6eXBh
ZGtvd2VnbyBvdHJ6eW1hbmlhIHRlaiB3aWFkb21vc2NpLCBwcm9zaW15IG8gcG93aWFkb21pZW5p
ZSBuYWRhd2N5IG9yYXogdHJ3YWxlIGplaiB1c3VuaWVjaWU7IGpha2lla29sd2llayBwcnplZ2xh
ZGFuaWUgbHViIHJvenBvd3N6ZWNobmlhbmllIGplc3QgemFicm9uaW9uZS4KVGhpcyBlLW1haWwg
YW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgbWF0ZXJpYWwgZm9y
IHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpLiBJZiB5b3UgYXJlIG5v
dCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2UgY29udGFjdCB0aGUgc2VuZGVyIGFuZCBk
ZWxldGUgYWxsIGNvcGllczsgYW55IHJldmlldyBvciBkaXN0cmlidXRpb24gYnkgb3RoZXJzIGlz
IHN0cmljdGx5IHByb2hpYml0ZWQuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
