Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99427C4332F
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 15:52:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 808193CCEB5
	for <ltp@archiver.kernel.org>; Fri, 18 Nov 2022 16:52:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A4AF3C76CE
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 16:52:11 +0100 (CET)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A09581BC3825
 for <ltp@lists.linux.it>; Fri, 18 Nov 2022 16:52:10 +0100 (CET)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AIE7fpZ029768; Fri, 18 Nov 2022 15:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=SXwhqIAaftuo8sNcAL6uRbJclPuQtaJaKdJIV2dBOS8=;
 b=cvAodgl+ZQYA/e+VPrP8wJyTcSNNcD3CCXhISn91szAP5FL9+PEhGiEPHHr22TTjilTP
 Bx7KRXxwqin5GXEN8V2/RWbDTpujNppjQMIvqlBt0XEq7/MPUw8QvnPeDqr69SqtTFB6
 MdcseOjuKl0FZI8r9RIW3V5TVnTDN8dc7pYDajfpsHN3eANcB6gRQcvFdKjQuZJ5/uxp
 N1pHwZ2H3AZsPqV7uVzcpnxlUgfrh6XEzmH1GuJP9keWx57+LVD4cq8DMjlUYytFYT51
 jusqf16AdNQyHiv5dTJ3mbjclnEJORw/hTKF8z03DBVjwLrWfOIzgMvM3gA5/QXn6PrT bA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kx66kb467-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Nov 2022 15:52:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AIFot9F022075;
 Fri, 18 Nov 2022 15:52:06 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma06ams.nl.ibm.com with ESMTP id 3kwu4yh3p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Nov 2022 15:52:06 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2AIFq3kF39715554
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Nov 2022 15:52:03 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 356AFAE045;
 Fri, 18 Nov 2022 15:52:03 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81C8EAE04D;
 Fri, 18 Nov 2022 15:52:00 +0000 (GMT)
Received: from tarunpc (unknown [9.43.17.26])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 18 Nov 2022 15:52:00 +0000 (GMT)
Message-ID: <690a07c2b82db5356c81ecd36c6d6d91d62b2cd5.camel@linux.ibm.com>
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Nov 2022 21:21:59 +0530
In-Reply-To: <Y3ebLYv5EzkOV/cZ@yuki>
References: <20221116112516.261535-1-tsahu@linux.ibm.com>
 <20221116112516.261535-3-tsahu@linux.ibm.com> <Y3UDxqM8qvnqRfeT@yuki>
 <20221116162630.fhjoksvrdel5rlzs@tarunpc> <Y3ebLYv5EzkOV/cZ@yuki>
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ASKf7GECHm84sFjEt3aLlQllYUzdR_dn
X-Proofpoint-GUID: ASKf7GECHm84sFjEt3aLlQllYUzdR_dn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_02,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0
 mlxlogscore=940 mlxscore=0 clxscore=1015 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180090
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: tsahu@linux.ibm.com
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
Thanks Cyril, for the such a good insights. I will rework on this test.

~Tarun

On Fri, 2022-11-18 at 15:48 +0100, Cyril Hrubis wrote:
> Hi!
> > > > +static long hpage_size;
> > > > +
> > > > +	if (t != et) {
> > > > +		tst_res(TFAIL, "At Line %i:While %s: Bad
> > > > "MEMINFO_HPAGE_TOTAL
> > > > +				" expected %li, actual %li",
> > > > line, desc, et, t);
> > > 
> > > We do have tst_res_() that can be called as:
> > > 
> > > 	tst_res_(__FILE__, line,
> > >                  "%s bad " MEMINFO_HPAGE_TOTAL " = %li expected
> > > %li",
> > > 		 desc, et, t);
> > Ok. Will update it.
> > > > +out:
> > > > +	return verify_counters(line, desc, et, ef, er, es);
> > > > +}
> > > > +#define set_nr_hugepages(c, d) CHECK_(set_nr_hugepages_(c, d,
> > > > __LINE__))
> > > 
> > > The macro name should be uppercase so that it's clear that it's a
> > > macro
> > > and not a simple function. With that we can also drop the
> > > underscore
> > > from the actual function name too.
> > > 
> > I avoided it deliberately knowing that these macros are being
> > called too
> > often, keeping them in uppercase would have made the code look too
> > messy.
> > Then, I looked that there was tst_res and similiar macros too which
> > were
> > kept in smallcase too (which is wrapper to tst_res_ function), That
> > is why
> > I kept them smallcase.
> 
> The whole point why we are going in circles around how to structure
> this
> piece of code is code readibility. Source code is more often read
> than
> written, which means that it's more important to invest into writing
> code that is easily understandable since that will save effort in the
> long term. That is true especially for kernel tests, where there is
> enough complexity in the kernel itself and writing tests that are not
> easy to understand does actually harm.
> 
> There is a key difference between tst_res() defined to tst_res_()
> that
> adds a few parameters and macros that change the codeflow. If there
> are
> macros that change code flow, and perhaps checkpatch is right here
> that
> it's wiser to avoid them at all, they should at least scream in upper
> case letters that this is not a regular function.
> 
> This all boils down to a principle of a least surprise.
> 
> Perhaps the best solution would be to get back to a drawing board and
> figure out how to better structure the test so that the code flow is
> easier to follow.
> 


> > > Maybe it would be a bit nicer to have actually two different
> > > macros so
> > > that we don't have to resort to this do {} while (0) trickery
> > > e.g.
> > > 
> > > #define CHECK_BREAK(cond) if (cond) break;
> > > #define CHECK_RETURN(cond) if (cond) return -1;
> > > 
> > > #define MAP_BREAK(s, h, f, d) CHECK_BREAK(map(s, h, f, d,
> > > __LINE__))
> > > #define MAP_RETURN(s, h, f, d) CHECK_RETURN(map(s, h, f, d,
> > > __LINE__))
> > > 
> > > Then the check counters would look much better.
> > > 
> > > Or we can just stick to the RETURN variants and put the body of
> > > the loop
> > > in the runtest() function into do_interation() function.
> > > 
> > I like the second idea, as it will only have one macro. which will
> > keep the
> > code less messy. But anyway, I had tried this already, if (cond)
> > return; is
> > not allowed. "make check" throws warning saying, "Macros with flow
> > control
> > statements should be avoided". Only way I could see is to use
> > break.
> 
> Again, let's not work around the tooling we have, the tooling is
> supposed to help, once you start bending the code so that the tooling
> is
> happy you are on a wrong path.
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
