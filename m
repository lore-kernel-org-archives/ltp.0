From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Fri, 1 May 2020 18:09:04 +1000
Subject: [LTP] [PATCH 2/4] syscalls/fanotify15: Minor corrections
In-Reply-To: <20200421065002.12417-3-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-3-amir73il@gmail.com>
Message-ID: <20200501080902.GA2782@morpheus.bobrowski.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 21, 2020 at 09:50:00AM +0300, Amir Goldstein wrote:
>  static void do_test(void)
> @@ -55,23 +61,24 @@ static void do_test(void)
>  	struct fanotify_event_metadata *metadata;
>  	struct fanotify_event_info_fid *event_fid;
>  
> +

^ Unnecessary white line entered here?

>  	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> -				FAN_CREATE | FAN_DELETE | FAN_ATTRIB |
> -				FAN_MOVED_FROM | FAN_MOVED_TO |
> -				FAN_DELETE_SELF | FAN_ONDIR,
> +				FAN_CREATE | FAN_DELETE | FAN_MOVE |
> +				FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR,
>  				AT_FDCWD, TEST_DIR) == -1) {

...

> -	/* Generate a sequence of events */
> +	/* All dirent events on testdir are merged */
>  	event_set[count].mask = FAN_CREATE | FAN_MOVED_FROM | FAN_MOVED_TO | \
>  				FAN_DELETE;

Just a suggestion, perhaps we can modify the above line to the following:

	event_set[count].mask = FAN_CREATE | FAN_MOVE | FAN_DELETE;

Also, I believe that we can generally replace all instances of
FAN_MOVED_FROM | FAN_MOVED_TO with FAN_MOVE within this file.

The rest looks good to me.

Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

/M
