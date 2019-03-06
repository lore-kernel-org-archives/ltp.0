From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 6 Mar 2019 12:35:44 -0500 (EST)
Subject: [LTP] [RFC PATCH 1/2] tst_test: Add test multiplex function
In-Reply-To: <20190306170008.GE12479@rei>
References: <20190306152430.25219-1-chrubis@suse.cz>
 <1194364640.5702234.1551891235712.JavaMail.zimbra@redhat.com>
 <20190306170008.GE12479@rei>
Message-ID: <815826896.5712903.1551893744593.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > on first look this looks like a workaround, because we have locked
> > ourselves out of .test function for timer tests.
> 
> I do not follow you here, can you elaborate?

If this wasn't timer test, I'd ask why don't we use existing .test and .tcnt,
your test() func can be called with a parameter, so you could change
the code to choose correct syscall/glibc func based on value of that parameter.

For normal tests, this looks almost and .test/.tcnt functionality,
except test count can be also dynamic.

static int tcase = -1;

static void test(void)
{
   switch (tcase) {
   }
}

static int select_mpx(void)
{
    tcase++;
    if (tcase == 5)
      return 0;
    return 1;
}

static struct tst_test test = {
    .test_multiplex = select_mpx,
    .test_all = test,
}

> 
> This patch has nothing to do with timer tests, it just allows whatever
> the test does to be done several times with a hook to change some
> settings prior to each iteration.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
