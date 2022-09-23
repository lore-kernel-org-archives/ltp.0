Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EA6C6FA91
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 15:21:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11AAC3CAD92
	for <ltp@archiver.kernel.org>; Fri, 23 Sep 2022 17:21:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 043E93CAAA6
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 17:21:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CF8A86024B1
 for <ltp@lists.linux.it>; Fri, 23 Sep 2022 17:21:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CB2C1F895;
 Fri, 23 Sep 2022 15:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663946464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bn2jIsOtFsaU3NVg73kTM7vcgbNmy8VWPU8mGlLCaBw=;
 b=aXEQ+eLLYdTWE8WK8xpAHJTU2KtuRY1PWBkW87QHjLlxA4VfD81JnsZDDsrsaA42GPYUhB
 OrkemufUQ/COY9ZiTXJ3eKEm+x2BLM6A3qk6308dxizrAlqk4Y/eI0W1C9S6xVn1y4hr+o
 HW4zpjzlFGCeY5N8Oroya2oKNXTR9e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663946464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bn2jIsOtFsaU3NVg73kTM7vcgbNmy8VWPU8mGlLCaBw=;
 b=Hr68TOvpS7IQMh5dnsDJqOVfZxtCtFFRUOHB2mcuHHCGmFDyE8aNQaEpr40A/Zk+mWfJD7
 R8PwNRwxfAOITICg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBD3813AA5;
 Fri, 23 Sep 2022 15:21:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EDueON/OLWMIOgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 23 Sep 2022 15:21:03 +0000
Date: Fri, 23 Sep 2022 17:23:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yy3PVQCjVuVJjqwt@yuki>
References: <20220922210931.23982-1-pvorel@suse.cz>
 <20220922210931.23982-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220922210931.23982-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3 v2] tst_supported_fs: Unify messaging
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

Hi!
> +#define err(...) ({ \
> +	fprintf(stderr, __VA_ARGS__); \
> +	fprintf(stderr, "\n"); \
> +	usage(); \
> +	return 2; })
           ^
This should rather be exit(2);

It's only matter of time until someone uses that in a function outside
of main.

> +#define fail(...) ({ \
> +	fprintf(stderr, __VA_ARGS__); \
> +	fprintf(stderr, "\n"); \
> +	return 1; })

Here as well.

> +#define info(...) ({ \
> +	fprintf(stderr, __VA_ARGS__); \
> +	fprintf(stderr, "\n"); \
> +	return 0; })

The naming here is a bit of strange, I wouldn't expect that function
called info() would exit the process.

Maybe these three should include exit in the function name such as
info_exit(), err_exit() and fail_exit().

>  static void usage(void)
>  {
>  	fprintf(stderr, "Usage:\n");
> @@ -90,67 +106,50 @@ int main(int argc, char *argv[])
>  			break;
>  
>  		case 'd':
> -			if (fsname) {
> -				fprintf(stderr,
> -					"Can't specify multiple paths\n");
> -				usage();
> -				return 2;
> -			}
> +			if (fsname)
> +				err("Can't specify multiple paths");
>  
>  			fsname = tst_fs_type_name(tst_fs_type(optarg));
>  			break;
>  		}
>  	}
>  
> -	if (fsname && !skiplist) {
> -		fprintf(stderr, "Parameter -d requires skiplist\n");
> -		usage();
> -		return 2;
> -	}
> +	if (fsname && !skiplist)
> +		err("Parameter -d requires skiplist");
>  
> -	if (argc - optind > 1) {
> -		fprintf(stderr, "Can't specify multiple fs_type\n");
> -		usage();
> -		return 2;
> -	}
> +	if (argc - optind > 1)
> +		err("Can't specify multiple fs_type");
>  
>  	/* fs_type */
>  	if (optind < argc) {
> -		if (fsname) {
> -			fprintf(stderr, "Can't specify fs_type and -d together\n");
> -			usage();
> -			return 2;
> -		}
> +		if (fsname)
> +			err("Can't specify fs_type and -d together");
>  
>  		fsname = argv[optind];
>  	}
>  
>  	if (fsname) {
>  		if (fsname[0] == '\0')
> -			tst_brk(TCONF, "fs_type is empty");
> +			err("fs_type is empty");
>  
>  		if (skiplist) {
>  			if (tst_fs_in_skiplist(fsname, (const char * const*)skiplist))
> -				tst_brk(TCONF, "%s is skipped", fsname);
> -			else
> -				tst_res(TINFO, "%s is not skipped", fsname);
> +				fail("%s is skipped", fsname);
>  
> -			return 0;
> +			info("%s is not skipped", fsname);
>  		}
>  
>  		if (tst_fs_is_supported(fsname) == TST_FS_UNSUPPORTED)
> -			tst_brk(TCONF, "%s is not supported", fsname);
> -		else
> -			tst_res(TINFO, "%s is supported", fsname);
> +			fail("%s is not supported", fsname);
>  
> -		return 0;
> +		info("%s is supported", fsname);
>  	}
>  
>  	/* all filesystems */
>  	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);
>  
>  	if (!filesystems[0])
> -		tst_brk(TCONF, "There are no supported filesystems or all skipped");
> +		fail("There are no supported filesystems or all skipped");
>  
>  	for (i = 0; filesystems[i]; i++)
>  		printf("%s\n", filesystems[i]);
> -- 
> 2.37.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
