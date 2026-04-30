Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14CACD13DA
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:10:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65A403E53DC
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:10:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52B853E2892
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:10:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5653E20015D
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547410; x=1809083410;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:mime-version: content-transfer-encoding;
 bh=BwHPTuj2n75VkGObRPgZvb7Gw0kTpdT0iOIgOrSisKo=;
 b=VBXHIurJrPgP5bAK3tas3rBz+A5+C/K0NvLlh+SAtBb2SOm7EEoqa78f
 gHWLzmvufPgZ/dT3rapVfKTfN4DAlNMYEGAK2UuST7pQD9AyaFVMJEbX+
 pPsa/bJxviqZb3PfHDKlSEc9C0V5U8alJpsIy+vA5uzzQFW663NwXpZ6I
 jjIE4PneKfrHvQvK0JGF/DMvTBY9KUw8RH6JrW2UuxkVvPm+k5O2IzLb8
 etE8NgYqKSI+VNnKZcaBQJA23vjfjeyu8ihSNl1xoAD4oyeLUylkntRrW
 3CGe6sJeXMpqIZ/i3w/5jThmJpHlGV+y2Ju7dj7ByJKN9GU2X5TC7xGCy A==;
X-CSE-ConnectionGUID: 2A45udUvRVeNXhm7ahbUAQ==
X-CSE-MsgGUID: HB5eXbtIS96sgvLeRf3HcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89587778"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="89587778"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:10:08 -0700
X-CSE-ConnectionGUID: SssNlzF2Q3S8P60mYRYegg==
X-CSE-MsgGUID: fP8x4020QXeRvO5uA188Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="233523608"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:10:08 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 04:10:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 04:10:08 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.57)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 04:10:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACN8IA9U5UD36sZyhBK8RX7vgE7LIhg7gOVuXosIf6JHmoy6kt0ugzQeE9EvFszfAPABDHq2LN76m90FYGSZw34DYRiEIsH/9ZFi24TTF+kEsaj/x0RvVnm30r7EmgrPlR1uEP8FM/kM0AdRrE60bOFiegejclox9EkycqwY5jdfO+TPdZNQSdDvuIXhx90OnCwApqirm0PjvMcHdOk0Bi02hBe5lWmeFxtB7jJHiz39v9LCdA4xTvJwCWt/NZI6bFdRahBRqlZ1zaAIkdqLeoS21ICDUgxH0AwjsLlkhmaP9l2rH1i317BA9ZlYKLfIsiIC9Jif15N/l+SeXZ4kFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbjZ4qVerR0CogQn94jEjVSh3OZfl8ab0Tucf5V6l5A=;
 b=W65XphvSxsjBd27ZixLEE3urAfQSH6AOLGyWeklpzY6mR8eB3ez38YyH09RA+wjqUX/g9IqlMTBY/y+HqdLE6WL+5z97MoAMGebKispJgYM644R9fPoSxCzNbUHHXrQDa/7N6opLbFMLnm6w1NVQhq+MetFJtIO9vKxzpEslepgTDEyXHlswlSQrwyp+BkqcFAb07UqDlQiGVQ5VjtG/MrRPEytwQ8GPiMuXQxKKUwAEr5Rtkn3Y2e2OJfbHm1iSPa1KQA8KJ97O9bXBC+hxTBVFiNZzIZpjw+6xcudGtaHUfJhjNKRjofkUBb7vYC4LiMsbjNkDDoNt857VMJnElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB7024.namprd11.prod.outlook.com (2603:10b6:510:220::19)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:10:05 +0000
Received: from PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13]) by PH8PR11MB7024.namprd11.prod.outlook.com
 ([fe80::be73:dcff:d32:6d13%3]) with mapi id 15.20.9870.016; Thu, 30 Apr 2026
 11:10:05 +0000
