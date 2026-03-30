Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72D610D14A4
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 11:59:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11FFA3E4F2A
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 13:59:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 308CC3E4F18
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 13:58:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F381C10005CF
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 13:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774871932; x=1806407932;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=rx3Xfzl+EL9DKeNQeYwOUaOqMV6znaideD6R/fIQJLM=;
 b=lBQYqmM0+sb+8Y1Xvwwi6g59JYPMSMyjrjWVE6WH6URD42gmmIYy4vM5
 rpygJdMnIp5BzkA4annyUAQSxiKZ2Z43/zvOl0Cq351Fb2/TQX1splXui
 SQh0q36GbmwlRmrcTSDpP0+16HtN28ptuaPtItHS2S4ePp4qGInQlY+Hj
 SZyfkXOkZssQYHl1okAjFPtXSmnDrdDabp7xuPG64iHuTscIAO8u0ZUoj
 U486vwGHBPAAxcR1NFfO28CJcaXjumdGM8VpQKFWG5E5zocHC08I4j3pi
 G8dry1C92yUDh2egEinkFSTpp5MIH/EkDsovjM5s9zdRJjS1NglLJBfxY A==;
X-CSE-ConnectionGUID: Q6flah2rTWqEgjUUYmyqew==
X-CSE-MsgGUID: M4qJzOeNRIi3WPo8og8PPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="101322086"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="101322086"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 04:58:49 -0700
X-CSE-ConnectionGUID: hM3TNlIJR5KiNF8eFcbZDA==
X-CSE-MsgGUID: R1zHppWTRR6rnH+MpF+Tvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="226288039"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 04:58:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 04:58:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 04:58:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 04:58:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGrOi/cynR2qv3Qpy3jzIinPY8FUGd/yjFokpTprlVthSHHuyEl80bQLNO2mURq1gzSSYd1poPJJkN1fx7HGt1IVnBiyyIG5agn5KO43wIjFTTIgBi97Ep7UO5GHhEqmnRKlujD0xlD4gfj9U84C7cO0tF5Afqwadxrl2q+RrBiXyyrYJm7+5N2gutO33yQFHPutqaw/qKIoO/lFSEUnDrB0DkUlYoE9Wjg9ohatr72XUuBGW6+vKIaUDSTaW0PDJYVrn3+jPctp2TmP2tAFaXdR6NmEazLH4XoI9lYmH1kvAmAr/50vVyivhUIe0YJkRr0RAPmvnlJtY/BofzCE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acfSNP/pQH0pTW5VXu/UnOzrowTiIcpWimYJQ7rIbVI=;
 b=Or2s7vNNjvGYMkjs9F8R5aZm4Eayvyej8VkI27VdBQ5TqXYs53t5X2ckgDm+YZ4DhMGPBqBL0RSIxxsgh5QydjeM9FMarOsJJ9EwsYKr9xG6jRm4X17OKludDMSK97eSYjkXOgViggjw6wc7INjZQdWhaEIN/PHbG9LheWX9X274uiixKpnn3Zbqboj6Jh8e1a1B41h8lUFCqt0pItfFr8b2R7RSAmsVNq0vTGOX1COEsYp3i/rwTELPLxYuuKBDGmM8asiYyZKeTgwI/1YZxtIi83EU0gXb5UaBHBAVN86vrPILzKkzD/K6EP4GUvutqP12LAT0r0ncx2EWbyw/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by PH7PR11MB5916.namprd11.prod.outlook.com (2603:10b6:510:13d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Mon, 30 Mar
 2026 11:58:39 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 11:58:39 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>
Thread-Topic: [LTP] [PATCH v6] high_freq_hwp_cap_cppc.c: new test
Thread-Index: AQHcurnfBn2rlCZ/gkqnvWjlISVaRrW/LyKAgAfUgAA=
Date: Mon, 30 Mar 2026 11:58:39 +0000
Message-ID: <af6233eac9b685f8518453afa53daf31f0af8922.camel@intel.com>
References: <69c3d3f0.050a0220.2bacda.8597@mx.google.com>
In-Reply-To: <69c3d3f0.050a0220.2bacda.8597@mx.google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|PH7PR11MB5916:EE_
x-ms-office365-filtering-correlation-id: 885f88d3-edfe-4cc3-b3b5-08de8e53ae6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Ovq0BHZqSQm7w5LyrVSNslIZKwqxalZPcf2sw8zJWQ/MLcDUg38HF9H9qcMAqgNr/KM+0xEWZACnjfuLQ700tOKi6lh3YAL6BMtSltMvF0jXXzMh0mmrR2d161qNPuNIX7lxZVMgjGtq1bdA0kOSzqBX+BgHcsZzCcMuO9nG7A/CTXo74unXyud2c+JHOH/FkVJKbPybQugvEmTEZxBqMKWN+vFAsk9ZRQPm0Iwf/7ami1Hgq2P3Ut13QvSfUPEPwlvkXJsmVqzOIDA1cdAmcI2PW65YEfpJow1/u+n7vz6Y0JSGfsH0fdEZyJegkxtoL8UOowGK4cdJoLhqK4qSF38KyWcnvlfap3IMqXzOOVsDzH5ZMZO9Cxoeo2WEw6eTFZO1vrid2j7NlQl0fHnSbnYWRcOifo8q2bk0P760S0DPCwDBeJflGoH2dqUW25XfokaQELLKZa1GoUNbmI0r1Hiialaq5pHXDF6lLsrIYGdlYBC1DtrDoRpBjcNVaBB4VqGEdyx7i0iOkF3wYeZc2o0x6QcQ/X2HfMEeaY4If6LRAwcoIBh/SfJuzQ692x76egjFwaq0yLCjZ5+Zv3cN9TcS2REL4wZFJaj8hKWsQr9nPK2mXowxgYY0YaF1PgffemAPTANXf2CVhTrCJBkDbLeS+RDmIg+louD7IFIGrqRQtbBVzyfkbP4nbw/uJMDF4VgEgq5Ny58RH4kvhyiq4YP0kFf6sWjqBsxle5dsZ+4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bys5MkVQdUVEcnBORUFKdjNrZWNheDJKSHN5R2JobURPb0hVRTgyc3ppcmlh?=
 =?utf-8?B?akl1UXVxYlMza1dFUmYwcHlmRDV5UGVwVmZUN3M5S0V6V3UvcFNhNlpuT1Rv?=
 =?utf-8?B?b3UzNkRrdnNSN3F5d2t0MmJDOHZQcEwxa21ralA4bUF3c0xPaE1kY21kSU9F?=
 =?utf-8?B?YlpXdFJwUHphWkd4MG5KOS9MMWZteVRad20wWHI0T3pFZmpxeTQ5Zk96a0Jh?=
 =?utf-8?B?K2E0MEpZSzJjU2t2a2xRZ0wwL3E0Q1VKSlZ5QTNNUGoyVFJLdnJKampPSHhQ?=
 =?utf-8?B?aVFxajZzRDhXQUlqdWp0WlZwdXRzNFlKL0NOOVVManNhYVVOdFVoTThqOGV4?=
 =?utf-8?B?cDNTL1ZKQWplUExReHFjME01YTJHYjVSWXdKdHJkMUlxVXNLV0g3UVZXR0g2?=
 =?utf-8?B?cHZnSngyQ1RCRDlWN0ZrSGdkRDU3d3hoNi96dDd0ZE5xZnF2cXRrWVJwaW5L?=
 =?utf-8?B?UGhPa2YzV1p3c3NOcy9aK0todmFZVTM0WjRFYlFIei8wRDlSQ05YNWdhTzQr?=
 =?utf-8?B?NCtCbld1RG5sejFmZXBPUVhoblE2MUdEZUwyNHllUGREcW1ueXdoNkgxTmti?=
 =?utf-8?B?V1pjSXA2ak51NnlDTFVWSlJhOUZLd2tUSVlnaFY0d2RZTVAyOHczNjRXcnZP?=
 =?utf-8?B?djIydW9FRE42UFQxb2FKeksvc1kwWmRlc1JaVHRJSUgzNU1WTXZXbFBWMy9w?=
 =?utf-8?B?VHRHUUhVdUNkc0pYelJ0eUFpSkxCL1NGTFUwQUJwVUs2SkhVbHRMMFZ3Q2pn?=
 =?utf-8?B?NmxVR1RneVMxMUlOOXcyMzBwMm1yQkNhdmJTdEN0TVlMTTY2TU9yRVNiQW5H?=
 =?utf-8?B?UXBrSzV4WnNRdkFJcytpcU8rWTBReXV1Tzk5dXRmRWRhTnVRRExRNHBMdWJu?=
 =?utf-8?B?VS8wTGgxZ3VFd2cybGN6TVBSRVMrREhwWnRYQWE0MDZhd09BRXZhUTBBK1pY?=
 =?utf-8?B?c2JBYWx4Nmx1TlR6QnRnd0VPV1V0M3hSVFY3L2tRMjFiOWYzdjBKQXZjYVEr?=
 =?utf-8?B?Zmc4Y3ZkcEh5OUU3U1RzYUNPcE5pNnhrZndlQm81eE55YnIzTVZjSkEyMXJK?=
 =?utf-8?B?L0VoaEtISktkaUxDVmdweUpTQTFUZEdSTHJ5bVNrenJTbytxTWhsQmpMck5R?=
 =?utf-8?B?c0J4eEIyMXdrRHNDNWJ3QysrSEVjN0FaOGdsVVkyK0c5QlJUZnRHdytoSmJI?=
 =?utf-8?B?b1hwVGI5QTY2ZFNhN2FaZ2k0T0JYeUREaXpPaCtDRW5Ja3hLUWZzWlBiR3FD?=
 =?utf-8?B?Ry85dVlOV1lWTkhpUkgwbngzdkRtZnA4ZktkdS90SGtYYkxiQk5ocStIU0Vt?=
 =?utf-8?B?VFhFeTBTRno4VUdmc2REWWJVcDBTTWxaSXJXWHo4RVJkd1kzdzVRZ2F5OU9q?=
 =?utf-8?B?UzJDMHhyWTVhOEVBSjkvN2ExYk1CdkgzcEErbm1ObDFGZXhvZFhHTlhyMzdC?=
 =?utf-8?B?dDBlZkxMSUZ6YnA4ZHNHMkQwc2xmY1pET1dVT2g2ajRPdWlwUFEzUVAyYm02?=
 =?utf-8?B?cWE1bk50TW1IVzhDU3lGRUlvcCt5SDUzclVScFVYbGNldG5KS3hDMTZFN2ZD?=
 =?utf-8?B?b290dmY2ZnExM2xNQUpmZ3g4WCtIWFduWk1nQlNiZEpkVW0xc3RIbjN1R2w2?=
 =?utf-8?B?ekFTVmFwVkhHckxSNG1keFp0eWt5WE8rOUtmZmNMVG5vd2hmKzlnWlJPckkr?=
 =?utf-8?B?SkpjaFpMMmJVeklFSGVoSWJsSENlWThIOGtKU0NvT08zZ2QvZXg1VE1QKzgz?=
 =?utf-8?B?ZGJGUTJkV3NNNkVoU05Dek5nT1lIbXpGdVd3Nk51WW5xMW1XYkVWcWw5djhS?=
 =?utf-8?B?bUNhZVpVVDVtZXU1aDlIOFlJMU0rRlVqQjBFd3dqL2tkQzdaN0wvNkVDN0p3?=
 =?utf-8?B?RG1ReTNPU2VLYzBtZXU5elZZQUNJVlVEVlJTc0sxSEZPOXd0RDBhZ3YvSXVy?=
 =?utf-8?B?TVRRVFhBeXlhME9ZYkM0cUU4c01KUDZyeDdTT2JHbktMdWhBay9oSlNOb1Jq?=
 =?utf-8?B?NDlaWXNqcjZndlh6RXZidHJ6QkdvWEVnN2FzQlNBaisrSm1pY0g2Zko4cm9a?=
 =?utf-8?B?d0RaMUQ2MXJGNGtLbVBVdDE2SVFVSXBJNHZ4WTE0Z2ppYTgzSmQzQTVZUTdR?=
 =?utf-8?B?UzJPZ0dHV3JrYXEydENhL1hlbzYrTU4zSUxLNXROYmFWdWhucStXTmlrYzhZ?=
 =?utf-8?B?VVM3Q3hPblhjRENTSDM3aUhZMVAxWnczRmF6Nkx4MHJLb1hJYm5YVWJmMTJT?=
 =?utf-8?B?V3RLeEdxd2xvWEwzUW9IRDBQVnMrbmFRblVOTDJEbWxrZ0Z4WkpGRTZEdHRX?=
 =?utf-8?B?TU1TRldZQjhsbXJzV204R3poYXNKNU5XMFRudFdTaXBmL2hjZ1hCNnhqNXRt?=
 =?utf-8?Q?b4YWf7dHOwuarmd4=3D?=
Content-ID: <9CEEC8BF881B5945B8671A4E48C3D65F@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cKXVlKfRsfb3qjwrNYagXzELQTDmkCqm4negpgflDQr134yJtpue8W90gtpg+uELsNGu4tEue4m3vp8o66I6oUsTZtyrL1BTKpA8DhvjNkP1IBEOMtUvnJ60aFA62KJjTB+btCyWaljJ1t70se39zsJEAze79nEZ4YHeo/RJZQ/sxV/tWZCpazSEBEMtJktGkbSsTbG9Ehjl2V6E0KMgEsXTPpq8dTSiYkSJpitlDqQujmMHmztR9/U6lPCfgb6+8bq99Wt50H7MouuWRc+1TKtAVuzfI3vnHuEDRsDag3a2DIY0+t3EEPhcNoYwoVq9d+aaM2EEUAld/py+HVoOeQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885f88d3-edfe-4cc3-b3b5-08de8e53ae6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 11:58:39.2776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Qc5H+DhDh2vkgbnZCHtrH0+w6Yz4K/wldQCtcHSTqpqYPLY6qtBPwBhygjbaIYGZxKtmv6OI2ZZPu3guxUPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5916
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] high_freq_hwp_cap_cppc.c: new test
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
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Ossowski,
 Tomasz" <tomasz.ossowski@intel.com>, "Dubel,
 Helena Anna" <helena.anna.dubel@intel.com>, "Niestepski,
 Daniel" <daniel.niestepski@intel.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

