From: Peter Gubka <pgubka@gmail.com>
Date: Tue, 1 Dec 2020 15:27:35 +0100
Subject: [LTP] linux kernel versions vs. ltp release tags
In-Reply-To: <20201201125542.GB27684@yuki.lan>
References: <CAPeFc=TgA6ABrvDthLBoruqfmopx5nhqYYDAv7h0B+CjaFY-CA@mail.gmail.com>
 <20201201125542.GB27684@yuki.lan>
Message-ID: <CAPeFc=Rvpq90yQKaGfg9gtFhyJNui3CvjY4ewOy6DS2na9RXNQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi.

thanks for the answer. In my particular case there is a test
https://github.com/linux-test-project/ltp/blob/b59c662104c8989704953d1e5dc8c3c6412daa2a/testcases/kernel/syscalls/sendto/sendto03.c
which causes kernel panic because it tests something which is not present
in my kernel.
Are there any recommendations on what to do in such a case?

Regards,
Peter Gubka

On Tue, Dec 1, 2020 at 1:54 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I would like to test linux with kernel version 5.4.47.
> > Is there any relation between ltp releases and kernel versions?
>
> Short answer: No.
>
> More detailed answer:
>
> LTP should be backwards compatible for about 10 years back for both
> kernel and userspace (libc, gcc, etc.). I.e. latest should run fine on
> 10 years old distribution and anything newer. Latest LTP also contains
> more testcases and fixes so in 99% of the cases it makes senes to use
> either latest stable release or a git HEAD.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201201/922e4c48/attachment.htm>
