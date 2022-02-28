Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E776FC433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 06:29:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C25D3CA289
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 07:29:56 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E04E73C24D6
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 07:29:46 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8322D6008F2
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 07:29:45 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id p14so22619413ejf.11
 for <ltp@lists.linux.it>; Sun, 27 Feb 2022 22:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZxLQ56NXbvzYXRBstjGIKmuQIsEBLhVk2DqLLUfr0so=;
 b=HEBQpT8UcNxkuuSTQ2XU1pI/lXSoUjl/FrZM/wOvz94tUf+IHlmMSaSnsckIU/do4A
 LqHuJtkmHhLHhV2UGujfztYC3zPIf9MBq6AHv44urmV0HnmHJFXcwNuyoZ6sydKuKKCL
 qif6/OAkwua+LBqJQQSPRtv0n6yGMXeay2NHdU9gjo9jkdbZly6GM4NWaH3KlTXd9Orm
 PRl4vGZgYdNFZ5vq8fxSoxNVpnSBbGzphaphV2qYf8sIN2tSI23Ri83Mer1wJql98SKq
 oDLiEaSrQYxBE3w2e7amfxsMSUA7EDT2TZ2CWL/Y/Nze/H7Kqsy12pTXVT1iv0vDOzmW
 uiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZxLQ56NXbvzYXRBstjGIKmuQIsEBLhVk2DqLLUfr0so=;
 b=BS2RFozVFpu//nN/k8BZPRmYagXBuHKW49rqAsZYfusStLfgM6UWtWH4AetzFPbuN/
 RzgZiusTw3XgLIqWchz+r/StYwYQmsGHwfUU97w8d8IsWa/o8RTU6tfTYYUQIS1R2UhZ
 xM1jGYfQfp4EwaCWE9LBfW0/exJB6KqWKr6Q5XvRUEUe1uiYebyTyCCU5jYsOXtLuLRK
 EVjw/5qQlBA6qcX9RXh7U6P9pYq3kJE+5vRRfN1Tvmt8XZDjyaPPUTmefGrfQW4TIGwo
 mI5OHYat0bTeAPPlnALy/DIKZE206PkLG4QmneWkjqYlzqDJpURYEynaFi1Ha2TFUFOP
 daqw==
X-Gm-Message-State: AOAM5336KMRNlbG2HEwtuFxUoOfhKJDUvQkRnyWDVCmq4oQAvXq/42Lr
 YTiAYzEPEzvJoJTrJDM+MejM+LLwPgbWzi4ZCEDbuikJ
X-Google-Smtp-Source: ABdhPJyNnC6CFBGgNUgpcO6sNCbxUtXXKcYsvhSAhjgYVaUjnPSReL1E3Uju/JbrpG4lVdf0cEm2/j9APal7mRGHZzw=
X-Received: by 2002:a17:906:6547:b0:6bd:e2ad:8c82 with SMTP id
 u7-20020a170906654700b006bde2ad8c82mr14046465ejn.693.1646029783928; Sun, 27
 Feb 2022 22:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
 <Ye/ZOo2tlA+Jf+Cf@yuki>
In-Reply-To: <Ye/ZOo2tlA+Jf+Cf@yuki>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Mon, 28 Feb 2022 14:29:32 +0800
Message-ID: <CADJHv_tRGHhLg2YLssu8hQpNU_PLa_iD1qhMWadBRpbTatoFiA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] kernel/fs/fs-notify: fsnotify stress tests
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

How to run another LTP test case fs_racer.sh or read_all in a new C
programme testcase?

I tried but hit some issues with the PATH configuration.

Is this recommended by you guys?

Thanks,
Murphy

