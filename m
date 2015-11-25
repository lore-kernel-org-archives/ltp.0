From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Nov 2015 11:47:47 +0100
Subject: [LTP] [PATCH V3] controllers/pids: Add new testcases
In-Reply-To: <56558EA3.5000607@suse.com>
References: <1448026487-6079-1-git-send-email-chnyda@suse.com>
 <56557D6F.80906@oracle.com> <56558EA3.5000607@suse.com>
Message-ID: <20151125104747.GA24599@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Is it necessary to add a busy loop to completely load CPU? If we only 
> > wait, I would add a sleep, something like
> >
> > while (1)
> >      usleep(10);
> >
> 
> You are absolutely right, it is not needed at all to completely load CPU.
> Maybe it would also be better to use sleep rather than usleep.

Or we can call pause(2) which will block the process until signal
arrives.

-- 
Cyril Hrubis
chrubis@suse.cz
