From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 09 Jun 2020 13:45:57 +0100
Subject: [LTP] [PATCH] read_all: scale down how many times we read by
 default
In-Reply-To: <33c4abf347e2de96f89b9acea02d731e47dbf2a9.1591700131.git.jstancek@redhat.com>
References: <33c4abf347e2de96f89b9acea02d731e47dbf2a9.1591700131.git.jstancek@redhat.com>
Message-ID: <877dwgxv96.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Jan Stancek <jstancek@redhat.com> writes:

> read_all is running into timeouts on high cpu systems, where
> access to some per-cpu files is protected by a lock. Latest
> example is /sys/kernel/tracing/per_cpu/*.
>
> At the moment we read each file 10 times, and we have been
> excluding files that take too long. Rather than expanding
> blacklist, scale the default down to 3.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/fs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/runtest/fs b/runtest/fs
> index 464ba8fb9686..5892e9fdaee5 100644
> --- a/runtest/fs
> +++ b/runtest/fs
> @@ -69,9 +69,9 @@ fs_di fs_di -d $TMPDIR
>  # Was not sure why it should reside in runtest/crashme and won't get tested ever
>  proc01 proc01 -m 128
>  
> -read_all_dev read_all -d /dev -p -q -r 10
> -read_all_proc read_all -d /proc -q -r 10
> -read_all_sys read_all -d /sys -q -r 10
> +read_all_dev read_all -d /dev -p -q -r 3
> +read_all_proc read_all -d /proc -q -r 3
> +read_all_sys read_all -d /sys -q -r 3
>  
>  #Run the File System Race Condition Check tests as well
>  fs_racer fs_racer.sh -t 5
> -- 
> 2.18.1

OK this makes sense. We shouldn't be stress testing the system in this
runtest file.

-- 
Thank you,
Richard.
