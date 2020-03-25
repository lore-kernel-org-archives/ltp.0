From: Li Wang <liwang@redhat.com>
Date: Wed, 25 Mar 2020 13:56:42 +0800
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200324185542.GB17441@dell5510>
References: <20200320134937.16616-2-pvorel@suse.cz>
 <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
 <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
 <20200323113738.GA4807@dell5510>
 <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
 <CAEemH2e4sRwZ8HRm-w5CD=Wm8-SW+LaA5XHDnXdqrOL1t4FdtA@mail.gmail.com>
 <20200323160415.GC15673@dell5510> <20200324235150.GC4521@yuki.lan>
 <20200324172102.GA1307@dell5510> <20200325015324.GA15127@yuki.lan>
 <20200324185542.GB17441@dell5510>
Message-ID: <CAEemH2cGgB_H3pq1xwBC46OhA_y-Zhyrr_H-jQS13-_4xu7-0A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Wed, Mar 25, 2020 at 2:55 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Cyril,
>
> > > > Also if we are going to add this functionality it should be added as
> an
> > > > .needs_cmds array in the tst_test structure.
> > > .needs_cmds sounds as a good idea. But let's do it as a separate
> effort.
> > > I'll leave already sent v2 for review. Once .needs_cmds is
> implemented, we can
> > > use it as well for copy_file_range02.c.
>
> > Actually I would like to avoid exposing the function to the tests and
> > force people to use the .needs_cmds instead in order to have a proper
> > metadata.
> Oh yes, metadata effort, that's important, I'll implement it. But I still
> think
> it's useful to have SAFE_RUNCMD(), although I can remove TCONF (use flag
> TST_RUN_CMD_CHECK_CMD, see below).
>

I'm OK with SAFE_RUNCMD.


> > > BTW what do you think on changing 255 (and 254) for something less
> common?
> > > It's just a corner case swapon on certain setup in copy_file_range02.c
> returns
> > > 255 on error:
>
> > I do not think that this will solve the problem. We may hit the same
> > problem with any random number we will choose.
>
> > I guess checking for the command existence before we vfork() would be
> > safer bet here.
> +1. But this IMHO requires to add another parameter to tst_run_cmd_fds_(),
> because we don't want always TCONF. Best will be to turn int pass_exit_val
> into
> int flags with 2 possible values (e.g. TST_RUN_CMD_PASS_EXIT_VAL and
> TST_RUN_CMD_CHECK_CMD).
>

Agree, if we set '.needs_cmds' already we don't need to double-check the
command existence in tst_run_cmd() again.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200325/f87216f7/attachment.htm>
