From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jun 2021 08:50:08 +0200
Subject: [LTP] 
 =?utf-8?b?562U5aSNOiDnrZTlpI06ICBbUEFUQ0hdIGx0cC1haW9kaW8v?=
 =?utf-8?q?dio=5Fappend=3A_fix_dio=5Fappend=28=29?=
In-Reply-To: <60B9A3D1.1040001@fujitsu.com>
References: <d87da351dd8cd8c8e51afc8922162e84@sslemail.net>
 <60B8A96C.8080503@fujitsu.com>
 <befea6726fc7467b9410db3e3b961f3e@inspur.com>
 <60B98598.7000905@fujitsu.com>
 <eddbe134055240cb8889b4df76404c1d@inspur.com>
 <60B9A3D1.1040001@fujitsu.com>
Message-ID: <YLnNIHcZZEwT0CeM@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu, Dong,

> Hi Dong

> > Hi xuyang

> > Thank you very much for your reply, but I think we should add the judgment of the return value in the "dio_append" function, because the final return value is 0 regardless of whether the test item passes or not, and 0 means PASS.
> IMO, I don't like perror or printf function and use return value to tell
> runltp that this case failed. LTP has tst_res() function with different
> flag and ltp new test framework can check pass/fail/conf number in
> lib/tst_test.c do_exit function.

+1

> A generic fix shound use tst_resm(TFAIL,) and tst_exit function.
> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
> @@ -85,7 +85,7 @@ void dio_append(char *filename)
>         fd = open(filename, O_DIRECT | O_WRONLY | O_CREAT, 0666);

>         if (fd < 0) {
> -               perror("cannot create file");
> +               tst_resm(TFAIL, "cannot create file %s", filename);
>                 return;
>         }

> @@ -99,7 +99,7 @@ void dio_append(char *filename)
>         memset(bufptr, 0, 64 * 1024);
>         for (i = 0; i < 1000; i++) {
>                 if ((w = write(fd, bufptr, 64 * 1024)) != 64 * 1024) {
> -                       fprintf(stderr, "write %d returned %d\n", i, w);
> +                       tst_resm(TFAIL, "write %d returned %d", i, w);
>                 }
>         }
>  }
> @@ -139,5 +139,5 @@ int main(void)
>         for (i = 0; i < num_children; i++) {
>                 kill(pid[i], SIGTERM);
>         }
> -       return 0;
> +       tst_exit();
>  }

> It also need sto use setup and cleanup function. But it is old test api.
> I guess we can use new api to do it.

> @Cyril, Petr, Li
> I think it is time to convert the whole ltp-aiodio cases into new api
+1. Although these tests fail on mainline, thus it's a question how to fix them.
Also they might are already covered in xfstests [1], it'd be better to ask in
fstests ML [2].

> and we still can use ltp-aiodio.sh.
If we decide to keep aiodio, it might be worth to tranform this somehow into
runltp-ng [3].

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/
[2] https://lore.kernel.org/fstests/
[3] https://github.com/metan-ucw/runltp-ng

> Best Regards
> Yang Xu

...
