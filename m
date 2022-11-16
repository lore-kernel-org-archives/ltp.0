Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455F3C43217
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 16:27:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CA2A3C786C
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 17:26:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3630F3C62EE
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 17:26:46 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 310F81000379
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 17:26:44 +0100 (CET)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AGFRnmi030942; Wed, 16 Nov 2022 16:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=YuxJWF1je0c4RFfyQUhqEYEfQZzo2fKf4HtVD6SlK6k=;
 b=LPsB6o1Y1xDC+SP+kk7wieBUrvKlF6rH+iXZ2jjRJOcXGPtlhQJEv+YPX5rAVAh1edum
 jq7q9VuXbj96XRwHRAOwfCVm9y8y+jUbbF/fkiOy50cxEiIObLNPsHaEN3XFs61soZQF
 y8PhN+mZk5UQqxnRalvy3hsjKbLywG4u1b5iXygV4OlywsG5GATvR8Xh23eWtZTO3pEO
 fZUJChOteCUKR4DZRsX9vGi3cpT31e7YIErn4O8TiqRvKAi/BxvRgcMNXZmSgmpQApgx
 WC2Hgq8iAReeZADPoXz5j+rI9W/kmJKMWE6CNjDMU1EZhSOaYhGDWgxzPGPg1q5plpFG Ag== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw2h6210s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 16:26:42 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGGKtD9005653;
 Wed, 16 Nov 2022 16:26:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma05fra.de.ibm.com with ESMTP id 3kt3494pcb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 16:26:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AGGQb6d64946612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Nov 2022 16:26:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 058674C040;
 Wed, 16 Nov 2022 16:26:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 702244C044;
 Wed, 16 Nov 2022 16:26:34 +0000 (GMT)
Received: from tarunpc (unknown [9.43.26.168])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Nov 2022 16:26:34 +0000 (GMT)
Date: Wed, 16 Nov 2022 21:56:30 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221116162630.fhjoksvrdel5rlzs@tarunpc>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
 <20221116112516.261535-3-tsahu@linux.ibm.com>
 <Y3UDxqM8qvnqRfeT@yuki>
Content-Disposition: inline
In-Reply-To: <Y3UDxqM8qvnqRfeT@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0FUY5PY0IcWVkdZj6V8A0u9wQmW9nUa0
X-Proofpoint-ORIG-GUID: 0FUY5PY0IcWVkdZj6V8A0u9wQmW9nUa0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160112
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/7] Hugetlb: Migrating libhugetlbfs counters
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

Hi, 
Thanks for reviewing the patch, Cyril.
Please find my comments inline.
On Nov 16 2022, Cyril Hrubis wrote:
> Hi!
> > +#define CHECK_(fun)	\
> > +		{			\
> > +		if (fun)	\
> > +			break;	\
> > +	}
> 
> This is working around the tooling we have I would rather have a look
> into the checkpatch script to see if we could tweak the rule rather than
> to introduce this messy code.
> 
> Just submit the patch with sane code and I will check for what I can do
> with the script to get rid of the error.
Ok.

--Skip
> > +static long hpage_size;
> > +
> > +	if (t != et) {
> > +		tst_res(TFAIL, "At Line %i:While %s: Bad "MEMINFO_HPAGE_TOTAL
> > +				" expected %li, actual %li", line, desc, et, t);
> 
> We do have tst_res_() that can be called as:
> 
> 	tst_res_(__FILE__, line,
>                  "%s bad " MEMINFO_HPAGE_TOTAL " = %li expected %li",
> 		 desc, et, t);
Ok. Will update it.
> 
> > +out:
> > +	return verify_counters(line, desc, et, ef, er, es);
> > +}
> > +#define set_nr_hugepages(c, d) CHECK_(set_nr_hugepages_(c, d, __LINE__))
> 
> The macro name should be uppercase so that it's clear that it's a macro
> and not a simple function. With that we can also drop the underscore
> from the actual function name too.
> 
I avoided it deliberately knowing that these macros are being called too
often, keeping them in uppercase would have made the code look too messy.
Then, I looked that there was tst_res and similiar macros too which were
kept in smallcase too (which is wrapper to tst_res_ function), That is why
I kept them smallcase.

