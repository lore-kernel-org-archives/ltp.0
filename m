From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Oct 2019 16:06:21 +0800
Subject: [LTP] [PATCH v2 1/2] lib: Add support for test tags
In-Reply-To: <1270016842.8517878.1571817492480.JavaMail.zimbra@redhat.com>
References: <20191022140757.29713-1-chrubis@suse.cz>
 <20191022140757.29713-2-chrubis@suse.cz>
 <CAEemH2eCpbAuU2xYNtiv9Wq4VwHJE2dZRXnO9v+2H=1=JQJUXQ@mail.gmail.com>
 <1270016842.8517878.1571817492480.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2f2D4PjaMaOE_ADUqg5igEi97nHBsH6A7qXtO-2KO7btg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Oct 23, 2019 at 3:58 PM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> > Maybe we can merge this string compare in the same for loops?
> >
> > e.g: http://pastebin.test.redhat.com/808028
>
> Li, I don't think this is public server.
>

Sorry, thanks for the reminder.
[I copied the below code to gmail, it always lost the indent]

static void print_failure_hints(void)
{
        unsigned int i;
        int hint_printed = 0;
        const struct tst_tag *tags = tst_test->tags;

        if (!tags)
                return;

        for (i = 0; tags[i].name; i++) {
                if (!strcmp(tags[i].name, "linux-git")) {
                        if (hint_printed != 1) {
                                hint_printed = 1;
                                print_colored("\nHINT: ");
                                printf("You _MAY_ be missing kernel fixes,
see:\n\n");
                        }

                        printf(LINUX_GIT_URL "%s\n", tags[i].value);
                } else if (!strcmp(tags[i].name, "CVE")) {
                         if (hint_printed != 2) {
                                 hint_printed = 2;
                                 print_colored("\nHINT: ");
                                 printf("You _MAY_ be vunerable to CVE(s),
see:\n\n");
                          }

                        printf(CVE_DB_URL "%s\n", tags[i].value);
                } else {
                        print_colored("\nERROR: ");
                        printf("tags[%d].name should be linux-git or
CVE\n", i);
                        return;
                }
        }
}

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191023/617b683e/attachment.htm>
