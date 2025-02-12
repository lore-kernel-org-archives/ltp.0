Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25715C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 10:20:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 813AE3C99E8
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 11:20:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 933B03C8E63
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 02:08:08 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=yoyang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F2CE61EDA8
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 02:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739322485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hPpev8pGGuMItNXO6iyQ+L0lnktTz9rAognaEBnFAAw=;
 b=LoyBZaaXo/WwnNs3R2Z/yhzGMoRG+6zr1wZqxtlp4X9VA4ILW1XzTPH9Z8XS4/eglNZn7Z
 SmHZXjTx13vaVYx5jooTXuEZqvqMQ6keYMtu9NDYFehpSu4jKfFBEOqIQAFe/nHErvDWWF
 EgZHIqfuOwjDYnOBxPSwgfKYrpuoEHk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-is3uXLIzPk-tC2iNkUbAjA-1; Tue,
 11 Feb 2025 20:08:01 -0500
X-MC-Unique: is3uXLIzPk-tC2iNkUbAjA-1
X-Mimecast-MFC-AGG-ID: is3uXLIzPk-tC2iNkUbAjA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8069319560AA; Wed, 12 Feb 2025 01:08:00 +0000 (UTC)
Received: from dell-per750-06-vm-07.rhts.eng.pek2.redhat.com
 (dell-per750-06-vm-07.rhts.eng.pek2.redhat.com [10.73.180.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F15BB19560A3; Wed, 12 Feb 2025 01:07:56 +0000 (UTC)
Date: Wed, 12 Feb 2025 09:07:51 +0800
From: Yongcheng Yang <yoyang@redhat.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z6v0Z486y3h4IvKC@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
References: <20250211032457.7396-1-liwang@redhat.com>
 <20250211172019.GA1906142@pevik>
MIME-Version: 1.0
In-Reply-To: <20250211172019.GA1906142@pevik>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oGwJAgiS903SjiT4GwTRmC-v0J9--cZM4x8ySD2I4mU_1739322480
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 12 Feb 2025 11:18:57 +0100
Subject: Re: [LTP] [PATCH] statx07: Skip test if NFS server is never enabled
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
Cc: smayhew@redhat.com, Martin Doucha <martin.doucha@suse.com>,
 Yongcheng Yang <yoyang@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

On Tue, Feb 11, 2025 at 06:20:19PM +0100, Petr Vorel wrote:
> Hi Li, all,
> 
> > The statx07 test requires an active NFS server, as it relies on
> > exportfs, which reads from '/var/lib/nfs/etab'. By default, etab
> > file does not exist unless the NFS server is started at least once
> > (since new version nfs-utils-2.5.4-32.el9).
> 
> > This causing the test to fail when etab is missing:
> 
> >   tst_test.c:1722: TINFO: Overall timeout per run is 0h 00m 30s
> >   tst_buffers.c:57: TINFO: Test is using guarded buffers
> >   exportfs: can't open /var/lib/nfs/etab for reading
> >   statx07.c:136: TBROK: failed to exportfs
> 
> > This patch adds a check using access("/var/lib/nfs/etab", F_OK)
> > before running the test. If the file does not exist, the test
> > is skipped (TCONF) instead of failing, preventing misleading
> > test failures.
> 
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Yongcheng Yang <yoyang@redhat.com>
> > ---
> >  testcases/kernel/syscalls/statx/statx07.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> > diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> > index 968174330..bc8e6fd65 100644
> > --- a/testcases/kernel/syscalls/statx/statx07.c
> > +++ b/testcases/kernel/syscalls/statx/statx07.c
> > @@ -115,6 +115,9 @@ static void setup(void)
> >  	int ret;
> >  	char server_path[BUFF_SIZE];
> 
> > +	if (access("/var/lib/nfs/etab", F_OK) < 0)
> > +		tst_brk(TCONF, "nfs-server might not set up");
> 
> On Tumbleweed with nfs-client-2.8.1-44.2.x86_64:
> 
> # systemctl stop nfs-server.service
> # ./statx07
> ...
> tst_test.c:1904: TINFO: Tested kernel: 6.13.0-2.g0127a37-default #1 SMP PREEMPT_DYNAMIC Thu Jan 23 11:21:55 UTC 2025 (0127a37) x86_64
> ...
> statx07.c:141: TCONF: nfs server not set up?: EOPNOTSUPP (95)
> 
> $ ls -la /var/lib/nfs/etab
> 
> The same behavior is on older systems (I checked SLE15-SP4 with 5.14 based
> kernel and nfs-client-2.1.1).
> 
> There is a working detection. I wonder what is different on the system you test.
> OTOH fortunately this patch would not break SLES/openSUSE (it would just not
> help to detect), therefore I'm not against it.

This is for an update of the nfs-utils spec file, see
https://src.fedoraproject.org/rpms/nfs-utils/c/eea36e50024efbac78514f96a29f05306905118b?//branch=rawhide

Now /var/lib/nfs/etab and /var/lib/nfs/rmtab are marked as %config files
and they will not be created when nfs-utils is just installed.

Best Regards,
Yongcheng

> 
> Kind regards,
> Petr
> 
> > +
> >  	mode_t old_umask = umask(0);
> 
> >  	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
