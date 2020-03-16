From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Mar 2020 07:22:38 +0100
Subject: [LTP] [PATCH V6 05/10] syscalls/fsconfig: New tests
In-Reply-To: <20200316060950.6o52idjfocdibrn6@vireshk-i7>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
 <824c287cd06190cf0a489535fd4617aff8742b03.1584014172.git.viresh.kumar@linaro.org>
 <20200312191025.GD3803@rei.lan>
 <20200313040012.bvkzfbxlvrwkkltd@vireshk-i7>
 <20200313080334.GA6597@rei.lan>
 <20200313084853.lnfi4dnyoht5yupi@vireshk-i7>
 <20200313120943.GA32033@dell5510>
 <20200316060950.6o52idjfocdibrn6@vireshk-i7>
Message-ID: <20200316062238.GA2616854@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

> > > I didn't knew about the -i option, yeah your change makes sense now :)
> > NOTE: all test (both C and shell) should support -h (inherited from the
> > library), to display options.

> I didn't thought about that as well earlier, but then tried -h option
> with the executable earlier before your mail came and it worked. So I
> assume I don't have to do anything special to support the -h option as
> it is already working fine right now ?
Yes, that's automatically done by library (a nice feature of new C library API).
See parse_opts() in lib/tst_test.c. And even better: you can very easily extend
it, see 2.2.5 Test specific command line options [1].

Cyril also recently described LTP library model in his blog [3].

We were thinking to separate the library so it can be reused in other projects
(similarly like kernel's kconfig is used in other projects). But it'd be good
first to rewrite all tests which uses legacy API, which allows remove legacy API
itself.

BTW We also try to keep shell API to be similar to C API (when possible),
therefore getopt support it's there as well, see 2.3.3 Optional command line
parameters [2].

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#225-test-specific-command-line-options
[2] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#233-optional-command-line-parameters
[3] https://people.kernel.org/metan/the-ltp-test-driver-model