From: "Kubaj, Piotr" <piotr.kubaj@intel.com>
To: "andrea.cervesato@suse.com" <andrea.cervesato@suse.com>
Thread-Topic: [LTP] [PATCH v7] high_freq_hwp_cap_cppc.c: new test
Thread-Index: AQHc0KpwPeKF+/oPukmWXksG+FH/2bX1uSCAgAHJVIA=
Date: Thu, 30 Apr 2026 11:10:04 +0000
Message-ID: <4aba20ea6369b6ad2423a67b7af2c4b7a68c04f0.camel@intel.com>
References: <69f1b8ea.050a0220.2c172.5acd@mx.google.com>
In-Reply-To: <69f1b8ea.050a0220.2c172.5acd@mx.google.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7024:EE_|DS0PR11MB7880:EE_
x-ms-office365-filtering-correlation-id: 514e3827-49b1-4030-6d93-08dea6a9082d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: CsleRcxpUPXKGaZLgI014xJr0s3Ae/J/3aRSax3h0+DFPm1hM2BfuIJ1bgsPC9KaeedBtmXDnETlBX25nxvNsM0asGoYykQ3Z4053dHw+1YDPm58DJcdTmTujAeryV64MQTmHRO8Y8BpEdOaLh6JQR/6jz8S5z/06LrlWFbXWQuivBU02M4bAHdIYA2pLNzF/EmzYu6RIRqdxdeYvzcRlwNa9EkQnH2vg+ajOmhtvdmk9Xw9MjS06DczTPEqw1UsKRgfiswhTJ3To/f0aC5zntuILbY7D2TnYRRWjWWeeJWfuoLpX44f3fyo0pcJ/v6ruHIW4DWyxoDABVliX4F4GcKF75D0tpUfFmVrZRV7T8yNCgEHbvlTPvlg98oh8uN9+sJBmDMd1ZWiTsDMMoP8bTRQZaN5A1rlFMic9L5HF1PIPaZdbqaYKqv/8z763XWmP2o2Gl+Gw8+/RAVaazMOiHRj1W460sCIMqu+0fLR/uQmF2vt7CHpg2sgHusWqKv3ETEcqP9UKnfvoJShvp5qcEFuMRRueH58fNxVOm+WGuiJvs9iPrpNKLA/7srHdty5N/pKxZnliz0guLNMF2Pkq59ZUyyahDgfH6QCm+KvqPGP3tUyx7ocE5YwmU/jNxB1Sm0q4+SffRNJUNzLhSwyJ0XCJ43lnI4k65gVDJopiPBAK1QvwfjecjoPySRv+/3RlXfJkOXHtNRvuob/VlLWq7JeG855uqtrlsBVoazAWZ7YFamc9PEPwH0/Dks4dWughOON+WZJ1AueF2oaVfdfO02ZFywgLOztH4l1eslk9Es=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB7024.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1hqcXJsTjlTSVhZK2g3N08wYWJpZ0V0b0thRGlRNTlsb2toUDFMRjUzMW5l?=
 =?utf-8?B?MGlBY0IyTmczai9PM1dqRDQ2UW82KytxRnhvVmxXaE5IbW4rd1N4VjQvY1pX?=
 =?utf-8?B?NStjZlNEMUloZWJvbVdGYjhITGpsS3VUNDVtOG1UYkRvN0xJS1dySms3WE5P?=
 =?utf-8?B?WHVCbC8reEV6aWtUbThCWUZCS1ZUajNwWDlmMC9wUCtnVGZONDBNUDh3cVZK?=
 =?utf-8?B?NTk2NG02UzNEQWJQZVluUnZDSy8yOUlUcnhnOXptM2ltSi85ZXIxWVNDSGdQ?=
 =?utf-8?B?emVFcm0yWWpWZDZMQ3FPUEU2ZEE3eXBzSVJieUFQYzlmazdXREUrRHJGL2RW?=
 =?utf-8?B?dXFGRkNkZXMwTGh6YkNNUUFIMEhzMytBQkk5aDJnbTUvVEFPaEdUOHRiZWt4?=
 =?utf-8?B?M0srdUVtNTNHZHV0SlJDVUszOUtta3dOaHhKdHVYN0YyWGJxYnNERFJGMTd0?=
 =?utf-8?B?UHd2UTdtNDVnQjFPMUc2RnBLRUxLOXhBTzljMkF2VGl5ZFdUMDE4ZVVFWjdq?=
 =?utf-8?B?d21CRUZ6ZTZYRStVSm9lTzZINDlxVjJraUFYV2x2eTZtc04xL3JPZnRvem1s?=
 =?utf-8?B?SlRhRlkwWm5ZakFsakhvRGRMS1hEMjJnT25KbnJtK2NRUXJLQTdYMUd6emdS?=
 =?utf-8?B?ZTdndlllN2c5MHhUalpoYVZ2d2psSUZjSElXUjFENlhoZDB6N2FoWFVLYTVa?=
 =?utf-8?B?MlcwMDUySUdrM3l2eDEvTENzUUdzbjlncTA1aUx6aGdRMVZKeUZHYnJlaHNU?=
 =?utf-8?B?a1hYMFYvSXFLZGtpN283TGNaRWtwOExJd3NvWjNkUlFBU2s5UjYrdEUrb0E2?=
 =?utf-8?B?dUUwcGEyVGlaNVUvK0ZIcEN2SEJmVHlHeU9oMHoyRmlYVEhDRlpONjdLV0ZD?=
 =?utf-8?B?UVdTeStPQmR4RjRSTGlzelZxb2dVQitQSzA1amNld3VHdWtOUUlsZUdhbmlC?=
 =?utf-8?B?Mk9vTkNjT21nSHNOdFBQQ2U3MjVIRyt0cnF1ZVFhb0VVYWNFKzRrU0hGdWds?=
 =?utf-8?B?NFRtNStLVXYrOVNYLzFlMDR5QmlXRy8xM1hheWhMV1c3WlVza1E3ME9vTGNH?=
 =?utf-8?B?cjg1MkxqSFZYemMrcmdVMWpYc2dXZitmeEpaTWtrUWxoZTRueEgrNHNmTEpa?=
 =?utf-8?B?NXZGSkt5NytoWkNHblVYT2lPNmZIQm01T0JndEhwcGsxZDlKWDlHcnlCUDhy?=
 =?utf-8?B?cVJsbWdHYmpZclByTE5zT1VFbVQvRTMrOFRtQkk0Z1dORkZGMnpleloyMW1R?=
 =?utf-8?B?NW05Qm5LcUZFenZpMVE5RzJpS0FVTk9mWGI5OHFPR2RLcCtNSCtjUU0xcUlC?=
 =?utf-8?B?QUZTV0hvVmtwVmtRRWpPYnBNSzFxWWFid1Fxd1VRdUVVb3VUR2hScnVrcVlS?=
 =?utf-8?B?VjZZVnZYVEhxb3htMEVHNFpPUUU3a3YxUS9ieU0wcTBqWlYwN2VNQmkzRFh5?=
 =?utf-8?B?TW4xSDFhVmFxUGZiUG1yZ1JiTjVieVpwQVVWajFoK3FoYkxDSEoyd3NMU1Zv?=
 =?utf-8?B?c0t4Nkxld1N1bWhDYWFmS0JiNnlKN0tEZk04NVBkSThSK3lVS1g4OWVYMDFp?=
 =?utf-8?B?WG9BbmhPOXJzYXlSOWRtT1NnSnA4TmF0NnJGSHlaaUNOYjhPMnRXMFNQVzhp?=
 =?utf-8?B?YTFMU1BnZ1JONEFCTkt1VEZiWFFpSjNKRi9SNVZwL0luUWRBVnV1WGhQZDgv?=
 =?utf-8?B?SXJORWM1czY2WmJkZ2xSZWNCZ1d6dUgwRXdScTY1TjBDVEc0M3VHTmlUYjNK?=
 =?utf-8?B?bVRuZjdieXp1TkxSU2ZMaTFSNzJmRHRRZXRCeHNGeWlEUXpJdWNZNy9XUVlT?=
 =?utf-8?B?UVRpYlB1RDRBU3VxdmhreG96SXlyOG12MElUMUlUN0ZWQmprM0xiRmtHeng2?=
 =?utf-8?B?MXlPMU9zTEhDT3QrSzVad2hmUmEzSmFLOXpTWUs1ZEFiRmZOL3phZWo3ejV0?=
 =?utf-8?B?MnB4RTJiZkI3VFZDblFPMXNJSGpReUZEcSszZ2ZwMHFoVDhUb0pieWNlUHVQ?=
 =?utf-8?B?amZKdys4K3NPeGt0MkYwWWR2eFZtSnlnNUwxQkR3R0R2aGprUXM3ZklWYWkz?=
 =?utf-8?B?ZkR6bmxqZ0RlaUs5ZkxEaStlNnY3U3lMWEpiQVFReW1iMWRzbDVNbGs4ckdh?=
 =?utf-8?B?T1dXWVpYbTFYS21PQ2FIM08yWGxIWWlJTUI5VTg5d3F5QWZzbEdZR0RwQmhu?=
 =?utf-8?B?NERTM0E1bXdhQ1BSdkFUVDA5cCtNanVXaFh2RjZlKzcrYVFJbWdhdkhHTHc3?=
 =?utf-8?B?UDI0azVIWkczR2MzOXkxeHdQanJCUytySU00WXd4dnNJQ0VxODBzOVc1N09S?=
 =?utf-8?B?Y3M5ZS9wRi9KVUxFNkFoazJpL1FTeWs5d1REaUpxb2pWWVFET0twVHBJVmJE?=
 =?utf-8?Q?zXV0JiQP0fAd6dj0=3D?=
