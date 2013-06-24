Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ur7Cr-0004hE-G6
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 13:53:21 +0000
Date: Mon, 24 Jun 2013 15:54:47 +0200
From: chrubis@suse.cz
Message-ID: <20130624135447.GA2557@rei>
References: <016bca5a3f28e308234e5b1028a831e5fa50fda6.1371736603.git.jstancek@redhat.com>
	<20130624132249.GC1638@rei>
	<2114792229.1514957.1372081597213.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2114792229.1514957.1372081597213.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v2] new testcase: kmsg01
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
> > > +static void test_seek(void)
> > > +{
> > > +	int k, j = NUM_READ_RETRY, fd;
> > > +	char msg[MAX_MSGSIZE];
> > > +	unsigned long seqno[2];
> > > +
> > > +	/* 1. read() after SEEK_SET 0 returns same (first) message */
> > > +	tst_resm(TINFO, "TEST: seek SEEK_SET 0");
> > > +
> > > +	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
> > > +	if (fd < 0)
> > > +		tst_brkm(TBROK|TERRNO, cleanup,	"failed to open /dev/kmsg");
> > > +
> > > +	while (j) {
> > > +		for (k = 0; k < 2; k++) {
> > > +			TEST(read(fd, msg, sizeof(msg)));
> > > +			if (TEST_RETURN == -1) {
> > > +				if (errno == EPIPE)
> > > +					break;
> > > +				else
> > > +					tst_brkm(TBROK|TTERRNO, cleanup,
> > > +						"failed to read /dev/kmsg");
> > > +			}
> > > +			if (get_msg_fields(msg, NULL, &seqno[k]) != 0)
> > > +				tst_resm(TFAIL, "failed to parse seqid: %s",
> > > +					msg);
> > > +			if (k == 0)
> > > +				if (lseek(fd, 0, SEEK_SET) == -1)
> > > +					tst_resm(TFAIL|TERRNO,
> > > +						"SEEK_SET 0 failed");
> > > +		}
> > > +
> > > +		if (TEST_RETURN != -1)
> > > +			break;
> > > +
> > > +		/* give a second to whoever overwrote first message to finish */
> > > +		sleep(1);
> > > +		j--;
> > > +
> > > +		/* read returned EPIPE, reopen fd and try again */
> > > +		SAFE_CLOSE(cleanup, fd);
> > > +		fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
> > > +		if (fd < 0)
> > > +			tst_brkm(TBROK|TERRNO, cleanup,
> > > +				"failed to open /dev/kmsg");
> > 
> > I guess that the comment says something different than the code, there
> > is no read involved here.
> 
> Read mentioned here is the one at the beginning of for loop. This line can only
> be reached if that read returned EPIPE. Other failures will end with TBROK.
> If read succeeded this line is never reached, "if (TEST_RETURN != -1)" above
> will break the while loop.

Ah it could be read as imperative sentence too, which confused me
slightly.

I guess that "read has returned EPIPE" would be clearer...

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
