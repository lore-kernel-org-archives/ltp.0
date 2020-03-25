From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Mar 2020 18:07:40 +0100
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <CAEemH2doL4m4-TLBBWTHygTRPSTa68dkoAFjZJrDmzrkmgUrSQ@mail.gmail.com>
References: <CAEemH2f7TB9sMt-+YE2zF5KztT4O64VN9L4AZWdS3nU1uJX5_w@mail.gmail.com>
 <303d1019-f836-b2ae-ce51-d2c46dd7fb1e@cn.fujitsu.com>
 <20200323113738.GA4807@dell5510>
 <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
 <CAEemH2e4sRwZ8HRm-w5CD=Wm8-SW+LaA5XHDnXdqrOL1t4FdtA@mail.gmail.com>
 <20200323160415.GC15673@dell5510> <20200324235150.GC4521@yuki.lan>
 <20200324172102.GA1307@dell5510> <20200325015324.GA15127@yuki.lan>
 <CAEemH2doL4m4-TLBBWTHygTRPSTa68dkoAFjZJrDmzrkmgUrSQ@mail.gmail.com>
Message-ID: <20200325170739.GA2461@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > > Also if we are going to add this functionality it should be added as an
> > > > .needs_cmds array in the tst_test structure.
> > > .needs_cmds sounds as a good idea. But let's do it as a separate effort.
> >
> +1, thanks Petr!
> 
> 
> > > I'll leave already sent v2 for review. Once .needs_cmds is implemented,
> > we can
> > > use it as well for copy_file_range02.c.
> >
> > Actually I would like to avoid exposing the function to the tests and
> > force people to use the .needs_cmds instead in order to have a proper
> > metadata.
> >
> 
> Sounds good.
> 
> And this makes me think more of the '.request_hugepages' story. The
> needs_foo flags require the foo to be present on the system as hard
> requirements. In some situations(i.e copy_file_range02.c), we probably need
> to handle the soft situation, which means, the commands are only part of
> the test requirement. So if it writing with .needs_cmds="xxx", it might
> skip the whole test in setup() phase.

Indeed, there are couple of solutions for that, one of them would have
all the arrays doubled and one of them would list hard requirement while
the other soft requirements. Then we will end up with something as
"need_cmds" and "wants_cmds". The second one would be more or less
informative, the test may print a message "Missing foo command test
coverage will be limited".

-- 
Cyril Hrubis
chrubis@suse.cz
