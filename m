From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 9 Mar 2016 04:49:57 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/fstatat01: fix test on x86_64 arch
In-Reply-To: <56DFF11F.9080505@oracle.com>
References: <1457511825-29960-1-git-send-email-alexey.kodanev@oracle.com>
 <166755113.7189444.1457515127024.JavaMail.zimbra@redhat.com>
 <56DFF11F.9080505@oracle.com>
Message-ID: <475199963.7200678.1457516997100.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Wednesday, 9 March, 2016 10:47:11 AM
> Subject: Re: [LTP] [PATCH] syscalls/fstatat01: fix test on x86_64 arch
> 
> Hi,
> On 03/09/2016 12:18 PM, Jan Stancek wrote:
> > ...
> > -/* TODO (garrcoop): properly port to fstatat64. */
> > -#if (defined __NR_fstatat64) && (__NR_fstatat64 != 0)
> > -struct stat64 statbuf;
> > -#else
> > -struct stat statbuf;
> > -#endif
> > -
> > -/*
> > - * XXX (garrcoop): NO NO NO NO NO NO NO NO NO ... use
> > linux_syscall_numbers.h!
> > - */
> > -/* __NR_fstatat64 and __NR_fstatat64 if not defined are ALWAYS stubbed by
> > - *  linux_syscall_numbers.h Need to check for 0 to avoid testing with
> > stubs
> > */
> > -#if (defined __NR_fstatat64) && (__NR_fstatat64 != 0)
> > -int myfstatat(int dirfd, const char *filename, struct stat64 *statbuf,
> > -	      int flags)
> > +#if !defined(HAVE_FSTATAT)
> > +#if (defined __NR_fstatat64) && (__NR_fstatat64 > 0)
> > +static struct stat64 statbuf;
> > +int fstatat(int dirfd, const char *filename, struct stat64 *statbuf, int
> > flags)
> >   {
> >   	return ltp_syscall(__NR_fstatat64, dirfd, filename, statbuf, flags);
> >   }
> > -#elif (defined __NR_newfstatat) && (__NR_newfstatat != 0)
> > -int myfstatat(int dirfd, const char *filename, struct stat *statbuf, int
> > flags)
> > +#else
> > Shouldn't we check that __NR_newfstatat is defined? There seem to be
> > architectures,
> > that don't define both fstatat64 and newfstatat.
> 
> It seems unnecessary... it should be defined in linux_syscall_numbers.h
> whether
> it is supported or not. In the last case __NR_newfstatat is defined as
> __LTP_NR_INVALID_SYSCALL,eventually we'll get TCONF for ltp_syscall(-1,
> ...).

You're right, regen.sh will add common stub as long as at least one arch
defines it (which we do).

Regards,
Jan

> 
> Thanks,
> Alexey
> 
> >
> > Regards,
> > Jan
> >
> >> +static struct stat statbuf;
> >> +int fstatat(int dirfd, const char *filename, struct stat *statbuf, int
> >> flags)
> >>   {
> >>   	return ltp_syscall(__NR_newfstatat, dirfd, filename, statbuf, flags);
> >>   }
> >> +#endif
> >>   #else
> >> -/* stub - will never run */
> >> -int myfstatat(int dirfd, const char *filename, struct stat *statbuf, int
> >> flags)
> >> -{
> >> -	return ltp_syscall(0, dirfd, filename, statbuf, flags);
> >> -}
> >> +static struct stat statbuf;
> >>   #endif
> >>   
> >>   int main(int ac, char **av)
> >> @@ -104,8 +92,7 @@ int main(int ac, char **av)
> >>   		tst_count = 0;
> >>   
> >>   		for (i = 0; i < TST_TOTAL; i++) {
> >> -			TEST(myfstatat
> >> -			     (fds[i], filenames[i], &statbuf, flags[i]));
> >> +			TEST(fstatat(fds[i], filenames[i], &statbuf, flags[i]));
> >>   
> >>   			if (TEST_ERRNO == expected_errno[i]) {
> >>   				tst_resm(TPASS | TTERRNO,
> >> --
> >> 1.7.1
> >>
> >>
> >> --
> >> Mailing list info: http://lists.linux.it/listinfo/ltp
> >>
> 
> 
