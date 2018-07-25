From: vishnu <vishnu@zilogic.com>
Date: Wed, 25 Jul 2018 12:43:31 -0000
Subject: [LTP] [PATCH v2] Test for memfd_create() syscall
	withMFD_HUGETLBflag.
References: <20180720101807.4760-1-vishnu@zilogic.com>
 <1721785370.35493152.1532440260470.JavaMail.zimbra@redhat.com>
Message-ID: <8ba2ddff22ee07c35c6ca82b080e619b.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

  Thanks for your code review.



> +static void test_write_protect(int fd)
> +{
> +        if (CHECK_HUGE_NON_WRITEABLE(fd) == 0)
> +                tst_res(TPASS, "write call failed as expected");
> +        else
> +                tst_res(TFAIL, "write call passed unexpectedly");
> +}
> Why not report PASS/FAIL directly? Or why not put the test
  right here, without all the indirection? Are you planning
  on using CHECK_HUGE_NON_WRITEABLE() in other tests?

  CHECK_HUGE_NON_WRITEABLE() is dedicated to this test alone.
  We will move the code logic from CHECK_HUGE_NON_WRITEABLE() to
  test_write_protect() avoiding indirection.



> +        hugepages_enabled = 1;
> +        SAFE_CLOSE(fd);
> +
> +        if (GET_HUGE_TOTAL_PAGES() == 0)
> +                tst_brk(TCONF, "Enable Hugepages manually");
> I thought you need 4 huge pages for the test. This skips setup
  even for 1.
> If you need 4 huge pages for test, then shouldn't this check you have at
least 4?

  There is no such demand for particular number of hugepages.
  Tests will work for any number of hugepages greater than 0.
  4 is actually a randomly choosen number.

  We will modify setup in a way that:-
    1. Check the number of free_hugepages.
    2. if free_hugepages is 0, increase the total hugepage count by
       a number (choosen 4).
    3. Again, if free_hugepages is 0, tst_brk -> TCONF.

  In clean-up, restore the original value of total hugepage count.




memfd_create04.c:80: INFO: Attempt to create 1GB huge pages
memfd_create04.c:82: INFO: memfd_create(tfile, 2013265924) succeeded
memfd_create04.c:94: INFO: mmap((nil), 1073741824, 2, 2, 3, 0) failed
memfd_create04.c:96: WARN: Contiguous memory unavailable to map
memfd_create04.c:100: INFO: close(3) succeeded
memfd_create04.c:102: PASS: Successfully created 1GB pages
> This looks like a guaranteed warning on some systems.
  What do you expect user do with this warning? Report bug? Change config?

  In memfd_create04:

   1. The warning is to due lack of contiguous memory resource to map
hugepage and is nothing related to syscall failure.

    Map checking here is an add-on, which is not compulsory.
    We will remove this checking as users have nothing to do with it.

   2. Hence if no map checking, the test will work without set-up & clean-up.



Regards,
Vishnu K


