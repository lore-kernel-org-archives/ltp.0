Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XYc30-0000Ob-RX
	for ltp-list@lists.sourceforge.net; Mon, 29 Sep 2014 14:35:30 +0000
Date: Mon, 29 Sep 2014 16:35:04 +0200
From: chrubis@suse.cz
Message-ID: <20140929143504.GA11010@rei>
References: <1411646861-19217-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1411646861-19217-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH] lib/tst_checkpoint.c: added support for unlimited
 number of named pipes
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!

What is the motivation for the patch?

I guess that you want to synchronize a parent process with two or more
children, right? That case can be solved more elegantly by calling
TST_CHECKPOINT_PARENT_WAIT() twice and doing
TST_CHECKPOINT_CHILD_SIGNAL() in each child.

> Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
> ---
>  include/tst_checkpoint.h |  5 ++++-
>  lib/tst_checkpoint.c     | 36 ++++++++++++++++++++++--------------
>  2 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
> index f2d7efe..a396c04 100644
> --- a/include/tst_checkpoint.h
> +++ b/include/tst_checkpoint.h
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (C) 2012 Cyril Hrubis chrubis@suse.cz
> + * Copyright (C) 2014 Matus Marhefka mmarhefk@redhat.com
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of version 2 of the GNU General Public License as
> @@ -36,9 +37,11 @@
>  
>  #include "test.h"
>  
> -#define TST_CHECKPOINT_FIFO "tst_checkpoint_fifo"
> +#define TST_CHECKPOINT_FIFO "tst_checkpoint_fifo_"
> +#define FIFO_LEN 30
>  
>  struct tst_checkpoint {
> +	char file[FIFO_LEN];
>  	/* child return value in case of failure */
>  	int retval;
>  	/* timeout in msecs */
> diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
> index 695cd3e..bc5d303 100644
> --- a/lib/tst_checkpoint.c
> +++ b/lib/tst_checkpoint.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (C) 2012 Cyril Hrubis chrubis@suse.cz
> + * Copyright (C) 2014 Matus Marhefka mmarhefk@redhat.com
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of version 2 of the GNU General Public License as
> @@ -70,6 +71,8 @@ int open_wronly_timed(const char *path, unsigned int timeout)
>  void tst_checkpoint_init(const char *file, const int lineno,
>                           struct tst_checkpoint *self)
>  {
> +	char *fn;
> +
>  	if (!tst_tmpdir_created()) {
>  		tst_brkm(TBROK, NULL, "Checkpoint could be used only in test "
>  		                      "temporary directory at %s:%d",
> @@ -77,15 +80,20 @@ void tst_checkpoint_init(const char *file, const int lineno,
>  	}
>  	
>  	/* default values */
> +	strcpy(self->file, TST_CHECKPOINT_FIFO"XXXXXX");
> +	fn = mktemp(self->file);
> +	if (*fn == '\0') {
> +		tst_brkm(TBROK | TERRNO , NULL,
> +			 "Failed to create a unique temp file at %s:%d",
> +			 file, lineno);
> +	}
>  	self->retval = 1;
>  	self->timeout = 5000;
>  
> -	unlink(TST_CHECKPOINT_FIFO);
> -
> -	if (mkfifo(TST_CHECKPOINT_FIFO, 0666)) {
> +	if (mkfifo(self->file, 0666)) {
>  		tst_brkm(TBROK | TERRNO, NULL,
>  		         "Failed to create fifo '%s' at %s:%d",
> -		         TST_CHECKPOINT_FIFO, file, lineno);
> +		         self->file, file, lineno);
>  	}

There is no need for the whole mktemp() and unique names. It is ensured
that the fifo is created in the test temporary directory, which is
unique for each test instance. So if we need to create multiple fifos we
can just number them or something.

>  }
>  
> @@ -97,12 +105,12 @@ void tst_checkpoint_parent_wait(const char *file, const int lineno,
>  	char ch;
>  	struct pollfd fd;
>  
> -	fd.fd = open(TST_CHECKPOINT_FIFO, O_RDONLY | O_NONBLOCK);
> +	fd.fd = open(self->file, O_RDONLY | O_NONBLOCK);
>  
>  	if (fd.fd < 0) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  		         "Failed to open fifo '%s' at %s:%d",
> -		         TST_CHECKPOINT_FIFO, file, lineno);
> +		         self->file, file, lineno);
>  	}
>  
>  	fd.events = POLLIN;
> @@ -121,7 +129,7 @@ void tst_checkpoint_parent_wait(const char *file, const int lineno,
>  	default:
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  		         "Poll failed for fifo '%s' at %s:%d",
> -			 TST_CHECKPOINT_FIFO, file, lineno);
> +			 self->file, file, lineno);
>  	}
>  
>  	ret = read(fd.fd, &ch, 1);
> @@ -157,11 +165,11 @@ void tst_checkpoint_child_wait(const char *file, const int lineno,
>  	int ret, fd;
>  	char ch;
>  
> -	fd = open(TST_CHECKPOINT_FIFO, O_RDONLY);
> +	fd = open(self->file, O_RDONLY);
>  
>  	if (fd < 0) {
>  		fprintf(stderr, "CHILD: Failed to open fifo '%s': %s at "
> -		        "%s:%d\n", TST_CHECKPOINT_FIFO, strerror(errno),
> +		        "%s:%d\n", self->file, strerror(errno),
>  		        file, lineno);
>  		exit(self->retval);
>  	}
> @@ -170,7 +178,7 @@ void tst_checkpoint_child_wait(const char *file, const int lineno,
>  
>  	if (ret == -1) {
>  		fprintf(stderr, "CHILD: Failed to read from fifo '%s': %s "
> -		        "at %s:%d\n", TST_CHECKPOINT_FIFO, strerror(errno),
> +		        "at %s:%d\n", self->file, strerror(errno),
>  		        file, lineno);
>  		goto err;
>  	}
> @@ -193,11 +201,11 @@ void tst_checkpoint_signal_parent(const char *file, const int lineno,
>  {
>  	int ret, fd;
>  	
> -	fd = open(TST_CHECKPOINT_FIFO, O_WRONLY);
> +	fd = open(self->file, O_WRONLY);
>  
>  	if (fd < 0) {
>  		fprintf(stderr, "CHILD: Failed to open fifo '%s': %s at %s:%d",
> -		        TST_CHECKPOINT_FIFO, strerror(errno), file, lineno);
> +		        self->file, strerror(errno), file, lineno);
>  		exit(self->retval);
>  	}
>  
> @@ -229,12 +237,12 @@ void tst_checkpoint_signal_child(const char *file, const int lineno,
>  {
>  	int ret, fd;
>  	
> -	fd = open_wronly_timed(TST_CHECKPOINT_FIFO, self->timeout);
> +	fd = open_wronly_timed(self->file, self->timeout);
>  
>  	if (fd < 0) {
>  		tst_brkm(TBROK | TERRNO, cleanup_fn,
>  		         "Failed to open fifo '%s' at %s:%d",
> -		         TST_CHECKPOINT_FIFO, file, lineno);
> +		         self->file, file, lineno);
>  	}
>  
>  	ret = write(fd, "p", 1);
> -- 
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
> Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
> Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
> Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
> http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
