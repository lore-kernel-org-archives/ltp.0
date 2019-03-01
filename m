From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Mar 2019 16:26:43 +0800
Subject: [LTP] [RFC PATCH] mm: rewrite mtest01 with new API
In-Reply-To: <138010263.3799706.1551427391091.JavaMail.zimbra@redhat.com>
References: <20190228074002.14351-1-liwang@redhat.com>
 <646940042.3510845.1551391739985.JavaMail.zimbra@redhat.com>
 <CAEemH2d1NFFP8aQs96W-4r-OSBoXkd86TD92wp3ZZxzrhygQyw@mail.gmail.com>
 <138010263.3799706.1551427391091.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cx0mPzhgAUKq01_4JXOnanQjK79JqEdPZ5N0kpO4A_QA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 1, 2019 at 4:03 PM Jan Stancek <jstancek@redhat.com> wrote:

Maybe give it few days, so other people can respond, if they like/don't like
> going in this direction.
>

Sure.

Btw, I'm not going to use shared memory here since that probably make
things more complicated.
I guess just do remaining time check in the parent while loop is enough for
the two OOM situations
which I was mentioned in last mail.

==== mem_test() ======
        ...

if (pid == 0)
child_loop_alloc();

/* waits in the loop for all children finish allocating*/
while(pid_count < pid_cntr) {
if (tst_timeout_remaining() < 15)
break;

sleep(1);
}

if (dowrite) {
                pre_free - post_free check...
} else {
...
}

       kill children here..

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190301/6952d779/attachment-0001.html>
