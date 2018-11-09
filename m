From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Nov 2018 11:28:59 +0100
Subject: [LTP] [Automated-testing] [RFC] [PATCH] lib: Add support for
 test tags
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF88A346A7@USCULXMSG01.am.sony.com>
References: <20181107142209.8965-1-chrubis@suse.cz>
 <156962223.71358453.1541698207250.JavaMail.zimbra@redhat.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF88A346A7@USCULXMSG01.am.sony.com>
Message-ID: <20181109102859.GA19700@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > So, only way to get metadata for tools is to run the test
> > with -q on supported target? (since I assume when
> > TST_TEST_TCONF branch hits, there won't be any data).
> > 
> > Would there be any benefit to having metadata in a (json)
> > file from the start? Negative would be likely duplicating
> > things like "needs_root". Positive is we could check for
> > errors/typos during build time.
> 
> I'd like to see a way to extract this data without having to 
> run the test as well.  That way test frameworks using LTP
> could extract the data and handle test scheduling,
> test dependencies, etc. without having to build or execute
> the code.  In the case of Fuego, test dependencies are analyzed
> on a separate machine from the one running the test.  Also,
> we try to process some dependencies prior to building the test.

What I had in mind was some additional database build step where
all tests would be executed with -q parameter on the target machine
which would create a big structured file with all the metadata. So first
thing before any test would be executed would be a script that would
check if there is a database file or not and and if there is none it
would build it, then we can get the database from the target machine
and the test runner can make use of that.

This process has to be either part of the LTP build or has to be
executed before first testrun anyways, sice there is no other way
to keep the data in sync with the binaries.

> One mechanism for storing the data would be a separate json
> file, but you could also embed the information in the source
> using some regularized markup (json or something simpler)
> that could be handled both in-source (for your -q operation),
> or by an external scanner/converter.

Actually I've started to think that this may be the answer, if we manage
to encode the metadata into C string as well as into some structured
form we can have test description as well as some of the metadata
available both at the runtime as well as in a format that could be
parsed without compiling the test.

But there are drawbacks, I do not think that it's sane to encode if test
requires root or not, or if it needs a block device in some kind of
markup text. I think that it's mutch better when it's encoded in the
tst_test structure as it is now.

-- 
Cyril Hrubis
chrubis@suse.cz
