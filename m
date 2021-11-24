Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E12C433F5
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 09:27:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EF813C25EC
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 10:27:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E52263C08AA
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 10:27:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 534781001392
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 10:27:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B9BB1FD2F;
 Wed, 24 Nov 2021 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637746044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHnfb0GLw5GNM5LeyTUNMxqhBCPXGsejaSq6cwrJQOQ=;
 b=vj/FCmgt3XMLwCuvfNEDJeu1EpFSotlt6OTs8lWvkggcbA0YAZX9PKApeskSN1sOtvOIEt
 cIDTB3e2SOqqsqbacEMQMlhHZgF6yfMVzu6A5jeMhvaoR1Pc4t3Vc41Ojjr2gHFCK11e/L
 RWLTICGP3bOlDlGi+EWZMa3cSs87zVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637746044;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tHnfb0GLw5GNM5LeyTUNMxqhBCPXGsejaSq6cwrJQOQ=;
 b=3OvIK+M0uYzNMwARkjz6WTnE/ZXRBdIgvLs8pCSqAqQnf58UkqSfTj/VmfGPZCsNOLorv2
 Rvhqd2zE+fjqGlBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52CDD13EC4;
 Wed, 24 Nov 2021 09:27:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yggzE3wFnmFURQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 24 Nov 2021 09:27:24 +0000
Message-ID: <9d0f2161-4c10-6318-5a15-470cc12fe76c@suse.cz>
Date: Wed, 24 Nov 2021 10:27:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20211123151537.14913-1-mdoucha@suse.cz>
 <20211123151537.14913-3-mdoucha@suse.cz> <YZ1Dmbh+m6blfLzZ@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YZ1Dmbh+m6blfLzZ@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] Add test for NFS directory listing
 regression
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

On 23. 11. 21 20:40, Petr Vorel wrote:
> If you agree, I suggest to merge it with these changes:
> 
> diff --git testcases/network/nfs/nfs_stress/nfs07.sh testcases/network/nfs/nfs_stress/nfs07.sh
> index 2c04746fa..e44573405 100755
> --- testcases/network/nfs/nfs_stress/nfs07.sh
> +++ testcases/network/nfs/nfs_stress/nfs07.sh
> @@ -26,7 +26,7 @@ TST_USAGE="show_usage"
>  show_usage()
>  {
>  	nfs_usage
> -	echo "-n x    Create x files and x directories, default is 5000"
> +	echo "-n x    Create x files and x directories, default is $FILE_COUNT"
>  }

If you run `nfs07.sh -hn 123`, your version will print that the default
is 123.

>  
>  do_setup()
> @@ -45,7 +45,7 @@ do_test()
>  {
>  	local count
>  
> -	# Pass the list of files through `sort -u` in case `ls` doesn't fitler
> +	# Pass the list of files through `sort -u` in case `ls` doesn't filter
>  	# out potential duplicate filenames returned by buggy NFS
>  	count=`ls | grep '^file' | sort -u | wc -l`
>  
> @@ -61,7 +61,7 @@ do_test()
>  		return
>  	fi
>  
> -	tst_res TPASS "All files and directories were correctly listed"
> +	tst_res TPASS "All $FILE_COUNT files and directories were correctly listed"
>  }

That would make the line over 80 characters and the number isn't that
important. Let's fix just the "fitler" typo.

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
