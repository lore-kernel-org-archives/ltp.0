From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Aug 2021 11:56:31 +0300
Subject: [LTP] [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
In-Reply-To: <20210802214645.2633028-4-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-4-krisman@collabora.com>
Message-ID: <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 3, 2021 at 12:47 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Verify the FID provided in the event.  If the testcase has a null inode,
> this is assumed to be a superblock error (i.e. null FH).
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify20.c     | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index fd5cfb8744f1..d8d788ae685f 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -40,6 +40,14 @@
>
>  #define FAN_EVENT_INFO_TYPE_ERROR      4
>
> +#ifndef FILEID_INVALID
> +#define        FILEID_INVALID          0xff
> +#endif
> +
> +#ifndef FILEID_INO32_GEN
> +#define FILEID_INO32_GEN       1
> +#endif
> +
>  struct fanotify_event_info_error {
>         struct fanotify_event_info_header hdr;
>         __s32 error;
> @@ -57,6 +65,9 @@ static const struct test_case {
>         char *name;
>         int error;
>         unsigned int error_count;
> +
> +       /* inode can be null for superblock errors */
> +       unsigned int *inode;

Any reason not to use fanotify_fid_t * like fanotify16.c?

Thanks,
Amir.
