Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3796CC00528
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 02:42:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C25FD3CE36F
	for <ltp@archiver.kernel.org>; Sat,  5 Aug 2023 04:42:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE1CB3CAB0C
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 04:42:10 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 15A1114001E2
 for <ltp@lists.linux.it>; Sat,  5 Aug 2023 04:42:06 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3752fvoX021456;
 Sat, 5 Aug 2023 10:41:57 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from ubuntu01 (10.0.12.75) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Sat, 5 Aug 2023 10:41:58 +0800
Date: Sat, 5 Aug 2023 02:41:55 +0000
From: Leo Liang <ycliang@andestech.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZM2284WIANaxhmCF@ubuntu01>
References: <20230803103004.2429973-1-ycliang@andestech.com>
 <ZMuEkuWpcIkEN3QP@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZMuEkuWpcIkEN3QP@yuki>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Originating-IP: [10.0.12.75]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3752fvoX021456
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] hugeshmat04: Restore the correct shmmax value
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
Cc: cynthia@andestech.com, patrick@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Thu, Aug 03, 2023 at 12:42:26PM +0200, Cyril Hrubis wrote:
> Hi!
> > Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > ---
> >  testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> > index 50efa8a52..b3e7c272a 100644
> > --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> > +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
> > @@ -83,12 +83,12 @@ static void setup(void)
> >  	long hpage_size, orig_hugepages;
> >  
> >  	orig_hugepages = get_sys_tune("nr_hugepages");
> > -	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &orig_shmmax);
> > -	SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", (long)SIZE);
> > -	SAFE_FILE_SCANF(PATH_SHMMAX, "%ld", &new_shmmax);
> > +	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &orig_shmmax);
> > +	SAFE_FILE_PRINTF(PATH_SHMMAX, "%lu", (long)SIZE);
> > +	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &new_shmmax);
> >  
> >  	if (new_shmmax < SIZE)
> > -		tst_brk(TCONF,	"shmmax too low, have: %ld", new_shmmax);
> > +		tst_brk(TCONF,	"shmmax too low, have: %lu", new_shmmax);
> >  
> >  	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
> >  
> > @@ -99,7 +99,7 @@ static void setup(void)
> >  static void cleanup(void)
> >  {
> >  	if (orig_shmmax != -1)
> > -		SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld", orig_shmmax);
> > +		SAFE_FILE_PRINTF(PATH_SHMMAX, "%lu", orig_shmmax);
> >  }
> 
> Can we please move the PATH_SHMMAX restoration to the .save_restore part
> of the tst_test structure?
> 
> https://github.com/linux-test-project/ltp/wiki/C-Test-API#127-saving--restoring-procsys-values

Thanks for the pointer.
I will send a v2 patch soon!

Best regards,
Leo

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
