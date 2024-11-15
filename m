Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD648D6DDD2
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 05:10:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F27633D7291
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 06:10:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B3123C62AC
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 06:10:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com;
 receiver=lists.linux.it)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E82146418C1
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 06:10:28 +0100 (CET)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0kHpl015146;
 Fri, 15 Nov 2024 05:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YRUYBk
 Te4kBch3RjQ6hcAX6cCIoUtWoiASLRsd3/EiY=; b=WiVPTPTPu5GtzEC/yVrBdk
 o6nzMj50T0gWArBhpxatatulE0KprOgbZyP/lueE98IS0APHqPvRh0vGJYXJ3ZG5
 xgZuxWbPdWkZks+p0fbY8jykDJsuj4Q+CrFQChbOTaQtduINp7qDL3NEHX9IQrk+
 ZkC95dTwcxrEbuEEFkBvOkxqNFopiGKuj9Iyb/jnBXQCly8SQ2kZT2kCiQ6Zoe1J
 FwaoaLdX2hjBwRgXThzVbVoLRrJZoaJ9MUuBjhomLSxYEX0/Qgfbo/Kmks/4Pctu
 Ec7JQ6fPd0nyMWGvW8Pki4A4wU6uMyqLMDmtZqXMxXvZIVHZJHpHVj/DiIe26V0Q
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc10dc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Nov 2024 05:10:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF41nYt008404;
 Fri, 15 Nov 2024 05:10:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf0f2rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Nov 2024 05:10:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4AF5AOLP49021382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Nov 2024 05:10:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA3B258059;
 Fri, 15 Nov 2024 05:10:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E2CF58065;
 Fri, 15 Nov 2024 05:10:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown
 [9.61.35.114]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Nov 2024 05:10:24 +0000 (GMT)
Message-ID: <219c37a46024eb2c8ae5af342ec26802519f26e7.camel@linux.ibm.com>
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Date: Fri, 15 Nov 2024 00:10:23 -0500
In-Reply-To: <20241101143726.1278291-1-pvorel@suse.cz>
References: <20241101143726.1278291-1-pvorel@suse.cz>
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xRLfgMMeLG_P_f_NwX-hIWoF5TlD9l0x
X-Proofpoint-ORIG-GUID: xRLfgMMeLG_P_f_NwX-hIWoF5TlD9l0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150041
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ima_boot_aggregate: Fix openssl 3.0
 deprecation warnings
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 2024-11-01 at 15:37 +0100, Petr Vorel wrote:
> From the docs:
> https://docs.openssl.org/3.0/man7/migration_guide/#deprecated-low-level-digest-functions
> 
>     Use of low-level digest functions such as SHA1_Init(3) have been
>     informally discouraged from use for a long time. Applications should
>     instead use the high level EVP APIs EVP_DigestInit_ex(3),
>     EVP_DigestUpdate(3) and EVP_DigestFinal_ex(3), or the quick one-shot
>     EVP_Q_digest(3).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Sorry for the long delay in responding.  The patch nicely cleans up all the
warnings.

thanks,

Mimi

> ---
>  .../integrity/ima/src/ima_boot_aggregate.c    | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> index 62468e0d19..68d12fc3c2 100644
> --- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> +++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
> @@ -24,6 +24,7 @@
>  
>  #if HAVE_LIBCRYPTO
>  #include <openssl/sha.h>
> +#include <openssl/evp.h>
>  
>  #define MAX_EVENT_SIZE (1024*1024)
>  #define EVENT_HEADER_SIZE 32
> @@ -61,7 +62,11 @@ static void display_sha1_digest(unsigned char *pcr)
>  static void do_test(void)
>  {
>  	FILE *fp;
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +	EVP_MD_CTX *c = NULL;
> +#else
>  	SHA_CTX c;
> +#endif
>  	int i;
>  
>  	if (!file)
> @@ -85,12 +90,24 @@ static void do_test(void)
>  		}
>  
>  		if (event.header.pcr < NUM_PCRS) {
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +			if ((c = EVP_MD_CTX_new()) == NULL)
> +				tst_brk(TBROK, "can't get new context");
> +
> +			EVP_DigestInit_ex(c, EVP_sha1(), NULL);
> +			EVP_DigestUpdate(c, pcr[event.header.pcr].digest,
> +					 SHA_DIGEST_LENGTH);
> +			EVP_DigestUpdate(c, event.header.digest, SHA_DIGEST_LENGTH);
> +			EVP_DigestFinal_ex(c, pcr[event.header.pcr].digest, NULL);
> +			EVP_MD_CTX_free(c);
> +#else
>  			SHA1_Init(&c);
>  			SHA1_Update(&c, pcr[event.header.pcr].digest,
>  				    SHA_DIGEST_LENGTH);
>  			SHA1_Update(&c, event.header.digest,
>  				    SHA_DIGEST_LENGTH);
>  			SHA1_Final(pcr[event.header.pcr].digest, &c);
> +#endif
>  		}
>  
>  #if MAX_EVENT_DATA_SIZE < USHRT_MAX
> @@ -107,15 +124,30 @@ static void do_test(void)
>  
>  	/* Extend the boot aggregate with the pseudo PCR digest values */
>  	memset(&boot_aggregate, 0, SHA_DIGEST_LENGTH);
> +
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +	EVP_DigestInit_ex(c, EVP_sha1(), NULL);
> +#else
>  	SHA1_Init(&c);
> +#endif
> +
>  	for (i = 0; i < NUM_PCRS; i++) {
>  		if (debug) {
>  			printf("PCR-%2.2x: ", i);
>  			display_sha1_digest(pcr[i].digest);
>  		}
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +		EVP_DigestUpdate(c, pcr[i].digest, SHA_DIGEST_LENGTH);
> +#else
>  		SHA1_Update(&c, pcr[i].digest, SHA_DIGEST_LENGTH);
> +#endif
>  	}
> +
> +#if OPENSSL_VERSION_NUMBER > 0x030000000L
> +	EVP_MD_CTX_free(c);
> +#else
>  	SHA1_Final(boot_aggregate, &c);
> +#endif
>  
>  	printf("sha1:");
>  	display_sha1_digest(boot_aggregate);


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
