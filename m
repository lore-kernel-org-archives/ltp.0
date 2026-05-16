Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D29ECD4851
	for <ltp@archiver.kernel.org>; Sat, 16 May 2026 05:00:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2E6A3E1F3D
	for <ltp@archiver.kernel.org>; Sat, 16 May 2026 07:00:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E0673D69E8
 for <ltp@lists.linux.it>; Sat, 16 May 2026 07:00:37 +0200 (CEST)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F7956007B6
 for <ltp@lists.linux.it>; Sat, 16 May 2026 07:00:36 +0200 (CEST)
Date: Sat, 16 May 2026 13:00:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1778907635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XseSm80x9AD73AaQRClSNnUoXOXvp37gZaoRd35zkQg=;
 b=K9owzOiUHQERxoxe7HD0FO93Oo1Ellz5THL3CfCsCVm50QpnVHdm59gpggJaRhsPF4E6Op
 CTp6oqOiXyMXAbofixl71CvckeaBEMY5nzbGBEDUXrW5BQuq1uLITq4Z5umv2X7sKKVEw1
 /L9r4U3p4DO+Wcv13pwvzj+NckoDrMk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <agf53mSShy735Whu@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260505083016.36843-1-li.wang@linux.dev>
 <20260515155814.GB45497@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260515155814.GB45497@pevik>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: Introduce tst_path_macros.h to
 consolidate system paths
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

Petr Vorel wrote:

> Hi Li,
> 
> could you please rebase to master and push branch to your fork?
> Patch now does not apply:

Sure, rebased and pushed to my fork:
 https://github.com/wangli5665/ltp/tree/tst_path_defs

> I suppose metadata will work with it correctly since Cyril's support for macros
> in past (i.e. metadata/ltp.json will have "/proc/sys/kernel/hostname", not
> PATH_HOSTNAME, which tells nothing to LTP users).

Oh, I didn't realized this, seems the ltp.json contains define words:

# cat metadata/ltp.json |grep PATH_
     "PATH_MAX_USER_NAMESPACES",
     "PATH_MAX_USER_NAMESPACES",
     "PATH_MAX_USER_NAMESPACES",
     "PATH_MAX_USER_NAMESPACES",
     "PATH_UNPRIVILEGED_USERNS_CLONE",
     "PATH_MAX_USER_NAMESPACES",
     "PATH_UNPRIVILEGED_USERNS_CLONE",
     "PATH_VM_OVERCOMMIT_HPAGES",
     "PATH_VM_OVERCOMMIT_HPAGES",
     ...

I can change them back to the original types (for ltp.json) in a separate patch.

> I slightly prefer the previous name tst_path.h (for me macros are complex
> functions, not just simple definitions, what info gives me "macro-only content"?
> I care more about the actual content). I'm ok with it current name, but maybe
> kernel_paths.h or proc_sys_paths.h would be more obvious which paths is it
> about. Also, it's not just about paths, but also about the content in these
> /proc|sys files (e.g. "HugePages_Total:").

Yes, I'm also hesitant about the naming. The tst_ prefix is needed since it will
be placed in the include/ directory and used across the entire project. proc_ or
sys_ sounds a bit too narrow in scope. Maybe:

  tst_path_defs.h
  tst_sys_paths.h

I'm now leaning towards tst_path_defs.h. WDYT?

> 
> >     	* Replaced generic string concatenation macros with explicit.
> >     	* Manualy built & Tested all touched tests on my c10s vm.
> 
> ...
> 
> > +/* KERNEL */
> > +#define PATH_HOSTNAME			"/proc/sys/kernel/hostname"
> > +#define PATH_OSRELEASE			"/proc/sys/kernel/osrelease"
> ...
> > +/* USER */
> > +#define PATH_MAX_USER_NAMESPACES	"/proc/sys/user/max_user_namespaces"
> 
> I have 2 concerns:
> 
> 1) we often try to have LTP specific 'TST_' prefix to avoid clash with
> whatever definition. Is it ok to ignore it now?

I'd prefer to stick with PATH_ instead of TST_PATH_. PATH_ is universally
understood as a file path definition. Adding TST_ makes it unnecessarily
verbose.

> 2) I'm pretty sure I will have to look into this file often, because from
> definition name I have no idea where exactly file is. I'd be ok with long name
> TST_PROC_SYS_KERNEL_HOSTNAME, but understand Cyril wants short names. Maybe at
> least TST_PATH_KERNEL_HOSTNAME and TST_PATH_USER_MAX_USER_NAMESPACES(last
> directory and file)? That would be similar to what sysctl is using:
> 
> 	sysctl kernel.hostname
> 	sysctl user.max_user_namespaces

I understand the concern, but long macros like TST_PATH_USER_MAX_USER_NAMESPACES
will make the test code very verbose and easily lead to 80-character
line wrapping issues.

To address the readability issue without making the names too long,
I can add _KERNEL_ and _USER_ to the defines (like PATH_KERNEL_HOSTNAME
and PATH_USER_MAX_USER_NAMESPACES). I think this is a good middle ground.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
