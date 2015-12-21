From: Li Wang <liwang@redhat.com>
Date: Mon, 21 Dec 2015 16:36:08 +0800
Subject: [LTP] [PATCH v3] hugetlb/hugemmap: add new testcase hugemmap06.c
In-Reply-To: <2096168533.29677153.1450348851398.JavaMail.zimbra@redhat.com>
References: <1448618434-6780-1-git-send-email-liwang@redhat.com>
 <2096168533.29677153.1450348851398.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2dxFN3cQody--Ag_O_X3C7_OKoUQwuiNB3ys3GLOaPBPQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Thu, Dec 17, 2015 at 6:40 PM, Jan Stancek <jstancek@redhat.com> wrote:

>
>
> Hi,
>
> v3 looks OK to me, few nits are noted below:
>
> If you make "addr" "char *" one cast can go away.
> And from what I understand, important is to touch the page,
> so writing char instead of int should work too:
>   *(mmap_sz->addr + b * hpage_size) = rand();
>

yeah, that would be nice!


>
> I tried the above and I could still trigger the panic.
>
> > +             }
> > +     }
> > +     return NULL;
> > +}
> > +
> > +void do_mmap(void)
> > +{
> > +     int i, sz;
> > +     void *addr, *new_addr;
> > +     struct mp mmap_sz[ARSZ];
> > +     pthread_t tid[ARSZ];
> > +
> > +     sz = ARSZ + 1;
>
> This could go on same line where you declared sz.
>

ok.


>
> > +                             -1, 0);
> > +
> > +             if (new_addr == MAP_FAILED) {
> > +                     TEST(pthread_join(tid[i], NULL));
>
> What is the purpose of pthread_join here?
>

hmm, jut waiting for the latest thread to make process safe. but after
thinking over, I feel it's meaningless to do that.  okay, thanks for
pointing out, I can remove it.


>
> > +                     if (TEST_RETURN)
> > +                             tst_brkm(TBROK | TRERRNO, cleanup,
> > +                                             "pthread_join failed");
> > +                     tst_brkm(TFAIL | TERRNO, cleanup, "mremap failed");
>
> "mremap" looks like typo
>

yes.


>
> Regards,
> Jan
>
>
thanks for your kind reply. patch V4 will be threw out.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151221/63c2a736/attachment.html>
