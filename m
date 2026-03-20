Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AE4109193D
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 09:32:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 343563E2B42
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 10:32:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1DC93E180B
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:32:33 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D91431A00CBB
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:32:27 +0100 (CET)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62JKoTOb3709441; Fri, 20 Mar 2026 09:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=NXDE9Wus8If2Qnm4DwDEnAp22B8FPm
 nsXFv3iapkqEE=; b=auGDd3e7FKla3ObAzQqOHDO4Ot68Bp8KcXfgL0JHNZiXx7
 hM+i/1TmxGWlCXT4yOpvVP+fZfa0ymr8/dLiu+FFSJoMJu7VjehXlf6wcmgmwEC5
 Ox9uDzAwTysacDVLrcbEL8O31DV1Lo5D4WOzxZOCTnRbcVJGWBnm9W1eVIigEk7L
 EUupk5NoXZHzKS4nKqj4p2QZXOlcC7UdUBkutmMw8tQbgGUS/YlbmuJn7MgipXRP
 orgGC6KDc8ZiDyDJlKy/zEyMngtYYYbCt708CQvAC1F4b6bVLAp2dvTTllGEzD+s
 vgTp/G1vSzQ2vYGnMK4PBomUdAHNdPmcNof/vuxw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3da1cq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 09:32:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K7CMGl014033;
 Fri, 20 Mar 2026 09:32:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcyennu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 09:32:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62K9WMVW51315132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 09:32:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4F0220040;
 Fri, 20 Mar 2026 09:32:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A0822004E;
 Fri, 20 Mar 2026 09:32:22 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.70.9]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 20 Mar 2026 09:32:22 +0000 (GMT)
Date: Fri, 20 Mar 2026 10:32:20 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ab0UJCvwZrGVp_Lo@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260318111306.98139-1-japo@linux.ibm.com>
 <20260318111306.98139-3-japo@linux.ibm.com>
 <20260318151817.GC31214@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260318151817.GC31214@pevik>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69bd1429 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NLX7q4O0UYb2mT-5HSUA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA3MCBTYWx0ZWRfX8ONSBIQNrS9K
 qEEbiLNLSydHJIT5Y3wax9On+4CcbCH7S0eQ+PPEbDTUS3vIugmU7M5VAmU6CiEAg4gWZf/m/OG
 PSTq8L/7p3ap4HP1QBkL377kwQtcpguDmIk5zTQpBqFh88Fq64uOkygj/96osKKG/1D8iN1S8XC
 /7pYsQXy8vjMM3vPqpCEwgdRfy9SSwUKK0SGfgwpzONn8sBS5ZOJOLyU5+Nw6DkgDCG6hYwNcz7
 Qkcv09wMMly8qsO1QRX78KRmEbYbgdblpu4lnMy6ta9i9hqgxG9OyOJ1he4n6P69Q4LvtUHY1lQ
 2dK8ljPxO16SG/iOPI6RapLK0LqTctYEM1yGYGNCyh7xNEwaBLpWuAri6/Dkf8j44mEUcCTfkMf
 KOUoDTE1m2E8PCP0RkAkM3tMRnwd+Tv8TUt7XX1GrEbkOWEGngqz7k0Yxs3wlaahob24eWYFQt9
 2dF8ry5Qs4UFflc0DYA==
X-Proofpoint-GUID: q4uo5R34-lz7zWG_WI-BKZeO_VN8fzkx
X-Proofpoint-ORIG-GUID: q4uo5R34-lz7zWG_WI-BKZeO_VN8fzkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200070
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] setxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,
> Hi Jan,
>
> > +static bool socket_xattr_supported;
> > +
> >  struct test_case {
> >  	char *fname;
> >  	char *key;
> > @@ -57,7 +60,9 @@ struct test_case {
> >  	int flags;
> >  	int exp_err;
> >  	int needskeyset;
> > +	bool check_xattr;
>
> Maybe more readable would be 'check_kver' (I can change it before merge).
>
> >  };
> > +
> >  static struct test_case tc[] = {
> >  	{			/* case 00, set attr to reg */
> >  	 .fname = FILENAME,
> > @@ -115,6 +120,7 @@ static struct test_case tc[] = {
> >  	 .size = XATTR_TEST_VALUE_SIZE,
> >  	 .flags = XATTR_CREATE,
> >  	 .exp_err = EPERM,
> > +	 .check_xattr = true,
> >  	 },
> >  };
>
> > @@ -126,6 +132,9 @@ static void verify_setxattr(unsigned int i)
> >  				XATTR_CREATE);
> >  	}
>
> > +	if (tc[i].check_xattr && socket_xattr_supported)
> > +		tc[i].exp_err = 0;
> > +
> >  	TEST(setxattr(tc[i].fname, tc[i].key, tc[i].value, tc[i].size,
> >  			tc[i].flags));
>
> > @@ -185,6 +194,8 @@ static void setup(void)
> >  	SAFE_MKNOD(CHR, S_IFCHR | 0777, dev);
> >  	SAFE_MKNOD(BLK, S_IFBLK | 0777, 0);
> >  	SAFE_MKNOD(SOCK, S_IFSOCK | 0777, 0);
> > +
> > +	socket_xattr_supported = (tst_kvercmp(7, 1, 0) >= 0);
>
> Brackets are not needed (not a mistake, but I'll remove it before merge).
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
Thank you very much, I appreciate it!

Kind regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
