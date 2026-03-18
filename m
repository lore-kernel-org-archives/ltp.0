Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25664103E160
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 10:54:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0DE53E58F0
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 11:54:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EB653CEF3D
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:53:51 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 04D7B600BE4
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 11:53:50 +0100 (CET)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HJ0kSK1106118; Wed, 18 Mar 2026 10:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=dxtvJL8gkSmtVdkK9mrrQC19W8smT+
 g9cZI6nqvQ5Wg=; b=LfwyiLvoSiG18vbXM69d7sV5XyqhkXTqqHXxhd785bRDnr
 4kzn1A006RqIMaong6IY08a2zJKxxjIyKgqGOQXzS4nuOE4jzFkxfxGu+cdKpYhB
 +EyvkZkxif/qGGVtaBDN28gnpwaGOmd6iKFESBzrj2KynSxHR1TGpSNlbE4kPcL5
 Bp0+Hm5Ob/BXBkUezehgK6TzdgPMT+zddr9EN5XsUUfG9AILdufGLiLcXujTISPN
 /cZmGglVvobx+4LsnT+OdGrGBke3Dh2qpsMB5AU7etFVCCVU3VMUa6Qs0ruQjvZG
 1Zda/ITmRdz89BdGVOEItK20C+4LRcpT9Qye4Dww==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64skak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 10:53:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I9f8rX028785;
 Wed, 18 Mar 2026 10:53:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkdkfu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 10:53:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62IArjGU47907228
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2026 10:53:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 895AF2004F;
 Wed, 18 Mar 2026 10:53:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7156A20043;
 Wed, 18 Mar 2026 10:53:45 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.52.197.53]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 18 Mar 2026 10:53:45 +0000 (GMT)
Date: Wed, 18 Mar 2026 11:53:44 +0100
From: Jan Polensky <japo@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <abqEODuGuZRMueNm@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260316122725.122719-3-japo@linux.ibm.com>
 <69b9505b.050a0220.133478.afd0@mx.google.com>
 <20260317230137.GB371512@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260317230137.GB371512@pevik>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NyGHARD95gMSEqOllt8-xwsdBC243NT4
X-Proofpoint-GUID: NyGHARD95gMSEqOllt8-xwsdBC243NT4
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69ba843c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=cspqiSWGMBoMU0IM78MA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA5MCBTYWx0ZWRfX5SpDOSaAvvI5
 T2D5FwHtpbLnnPgF5N3OmzhQMJQ5pljf/mnt9AeNAHaTPaPx5Ot+e6TNrReWY4vh8632UHfcfEi
 NaWJr3iUXShRztrKZ+VrHUxyQf/KG6plnOqf5IFDT+aRPtfBN4GLT4Bdx2qradbNs2CTdnp80Gi
 VFPkBk89u3aznk9SyLzJs6Bl50aIM5tx69WuRcCA96Y2Y35P/r7nikiBw/qkxDbg+KheWDg3kt7
 IEZUTSI+FoVYMsfiF79/84QgakNcE6T5EzuhZ1E02Itp41MsAoq/ZxjkGeLJtFoX7mfOnB8vSmh
 6mqvqp38ICUT2GV7q3c8J3lOtyKqBRAuJP+1JIjB3v7bvl1O3PJwDg8pXYH4vj5YTmXHu1RSNQU
 9jd22Jd9rMzazi6FrGHh3bxxe5gOVvC1r78vjyahE2pTcT1PNoc6+sGKQbTmbNto2VxPSTrGsgA
 ZV1T4F6q0/VLBg1/GLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180090
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] setxattr02: Adapt test for kernel 7.1.0+
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

Hi Petr and Andrea,
> Hi Andrea,
> 
> > Hi!
> 
> > Sorry for jumping in a bit late, but...
> 
> > > +static bool socket_xattr_supported;
> > > +
> > >  struct test_case {
> > >  	char *key;
> > > @@ -57,7 +60,16 @@ struct test_case {
> > >  	int flags;
> > >  	int exp_err;
> > >  	int needskeyset;
> > > +	void (*fix_errno)(struct test_case *tc);
> 
> > Honestly I would have preferred a bool flag here instead of a function.
> > The code would have been more readable as:
> 
> > static void verify_setxattr(unsigned int i)
> > {
> > ..
> >     if (tc[i].check_xattr && socket_xattr_supported)
> >         tc->exp_err = 0;
> > ..
> > }
> 
> > And only 1 testcase would have been touched with `.check_xattr = 1`.
> 
> OK, this is slightly simpler.
> 
[snip]
Yes, it's simpler. The `make check` command is a good thing, thanks for
pointing it out. I see what you mean.

I'll send v4 soon.

Kind regards,
Jan

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
