From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 15 Oct 2019 09:42:21 +0200
Subject: [LTP] [PATCH 1/2] lib: Add support for test tags
In-Reply-To: <CAEemH2e+xD2OCFZs14ejmppKu2rLXKsr16Vfc3tqw-YoesWuJg@mail.gmail.com>
References: <20191014112522.24548-1-chrubis@suse.cz>
 <20191014112522.24548-2-chrubis@suse.cz>
 <CAEemH2e+xD2OCFZs14ejmppKu2rLXKsr16Vfc3tqw-YoesWuJg@mail.gmail.com>
Message-ID: <87tv8awj36.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

>>  }
>>
>> +static void print_colored(const char *str)
>> +{
>> +       if (tst_color_enabled(STDOUT_FILENO))
>> +               printf("%s%s%s", ANSI_COLOR_YELLOW, str, ANSI_COLOR_RESET);
>> +       else
>> +               printf("%s", str);
>> +}
>> +
>> +static void print_failure_hints(void)
>> +{
>> +       unsigned int i;
>> +       const struct tst_tag *tags = tst_test->tags;
>> +
>> +       if (!tags)
>> +               return;
>> +
>> +       for (i = 0; tags[i].name; i++) {
>> +               if (!strcmp(tags[i].name, "linux-git")) {
>> +                       printf("\n");
>> +                       print_colored("HINT: ");
>
> +                       printf("This is a regression test for linux kernel,
>> see commit:\n\n"

It may be better just to print "Associated Linux kernel commit: ..." and
"Associated bug ID: CVE-..." in the loop. Then we can avoid any
discussions about what type of test it is.

Also, a test description tag could be added if necessary.

Maybe it would also be a good idea to link back to the test source code
on github? Possibly this info could be injected at build time?

>> +                              LINUX_GIT_URL "%s\n", tags[i].value);
>>
>
> This sentence 'HINT: This is a ...' will be printed many times if there are
> many commits in tags, I prefer to see only once in front of these
> linux-kernel links.
>
>
>> +               }
>> +
>> +               if (!strcmp(tags[i].name, "CVE")) {
>> +                       printf("\n");
>> +                       print_colored("HINT: ");
>> +                       printf("This test also tests for CVE-%s, see:\n\n"
>> +                              CVE_DB_URL "%s\n", tags[i].value,
>> tags[i].value);
>>
>
> Here as well.
>
> -- 
> Regards,
> Li Wang


-- 
Thank you,
Richard.
