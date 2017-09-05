From: Sandeep Patil <sspatil@google.com>
Date: Tue, 5 Sep 2017 15:20:31 -0700
Subject: [LTP] [PATCH] android: madvise08: fix for android devices.
In-Reply-To: <20170829121350.GG31839@rei.lan>
References: <20170828212444.123677-1-sspatil@google.com>
 <20170829121350.GG31839@rei.lan>
Message-ID: <20170905222031.GT84377@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 29, 2017 at 02:13:50PM +0200, Cyril Hrubis wrote:
> Hi!
> >  static void setup(void)
> >  {
> > @@ -80,7 +81,7 @@ static void setup(void)
> >  	if (!(0x1 & filter))
> >  		tst_brk(TCONF, "Anonymous private memory is not dumpable.");
> >  
> > -	SAFE_FILE_SCANF(CORE_PATTERN, "%m[^\n]", &cpattern);
> > +	SAFE_FILE_SCANF(CORE_PATTERN, "%s[^\n]", cpattern);
> >  	tst_res(TINFO, "System core pattern is '%s'", cpattern);
> >  
> >  	SAFE_GETCWD(cwd, sizeof(cwd));
> > @@ -108,10 +109,7 @@ static void setup(void)
> >  
> >  static void cleanup(void)
> >  {
> > -	if (cpattern)
> > -		SAFE_FILE_PRINTF(CORE_PATTERN, "%s", cpattern);
> > -
> > -	free(cpattern);
> > +	SAFE_FILE_PRINTF(CORE_PATTERN, "%s", cpattern);
> 
> This change breaks the test in a case that tst_brk() is called before we
> read the cpattern successfully, as we will write and empty string to the
> cpattern file here in the test cleanup. We have to restore it only and
> only if it was read correctly. We may as well add a flag called
> restore_pattern and set it to 1 once we write with SAFE_FILE_PRINTF() in
> the test setup and use it here.

Ack and I did miss that path. Fixing in v2 with a 'restore_cpattern' flag.

- ssp

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
