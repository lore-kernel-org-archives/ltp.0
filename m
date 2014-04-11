Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WYYgA-00054m-FL
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 10:27:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WYYg8-0000x5-SU
	for ltp-list@lists.sourceforge.net; Fri, 11 Apr 2014 10:27:26 +0000
Message-ID: <5347C312.80509@cn.fujitsu.com>
Date: Fri, 11 Apr 2014 18:25:22 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1397122484-29192-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<592669147.2947135.1397129256250.JavaMail.zimbra@redhat.com>
In-Reply-To: <592669147.2947135.1397129256250.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH v2] pipeio/pipeio.c: cleanup
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

Hi,
On 04/10/2014 07:27 PM, Jan Stancek wrote:
>
>> +static int Nchildcomplete;
> I'd suggest sig_atomic_t here.

Yes, it should be.
>
>> +
>> +static int error;
>> +static int count;
>> +static int num_writers = 1;	/* number of writers */
>> +static int num_writes = 1;	/* number of writes per child */
>> +static int loop;		/* loop indefinitely */
>> +static int exit_error = 1;	/* exit on error #, zero means no exit */
>> +static int size = 327;		/* default size */
>> +static int unpipe;		/* un-named pipe if non-zero */
>> +static int verbose;		/* verbose mode if set */
>> +static int quiet;		/* quiet mode if set */
>> +static int num_rpt;		/* ping number, how often to print message */
>> +static int chld_wait;	/* max time to wait between writes, 1 == no wait */
>> +static int parent_wait;	/* max time to wait between reads, 1 == no wait */
>> +static int ndelay = O_NDELAY;	/* additional flag to open */
>> +static char *writebuf;
>> +static char *readbuf;
>> +static char pname[PATH_MAX];	/* contains the name of the unamed pipe */
>> +static char *blk_type = NON_BLOCKING_IO; /* blocking i/o or not */
>> +static char *pipe_type;		/* type of pipe under test */
>> +static int fds[2];		/* un-named pipe fds */
>> +static int read_fd;
>> +static int write_fd;
>> +static int empty_read;
>> +static int format = HEX;
>> +static int format_size = -1;
>> +static int iotype;		/* sync io */
>> +static int sem_id;
>> +static struct sembuf sem_op;
> Some of these variables could be local: "fds" only in setup(),
> "sem_op" could be local in do_child() and do_parent().
>
> I'd suggest to also split this list of global variables, so it's clear
> which are modified as part of setup and which change value
> also throughout the run.
OK, it's reasonable, thanks.

Regards,
Xiaoguang Wang
>
> Split of code into functions looked OK to me.
>
> Regards,
> Jan
> .
>


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
