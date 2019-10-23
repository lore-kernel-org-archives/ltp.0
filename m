From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Oct 2019 18:06:40 +0200
Subject: [LTP] [PATCH v2 1/2] lib: Add support for test tags
In-Reply-To: <CAEemH2f2D4PjaMaOE_ADUqg5igEi97nHBsH6A7qXtO-2KO7btg@mail.gmail.com>
References: <20191022140757.29713-1-chrubis@suse.cz>
 <20191022140757.29713-2-chrubis@suse.cz>
 <CAEemH2eCpbAuU2xYNtiv9Wq4VwHJE2dZRXnO9v+2H=1=JQJUXQ@mail.gmail.com>
 <1270016842.8517878.1571817492480.JavaMail.zimbra@redhat.com>
 <CAEemH2f2D4PjaMaOE_ADUqg5igEi97nHBsH6A7qXtO-2KO7btg@mail.gmail.com>
Message-ID: <20191023160640.GA17663@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Sorry, thanks for the reminder.
> [I copied the below code to gmail, it always lost the indent]
> 
> static void print_failure_hints(void)
> {
>         unsigned int i;
>         int hint_printed = 0;
>         const struct tst_tag *tags = tst_test->tags;
> 
>         if (!tags)
>                 return;
> 
>         for (i = 0; tags[i].name; i++) {
>                 if (!strcmp(tags[i].name, "linux-git")) {
>                         if (hint_printed != 1) {
>                                 hint_printed = 1;
>                                 print_colored("\nHINT: ");
>                                 printf("You _MAY_ be missing kernel fixes,
> see:\n\n");
>                         }
> 
>                         printf(LINUX_GIT_URL "%s\n", tags[i].value);
>                 } else if (!strcmp(tags[i].name, "CVE")) {
>                          if (hint_printed != 2) {
>                                  hint_printed = 2;
>                                  print_colored("\nHINT: ");
>                                  printf("You _MAY_ be vunerable to CVE(s),
> see:\n\n");
>                           }
> 
>                         printf(CVE_DB_URL "%s\n", tags[i].value);

This would produce intermixed CVE and linux-git lines unless the tags
are sorted correctly in the source code, I do not want to depend on the
order hence the two loops.

>                 } else {
>                         print_colored("\nERROR: ");
>                         printf("tags[%d].name should be linux-git or
> CVE\n", i);
>                         return;

I've tried to explain to pvorel already that this is a wrong place to
assert the tag names. If nothing else this piece of code will be rarely
triggered and the error would end up ignored.

I plan to assert the tag names in the docparse tool that will build the
test metadata during the LTP build, so that wrong metadata will actually
fail the LTP build.

>                 }
>         }
> }

-- 
Cyril Hrubis
chrubis@suse.cz
