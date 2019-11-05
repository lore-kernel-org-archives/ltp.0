From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 5 Nov 2019 08:11:21 -0500 (EST)
Subject: [LTP] [PATCH 2/2] fanotify: Rename fanotify_event_info_fid
 struct
In-Reply-To: <20191105005341.19033-3-petr.vorel@gmail.com>
References: <20191105005341.19033-1-petr.vorel@gmail.com>
 <20191105005341.19033-3-petr.vorel@gmail.com>
Message-ID: <1570001833.10536641.1572959481303.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -133,17 +133,15 @@ struct fanotify_event_info_header {
>  	uint8_t pad;
>  	uint16_t len;
>  };
> +#endif /* ! FAN_REPORT_FID */
>  
>  #ifdef HAVE_NAME_TO_HANDLE_AT
> -struct fanotify_event_info_fid {
> +struct lapi_fanotify_event_info_fid {
>  	struct fanotify_event_info_header hdr;
>  	__kernel_fsid_t fsid;
>  	unsigned char handle[0];
>  };

I think I see what you mean by "mixing glibc/lapi/kernel types".
This structure could be combination of various types and now it's
used even if sys/fanotify.h provides one.

As alternative idea, we could add some accessor macro for that 'val' field.
On musl macro would return '__val', and elsewhere 'val'.

