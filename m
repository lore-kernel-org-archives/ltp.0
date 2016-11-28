From: Li Wang <liwang@redhat.com>
Date: Mon, 28 Nov 2016 11:45:00 +0800
Subject: [LTP] [PATCH 2/3] ltp/numa: cleanup work for numa/*
In-Reply-To: <20161123133445.GH3346@rei.lan>
References: <1479872213-29969-1-git-send-email-liwang@redhat.com>
 <20161123132612.GG3346@rei.lan> <20161123133445.GH3346@rei.lan>
Message-ID: <CAEemH2e3_x3Zt5UxkBX4et6JFQTSy8DbJfjZ-2en1_L3zfdVAA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

agree all these comments below. thanks!

On Wed, Nov 23, 2016 at 9:34 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> > +   if (argc != 2) {
>> > +           printf("Error: arguments not right.\n");
>>                         ^
>>                       This is pretty value and hence useless. You should
>                                        ^
>                                        vague
>
>>                       rather explain that the program takes exactly one
>>                       numeric parameter.
>>
>> > +           exit(-1);
>>
>> You should rather exit with 1 here.
>>
>> > +   }
>> > +
>> >     switch (atoi(argv[1])) {
>> >     case 1:
>> >             printf("%d", PAGE_SIZE);
>> > -           tst_exit();
>> > +           return 0;
>> >     case 2:
>> >             buf = malloc(MB);
>> >             if (!buf) {
>> > -                   tst_resm(TINFO, "#Memory is not available\n");
>> > -                   tst_exit();
>> > +                   printf("Memory is not available\n");
>>
>> It would be a bit better to print the error messages into the stderr
>> instead.
>>
>> >                     exit(2);
>> >             }
>> >             for (i = 0; i < MB; i += PAGE_SIZE) {
>> > -                   count++;
>> >                     buf[i] = 'a';
>> >                     barrier();
>> >             }
>> >             free(buf);
>> > -           tst_exit();
>> > +           return 0;
>> >     case 3:
>> >             /* Trap SIGINT */
>> >             sa.sa_handler = sigfunc;
>> >             sa.sa_flags = SA_RESTART;
>> >             sigemptyset(&sa.sa_mask);
>> >             if (sigaction(SIGINT, &sa, 0) < 0) {
>> > -                   tst_brkm(TBROK, NULL, "#Sigaction SIGINT failed\n");
>> > -                   tst_exit();
>> > -                   exit(1);
>> > +                   printf("Sigaction SIGINT failed\n");
>> > +                   exit(3);
>> >             }
>> >             /* wait for signat Int */
>> >             pause();
>> > -           tst_exit();
>> > +           return 0;
>> >     default:
>> >             exit(1);
>> >     }
>>
>> --
>> Cyril Hrubis
>> chrubis@suse.cz
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Regards,
Li Wang
Email: liwang@redhat.com
