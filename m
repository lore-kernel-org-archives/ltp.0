From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Mar 2019 19:28:30 +0100
Subject: [LTP] [RFC PATCH 1/2] tst_test: Add test multiplex function
In-Reply-To: <815826896.5712903.1551893744593.JavaMail.zimbra@redhat.com>
References: <20190306152430.25219-1-chrubis@suse.cz>
 <1194364640.5702234.1551891235712.JavaMail.zimbra@redhat.com>
 <20190306170008.GE12479@rei>
 <815826896.5712903.1551893744593.JavaMail.zimbra@redhat.com>
Message-ID: <20190306182829.GA3127@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > on first look this looks like a workaround, because we have locked
> > > ourselves out of .test function for timer tests.
> > 
> > I do not follow you here, can you elaborate?
> 
> If this wasn't timer test, I'd ask why don't we use existing .test and .tcnt,
> your test() func can be called with a parameter, so you could change
> the code to choose correct syscall/glibc func based on value of that parameter.
> 
> For normal tests, this looks almost and .test/.tcnt functionality,
> except test count can be also dynamic.

Well so does the .all_filesystems flag, however I see these concepts to
be orthogonal to what the actual test does, which is the reason I want
them hooked up in the library rather than to be part of the testcase
code.

-- 
Cyril Hrubis
chrubis@suse.cz
