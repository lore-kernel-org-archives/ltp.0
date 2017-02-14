From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Feb 2017 08:23:12 -0500 (EST)
Subject: [LTP] [PATCH 3/4] newlib: Allow SAFE_MACROS to be called
	from	cleanup
In-Reply-To: <20170214122639.442-3-chrubis@suse.cz>
References: <20170214122639.442-1-chrubis@suse.cz>
 <20170214122639.442-3-chrubis@suse.cz>
Message-ID: <350522678.4314423.1487078592694.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> diff --git a/doc/test-writing-guidelines.txt
> b/doc/test-writing-guidelines.txt
> index 41cee58..cec4bdc 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -341,9 +341,6 @@ cleanup() callback.
>     initialized. (Some of the steps may not depend on others and everything
>     will work if there were swapped but let's keep it in order.)
>  
> -3. Avoid using SAFE_MACROS() in cleanup if you want the cleanup to carry on
> -   when a cleanup step has failed.
> -
>  The first rule may seem complicated at first however, on the contrary, it's
>  quite easy. All you have to do is to keep track of what was already
>  initialized. For example file descriptors needs to be closed only if they
>  were
> @@ -381,11 +378,11 @@ requires extra flag to be set after device was
> successfully mounted.

Code is straight-forward, but maybe we should add a sentence or two
to docs to clarify what happens when you call SAFE_MACRO in cleanup:
1) cleanup continues to run and
2) TBROK errors are reported as TWARN

Regards,
Jan
