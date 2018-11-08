From: Tim.Bird@sony.com <Tim.Bird@sony.com>
Date: Thu, 8 Nov 2018 20:19:09 +0000
Subject: [LTP] [Automated-testing] [RFC] [PATCH] lib: Add support
	for	test tags
In-Reply-To: <156962223.71358453.1541698207250.JavaMail.zimbra@redhat.com>
References: <20181107142209.8965-1-chrubis@suse.cz>
 <156962223.71358453.1541698207250.JavaMail.zimbra@redhat.com>
Message-ID: <ECADFF3FD767C149AD96A924E7EA6EAF88A346A7@USCULXMSG01.am.sony.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> -----Original Message-----
> From: Jan Stancek
> 
> Hi,
> 
> ----- Original Message -----
> > This is just proof of concept of moving some of the test metadata into
> > more structured form. If implemented it will move some information from
> > comments in the test source code to an array to the tst_test structure.
> >
> > It's not finished and certainly not set into a stone, this patch is
> > mainly intended to start a discussion.
> >
> > The newly introduced test tags are generic name-value pairs that can
> > hold test metadata, the intended use for now is to store kernel commit
> > hashes for kernel reproducers as well as CVE ids. The mechanism is
> > however choosen to be very generic so that it's easy to add basically
> > any information later on.
> >
> > As it is the main purpose is to print hints for a test failures. If a
> > test that has been written as a kernel reproducer fails it prints nice
> > URL pointing to a kernel commit that may be missing.
> >
> > Example output:
> >
> > tst_test.c:1145: INFO: Timeout per run is 0h 05m 00s
> > add_key02.c:98: FAIL: unexpected error with key type 'asymmetric':
> EINVAL
> > add_key02.c:98: FAIL: unexpected error with key type 'cifs.idmap': EINVAL
> > add_key02.c:98: FAIL: unexpected error with key type 'cifs.spnego': EINVAL
> > add_key02.c:98: FAIL: unexpected error with key type 'pkcs7_test': EINVAL
> > add_key02.c:98: FAIL: unexpected error with key type 'rxrpc': EINVAL
> > add_key02.c:98: FAIL: unexpected error with key type 'rxrpc_s': EINVAL
> > add_key02.c:98: FAIL: unexpected error with key type 'user': EINVAL
> > add_key02.c:98: FAIL: unexpected error with key type 'logon': EINVAL
> >
> > HINT: This is a regression test for linux kernel, see commit:
> >
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
> d=5649645d725c
> >
> > HINT: This test also tests for CVE-2017-15274, see:
> >
> > https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-15274
> >
> > Summary:
> > passed   0
> > failed   8
> > skipped  0
> > warnings 0
> >
> > This commit also adds adds the -q test flag, that can be used to query
> > test information, which includes these tags, but is not limited to them.
> >
> > The main inteded use for the query operation is to export test metadata
> > and constraints to the test execution system. The long term goal for
> > this would be parallel test execution as for this case the test runner
> > would need to know which global system resources is the test using to
> > avoid unexpected failures.
> >
> > So far it exposes only if test needs root and if block device is needed
> > for the test, but I would expect that we will need a few more tags for
> > various resources, one that comes to my mind would be "test is using
> > SystemV SHM" for that we can do something as add a "constraint" tag with
> > value "SysV SHM" or anything else that would be fitting. Another would
> > be "Test is changing system wide clocks", etc.
> >
> > So far the output from the query operation looks as:
> >
> > sh$ ./add_key02 -q
> > {
> >  "root": false
> >  "blk_device": false
> >  "linux-git": "5649645d725c"
> >  "CVE": "2017-15274"
> > }
> 
> So, only way to get metadata for tools is to run the test
> with -q on supported target? (since I assume when
> TST_TEST_TCONF branch hits, there won't be any data).
> 
> Would there be any benefit to having metadata in a (json)
> file from the start? Negative would be likely duplicating
> things like "needs_root". Positive is we could check for
> errors/typos during build time.

I'd like to see a way to extract this data without having to 
run the test as well.  That way test frameworks using LTP
could extract the data and handle test scheduling,
test dependencies, etc. without having to build or execute
the code.  In the case of Fuego, test dependencies are analyzed
on a separate machine from the one running the test.  Also,
we try to process some dependencies prior to building the test.

One mechanism for storing the data would be a separate json
file, but you could also embed the information in the source
using some regularized markup (json or something simpler)
that could be handled both in-source (for your -q operation),
or by an external scanner/converter.
 -- Tim


