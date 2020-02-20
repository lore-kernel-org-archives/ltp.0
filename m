From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2020 13:10:54 +0800
Subject: [LTP] [PATCH V2 01/10] tst_device: Add tst_ismount() helper
In-Reply-To: <199f58740e42bbdbcba0c847c194f62d2b3bb37b.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <199f58740e42bbdbcba0c847c194f62d2b3bb37b.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2d9DmK3-1hNH4Y-L+qikN7GXPbtguM7q4AQ__9is2MoPA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 19, 2020 at 5:28 PM Viresh Kumar <viresh.kumar@linaro.org>
wrote:

> This patch moves the ismount() helper added to the fsmount syscall tests
> to the standard library and renames it to tst_ismount(). The helper can
> be used across different files now.
>
> Minor modifications are also done to the helper.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
Acked-by: Li Wang <liwang@redhat.com>


> ---
> +/*
> + * Verifies if an earlier mount is successful or not.
> + * @path: Mount path to verify
> + */
> +int tst_ismount(const char *path);
>

I have slightly thought to rename it as 'tst_is_mounted(const char *path)',
but it also depends on other reviewer's opinion, I have no strong insist
here.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/88c19774/attachment.htm>
