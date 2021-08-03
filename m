From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Aug 2021 11:42:16 +0300
Subject: [LTP] [PATCH 2/7] syscalls/fanotify20: Validate the generic
 error info
In-Reply-To: <20210802214645.2633028-3-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-3-krisman@collabora.com>
Message-ID: <CAOQ4uxhDUZND7Ak9vL-_vR50KSoewyKNzFsTsGP+UeDQmB2Rhg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Implement some validation for the generic error info record emitted by
> the kernel.  The error number is fs-specific but, well, we only support
> ext4 for now anyway.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 59 ++++++++++++++++++-
>  1 file changed, 58 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index 50531bd99cc9..fd5cfb8744f1 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -37,6 +37,14 @@
>
>  #ifndef FAN_FS_ERROR
>  #define FAN_FS_ERROR           0x00008000
> +
> +#define FAN_EVENT_INFO_TYPE_ERROR      4
> +
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       __s32 error;
> +       __u32 error_count;
> +};
>  #endif

Those defines go in fanotify.h

>
>  #define BUF_SIZE 256
> @@ -47,11 +55,54 @@ int fd_notify;
>
>  static const struct test_case {
>         char *name;
> +       int error;
> +       unsigned int error_count;
>         void (*trigger_error)(void);
>         void (*prepare_fs)(void);
>  } testcases[] = {
>  };
>
> +struct fanotify_event_info_header *get_event_info(
> +                                       struct fanotify_event_metadata *event,
> +                                       int info_type)
> +{
> +       struct fanotify_event_info_header *hdr = NULL;
> +       char *start = (char *) event;
> +       int off;
> +
> +       for (off = event->metadata_len; (off+sizeof(*hdr)) < event->event_len;
> +            off += hdr->len) {
> +               hdr = (struct fanotify_event_info_header *) &(start[off]);
> +               if (hdr->info_type == info_type)
> +                       return hdr;
> +       }
> +       return NULL;
> +}
> +
> +#define get_event_info_error(event)                                    \
> +       ((struct fanotify_event_info_error *)                           \
> +        get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))

This helper and macro would be very useful in fanotify.h for other tests to use.

Thanks,
Amir.
