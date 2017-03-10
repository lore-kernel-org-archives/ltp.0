From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 10 Mar 2017 16:09:23 +0100
Subject: [LTP] [PATCH v4 1/3] syscalls/mq_timedreceive: convert to new
	API
In-Reply-To: <20170310150834.c4fkjkefshzjjtft@dell5510>
References: <20170308142154.25916-1-pvorel@suse.cz>
 <20170310144600.GA2017@rei.lan>
 <20170310150834.c4fkjkefshzjjtft@dell5510>
Message-ID: <20170310150923.GD2017@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > (90% of the changes fixes the -i looping argument as we have to close
> >  file descriptors, initialize timeouts correctly on each iteration, etc.)
> Good tip for testing, thanks!

I usually run the test with -i at least 100 which tends to catch various
problems...

-- 
Cyril Hrubis
chrubis@suse.cz
