Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79719C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 17:35:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E0B43CE0FB
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 18:35:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE7443CDCC0
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 18:35:13 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B600B1A0122D
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 18:35:12 +0100 (CET)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2APHN4IO031291; Fri, 25 Nov 2022 17:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ELG7fmjW8Ypalz6gah65zbTSpwHPQgnCFXDs9ugwWZ4=;
 b=Lsr5adMY9NY63BZHax2ZxfzkYLyZVW3hrUt5Jb0+Wg+HzpM0quGOuzo9jOgA+8hw4qo3
 B12WjoMM9QmTTfgIYn9YwKoqApMZ3WkOUBcJnQkE0yqMHxkmB1S07eOz/XAlG0f3lSn3
 JsILbgnkXWy8f2WSKlmdXWBZBg11wf1tG8hPyAlvjR2lZnuDZfFg1BIwE1gejZbQGPrb
 GlbT08Ulv0AJWcF6EmYZI0O8Hz0O6HwKxU3oDI7nxvAV6SWyzp/veFTeEbNTXxynG33J
 O0KIudP2StuDEe9ObyaZIu8+Hg8f2wOmVMsNV7xOv39JAIZHt0ApYqkWONuWMS7JEpV8 Xg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m3223061u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Nov 2022 17:35:10 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2APHLbwn007949;
 Fri, 25 Nov 2022 17:35:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by ppma01fra.de.ibm.com with ESMTP id 3kxps975hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Nov 2022 17:35:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 2APHZ5SK40501680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Nov 2022 17:35:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 127AD4C04E;
 Fri, 25 Nov 2022 17:35:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 650244C046;
 Fri, 25 Nov 2022 17:35:02 +0000 (GMT)
Received: from tarunpc (unknown [9.43.60.113])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Nov 2022 17:35:02 +0000 (GMT)
Date: Fri, 25 Nov 2022 23:04:59 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20221125173459.cwujma4km7gcd4vq@tarunpc>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
 <20221120191533.164848-5-tsahu@linux.ibm.com>
 <Y39cpPahJWYvQ4cT@yuki>
Content-Disposition: inline
In-Reply-To: <Y39cpPahJWYvQ4cT@yuki>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s1Bf2CzUlkjorfB0U74Hj01S5VlgXG0R
X-Proofpoint-ORIG-GUID: s1Bf2CzUlkjorfB0U74Hj01S5VlgXG0R
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_08,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211250133
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/7] Hugetlb: Safe macro for posix_fadvise call
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

On Nov 24 2022, Cyril Hrubis wrote:
> Hi!
> >  include/tst_safe_macros.h | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> > index 81c4b0844..4965e44d0 100644
> > --- a/include/tst_safe_macros.h
> > +++ b/include/tst_safe_macros.h
> > @@ -298,6 +298,23 @@ static inline int safe_ftruncate(const char *file, const int lineno,
> >  #define SAFE_FTRUNCATE(fd, length) \
> >  	safe_ftruncate(__FILE__, __LINE__, (fd), (length))
> >  
> > +static inline int safe_posix_fadvise(const char *file, const int lineno,
> > +                                int fd, off_t offset, off_t len, int advice)
> > +{
> > +	int rval;
> > +
> > +	rval = posix_fadvise(fd, offset, len, advice);
> > +
> > +	if (rval)
> > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > +			"posix_fadvise(%d,%ld,%ld,%d) failed",
> > +			fd, (long)offset, (long)len, advice);
> 
> I did a closer look at the posix_fadvise() manual and it returns an
> error in case of a failure, so the TERRNO is wrong here since that
> would print whatever was the last error stored in there.
> 
> So we either have to do errno = rval; in the if (rval) branch or use
> tst_strerrno() to print the errno ourselves.
> 
> Looking at the code we have the safe_pthread.c does use tst_strerrno()
> to print the error, so I would be inclined to do so here as well.
> 

posix_fadvise should be inline, and so for the convention it will be part of
tst_safe_macros.h
tst_strerrno is defined in lib/errnos.h

there are only two such header file declared in this way. errnos.h and
signame.h. To be able to use tst_strerrno, it will require some cleanup
(like converting .h to .c and transfer PAIR, STRPAIR macros definition to
header files too from tst_res.c).

As, Even looking at past commits, I am not sure why these two file are
implememnted as .h, and not available as in general. I am currently
thinking of errno = rval way.

Can those file be converted?


> Also LKML coding style prefers curly braces around multiline blocks, so
> I would enclose the multiline tst_brk_() into curly braces, but that is
> very minor.
> 
> > +	return rval;
> > +}
> > +#define SAFE_POSIX_FADVISE(fd, offset, len, advice) \
> > +	safe_posix_fadvise(__FILE__, __LINE__, (fd), (offset), (len), (advice))
> > +
> >  static inline int safe_truncate(const char *file, const int lineno,
> >                                  const char *path, off_t length)
> >  {
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
