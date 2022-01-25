Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6FAC433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 07:30:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C58683C932A
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 08:30:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4223C21D9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 08:30:01 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 704701400204
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 08:29:59 +0100 (CET)
Received: by mail-il1-x130.google.com with SMTP id u5so16059916ilq.9
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 23:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tCYIIfyuitjKZiTWdL5gys0xvkzewESYvs2dyNUtcpQ=;
 b=qw5k6ujVg1ayfT2TAUBeS4xyCcd25jKKUIDCpYAqDQykLAS/cSenOnr5MdpGacb50z
 NOdACD51p+31604j3BJLEmzdhvaPl0WsyT3mXZqTdq1dG3SZC5BoA7n21Y66gBTetoyQ
 gcVu9wW0wxsK7qBxxAasinazekUJr+KJZuLH8YwHWcfAQ7mq3PMU7gc9qfHaIGVzTuLs
 Ssonzf4G0nynsjdptJcwhosJ8FNFe7EXTOOxNrJ96qbTzUxNx4QKAKATRRWeZYVxIBhf
 OC6OtZyDBVKOfJcX3CtHcv4Jw8kJCbTx0f9oUniVXq5Q8dMPg5jIjDjtlywFS1gA9yKf
 +yLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tCYIIfyuitjKZiTWdL5gys0xvkzewESYvs2dyNUtcpQ=;
 b=TgkuZQO2S8w6vVu0WDvMOmfG1zHQGFS6OVOmF15nru1yz4qGwcTesBp0a703W2mHnD
 AxZwkoUIvf+oNdTZgLeYYID6dc+N4EaxZEcFPMnmtB4BI3+9jk69iX1G9LRkbqEV+pVr
 U9iwiIc30CbkhMKUvPH8lY5OfUQKEuXedS/csBE0ljpOwQ7LQVLcwgt3LQ3F2rdYoll5
 vH4E4Q9jCNBBpJHzoP9PyOf04DCwyhHQINhlhjW1fcFTUtjvLRrDC+/58MaplX2peKmH
 yvMwVY0HzT5S5RiV7Q2O1oI4Mf0MA7em5q+5e/xSrXCS/Bb0rV0R6Cx+ztUPX9UkTi2Q
 RDvw==
X-Gm-Message-State: AOAM532NeoP8wq/uGJ5JQjR6EGKG3UDH+YsEd+Xv3mV1/P519fJ7YB5z
 +8d87PmGP5WxqHhofxhTcb7PGhP6JzRV0K3tIWg=
X-Google-Smtp-Source: ABdhPJyhEgEKTvETW4M14JaHG7eDHyEtS6kkB7xBCiygmWndISjRqblibGotQKl4wUyP6sD8bYRruyCIqVA1bTTutqw=
X-Received: by 2002:a05:6e02:1785:: with SMTP id
 y5mr10576913ilu.24.1643095798030; 
 Mon, 24 Jan 2022 23:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
In-Reply-To: <20220125024718.jszwoussimqk6trf@xzhoux.usersys.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Jan 2022 09:29:47 +0200
Message-ID: <CAOQ4uxh4b-sPZqt4MMDFHWZVfJCp5ZAF=N-c-k-0mhzOyxLE_w@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jan 25, 2022 at 4:47 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> Exercise fsnotify and inotify interfaces while IO going on.

Hi Murphy,

It's worth documenting in main test script that this test
was created as a regression test for commit
4396a73115fc fsnotify: fix sb_connectors leak

Can you elaborate a bit more about the expectation from this test.
I do not see any error checking in the main script.
Is any perror supposed to fail the test?
Is its purpose to catch kernel dmesg splats of all sorts?

In your original post you wrote that bug makes the test hang:
https://lore.kernel.org/linux-fsdevel/20210907063338.ycaw6wvhzrfsfdlp@xzhoux.usersys.redhat.com/

If that is the case, better mention this to the LTP maintainers.

Thanks,
Amir.




