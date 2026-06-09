Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E5CCD8CA4
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:18:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 615EC3E6F24
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 16:18:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81D863C888C
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 16:17:58 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B98311000966
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 16:17:54 +0200 (CEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597v8DL139779; Tue, 9 Jun 2026 14:17:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=foMX+ruVPI971+TbYF1jmRF+QRkaZh
 UYXy7VoVdDWVI=; b=Y9iwgd7J8DSlhlmhXQ1feNN6PyOpNmleN9xD7Fh5z1tSDY
 aMHQsF1i3Bab4dtB4A1c7fT+WmPCcWWEyj3myaQAXyWiPVUYwwTEqeePEwQN/V0K
 dpVcXF95J1yfoJBjP5+Xjrl4VDSHwnCZzvOmzMSN8HCyx+pMf3q8P3kXBuH+9Wzu
 ux0/otWuuRMXeMJNiY95EMlfTjjGQVm0R8/fPZ/WG2dW1Lc3/IvLW2KaRavbk++n
 egEPgtbrWxZm5UByYSDxUfqgticUxkGTQOF82PbyEYp/Rh0W42CaMASV14XsPpbN
 ka8yCaJpDiNbAwqxAGT1znjcI0OMibwlnauCBrGQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23vm3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 14:17:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659E4kxl015485;
 Tue, 9 Jun 2026 14:17:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jya328-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 14:17:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 659EHmgl37421472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 14:17:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E58EA20043;
 Tue,  9 Jun 2026 14:17:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A14E420040;
 Tue,  9 Jun 2026 14:17:48 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.111.52.46]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  9 Jun 2026 14:17:48 +0000 (GMT)
Date: Tue, 9 Jun 2026 16:17:47 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aiggi35F7Iz0dMPN@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20260608155241.270875-1-japo@linux.ibm.com>
 <aifalyMdDVoFT3Tg@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aifalyMdDVoFT3Tg@yuki.lan>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a282090 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=DItb2DfyHIxjeLRjZJQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Ubl1IPEfSDbmWi0oKHiFYjw9pwa_4Bh_
X-Proofpoint-GUID: Ubl1IPEfSDbmWi0oKHiFYjw9pwa_4Bh_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzNCBTYWx0ZWRfX1AxsdcO9hNwe
 mb71FH+GFzjWsrXj/Gn9JpmWevIjmnIUaZyiSXQeNrTCVTSC+FQa8lVxOyRfUuzDiIeuHGAI/jx
 nqb9L6TeikXyGOTognVs2Q9TRhj/MSj0cBztQ4JfZC8yvzZa+StySZXqMruRX2crchUt5SIgtFu
 ZfsyDyu70GEe0wsmE8+ELHcGeXehvNbfVWYHECKexWe+t6MypOWrNvXt6kFB36Acv7GdkflFOya
 nEC68eWsWgfZsRKIY2UQr+XDuXfsW/ny2BUc14ejVxftzIgdLGuzPfQxWp5mJAkH55pdJr3/L6x
 /4pguONnfpl69Q9dxbK3A0EMUrz3Mbgb6vrMQUF5JujZU2tXZLB2bQ74K1iUNP1ve3aQ9XFT7BE
 hRuqi+3+drnDXhW0Oirb36GOo9xUyOUKNTwR9qGpdXlGrbq+QSPJMAPdP7jWBMxDmfcGPE4PnBC
 PUow6bE4zWn+sw0+31Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090134
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 09, 2026 at 11:19:19AM +0200, Cyril Hrubis wrote:
> Hi!
> > exfat, like XFS, requires actual data writes (not just fallocate) to
> > fully allocate swap files. Without this, swapon(2) fails with EINVAL
> > due to unallocated extents.
> >
> > This matches the kernel's requirement that swap files must be fully
> > allocated before activation.
> >
> > Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> > ---
> >  libs/swap/tse_swap.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/libs/swap/tse_swap.c b/libs/swap/tse_swap.c
> > index ae3c193132e6..e321cb1dfe63 100644
> > --- a/libs/swap/tse_swap.c
> > +++ b/libs/swap/tse_swap.c
> > @@ -177,8 +177,9 @@ int make_swapfile(const char *file, const int lineno,
> >  	if (prealloc_contiguous_file(swapfile, blk_size, blocks) != 0)
> >  		tst_brk_(file, lineno, TBROK, "Failed to create swapfile");
> >
> > -	/* Fill the file if needed (specific to old xfs filesystems) */
> > -	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
> > +	/* Fill the file if needed (specific to xfs and exfat filesystems) */
> > +	long fs_type = tst_fs_type(swapfile);
> > +	if (fs_type == TST_XFS_MAGIC || fs_type == TST_EXFAT_MAGIC) {
> >  		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
> >  			tst_brk_(file, lineno, TBROK, "Failed to fill swapfile");
> >  	}
>
Hi Cyril,
> The swapon01 works for me for exfat without this change. Where does this
> fail (arch, kernel, OS, is exfat in kernel or FUSE, etc.)?

The failure occurred on:
 - Architecture: s390x
 - Kernel: 7.1.0-20260608.rc7.git374.a87737435cfa.300.fc44.s390x+next
   (linux-next and since ~ 17 days)
 - OS: Fedora Linux 44
 - exfat: Kernel module (not FUSE)

The issue manifests when swapon(2) is called on an exfat swap file that was
created using only fallocate() without actual data writes. The kernel rejects
the swap file with EINVAL because it detects unallocated extents.

This is similar to the existing XFS behavior where tst_fill_file() is already
required. Both filesystems need actual data writes (not just metadata
allocation via fallocate) to ensure swap files are fully allocated before
swapon(2) can activate them.

The patch ensures consistent behavior across filesystems that have this
requirement.

Best regards,
Jan
>
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