--skip
> > +static int test_counters_(char *desc, int base_nr)
> > +{
> > +	int fail = 1;
> > +
> > +	tst_res(TINFO, "%s...", desc);
> > +
> > +	do {
> > +		set_nr_hugepages(base_nr, "initializing hugepages pool");
> > +
> > +		/* untouched, shared mmap */
> > +		map(SL_TEST, 1, MAP_SHARED, "doing mmap shared with no touch");
> > +		unmap(SL_TEST, 1, MAP_SHARED, "doing munmap on shared with no touch");
> > +
> > +		/* untouched, private mmap */
> > +		map(SL_TEST, 1, MAP_PRIVATE, "doing mmap private with no touch");
> > +		unmap(SL_TEST, 1, MAP_PRIVATE, "doing munmap private with on touch");
> > +
> > +		/* touched, shared mmap */
> > +		map(SL_TEST, 1, MAP_SHARED, "doing mmap shared followed by touch");
> > +		touch(SL_TEST, 1, MAP_SHARED, "touching the addr after mmap shared");
> > +		unmap(SL_TEST, 1, MAP_SHARED, "doing munmap shared after touch");
> > +
> > +		/* touched, private mmap */
> > +		map(SL_TEST, 1, MAP_PRIVATE, "doing mmap private followed by touch");
> > +		touch(SL_TEST, 1, MAP_PRIVATE, "touching the addr after mmap private");
> > +		unmap(SL_TEST, 1, MAP_PRIVATE, "doing munmap private after touch");
> > +
> > +		/* Explicit resizing during outstanding surplus */
> > +		/* Consume surplus when growing pool */
> > +		map(SL_TEST, 2, MAP_SHARED, "doing mmap to consume surplus");
> > +		set_nr_hugepages(MAX(base_nr, 1), "setting hugepages pool to consume surplus");
> > +
> > +		/* Add pages once surplus is consumed */
> > +		set_nr_hugepages(MAX(base_nr, 3), "Adding more pages after consuming surplus");
> > +
> > +		/* Release free huge pages first */
> > +		set_nr_hugepages(MAX(base_nr, 2), "Releasing free huge pages");
> > +
> > +		/* When shrinking beyond committed level, increase surplus */
> > +		set_nr_hugepages(base_nr, "increasing surplus counts");
> > +
> > +		/* Upon releasing the reservation, reduce surplus counts */
> > +		unmap(SL_TEST, 2, MAP_SHARED, "reducing surplus counts");
> > +		fail = 0;
> > +	} while (0);
> > +
> > +	if (fail)
> > +		return -1;
> > +	tst_res(TINFO, "OK");
> > +	return 0;
> 
> Maybe it would be a bit nicer to have actually two different macros so
> that we don't have to resort to this do {} while (0) trickery e.g.
> 
> #define CHECK_BREAK(cond) if (cond) break;
> #define CHECK_RETURN(cond) if (cond) return -1;
> 
> #define MAP_BREAK(s, h, f, d) CHECK_BREAK(map(s, h, f, d, __LINE__))
> #define MAP_RETURN(s, h, f, d) CHECK_RETURN(map(s, h, f, d, __LINE__))
> 
> Then the check counters would look much better.
> 
> Or we can just stick to the RETURN variants and put the body of the loop
> in the runtest() function into do_interation() function.
> 
I like the second idea, as it will only have one macro. which will keep the
code less messy. But anyway, I had tried this already, if (cond) return; is
not allowed. "make check" throws warning saying, "Macros with flow control
statements should be avoided". Only way I could see is to use break.
> > +
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
