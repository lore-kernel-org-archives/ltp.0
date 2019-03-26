From: Sandeep Patil <sspatil@android.com>
Date: Tue, 26 Mar 2019 21:44:48 +0900
Subject: [LTP] [PATCH 2/4] syscalls/accept01: convert to new library.
In-Reply-To: <20190326123519.GB32549@rei.lan>
References: <20190325232012.67123-1-sspatil@android.com>
 <20190325232012.67123-3-sspatil@android.com>
 <20190326123519.GB32549@rei.lan>
Message-ID: <20190326124448.GB5826@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 26, 2019 at 01:35:19PM +0100, Cyril Hrubis wrote:
> Hi!
> > +static void setup_invalid_fd(struct test_case *tcase);
> > +static void setup_nonsocket_fd(struct test_case *tcase);
> > +static void setup_socket(struct test_case *tcase);
> > +static void setup_fionbio(struct test_case *tcase);
> > +static void cleanup_tcase(struct test_case *tcase);
> 
> Actually there is no need to have the setup & cleanup functions to be
> executed at runtime, we can do all the test setup in the test setup and
> cleanup in test cleanup.
> 
> We usually tend to solve this by making the fd in the testcase structure
> a pointer and initializing it with a pointer to global variable that is
> then intialized in setup. See for example syscalls/read/read02.c

Ack, I think this may have been a mix of both before, I can rework to use
globals easily instead.

> 
> > +/* test cases */
> 
> This is useless comment.

