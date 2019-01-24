From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Jan 2019 14:56:01 +0100
Subject: [LTP] LTP kernel config needs inputs ?
In-Reply-To: <0B227663-0650-4B24-8721-1D1206E9FBA1@linaro.org>
References: <0B227663-0650-4B24-8721-1D1206E9FBA1@linaro.org>
Message-ID: <20190124135601.GB9217@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Currently we have a list of "bugs", out of LKFT, that are only related
> to missing kernel configuration options in boards & systems being tested
> by our framework and environment. I would like to get some feedback
> regarding this, if possible. Since we use multiple testing frameworks in
> LKFT, we usually compare features, from one and another, and we would
> like some input about possibility of having kernel config fragments in
> LTP (or something better).
>
> kselftests has config fragments in order to enable kernel config options
> needed for specific tests (like showed at the end of this e-mail). I see
> that, nowadays, we have a file called README.kernel_config that contains
> a list of needed kernel options (for the basic framework ?), but this
> file hasn't been updated since 2014.
> 
> We have a list of some bugs that we have identified missing config
> options in our kernel builds. Sometimes we are lucky and the tests get
> BROK reported because they test a specific feature requirement before
> the real test, but, sometimes, random errors give us no clue if we are
> missing kernel features or facing a kernel issue.
> 
> Any opinions on something that could relieve this burden ?

Actually have you seen the proof-of-concept documentation patch I've
send to this list? It kind of went in the similar direction:

https://patchwork.ozlabs.org/patch/1004412/

The idea is that the required config options, among other information,
would be listed in human readable comment in the test, which could be
parsed and the data could be compiled into the test so that in can exit
with TCONF if these options are missing and also to be able to export
this information for the test-execution-framework.

Given that that there will be parser involved we can have the kconfig
options stored in fragments in separate file as well.

I kind of avoided on working on this patch further because I received
zero feedback for it and I hope that there will be at least some
discussion about it on the informal gathering we plan for fosdem. But if
you have any sugestions we can start the discussion now :-).

-- 
Cyril Hrubis
chrubis@suse.cz
