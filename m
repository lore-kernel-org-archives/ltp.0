From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 1 Mar 2019 03:44:12 -0500 (EST)
Subject: [LTP] [RFC PATCH] mm: rewrite mtest01 with new API
In-Reply-To: <CAEemH2cx0mPzhgAUKq01_4JXOnanQjK79JqEdPZ5N0kpO4A_QA@mail.gmail.com>
References: <20190228074002.14351-1-liwang@redhat.com>
 <646940042.3510845.1551391739985.JavaMail.zimbra@redhat.com>
 <CAEemH2d1NFFP8aQs96W-4r-OSBoXkd86TD92wp3ZZxzrhygQyw@mail.gmail.com>
 <138010263.3799706.1551427391091.JavaMail.zimbra@redhat.com>
 <CAEemH2cx0mPzhgAUKq01_4JXOnanQjK79JqEdPZ5N0kpO4A_QA@mail.gmail.com>
Message-ID: <269593361.3808924.1551429852336.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> On Fri, Mar 1, 2019 at 4:03 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> Maybe give it few days, so other people can respond, if they like/don't like
> > going in this direction.
> >
> 
> Sure.
> 
> Btw, I'm not going to use shared memory here since that probably make
> things more complicated.
> I guess just do remaining time check in the parent while loop is enough for
> the two OOM situations
> which I was mentioned in last mail.
> 
> ==== mem_test() ======
>         ...
> 
> if (pid == 0)
> child_loop_alloc();
> 
> /* waits in the loop for all children finish allocating*/
> while(pid_count < pid_cntr) {
> if (tst_timeout_remaining() < 15)
> break;
> 
> sleep(1);
> }
> 
> if (dowrite) {
>                 pre_free - post_free check...

This doesn't look very accurate. Other system processes can influence this.

Do we need to check it at all? If a child didn't complete allocation
it's not going to signal parent.

> } else {
> ...
> }
> 
>        kill children here..
> 
> --
> Regards,
> Li Wang
> 
