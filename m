Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210C6C36008
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743036587; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Fi5dfGNzRBEmLUVPXgeeNjiyXIsANQWB64n3pdOGTuk=;
 b=Uv0RnLzwCCea+/fo5iNvmWLoWh8/N84AbZxk/UTOrN46ScGunonlOZvVx5sxrWhDMDc5f
 2JJ68UXMNk2gt3TsY1oZ4WpWw8/dIIJHK6XggHcCzrzPah3Cksvc22SHGHyFND/A6dzGZFY
 dUgZjponnB+zpxwBiZxu/cjrthec+v4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03FF83C9C70
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 01:49:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D5C23C9C70
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 01:49:25 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3EF431400204
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 01:49:24 +0100 (CET)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2279915e06eso9648565ad.1
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 17:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1743036562; x=1743641362;
 darn=lists.linux.it; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U3ibaiMuu+COMl2CleDE3M0U3/NtyoxWAeWllDuQocU=;
 b=sTH5sXbcKCZG3fxAoCHEuBHe1zMygBoUMzgFwW9ikUgIKYXEHi++S+/zexBM/x60qv
 FRoOowHJ1xhblzHMq5V+7keTAu9wXs1254xfCa/+/TB+5/tQaohpJqS9Fqk5p7hlHDtp
 mYj46bipQSOYCth2tt8o+TVyQb4/9I0ZfyVSDhclbSP5GIl83S2YM1jKKvM7sRS197SZ
 gcQGJSCV5VSBouhF4+Q344LCMAvObwDFT36CYADKNkliK+3G5kimkUpRp9SjI3GUk3D1
 DdFHuZS2MDNPvwh/XO72RPjR52GgmoxxaO7bkjDuKw3Tqjajz1u/4ZaLDwxqLASfsrHC
 ItRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743036562; x=1743641362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3ibaiMuu+COMl2CleDE3M0U3/NtyoxWAeWllDuQocU=;
 b=vxnT1CuFuUfeWzqY24BP/ErjtPSu7tdWNw1DHzit8SykC4QKJ2EWqVcKKzl2Iu6ZeU
 4qqTXPfU2n/qdsSm394rc2RINnHwPGK03PwUguJ4HjxetIObW4xug9qfEfowD+Z2luaR
 rIWnYxvt1HvajXnsI4OFQxpqcCSiRrm243N/rokVGPmnvETEP4+dvJfHadmUIHRCwSwp
 RTy97rMxDIdEh6U2mYyFkXU9tcP9y2jqsEQ5AIIMutfySn/3j2RYxhT4IQPzD5nge0aI
 Z6ByQ5Oom+Vbc+0YmU+48sptB6LFNBSVyoVmfmvUpl9tKg3XYQKK/5cx7+kYPFR9IAqo
 JGQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtr5hxT5hvVV9ONdO927dmN4mEnqOBXNGuXkzw4V0tVqEtKmo6kxBHdpm0mehVeTZ2jc4=@lists.linux.it
X-Gm-Message-State: AOJu0YzY53yQIJTfZ1ehOR0l+91BBQXDoOvaIidjeUVurYo2EgbHvyZm
 /nYmV/1+OYpP7wZsfLRjXYNyd43MmpY9JuKf53WW83016D0v8dPtYe525/VmWLY=
X-Gm-Gg: ASbGncurggRgxqDKUSr2uzMGuHnkg3xz0TFWyeB4psBe95VRMPaV9bnfzu5L8LKBWs/
 n4FCkVSRwqCIsASNzQf+q9TDZ2omo8Rc3ixA3ApjKT+2EfHxCGXnLu/TldtW6Nazoj14BVkKskc
 nQ6GqTggQ6C2QGAyH4/AK3sfuHOREK2dszzItNdvtqhTd/Zleq9SxAft95aorkAY9/SOE9pdaRz
 V5v1+gRdFIGldP2F+cW3MAbMsZIYGAB0aLkQNX5y0JPZWp4s4KIygX4//P/5SN0tAUjWrGw5BMb
 QjQE04sLF22qMDeCwieWt7ErW/03M6vCcpr4IrFfXSV/jvMqxaVRbEUXS4k0Fp2AL+LYaBPikDh
 T6TcRYb8=
