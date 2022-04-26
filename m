Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860FFC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 14:48:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A73963CA478
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 16:48:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 906263C9817
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 16:48:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B415D1A00895
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 16:48:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C38B2210F3;
 Tue, 26 Apr 2022 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650984514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCPBGzZ9FtRbio955/sN321UCx1vuPGox0cSEKD/MeA=;
 b=odVm4ohkoR4McdXMfK5cJIIUlVGxWF6hqmTTGC10DpWDE/pEcF0q4hVBE4jvtc1f1N4umG
 wHCuIuOyDnLomIDuuVj5qGogiOEcqXGCUd31PYX2Dnx+Mi0a/5k1UL7NXs7Jkb5Hkokx0d
 xulQSLN4mERMMdZ0BRTo2QnsGewSapk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650984514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sCPBGzZ9FtRbio955/sN321UCx1vuPGox0cSEKD/MeA=;
 b=NsJtrrHwunb+4mkTv5Eeuve+JQchkp+O8ttqYSjrrW3zuDVho6sLxs0drTqnMP7exqCCX0
 QNfwPZEOD/vVj0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE4F413AD5;
 Tue, 26 Apr 2022 14:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vyVMKUIGaGKHVAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 26 Apr 2022 14:48:34 +0000
Message-ID: <904cab2b-df70-4c99-c975-b3132ff5a4c4@suse.cz>
Date: Tue, 26 Apr 2022 16:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20220422144141.16848-1-pvorel@suse.cz>
 <20220422144141.16848-5-pvorel@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220422144141.16848-5-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] doc: Update shell API examples
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
looks good, small nit below.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 22. 04. 22 16:41, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * Updates related to 1st and 2nd commit.
> 
>  doc/library-api-writing-guidelines.txt | 11 +++++++----
>  doc/shell-test-api.txt                 |  8 ++++++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/library-api-writing-guidelines.txt b/doc/library-api-writing-guidelines.txt
> index 9e926e9713..06b617e693 100644
> --- a/doc/library-api-writing-guidelines.txt
> +++ b/doc/library-api-writing-guidelines.txt
> @@ -67,17 +67,20 @@ Changes in the shell API should not introduce uncommon dependencies
>  
>  Besides shell API libraries in 'testcases/lib' it's worth to put common code
>  for particular tests into shell library. The filename should end '_lib.sh',
> -they should load 'tst_test.sh' or 'tst_net.sh'.
> +they should load 'tst_test.sh' or 'tst_net.sh' at the end of the file.
>  
>  Shell libraries should have conditional expansion for 'TST_SETUP' or 'TST_CLEANUP',
>  to avoid surprises when test specific setup/cleanup function is redefined by
> -shell library.
> +shell library. Although there is not an optimal general solution because
> +usually test which have specific setup/cleanup also needs to call library
> +setup/cleanup, but it's better not to require 'TST_SETUP' or 'TST_CLEANUP' to
> +be on specific place.

When you've started the sentence with "although", the "but" doesn't
belong there. On the last line, "at a specific position" would be better.

>  
>  [source,sh]
>  -------------------------------------------------------------------------------
>  # ipsec_lib.sh
>  # SPDX-License-Identifier: GPL-2.0-or-later
> -TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
> -. tst_test.sh
> +TST_SETUP="${TST_SETUP:-ipsec_lib_setup}"
>  ...
> +. tst_test.sh
>  -------------------------------------------------------------------------------
> diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
> index 4c16f36250..df5ebbdf0d 100644
> --- a/doc/shell-test-api.txt
> +++ b/doc/shell-test-api.txt
> @@ -40,6 +40,7 @@ do_test()
>  	fi
>  }
>  
> +. tst_test.sh
>  tst_run
>  -------------------------------------------------------------------------------
>  
> @@ -90,6 +91,7 @@ test2()
>  	tst_res TPASS "Test $1 passed"
>  }
>  
> +. tst_test.sh
>  tst_run
>  # output:
>  # foo 1 TPASS: Test 1 passed
> @@ -118,6 +120,7 @@ do_test()
>  	esac
>  }
>  
> +. tst_test.sh
>  tst_run
>  # output:
>  # foo 1 TPASS: Test 1 passed
> @@ -145,6 +148,7 @@ do_test()
>  	tst_res TPASS "Test $1 passed with data '$2'"
>  }
>  
> +. tst_test.sh
>  tst_run
>  # output:
>  # foo 1 TPASS: Test 1 passed with data 'foo'
> @@ -174,6 +178,7 @@ do_test()
>  	esac
>  }
>  
> +. tst_test.sh
>  tst_run
>  # output:
>  # foo 1 TPASS: Test 1 passed with data 'foo'
> @@ -278,6 +283,7 @@ do_test()
>  	...
>  }
>  
> +. tst_test.sh
>  tst_run
>  -------------------------------------------------------------------------------
>  
> @@ -337,6 +343,7 @@ do_test()
>  	...
>  }
>  
> +. tst_test.sh
>  tst_run
>  -------------------------------------------------------------------------------
>  
> @@ -379,6 +386,7 @@ do_test()
>  	...
>  }
>  
> +. tst_test.sh
>  tst_run
>  -------------------------------------------------------------------------------
>  


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
