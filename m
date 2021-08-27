From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 27 Aug 2021 11:35:43 +0100
Subject: [LTP] [PATCH] userns/userns08.c: Enable userns in
 max_user_namespaces file
In-Reply-To: <1628144855-5924-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1628144855-5924-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87h7fbkwe8.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Yang,

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> On old distros ie centos7, the default value of max_user_namespaces is set to 0.
> Enable it by increasing this value.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Looks good, except for very minor point below.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  testcases/kernel/containers/userns/userns08.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
> index aedfc6c4e..0910ea7d4 100644
> --- a/testcases/kernel/containers/userns/userns08.c
> +++ b/testcases/kernel/containers/userns/userns08.c
> @@ -120,6 +120,11 @@ static void setup(void)
>  
>  	SAFE_WRITE(fd, 1, "\n", 1);
>  	SAFE_CLOSE(fd);
> +
> +	/* The default value of max_user_namespaces is set to 0 on some distros,
> +	 * We need to change the default value to call clone().
> +	 */

We don't need inline comments like this. In this case the commit message
and git-blame is fine. Other times the style guide requests it goes in
the comment at the top.

-- 
Thank you,
Richard.
