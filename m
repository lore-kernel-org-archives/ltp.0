Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B768AC433EF
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 09:51:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 533C33C59E8
	for <ltp@archiver.kernel.org>; Wed, 24 Nov 2021 10:51:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0346B3C1DA8
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 10:51:00 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9FF002011D2
 for <ltp@lists.linux.it>; Wed, 24 Nov 2021 10:50:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEE562195F;
 Wed, 24 Nov 2021 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637747458;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VKAsDt3cGsFIU1slYo5uW1AhDNF8fNq8Tl4bXSqCbEM=;
 b=aeYgWIZPYMxYs7m1TlrdlDi+xcanP5RSWVZsR204gFylgFxB3yxj++jj0y7wUOw+g+geMd
 DzC9PZqxjKkgFTn/BByApBWhAszt6T7bQyG61/15AiGic2kXWGAsAR4GTw4bV/KX0vWuSR
 Se2Flp6vI7HO/sEk+jWB+1I4j+bkl8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637747458;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VKAsDt3cGsFIU1slYo5uW1AhDNF8fNq8Tl4bXSqCbEM=;
 b=Qi7YRmBJOdkxP1pQDph2uo5mtZnYQu2fb+3Zzg5+Ski9MhQseHYPeN69CTs5qOJVvY4GYl
 scQFYXHyUjTGCMAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8545F13EFF;
 Wed, 24 Nov 2021 09:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id L1TPHgILnmFiUQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 24 Nov 2021 09:50:58 +0000
Date: Wed, 24 Nov 2021 10:50:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YZ4LAN2RrJntGlFq@pevik>
References: <20211123151537.14913-1-mdoucha@suse.cz>
 <20211123151537.14913-3-mdoucha@suse.cz> <YZ1Dmbh+m6blfLzZ@pevik>
 <9d0f2161-4c10-6318-5a15-470cc12fe76c@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9d0f2161-4c10-6318-5a15-470cc12fe76c@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> > -	echo "-n x    Create x files and x directories, default is 5000"
> > +	echo "-n x    Create x files and x directories, default is $FILE_COUNT"
> >  }

> If you run `nfs07.sh -hn 123`, your version will print that the default
> is 123.

Out of curiosity (as it's not anything important) not sure what's wrong on my
side (I tested it before I suggested it, I also reinstalled LTP to make sure
it's updated), but it works as expected:

# PATH="/opt/ltp/testcases/bin:$PATH" ./nfs07.sh -hn 123
nfs07 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
nfs07 1 TINFO: add local addr 10.0.0.2/24
nfs07 1 TINFO: add local addr fd00:1:1:1::2/64
nfs07 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
nfs07 1 TINFO: add remote addr 10.0.0.1/24
nfs07 1 TINFO: add remote addr fd00:1:1:1::1/64
nfs07 1 TINFO: Network config (local -- remote):
nfs07 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
nfs07 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
nfs07 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
-t x    Socket type, tcp or udp, default is udp
-v x    NFS version, default is '3'
-n x    Create x files and x directories, default is 5000
-h      Prints this help
-i n    Execute test n times

> >  do_setup()
> > @@ -45,7 +45,7 @@ do_test()
> >  {
> >  	local count

> > -	# Pass the list of files through `sort -u` in case `ls` doesn't fitler
> > +	# Pass the list of files through `sort -u` in case `ls` doesn't filter
> >  	# out potential duplicate filenames returned by buggy NFS
> >  	count=`ls | grep '^file' | sort -u | wc -l`

> > @@ -61,7 +61,7 @@ do_test()
> >  		return
> >  	fi

> > -	tst_res TPASS "All files and directories were correctly listed"
> > +	tst_res TPASS "All $FILE_COUNT files and directories were correctly listed"
> >  }

> That would make the line over 80 characters and the number isn't that
> important. Let's fix just the "fitler" typo.
I don't consider 80 as an issue as long as it's not over 100 chars (barier
increased also in mainline checkpatch.pl), but sure, these are really minor
issues, thus agree to fix just the typo.

Waiting little longer if Alexey has any comments and then merge.

Thanks a lot for very useful test case!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
