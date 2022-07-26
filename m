Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3DDC43334
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 13:12:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CF3B3C9F6D
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 15:12:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8745F3C9427
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:12:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D9E76011AE
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:12:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 543111FBA0;
 Tue, 26 Jul 2022 13:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658841148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mIV0TqFk+nGTbdOaeNXczfRH2L5f/06eNREkuEEpAfQ=;
 b=ZebgD1fk+Gv0AxgAj8N4t0gyZRBVay90FGt4TU3X5QAAhsFSdyB+z72w+ue8kZY6g1kLuL
 EpelpmmWHdjYYiHcLSUPqTZeS6fRd/XuZO0wfASzstDYEYvnY+hTpZ5VfQdthr24orc7AE
 yw2zpukTSRCIbfH0LIagaNy7F0tQeCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658841148;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mIV0TqFk+nGTbdOaeNXczfRH2L5f/06eNREkuEEpAfQ=;
 b=I8yvRTSnBVMqnFimR528I3hbIXF8O73KxSfc7VVgfAZLXXI4FadYByoC39y9ibkOK02Q46
 8KFThjup6Z89pkDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 252C613A7C;
 Tue, 26 Jul 2022 13:12:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U5+NBzzo32LVFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 13:12:28 +0000
Date: Tue, 26 Jul 2022 15:12:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <Yt/oOuaJU3ExV5f9@pevik>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <d2355625a3b0bd7cac07fc2e80098ca2c59d10b1.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d2355625a3b0bd7cac07fc2e80098ca2c59d10b1.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 10/18] controllers: Expand cgroup_lib shell
 library
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

Hi Luke,

...
> +# Gets the cgroup version of the given controller
> +# USAGE: cgroup_get_version CONTROLLER
> +# RETURNS: "1" if version 1 and "2" if version 2
> +# Must call cgroup_require before calling
> +cgroup_get_version()
>  {
> -	local subsystem=$1
> -	local mntpoint
> +	local ctrl="$1"
> +	local version

> -	[ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem not defined"
> +	[ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller not defined"
NOTE: this will always pass, because you pass variable in ""
(thus $1 = "" and $# = 1):
cgroup_get_task_list()
{
	local ctrl="$1"
	version=$(cgroup_get_version "$ctrl")

> +	[ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version: No previous state found. Forgot to call cgroup_require?"

> -	mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
> -	[ -z "$mntpoint" ] && return 1
> +	version=$(echo "$_cgroup_state" | grep -w "^$ctrl" | awk '{ print $2 }')
> +	[ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could not find controller $ctrl"
> +
> +	echo "$version"

> -	echo $mntpoint
>  	return 0
>  }
...

> +# Mounts and configures the given controller
> +# USAGE: cgroup_require CONTROLLER
> +cgroup_require()
> +{
> +	local ctrl="$1"
> +
> +	[ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not defined"
> +
> +	[ ! -f /proc/cgroups ] && tst_brk TCONF "Kernel does not support control groups"
> +
> +	_cgroup_state=$(tst_cgctl require "$ctrl" $$)
> +
> +	if [ $? -eq 32 ]; then
> +		tst_brk TCONF "'tst_cgctl require' exited. Controller is probably not available?"
> +	fi
> +
> +	if [ $? -ne 0 ]; then
> +		tst_brk TBROK "'tst_cgctl require' exited."
> +	fi
FYI if cgroup_require is called from cleanup function tst_brk does not exit the
code:

tst_brk()
{
	local res=$1
	shift

	if [ "$TST_DO_EXIT" = 1 ]; then
		tst_res TWARN "$@"
		return
	fi

	tst_res "$res" "$@"
	_tst_do_exit
}

IMHO that means that $? became 0 even it was previously 32.
It's always safer to save $? into local variable if needed to store exit code
(otherwise using if, e.g. "if ! foo; then" is preferred).

NOTE: Maybe at this point it might be safer if you post next version
where you do fixes yourself. I'll try to review the rest of the shell scripts
today (C code looks correct to me).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
