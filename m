Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6AFC3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 05:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744263149; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=a+GQijybxPN7NIkkWkyw4EFspP/pW0sNfe+yZ7ce0H8=;
 b=jUgI8gzD7KEnOAcvVaVctD4iifWQly3N75qiEecf+BLmULH3j0MCaq/RSpf8sq7OmrVi6
 H20sJgKPAVl3E7WKFnh6rPSFGA6haqreB0EOYRpfrx9DATeyIX2nswdtDbUgg88bmlAFXIH
 zmYoupkr7ySI/7G7gmcyi97n+TEAyts=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 191453CB44A
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 07:32:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AEFE3CA46A
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:32:06 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 27F832009AC
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:32:03 +0200 (CEST)
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso2682215e9.1
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 22:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744263122; x=1744867922; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pMWTC9cSiZXW49/zzmqWRMs+DVD/X03/vic9OUobLDk=;
 b=gL60LTyLH+SksP9A8XBxbGjBXHMX9TWGpyDfkF90YsbRh4UfMHZ5+WInhuDrhyKg5N
 1LQjVeWhVlM2BdUuybJqrYlxih7+9UmlVRUW1Hj4x9vti+6m7YJhhZOqmM2ByG8j58P9
 OIZUzwATxGsDhGBPxgdeFyYckEmOjmAqSB4L1UOzHSYZUnbzSnRIVo+DTjBpHstBrmfW
 Cc11SaK8tRbgSsSDBZuaUFJ0SCqmR6hCb8MMfEec6MsV97/eDAc0oCbZ7JGVaRNIKGs0
 /NoQdtKYy+c5xnBPzM5pD+kOstadeCgJLQXMrKL6IaiZt17jdOLdWCnAmKPABz5JZnyA
 7eMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744263122; x=1744867922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMWTC9cSiZXW49/zzmqWRMs+DVD/X03/vic9OUobLDk=;
 b=v/gj70qry2GaVOql1eE4PiPvuQVY73w4WNINSxvNtccrB1ZLEnyopKJ7onyMYKZxWE
 FeD0PZY1SIPYe80PEbzDC8IjWDG1PBPQUDbWC/kAXkruNMYEJbf8bACXsYNp6hhpyw5b
 SQlBtTjasDv8oN8l4lFRkpOrkThqBs0ik1ehclCh12OqMpLAgIFOyeb8b/NGeVbg7rdU
 6ujtQx+rGEhn20fK5v0SjhzWbIAOEjPMHpL8lkjuTX0skpWWo1v+hK3yGdpThThQyOyX
 +GmABunXkLxMcWfmiwVbB4OebBoAilPfmBHAHa9/lXKOhQkuomphAWlGtUvJ7wolshst
 QsDw==
X-Gm-Message-State: AOJu0YysI4hIKeFzt8VN8kKnYOlU1qGlVZg0wLXtzsZ1fK/DRgtbFPU2
 kSuee9zB4puzba7mUBEMjPNAmrZIpVGGd3f2iHBhqW1REhucMj4Pb1tR/CDwWG8kaS8kftMsiVN
 lyQv5
X-Gm-Gg: ASbGncsuYE4y9XSJ/3/5T4BcrYd5kd4ZnzH/6p1ZBvAu7Xf01c10a1RsHbi+OiY9/6e
 UbxLkTq7XZ4Bct7UhmHEoCWXT3hvK57K+Ad0hcoSjbaOF3QzPVZXff6quFM4dN/lwNDxSgP04ZW
 V+1MiuzBkHoMlbYoz1a4f4nfmqVaTJORgw7iIUfjsAGrnJOFZwDr0ggM6u79EBDi3SZ0BQgpzOq
 jy4UEsRqprNCyvUVoOsG6wHJNEovjHo8p0HY6r7GhRdUu0nBZAbdQASMUnBd6QdNnj562Gfxd0Z
 vHqzgjALc+jjtarHFhOwp74I
X-Google-Smtp-Source: AGHT+IHd/4FrMDaYyK+9SLyzNHdL8Ag9ro9f+O3RnIednxNnWtN9DARhYzYwJlTQrsNdNE6DoiUoEw==
X-Received: by 2002:a5d:648c:0:b0:391:49f6:dad4 with SMTP id
 ffacd0b85a97d-39d8f4e4712mr960277f8f.41.1744263122420; 
 Wed, 09 Apr 2025 22:32:02 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm2539416a91.4.2025.04.09.22.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 22:32:01 -0700 (PDT)
Date: Thu, 10 Apr 2025 01:31:57 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z/dXzRQsXnXKYYkh@wegao>
References: <20240415114652.22687-1-wegao@suse.com>
 <20241212085058.29551-1-wegao@suse.com>
 <20241212085058.29551-3-wegao@suse.com>
 <20250227164338.GG3130282@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250227164338.GG3130282@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] ioctl_fiemap01: New test for fiemap ioctl()
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

