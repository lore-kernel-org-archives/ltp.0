From: Li Wang <liwang@redhat.com>
Date: Tue, 23 May 2017 10:38:23 +0800
Subject: [LTP] [PATCH] tst_test.c: set the test id automatically
In-Reply-To: <20170522141611.19386-1-chrubis@suse.cz>
References: <20170522141611.19386-1-chrubis@suse.cz>
Message-ID: <CAEemH2cM2O8xXgtUTwztNxtdfu90SE=R7ohHH8Ag_LFh3BEmeQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 22, 2017 at 10:16 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Use the argv[0] to set the tst_test->tid automatically since we fail to
> update it commonly and we end up with wrong tid due to copy&paste.
>
> Now it's initialized in the test setup based on argv[0]. If argv[0] is a
> path we take last element in it.
>
> This patch is based on v1 by Li Wang but I've omitted moving the
> parse_opts() up in the setup() since the setup() function expects
> that tst_test sturcture is non-NULL and may segfault if that is not
> true.
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>
> +static void get_tid(char *argv[])
> +{
> +       char *p;
> +
> +       if (!argv[0] || !argv[0][0]) {
> +               tst_res(TINFO, "argv[0] is empty!");
> +               return "ltp_empty_argv";
> +       }

Return a constant string here to replace tst_brk() is very sensible.
Not only do not move parse_opts() up but also keep test running with
empty argv[0]. I like this supplement.


Regards,
Li Wang
