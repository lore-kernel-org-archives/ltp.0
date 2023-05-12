Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4ACC77B7C
	for <ltp@archiver.kernel.org>; Fri, 12 May 2023 07:43:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE7503CD5B0
	for <ltp@archiver.kernel.org>; Fri, 12 May 2023 09:43:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF9553CA0CC
 for <ltp@lists.linux.it>; Fri, 12 May 2023 09:43:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3CA3D600977
 for <ltp@lists.linux.it>; Fri, 12 May 2023 09:43:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F2F72270C;
 Fri, 12 May 2023 07:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683877396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksU5ZKw3Kio2TGZdZRZ7Uxl4HNVyHbnXk7iE+i0ikA8=;
 b=hh5pW3r+I1joUeRXkqHRPrnYH3qBrMVxzyI4wTwKfvq0PcTD1L2arLlGmiv+LRteTOXoPw
 EhAVi04HZ9pcWOeSfyK6WuEO6knUT7pIHTJnk+PftwnMoxwUSj2jN+skChEfyVKYk4dZXm
 Q6Rca7HIlR+lopJ0icGlsmTEmvQUIbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683877396;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksU5ZKw3Kio2TGZdZRZ7Uxl4HNVyHbnXk7iE+i0ikA8=;
 b=MFqkMqwQSrKDO8dNfDKo+Lpd06IUMbANWseBEaEPmL6q5GtRMvruKb5xSCoDvz8zlNw+yv
 3KmacVvImhZHzCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C91413466;
 Fri, 12 May 2023 07:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1rvkDRTuXWSoCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 12 May 2023 07:43:16 +0000
Date: Fri, 12 May 2023 09:43:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Steve Dickson <steved@redhat.com>
Message-ID: <20230512074314.GB30010@pevik>
References: <20230504101619.GA3801922@pevik>
 <76403fb4-87f2-88cb-ab0c-ba63feacbeee@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <76403fb4-87f2-88cb-ab0c-ba63feacbeee@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP: tirpc_rpcb_rmtcall is failing
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
Cc: linux-nfs@vger.kernel.org, ltp@lists.linux.it,
 libtirpc-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Steve,

> Hello Petr,

> On 5/4/23 6:16 AM, Petr Vorel wrote:
> > Hi Steve,

> > tirpc_rpcb_rmtcall is failing. I was able to reproduce it on
> > * openSUSE Tumbleweed with libtirpc 1.3.3
> > * Debian stable  11 (bullseye) with libtirpc 1.3.1-1

> > OTOH SLE 15-SP4 with libtirpc 1.2.6 is working.

> > PATH="/opt/ltp/testcases/bin:$PATH" rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
> > rpc_test 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
> > rpc_test 1 TINFO: add local addr 10.0.0.2/24
> > rpc_test 1 TINFO: add local addr fd00:1:1:1::2/64
> > rpc_test 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
> > rpc_test 1 TINFO: add remote addr 10.0.0.1/24
> > rpc_test 1 TINFO: add remote addr fd00:1:1:1::1/64
> > rpc_test 1 TINFO: Network config (local -- remote):
> > rpc_test 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
> > rpc_test 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
> > rpc_test 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
> > rpc_test 1 TINFO: timeout per run is 0h 5m 0s
> > rpc_test 1 TINFO: check registered RPC with rpcinfo
> > rpc_test 1 TINFO: registered RPC:
> >     program vers proto   port  service
> >      100000    4   tcp    111  portmapper
> >      100000    3   tcp    111  portmapper
> >      100000    2   tcp    111  portmapper
> >      100000    4   udp    111  portmapper
> >      100000    3   udp    111  portmapper
> >      100000    2   udp    111  portmapper
> >      100005    1   udp  20048  mountd
> >      100005    1   tcp  20048  mountd
> >      100005    2   udp  20048  mountd
> >      100005    2   tcp  20048  mountd
> >      100005    3   udp  20048  mountd
> >      100005    3   tcp  20048  mountd
> >      100024    1   udp  37966  status
> >      100024    1   tcp  43643  status
> >      100003    3   tcp   2049  nfs
> >      100003    4   tcp   2049  nfs
> >      100227    3   tcp   2049  nfs_acl
> >      100021    1   udp  59603  nlockmgr
> >      100021    3   udp  59603  nlockmgr
> >      100021    4   udp  59603  nlockmgr
> >      100021    1   tcp  39145  nlockmgr
> >      100021    3   tcp  39145  nlockmgr
> >      100021    4   tcp  39145  nlockmgr
> > rpc_test 1 TINFO: using libtirpc: yes
> > rpc_test 1 TFAIL: tirpc_rpcb_rmtcall 10.0.0.2 536875000 failed unexpectedly
> > 1

> > The problem is in tirpc_rpcb_rmtcall.c [1], which calls rpcb_rmtcall(), which
> > returns 1 (I suppose RPC_CANTENCODEARGS - can't encode arguments - enum
> > clnt_stat from tirpc/rpc/clnt_stat.h):

> > 	cs = rpcb_rmtcall(nconf, argc[1], progNum, VERSNUM, PROCNUM,
> > 			  (xdrproc_t) xdr_int, (char *)&var_snd,
> > 			  (xdrproc_t) xdr_int, (char *)&var_rec, tv, &svcaddr);

> > 	test_status = (cs == RPC_SUCCESS) ? 0 : 1;

> > 	//This last printf gives the result status to the tests suite
> > 	//normally should be 0: test has passed or 1: test has failed
> > 	printf("%d\n", test_status);

> > 	return test_status;

> > Any idea what could be wrong with these very old tests?
> No... No idea... but I'm unable to reproduce it. It appears
> you are using different repo that the one I found on
> github [1]. But...

Thanks a lot for looking into the issue.
BTW on which Fedora/RHEL/CentOS version did you test?

No, I'm also using the official LTP repository on github [1].
And I compile on recent glibc (> 2.32, which removed SUN-RPC) and with libtirpc:

./configure
...
libtirpc: yes
glibc SUN-RPC: no

> Looking code, RPC_CANTENCODEARGS is returned when
> there is an xdr problem which might means a
> memory problem??

> With that said... commits 21718bbb^..fa153d63 did
That was released on 1.3.3, but I'm able to reproduce it on
Debian stable  11 (bullseye) with libtirpc 1.3.1-1.

Kind regards,
Petr

> make a lot of changes in the locking and cache
> management.

> steved.

> [1] https://github.com/linux-test-project/ltp

> > Kind regards,
> > Petr

> > [1] https://github.com/linux-test-project/ltp/blob/12765c115f11026c090ab0ee5dd79b38d95ef31f/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall.c#L91-L93



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
