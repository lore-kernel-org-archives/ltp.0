From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Feb 2017 15:35:25 +0100
Subject: [LTP] [PATCH] aio_suspend_4-1: Fix failures on s390x
In-Reply-To: <93175945.2218188.1486050040647.JavaMail.zimbra@redhat.com>
References: <20170202132226.32352-1-chrubis@suse.cz>
 <93175945.2218188.1486050040647.JavaMail.zimbra@redhat.com>
Message-ID: <20170207143524.GA2839@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  	/* Wait for list processing completion */
> >  	while (!received_all)
> > -		sleep(1);
> > +		usleep(50000);
> 
> Should we limit this loop by some counter? If something goes wrong,
> this can loop forever.

I've added a 5 minute limit here, which should be more than enough since
the test runs for less than one second.

> Other than nit above, it looks good to me, ACK.

And pushed with your ack.

-- 
Cyril Hrubis
chrubis@suse.cz
