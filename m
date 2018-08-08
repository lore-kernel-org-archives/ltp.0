From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Aug 2018 16:41:55 +0200
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <CAEemH2f8di2qLvKPmutiO64w+YOxVbHxZgggvqtM-TPS5TU8eg@mail.gmail.com>
References: <1533111474.1176.4.camel@mtkswgap22>
 <CAEemH2dsg0Z18taXrBeQvCkJF1WHh9fHbP=GvMzRV62h4kNCzg@mail.gmail.com>
 <CALLuPvp4Ay5F_giNiUuDR9By+eLNPUNT-perUOE=gbCSmbsc2A@mail.gmail.com>
 <CAEemH2f8di2qLvKPmutiO64w+YOxVbHxZgggvqtM-TPS5TU8eg@mail.gmail.com>
Message-ID: <20180808144155.GG19147@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> static void do_child(void)
> {
>     ...
> 
>     /* Check if system support execveat() correctly */
>     TEST(execveat(fd, "", argv, environ, AT_EMPTY_PATH));
>     /* Do TCONF if we get EINVAL here */
> 
>     SAFE_UNLINK(TEST_FILE_PATH);
> 
>     /* Do your testing */
>     TEST(execveat(fd, "", argv, environ, AT_EMPTY_PATH));
>     /* Here if we get EINVAL again that means hit a bug! */
> }
> 
> Did I miss anything?

It's a bit more complicated than that, we have to fork() first and run
the check in the child otherwise we will never get to the test code, as
we will either do tst_brk(TBROK) or execute the child code instead...

I will write the code to check it and amend the test before applying to
the tree.

-- 
Cyril Hrubis
chrubis@suse.cz