Content-ID: <BCFEB19573F86E4294AB53E1B99F9B0C@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OV8Chn1noCAW+o8fFM/6cFLbe+xK1FWM0WqJymV5doT+r8WWq8ZRjYsbD0GzPbO6pzP/Ar2lUvzhxVRWPPZprkBlfEflOrxBkW2ym/AmcCLizTkIt+Z7O+efWrLe1fGG6tJxob8QMHG/xxXxcN5vEf+L8n5iGJd1BBdz9nD5TQEjHVzlitdm73ZoyXF46dXQgTSkkbKz5Y/9eG0aGzpHqw036AGsBPMOsFSDcTLF/kFkXc0pj95eUQSB78ouOQNucsDYkFsKDwLTn3wyS9XJmK+kZR0LeI2CJAEcViIPBYbzShyuIUDmEcnVlut3tVjHC8Cscies3vc7vfIKZgBwBA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514e3827-49b1-4030-6d93-08dea6a9082d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 11:10:04.9926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 66G5tdiypFSD1wyT3W7cuPjzjORBl1/UYP4HLTNTq9avTiQxd/GGSHqgMQSACAdw8KqsA8IzNoa74Ctc6vIBZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] high_freq_hwp_cap_cppc.c: new test
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

MjAyNi0wNC0yOSAo5rC0KSDjga4gMDc6NTMgKzAwMDAg44GrIEFuZHJlYSBDZXJ2ZXNhdG8g44GV
44KT44Gv5pu444GN44G+44GX44GfOg0KPiBIaSBQaW90ciwNCj4gDQo+IEkgY29tbWVudGVkIHRo
ZSB3cm9uZyBwYXRjaC4gV2FzIHY2LCBzb3JyeS4gTGV0IG1lIGNvbXBsZXRlIHRoZQ0KPiByZXZp
ZXcNCj4gaGVyZS4NCj4gDQo+ID4gK3N0YXRpYyB2b2lkIHJ1bih2b2lkKQ0KPiA+ICt7DQo+ID4g
Kwlib29sIHN0YXR1cyA9IHRydWU7DQo+ID4gKw0KPiA+ICsJZm9yIChpbnQgaSA9IDA7IGkgPCBu
cHJvYzsgaSsrKSB7DQo+ID4gKwkJaW50IG9ubGluZSA9IDE7DQo+ID4gKwkJY2hhciBwYXRoW1BB
VEhfTUFYXTsNCj4gDQo+IFRoaXMgY2FuIHN0YXkgb3V0IG9mIHRoZSBsb29wLiBgc25wcmludGYo
KWAgYWRkcyBhIHN0cmluZyB0ZXJtaW5hdG9yDQo+IHNvIHRoZXJlJ3Mgbm8gaXNzdWUgd2l0aCB0
aGlzLg0KRml4ZWQuDQoNCj4gDQo+ID4gKwkJdW5zaWduZWQgbG9uZyBsb25nIG1zcl9oaWdoZXN0
X3BlcmYgPSAwLA0KPiA+IHN5c2ZzX2hpZ2hlc3RfcGVyZiA9IDA7DQo+ID4gKw0KPiA+ICsJCXNu
cHJpbnRmKHBhdGgsIHNpemVvZihwYXRoKSwNCj4gPiAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUv
Y3B1JWQvb25saW5lIiwgaSk7DQo+ID4gKwkJaWYgKGkpDQo+IA0KPiBJIHRoaW5rIEkgbWlzc2Vk
IGEgcGFydCBoZXJlLiBEaWQgeW91IGRvdWJsZSBjaGVjayBpZiBgaSA9PSAwYA0KPiBjcmVhdGVz
DQo+IGFuIGlzc3VlIHdoaWxlIHVzaW5nIFNBRkVfRklMRV9TQ0FORiA/IFBsZWFzZSB2ZXJpZnkg
YW5kIGV2ZW50dWFsbHkNCj4gcmVtb3ZlIHRoaXMgY2hlY2suDQpZZXMsIGl0J3MgbmVjZXNzYXJ5
LiAib25saW5lIiBpcyBub3QgYXZhaWxhYmxlIGZvciBjcHUwLCBJIHRoaW5rIGl0J3MNCmFzc3Vt
ZWQgdG8gYmUgYWx3YXlzIG9ubGluZS4NCg0KPiANCj4gPiArCQkJU0FGRV9GSUxFX1NDQU5GKHBh
dGgsICIlZCIsICZvbmxpbmUpOw0KPiANCj4gUmVnYXJkcywNCj4gLS0NCj4gQW5kcmVhIENlcnZl
c2F0bw0KPiBTVVNFIFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgNCj4gYW5kcmVhLmNlcnZl
c2F0b0BzdXNlLmNvbQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkludGVsIFRlY2hub2xvZ3kgUG9sYW5kIHNwLiB6
IG8uby4KdWwuIFNsb3dhY2tpZWdvIDE3MyB8IDgwLTI5OCBHZGFuc2sgfCBTYWQgUmVqb25vd3kg
R2RhbnNrIFBvbG5vYyB8IFZJSSBXeWR6aWFsIEdvc3BvZGFyY3p5IEtyYWpvd2VnbyBSZWplc3Ry
dSBTYWRvd2VnbyAtIEtSUyAxMDE4ODIgfCBOSVAgOTU3LTA3LTUyLTMxNiB8IEthcGl0YWwgemFr
bGFkb3d5IDIwMC4wMDAgUExOLgpTcG9sa2Egb3N3aWFkY3phLCB6ZSBwb3NpYWRhIHN0YXR1cyBk
dXplZ28gcHJ6ZWRzaWViaW9yY3kgdyByb3p1bWllbml1IHVzdGF3eSB6IGRuaWEgOCBtYXJjYSAy
MDEzIHIuIG8gcHJ6ZWNpd2R6aWFsYW5pdSBuYWRtaWVybnltIG9wb3puaWVuaW9tIHcgdHJhbnNh
a2NqYWNoIGhhbmRsb3d5Y2guCgpUYSB3aWFkb21vc2Mgd3JheiB6IHphbGFjem5pa2FtaSBqZXN0
IHByemV6bmFjem9uYSBkbGEgb2tyZXNsb25lZ28gYWRyZXNhdGEgaSBtb3plIHphd2llcmFjIGlu
Zm9ybWFjamUgcG91Zm5lLiBXIHJhemllIHByenlwYWRrb3dlZ28gb3RyenltYW5pYSB0ZWogd2lh
ZG9tb3NjaSwgcHJvc2lteSBvIHBvd2lhZG9taWVuaWUgbmFkYXdjeSBvcmF6IHRyd2FsZSBqZWog
dXN1bmllY2llOyBqYWtpZWtvbHdpZWsgcHJ6ZWdsYWRhbmllIGx1YiByb3pwb3dzemVjaG5pYW5p
ZSBqZXN0IHphYnJvbmlvbmUuClRoaXMgZS1tYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgbWF5IGNv
bnRhaW4gY29uZmlkZW50aWFsIG1hdGVyaWFsIGZvciB0aGUgc29sZSB1c2Ugb2YgdGhlIGludGVu
ZGVkIHJlY2lwaWVudChzKS4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwg
cGxlYXNlIGNvbnRhY3QgdGhlIHNlbmRlciBhbmQgZGVsZXRlIGFsbCBjb3BpZXM7IGFueSByZXZp
ZXcgb3IgZGlzdHJpYnV0aW9uIGJ5IG90aGVycyBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
