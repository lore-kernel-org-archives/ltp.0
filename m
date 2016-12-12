From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 12 Dec 2016 16:07:15 +0100
Subject: [LTP] [PATCH v2 3/5] ipc/msgget01.c: cleanup && convert to new
	API
In-Reply-To: <1481087800-20639-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20161123135513.GI3346@rei.lan>
 <1481087800-20639-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1481087800-20639-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20161212150714.GF21828@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>  top_srcdir              ?= ../../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
> -include $(abs_srcdir)/../Makefile.inc
> +
> +LDLIBS		+= -lnewipc
> +NEWDIR		:= ../libnewipc
> +
> +CPPFLAGS	+= -I$(abs_srcdir)/$(NEWDIR)
> +LDFLAGS		+= -L$(abs_builddir)/$(NEWDIR)

I guess that we can simply write:

CPPFLAGS += -I$(abs_srcdir)/../libnewipc
LDFLAGS  += -L$(abs_builddir)/../libnewipc

It's not longer than defining the dir variable anyway.

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
> index e8208b7..bc6c73a 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
> @@ -1,186 +1,85 @@
>  /*
> + * Copyright (c) International Business Machines  Corp., 2001
>   *
> - *   Copyright (c) International Business Machines  Corp., 2001
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
>   *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
>   *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * You should have received a copy of the GNU General Public License
> + * along with this program.
>   */
>  
>  /*
> - * NAME
> - *	msgget01.c
> - *
>   * DESCRIPTION
> - *	msgget01 - create a message queue, write a message to it and
> - *		   read it back.
> - *
> - * ALGORITHM
> - *	loop if that option was specified
> - *	create a message queue
> - *	check the return code
> - *	  if failure, issue a FAIL message.
> - *	otherwise,
> - *	  if doing functionality testing by writting a message to the queue,
> - *	  reading it back and comparing the two.
> - *	  	if the messages are the same,
> - *			issue a PASS message
> - *		otherwise
> - *			issue a FAIL message
> - *	call cleanup
> - *
> - * USAGE:  <for command-line>
> - *  msgget01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -f   : Turn off functionality Testing.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -P x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	03/2001 - Written by Wayne Boyer
> - *
> - * RESTRICTIONS
> - *	none
> + * create a message queue, write a message to it and
> + * read it back.
>   */
>  
> -#include "ipcmsg.h"
> -
> +#include <errno.h>
>  #include <string.h>
> +#include <sys/types.h>
> +#include <sys/ipc.h>
> +#include <sys/msg.h>
>  
> -char *TCID = "msgget01";
> -int TST_TOTAL = 1;
> +#include "libnewipc.h"
> +#include "tst_test.h"
>  
> -int msg_q_1 = -1;		/* to hold the message queue ID */
> +static int msg_q_1 = -1;
> +static key_t msgkey;
>  
> -int main(int ac, char **av)
> +static struct buf {
> +	long type;
> +	char text[MSGSIZE + 1];
> +} snd_buf, rcv_buf;
> +
> +static void verify_msgget(void)
>  {
> -	int lc;
> -	void check_functionality(void);
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();		/* global setup */
> -
> -	/* The following loop checks looping state if -i option given */
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		/*
> -		 * Use TEST macro to make the call to create the message queue
> -		 */
> -
> -		TEST(msgget(msgkey, IPC_CREAT | IPC_EXCL | MSG_RD | MSG_WR));
> -
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
> -				 TCID, TEST_ERRNO, strerror(TEST_ERRNO));
> -		} else {
> -			msg_q_1 = TEST_RETURN;
> -			/*
> -			 * write a message to the queue.
> -			 * read back the message.
> -			 * PASS the test if they are the same.
> -			 */
> -			check_functionality();
> -		}
> -
> -		/*
> -		 * remove the message queue that was created and mark the ID
> -		 * as invalid.
> -		 */
> -		if (msg_q_1 != -1) {
> -			rm_queue(msg_q_1);
> -			msg_q_1 = -1;
> -		}
> +	TEST(msgget(msgkey, IPC_CREAT | MSG_RW));
> +	if (TEST_RETURN == -1) {
> +		tst_res(TFAIL | TTERRNO, "msgget() failed");
> +		return;
>  	}
>  
> -	cleanup();
> -	tst_exit();
> -}
> +	msg_q_1 = TEST_RETURN;
>  
> -/*
> - * check_functionality() - check the functionality of the tested system call.
> - */
> -void check_functionality(void)
> -{
> -	int i = 0;
> -	MSGBUF snd_buf, rcv_buf;
> -
> -	/* EAGLE: Houston, Tranquility Base here. The Eagle has landed! */
> -	char *queue_msg =
> -	    "Qston, check_functionality here.  The message has queued!";
> -
> -	/*
> -	 * copy our message into the buffer and then set the type.
> -	 */
> -	do {
> -		snd_buf.mtext[i++] = *queue_msg;
> -	} while (*queue_msg++ != '\0');
> -
> -	snd_buf.mtype = MSGTYPE;
> -
> -	/* send the message */
> -	if (msgsnd(msg_q_1, &snd_buf, MSGSIZE, 0) == -1) {
> -		tst_brkm(TBROK, cleanup, "Could not send a message in the "
> -			 "check_functionality() routine.");
> -	}
> +	if (msgsnd(msg_q_1, &snd_buf, MSGSIZE, 0) == -1)
> +		tst_brk(TBROK | TERRNO, "msgsnd() failed");
>  
> -	/* receive the message */
> -	if (msgrcv(msg_q_1, &rcv_buf, MSGSIZE, MSGTYPE, IPC_NOWAIT) == -1) {
> -		tst_brkm(TBROK, cleanup, "Could not read a messages in the "
> -			 "check_functionality() routine.");
> -	}
> +	if (msgrcv(msg_q_1, &rcv_buf, MSGSIZE, MSGTYPE, IPC_NOWAIT) == -1)
> +		tst_brk(TBROK | TERRNO, "msgrcv() failed");
>  
> -	if (strcmp(snd_buf.mtext, rcv_buf.mtext) == 0) {
> -		tst_resm(TPASS, "message received = message sent");
> -	} else {
> -		tst_resm(TFAIL, "message received != message sent");
> -	}
> +	if (strcmp(snd_buf.text, rcv_buf.text) == 0)
> +		tst_res(TPASS, "message received = message sent");
> +	else
> +		tst_res(TFAIL, "message received != message sent");
>  }
>  
> -/*
> - * setup() - performs all the ONE TIME setup for this test.
> - */
> -void setup(void)
> +static void setup(void)
>  {
> +	msgkey = getipckey();
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/*
> -	 * Create a temporary directory and cd into it.
> -	 * This helps to ensure that a unique msgkey is created.
> -	 * See ../lib/libipc.c for more information.
> -	 */
> -	tst_tmpdir();
> +	strcpy(snd_buf.text, "hello world");
>  
> -	msgkey = getipckey();
> +	snd_buf.type = MSGTYPE;

You can initialize the snd_buf statically.

>  }
>  
> -/*
> - * cleanup() - performs all the ONE TIME cleanup for this test at completion
> - * 	       or premature exit.
> - */
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	/* if it exists, remove the message queue that was created */
>  	rm_queue(msg_q_1);
>  
> -	tst_rmdir();
> -
> +	msg_q_1 = -1;

There is no reason to reset msg_q_1 here, since we will never get back
to the test code once we call cleanup in the test library.

>  }
> +
> +static struct tst_test test = {
> +	.tid = "msgget01",
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_msgget,
> +	.needs_tmpdir = 1
> +};
> -- 
> 1.8.3.1
> 
> 
> 

-- 
Cyril Hrubis
chrubis@suse.cz