>
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  testcases/kernel/fs/fs-notify/Makefile        |  18 ++
>  .../fs/fs-notify/fanotify_flush_stress.c      |  52 ++++
>  .../fs/fs-notify/fanotify_init_stress.c       |  32 +++
>  .../fs/fs-notify/fanotify_mark_stress.c       |  58 +++++
>  .../kernel/fs/fs-notify/fanotify_watch.c      | 244 ++++++++++++++++++
>  testcases/kernel/fs/fs-notify/freadfile.c     |  27 ++
>  .../kernel/fs/fs-notify/fsnotify-stress.sh    |  64 +++++
>  testcases/kernel/fs/fs-notify/fwritefile.c    |  27 ++
>  .../fs/fs-notify/inotify_add_rm_stress.c      |  36 +++
>  .../kernel/fs/fs-notify/inotify_init_stress.c |  22 ++
>  .../fs/fs-notify/inotify_inmodify_stress.c    |  17 ++
>  testcases/kernel/fs/fs-notify/inotify_watch.c |  98 +++++++
>  testcases/kernel/fs/fs-notify/readfile.c      |  28 ++
>  testcases/kernel/fs/fs-notify/rw_files.sh     |  90 +++++++
>  testcases/kernel/fs/fs-notify/writefile.c     |  28 ++
>  15 files changed, 841 insertions(+)
>  create mode 100644 testcases/kernel/fs/fs-notify/Makefile
>  create mode 100644 testcases/kernel/fs/fs-notify/fanotify_flush_stress.c
>  create mode 100644 testcases/kernel/fs/fs-notify/fanotify_init_stress.c
>  create mode 100644 testcases/kernel/fs/fs-notify/fanotify_mark_stress.c
>  create mode 100644 testcases/kernel/fs/fs-notify/fanotify_watch.c
>  create mode 100644 testcases/kernel/fs/fs-notify/freadfile.c
>  create mode 100755 testcases/kernel/fs/fs-notify/fsnotify-stress.sh
>  create mode 100644 testcases/kernel/fs/fs-notify/fwritefile.c
>  create mode 100644 testcases/kernel/fs/fs-notify/inotify_add_rm_stress.c
>  create mode 100644 testcases/kernel/fs/fs-notify/inotify_init_stress.c
>  create mode 100644 testcases/kernel/fs/fs-notify/inotify_inmodify_stress.c
>  create mode 100644 testcases/kernel/fs/fs-notify/inotify_watch.c
>  create mode 100644 testcases/kernel/fs/fs-notify/readfile.c
>  create mode 100755 testcases/kernel/fs/fs-notify/rw_files.sh
>  create mode 100644 testcases/kernel/fs/fs-notify/writefile.c
>
> diff --git a/testcases/kernel/fs/fs-notify/Makefile b/testcases/kernel/fs/fs-notify/Makefile
> new file mode 100644
> index 000000000..328783942
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/Makefile
> @@ -0,0 +1,18 @@
> +#
> +#    kernel/fs/fs-notify testcases Makefile.
> +#
> +
> +top_srcdir                     ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +BINARIES:=fanotify_flush_stress fanotify_init_stress \
> +fanotify_mark_stress fanotify_watch inotify_watch \
> +inotify_add_rm_stress inotify_init_stress inotify_inmodify_stress\
> +writefile freadfile fwritefile readfile
> +
> +INSTALL_TARGETS                        := fsnotify-stress.sh $(BINARIES) rw_files.sh
> +
> +MAKE_TARGETS                   := $(BINARIES)
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/fs/fs-notify/fanotify_flush_stress.c b/testcases/kernel/fs/fs-notify/fanotify_flush_stress.c
> new file mode 100644
> index 000000000..493acfb56
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/fanotify_flush_stress.c
> @@ -0,0 +1,52 @@
> +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/fanotify.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       char buf;
> +       int fd;
> +
> +       /* Create the file descriptor for accessing the fanotify API */
> +       fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +                                          O_RDONLY | O_LARGEFILE);
> +       if (fd == -1) {
> +               perror("fanotify_init");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* Loop marking all kinds of events and flush */
> +       while (1) {
> +
> +               if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +                         FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> +                         FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> +                         FAN_EVENT_ON_CHILD, -1, argv[1]) == -1)
> +
> +                       perror("fanotify_mark add");
> +
> +               if (fanotify_mark(fd, FAN_MARK_FLUSH | FAN_MARK_MOUNT,
> +                                               0, -1, argv[1]) == -1)
> +                       perror("fanotify_mark flush mount");
> +
> +               if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +                         FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM | FAN_CLOSE |
> +                         FAN_OPEN | FAN_ACCESS_PERM | FAN_ONDIR |
> +                         FAN_EVENT_ON_CHILD, -1, argv[1]) == -1)
> +
> +                       perror("fanotify_mark add");
> +
> +               if (fanotify_mark(fd, FAN_MARK_FLUSH, 0, -1, argv[1]) == -1)
> +                       perror("fanotify_mark flush");
> +       }
> +
> +       close(fd);
> +       exit(EXIT_SUCCESS);
> +}
> diff --git a/testcases/kernel/fs/fs-notify/fanotify_init_stress.c b/testcases/kernel/fs/fs-notify/fanotify_init_stress.c
> new file mode 100644
> index 000000000..d11924b57
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/fanotify_init_stress.c
> @@ -0,0 +1,32 @@
> +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> +#include <errno.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <sys/fanotify.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       char buf;
> +       int fd;
> +       while (1) {
> +
> +               /* Create the file descriptor for accessing the fanotify API */
> +               fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT |
> +                               FAN_NONBLOCK, O_RDONLY | O_LARGEFILE);
> +               if (fd == -1)
> +                       perror("fanotify_init");
> +
> +               if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +                               FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
> +                               FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
> +                               FAN_ONDIR | FAN_EVENT_ON_CHILD, -1,
> +                               argv[1]) == -1)
> +                       perror("fanotify_mark");
> +
> +               close(fd);
> +       }
> +
> +       exit(EXIT_SUCCESS);
> +}
> diff --git a/testcases/kernel/fs/fs-notify/fanotify_mark_stress.c b/testcases/kernel/fs/fs-notify/fanotify_mark_stress.c
> new file mode 100644
> index 000000000..7f648e103
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/fanotify_mark_stress.c
> @@ -0,0 +1,58 @@
> +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/fanotify.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +void add_mark(int fd, uint64_t mask, char *path)
> +{
> +       if (fanotify_mark(fd, FAN_MARK_ADD, mask, -1, path) == -1)
> +               perror("fanotify_mark add");
> +}
> +
> +void remove_mark(int fd, uint64_t mask, char *path)
> +{
> +       if (fanotify_mark(fd, FAN_MARK_REMOVE, mask, -1, path) == -1)
> +               perror("fanotify_mark remove");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       char buf;
> +       int fd;
> +       /* Create the file descriptor for accessing the fanotify API */
> +       fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +                                          O_RDONLY | O_LARGEFILE);
> +       if (fd == -1) {
> +               perror("fanotify_init");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* Loop marking all kinds of events */
> +       while (1) {
> +               add_mark(fd, FAN_ACCESS, argv[1]);
> +               remove_mark(fd, FAN_ACCESS, argv[1]);
> +               add_mark(fd, FAN_MODIFY, argv[1]);
> +               remove_mark(fd, FAN_MODIFY, argv[1]);
> +               add_mark(fd, FAN_OPEN_PERM, argv[1]);
> +               remove_mark(fd, FAN_OPEN_PERM, argv[1]);
> +               add_mark(fd, FAN_CLOSE, argv[1]);
> +               remove_mark(fd, FAN_CLOSE, argv[1]);
> +               add_mark(fd, FAN_OPEN, argv[1]);
> +               remove_mark(fd, FAN_OPEN, argv[1]);
> +               add_mark(fd, FAN_ACCESS_PERM, argv[1]);
> +               remove_mark(fd, FAN_ACCESS_PERM, argv[1]);
> +               add_mark(fd, FAN_ONDIR, argv[1]);
> +               remove_mark(fd, FAN_ONDIR, argv[1]);
> +               add_mark(fd, FAN_EVENT_ON_CHILD, argv[1]);
> +               remove_mark(fd, FAN_EVENT_ON_CHILD, argv[1]);
> +       }
> +
> +       close(fd);
> +       exit(EXIT_SUCCESS);
> +}
> diff --git a/testcases/kernel/fs/fs-notify/fanotify_watch.c b/testcases/kernel/fs/fs-notify/fanotify_watch.c
> new file mode 100644
> index 000000000..1028e0e30
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/fanotify_watch.c
> @@ -0,0 +1,244 @@
> +/* Example in man 7 fanotify */
> +
> +#define _GNU_SOURCE     /* Needed to get O_LARGEFILE definition */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>
> +#include <poll.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/fanotify.h>
> +#include <unistd.h>
> +#include <string.h>
> +
> +/* get comm for pid from /proc/pid/comm */
> +static char * get_comm_pid(unsigned int pid)
> +{
> +       char * proc_name;
> +       char * comm;
> +       int comm_fd, cnt;
> +
> +       proc_name = (char *)malloc(50);
> +       if (proc_name != NULL)
> +               sprintf(proc_name, "/proc/%u/comm\0", pid);
> +       else
> +               return NULL;
> +
> +       comm = (char *)malloc(50);
> +       if (comm != NULL)
> +               memset(comm, 0, 50);
> +       else
> +               return NULL;
> +
> +       comm_fd = open(proc_name, O_RDONLY);
> +       if (comm_fd != -1) {
> +               cnt = read(comm_fd, comm, 50);
> +               if (cnt != -1) {
> +                       comm[cnt] = '\0';
> +                       close(comm_fd);
> +                       return comm;
> +               }
> +               close(comm_fd);
> +       }
> +
> +       return NULL;
> +}
> +
> +/* Read all available fanotify events from the file descriptor 'fd' */
> +
> +static void handle_events(int fd)
> +{
> +       const struct fanotify_event_metadata *metadata;
> +       struct fanotify_event_metadata buf[200];
> +       ssize_t len;
> +       char path[PATH_MAX];
> +       ssize_t path_len;
> +       char procfd_path[PATH_MAX];
> +       struct fanotify_response response;
> +
> +       /* Loop while events can be read from fanotify file descriptor */
> +       for(;;) {
> +
> +               /* Read some events */
> +               len = read(fd, (void *) &buf, sizeof(buf));
> +               if (len == -1 && errno != EAGAIN) {
> +                       perror("read");
> +                       exit(EXIT_FAILURE);
> +               }
> +
> +               /* Check if end of available data reached */
> +               if (len <= 0)
> +                       break;
> +
> +               /* Point to the first event in the buffer */
> +               metadata = buf;
> +
> +               /* Loop over all events in the buffer */
> +               while (FAN_EVENT_OK(metadata, len)) {
> +
> +                       /* Check that run-time and compile-time structures match */
> +
> +                       if (metadata->vers != FANOTIFY_METADATA_VERSION) {
> +                               fprintf(stderr,
> +                                   "Mismatch of fanotify metadata version.\n");
> +                               exit(EXIT_FAILURE);
> +                       }
> +
> +                       /* metadata->fd contains either FAN_NOFD, indicating a
> +                          queue overflow, or a file descriptor (a nonnegative
> +                          integer). Here, we simply ignore queue overflow. */
> +
> +                       if (metadata->fd >= 0) {
> +
> +                               /* Handle open permission event */
> +                               if (metadata->mask & FAN_OPEN_PERM) {
> +                                       printf("FAN_OPEN_PERM: ");
> +
> +                                       /* Allow file to be opened */
> +                                       response.fd = metadata->fd;
> +                                       response.response = FAN_ALLOW;
> +                                       write(fd, &response,
> +                                           sizeof(struct fanotify_response));
> +                               }
> +
> +                               /* Handle access permission event */
> +                               if (metadata->mask & FAN_ACCESS_PERM) {
> +                                       printf("FAN_ACCESS_PERM: ");
> +
> +                                       /* Allow file to be accessed */
> +                                       response.fd = metadata->fd;
> +                                       response.response = FAN_ALLOW;
> +                                       write(fd, &response,
> +                                           sizeof(struct fanotify_response));
> +                               }
> +
> +                               /* Handle closing of writable file event */
> +                               if (metadata->mask & FAN_CLOSE_WRITE)
> +                                       printf("FAN_CLOSE_WRITE: ");
> +
> +                               /* Handle closing of not writable file event */
> +                               if (metadata->mask & FAN_CLOSE_NOWRITE)
> +                                       printf("FAN_CLOSE_NOWRITE: ");
> +
> +                               /* Handle modify file event */
> +                               if (metadata->mask & FAN_MODIFY)
> +                                       printf("FAN_MODIFY: ");
> +
> +                               /* Handle open event */
> +                               if (metadata->mask & FAN_OPEN)
> +                                       printf("FAN_OPEN: ");
> +
> +                               /* Handle access event */
> +                               if (metadata->mask & FAN_ACCESS)
> +                                       printf("FAN_ACCESS: ");
> +
> +                               /* Handle access event */
> +                               if (metadata->mask & FAN_ONDIR)
> +                                       printf("FAN_ONDIR: ");
> +
> +                               /* Handle access event */
> +                               if (metadata->mask & FAN_EVENT_ON_CHILD)
> +                                       printf("FAN_EVENT_ON_CHILD: ");
> +
> +                               /* Retrieve/print the accessed file path*/
> +                               snprintf(procfd_path, sizeof(procfd_path),
> +                                           "/proc/self/fd/%d", metadata->fd);
> +                               path_len = readlink(procfd_path, path,
> +                                           sizeof(path) - 1);
> +                               if (path_len == -1) {
> +                                       perror("readlink");
> +                                       exit(EXIT_FAILURE);
> +                               }
> +
> +                               path[path_len] = '\0';
> +                               printf("File %s.\t\t Comm %s", path,
> +                                       get_comm_pid(metadata->pid));
> +
> +                               /* Close the file descriptor of the event */
> +
> +                               close(metadata->fd);
> +                       }
> +
> +                       /* Advance to next event */
> +                       metadata = FAN_EVENT_NEXT(metadata, len);
> +               }
> +       }
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       char buf;
> +       int fd, poll_num;
> +       nfds_t nfds;
> +       struct pollfd fds[2];
> +       FILE *f;
> +#if 0
> +       /* Check mount point is supplied */
> +       if (argc != 2) {
> +               fprintf(stderr, "Usage: %s MOUNT\n", argv[0]);
> +               exit(EXIT_FAILURE);
> +       }
> +#endif
> +       printf("%s on %s\n", argv[0], argv[1]);
> +       fflush(stdout);
> +       f = freopen("fanotify.log", "w+", stdout);
> +       if (f == NULL) {
> +               perror("freopen");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* Create the file descriptor for accessing the fanotify API */
> +       fd = fanotify_init(FAN_CLOEXEC | FAN_CLASS_CONTENT | FAN_NONBLOCK,
> +                                          O_RDONLY | O_LARGEFILE);
> +       if (fd == -1) {
> +               perror("fanotify_init");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* Mark the mount for:
> +          - permission events before opening files
> +          - notification events after closing a write-enabled
> +                file descriptor */
> +       if (fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> +                       FAN_ACCESS | FAN_MODIFY | FAN_OPEN_PERM |
> +                       FAN_CLOSE | FAN_OPEN | FAN_ACCESS_PERM |
> +                       FAN_ONDIR | FAN_EVENT_ON_CHILD,
> +                       -1, argv[1]) == -1) {
> +
> +               perror("fanotify_mark");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       /* Prepare for polling */
> +       nfds = 1;
> +
> +       /* Fanotify input */
> +       fds[0].fd = fd;
> +       fds[0].events = POLLIN;
> +
> +       /* This is the loop to wait for incoming events */
> +       printf("Listening for events.\n");
> +       while (1) {
> +               poll_num = poll(fds, nfds, -1);
> +               if (poll_num == -1) {
> +                       if (errno == EINTR)     /* Interrupted by a signal */
> +                               continue;           /* Restart poll() */
> +
> +                       perror("poll");         /* Unexpected error */
> +                       exit(EXIT_FAILURE);
> +               }
> +
> +               if (poll_num > 0) {
> +
> +                       if (fds[0].revents & POLLIN) {
> +
> +                               /* Fanotify events are available */
> +                               handle_events(fd);
> +                       }
> +               }
> +       }
> +
> +       fclose(f);
> +       printf("Listening for events stopped.\n");
> +       exit(EXIT_SUCCESS);
> +}
> diff --git a/testcases/kernel/fs/fs-notify/freadfile.c b/testcases/kernel/fs/fs-notify/freadfile.c
> new file mode 100644
> index 000000000..24bf76bcd
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/freadfile.c
> @@ -0,0 +1,27 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +int main(int argc, char **argv)
> +{
> +       int fd;
> +       char buf[BUFSIZ];
> +       FILE *f;
> +
> +       memset(buf, 1, BUFSIZ);
> +       while(1) {
> +               f = fopen(argv[1], "r+");
> +               if (f == NULL) {
> +                       perror("freadfile fopen");
> +                       exit(EXIT_FAILURE);
> +               }
> +               fread(buf, sizeof(char), BUFSIZ, f);
> +               usleep(1);
> +       }
> +       fclose(f);
> +       return 0;
> +}
> diff --git a/testcases/kernel/fs/fs-notify/fsnotify-stress.sh b/testcases/kernel/fs/fs-notify/fsnotify-stress.sh
> new file mode 100755
> index 000000000..d6fd5482b
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/fsnotify-stress.sh
> @@ -0,0 +1,64 @@
> +#!/bin/bash
> +
> +export TIMEOUT=10
> +
> +STRESSES="fanotify_flush_stress fanotify_init_stress \
> +fanotify_mark_stress fanotify_watch inotify_watch \
> +inotify_add_rm_stress inotify_init_stress inotify_inmodify_stress"
> +IO_OPES="writefile freadfile fwritefile readfile"
> +
> +NR_CPUS=$(grep -c processor /proc/cpuinfo)
> +[ $NR_CPUS -lt 4 ] && NR_CPUS=4
> +
> +function cleanup_processes()
> +{
> +       while ps -eo pid,comm | \
> +               grep -q -E "fanotify|inotify|rw_files|readfile|writefile" ; do
> +               killall rw_files.sh $STRESSES $IO_OPES > /dev/null 2>&1
> +               sleep 1
> +       done
> +}
> +
> +function cleanup()
> +{
> +       sleep 3 # waiting possible unfinished processes
> +       cleanup_processes
> +       rm -f $STRESSES $IO_OPES fanotify.log inotify.log tmp
> +       cd /
> +       sync
> +}
> +
> +function run_stress()
> +{
> +       local i j rcnt=0
> +       echo -e "* CPU count: $NR_CPUS"
> +       echo -e "* TIMEOUT for each subcase: $TIMEOUT"
> +
> +       echo -e "* Starting fsnotify stress on directory and regular file"
> +       touch $TMPDIR/testfile
> +       >tmp
> +       for i in $STRESSES $IO_OPES rw_files.sh; do
> +               for j in $STRESSES ; do
> +                       [ "$i" == "$j" ] && continue
> +                       # skip duplicate combinations
> +                       grep -w $j tmp | grep -qw $i && continue
> +                       echo -e "* Starting $i and $j, rcnt $rcnt"
> +                       ./$i $TMPDIR $TIMEOUT > /dev/null 2>&1 &
> +                       ./$i $TMPDIR/testfile $TIMEOUT > /dev/null 2>&1 &
> +                       ./$j $TMPDIR $TIMEOUT > /dev/null 2>&1 &
> +                       ./$j $TMPDIR/testfile $TIMEOUT > /dev/null 2>&1 &
> +                       sleep $TIMEOUT
> +                       cleanup_processes
> +                       echo -e "$i $j" >> tmp
> +                       ((rcnt++))
> +               done
> +       done
> +}
> +
> +trap "cleanup; exit;" 2
> +
> +echo "***** Starting tests *****"
> +run_stress
> +
> +echo -e "\n***** Cleanup fanotify inotify device *****"
> +cleanup
> diff --git a/testcases/kernel/fs/fs-notify/fwritefile.c b/testcases/kernel/fs/fs-notify/fwritefile.c
> new file mode 100644
> index 000000000..a2956d60b
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/fwritefile.c
> @@ -0,0 +1,27 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +int main(int argc, char **argv)
> +{
> +       int fd;
> +       char buf[BUFSIZ];
> +       FILE *f;
> +
> +       memset(buf, 1, BUFSIZ);
> +       while(1) {
> +               f = fopen(argv[1], "w+");
> +               if (f == NULL) {
> +                       perror("fwritefile fopen");
> +                       exit(EXIT_FAILURE);
> +               }
> +               fwrite(buf, sizeof(char), BUFSIZ, f);
> +               usleep(1);
> +       }
> +       fclose(f);
> +       return 0;
> +}
> diff --git a/testcases/kernel/fs/fs-notify/inotify_add_rm_stress.c b/testcases/kernel/fs/fs-notify/inotify_add_rm_stress.c
> new file mode 100644
> index 000000000..e88fc088e
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/inotify_add_rm_stress.c
> @@ -0,0 +1,36 @@
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <dirent.h>
> +#include <stdio.h>
> +#include <sys/inotify.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       int notify_fd;
> +       int wd, ret;
> +
> +       notify_fd = inotify_init1(IN_CLOEXEC);
> +       if (notify_fd == -1) {
> +               perror("inotify_init1");
> +               return -1;
> +       }
> +
> +       while (1) {
> +               wd = inotify_add_watch(notify_fd, argv[1],
> +                       IN_ACCESS | IN_ATTRIB | IN_CLOSE_WRITE |
> +                       IN_CLOSE_NOWRITE | IN_CREATE | IN_DELETE |
> +                       IN_DELETE_SELF | IN_MODIFY | IN_MOVE_SELF |
> +                       IN_MOVED_FROM | IN_MOVED_TO | IN_OPEN);
> +               if (wd < 0)
> +                       perror("inotify_add_watch");
> +
> +               ret = inotify_rm_watch(notify_fd, wd);
> +               if (ret < 0)
> +                       perror("inotify_rm_watch");
> +       }
> +       close(notify_fd);
> +       return 0;
> +}
> diff --git a/testcases/kernel/fs/fs-notify/inotify_init_stress.c b/testcases/kernel/fs/fs-notify/inotify_init_stress.c
> new file mode 100644
> index 000000000..62cb7c2e6
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/inotify_init_stress.c
> @@ -0,0 +1,22 @@
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <dirent.h>
> +#include <stdio.h>
> +#include <sys/inotify.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       int notify_fd;
> +       int wd;
> +
> +       while (1) {
> +               notify_fd = inotify_init1(IN_CLOEXEC);
> +               if (notify_fd == -1)
> +                       perror("inotify_init1");
> +               close(notify_fd);
> +       }
> +       return 0;
> +}
> diff --git a/testcases/kernel/fs/fs-notify/inotify_inmodify_stress.c b/testcases/kernel/fs/fs-notify/inotify_inmodify_stress.c
> new file mode 100644
> index 000000000..546ccb76f
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/inotify_inmodify_stress.c
> @@ -0,0 +1,17 @@
> +#include <sys/inotify.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +/*
> + * Calls inotify_rm_watch in a loop.
> + */
> +int main(int argc, char **argv)
> +{
> +       int fd = inotify_init();
> +       while (1) {
> +               int wd = inotify_add_watch(fd, argv[1], IN_MODIFY);
> +               inotify_rm_watch(fd, wd);
> +       }
> +       close(fd);
> +       return 0;
> +}
> diff --git a/testcases/kernel/fs/fs-notify/inotify_watch.c b/testcases/kernel/fs/fs-notify/inotify_watch.c
> new file mode 100644
> index 000000000..b4b908b6b
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/inotify_watch.c
> @@ -0,0 +1,98 @@
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <dirent.h>
> +#include <stdio.h>
> +#include <sys/inotify.h>
> +
> +int main(int argc, char *argv[])
> +{
> +       int notify_fd;
> +       int wd, ret;
> +       char *buf;
> +       FILE *f;
> +
> +       f = freopen("inotify.log", "w+", stdout);
> +       if (f == NULL) {
> +               perror("freopen");
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       buf = malloc(sizeof(struct inotify_event) + NAME_MAX + 1);
> +       if (buf == NULL) {
> +               perror("malloc");
> +               return -1;
> +       }
> +
> +       notify_fd = inotify_init1(IN_CLOEXEC);
> +       if (notify_fd == -1) {
> +               perror("inotify_init1");
> +               return -1;
> +       }
> +
> +       wd = inotify_add_watch(notify_fd, argv[1],
> +               IN_ACCESS | IN_ATTRIB | IN_CLOSE_WRITE | IN_CLOSE_NOWRITE |
> +               IN_CREATE | IN_DELETE | IN_DELETE_SELF | IN_MODIFY |
> +               IN_MOVE_SELF | IN_MOVED_FROM | IN_MOVED_TO | IN_OPEN);
> +
> +       if (wd < 0) {
> +               perror("inotify_add_watch");
> +               return -1;
> +       }
> +
> +       while (ret = read(notify_fd, buf, NAME_MAX) != -1) {
> +               struct inotify_event *ip = (struct inotify_event *)buf;
> +               printf("name %s event ", ip->name);
> +               switch (ip->mask) {
> +               case IN_ACCESS:
> +                       printf("access\n");
> +                       break;
> +               case IN_ATTRIB:
> +                       printf("attrib\n");
> +                       break;
> +               case IN_CLOSE_WRITE:
> +                       printf("close write\n");
> +                       break;
> +               case IN_CLOSE_NOWRITE:
> +                       printf("close nowrite\n");
> +                       break;
> +               case IN_CREATE:
> +                       printf("create\n");
> +                       break;
> +               case IN_DELETE:
> +                       printf("delete\n");
> +                       break;
> +               case IN_DELETE_SELF:
> +                       printf("deleteself\n");
> +                       break;
> +               case IN_MODIFY:
> +                       printf("modify\n");
> +                       break;
> +               case IN_MOVE_SELF:
> +                       printf("move self\n");
> +                       break;
> +               case IN_MOVED_FROM:
> +                       printf("move from\n");
> +                       break;
> +               case IN_MOVED_TO:
> +                       printf("move to\n");
> +                       break;
> +               case IN_OPEN:
> +                       printf("open\n");
> +                       break;
> +               default:
> +                       printf("\n");
> +                       break;
> +               };
> +       }
> +
> +       ret = inotify_rm_watch(notify_fd, wd);
> +       if (ret < 0)
> +               perror("inotify_rm_watch");
> +
> +       fclose(f);
> +       close(notify_fd);
> +       return 0;
> +}
> diff --git a/testcases/kernel/fs/fs-notify/readfile.c b/testcases/kernel/fs/fs-notify/readfile.c
> new file mode 100644
> index 000000000..2ab1a3694
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/readfile.c
> @@ -0,0 +1,28 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +int main(int argc, char **argv)
> +{
> +       int fd, ret;
> +       char buf[BUFSIZ];
> +
> +       memset(buf, 1, BUFSIZ);
> +       while (1) {
> +               fd = open(argv[1], O_RDWR);
> +               if (fd == -1) {
> +                       perror("readfile open");
> +                       exit(EXIT_FAILURE);
> +               }
> +               ret = read(fd, buf, BUFSIZ);
> +               if (ret == -1)
> +                       perror("readfile read");
> +               usleep(1);
> +       }
> +       close(fd);
> +       return 0;
> +}
> diff --git a/testcases/kernel/fs/fs-notify/rw_files.sh b/testcases/kernel/fs/fs-notify/rw_files.sh
> new file mode 100755
> index 000000000..bb3387160
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/rw_files.sh
> @@ -0,0 +1,90 @@
> +#!/bin/bash
> +
> +TDIR=$1
> +TIMEO=$2
> +
> +[ -z "$TDIR" ] && TDIR=/tmp/
> +[ -d $TDIR ] || TDIR=/tmp/
> +[ -z "$TIMEO" ] && TIMEO=1m
> +
> +[ ! -d $TDIR ] && exit
> +
> +function add_files()
> +{
> +       local i=0
> +
> +       while true ; do
> +
> +               touch f-$i
> +               ln -s f-$i f-$i-sym
> +               ln f-$i f-$i-hdl
> +
> +               mkdir d-$i
> +
> +               mknod c-$i c 1 2
> +               mknod b-$i b 1 2
> +               mknod p-$i p
> +
> +               ((i++))
> +               [ -e stoptest ] && { echo $FUNCNAME; exit; }
> +       done
> +}
> +
> +function mv_files()
> +{
> +       local i=0
> +
> +       while true ; do
> +
> +               mv -f f-$i f-$i-rename
> +               mv -f f-$i-rename f-$i
> +               ((i++))
> +               [ -e stoptest ] && { echo $FUNCNAME; exit; }
> +       done
> +}
> +
> +function read_files()
> +{
> +       while true ; do
> +
> +               find .
> +               cat f-*
> +               ls d-*
> +               [ -e stoptest ] && { echo $FUNCNAME; exit; }
> +       done
> +}
> +
> +function write_files()
> +{
> +       while true ; do
> +
> +               for j in f-* d-* c-* b-* p-* ; do
> +                       echo 1 > $j
> +                       echo 2 >> $j
> +                       [ -e stoptest ] && { echo $FUNCNAME; exit; }
> +               done
> +               [ -e stoptest ] && { echo $FUNCNAME; exit; }
> +       done
> +}
> +
> +function rm_files()
> +{
> +       while true ; do
> +
> +               rm -rf d-* f-* c-* b-* p-*
> +               sleep 3
> +               [ -e stoptest ] && { echo $FUNCNAME; exit; }
> +       done
> +}
> +
> +pushd $TDIR > /dev/null 2>&1
> +rm -f stoptest
> +add_files > /dev/null 2>&1 &
> +mv_files > /dev/null 2>&1 &
> +read_files > /dev/null 2>&1 &
> +write_files > /dev/null 2>&1 &
> +rm_files > /dev/null 2>&1 &
> +popd > /dev/null 2>&1
> +
> +sleep $TIMEO
> +touch $TDIR/stoptest
> diff --git a/testcases/kernel/fs/fs-notify/writefile.c b/testcases/kernel/fs/fs-notify/writefile.c
> new file mode 100644
> index 000000000..9025b5d95
> --- /dev/null
> +++ b/testcases/kernel/fs/fs-notify/writefile.c
> @@ -0,0 +1,28 @@
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +
> +int main(int argc, char **argv)
> +{
> +       int fd, ret;
> +       char buf[BUFSIZ];
> +
> +       memset(buf, 1, BUFSIZ);
> +       while (1) {
> +               fd = open(argv[1], O_RDWR);
> +               if (fd == -1) {
> +                       perror("writefile open");
> +                       exit(EXIT_FAILURE);
> +               }
> +               ret = write(fd, buf, BUFSIZ);
> +               if (ret == -1)
> +                       perror("writefile write");
> +               usleep(1);
> +       }
> +       close(fd);
> +       return 0;
> +}
> --
> 2.31.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