On Tue, Jan 25, 2022 at 7:02 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > diff --git a/testcases/kernel/fs/fs-notify/Makefile b/testcases/kernel/fs/fs-notify/Makefile
> > new file mode 100644
> > index 000000000..328783942
> > --- /dev/null
> > +++ b/testcases/kernel/fs/fs-notify/Makefile
> > @@ -0,0 +1,18 @@
> > +#
> > +#    kernel/fs/fs-notify testcases Makefile.
> > +#
> > +
> > +top_srcdir                   ?= ../../../..
> > +
> > +include $(top_srcdir)/include/mk/testcases.mk
> > +
> > +BINARIES:=fanotify_flush_stress fanotify_init_stress \
> > +fanotify_mark_stress fanotify_watch inotify_watch \
> > +inotify_add_rm_stress inotify_init_stress inotify_inmodify_stress\
> > +writefile freadfile fwritefile readfile
> > +
> > +INSTALL_TARGETS                      := fsnotify-stress.sh $(BINARIES) rw_files.sh
> > +
> > +MAKE_TARGETS                 := $(BINARIES)
> > +
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/fs/fs-notify/fanotify_flush_stress.c b/testcases/kernel/fs/fs-notify/fanotify_flush_stress.c
> > new file mode 100644
> > index 000000000..493acfb56
> > --- /dev/null
> > +++ b/testcases/kernel/fs/fs-notify/fanotify_flush_stress.c
> > @@ -0,0 +1,52 @@
> > +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> > +#include <poll.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/fanotify.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     char buf;
> > +     int fd;
> > +
> > +     /* Create the file descriptor for accessing the fanotify API */
> > +     fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> > +                                        O_RDONLY | O_LARGEFILE);
> > +     if (fd == -1) {
> > +             perror("fanotify_init");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     /* Loop marking all kinds of events and flush */
> > +     while (1) {
> > +
> > +             if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> > +                       FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> > +                       FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> > +                       FAN_EVENT_ON_CHILD, -1, argv[1]) == -1)
> > +
> > +                     perror("fanotify_mark add");
> > +
> > +             if (fanotify_mark(fd, FAN_MARK_FLUSH | FAN_MARK_MOUNT,
> > +                                             0, -1, argv[1]) == -1)
> > +                     perror("fanotify_mark flush mount");
> > +
> > +             if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> > +                       FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> > +                       FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> > +                       FAN_EVENT_ON_CHILD, -1, argv[1]) == -1)
> > +
> > +                     perror("fanotify_mark add");
> > +
> > +             if (fanotify_mark(fd, FAN_MARK_FLUSH, 0, -1, argv[1]) == -1)
> > +                     perror("fanotify_mark flush");
> > +     }
> > +
> > +     close(fd);
> > +     exit(EXIT_SUCCESS);
> > +}
> > diff --git a/testcases/kernel/fs/fs-notify/fanotify_init_stress.c b/testcases/kernel/fs/fs-notify/fanotify_init_stress.c
> > new file mode 100644
> > index 000000000..d11924b57
> > --- /dev/null
> > +++ b/testcases/kernel/fs/fs-notify/fanotify_init_stress.c
> > @@ -0,0 +1,32 @@
> > +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> > +#include <errno.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <stdlib.h>
> > +#include <sys/fanotify.h>
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     char buf;
> > +     int fd;
> > +     while (1) {
> > +
> > +             /* Create the file descriptor for accessing the fanotify API */
> > +             fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT |
> > +                             FAN_NONBLOCK, O_RDONLY | O_LARGEFILE);
> > +             if (fd == -1)
> > +                     perror("fanotify_init");
> > +
> > +             if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> > +                             FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
> > +                             FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
> > +                             FAN_ONDIR | FAN_EVENT_ON_CHILD, -1,
> > +                             argv[1]) == -1)
> > +                     perror("fanotify_mark");
> > +
> > +             close(fd);
> > +     }
> > +
> > +     exit(EXIT_SUCCESS);
> > +}
> > diff --git a/testcases/kernel/fs/fs-notify/fanotify_mark_stress.c b/testcases/kernel/fs/fs-notify/fanotify_mark_stress.c
> > new file mode 100644
> > index 000000000..7f648e103
> > --- /dev/null
> > +++ b/testcases/kernel/fs/fs-notify/fanotify_mark_stress.c
> > @@ -0,0 +1,58 @@
> > +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> > +#include <poll.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/fanotify.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +
> > +void add_mark(int fd, uint64_t mask, char *path)
> > +{
> > +     if (fanotify_mark(fd, FAN_MARK_ADD, mask, -1, path) == -1)
> > +             perror("fanotify_mark add");
> > +}
> > +
> > +void remove_mark(int fd, uint64_t mask, char *path)
> > +{
> > +     if (fanotify_mark(fd, FAN_MARK_REMOVE, mask, -1, path) == -1)
> > +             perror("fanotify_mark remove");
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     char buf;
> > +     int fd;
> > +     /* Create the file descriptor for accessing the fanotify API */
> > +     fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> > +                                        O_RDONLY | O_LARGEFILE);
> > +     if (fd == -1) {
> > +             perror("fanotify_init");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     /* Loop marking all kinds of events */
> > +     while (1) {
> > +             add_mark(fd, FAN_ACCESS, argv[1]);
> > +             remove_mark(fd, FAN_ACCESS, argv[1]);
> > +             add_mark(fd, FAN_MODIFY, argv[1]);
> > +             remove_mark(fd, FAN_MODIFY, argv[1]);
> > +             add_mark(fd, FAN_OPEN_PERM, argv[1]);
> > +             remove_mark(fd, FAN_OPEN_PERM, argv[1]);
> > +             add_mark(fd, FAN_CLOSE, argv[1]);
> > +             remove_mark(fd, FAN_CLOSE, argv[1]);
> > +             add_mark(fd, FAN_OPEN, argv[1]);
> > +             remove_mark(fd, FAN_OPEN, argv[1]);
> > +             add_mark(fd, FAN_ACCESS_PERM, argv[1]);
> > +             remove_mark(fd, FAN_ACCESS_PERM, argv[1]);
> > +             add_mark(fd, FAN_ONDIR, argv[1]);
> > +             remove_mark(fd, FAN_ONDIR, argv[1]);
> > +             add_mark(fd, FAN_EVENT_ON_CHILD, argv[1]);
> > +             remove_mark(fd, FAN_EVENT_ON_CHILD, argv[1]);
> > +     }
> > +
> > +     close(fd);
> > +     exit(EXIT_SUCCESS);
> > +}
> > diff --git a/testcases/kernel/fs/fs-notify/fanotify_watch.c b/testcases/kernel/fs/fs-notify/fanotify_watch.c
> > new file mode 100644
> > index 000000000..1028e0e30
> > --- /dev/null
> > +++ b/testcases/kernel/fs/fs-notify/fanotify_watch.c
> > @@ -0,0 +1,244 @@
> > +/* Example in man 7 fanotify */
> > +
> > +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <limits.h>
> > +#include <poll.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <sys/fanotify.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +
> > +/* get comm for pid from /proc/pid/comm */
> > +static char * get_comm_pid(unsigned int pid)
> > +{
> > +     char * proc_name;
> > +     char * comm;
> > +     int comm_fd, cnt;
> > +
> > +     proc_name = (char *)malloc(50);
> > +     if (proc_name != NULL)
> > +             sprintf(proc_name, "/proc/%u/comm\0", pid);
> > +     else
> > +             return NULL;
> > +
> > +     comm = (char *)malloc(50);
> > +     if (comm != NULL)
> > +             memset(comm, 0, 50);
> > +     else
> > +             return NULL;
> > +
> > +     comm_fd = open(proc_name, O_RDONLY);
> > +     if (comm_fd != -1) {
> > +             cnt = read(comm_fd, comm, 50);
> > +             if (cnt != -1) {
> > +                     comm[cnt] = '\0';
> > +                     close(comm_fd);
> > +                     return comm;
> > +             }
> > +             close(comm_fd);
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> > +/* Read all available fanotify events from the file descriptor 'fd' */
> > +
> > +static void handle_events(int fd)
> > +{
> > +     const struct fanotify_event_metadata *metadata;
> > +     struct fanotify_event_metadata buf[200];
> > +     ssize_t len;
> > +     char path[PATH_MAX];
> > +     ssize_t path_len;
> > +     char procfd_path[PATH_MAX];
> > +     struct fanotify_response response;
> > +
> > +     /* Loop while events can be read from fanotify file descriptor */
> > +     for(;;) {
> > +
> > +             /* Read some events */
> > +             len = read(fd, (void *) &buf, sizeof(buf));
> > +             if (len == -1 && errno != EAGAIN) {
> > +                     perror("read");
> > +                     exit(EXIT_FAILURE);
> > +             }
> > +
> > +             /* Check if end of available data reached */
> > +             if (len <= 0)
> > +                     break;
> > +
> > +             /* Point to the first event in the buffer */
> > +             metadata = buf;
> > +
> > +             /* Loop over all events in the buffer */
> > +             while (FAN_EVENT_OK(metadata, len)) {
> > +
> > +                     /* Check that run-time and compile-time structures match */
> > +
> > +                     if (metadata->vers != FANOTIFY_METADATA_VERSION) {
> > +                             fprintf(stderr,
> > +                                 "Mismatch of fanotify metadata version.\n");
> > +                             exit(EXIT_FAILURE);
> > +                     }
> > +
> > +                     /* metadata->fd contains either FAN_NOFD, indicating a
> > +                        queue overflow, or a file descriptor (a nonnegative
> > +                        integer). Here, we simply ignore queue overflow. */
> > +
> > +                     if (metadata->fd >= 0) {
> > +
> > +                             /* Handle open permission event */
> > +                             if (metadata->mask & FAN_OPEN_PERM) {
> > +                                     printf("FAN_OPEN_PERM: ");
> > +
> > +                                     /* Allow file to be opened */
> > +                                     response.fd = metadata->fd;
> > +                                     response.response = FAN_ALLOW;
> > +                                     write(fd, &response,
> > +                                         sizeof(struct fanotify_response));
> > +                             }
> > +
> > +                             /* Handle access permission event */
> > +                             if (metadata->mask & FAN_ACCESS_PERM) {
> > +                                     printf("FAN_ACCESS_PERM: ");
> > +
> > +                                     /* Allow file to be accessed */
> > +                                     response.fd = metadata->fd;
> > +                                     response.response = FAN_ALLOW;
> > +                                     write(fd, &response,
> > +                                         sizeof(struct fanotify_response));
> > +                             }
> > +
> > +                             /* Handle closing of writable file event */
> > +                             if (metadata->mask & FAN_CLOSE_WRITE)
> > +                                     printf("FAN_CLOSE_WRITE: ");
> > +
> > +                             /* Handle closing of not writable file event */
> > +                             if (metadata->mask & FAN_CLOSE_NOWRITE)
> > +                                     printf("FAN_CLOSE_NOWRITE: ");
> > +
> > +                             /* Handle modify file event */
> > +                             if (metadata->mask & FAN_MODIFY)
> > +                                     printf("FAN_MODIFY: ");
> > +
> > +                             /* Handle open event */
> > +                             if (metadata->mask & FAN_OPEN)
> > +                                     printf("FAN_OPEN: ");
> > +
> > +                             /* Handle access event */
> > +                             if (metadata->mask & FAN_ACCESS)
> > +                                     printf("FAN_ACCESS: ");
> > +
> > +                             /* Handle access event */
> > +                             if (metadata->mask & FAN_ONDIR)
> > +                                     printf("FAN_ONDIR: ");
> > +
> > +                             /* Handle access event */
> > +                             if (metadata->mask & FAN_EVENT_ON_CHILD)
> > +                                     printf("FAN_EVENT_ON_CHILD: ");
> > +
> > +                             /* Retrieve/print the accessed file path*/
> > +                             snprintf(procfd_path, sizeof(procfd_path),
> > +                                         "/proc/self/fd/%d", metadata->fd);
> > +                             path_len = readlink(procfd_path, path,
> > +                                         sizeof(path) - 1);
> > +                             if (path_len == -1) {
> > +                                     perror("readlink");
> > +                                     exit(EXIT_FAILURE);
> > +                             }
> > +
> > +                             path[path_len] = '\0';
> > +                             printf("File %s.\t\t Comm %s", path,
> > +                                     get_comm_pid(metadata->pid));
> > +
> > +                             /* Close the file descriptor of the event */
> > +
> > +                             close(metadata->fd);
> > +                     }
> > +
> > +                     /* Advance to next event */
> > +                     metadata = FAN_EVENT_NEXT(metadata, len);
> > +             }
> > +     }
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     char buf;
> > +     int fd, poll_num;
> > +     nfds_t nfds;
> > +     struct pollfd fds[2];
> > +     FILE *f;
> > +#if 0
> > +     /* Check mount point is supplied */
> > +     if (argc != 2) {
> > +             fprintf(stderr, "Usage: %s MOUNT\n", argv[0]);
> > +             exit(EXIT_FAILURE);
> > +     }
> > +#endif
> > +     printf("%s on %s\n", argv[0], argv[1]);
> > +     fflush(stdout);
> > +     f = freopen("fanotify.log", "w+", stdout);
> > +     if (f == NULL) {
> > +             perror("freopen");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     /* Create the file descriptor for accessing the fanotify API */
> > +     fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> > +                                        O_RDONLY | O_LARGEFILE);
> > +     if (fd == -1) {
> > +             perror("fanotify_init");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     /* Mark the mount for:
> > +        - permission events before opening files
> > +        - notification events after closing a write-enabled
> > +              file descriptor */
> > +     if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> > +                     FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
> > +                     FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
> > +                     FAN_ONDIR | FAN_EVENT_ON_CHILD,
> > +                     -1, argv[1]) == -1) {
> > +
> > +             perror("fanotify_mark");
> > +             exit(EXIT_FAILURE);
> > +     }
> > +
> > +     /* Prepare for polling */
> > +     nfds = 1;
> > +
> > +     /* Fanotify input */
> > +     fds[0].fd = fd;
> > +     fds[0].events = POLLIN;
> > +
> > +     /* This is the loop to wait for incoming events */
> > +     printf("Listening for events.\n");
> > +     while (1) {
> > +             poll_num = poll(fds, nfds, -1);
> > +             if (poll_num == -1) {
> > +                     if (errno == EINTR)     /* Interrupted by a signal */
> > +                             continue;           /* Restart poll() */
> > +
> > +                     perror("poll");         /* Unexpected error */
> > +                     exit(EXIT_FAILURE);
> > +             }
> > +
> > +             if (poll_num > 0) {
> > +
> > +                     if (fds[0].revents & POLLIN) {
> > +
> > +                             /* Fanotify events are available */
> > +                             handle_events(fd);
> > +                     }
> > +             }
> > +     }
> > +
> > +     fclose(f);
> > +     printf("Listening for events stopped.\n");
> > +     exit(EXIT_SUCCESS);
> > +}
> > diff --git a/testcases/kernel/fs/fs-notify/freadfile.c b/testcases/kernel/fs/fs-notify/freadfile.c
> > new file mode 100644
> > index 000000000..24bf76bcd
> > --- /dev/null
> > +++ b/testcases/kernel/fs/fs-notify/freadfile.c
> > @@ -0,0 +1,27 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +
> > +int main(int argc, char **argv)
> > +{
> > +     int fd;
> > +     char buf[BUFSIZ];
> > +     FILE *f;
> > +
> > +     memset(buf, 1, BUFSIZ);
> > +     while(1) {
> > +             f = fopen(argv[1], "r+");
> > +             if (f == NULL) {
> > +                     perror("freadfile fopen");
> > +                     exit(EXIT_FAILURE);
> > +             }
> > +             fread(buf, sizeof(char), BUFSIZ, f);
> > +             usleep(1);
> > +     }
> > +     fclose(f);
> > +     return 0;
> > +}
>
> There is no real reason to keep these as several separate files. We can
> actually put the whole test into one single C source that forks severa
> times and each child runs one of loops from these helpers.
>
> > diff --git a/testcases/kernel/fs/fs-notify/fsnotify-stress.sh b/testcases/kernel/fs/fs-notify/fsnotify-stress.sh
> > new file mode 100755
> > index 000000000..d6fd5482b
> > --- /dev/null
> > +++ b/testcases/kernel/fs/fs-notify/fsnotify-stress.sh
> > @@ -0,0 +1,64 @@
> > +#!/bin/bash
> > +
> > +export TIMEOUT=10
> > +
> > +STRESSES="fanotify_flush_stress fanotify_init_stress \
> > +fanotify_mark_stress fanotify_watch inotify_watch \
> > +inotify_add_rm_stress inotify_init_stress inotify_inmodify_stress"
> > +IO_OPES="writefile freadfile fwritefile readfile"
> > +
> > +NR_CPUS=$(grep -c processor /proc/cpuinfo)
> > +[ $NR_CPUS -lt 4 ] && NR_CPUS=4
> > +
> > +function cleanup_processes()
> > +{
> > +     while ps -eo pid,comm | \
> > +             grep -q -E "fanotify|inotify|rw_files|readfile|writefile" ; do
> > +             killall rw_files.sh $STRESSES $IO_OPES > /dev/null 2>&1
> > +             sleep 1
> > +     done
> > +}
> > +
> > +function cleanup()
> > +{
> > +     sleep 3 # waiting possible unfinished processes
> > +     cleanup_processes
> > +     rm -f $STRESSES $IO_OPES fanotify.log inotify.log tmp
> > +     cd /
> > +     sync
> > +}
> > +
> > +function run_stress()
> > +{
> > +     local i j rcnt=0
> > +     echo -e "* CPU count: $NR_CPUS"
> > +     echo -e "* TIMEOUT for each subcase: $TIMEOUT"
> > +
> > +     echo -e "* Starting fsnotify stress on directory and regular file"
> > +     touch $TMPDIR/testfile
> > +     >tmp
> > +     for i in $STRESSES $IO_OPES rw_files.sh; do
> > +             for j in $STRESSES ; do
> > +                     [ "$i" == "$j" ] && continue
> > +                     # skip duplicate combinations
> > +                     grep -w $j tmp | grep -qw $i && continue
> > +                     echo -e "* Starting $i and $j, rcnt $rcnt"
> > +                     ./$i $TMPDIR $TIMEOUT > /dev/null 2>&1 &
> > +                     ./$i $TMPDIR/testfile $TIMEOUT > /dev/null 2>&1 &
> > +                     ./$j $TMPDIR $TIMEOUT > /dev/null 2>&1 &
> > +                     ./$j $TMPDIR/testfile $TIMEOUT > /dev/null 2>&1 &
> > +                     sleep $TIMEOUT
> > +                     cleanup_processes
> > +                     echo -e "$i $j" >> tmp
> > +                     ((rcnt++))
> > +             done
> > +     done
> > +}
> > +
> > +trap "cleanup; exit;" 2
> > +
> > +echo "***** Starting tests *****"
> > +run_stress
> > +
> > +echo -e "\n***** Cleanup fanotify inotify device *****"
> > +cleanup
>
> This could be easily rewritten in the LTP C API. We do have helper sofr
> most of the functionality that is reimplemented poorly in shell here.
>
> So the whole test should really be a single C source where the testrun
> forks children that runs the stress and I/O rutines that are currently
> in the $BINARIES and the main pid would watch over the execution.
>
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