MjAyNi0wMy0yNSAo5rC0KSDjga4gMTI6MjQgKzAwMDAg44GrIEFuZHJlYSBDZXJ2ZXNhdG8g44GV
44KT44Gv5pu444GN44G+44GX44GfOgo+IEhpIFBpb3RyLAo+IAo+IFRoYW5rcyBmb3IgdGhlIG5l
dyB0ZXN0LiBBIGZldyBpc3N1ZXMgYmVsb3cuCj4gCj4gPiArLyoKPiA+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMjYgSW50ZWwgLSBodHRwOi8vd3d3LmludGVsLmNvbS8KPiA+ICsgKi8KPiAKPiBUaGUg
Y29weXJpZ2h0IGxpbmUgc2hvdWxkIGluY2x1ZGUgYW4gYXV0aG9yIG5hbWUgYW5kIGVtYWlsLCBl
LmcuOgo+IAo+IMKgIENvcHlyaWdodCAoYykgMjAyNiBQaW90ciBLdWJhaiA8cGlvdHIua3ViYWpA
aW50ZWwuY29tPgo+IAo+ID4gKwkJaWYgKGkpCj4gPiArCQkJU0FGRV9GSUxFX1NDQU5GKHBhdGgs
ICIlZCIsICZvbmxpbmUpOwo+IAo+IFNBRkVfRklMRV9TQ0FORiB3aXRoICIlZCIgZXhwZWN0cyBh
IHBvaW50ZXIgdG8gaW50LCBidXQgYG9ubGluZWAgaXMKPiBib29sICh0eXBpY2FsbHkgMSBieXRl
KS4gVGhpcyBpcyB1bmRlZmluZWQgYmVoYXZpb3IgYW5kIHdpbGwgbGlrZWx5Cj4gY29ycnVwdCB0
aGUgc3RhY2sgb24gbGl0dGxlLWVuZGlhbi4gUGxlYXNlIHVzZSBgaW50IG9ubGluZSA9IDE7YAo+
IGluc3RlYWQuCj4gCj4gVGhpcyBzaG91bGQgYmUgc3BvdHRlZCBieSBhbnkgc3RhdGljIGFuYWx5
emVyIG9yIGNsYW5nZC4uYW5kIGV2ZW4KPiBnY2Mgc2hvd3MgdGhpcyBlcnJvci4KRm9yIHRoZSBy
ZWNvcmQ6IApHQ0MgZG9lcyBOT1QgcHJpbnQgYSB3YXJuaW5nIHdoaWxlIGNvbXBpbGluZyB0aGF0
IGNvZGUuIEF0IGxlYXN0IHdpdGgKdGhlIGRlZmF1bHQgc2V0IG9mIG9wdGlvbnMgd2hlbiBidWls
ZGluZyBvbiBEZWJpYW4gMTMgd2l0aCBzdG9jayBHQ0MKMTQuMi4wLgoKPiAKPiA+ICsJCXNucHJp
bnRmKHBhdGgsIHNpemVvZihwYXRoKSwgIi9kZXYvY3B1LyVkL21zciIsCj4gPiBpKTsKPiA+ICsJ
CWludCBmZCA9IFNBRkVfT1BFTihwYXRoLCBPX1JET05MWSk7Cj4gPiArCj4gPiArCQlTQUZFX1BS
RUFEKDEsIGZkLCAmbXNyX2hpZ2hlc3RfcGVyZiwKPiA+IHNpemVvZihtc3JfaGlnaGVzdF9wZXJm
KSwgMHg3NzEpOwo+IAo+IFNBRkVfQ0xPU0UoZmQpIHJpZ2h0IGFmdGVyIGl0IGhhcyBiZWVuIHVz
ZWQuIFRoZXJlJ3Mgbm8gbmVlZCB0byBrZWVwCj4gaXQKPiBvcGVuIGFmdGVyIHByZWFkKCkuCj4g
Cj4gPiArCQltc3JfaGlnaGVzdF9wZXJmICY9ICgxVUxMIDw8IDgpIC0gMTsKPiAKPiAweDc3MSBh
bmQgdGhlIDgtYml0IG1hc2sgYXJlIG1hZ2ljIG51bWJlcnMuIE5hbWVkIGRlZmluZXMgd291bGQK
PiBoZWxwIHJlYWRhYmlsaXR5LCBlLmcuOgo+IAo+IMKgICNkZWZpbmUgTVNSX0hXUF9DQVBBQklM
SVRJRVPCoCAweDc3MQo+IMKgICNkZWZpbmUgSElHSEVTVF9QRVJGX01BU0vCoMKgwqDCoCAweEZG
Cj4gCj4gVGhlIHRlc3QgZmFpbHMgYmVjYXVzZSBtc3IgZGV2aWNlIGlzIG5vdCBhdmFpbGFibGUs
IHNvIHlvdSBuZWVkOgo+IAo+IMKgIC5uZWVkc19kcml2ZXJzID0gKGNvbnN0IGNoYXIgKmNvbnN0
IFtdKQo+IHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAKPiDCoMKgwqDC
oMKgCj4gIm1zciIswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gwqDC
oCAKPiDCoMKgwqDCoMKgCj4gTlVMTMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAKPiDCoMKgIAo+IMKgIH0sCj4gCj4gQW5kIHByb2JhYmx5IHRoZSBDT05GSUdfWDg2
X01TUj15IGNoZWNrIGFzIHdlbGwuCj4gCj4gUmVnYXJkcywKPiAtLQo+IEFuZHJlYSBDZXJ2ZXNh
dG8KPiBTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKPiBhbmRyZWEuY2VydmVzYXRv
QHN1c2UuY29tCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpJbnRlbCBUZWNobm9sb2d5IFBvbGFuZCBzcC4geiBvLm8u
CnVsLiBTbG93YWNraWVnbyAxNzMgfCA4MC0yOTggR2RhbnNrIHwgU2FkIFJlam9ub3d5IEdkYW5z
ayBQb2xub2MgfCBWSUkgV3lkemlhbCBHb3Nwb2RhcmN6eSBLcmFqb3dlZ28gUmVqZXN0cnUgU2Fk
b3dlZ28gLSBLUlMgMTAxODgyIHwgTklQIDk1Ny0wNy01Mi0zMTYgfCBLYXBpdGFsIHpha2xhZG93
eSAyMDAuMDAwIFBMTi4KU3BvbGthIG9zd2lhZGN6YSwgemUgcG9zaWFkYSBzdGF0dXMgZHV6ZWdv
IHByemVkc2llYmlvcmN5IHcgcm96dW1pZW5pdSB1c3Rhd3kgeiBkbmlhIDggbWFyY2EgMjAxMyBy
LiBvIHByemVjaXdkemlhbGFuaXUgbmFkbWllcm55bSBvcG96bmllbmlvbSB3IHRyYW5zYWtjamFj
aCBoYW5kbG93eWNoLgoKVGEgd2lhZG9tb3NjIHdyYXogeiB6YWxhY3puaWthbWkgamVzdCBwcnpl
em5hY3pvbmEgZGxhIG9rcmVzbG9uZWdvIGFkcmVzYXRhIGkgbW96ZSB6YXdpZXJhYyBpbmZvcm1h
Y2plIHBvdWZuZS4gVyByYXppZSBwcnp5cGFka293ZWdvIG90cnp5bWFuaWEgdGVqIHdpYWRvbW9z
Y2ksIHByb3NpbXkgbyBwb3dpYWRvbWllbmllIG5hZGF3Y3kgb3JheiB0cndhbGUgamVqIHVzdW5p
ZWNpZTsgamFraWVrb2x3aWVrIHByemVnbGFkYW5pZSBsdWIgcm96cG93c3plY2huaWFuaWUgamVz
dCB6YWJyb25pb25lLgpUaGlzIGUtbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIG1heSBjb250YWlu
IGNvbmZpZGVudGlhbCBtYXRlcmlhbCBmb3IgdGhlIHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCBy
ZWNpcGllbnQocykuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFz
ZSBjb250YWN0IHRoZSBzZW5kZXIgYW5kIGRlbGV0ZSBhbGwgY29waWVzOyBhbnkgcmV2aWV3IG9y
IGRpc3RyaWJ1dGlvbiBieSBvdGhlcnMgaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