On Thu, Feb 27, 2025 at 05:43:38PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> 
> > +
> > +	ret = ioctl(fd, FS_IOC_FIEMAP, fiemap);
> > +	if (ret == -1) {
> > +		if (errno == ENOTTY)
> > +			tst_res(TCONF, "ioctl(FS_IOC_FIEMAP) not implemented");
> I wonder if it's safe to put errno == ENOTTY check into SAFE_IOCTL().
> We have similar checks in safe_socket() and other.
> 
> e.g.:
> #define TTYPE (errno == ENOTTY ? TCONF : TBROK)
> 
> Maybe it's not safe, ENOTTY might be caused by some test error which deserves
> TBROK:
> 
>        ENOTTY fd is not associated with a character special device.
> 
>        ENOTTY The specified operation does not apply to the kind of object that the file descriptor fd references.
> 
I remove this code in next version, i have done quick test on our old build such as 12-sp5 , result is pass

susetest:~ # cat /etc/os-release
NAME="SLES"
VERSION="12-SP5"
VERSION_ID="12.5"
PRETTY_NAME="SUSE Linux Enterprise Server 12 SP5"
ID="sles"
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:suse:sles:12:sp5"
susetest:~ # uname
uname    uname26
susetest:~ # uname -r
4.12.14-122.231-default

> > +
> > +static struct tst_test test = {
> > +	.mount_device = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.all_filesystems = 1,
> > +	.skip_filesystems = (const char *const[]) {
> > +		"exfat", "vfat", "ntfs", "tmpfs", NULL
> 
> Is the function unimplemented on these (even on tmpfs)? I would expect that but
tmpfs is an in-memory filesystem and does not store any file into real disk, so it
not suppose to support it. 
> better to explain in the commit message why it's skipped.
I have done some check on other filesystems such as exfat/vfat/ntfs, it show unsupport
error, still need further investigation if we want figure out root cause, just for
safe reason i skip those filesystem in this case currently.


attach test log:
cat /etc/os-release
NAME="openSUSE Leap"
VERSION="15.5"
ID="opensuse-leap"
ID_LIKE="suse opensuse"
VERSION_ID="15.5"
PRETTY_NAME="openSUSE Leap 15.5"
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:opensuse:leap:15.5"
BUG_REPORT_URL="https://bugs.opensuse.org"
HOME_URL="https://www.opensuse.org/"
DOCUMENTATION_URL="https://en.opensuse.org/Portal:Leap"
LOGO="distributor-logo-Leap"


tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:678: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1724: TINFO: Overall timeout per run is 0h 02m 00s
tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
tst_supported_fs_types.c:62: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
tst_supported_fs_types.c:170: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:170: TINFO: Skipping exfat as requested by the test
tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs

tst_test.c:1833: TINFO: === Testing on vfat ===
tst_test.c:1170: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_iocNjlayn/mntpoint fstyp=vfat flags=0
ioctl_fiemap01.c:87: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) expected EBADR: EOPNOTSUPP (95)
ioctl_fiemap01.c:90: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) failed: EOPNOTSUPP (95)
tst_test.c:1797: TBROK: Test killed by SIGSEGV!



tst_test.c:1833: TINFO: === Testing on exfat ===
tst_test.c:1170: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_ioclNusF7/mntpoint fstyp=exfat flags=0
ioctl_fiemap01.c:87: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) expected EBADR: EOPNOTSUPP (95)
ioctl_fiemap01.c:90: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) failed: EOPNOTSUPP (95)
tst_test.c:1797: TBROK: Test killed by SIGSEGV!



tst_test.c:1833: TINFO: === Testing on ntfs ===
tst_test.c:1170: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_iocGtgwCr/mntpoint fstyp=ntfs flags=0
tst_test.c:1183: TINFO: Trying FUSE...
ioctl_fiemap01.c:87: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) expected EBADR: EOPNOTSUPP (95)
ioctl_fiemap01.c:90: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) failed: EOPNOTSUPP (95)
tst_test.c:1797: TBROK: Test killed by SIGSEGV!



tst_test.c:1833: TINFO: === Testing on tmpfs ===
tst_test.c:1170: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1146: TINFO: Limiting tmpfs size to 32MB
tst_test.c:1183: TINFO: Mounting ltp-tmpfs to /tmp/LTP_iocUtSP0X/mntpoint fstyp=tmpfs flags=0
ioctl_fiemap01.c:87: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) expected EBADR: EOPNOTSUPP (95)
ioctl_fiemap01.c:90: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) failed: EOPNOTSUPP (95)
tst_test.c:1797: TBROK: Test killed by SIGSEGV!


> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
