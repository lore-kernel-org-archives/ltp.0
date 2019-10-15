From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Oct 2019 12:54:58 +0800
Subject: [LTP] [PATCH 2/2] testcases/kernel: Add linux git and CVE tags
In-Reply-To: <20191014112522.24548-3-chrubis@suse.cz>
References: <20191014112522.24548-1-chrubis@suse.cz>
 <20191014112522.24548-3-chrubis@suse.cz>
Message-ID: <CAEemH2f0ZXYEwsvcxWhdE33EzLJKr=EeeG91Uq_8rBZOsx57NQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:


>
> diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
> index 6997fffe4..012cbb7cd 100644
> --- a/testcases/cve/cve-2014-0196.c
> +++ b/testcases/cve/cve-2014-0196.c
> @@ -141,4 +141,9 @@ static struct tst_test test = {
>         .setup = setup,
>         .cleanup = cleanup,
>         .test_all = run,
> +       .tags = (const struct tst_tag[]) {
> +               {"linux-git", "4291086b1f08"},
> +               {"CVE", "2014-0196"},
> +               {}
>

Some of the tests use {NULL, NULL} to terminate tag array but some not,
maybe we need to keep consistent in usage.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191015/bc68b025/attachment.htm>
