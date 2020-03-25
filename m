From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Mar 2020 16:40:48 +0100
Subject: [LTP] [PATCH 2/2] Use SAFE_RUNCMD()
In-Reply-To: <20200325100350.GB5404@yuki.lan>
References: <CAEemH2fhRYefq_9LmSmDvujS1OQa7rCeF7V=mJQrLhz0bwpo0A@mail.gmail.com>
 <CAEemH2e4sRwZ8HRm-w5CD=Wm8-SW+LaA5XHDnXdqrOL1t4FdtA@mail.gmail.com>
 <20200323160415.GC15673@dell5510> <20200324235150.GC4521@yuki.lan>
 <20200324172102.GA1307@dell5510> <20200325015324.GA15127@yuki.lan>
 <CAEemH2doL4m4-TLBBWTHygTRPSTa68dkoAFjZJrDmzrkmgUrSQ@mail.gmail.com>
 <20200325170739.GA2461@yuki.lan> <20200325093427.GA23023@dell5510>
 <20200325100350.GB5404@yuki.lan>
Message-ID: <20200325154048.GB21800@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > > Indeed, there are couple of solutions for that, one of them would have
> > > all the arrays doubled and one of them would list hard requirement while
> > > the other soft requirements. Then we will end up with something as
> > > "need_cmds" and "wants_cmds". The second one would be more or less
> > > informative, the test may print a message "Missing foo command test
> > > coverage will be limited".
> > I was thinking about it and thought that would be too rich API (given there is
> > not that much external dependencies for C tests). But ok, sounds reasonable.

> Well yes, the matrix of options would explode exponentially if we do not
> keep it reasonable, hence we should keep it as simple as possible. So
> unless there is a real need for the wants_cmds I wouldn't add it now.
+1.

> > Also similar use case from shell tests: mostly $TST_NEEDS_CMDS is used,
> > which stop whole testing. But rarely (only in 3 tests and tst_net.sh) is used
> > tst_require_cmds() directly - it's a hard requirement, but it tries to run some
> > test before (or require it only when it's needed - tst_net.sh).
> > But that's bad from metadata point of view (you concentrate on metadata in C,
> > but sooner or later we'll need to handle shell as well).

> Unfortunatelly the whole problem is more complex than set of flags. The
> dependencies are often modified by the system properties, test command
> lline options, etc. Complete solution would need to be a set of
> conditionals or a domain language that would be able to express all
> dependencies. The main problem is that this would soon get too complex
> to a point where people would struggle to write the dependency rules.
OK, I don't know the details for metadata project. I thought that you're
planning to parse struct tst_test to get metadata for C. So my assumption was
that parsing TST_* would be equivalent for shell.

Kind regards,
Petr
