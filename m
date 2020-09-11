From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Sep 2020 15:42:11 +0800
Subject: [LTP] [PATCH v5] Add a test case for mmap MAP_GROWSDOWN flag
In-Reply-To: <20200911070540.GA22970@dell5510>
References: <20200911035533.30538-1-liwang@redhat.com>
 <20200911070540.GA22970@dell5510>
Message-ID: <CAEemH2eC-2SckKbWbQXLYZa=W8RM3hzA4-vWTKJasVFW_HnQKw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Sep 11, 2020 at 3:05 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > From: pravin <pravinraghul@zilogic.com>
>
> > We assign the memory region allocated using MAP_GROWSDOWN to a thread,
> > as a stack, to test the effect of MAP_GROWSDOWN. This is because the
> > kernel only grows the memory region when the stack pointer, is within
> > guard page, when the guard page is touched.
>
> >   1. Map an anyonymous memory region of size X, and unmap it.
> >   2. Split the unmapped memory region into two.
> >   3. The lower memory region is left unmapped.
> >   4. The higher memory region is mapped for use as stack, using
> MAP_FIXED | MAP_GROWSDOWN.
> >   5. The higher memory region is provided as stack to a thread, where
> >      a recursive function is invoked.
> >   6. The stack grows beyond the allocated region, into the lower memory
> area.
> >   7. If this results in the memory region being extended, into the
> >      unmapped region, the test is considered to have passed.
>
> > Also, to verify that(Test2) the stack grows to within a page of the high
> > end of the next lower map?ping will result in a SIGSEGV signal.
>
> > Resolves #300
> > Signed-off-by: Pravin Raghul S. <pravinraghul@zilogic.com>
> > Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > Cc: Cyril Hrubis <chrubis@suse.cz>
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> LGTM.
>
> Just please fix using spaces instead of tabs in check_stackgrow_up() and
> run_test() (I suppose your modifications to pravis's code):
>

Sorry for the chaotic indent, I guess it was caused by my editor.

Anyway, thanks for the review, will fix it after getting Cyril's reviewing.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200911/7a9af66e/attachment.htm>
