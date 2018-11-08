From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Nov 2018 13:11:34 +0800
Subject: [LTP] [RFC] [PATCH] lib: Add support for test tags
In-Reply-To: <20181107142209.8965-1-chrubis@suse.cz>
References: <20181107142209.8965-1-chrubis@suse.cz>
Message-ID: <CAEemH2dw1qeKgswzh8k_PdesQwGtRm72wzfG2erqw3J-WTJG0A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 7, 2018 at 10:22 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> This is just proof of concept of moving some of the test metadata into
> more structured form. If implemented it will move some information from
> comments in the test source code to an array to the tst_test structure.

I have to say, this is really a good proposal to LTP especially for
that regressions, we sometimes spend a lot of time to dig into test
failures and read code comments to find the reason/clue, if now
testcase can print out useful info when trigger the issue, that'd be
more friendly to LTP runner.

Another thought come to my mind is, can we build a correlation for one
case which have many alias? e.g cve-2017-15274 == add_key02. If LTP
framework has finished cve-2017-15274 test then run add_key02 in next,
just skip and mark it as the same result with cve-2017-15274 show.

>
> It's not finished and certainly not set into a stone, this patch is
> mainly intended to start a discussion.
>
> The newly introduced test tags are generic name-value pairs that can
> hold test metadata, the intended use for now is to store kernel commit
> hashes for kernel reproducers as well as CVE ids. The mechanism is
> however choosen to be very generic so that it's easy to add basically
> any information later on.
>
> As it is the main purpose is to print hints for a test failures. If a
> test that has been written as a kernel reproducer fails it prints nice
> URL pointing to a kernel commit that may be missing.

The key point is, we'd better set a strict limitation to print hints
only for known/expected failures. Because if the failure is a new
bz/issue for a system or testcase, that messages will be useless and
even misleading.

>
> This commit also adds adds the -q test flag, that can be used to query
> test information, which includes these tags, but is not limited to them.
>
> The main inteded use for the query operation is to export test metadata
> and constraints to the test execution system. The long term goal for
> this would be parallel test execution as for this case the test runner
> would need to know which global system resources is the test using to
> avoid unexpected failures.
>
> So far it exposes only if test needs root and if block device is needed
> for the test, but I would expect that we will need a few more tags for
> various resources, one that comes to my mind would be "test is using
> SystemV SHM" for that we can do something as add a "constraint" tag with
> value "SysV SHM" or anything else that would be fitting. Another would
> be "Test is changing system wide clocks", etc.

Sounds good.

But why only special( needs root or block-device) test can use that.
Maybe we could just define a generic struct for the tag, about the
real contents, test author can fill what they want to highlight.

-- 
Regards,
Li Wang
