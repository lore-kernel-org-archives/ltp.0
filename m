Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D15606A31C
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 05:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ip5qTO+j
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3B433E48CB
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 06:49:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 062713E2564
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 06:49:04 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54AB8140045D
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 06:49:02 +0100 (CET)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD5F3qV1900207; Fri, 13 Nov 2026 05:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=cTI6BT
 dk9LbGuQ93Eot5cWt5VbadH5rHhlsYWR4Xguk=; b=ip5qTO+jd6Ft1yl7+tV+xW
 kGumKHgZxH9Tyv9A3HFaMJC3bVhiJh4keJP16RuqgAx2j0ju3c82wnY9fy+5ZMd6
 Kf7fE3r1Tta/jeE/Lw0L0bBVLNC3dWiyAQWm/rzTXhaU9FD2DdjyhfQ0PMtZvD7n
 QdM4PjaGyZaH5Sk7MFJ5t2CJZ9aHfvtY4uwPDuf6EUDvZ38nq5XgbcEKKoWVMiTK
 FGMrcZkACSgomOu1ID9N+aijbAje2/cpOotWnT1KpzGkyHN/SgSHGXOBCsxxWgvc
 Npxmq4Nqd4qk0EIUuU7EQPorXikn7/RMO5vrFlYE6DQ+TuwlsS9pu/s2kTK7xL1w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq7a4tp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2026 05:49:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD5YqgM1832317; Fri, 13 Nov 2026 05:48:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq104kk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Nov 2026 05:48:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AD5mw5L31654426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Nov 2026 05:48:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28E3F58059;
 Fri, 13 Nov 2026 05:48:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD95358017;
 Fri, 13 Nov 2026 05:48:57 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Nov 2026 05:48:57 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 13 Nov 2026 11:18:57 +0530
From: pavrampu <pavrampu@linux.ibm.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
In-Reply-To: <avSp8HV3he2he28I@localhost.localdomain>
References: <20261108062034.41022-1-pavrampu@linux.ibm.com>
 <avSp8HV3he2he28I@localhost.localdomain>
Message-ID: <8a045cf3096d2293c7e35cd001566de6@linux.ibm.com>
X-Sender: pavrampu@linux.ibm.com
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAyMiBTYWx0ZWRfX94DVGtDwti04
 vSx2vLk2sOhrrNNUQT/G72iIE2gBPmGNmDsfMN8F04xsyD2KQiD6N1BQOtZEKV6oGVam6xRb8Nd
 8yvcicB0IJRkbg5Yl/LV4tsXAwd0Z+4=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af6a4cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=v1fWwwfZBqvM63EMcwwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: KoAf_uxYpO2L6sk2cR2d0ktz44d84ugP
X-Proofpoint-GUID: KoAf_uxYpO2L6sk2cR2d0ktz44d84ugP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAyMiBTYWx0ZWRfX4EcnFy0kjiIQ
 Yx57U4dNAjIHtaJTH7rT/cRl6+eCC5sDZEWIMyknrcUUgOL4mTeWJMvePuu974IVYFsgkc1AS6f
 oCEpM6P3vgKaFfIMYWCD/HONzYaihg48oUrRiYh1Z/q28fh8U3jAzfzggdGnKrf9RHZJgRqiQCH
 tsi1VqTIIK8bTgm9uIrgFOqPEl7K39fojVIdWc5UUIgEKWc0qMPYtZVJBGhLomRwPua26vehhSw
 uYb1PKEGtYeO7THJyx91oWwOu2gnaUSFPCbFXnZs7obO3Llz9Z/ZDdJBh1UY6X+pVdVYt1j+GI3
 COPvpIxOEUs11dhoUaSF3CCx7QZ6uo+a+JBwpDEi+TkTBNbUY0k8jA00E5Hn+Vx3YPSTFuNFh6Z
 2pih3ZFnK0k7NZKAra+k8he511WwRLiGnWE+TYlaURVEhyC7W9X1Dw1UNyupLviFeuc25ldbm3o
 IZJCyzO4IOn6an5IK6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130022
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] memcg/memcontrol05: add cgroup v2 task
 migration charge accounting test
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNi0xMS0xMSAyMzoxNywgTWljaGFsIEtvdXRuw70gd3JvdGU6Cj4gSGVsbG8uCj4gCj4g
T24gU3VuLCBOb3YgMDgsIDIwMjYgYXQgMTE6NTA6MzRBTSArMDUzMCwgUGF2aXRocmEKPiA8cGF2
cmFtcHVAbGludXguaWJtLmNvbT4gd3JvdGU6Cj4+IFZlcmlmeSB0aGF0IGluIGNncm91cCB2Miwg
bWVtb3J5IGNoYXJnZXMgcmVtYWluIHBpbm5lZCB0byB0aGUgY2dyb3VwCj4+IHRoYXQgYWxsb2Nh
dGVkIHRoZW0gd2hlbiBhIHRhc2sgbWlncmF0ZXMsIGFuZCB0aGF0IG5ldyBhbGxvY2F0aW9ucyAK
Pj4gYWZ0ZXIKPj4gbWlncmF0aW9uIGFyZSBjaGFyZ2VkIHRvIHRoZSBkZXN0aW5hdGlvbiBjZ3Jv
dXAuCj4gCj4gVGhlIHN0YXRpY25lc3Mgb2YgbWVtb3J5IGNoYXJnZXMgaXMgIm5vbi1mdW5jdGlv
bmFsIiBmZWF0dXJlIG9mIGNncm91cAo+IHYyLiBDb3VsZCB5b3UgZXhwbGFpbiBtb3JlIHRoZSBy
ZWFsIHdvcmQgbW90aXZhdGlvbiBiZWhpbmQgdGhpcyBjYXNlPwo+IAo+IChFYWNoIHN1Y2ggdGVz
dGNhc2UgaXMgc3ViamVjdCB0byBub2lzZSBhbmQgaXQncyBnb29kIHRvIHVuZGVyc3RhbmQKPiB3
aGF0L3doeSBhcmUgdGhlIGV4cGVjdGF0aW9ucy4pCj4gCj4gVGhhbmtzLAo+IE1pY2hhbAoKICBI
aSBNaWNoYWwsCgpUaGFua3MgZm9yIHRoZSBpbnB1dHMsIGJhc2ljYWxseSB0cnlpbmcgdG8gbWln
cmF0ZSAKdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1jdGwvIHRlc3QgdG8gY2dyb3Vw
djIgRGVwZW5kaW5nIG9uIGl0cyAKYXBwbGljYWJpbGl0eSB0byB2Miwgd2UgY2FuIGRldGVybWlu
ZSB3aGV0aGVyIHRvIHByb2NlZWQgd2l0aCB0aGlzIApwYXRjaC4KClRoYW5rcywKUGF2aXRocmEK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
