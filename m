From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Mar 2020 19:55:42 +0100
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200325015324.GA15127@yuki.lan>
References: <20200320134937.16616-2-pvorel@suse.cz>
 <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
 <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
 <20200323113738.GA4807@dell5510>
 <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
 <CAEemH2e4sRwZ8HRm-w5CD=Wm8-SW+LaA5XHDnXdqrOL1t4FdtA@mail.gmail.com>
 <20200323160415.GC15673@dell5510> <20200324235150.GC4521@yuki.lan>
 <20200324172102.GA1307@dell5510> <20200325015324.GA15127@yuki.lan>
Message-ID: <20200324185542.GB17441@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > > Also if we are going to add this functionality it should be added as an
> > > .needs_cmds array in the tst_test structure.
> > .needs_cmds sounds as a good idea. But let's do it as a separate effort.
> > I'll leave already sent v2 for review. Once .needs_cmds is implemented, we can
> > use it as well for copy_file_range02.c.

> Actually I would like to avoid exposing the function to the tests and
> force people to use the .needs_cmds instead in order to have a proper
> metadata.
Oh yes, metadata effort, that's important, I'll implement it. But I still think
it's useful to have SAFE_RUNCMD(), although I can remove TCONF (use flag
TST_RUN_CMD_CHECK_CMD, see below).

> > BTW what do you think on changing 255 (and 254) for something less common?
> > It's just a corner case swapon on certain setup in copy_file_range02.c returns
> > 255 on error:

> I do not think that this will solve the problem. We may hit the same
> problem with any random number we will choose.

> I guess checking for the command existence before we vfork() would be
> safer bet here.
+1. But this IMHO requires to add another parameter to tst_run_cmd_fds_(),
because we don't want always TCONF. Best will be to turn int pass_exit_val into
int flags with 2 possible values (e.g. TST_RUN_CMD_PASS_EXIT_VAL and
TST_RUN_CMD_CHECK_CMD).

> > Setting up swapspace version 1, size = 36 KiB (36864 bytes)
> > no label, UUID=bae78639-be0b-42b2-9e91-815b05f5751b
> > swapon: /tmp/msT4Ch/file_swap: swapon failed: Invalid argument
> > copy_file_range02.c:95: CONF: swapon binary not installed or failed

Kind regards,
Petr
