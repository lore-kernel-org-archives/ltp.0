From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 6 Mar 2017 03:18:26 -0500 (EST)
Subject: [LTP] [PATCH] kmsg01: fix race in SEEK_SET 0 test
In-Reply-To: <20170303143643.GC16323@rei.lan>
References: <6629de071a23c5a8df8eca358a55e5ae9ccc969e.1488447021.git.jstancek@redhat.com>
 <20170303143643.GC16323@rei.lan>
Message-ID: <1967673779.3483232.1488788306768.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Friday, 3 March, 2017 3:36:44 PM
> Subject: Re: [LTP] [PATCH] kmsg01: fix race in SEEK_SET 0 test
> 
> Hi!
> > +static int read_msg_seqno(int fd, unsigned long *seqno)
> > +{
> > +	char msg[MAX_MSGSIZE];
> > +
> > +	TEST(read(fd, msg, sizeof(msg)));
> > +	if (TEST_RETURN == -1 && TEST_ERRNO != EPIPE) {
> > +		tst_brkm(TBROK|TTERRNO, cleanup,
> > +			"failed to read /dev/kmsg");
> > +	}
> 
> Shouldn't we return -1 here on EPIPE as well?
> 
> 	if (TEST_ERRNO == EPIPE)
> 		return -1;

Yes, you're right. I had it returning -1 by default,
but then switched it to 0 and missed this case.

> 
> > +	if (get_msg_fields(msg, NULL, seqno) != 0) {
> > +		tst_resm(TFAIL, "failed to parse seqid: %s", msg);
> > +		return -1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void test_seek(void)
> >  {
> > -	int k, j = NUM_READ_RETRY, fd;
> > +	int j, fd, fd2;
> >  	char msg[MAX_MSGSIZE];
> > -	unsigned long seqno[2];
> > +	unsigned long seqno[2], tmp;
> > +	int done = 0;
> >  
> >  	/* 1. read() after SEEK_SET 0 returns same (first) message */
> >  	tst_resm(TINFO, "TEST: seek SEEK_SET 0");
> >  
> > -	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
> > -	if (fd < 0)
> > -		tst_brkm(TBROK|TERRNO, cleanup,	"failed to open /dev/kmsg");
> > -
> > -	while (j) {
> > -		for (k = 0; k < 2; k++) {
> > -			TEST(read(fd, msg, sizeof(msg)));
> > -			if (TEST_RETURN == -1) {
> > -				if (errno == EPIPE)
> > -					break;
> > -				else
> > -					tst_brkm(TBROK|TTERRNO, cleanup,
> > -						"failed to read /dev/kmsg");
> > -			}
> > -			if (get_msg_fields(msg, NULL, &seqno[k]) != 0)
> > -				tst_resm(TFAIL, "failed to parse seqid: %s",
> > -					msg);
> > -			if (k == 0)
> > -				if (lseek(fd, 0, SEEK_SET) == -1)
> > -					tst_resm(TFAIL|TERRNO,
> > -						"SEEK_SET 0 failed");
> > +	for (j = 0; j < NUM_READ_RETRY && !done; j++) {
> > +		/*
> > +		 * j > 0 means we are trying again, because we most likely
> > +		 * failed on read returning EPIPE - first message in buffer
> > +		 * has been overwrittern. Give a second to whoever overwrote
> > +		 * first message to finish.
> > +		 */
> > +		if (j)
> > +			sleep(1);
> 
> What about changing it to 0.1s here? Or are there processes that keeps
> feeding the kernel log buffer for a second or more?

Yes, we can go with 0.1.

> 
> > +		/*
> > +		 * Open 2 fds. Use fd1 to read seqno1, then seek to
> > +		 * begininng and read seqno2. Use fd2 to check if
> > +		 * first entry in buffer got overwritten. If so,
> > +		 * we'll have to repeat the test.
> > +		 */
> > +		fd = SAFE_OPEN(cleanup, "/dev/kmsg", O_RDONLY | O_NONBLOCK);
> > +		fd2 = SAFE_OPEN(cleanup, "/dev/kmsg", O_RDONLY | O_NONBLOCK);
> > +
> > +		if (read_msg_seqno(fd, &seqno[0]))
> > +			goto close_fds;
> > +
> > +		if (lseek(fd, 0, SEEK_SET) == -1) {
> > +			tst_resm(TFAIL|TERRNO, "SEEK_SET 0 failed");
> > +			goto done;
> 
> I wonder if this should be tst_brkm() rather than tst_resm(), since as
> it is we would end up printing the TFAIL message below, or am I
> mistaken?

I can skip the TFAIL message below, but I find TFAIL here more fitting,
because it is directly related to what's being tested. 

> 
> >  		}
> >  
> > -		if (TEST_RETURN != -1)
> > -			break;
> > +		if (read_msg_seqno(fd, &seqno[1]))
> > +			goto close_fds;
> >  
> > -		/* give a second to whoever overwrote first message to finish */
> > -		sleep(1);
> > -		j--;
> > +		if (read_msg_seqno(fd2, &tmp))
> > +			goto close_fds;
> >  
> > -		/* read above has returned EPIPE, reopen fd and try again */
> > +done:
> > +		done = 1;
> > +close_fds:
> >  		SAFE_CLOSE(cleanup, fd);
> > -		fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
> > -		if (fd < 0)
> > -			tst_brkm(TBROK|TERRNO, cleanup,
> > -				"failed to open /dev/kmsg");
> > +		SAFE_CLOSE(cleanup, fd2);
> >  	}
> >  
> > -	if (!j) {
> > +	if (j == NUM_READ_RETRY) {
> >  		tst_resm(TWARN, "exceeded: %d attempts", NUM_READ_RETRY);
> >  	} else {
> > -		if (seqno[0] != seqno[1])
> > -			tst_resm(TFAIL, "SEEK_SET 0");
> > -		else
> > +		if (seqno[0] != seqno[1]) {
> > +			tst_resm(TFAIL, "SEEK_SET 0, %lu != %lu",
> > +				seqno[0], seqno[1]);
> > +		} else {
> >  			tst_resm(TPASS, "SEEK_SET 0");
> > +		}
> >  	}
> >  
> >  	/* 2. messages after SEEK_END 0 shouldn't contain MSG_PREFIX */
> > +	fd = SAFE_OPEN(cleanup, "/dev/kmsg", O_RDONLY | O_NONBLOCK);
> >  	tst_resm(TINFO, "TEST: seek SEEK_END 0");
> >  	if (lseek(fd, 0, SEEK_END) == -1)
> >  		tst_resm(TFAIL|TERRNO, "lseek SEEK_END 0 failed");
> 
> Otherwise it looks OK.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
