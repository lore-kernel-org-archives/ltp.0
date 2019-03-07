From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 7 Mar 2019 13:29:10 +0100
Subject: [LTP] [RFC PATCH 1/2] tst_test: Add test multiplex function
In-Reply-To: <579318010.5729499.1551900024400.JavaMail.zimbra@redhat.com>
References: <20190306152430.25219-1-chrubis@suse.cz>
 <1194364640.5702234.1551891235712.JavaMail.zimbra@redhat.com>
 <20190306170008.GE12479@rei>
 <815826896.5712903.1551893744593.JavaMail.zimbra@redhat.com>
 <20190306182829.GA3127@rei>
 <579318010.5729499.1551900024400.JavaMail.zimbra@redhat.com>
Message-ID: <20190307122910.GC1040@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > If this wasn't timer test, I'd ask why don't we use existing .test and
> > > .tcnt,
> > > your test() func can be called with a parameter, so you could change
> > > the code to choose correct syscall/glibc func based on value of that
> > > parameter.
> > > 
> > > For normal tests, this looks almost and .test/.tcnt functionality,
> > > except test count can be also dynamic.
> > 
> > Well so does the .all_filesystems flag, however I see these concepts to
> > be orthogonal to what the actual test does, which is the reason I want
> > them hooked up in the library rather than to be part of the testcase
> > code.
> 
> OK, so it's like another level on top of current test functions.

Yes, the change to the library adds generic layer for that.

> I probably would like 'variant' somewhere in name more, but overall
> I'm not against the patch. Are you planning on adding some docs too?

I thought that calling it multiplex was descriptive enough name.


There is some summary in:

https://github.com/linux-test-project/ltp/issues/506

I guess that I can expand the text a bit and put it in the doc/
directory in the source tree along with the change to the test library.

-- 
Cyril Hrubis
chrubis@suse.cz
