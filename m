From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Mar 2020 16:49:07 +0100
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <20200320134937.16616-2-pvorel@suse.cz>
 <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
 <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
 <20200323113738.GA4807@dell5510>
 <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
Message-ID: <20200323154907.GB15673@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> > > > kernel/syscalls/copy_file_range/copy_file_range02.c
> > > only affect test6 and test7
> > >  6) Try to copy contents to a file chattred with +i
> > >  *    flag -> EPERM
> > >  * 7) Try to copy contents to a swapfile ->ETXTBSY
> > Yes, it'd be bad to break all tests due it.

> > Here is also problem with swapoff (or maybe chattr, mkswap, swapon; I don't
> > remember), which returns exit code 255 on error, so it's not possible to
> > distinguish this from the case whether command is not available (any idea,
> > how
> > to fix it?).

> Maybe we could achieve a tst_cmd_available(char *cmd) in the C version?
> which uses popen() to open a process like: "whereis/which command" and do
> string parse in the result to see the path(/usr/bin/cmd, /usr/sbin/cmd) of
> the bin if it has been found.
Or how about loop whole path like whereis/which command? I want to cover also
these "strange systems" (Android and embedded).

I wonder if to use this all the time (e.g. in safe_run_cmd(), because solution
in tst_run_cmd_fds_() (errno == ENOENT) works most of the time. Maybe changing
exit code 255 to something less common (e.g. INT_MAX - 5).
Do you want to use tst_cmd_available() also  not only as API

Kind regards,
Petr

> A draft version to show the idea:

> int tst_cmd_available(char *cmd)
> {
>     int ret = 0;
>     char path[PATH_MAX];
>     char result[PATH_MAX];
>     char command[PATH_MAX];

>     snprintf(path, PATH_MAX, "/usr/bin/%s", cmd);
>     snprintf(command, PATH_MAX, "whereis %s", cmd);
>     FILE *fp = popen(command, "r");
>     fgets(result, sizeof(result), fp);

>     if (strstr(result, path) != NULL)
>         ret = 1;
>     pclose(fp);

>     return ret;
> }
