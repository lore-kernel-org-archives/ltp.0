From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 18 Mar 2016 05:44:42 -0400 (EDT)
Subject: [LTP] Test library API changes
In-Reply-To: <20160317160606.GA31815@rei.lan>
References: <20160105111136.GA32659@rei.lan> <20160310165721.GA6142@rei>
 <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
 <20160314125153.GB600@rei.lan> <20160314160036.GA2511@rei.lan>
 <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
 <20160315092226.GA26279@rei.lan> <20160317160606.GA31815@rei.lan>
Message-ID: <457777222.10886512.1458294282223.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 17 March, 2016 5:06:06 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> I've rethinked the thread safety and LTP library and rewrote the
> documentation, there are no changes to the library as the ideal place to
> deal with thread safety is the user supplied cleanup.
> 
> Can you please review:
> 
> https://github.com/metan-ucw/ltp/blob/master/doc/test-writing-guidelines.txt#L732

Looks good to me.

"Only the main thread must return from the 'test()' function to the test
library"

We could also use an atomic flag in library to detect that
more threads escaped.
- in run_tests() after test_all() / test()
- in do_cleanup() after cleanup()

If flag is more then 1 then we know something is wrong,
e.g. more than 1 thread escaped cleanup() or test().

Regards,
Jan

> 
> There is also a new test at:
> 
> https://github.com/metan-ucw/ltp/blob/master/lib/newlib_tests/test08.c
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