X-Google-Smtp-Source: AGHT+IFnAErnvRw6w6zYA8RwNXoDN/pZhTmE2gfdgW366+JFnzo8IFmWZzTDFcSClOKbvjQXE59Ogg==
X-Received: by 2002:a05:6a20:2d20:b0:1f0:e42e:fb1d with SMTP id
 adf61e73a8af0-1fea301bd45mr3128802637.36.1743036562470; 
 Wed, 26 Mar 2025 17:49:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au.
 [49.181.60.96]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611c950sm13311890b3a.104.2025.03.26.17.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 17:49:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
 (envelope-from <david@fromorbit.com>) id 1txbQt-00000000kyo-0I5r;
 Thu, 27 Mar 2025 11:49:19 +1100
Date: Thu, 27 Mar 2025 11:49:19 +1100
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z-Sgj_XOVar8myLw@dread.disaster.area>
References: <20250326-fix_ioctl_ficlone03_32bit_bcachefs-v1-1-554a0315ebf5@suse.com>
 <20250326134749.GA45449@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250326134749.GA45449@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ioctl_ficlone03: fix capabilities on immutable
 files
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
From: Dave Chinner via ltp <ltp@lists.linux.it>
Reply-To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 26, 2025 at 02:47:49PM +0100, Petr Vorel wrote:
> Hi all,
> 
> [ Cc Kent and other filesystem folks to be sure we don't hide a bug ]
> 
> > From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> > Make sure that capabilities requirements are satisfied when accessing
> > immutable files. On OpenSUSE Tumbleweed 32bit bcachefs fails with the
> > following error due to missing capabilities:
> 
> > tst_test.c:1833: TINFO: === Testing on bcachefs ===
> > ..
> > ioctl_ficlone03.c:74: TBROK: ioctl .. failed: ENOTTY (25)
> > ioctl_ficlone03.c:89: TWARN: ioctl ..  failed: ENOTTY (25)
> > ioctl_ficlone03.c:91: TWARN: ioctl ..  failed: ENOTTY (25)
> > ioctl_ficlone03.c:98: TWARN: close(-1) failed: EBADF (9)

None of these are -EPERM, so how is a missing capability that
results in -EPERM being returned cause -ENOTTY or -EBADF failures?

ohhhhh. ENOTTY is a result of a kernel side compat ioctl handling bug
w/ bcachefs.

bcachefs doesn't implement ->fileattr_set().

sys_compat_ioctl() does:

        case FS_IOC32_GETFLAGS:
        case FS_IOC32_SETFLAGS:
                cmd = (cmd == FS_IOC32_GETFLAGS) ?
                        FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;

and then calls do_vfs_ioctl().

This then ends up in vfs_fileattr_set(), which does:

	if (!inode->i_op->fileattr_set)
                return -ENOIOCTLCMD;

which means sys_compat_ioctl() then falls back to calling
->compat_ioctl().

However, cmd has been overwritten to FS_IOC_SETFLAGS and
bch2_compat_fs_ioctl() looks for FS_IOC32_SETFLAGS, so it returns
-ENOIOCTLCMD as it doesn't handle the ioctl command passed in.

sys_compat_ioctl() then converts the -ENOIOCTLCMD to -ENOTTY, and
there's the error being reported.

OK, this is a bcachefs compat ioctl handling bug, triggered by not
implementing ->fileattr_set and implementing FS_IOC_SETFLAGS
directly itself via ->unlocked_ioctl.

Yeah, fixes to bcachefs needed here, not LTP.

> I wonder why it does not fail for generic VFS fs/ioctl.c used by Btrfs and XFS:

Because they implement ->fileattr_set() and so all the compat ioctl
FS_IOC32_SETFLAGS handling works as expected.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
