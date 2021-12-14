Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA294C433FE
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 16:45:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD19F3C8D0C
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 17:45:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86B2A3C8A8C
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 17:44:57 +0100 (CET)
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com
 [185.132.183.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5076B200972
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 17:44:54 +0100 (CET)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
 by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BEEkDfC014286; 
 Tue, 14 Dec 2021 16:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=N4r5bLW80ACRdZjAjzuF0rjcP2tPfgvmQRv0xAZgr0s=;
 b=jb8TJPofb4wnt6++N9PlWqqVHtjFGxlPjBtpdwdoYmR7nvNgOmeVAyNc8ZPHM28BrPws
 cK9iZA/CT6OEuERimwd6cSGDkg7f7Q6BZiMDnzqUC2UR9GnNZZN+GI90wpWOiKAs1CC+
 hm+ieLiPictl2XA44gkxZ7ep/BzNv0xnqrDQedyRYxD5vwlpAC0cbmg81cqy+FPbULOs
 TqAViVOX1uRLAVcGv0/uy7ERqDkM2ZrWvU5U2SVjdFYNlppdOYoohepblyu0J5Qw/pGf
 8zjjc/Vr8SjJKE/wmuhcA5p8d0m6fCDkCOtXvSpSAz5a0fmSump5qHP5M3n9uQQJqCef hw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx08-001d1705.pphosted.com with ESMTP id 3cvj6htcgn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Dec 2021 16:44:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfmiVfbwaqTkD1+VgrBxkNsl8v9lnDG2zX6bEWVFwB42dda98IDNo/EmAMGv4mq1Etokxk/PRiC8GTVbFXcjP2W7f/a5+Ugr0QPmXw8nPEGIE2IFQ9t5HbzPMYG/NVsuoStYHa5awfvjtvESiGIuoeO6HD06y70Rw1rMXM/vN9xMpN8Pv25LfVmRGkq7CcRWPf5LmnUWubIo98E+4Tj2VUXC4xdZQXU797h3THWoHOI/RqbCB63i/Ty3o9Th8wHNnxTZlolecCFb6hzjMZUBhOc9Gmi8wEVMLct3a6YM2QWXCiprrXVmWL3viQ1xHbGAV3JDAmP3Y41y5xGWAT30FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4r5bLW80ACRdZjAjzuF0rjcP2tPfgvmQRv0xAZgr0s=;
 b=mRru/43LI9hJFapAEvVOeQY9TL/j+LGpO2HqFUPGn3GCv6i2bvm1OmBuHvLWSHT0Ouay7+bKgXOmOLLbm9wv8pN++zMb1hzgr+m8n2CV2gcGOdoeY7CfbaHbJ0qIDYziZO24COkoH99v3ZjGpMKgbn3lg6O0iqWFaLpfJEZwRUVuVYbP2AXye5VjlApha69ZfkVyDXv0+XayVUx6RMmcsmlly3K1wCQvla+nZlNWMBPKZCBICW2e0RPedB2DK4Qc5tZ4khJ03wQP+Ao5YC/Ybix0odtw/I9uEcQzBJrRefPLc8v609f1NwJdzfVuX8NQG1lM33OspfZreYlrHiemtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2503.namprd13.prod.outlook.com (2603:10b6:a02:cd::33)
 by SJ0PR13MB5690.namprd13.prod.outlook.com (2603:10b6:a03:405::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.8; Tue, 14 Dec
 2021 16:44:50 +0000
Received: from BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::611e:6e22:a5ff:1a50]) by BYAPR13MB2503.namprd13.prod.outlook.com
 ([fe80::611e:6e22:a5ff:1a50%5]) with mapi id 15.20.4801.013; Tue, 14 Dec 2021
 16:44:50 +0000
