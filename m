From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Jan 2019 11:42:20 +0100
Subject: [LTP] Should people be concerned if they run the tests on their
 work boxes and getting ltp in distributions.
In-Reply-To: <CADdDZRnSugmfoyv1Mpt-HBrMVP5mD7Y4g3wA1cB3yaTPoeoGAg@mail.gmail.com>
References: <CADdDZRnSugmfoyv1Mpt-HBrMVP5mD7Y4g3wA1cB3yaTPoeoGAg@mail.gmail.com>
Message-ID: <20190103104220.GB10514@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> First of all thank you for making this series of tests and also some
> of the documentation you have made. Please CC me as I have disabled
> mailing list simply because I cannot keep up with the deluge of mail
> that arrives everyday.
> 
> Although one of the questions which probably should be part of the FAQ
> is should there be any concerns in running the tests on your everyday
> work machines ? I know that ideally it should be  run in  a lab but
> what if you do not have acces to that sort of infrastructure ? Are
> these any sort of good practises that people recommend to read through
> before starting the tests ?

It's directly in the README:

"
Warning!

Be careful with these tests!

Don't run them on production systems. Growfiles, doio, and iogen in
particular stress the I/O capabilities of systems and while they should
not cause problems on properly functioning systems, they are intended to
find (or cause) problems.
"

Generally it's quite likely that running whole run will crash your
system unless you have up-to-date system with latest fixes and even with
up to date system it's risky bussines.

You would be better off with running the tests in VM.

> I was able to compile and install ltp to /opt/ltp successfully and
> even run the version command, although found it a bit curious as to
> why autotools is used instead of something like cmake which has more
> readable human error output.

Well LTP is older than cmake and all the new fancy tools, at the time
LTP was founded autotools was likely only viable option. And it
continues to work fine, so there is no real reason for a change. We have
far to many more important tasks to work on.

> I also was wondering if there have been distributions which are either
> using ltp as part of their test infrastructure or/and also building
> binaries for their users .

Sure we are:

https://openqa.opensuse.org/tests/overview?distri=opensuse&version=Tumbleweed&build=20181231&groupid=32

And there is a little outdated version in buildservice:

https://build.opensuse.org/package/show/benchmark/ltp

You would be better of with manual compilation though, since this one is
too old to be really useful.


Or you can try my testing package, that more or less follow latest git:

https://build.opensuse.org/package/show/home:metan/ltp


-- 
Cyril Hrubis
chrubis@suse.cz
