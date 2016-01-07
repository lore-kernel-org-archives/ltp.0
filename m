From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 7 Jan 2016 08:01:36 -0500 (EST)
Subject: [LTP] Test library API changes
In-Reply-To: <20160105111136.GA32659@rei.lan>
References: <20160105111136.GA32659@rei.lan>
Message-ID: <1146864418.5284131.1452171696007.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 5 January, 2016 12:11:36 PM
> Subject: [LTP] Test library API changes
> 
> Hi!
> I'm back after my vacation and I had a some time to experiment with the
> LTP test API. My intention is to make the changes in the next
> development cycle. I.e. we will concentrate on the release in upcoming
> weeks and once that is taken care of I would like to discuss these
> changes.
> 
> I've pushed one cleanup that removes tst_res() and tst_brk() from the
> codebase today since there was only one test using this interface and
> that was a typo anyway.
> 
> Two patches that actually implement sketch of the new API are in forked
> LTP repository at:
> 
> https://github.com/metan-ucw/ltp
> 
> The interesting files are:
> 
> https://github.com/metan-ucw/ltp/blob/master/include/tst_test.h
> and
> https://github.com/metan-ucw/ltp/blob/master/lib/tst_test.c
> and one testcase that has been converted to the new library:
> https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/preadv/preadv01.c
> 
> The general intention is to move as much code to the library as possible
> in order to avoid common mistakes and also to let the programmer
> concentrate on the test itself rather than spending time figuring out
> the test library API.
> 
> One of the important changes is that the library functionality is
> exported as bitflags in the test structure rather than function calls,
> this makes the library much easier to use since this eliminates all
> problems with ordering of the resource inits/cleanups.
> 
> Another big change is that the process no longer runs the test function
> itself but rather than that export pointer to the function that runs the
> test. This would allow us to finally fix problems with test timeouts
> etc. since we can easily fork in the test library before we start
> execution the test code and watch for segfaults/timeouts etc.
> 
> The code I've wrote just a proof of concept and by no means complete.
> It's intended to start a conversation (I can send it as a patch here as
> well if desired, but I do not think that it makes sense for so early
> prototype).

Hi,

1) https://github.com/metan-ucw/ltp/blob/master/include/tst_test.h#L65
I did like there is option for test_all(). One concern I had was
that forcing everybody to use test(int) was too restrictive.
For example, you want to pass more parameters than just testcase #.
Also not all tests follow "static struct tcase {" idiom, with single
test function that is fed different arguments. I think test_all()
gives us more flexibility. I was also thinking if library should
care about "tcnt".

2) https://github.com/metan-ucw/ltp/blob/master/lib/tst_test.c#L218-L219
This also looks more strict requirement than what we had until now.
It requires to count exactly how many PASS/FAIL there are.
Is extra PASS or SKIP message a reason to fail the test with brk?

3) cleanup and children
I know, it's a proof of concept :-).

4) After first reading, I'm not sure I have clear picture of changes in API.
From what I gathered these are main changes:
  test.h -> tst_test.h
  tst_resm -> tst_res
  tst_brkm -> tst_brk
  safe_macros.h -> tst_safe_macros.h (now included via tst_test.h)

Did I miss anything?

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
