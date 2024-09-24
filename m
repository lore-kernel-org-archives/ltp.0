Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C759CF9C6B
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727172961; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fzG5Q650WwqxCqwHfd99lEx6s1Dkl0nsKCOzyKFVt1M=;
 b=RxC2fdUsyMaquzqEzy2kUU4+F9VE4lQ4VSeNRgjjYkAHW6B+sfZ6aRoK6T1fRbFWtWvDp
 QSyALBgAJ2xnnymMMST16v6/fO3CchCRr+ENi2UjOGcDgaPB1LPplGsUYT6hA4VoOtho7Qw
 z3KRJC39OtG0Yx0Vazid3TwhANRYl+c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90EB23C4C66
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 12:16:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E71553C4BF2
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 12:15:40 +0200 (CEST)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 92D371001197
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 12:15:39 +0200 (CEST)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5369f1c7cb8so6744167e87.1
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1727172939; x=1727777739; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbylRXp57+rJq8gVmTu6EoYXzXH+DNHsLfvDS5ongXc=;
 b=arK6q/+rW23HDC0OQPMLxM5WD5jgFo9w8PCJ86rpJjwCvMisIkVQxu9zoXyk68ZkX9
 BT6rXWAjwurymm6nNsUoQfUuRuzwX6yH0CIQkc7UjweFzIZcPSB8teopjuxHN3V/D83a
 8P/lLnXhhP/LeO8YJ4rmPDlVSCtGPvozxiGFI1qY1mdEVaV8QjEhzme2pquvTDbhsavn
 xk0LDY5+OPloufw7CpW2dIkFc5gYA+llwL6adjOGvEKNxwczdV35y6G2iUnOy3iOJ9io
 CAoPRqpi6ZYO/OWUlKunZu4uMc1sZ/FXnwZQDCBYkdyg196gA9VSlPfMPrSVN14Zs8Ug
 N95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727172939; x=1727777739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbylRXp57+rJq8gVmTu6EoYXzXH+DNHsLfvDS5ongXc=;
 b=iouj4tjVUE/CI/naBUaW1pyviFRuunoqTOGdNNuuKE+GNERhcZsGQfI5ACU6oE43w0
 MVnVdWVcvfd2IsGvhUtAd60Q+/fnSNUuE8z2cpIhi9yjtq7KnXpwBz/yzFXAdSUkZW2a
 08kuLm7xuciVyhgPobFs3gLpVRd9vOCtH6WNLjAmJQnzHHpp8y74hkgYkxMz+PyZ8oYh
 SqAyK1l7QIkZoxb4PNitO9dXQBMGGZmFkx3z7UrNmUM1SHsJr3dlbUDuff0Mfya92FF8
 jwU3d2SwkxF2L0WuUNq6tgLBiddLB7u5j4oPwq0MNxu9OttpQbtdBgLeoTZs+KDMjMcq
 MYbA==
X-Gm-Message-State: AOJu0Yy48Y4c2JEutHUE64JTm6v8xEgR68W6KH7UCuLqqkySKBVW7aKX
 JwWuNxgHoOWDc0rVJEwgjaNRY45bE436fbhwI71HLhU3+u8C9VEFbbacX+uopsaPPcNqilQgq8A
 =
X-Google-Smtp-Source: AGHT+IHTFulSy4kVcXglk3bQf0gP7D9d48T8BA6zOs8TuhIPChIf/W/2eM+ByF3zMC0b37VjaOhFVg==
X-Received: by 2002:a05:6512:3c8d:b0:52c:e3bd:c70b with SMTP id
 2adb3069b0e04-536ac2ce398mr7924593e87.1.1727172938621; 
 Tue, 24 Sep 2024 03:15:38 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930c8a98sm67393266b.124.2024.09.24.03.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 03:15:38 -0700 (PDT)
Date: Tue, 24 Sep 2024 06:15:32 -0400
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZvKRRDKH4D8ok8od@wegao>
References: <20240918100344.21316-1-wegao@suse.com>
 <efb8ced2-c2d2-4a1e-9358-e39e7f6b7adc@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <efb8ced2-c2d2-4a1e-9358-e39e7f6b7adc@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_test.sh: Add support for localhost ssh key
 setup
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Sep 18, 2024 at 01:46:30PM +0200, Martin Doucha wrote:
> Hi,
> this kind of configuration should be done by the test runner. LTP should not
> modify global system configuration unless doing so is a key part of the test
> scenario itself.
Will remove ssh configuration part to test runner.
> 
> The test runner can also create an alias for the lftp command so that the
> test can call it using the old name.
Create an alias for lftp not enough since current code use parameter "-nv" which
not supported by lftp so following error will popup:

