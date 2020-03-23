From: Li Wang <liwang@redhat.com>
Date: Mon, 23 Mar 2020 21:42:47 +0800
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200323113738.GA4807@dell5510>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <20200320134937.16616-2-pvorel@suse.cz>
 <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
 <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
 <20200323113738.GA4807@dell5510>
Message-ID: <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr, Xu,

On Mon, Mar 23, 2020 at 7:37 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li, Xu,
>
> > >       testcases/kernel/syscalls/add_key/add_key05.c   | 15
> ++-------------
> > >       testcases/kernel/syscalls/quotactl/quotactl01.c | 14
> ++------------
> > >       testcases/kernel/syscalls/quotactl/quotactl06.c | 12 +-----------
>
> > > Apart from the three, do you consider converting to SAFE_RUNCMD for the
> > > rest testcases?
> > > (it seems not too much work remaining since only a few test case uses
> > > tst_run_cmd)
> > At the beginning, I have the same idea. But after seeing code, I think we
> > should not because these cases have many sub tests(only few test deponds
> on
> > the result of the cmd execution.
>
> > > kernel/syscalls/setpriority/setpriority01.c
> > One year ago has a commit db82b596(setpriority01: Skip only PRIO_USER
> when
> > unable to add test user). It only affects PRIO_USER sub test.
> + 1. I didn't want to break the case when useradd is not available
> (android or
> some custom embedded linux) or there is no password file (root mounted as
> ro -
> custom embedded linux).
>

That's right. Thanks for the clarification.

>
> BTW I also avoid handling adding user as I want to implement better
> handling
> user and group in LTP (adding a flag), see:
> https://github.com/linux-test-project/ltp/issues/468


Good plan.


>
>
> Feel free to commend this plan.
> This patchset is kind of preparation for it.
>
> > > kernel/syscalls/copy_file_range/copy_file_range02.c
> > only affect test6 and test7
> >  6) Try to copy contents to a file chattred with +i
> >  *    flag -> EPERM
> >  * 7) Try to copy contents to a swapfile ->ETXTBSY
> Yes, it'd be bad to break all tests due it.
>
> Here is also problem with swapoff (or maybe chattr, mkswap, swapon; I don't
> remember), which returns exit code 255 on error, so it's not possible to
> distinguish this from the case whether command is not available (any idea,
> how
> to fix it?).
>

Maybe we could achieve a tst_cmd_available(char *cmd) in the C version?
which uses popen() to open a process like: "whereis/which command" and do
string parse in the result to see the path(/usr/bin/cmd, /usr/sbin/cmd) of
the bin if it has been found.

A draft version to show the idea:

int tst_cmd_available(char *cmd)
{
    int ret = 0;
    char path[PATH_MAX];
    char result[PATH_MAX];
    char command[PATH_MAX];

    snprintf(path, PATH_MAX, "/usr/bin/%s", cmd);
    snprintf(command, PATH_MAX, "whereis %s", cmd);
    FILE *fp = popen(command, "r");
    fgets(result, sizeof(result), fp);

    if (strstr(result, path) != NULL)
        ret = 1;
    pclose(fp);

    return ret;
}
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200323/984d7b66/attachment.htm>
