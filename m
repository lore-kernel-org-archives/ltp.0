From: Li Wang <liwang@redhat.com>
Date: Mon, 23 Mar 2020 17:10:56 +0800
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200320134937.16616-2-pvorel@suse.cz>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <20200320134937.16616-2-pvorel@suse.cz>
Message-ID: <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Fri, Mar 20, 2020 at 9:50 PM Petr Vorel <pvorel@suse.cz> wrote:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/add_key/add_key05.c   | 15 ++-------------
>  testcases/kernel/syscalls/quotactl/quotactl01.c | 14 ++------------
>  testcases/kernel/syscalls/quotactl/quotactl06.c | 12 +-----------


Apart from the three, do you consider converting to SAFE_RUNCMD for the
rest testcases?
(it seems not too much work remaining since only a few test case uses
tst_run_cmd)

kernel/syscalls/setpriority/setpriority01.c
kernel/syscalls/copy_file_range/copy_file_range02.c
...


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200323/609ae5f1/attachment.htm>