lftp: invalid option -- 'n'
Try `lftp --help' for more information

> 
> On 18. 09. 24 12:03, Wei Gao via ltp wrote:
> > When RHOST=localhost, ssh@localhost will encounter error since
> > no correct setup for authorized_keys and known_hosts etc.
> > 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >   testcases/lib/tst_test.sh               | 32 +++++++++++++++++++++++++
> >   testcases/network/tcp_cmds/ftp/ftp01.sh | 12 ++++++++--
> >   2 files changed, 42 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > index c19c30b76..6df16bd17 100644
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -784,6 +784,34 @@ tst_run()
> >   	_tst_do_exit
> >   }
> > +_tst_setup_localhost_ssh()
> > +{
> > +	if [ -z "$TST_SSHD_CONFIG" ]; then
> > +		TST_SSHD_CONFIG="/etc/ssh/sshd_config"
> > +	fi
> > +
> > +	if [ -z "$TST_SSH_DIR" ]; then
> > +		TST_SSH_DIR="/root/.ssh/"
> > +	fi
> > +
> > +	if [ ! -e "$TST_SSHD_CONFIG" ]; then
> > +		echo 'PermitRootLogin yes' >$TST_SSHD_CONFIG
> > +	elif [ ! `grep "^PermitRootLogin *yes" $TST_SSHD_CONFIG | wc -l` -gt 0 ]; then
> > +		echo 'PermitRootLogin yes' >>$TST_SSHD_CONFIG
> > +	fi
> > +
> > +	if [ ! -e "$TST_SSH_DIR/id_rsa" ]; then
> > +		ssh-keygen -q -N "" -t rsa -b 4096 -f $TST_SSH_DIR/id_rsa
> > +	fi
> > +
> > +	if [ -e "$TST_SSH_DIR/id_rsa.pub" ]; then
> > +		cat $TST_SSH_DIR/id_rsa.pub >> $TST_SSH_DIR/authorized_keys
> > +		ssh-keyscan -H localhost >> $TST_SSH_DIR/known_hosts
> > +	fi
> > +
> > +	systemctl restart sshd
> > +}
> > +
> >   _tst_run_iterations()
> >   {
> >   	local _tst_i=$TST_ITERATIONS
> > @@ -910,6 +938,10 @@ if [ -z "$TST_NO_DEFAULT_RUN" ]; then
> >   	tst_res TINFO "Running: $(basename $0) $TST_ARGS"
> >   	tst_res TINFO "Tested kernel: $(uname -a)"
> > +	if [ "$TST_NEEDS_LOCALHOST_SSH" = 1 ]; then
> > +		_tst_setup_localhost_ssh
> > +	fi
> > +
> >   	OPTIND=1
> >   	while getopts ":hi:$TST_OPTS" _tst_name $TST_ARGS; do
> > diff --git a/testcases/network/tcp_cmds/ftp/ftp01.sh b/testcases/network/tcp_cmds/ftp/ftp01.sh
> > index 53d1eec53..8ec7f4fca 100755
> > --- a/testcases/network/tcp_cmds/ftp/ftp01.sh
> > +++ b/testcases/network/tcp_cmds/ftp/ftp01.sh
> > @@ -4,13 +4,21 @@
> >   # Copyright (c) 2003 Manoj Iyer <manjo@mail.utexas.edu>
> >   # Copyright (c) 2001 Robbie Williamson <robbiew@us.ibm.com>
> > +TST_SETUP=setup
> >   TST_TESTFUNC=do_test
> >   TST_CNT=4
> >   TST_NEEDS_CMDS='awk ftp'
> >   TST_NEEDS_TMPDIR=1
> > +TST_NEEDS_LOCALHOST_SSH=1
> >   RUSER="${RUSER:-root}"
> >   RHOST="${RHOST:-localhost}"
> > +FTP_CLIENT_CMD="ftp -nv"
> > +
> > +setup()
> > +{
> > +    grep -q 'sles' /etc/os-release && FTP_CLIENT_CMD='lftp'
> > +}
> >   do_test()
> >   {
> > @@ -41,7 +49,7 @@ test_get()
> >               echo cd $TST_NET_DATAROOT
> >               echo get $file
> >               echo quit
> > -        } | ftp -nv $RHOST
> > +        } | $FTP_CLIENT_CMD $RHOST
> >           sum1="$(ls -l $file | awk '{print $5}')"
> >           sum2="$(ls -l $TST_NET_DATAROOT/$file | awk '{print $5}')"
> > @@ -62,7 +70,7 @@ test_put()
> >               echo cd $TST_TMPDIR
> >               echo put $file
> >               echo quit
> > -        } | ftp -nv $RHOST
> > +        } | $FTP_CLIENT_CMD $RHOST
> >           sum1="$(tst_rhost_run -c "sum $TST_TMPDIR/$file" -s | awk '{print $1}')"
> >           sum2="$(sum $TST_NET_DATAROOT/$file | awk '{print $1}')"
> 
> -- 
> Martin Doucha   mdoucha@suse.cz
> SW Quality Engineer
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
