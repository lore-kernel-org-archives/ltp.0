Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC7C4332F
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 18:40:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84C533CAAE6
	for <ltp@archiver.kernel.org>; Wed,  9 Nov 2022 19:40:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B32203C010E
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 19:40:36 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2AB3A14010CA
 for <ltp@lists.linux.it>; Wed,  9 Nov 2022 19:40:34 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9IaIOI030491;
 Wed, 9 Nov 2022 18:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=4Tk6dZ64cT2JR/I8xRAcVA+2l3UV23hYaS8lCFzWysQ=;
 b=XQ3M+V5FnSb0uPIHsUbLUNlXxiTOwUKIkzQJEyNppUZdqLCvoRQq1DW3S8CSh1c5QmWn
 TrvI7Er5FCTXQOTARdECdlq65O4MBLaiJa7MDi6fsM6vQ4U7v+CZGSpuFre2aIKlhCNd
 SQT1+pFnJQhkmC67+UMtoNmDpUiozEOoxvmB4RCFQS118EqpJ23Wg8hC4PofxRW4nonH
 4uwyK5u2uSdLEiwpD+DOFTKdf7QcZ7hQWvdnl8f9kmR4lKwqYwsl88MxTUm8Q4rzF/G3
 y1g/hPejKrxSnqcrY8xAn247nqvXagiMCU1XC1ihxz5LdK3G/o2Tgmd4LZxGAXY8GeU1 MA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3krfj5bw10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Nov 2022 18:40:32 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9IZQLG031558;
 Wed, 9 Nov 2022 18:40:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma06fra.de.ibm.com with ESMTP id 3kngq8mf5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Nov 2022 18:40:31 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2A9IYgva44958026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 9 Nov 2022 18:34:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4C0242042;
 Wed,  9 Nov 2022 18:40:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA6354203F;
 Wed,  9 Nov 2022 18:40:24 +0000 (GMT)
Received: from tarunpc (unknown [9.43.99.20])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed,  9 Nov 2022 18:40:24 +0000 (GMT)
Date: Thu, 10 Nov 2022 00:10:20 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221109184020.y4wyeli6cegffgby@tarunpc>
References: <20221108195207.232115-1-tsahu@linux.ibm.com>
 <20221108195207.232115-4-tsahu@linux.ibm.com>
 <Y2vS0slepYtvWQBx@yuki>
Content-Disposition: inline
In-Reply-To: <Y2vS0slepYtvWQBx@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yVMyhNAoUt8Ls4JtVKIxNAIlAn45vB9_
X-Proofpoint-GUID: yVMyhNAoUt8Ls4JtVKIxNAIlAn45vB9_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=926
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090140
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/5] Hugetlb: Migrating libhugetlbfs
 fadvise_reserve
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Nov 09 2022, Cyril Hrubis wrote:
Hi,

--skip
> > +
> > +	if (posix_fadvise(fd, 0, hpage_size, POSIX_FADV_WILLNEED) == -1) {
> > +		tst_res(TFAIL|TERRNO, "fadvise()");
> > +		goto cleanup;
> > +	}
> 
> If we follow how SAFE_MACROS() works this should rather be:
> 
> 	if (posix_fadvise(...)
> 		tst_brk(TBROK|TERRNO, "fadvise()");
>
Yes. I am thinking of adding it to tst_safe_macros (SAFE_POSIX_FADVISE).
But there are other tests, that uses it raw
(https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/mincore/mincore04.c).
Was there any reason to not create a SAFE_MACROS for it?

> > +	fadvise_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> > +	tst_res(TINFO, "Reserve count after fadvise: %lu", fadvise_rsvd);
> > -- 
> > 2.31.1
> > 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
