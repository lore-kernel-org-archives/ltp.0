From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 19 May 2017 02:41:55 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] tst_test: Be more verbose on timeout
In-Reply-To: <20170518085707.30523-1-chrubis@suse.cz>
References: <20170518085707.30523-1-chrubis@suse.cz>
Message-ID: <1877075389.14609671.1495176115788.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> I've recently stumbled upon a test that caused deadlock in the kernel
> and the test processes could not be killed because of that. This was
> while testing fanotify07 testcase on unpatched kernel.
> 
> In that case the test library just slept in the waitpid() call forever
> without
> producing any output. That was since the alarm handler that sends the SIGKILL
> to the test processes has fired but the processes stayed alive due to the
> kernel bug.
> 
> This patch makes this situation more verbose we:
> 
> * Print a message that we are about to kill the test process once it has
>   timeouted so that the user knows that something unexpected is
>   happening
> 
> * We retry 10 times with 5 second delay between tries
> 
> * And finally if we are out of retries and if the test processes are
>   stil alive we congratulate user ...

:-), looks good to me.

Regards,
Jan
