From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 11 Mar 2020 12:52:12 +0530
Subject: [LTP] [PATCH V5 02/10] lapi/fsmount.h: Add
 fsopen_supported_by_kernel()
In-Reply-To: <20200306124749.GB3375@rei.lan>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <21026a48ffa25ed8b09616cb939dc417459d2d74.1582779464.git.viresh.kumar@linaro.org>
 <20200306124749.GB3375@rei.lan>
Message-ID: <20200311072212.hsi2euwmvwrxuenw@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06-03-20, 13:47, Cyril Hrubis wrote:
> On Thu, Feb 27, 2020 at 10:44:30AM +0530, Viresh Kumar wrote:
> > Add a helper to check if the fsmount() related syscalls are supported by
> > the kernel or not.
> > 
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Acked-by: Li Wang <liwang@redhat.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  include/lapi/fsmount.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> > index 87f2f229c371..a6a24904e66d 100644
> > --- a/include/lapi/fsmount.h
> > +++ b/include/lapi/fsmount.h
> > @@ -130,5 +130,14 @@ enum fsconfig_command {
> >  
> >  #endif /* OPEN_TREE_CLONE */
> >  
> > +void fsopen_supported_by_kernel(void)
> > +{
> > +	if ((tst_kvercmp(5, 2, 0)) < 0) {
> > +		/* Check if the syscall is backported on an older kernel */
> > +		TEST(syscall(__NR_fsopen, NULL, 0));
> > +		if (TST_RET == -1 && TST_ERR == ENOSYS)
> > +			tst_brk(TCONF, "Test not supported on kernel version < v5.2");
> 
> 		Shouldn't we close the TST_RET here?

I didn't do that in the else part as this call should never succeed
and it will be a bug if it succeeds. Do you still want me to do it ?

-- 
viresh