yes, will remove.
> 
> > +static struct test_case {
> >  	int domain;		/* PF_INET, PF_UNIX, ... */
> >  	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
> >  	int proto;		/* protocol number (usually 0 = default) */
> > +	int socketfd;		/* socketfd for the test case */
> >  	struct sockaddr *sockaddr;	/* socket address buffer */
> > -	socklen_t *salen;	/* accept's 3rd argument */
> > +	socklen_t salen;	/* accept's 3rd argument */
> >  	int retval;		/* syscall return value */
> >  	int experrno;		/* expected errno */
> > -	void (*setup) (void);
> > -	void (*cleanup) (void);
> > +	void (*setup) (struct test_case *);
> > +	void (*cleanup) (struct test_case *);
> >  	char *desc;
> > -} tdat[] = {
> 
> ...
> 
> > +		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)&fsin1,
> > +		sizeof(fsin1), -1, EBADF, setup_invalid_fd, NULL,
> > +		"bad file descriptor"
> > +	},
> > +	{
> > +		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)&fsin1,
> > +		sizeof(fsin1), -1, ENOTSOCK, setup_nonsocket_fd,
> > +		cleanup_tcase, "bad file descriptor"
>                                  ^
> 				 Better description would be:
> 
>                                  "fd is not socket"
> 
> > +	},
> > +	{
> > +		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)3,
> > +		sizeof(fsin1), -1, EINVAL, setup_socket, cleanup_tcase,
> > +		"invalid socket buffer"
> > +	},
> > +	{
> > +		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)&fsin1,
> > +		1, -1, EINVAL, setup_socket, cleanup_tcase,
> > +		"invalid salen"
> > +	},
> > +	{
> > +		PF_INET, SOCK_STREAM, 0, -1, (struct sockaddr *)&fsin1,
> > +		sizeof(fsin1), -1, EINVAL, setup_fionbio, cleanup_tcase,
> > +		"no queued connections"
> > +	},
> > +	{
> > +		PF_INET, SOCK_DGRAM, 0, -1, (struct sockaddr *)&fsin1,
> > +		sizeof(fsin1), -1, EOPNOTSUPP, setup_socket, cleanup_tcase,
> > +		"UDP accept"
> > +	},
> > +};
> >  
> > -static void setup(void)
> > -{
> > -	TEST_PAUSE;
> >  
> > -	/* initialize local sockaddr */
> > -	sin0.sin_family = AF_INET;
> > -	sin0.sin_port = 0;
> > -	sin0.sin_addr.s_addr = INADDR_ANY;
> > -}
> >  
> > -static void cleanup(void)
> > +static void setup_invalid_fd(struct test_case *tcase)
> >  {
> > +	tcase->socketfd = 400; /* anything that is not an open file */
> >  }
> >  
> > -static void setup0(void)
> > +static void setup_nonsocket_fd(struct test_case *tcase)
> >  {
> > -	if (tdat[testno].experrno == EBADF)
> > -		s = 400;	/* anything not an open file */
> > -	else if ((s = open("/dev/null", O_WRONLY)) == -1)
> > -		tst_brkm(TBROK | TERRNO, cleanup, "error opening /dev/null");
> > +	tcase->socketfd = SAFE_OPEN("/dev/null", O_WRONLY);
> >  }
> >  
> > -static void cleanup0(void)
> > +static void setup_socket(struct test_case *tcase)
> >  {
> > -	s = -1;
> > +	tcase->socketfd = SAFE_SOCKET(tcase->domain, tcase->type, tcase->proto);
> > +	SAFE_BIND(tcase->socketfd, (struct sockaddr *)&sin0, sizeof(sin0));
> > +	tcase->salen = sizeof(fsin1);
> >  }
> >  
> > -static void setup1(void)
> > +static void setup_fionbio(struct test_case *tcase)
> >  {
> > -	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
> > -			tdat[testno].proto);
> > -	SAFE_BIND(cleanup, s, (struct sockaddr *)&sin0, sizeof(sin0));
> > -	sinlen = sizeof(fsin1);
> > +	int one = 1;
> > +	setup_socket(tcase);
> > +	SAFE_IOCTL(tcase->socketfd, FIONBIO, &one);
> >  }
> >  
> > -static void cleanup1(void)
> > +static void cleanup_tcase(struct test_case *tcase)
> >  {
> > -	(void)close(s);
> > -	s = -1;
> > +	if (tcase->socketfd >= 0)
> > +		SAFE_CLOSE(tcase->socketfd);
> > +
> > +	tcase->socketfd = -1;
> >  }
> >  
> > -static void setup2(void)
> > +void verify_accept(unsigned int nr)
> >  {
> > -	setup1();		/* get a socket in s */
> > -	sinlen = 1;		/* invalid s */
> > +	struct test_case *tcase = &tcases[nr];
> > +
> > +	if (tcase->setup)
> > +		tcase->setup(tcase);
> > +
> > +	TEST(accept(tcase->socketfd, tcase->sockaddr, &tcase->salen));
> > +	if (TST_RET > 0) {
> > +		/* don't leak accepted socket, close them first */
> > +		SAFE_CLOSE(TST_RET);
> > +		TST_RET = 0;
> > +	}
> > +
> > +	if (TST_RET != tcase->retval ||
> > +		(TST_RET < 0 && TST_ERR != tcase->experrno)) {
> > +		tst_res(TFAIL, "%s ; returned"
> > +				" %ld (expected %d), errno %d (expected"
> > +				" %d)", tcase->desc, TST_RET, tcase->retval,
> > +				TST_ERR, tcase->experrno);
> 
> 
> It would be better to split this, since we are doing only error return
> tests in this file we can do:
> 
> 
> 	if (TST_RET != -1) {
> 		tst_res(TFAIL, "%s: returned %i, expected -1", tcase->desc);
> 		return;
> 	}
> 
> 	if (TST_ERR != tcase->experr) {
> 		tst_res(TFAIL | TTERRNO, "%s: expected %s", tcase->desc,
> 		        tst_strerrno(tcase->exp));
> 		return;
> 	}
> 
> 	tst_res(TPASS | TTERRNO, "%s", tcase->desc);
> 
> > +	} else {
> > +		tst_res(TPASS, "%s successful", tcase->desc);
> 
> Other than that it looks good.

Thanks, I'll rework and send this.

- ssp

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
