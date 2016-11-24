From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Nov 2016 10:08:13 +0100
Subject: [LTP] [PATCH 1/1] testcases/mq_notify01: convert to use new
 test library API
In-Reply-To: <20161124001132.5w65c3djdh42fotu@dell5510>
References: <20161121081327.8444-1-pvorel@suse.cz>
 <20161122080039.GB5620@rei.lan>
 <20161124001132.5w65c3djdh42fotu@dell5510>
Message-ID: <20161124090813.GB14986@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > These fds can be opened only once in the test setup and passed in the
> > testcase structure. We do it usually as:
> 
> > static int file_fd;
> 
> > struct testcase tcases[] = {
> > ...
> > 	TYPE_NAME(file);
> > 	.fd = &file_fd;
> > ...
> > }
> 
> > static void setup(void)
> > {
> > 	file_fd = creat("file", 0644);
> > 	...
> > }
> IMHO if I reuse message queue between tests I need to delete messages before each test,
> otherwise I don't get signal for SIGEV_SIGNAL and SIGEV_THREAD. I can empty them with
> mq_receive() but is it worth of doing it?

You are right, the manual page explicitly says that the queue must be
empty. Missed that.

Creating and destroying the queue on each iteration may work better
then.

-- 
Cyril Hrubis
chrubis@suse.cz
