Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE1BC4332F
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 05:33:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D7713CD01F
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 06:33:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F29B3CD014
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 06:32:54 +0100 (CET)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 374E8600879
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 06:32:52 +0100 (CET)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AG50M67021998; Wed, 16 Nov 2022 05:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=liOeGKoA5Rer0VXDknc9qGulI3qve/4oimnw6Y35Mtk=;
 b=RN9kfQnh0U+vlKm475j4uYYLsY6sxZmx/aGjFJFIPnHgm1FyAi2BadZe8iCrgCdaAyWn
 icHS4h9cCr1XzieSaYDb/G4mG6mJCIFeSK8I+EcXdugKFkmNDj3IgI+4R3OgmiXOcmGL
 Xyaeau5YlliPP11ffznSj3SX9A2yLI8EIRNOYpZXsDi0kzWK7ojKDZPuhNlmYL3vDn4T
 rz1ehjvNyCYPAU+VbG8MnyIIHp9nReWRCdvJyAT88mzSBY/siHmQCIMMnSVfDsU6CZnq
 sGbwpSCy2Lkq165GPkZzj1Qxe/gK4h4xrYK4qpIrC2GZnRmUsOSr8XnhDCcRGsevQFj0 +w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kvsb80mku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 05:32:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AG5Lm8n015509;
 Wed, 16 Nov 2022 05:32:49 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 3kt348wbcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Nov 2022 05:32:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 2AG5QkZK25297264
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Nov 2022 05:26:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E72DA42042;
 Wed, 16 Nov 2022 05:32:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ACDF4203F;
 Wed, 16 Nov 2022 05:32:44 +0000 (GMT)
Received: from tarunpc.in.ibm.com (unknown [9.199.157.25])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 16 Nov 2022 05:32:44 +0000 (GMT)
Date: Wed, 16 Nov 2022 11:02:41 +0530
From: Tarun Sahu <tsahu@linux.ibm.com>
To: ltp@lists.linux.it
Message-ID: <20221116053241.rsqj3cirimaoq3mx@tarunpc.in.ibm.com>
References: <20221115070752.244461-1-tsahu@linux.ibm.com>
 <20221115070752.244461-2-tsahu@linux.ibm.com>
Content-Disposition: inline
In-Reply-To: <20221115070752.244461-2-tsahu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _Il5HBJQ1ms1Zg1kzLv-rSP_fsLn_waO
X-Proofpoint-GUID: _Il5HBJQ1ms1Zg1kzLv-rSP_fsLn_waO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160036
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/7] Hugetlb: Add new argument flags in
 tst_creat_unlinked
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
Cc: aneesh.kumar@linux.ibm.com, mike.kravetz@oracle.com, sbhat@linux.ibm.com,
 geetika@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Nov 15 2022, Tarun Sahu wrote:
> Some test requires custom flags along with O_CREAT|O_EXCL|O_RDWR.
> This patch creates support to pass custom flags in tst_creat_unlinked.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  include/tst_test.h                            |  2 +-
>  lib/tst_test.c                                | 22 ++++++++++++++-----
>  .../kernel/mem/hugetlb/hugemmap/hugemmap07.c  |  2 +-
>  .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  2 +-
>  .../kernel/mem/hugetlb/hugemmap/hugemmap09.c  |  2 +-
>  5 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index acf2421de..a62515bfe 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -365,7 +365,7 @@ void tst_set_max_runtime(int max_runtime);
>   * Create and open a random file inside the given dir path.
>   * It unlinks the file after opening and return file descriptor.
>   */
> -int tst_creat_unlinked(const char *path);
> +int tst_creat_unlinked(const char *path, int flags);
>  
>  /*
>   * Returns path to the test temporary directory in a newly allocated buffer.
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index b225ba082..6adb4c3a4 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1027,18 +1027,30 @@ static void prepare_and_mount_hugetlb_fs(void)
>  	mntpoint_mounted = 1;
>  }
>  
> -int tst_creat_unlinked(const char *path)
> +int tst_creat_unlinked(const char *path, int flags)
>  {
>  	char template[PATH_MAX];
> +	int len, c, range;
>  	int fd;
> +	int start[3] = {'0', 'a', 'A'};
>  
>  	snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
>  			path, tid);
> +	len = strlen(template) - 1;
> +
> +retry:
> +	srand(time(NULL));
> +	while (template[len] == 'X') {
> +		c = rand() % 3;
> +		range = start[c] == '0' ? 10 : 26;
> +		c = start[c] + (rand() % range);
> +		template[len--] = (char)c;
> +	}
> +	if (access(template, F_OK) == 0)
> +		goto retry;
>  
There is mistake, with retry. template will not have any XXXXXX.
I will update it next version.

> -	fd = mkstemp(template);
> -	if (fd < 0)
> -		tst_brk(TBROK | TERRNO, "mkstemp(%s) failed", template);
> -
> +	flags |= O_CREAT|O_EXCL|O_RDWR;
> +	fd = SAFE_OPEN(template, flags);
>  	SAFE_UNLINK(template);
>  	return fd;
>  }
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> index bd0fb440a..3122d5b9d 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap07.c
> @@ -113,7 +113,7 @@ cleanup:
>  static void setup(void)
>  {
>  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> -	huge_fd = tst_creat_unlinked(MNTPOINT);
> +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
>  }
>  
>  static void cleanup(void)
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> index ce40e7b69..f66b331dc 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> @@ -118,7 +118,7 @@ static void run_test(unsigned int test_type)
>  static void setup(void)
>  {
>  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> -	huge_fd = tst_creat_unlinked(MNTPOINT);
> +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
>  }
>  
>  static void cleanup(void)
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> index 1008395a4..ceb0f64a1 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap09.c
> @@ -60,7 +60,7 @@ static void run_test(void)
>  static void setup(void)
>  {
>  	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> -	huge_fd = tst_creat_unlinked(MNTPOINT);
> +	huge_fd = tst_creat_unlinked(MNTPOINT, 0);
>  }
>  
>  static void cleanup(void)
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
