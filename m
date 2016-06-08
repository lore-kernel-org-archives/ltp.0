From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Jun 2016 04:23:02 -0400 (EDT)
Subject: [LTP] [PATCH 3/3] lib/tst_test.c: Kill all children on timeout
In-Reply-To: <20160607124506.GA4236@rei.lan>
References: <20160607124506.GA4236@rei.lan>
Message-ID: <669820651.4512952.1465374182489.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 7 June, 2016 2:45:07 PM
> Subject: [LTP] [PATCH 3/3] lib/tst_test.c: Kill all children on timeout
> 
> * Run actuall test in a separate process group
> 
> * Deliver SIGKILL to all children on timeout
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

ACK.

Is there a 2/3? I can't seem to find the series this patch belongs to.
I assume 1/3 was "lib/tst_test.c: Run test in child process".

Regards,
Jan
