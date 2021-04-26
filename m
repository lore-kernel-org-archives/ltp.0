From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 26 Apr 2021 14:32:01 +0530
Subject: [LTP] [PATCH] Fix the 64-bit macro definition of mips
 architecture
In-Reply-To: <4b724549-4623-b7c8-72eb-7f7d309274ad@uniontech.com>
References: <20210426074812.27798-1-sujiaxun@uniontech.com>
 <4b724549-4623-b7c8-72eb-7f7d309274ad@uniontech.com>
Message-ID: <20210426090201.4ypx4hdyskpbufuf@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 26-04-21, 17:00, sujiaxun wrote:
> Hi Viresh,
> 
> Please process the patch below.
> 
> 
> > The mips architecture gcc does not have a built-in __arch64__,
> > you can also use "__BITS_PER_LONG == 64"
> > 
> > Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
> > ---
> >   include/lapi/msgbuf.h | 2 +-
> >   include/lapi/sembuf.h | 2 +-
> >   include/lapi/shmbuf.h | 2 +-
> >   3 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/lapi/msgbuf.h b/include/lapi/msgbuf.h
> > index f3277270d..873902e95 100644
> > --- a/include/lapi/msgbuf.h
> > +++ b/include/lapi/msgbuf.h
> > @@ -17,7 +17,7 @@
> >   #if defined(__mips__)
> >   #define HAVE_MSQID64_DS
> > 
> > -#if defined(__arch64__)
> > +#if __BITS_PER_LONG == 64
> >   /*
> >    * The msqid64_ds structure for the MIPS architecture.
> >    * Note extra padding because this structure is passed back and forth
> > diff --git a/include/lapi/sembuf.h b/include/lapi/sembuf.h
> > index 4ef0483a0..66579d294 100644
> > --- a/include/lapi/sembuf.h
> > +++ b/include/lapi/sembuf.h
> > @@ -24,7 +24,7 @@
> >    * Pad space is left for 2 miscellaneous 64-bit values on mips64,
> >    * but used for the upper 32 bit of the time values on mips32.
> >    */
> > -#if defined(__arch64__)
> > +#if __BITS_PER_LONG == 64
> >   struct semid64_ds {
> >   	struct ipc64_perm sem_perm;		/* permissions .. see ipc.h */
> >   	long		 sem_otime;		/* last semop time */
> > diff --git a/include/lapi/shmbuf.h b/include/lapi/shmbuf.h
> > index 28ee33620..ad71d9431 100644
> > --- a/include/lapi/shmbuf.h
> > +++ b/include/lapi/shmbuf.h
> > @@ -27,7 +27,7 @@
> >    * data structure when moving to 64-bit time_t.
> >    */
> > 
> > -#if defined(__arch64__)
> > +#if __BITS_PER_LONG == 64
> >   struct shmid64_ds {
> >   	struct ipc64_perm	shm_perm;	/* operation perms */
> >   	size_t			shm_segsz;	/* size of segment (bytes) */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
