Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A13C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 14:20:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42D673C9F04
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 15:20:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F73B3C9C2E
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 15:20:05 +0100 (CET)
Received: from de-smtp-delivery-102.mimecast.com
 (de-smtp-delivery-102.mimecast.com [194.104.109.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 774D8140142F
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 15:20:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com;
 s=mimecast20200619; t=1644589203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BrCnPTnWsaCM4TMFzkv34GOCm4xGqILE01pwE1kXb4U=;
 b=i2oSTTPTFgzbUqms8fh3ijAVKMqIgfMgHFQuG7X/lg6tusD9OXhLxtAKwteZ+kPHmSwR3p
 PxoB8eJS6usq1GBYeUoL/bjcg8pcUi0brGoYcUHHKLHZHgbOpQlBQRkp1iyL3bNU4Pdm8R
 nKGtQ9/YPaGhao9ahC+wizNKf0fB7S8=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2054.outbound.protection.outlook.com [104.47.8.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-7-eAZnWSJVO_6rGygVUzBbww-2; Fri, 11 Feb 2022 15:20:02 +0100
X-MC-Unique: eAZnWSJVO_6rGygVUzBbww-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGyQxDQSJxEiPP3dE9KRGRarzFayy+BXHEsYBj9VHWck5xPeHvbOnFikIjZa7Afi7CFjD8ODxGLkpX9610JkqBQl7i4ZwGc/dZciti3bP0lWFwFCM98VJ9wGvf9QkET3cHkDxIbahT2Eq1WIZ/c1GVvk9xyQwt7bFvqxzruYSTGqwV31eXjxzk2QcvVZd5bzjch2yyA01A58YuLG2GLFOKaqajCLtzhSqeby7EV+xtUX9GF9kCnz9+vp3HJ6a16IQBWU/2ecG2NYQ61iUEvJs3sUJIqZl2D9W7pKbRe7cl9lBBKYqUvsaHJHh9MgZGatFyu+spC+dfaozFjgfC/EWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrCnPTnWsaCM4TMFzkv34GOCm4xGqILE01pwE1kXb4U=;
 b=IbvpI0wzCJ9jRJLiC0NiJ4Snj+2qi0zZWsd4YYo7z6SRJk8Iuc9CdWpSuA9fluBW2ca5Ur7Pri4yGoqcyvNB+x/mhLLr6FE7HoL3yYHp99jpE/I5nnNTOb82AvHpU1HLI5nDZjssE6UYw96/pl/bkjuslpE+Lcu5phl8REqwHgjbrIE/xEy0WS0UfpU78TDxk6Pbfv/aug6rUB6MBo7vcyeq66yxKC8+fCCpKpsqfk3iMppVj98RUN2IKD6g/OpHUQ2f3z6MqPPQ9MCk9kZe/0Sy2vDyGVRn3ahTe4GWxZ3A+VF6mH+zXhERIfSQQ649Z89CbCjOxS2DmOAwJvppUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com (2603:10a6:803:60::23)
 by VI1PR0402MB3903.eurprd04.prod.outlook.com (2603:10a6:803:21::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Fri, 11 Feb
 2022 14:20:00 +0000
Received: from VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::a0d9:78a3:9171:9a2b]) by VI1PR04MB4958.eurprd04.prod.outlook.com
 ([fe80::a0d9:78a3:9171:9a2b%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 14:20:00 +0000
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [PATCH v1] lib/safe_file_ops.c: Fix resource leak
Thread-Index: AQHYH1IAH1V6ddvMtEiQQ9tTR3mbjA==
Date: Fri, 11 Feb 2022 14:20:00 +0000
Message-ID: <VI1PR04MB49583062AFA205712ABA54B793309@VI1PR04MB4958.eurprd04.prod.outlook.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 27114c63-3f36-eaf4-f404-9d4d3890644d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6025748f-2c82-441a-2aa1-08d9ed699675
x-ms-traffictypediagnostic: VI1PR0402MB3903:EE_
x-microsoft-antispam-prvs: <VI1PR0402MB3903B2EC33605FDB97E31F8593309@VI1PR0402MB3903.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+ZkRjPkhraHnhYzDH3QEH4DuI2sudXXhTFEAeBUfbCbTtiTGIcpKZcExJY2D/yOnP0KfSnftAt1+4FAHcSNWeGiNqRnCQHEpOUSM7QZtgAwn5aql4hueyTCkH1pCl4kvzwZmceIHsk/RC0dpKxxo4IUTq8gs37RQ2mGzqwBFMy35GeUkPKW1MRuwMBwuhDP1coEtZNY37lWGS0aIEwjaU7dy+esZS1vZ9+pjMHfk3tBU7EuiRiB42iPCMuVCZnsC4P7Wwh7jmKhAcuHtiw2HuujA7GMs3SDEXqnoh24Btt+IoE+kY0ljPts2OnC50JuyviDum1gfo+vY1SEGnWHHXYE541Qi03CWQ0xoN1IYaS5t5BkZVmv5vzP1CvgZkDFbRahVLyTut+eO065KwP18rHf2zskvRkVbCqEJq2J2lPI+3Atxbn/TdWjB7ujVWPCyxBEd1JOm8D+QPWpgZ8AGKPkwKLtgxBG+BWmTs85Ikoe5Zz2qx2PJuPrwoWSV1xW2oaDwWJ1HWhaZXl1GxErh+8/ngQ/Ok8M9jRbhDGaReRLBAHoKYPXCVF37/RzS6vGrVeSwi7POk8cS2je1BQskDtWtPRL68QvrmJ0m8fgjy3cutoWkBoHaOCzBdSwHx0uWBg2ytkntb1TiWfVjyhSmbCqWBNEKd3nxEZXwhEdpJKMwGTtPD+93+fzLeHPPWUE8Lji17n7/fdWjj2n9K5Gvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR04MB4958.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(8676002)(86362001)(76116006)(66946007)(8936002)(64756008)(83380400001)(107886003)(4326008)(66476007)(66556008)(508600001)(91956017)(316002)(6916009)(66446008)(2906002)(186003)(38100700002)(26005)(71200400001)(52536014)(44832011)(6506007)(7696005)(5660300002)(38070700005)(9686003)(33656002)(55016003)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bHO9OnEdSGX3w7uMycJoxPJBKyCF0Yv0CZ0MzSB1EN22nSaTcv2NvXWebT?=
 =?iso-8859-1?Q?wtOBl0H9b5psB6vno6UiK1KMo9GC2H2NZxYQX7lUFlb/z/qO2CTRMIrtWe?=
 =?iso-8859-1?Q?xBXN1qaMir7QOrYUwYhNwwP3BA589L3lvypz2CyzpaNgRJrfD9FDD5+1ng?=
 =?iso-8859-1?Q?97XmL+UBYzkAvihVhNRnFq/FmsKC8fwK9r/X9kw/C/d8tuwImYSVXljdKa?=
 =?iso-8859-1?Q?fzN1n7rcx6gpiAqSVcAJ2P7FbIXhO51k10KgJanB/QhL+9Eu8mLA7JGnOJ?=
 =?iso-8859-1?Q?f4PIfq0l2AORH5zF2ZsZbw3/Wd4UmhiQETRx1cfTiqjPnyJILeXzlAyXFN?=
 =?iso-8859-1?Q?nTpNlnUj3Jiz9IHYdrYlnPXkdMNFxoQFdiB50cRsxA2s9WHCYmp/A8nmWe?=
 =?iso-8859-1?Q?Rnq2lNVaIscd3d0sobGfzEikfIHyx0BAuPAcE3D/AWLpTO1foRwKrQLPp0?=
 =?iso-8859-1?Q?dkWEMkC471yzRxP718Trq5rx44EQpe5gGZQ/trFDsL/6GKT26/fYuDcxub?=
 =?iso-8859-1?Q?0nb4KX43hB5xtvJ5VJJ04rNB6kO6VR0eJ1vygsnP2LjEYfFdNd3qBmJ8JG?=
 =?iso-8859-1?Q?08KY4BVAuBUep/VSlTaruz++jx2rT1seotjA7s+q9yeMRKBelCL7V+Bd/J?=
 =?iso-8859-1?Q?YNGY/3RUlM83q1+2R7ojFAt1l1epUVVthrQQ3NqkQAItF6mycgVElfqx7E?=
 =?iso-8859-1?Q?/B3S6RcDPyGOkHcx9YlFgevN48G7+WiB9q3XNIo453KdJCgmI5VQVi/Oiu?=
 =?iso-8859-1?Q?9XnnaPhHIr94DEP87AeZB8g0G2uWkQP0Xaybk7r4K5AjfBPfN37qvgsguY?=
 =?iso-8859-1?Q?qQaxBcI0jRGn8wrg51bpz4Wen63PqWVGdGspaMi7y9013reYxo6EelTiia?=
 =?iso-8859-1?Q?NiLv+e/Dr6spfoZdbLeud0nmMY953feQp5yPI272AxF0EwBnt3Z9tHZvPq?=
 =?iso-8859-1?Q?8sXUlYZ4YmYLDsTb2C/CH58PqEJJ2H3IVjD0GE4zM5VXuwrP3HoDBQTSEs?=
 =?iso-8859-1?Q?lSBJa9RZZJ3Sa9ep0RKbt4DWpZDAvqmDeDecEnlsx7Z9TrhG9zqc4wdxOd?=
 =?iso-8859-1?Q?iPwJUltgu8KrVYtkPUHASdjWvJlrQ/lsEbXIlNKGfFFhLjX8/gN97Es/r9?=
 =?iso-8859-1?Q?49Ui1CohejvmfFsIKp6aYAE2y9NCdylTxfhJfRcy1J7R5PA15OB/nM8cXR?=
 =?iso-8859-1?Q?0HgkFEgDTivFkYGfxguKClN6owVtI+ZkSWOhGQ7WEPlX5m9ceXDwF3k+Fe?=
 =?iso-8859-1?Q?pqSDvq8iVqCg9ISf+1CrfOxmNRrzjkCyyaXrOeLzzc6PvveeeDqOghM5zj?=
 =?iso-8859-1?Q?llcbmR8U/iaHO2NKZYIMqZBEdkdCXS9uKsdp2Hqdqz4jvvHcT8Ykbms0Pp?=
 =?iso-8859-1?Q?D2zMtxql6DfiSPKn0fyNPsNdFYhte5cEaiMuPspVb8TuS6v2ekA+6LZpjf?=
 =?iso-8859-1?Q?i9i84ilX/xDjoPWX2abX/sH7rJ3xj9uUe74QxGc2vB1WYiQTagGens2cR2?=
 =?iso-8859-1?Q?9viJe/LTYM7+MOnXJsuQHOtDoxqD30rD/puANEEFi6ROVdDPal2X1WxqO8?=
 =?iso-8859-1?Q?F+onZg1xrx/olS7HTvofJdwjlYFTwB7fv3Hg5xzlj9FrpQ69xsjZUvFEmF?=
 =?iso-8859-1?Q?E6cyQP8SOYTqebFDoWAF5DTGdHvlu/rusEEawFJ5X42q74HtWznbnbYvIA?=
 =?iso-8859-1?Q?7+4lHnlW0l0KOzK+N5iEQC+MC1rQVqNz2r+h4p8zS4TSp2M8DxExsKyzun?=
 =?iso-8859-1?Q?ZZuQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6025748f-2c82-441a-2aa1-08d9ed699675
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 14:20:00.0308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppmMqv9MlVjLFoi7AV/obdnhyPse7MbPfno1jIZM+kknXkTKM7LiEgMh6cBErnDMbva+fJnV6jEbFm209r/ZUFSSiKC9OwQb3aY6enw+8Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3903
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] lib/safe_file_ops.c: Fix resource leak
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
From: Bogdan Lezhepekov via ltp <ltp@lists.linux.it>
Reply-To: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

safe_file_scanf and safe_file_vprintf suffered
from resource leak, as opened file descriptor
was not closed in case of error.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 lib/safe_file_ops.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/safe_file_ops.c b/lib/safe_file_ops.c
index f803691d8..d7231df4d 100644
--- a/lib/safe_file_ops.c
+++ b/lib/safe_file_ops.c
@@ -130,7 +130,7 @@ void safe_file_scanf(const char *file, const int lineno,
        if (f == NULL) {
                tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
                        "Failed to open FILE '%s' for reading", path);
-               return;
+               goto out;
        }
 
        exp_convs = tst_count_scanf_conversions(fmt);
@@ -142,14 +142,14 @@ void safe_file_scanf(const char *file, const int lineno,
        if (ret == EOF) {
                tst_brkm_(file, lineno, TBROK, cleanup_fn,
                        "The FILE '%s' ended prematurely", path);
-               return;
+               goto out;
        }
 
        if (ret != exp_convs) {
                tst_brkm_(file, lineno, TBROK, cleanup_fn,
                        "Expected %i conversions got %i FILE '%s'",
                        exp_convs, ret, path);
-               return;
+               goto out;
        }
 
        if (fclose(f)) {
@@ -157,6 +157,8 @@ void safe_file_scanf(const char *file, const int lineno,
                        "Failed to close FILE '%s'", path);
                return;
        }
+out:
+       fclose(f);
 }
 
 
@@ -261,13 +263,13 @@ static void safe_file_vprintf(const char *file, const int lineno,
        if (f == NULL) {
                tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
                        "Failed to open FILE '%s' for writing", path);
-               return;
+               goto out;
        }
 
        if (vfprintf(f, fmt, va) < 0) {
                tst_brkm_(file, lineno, TBROK, cleanup_fn,
                        "Failed to print to FILE '%s'", path);
-               return;
+               goto out;
        }
 
        if (fclose(f)) {
@@ -275,6 +277,8 @@ static void safe_file_vprintf(const char *file, const int lineno,
                        "Failed to close FILE '%s'", path);
                return;
        }
+out:
+       fclose(f);
 }
 
 void safe_file_printf(const char *file, const int lineno,
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
