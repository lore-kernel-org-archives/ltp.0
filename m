From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Oct 2019 15:39:19 +0800
Subject: [LTP] [PATCH v2 1/2] lib: Add support for test tags
In-Reply-To: <20191022140757.29713-2-chrubis@suse.cz>
References: <20191022140757.29713-1-chrubis@suse.cz>
 <20191022140757.29713-2-chrubis@suse.cz>
Message-ID: <CAEemH2eCpbAuU2xYNtiv9Wq4VwHJE2dZRXnO9v+2H=1=JQJUXQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril Hrubis <chrubis@suse.cz> wrote:

...
> +static void print_failure_hints(void)
> +{
> +       unsigned int i;
> +       const struct tst_tag *tags = tst_test->tags;
> +
> +       if (!tags)
> +               return;
> +
> +       int hint_printed = 0;
> +       for (i = 0; tags[i].name; i++) {
> +               if (!strcmp(tags[i].name, "linux-git")) {
> +                       if (!hint_printed) {
> +                               hint_printed = 1;
> +                               printf("\n");
> +                               print_colored("HINT: ");
> +                               printf("You _MAY_ be missing kernel fixes,
> see:\n\n");
> +                       }
> +
> +                       printf(LINUX_GIT_URL "%s\n", tags[i].value);
> +               }
> +
> +       }
> +
> +       hint_printed = 0;
> +       for (i = 0; tags[i].name; i++) {
> +               if (!strcmp(tags[i].name, "CVE")) {
>

Maybe we can merge this string compare in the same for loops?

e.g: http://pastebin.test.redhat.com/808028

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191023/fd388af2/attachment-0001.htm>
