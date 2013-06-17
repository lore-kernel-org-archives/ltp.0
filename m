Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uoc9Y-00047c-Bb
	for ltp-list@lists.sourceforge.net; Mon, 17 Jun 2013 16:19:36 +0000
Date: Mon, 17 Jun 2013 18:21:04 +0200
From: chrubis@suse.cz
Message-ID: <20130617162103.GC2053@rei>
References: <7258543eb9e994c30bac3c3b9547178c1a1f88f7.1370958327.git.jstancek@redhat.com>
	<20130617151358.GA2053@rei>
	<790434361.3815720.1371483737505.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <790434361.3815720.1371483737505.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] new testcase: kmsg01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > +static void test_read_returns_first_message(void)
> > > +{
> > > +	char msg[NUM_READ_MSGS][MAX_MSGSIZE];
> > > +	int msgs_match = 1;
> > > +	int i;
> > > +
> > > +	tst_resm(TINFO, "TEST: mult. readers will get same first message");
> > > +	for (i = 0; i < NUM_READ_MSGS; i++) {
> > > +		if (find_msg(-1, "", msg[i], MAX_MSGSIZE, 1) != 0)
> > > +			tst_resm(TFAIL, "failed to find any message");
> > > +	}
> > > +
> > > +	for (i = 0; i < NUM_READ_MSGS-1; i++)
> > > +		if (strlen(msg[i]) > 0 && strcmp(msg[i], msg[i+1]) != 0)
> > > +			msgs_match = 0;
> > > +	if (msgs_match)
> > > +		tst_resm(TPASS, "all readers got same message on first read");
> > > +	else
> > > +		tst_resm(TFAIL, "readers got different messages");
> > 
> > Is here a chance that the log would be overwritten by a kernel writing
> > urelated message? We do fill the log with a bunch of messages (126)
> > before this test, how much of the kernel log is filled by this? Looking
> > in the kernel .config I have LOG_BUF_SHIFT=18 which is 256KB which
> > should be large enough, but it could be set as low as 12 which is 4KB.
> 
> It is. Let's open extra fd, which we attempt to read only at the end.
> If reads fails with EPIPE we know that first message was overwritten.
> If that happens we can retry for NUM_READ_RETRY and repeat the test.
> If we get EPIPE in each attempt we can report TWARN.
> 

Souns good.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
