Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2776C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:18:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A7403DCD69
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:18:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03B463DCD69
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:18:06 +0200 (CEST)
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8DF0A200743
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:18:05 +0200 (CEST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784024284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coJJYNYStojfsd9NVgFqP9St8iNU7NFof9uSlNTn3/8=;
 b=LKI8ogBSVdiuibidjaOLBOULghJltfVtXYPNiFC8D3uSKIAvQRGpn6gBE0HDZft4fm/msH
 eiCMBaLx61GfAZUsbpXiUG0B5aKqBo9SHZh1DhQ/rtY6/y5nxrua6aj5jGnOVNFUMg/Bs8
 Fw6forRP+u0xzbQgbVRrEM8VOQosI2w=
Date: Tue, 14 Jul 2026 10:18:03 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: gang.yan@linux.dev
Message-ID: <171e5a6fadd4b47719c6a120a4586e750efb80bc@linux.dev>
TLS-Required: No
To: ltp@lists.linux.it
In-Reply-To: <20260714100738.7745-4-gang.yan@linux.dev>
References: <20260714100738.7745-1-gang.yan@linux.dev>
 <20260714100738.7745-4-gang.yan@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] tst_fd.c: replace syscall() with
 tst_syscall_base()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

July 14, 2026 at 6:07 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.yan@linux.dev?to=%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:

Hi,

Sorry for this broken message, please ignore it.
I've resent the patch series.

Thanks,
Gang


> 
> From: Gang Yan <yangang@kylinos.cn>
> 
> If some feature is not supported by some arch, like _NR__memfd_secret,
> it will become -1. And the syscall can continue with '-1' and the output
> would be:
> 
> '''
> accept03.c:47: TFAIL: accept() on memfd secret expected ENOTSOCK: EBADF (9)
> tst_fd.c:307: TBROK: close(38) failed: EBADF(9)
> '''
> 
> This patch use tst_syscall to give a more specific fail reason:
> 
> '''
> tst_fd.c:262: TCONF: Skipping memfd secret: ENOSYS(38)
> '''
> 
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  lib/tst_fd.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/tst_fd.c b/lib/tst_fd.c
> index 6538a098c..1d90505b2 100644
> --- a/lib/tst_fd.c
> +++ b/lib/tst_fd.c
> @@ -139,14 +139,14 @@ static void open_timerfd(struct tst_fd *fd)
>  
>  static void open_pidfd(struct tst_fd *fd)
>  {
> - fd->fd = syscall(__NR_pidfd_open, getpid(), 0);
> + fd->fd = tst_syscall_base(__NR_pidfd_open, getpid(), 0);
>  if (fd->fd < 0)
>  tst_res(TCONF | TERRNO, "pidfd_open()");
>  }
>  
>  static void open_fanotify(struct tst_fd *fd)
>  {
> - fd->fd = syscall(__NR_fanotify_init, FAN_CLASS_NOTIF, O_RDONLY);
> + fd->fd = tst_syscall_base(__NR_fanotify_init, FAN_CLASS_NOTIF, O_RDONLY);
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> @@ -164,7 +164,7 @@ static void open_inotify(struct tst_fd *fd)
>  
>  static void open_userfaultfd(struct tst_fd *fd)
>  {
> - fd->fd = syscall(__NR_userfaultfd, 0);
> + fd->fd = tst_syscall_base(__NR_userfaultfd, 0);
>  
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
> @@ -183,7 +183,7 @@ static void open_perf_event(struct tst_fd *fd)
>  .exclude_hv = 1,
>  };
>  
> - fd->fd = syscall(__NR_perf_event_open, &pe_attr, 0, -1, -1, 0);
> + fd->fd = tst_syscall_base(__NR_perf_event_open, &pe_attr, 0, -1, -1, 0);
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> @@ -194,7 +194,7 @@ static void open_io_uring(struct tst_fd *fd)
>  {
>  struct io_uring_params uring_params = {};
>  
> - fd->fd = syscall(__NR_io_uring_setup, 1, &uring_params);
> + fd->fd = tst_syscall_base(__NR_io_uring_setup, 1, &uring_params);
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> @@ -210,7 +210,7 @@ static void open_bpf_map(struct tst_fd *fd)
>  .max_entries = 1,
>  };
>  
> - fd->fd = syscall(__NR_bpf, BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
> + fd->fd = tst_syscall_base(__NR_bpf, BPF_MAP_CREATE, &array_attr, sizeof(array_attr));
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> @@ -219,7 +219,7 @@ static void open_bpf_map(struct tst_fd *fd)
>  
>  static void open_fsopen(struct tst_fd *fd)
>  {
> - fd->fd = syscall(__NR_fsopen, "ext2", 0);
> + fd->fd = tst_syscall_base(__NR_fsopen, "ext2", 0);
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> @@ -228,7 +228,7 @@ static void open_fsopen(struct tst_fd *fd)
>  
>  static void open_fspick(struct tst_fd *fd)
>  {
> - fd->fd = syscall(__NR_fspick, AT_FDCWD, "/", 0);
> + fd->fd = tst_syscall_base(__NR_fspick, AT_FDCWD, "/", 0);
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> @@ -237,7 +237,7 @@ static void open_fspick(struct tst_fd *fd)
>  
>  static void open_open_tree(struct tst_fd *fd)
>  {
> - fd->fd = syscall(__NR_open_tree, AT_FDCWD, "/", 0);
> + fd->fd = tst_syscall_base(__NR_open_tree, AT_FDCWD, "/", 0);
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> @@ -246,7 +246,7 @@ static void open_open_tree(struct tst_fd *fd)
>  
>  static void open_memfd(struct tst_fd *fd)
>  {
> - fd->fd = syscall(__NR_memfd_create, "ltp_memfd", 0);
> + fd->fd = tst_syscall_base(__NR_memfd_create, "ltp_memfd", 0);
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> @@ -255,7 +255,7 @@ static void open_memfd(struct tst_fd *fd)
>  
>  static void open_memfd_secret(struct tst_fd *fd)
>  {
> - fd->fd = syscall(__NR_memfd_secret, 0);
> + fd->fd = tst_syscall_base(__NR_memfd_secret, 0);
>  if (fd->fd < 0) {
>  tst_res(TCONF | TERRNO,
>  "Skipping %s", tst_fd_desc(fd));
> -- 
> 2.43.0
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
