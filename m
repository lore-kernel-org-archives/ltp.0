From: Li Wang <liwang@redhat.com>
Date: Tue, 23 May 2017 10:58:44 +0800
Subject: [LTP] [PATCH] tst_test.c: set the test id automatically
In-Reply-To: <20170522141611.19386-1-chrubis@suse.cz>
References: <20170522141611.19386-1-chrubis@suse.cz>
Message-ID: <CAEemH2eXNxvG8nJqagABb6x+iinSOcTxTC9XUDHU+NzUcW=WJA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 22, 2017 at 10:16 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 14a47d6..0bbcbf7 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -616,6 +616,22 @@ static void copy_resources(void)
>                 TST_RESOURCE_COPY(NULL, tst_test->resource_files[i], NULL);
>  }
>
> +static void get_tid(char *argv[])

Ah, forgot to mention that the return type should be "char *".


Li Wang
