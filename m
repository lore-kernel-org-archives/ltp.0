From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2020 15:20:21 +0200
Subject: [LTP] [PATCH v4 2/6] fanotify: Handle supported features checks
 in setup()
In-Reply-To: <20201126214121.6836-3-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
 <20201126214121.6836-3-pvorel@suse.cz>
Message-ID: <CAOQ4uxhpMvwsOKRPVegkTWxOi2MqQNABtfQ7DyZQ1Z01nE5Cng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Nov 26, 2020 at 11:41 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Create 2 helpers which are used in various tests in setup() to check for
> FAN_ACCESS_PERM enablement (caused by disabled CONFIG_FANOTIFY_ACCESS_PERMISSIONS)
> or FAN_OPEN_EXEC and FAN_OPEN_EXEC_PERM support in kernel.
>
> That helps to further code simplification in next commit.
>
> Due this change test with FAN_OPEN_EXEC_PERM in fanotify03.c no longer
> needs to be a first test.
>
> Also rename variable s/support_exec_events/exec_events_unsupported/
> for readability.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

You may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Just one nit I wrote it in review and you must have missed it.
There is nothing related to "exec" in the helper.
It should be called fanotify_events_supported_by_kernel().

Thanks,
Amir.