From: <Tim.Bird@sony.com>
To: <pvorel@suse.cz>, <ltp@lists.linux.it>
Thread-Topic: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
Thread-Index: AQHX8PkHcVdxahZ08EOaAgJkqo7HhqwyL5iA
Date: Tue, 14 Dec 2021 16:44:50 +0000
Message-ID: <BYAPR13MB25037C7B8DE0850EFB25DDE5FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-3-pvorel@suse.cz>
In-Reply-To: <20211214144309.6704-3-pvorel@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f1e12c6-e0f8-4e95-0ad1-08d9bf210c31
x-ms-traffictypediagnostic: SJ0PR13MB5690:EE_
x-microsoft-antispam-prvs: <SJ0PR13MB5690F720A50B8F868FC41A5DFD759@SJ0PR13MB5690.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:335;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgvDvarEbgk3oofQYqut6odXnrsEwt4zgcRZS2q8W7FzdTTv4r0yZ5P+EOZFk4mQDLLuaF3k0DYID8Rif33kM6xU/t8LLYfs0nSPLluOukvQip3rS/3JiytoTVN1pxHSLJv39pCMsr4ZfUZ1v1e9S6F/z7kWyffWp8KI3kq6LhqxYn/zpZ0BqPqYfVdh7wWN0iynFbRh3pIBlFLsksF8cRCPUD9/EpZCgaKzgmF0z/TKl2GNzDtB9AB76BnS8lp8Zx1EM+ODLftyGsGQkcWV4t1sHO0PKf2P9eEymlp8X5NQtAVLbTqst7Qv+OuAP6XQQUzG8l6hE9N1HR+d3HBJVnkNuOh43eBa0AUiJ40lBdElQ9FlDwY0frnJ2MHLUqY9EGr16nZo8WzF/z+OI0oLK4wtQyyTVsHIVFbnyutOZojsS/cHLjgebfrwxK4YmE2OOuqk5M/R5PqrGSaE6+smIir9ZyXKAYmdtVNDKatEpDA+smTzIkry/3Vflt945JMdtK8O0btU4+7b2qg557/OjhZrxx64qgl4FHrwX5PBkbskE1cp6vJojmXKed14VICbfaUGTSjWP+Od8R2Zx+zjiFyxVaOdhKLz/TjKAJacmbtFPjQtDlZqKZ9RlvANvwAc8l0GZA6czez1nnYhuBVoOSoKB24IATveevUc+2vXG6ptvVXeGYZfmQrbtSEZPQqBu7D9tRLqsG6/bACd56/eq0RVz/LcO1wAqye9UCVKIWssSGeHspyavLDN2Yl1jNFZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR13MB2503.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(52536014)(8676002)(110136005)(8936002)(66476007)(66556008)(2906002)(55016003)(64756008)(5660300002)(66446008)(38070700005)(38100700002)(82960400001)(122000001)(33656002)(9686003)(186003)(71200400001)(6506007)(508600001)(66946007)(7696005)(45080400002)(26005)(76116006)(83380400001)(86362001)(20210929001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3uQ40s75AcpaWONZf/CReztK7IcUOgXdxu42Z/ie59dokR2AC7z0gHSY4voc?=
 =?us-ascii?Q?e5n5P0d+c/29dbR7yxDIFphUygKPaWV6jcA2mVHri707wVZEfhqCJORc9One?=
 =?us-ascii?Q?z84F1UkV8+hRAp4LkyC/c8gEsSh+k8BODve4/zFlqH8xDj1lRnuAtGDi/Gq1?=
 =?us-ascii?Q?O+5rMyt1I61hd5+BYnDaDZ3UzVIfRccS/6SupJVSGC9+b7DOhFyn1XMM3n50?=
 =?us-ascii?Q?6vS2QjEZt5vdQo70I9s/SsfgdDeWiiu+mcH0ysKNK/1wPdD6yoTOX52D8FkM?=
 =?us-ascii?Q?oQgquWOeH/JOMIvx6LXd/+hU5qy/uNCvtcP4tP8KtUQa1J54FnMhhWYE4NhA?=
 =?us-ascii?Q?/X6KG+iAgRsxUajZe4a3VotLe4Csu7e6Ua9a/Bm/S3Sr+1xFpVzAlKEks0hv?=
 =?us-ascii?Q?D4EscBbxtU6LyGyhzcVt6CRj0Y1xHQH8YTTmaCIw4TCDOFcd7N1EwuL+KNC/?=
 =?us-ascii?Q?AgVwoXXLLRkoCQ5+4/7Vgmuh9OL4WPnWp9VLnR5A4aK6NgnXgwACJelhuvzC?=
 =?us-ascii?Q?1dcO7yCK09HsVEn2GCz5dgjCyZEWtowNIalu2HIbK/bDfiapXw7nEf5gQhqj?=
 =?us-ascii?Q?vf2k3TTtgiNc9wa+xsSYwI/A/FnaI7Rrw7Yjd+No1VtL545aOoixR5F0w3Uz?=
 =?us-ascii?Q?scNGJl8GMPP6D+gOCI5TNRp6gck+TK/Zqw6GMV9ZbwJ4Qa7UirilLXxkSYRJ?=
 =?us-ascii?Q?MITesDxO6fx0cOqVsLfqLRg6RW950Hlqs8z7PNuIB9qV2QxPujEjxEHJOf05?=
 =?us-ascii?Q?1J3p4InO/5ZTAlBqsbguT2mJG1uR1waoZ59rV0TeqouSE+4sLOV7LfmZbekn?=
 =?us-ascii?Q?VQjZzE8hFRS/bkercAVXmSrb51hFjvEKl116tjvy4LD0GEOjwn/mfYeowWTX?=
 =?us-ascii?Q?ZbDwnI32XWvgtdvgSgmacBHnvxAjQSBSyjDDOrM6WoGeSzxTHi9gf2r4U2U8?=
 =?us-ascii?Q?FfFodiFns2X9OH/0BP24CjvYPi/FGeCu2YgAP54mMy4PqAyyCWHVufgLJ1S5?=
 =?us-ascii?Q?8lY03jWLdCG5R2noCJAvqnPDXZdENkkOlDgzqCTrw99xCm6T5sn33913Ph3x?=
 =?us-ascii?Q?m8G0suf3vra3qmFbNz0+LLM7pHCpzd6YvMsBRIKolYfTvffU4oxxxV54XQJ2?=
 =?us-ascii?Q?5tP143Iv0CX2RZwEePwH+4nNWPk0nqUo1Jby/vEleBXFO1VFECvqCJbUFw/D?=
 =?us-ascii?Q?fN+VTRXg3oVqxmJC27uemUeUHUbzHeiCee8nSaw2Ml5sSpQhNo36SQEZVcO4?=
 =?us-ascii?Q?Q9wvdMByyzpGtv2Q/dBnJS7qp/MRh7KKW2aXO8yN8/t4929YBZHgcBsJUrek?=
 =?us-ascii?Q?kPDcwzNLbmzJSnERc3K3xMKoswoaFg+zgNvUBrywfUaUoEA1k05UI9ljjB0y?=
 =?us-ascii?Q?pEX1Kal0C5YI+PSS8eJgjsJwSXEzTGe8+fnt12lCCYItTTJmG/jOWGk0hfkz?=
 =?us-ascii?Q?Up1GyGIFsUD1FnWICFW0oWlz8AYqnotGVd8ZRAwdm3NEUhMwq+s7mUTn0RmK?=
 =?us-ascii?Q?hdJXymc3rUoywtyySFLEkngRLk3rrrzY9WUPmhGevCRzEMcE3hSo4NWaiuSt?=
 =?us-ascii?Q?ssGN3gNH1McTfxpG3SaxUbb3RXOwJM2EcnvEIyM4J4868lpj7epXb3eMt3mA?=
 =?us-ascii?Q?U9dkkLUVcq9uAvE5ugw3rrM=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2503.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1e12c6-e0f8-4e95-0ad1-08d9bf210c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 16:44:50.7752 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ST1wJgP0ie6biOBEqz+bgK3UxrIuo9PiKgDm7IQo4brEL14/ZwLldhdxkk8BEIEUICCAIlCdEDi9obtd/zqGvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5690
X-Proofpoint-GUID: kAVn9ijjt-fd6dnSy52poCANr33ceqW8
X-Proofpoint-ORIG-GUID: kAVn9ijjt-fd6dnSy52poCANr33ceqW8
X-Sony-Outbound-GUID: kAVn9ijjt-fd6dnSy52poCANr33ceqW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_07,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140092
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>



> -----Original Message-----
> From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Petr Vorel
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> new in v2
> 
>  lib/tst_test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 265df6543b..f92ff858e9 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -475,6 +475,19 @@ static void print_help(void)
>  {
>  	unsigned int i;
> 
> +	/* see doc/user-guide.txt, which lists also shell API variables */
> +	fprintf(stderr, "Environment Variables\n");
> +	fprintf(stderr, "---------------------\n");
> +	fprintf(stderr, "KCONFIG_PATH         Specify kernel config file\n");
> +	fprintf(stderr, "LTPROOT              Prefix for installed LTP, the default is /opt/ltp\n");
> +	fprintf(stderr, "LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)\n");
> +	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
> +	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
> +	fprintf(stderr, "LTP_TIMEOUT_MUL      Multiply timeout (must be number >= 1)\n");

I think this should this be: "Timeout multiplier (must be a number >=1, should be an integer)

> +	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm\n");
> +	fprintf(stderr, "TMPDIR               Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
> +	fprintf(stderr, "\n");
> +
>  	fprintf(stderr, "Options\n");
>  	fprintf(stderr, "-------\n");
> 
> --
> 2.34.1

 -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
